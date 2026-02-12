package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MultiTenant;
import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.ResponseVO.AppUser;
import com.DronaPay.UIServer.repository.WebUserAuditRepository;
import com.DronaPay.UIServer.repository.WebuserMappingAuditRepository;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.response.MenuPermissions;

import jakarta.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class WebUserAuditServiceImpl implements WebUserAuditService {

	private static final Logger LOGGER = LoggerFactory.getLogger(WebUserAuditServiceImpl.class);

	@Autowired
	private WebUserAuditRepository webUserAuditRepository;

	@Value("${account.lock.attempts}")
	private Integer lockAttempts;

	@Autowired
	private WebUserService webUserService;

	@Autowired
	private WebuserMappingService webuserMappingService;

	@Autowired
	private WebuserMappingAuditRepository webuserMappingAuditRepository;

	

	public WebUserAudit findPendingAddEntryByUserName(String username, String vcorgid) throws Exception {
		// return
		// webUserAuditRepository.findPendingAddEntryByUserName(username).orElse(null);
		return webUserAuditRepository
				.findByVcUserNameAndIstatusIsNullAndBclosedFalseAndVcActionAndIorgId_VcOrgIdOrderByDtEntryStamp(username, "A", vcorgid)
				.orElse(null);
	}

	public WebUserAudit findPendingAddEntryByIUserID(int iUserID) throws Exception {
		// return
		// webUserAuditRepository.findPendingAddEntryByIUserID(iUserID).orElse(null);
		String[] actions = {"M", "X"};
		return webUserAuditRepository
				.findByiUserIDAndIstatusIsNullAndBclosedFalseAndVcActionIn(iUserID, actions)
				.orElse(null);
	}

	@Transactional
	public void save(WebUserAudit wua, List<WebuserMappingAudit> mapList) throws Exception {
		WebUserAudit webUserAudit = webUserAuditRepository.save(wua);
		webuserMappingAuditRepository.deleteAllByWebUserAuditIDAndIorgId(webUserAudit.getIUserAuditID(),
				webUserAudit.getIorgId().getIorgid());
		mapList = mapList.stream().map(wbpm -> {
			wbpm.setIorgId(wua.getIorgId().getIorgid());
			wbpm.setWebUserAuditID(wua.getIUserAuditID());
			return wbpm;
		}).toList();
		webuserMappingAuditRepository.saveAll(mapList);
	}

	@Transactional
	public void save(WebUserAudit wua) throws Exception {
		List<WebuserMapping> origMapping = webuserMappingService.findByIDsWebuserIDandOrgID(wua.getIUserID(),
				wua.getIorgId().getIorgid());
		List<WebuserMappingAudit> auditMapping = origMapping
				.stream()
				.map(a -> {
					WebuserMappingAudit res = new WebuserMappingAudit();
					res.setMappingID(a.getMappingID());
					res.setMappingType(a.getMappingType());
					res.setItenantId(a.getItenantId());
					return res;
				})
				.collect(Collectors.toList());	
		save(wua, auditMapping);
	}

	public List<WebUserAudit> getAllPendingEntry() throws Exception {
		// return webUserAuditRepository.getAllPendingEntry();
		return webUserAuditRepository.findByIstatusIsNullAndBclosedFalse();
	}

	public List<WebUserAudit> getAllPendingEntryCreatedByIUserID(int iUserID) throws Exception {
		// return webUserAuditRepository.getAllPendingEntryCreatedByIUserID(iUserID);
		return webUserAuditRepository.findByiEntryUserIDAndIstatusIsNullAndBclosedFalse(iUserID);
	}

	public void update(WebUserAudit wua) throws Exception {
		if (wua.isBclosed() && wua.getIstatus().isBUpdateMaster()) {
			WebUser wu = WebUser.parse(wua);
			WebUser origUser = webUserService.findByUserOrgId(wua.getIUserID(), wua.getIorgId().getIorgid());
			wu.setVcPassword(origUser.getVcPassword());
			webUserService.save(wu);
//			webUserService.save(WebUser.parse(wua));
		}

		webUserAuditRepository.save(wua);
	}

	public WebUserAudit findByWebUserAuditId(int id, String vcorgid) throws Exception {
		return webUserAuditRepository.findByiUserAuditIDAndIorgId_VcOrgId(id, vcorgid);
	}

	public Integer getLastWebUserIdfromAudit() throws Exception {
		// return webUserAuditRepository.findIUserIdOfLastInsert();
		return webUserAuditRepository.findTopByOrderByTempiUserIDDesc().getTempiUserID();
	}

	public Integer getIUserIdForAudit() throws Exception {
		// Integer auditIUserId = webUserAuditRepository.findIUserIdOfLastInsert();
		Integer auditIUserId = webUserAuditRepository.findTopByOrderByTempiUserIDDesc().getTempiUserID();
		auditIUserId = (auditIUserId == null) ? 0 : auditIUserId;
		Integer iUserId = webUserService.findLastIUserId();
		iUserId = (iUserId == null) ? 0 : iUserId;
		if (auditIUserId >= iUserId) {
			return auditIUserId + 1;
		} else {
			return iUserId + 1;
		}
	}

	public Boolean getWebUserAuditExist(int WebUserID) throws Exception {
		// WebUserAudit exist = webUserAuditRepository.editEntryExist(WebUserID);
		WebUserAudit exist = webUserAuditRepository
				.findByiUserIDAndIstatusIsNullAndBclosedFalseOrderByDtEntryStampDesc(WebUserID);
		if (exist == null) {
			return false;
		} else {
			return true;
		}
	}

	public List<AppUser> getListOfWebUsers(List<WebUser> wus, MenuPermissions mp, WebUser user) throws Exception {
		List<AppUser> res = new ArrayList<>();
		List<WebuserMapping> godUsersList = webuserMappingService.findByIorgIdAndMappingIDAndMappingType(user.getIorgId().getIorgid(),0,"Role");
		for (WebUser wu : wus) {

			boolean exist = getWebUserAuditExist(wu.getIuserID());
			AppUser au = AppUser.builder()
					.id(wu.getIuserID())
					.audit(false)
					.fullName(wu.getVcFirstName() + " " + wu.getVcLastName())
					.designation(wu.getVcDesignation())
					.email(wu.getVcEmailID())
					.mobile(wu.getVcMobile())
					.username(wu.getUsername())
					.edit(mp.isEdit())
					.delete(mp.isDelete())
					.approve(false)
					.publish(mp.isPublish())
					.entryExist(exist)
					.vcorgid(wu.getIorgId().getVcOrgId())
					.build();
			if (mp.isEdit() && wu.getLoginAttempts() >= lockAttempts) {
				au.setLock(true);
			}
			boolean isGodUser = godUsersList.stream()
					.anyMatch(mapping -> mapping.getWebuserID().equals(wu.getIuserID()));
			if (isGodUser) {
				au.setEdit(false);
				au.setDelete(false);
				au.setLock(false);
			}
			res.add(au);
		}
		return res;
	}

	@Override
	public WebUserAudit findByEmail(String email, String vcorgid) throws Exception {

		// return webUserAuditRepository.findByEmail(email);
		return webUserAuditRepository.findByVcEmailIDAndIstatusIsNullAndBclosedFalseAndIorgId_VcOrgIdOrderByDtEntryStampDesc(email, vcorgid);
	}

	@Override
	public WebUserAudit findByUserName(String name, String orgid) throws Exception {
		// TODO Auto-generated method stub
		// return webUserAuditRepository.findByUserName(name);
		return webUserAuditRepository.findByVcUserNameAndIstatusIsNullAndBclosedFalseAndIorgId_VcOrgIdOrderByDtEntryStampDesc(name, orgid)
				.orElse(null);
	}

	@Override
	public WebUserAudit findByUserId(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return webUserAuditRepository.findByiUserAuditIDAndIstatusIsNullAndBclosedFalseOrderByDtEntryStampDesc(id);
	}

	@Override
	public List<WebUserAudit> getAllPendingEntry(String org, LoggedUser loggedUser) throws Exception {
		// if admin org, fetch all users
		// else extract tenants mapped to this username and fetch list of all users
		// mapped to these tenants
		if (org.equals(MultiTenant.adminOrg)) {
			return getAllPendingEntry();
		} else {
			List<Integer> tenantids = loggedUser.getUserTenant();
			WebUser user = loggedUser.getWebUser();
			Integer iorgid = user.getIorgId().getIorgid();
			List<WebUserAudit> userEntries = webUserAuditRepository
					.findAllByIstatusIsNullAndBclosedFalseAndIorgId_Iorgid(iorgid);
			Map<Integer, WebUserAudit> userEntriesMap = new HashMap<>();
			List<Integer> userEntriesInt = userEntries.stream().map(us -> {
				userEntriesMap.put(us.getIUserAuditID(), us);
				return us.getIUserAuditID();
			}).toList();

			Map<Integer, List<WebuserMappingAudit>> matchingUsers = webuserMappingAuditRepository
					.findAllByMappingTypeAndWebUserAuditIDInAndIorgId(String.valueOf(WebuserMappingType.Tenant),
							userEntriesInt, iorgid)
					.stream()
					.collect(Collectors.groupingBy(WebuserMappingAudit::getWebUserAuditID));

			List<Integer> acceptUsersInt = webuserMappingAuditRepository
					.findAllByMappingIDInAndMappingTypeAndWebUserAuditIDInAndIorgId(
							tenantids, String.valueOf(WebuserMappingType.Tenant), userEntriesInt, iorgid)
					.stream()
					.map(wbmp -> wbmp.getWebUserAuditID())
					.collect(Collectors.groupingByConcurrent(Function.identity(), Collectors.counting()))
					.entrySet()
					.stream()
					.filter(wbmp -> (matchingUsers.get(wbmp.getKey()).size() == wbmp.getValue()))
					.map(wbmp -> wbmp.getKey())
					.collect(Collectors.toList());
			return acceptUsersInt.stream().map(id -> userEntriesMap.get(id)).toList();

		}
	}
}
