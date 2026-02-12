package com.DronaPay.UIServer.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.WebUserAudit;

@Repository
public interface WebUserAuditRepository extends JpaRepository<WebUserAudit, Integer> {

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.vcUserName = :username AND
	// wua.istatus = null AND wua.bclosed = false ORDER BY wua.dtEntryStamp DESC")
	// public Optional<WebUserAudit> findLastEntryByUserName(@Param("username")
	// String username);

	public Optional<WebUserAudit> findByVcUserNameAndIstatusIsNullAndBclosedFalseAndIorgId_VcOrgIdOrderByDtEntryStampDesc(
			String username, String orgid);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.istatus = null AND
	// wua.bclosed = false")
	// public List<WebUserAudit> getAllPendingEntry();
	public List<WebUserAudit> findByIstatusIsNullAndBclosedFalse();

	public List<WebUserAudit> findAllByIstatusIsNullAndBclosedFalseAndIorgId_Iorgid(Integer iorgid);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.iEntryUserID.iUserID =
	// :iUserID AND wua.istatus = null AND wua.bclosed = false")
	// public List<WebUserAudit>
	// getAllPendingEntryCreatedByIUserID(@Param("iUserID") int iUserID);
	public List<WebUserAudit> findByiEntryUserIDAndIstatusIsNullAndBclosedFalse(Integer iUserID);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.vcUserName = :username AND
	// wua.istatus = null AND wua.bclosed = false"
	// + " AND wua.vcAction = 'A' ORDER BY wua.dtEntryStamp DESC")
	// public Optional<WebUserAudit>
	// findPendingAddEntryByUserName(@Param("username") String username);
	public Optional<WebUserAudit> findByVcUserNameAndIstatusIsNullAndBclosedFalseAndVcActionAndIorgId_VcOrgIdOrderByDtEntryStamp(
			String username, String ActionA, String vcorgid);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.iUserID.iUserID = :iUserID
	// AND wua.istatus = null AND wua.bclosed = false"
	// + " AND wua.vcAction = 'M' ORDER BY wua.dtEntryStamp DESC")
	// public Optional<WebUserAudit> findPendingAddEntryByIUserID(@Param("iUserID")
	// int iUserID);
	public Optional<WebUserAudit> findByiUserIDAndIstatusIsNullAndBclosedFalseAndVcActionIn(Integer iUserID, String[] actions);

	public WebUserAudit findByiUserAuditIDAndIorgId_VcOrgId(int id, String vcorgid);

	// @Query("SELECT max(tempiUserID) FROM WebUserAudit")
	// public Integer findIUserIdOfLastInsert();

	public WebUserAudit findTopByOrderByTempiUserIDDesc();

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.iUserID.iUserID = :iUserID
	// AND wua.istatus = null AND wua.bclosed = false"
	// + " ORDER BY wua.dtEntryStamp DESC")
	// public WebUserAudit editEntryExist(@Param("iUserID") int iUserID);
	public WebUserAudit findByiUserIDAndIstatusIsNullAndBclosedFalseOrderByDtEntryStampDesc(Integer iUserID);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.vcEmailID = :email AND
	// wua.istatus = null AND wua.bclosed = false"
	// + " ORDER BY wua.dtEntryStamp DESC")
	// public WebUserAudit findByEmail(@Param("email") String email);
	public WebUserAudit findByVcEmailIDAndIstatusIsNullAndBclosedFalseAndIorgId_VcOrgIdOrderByDtEntryStampDesc(String email, String orgid);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.vcUserName = :name AND
	// wua.istatus = null AND wua.bclosed = false"
	// + " ORDER BY wua.dtEntryStamp DESC")
	// public WebUserAudit findByUserName(@Param("name") String name);
	// public WebUserAudit
	// findByVcUserNameAndIstatusIsNullAndBclosedFalseOrderByDtEntryStampDesc(String
	// name);

	// @Query("SELECT wua FROM WebUserAudit wua WHERE wua.iUserAuditID = :id AND
	// wua.istatus = null AND wua.bclosed = false"
	// + " ORDER BY wua.dtEntryStamp DESC")
	// public WebUserAudit findByUserId(@Param("id") Integer id);
	public WebUserAudit findByiUserAuditIDAndIstatusIsNullAndBclosedFalseOrderByDtEntryStampDesc(Integer id);
}
