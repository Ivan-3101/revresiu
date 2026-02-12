package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.ListManagementVO;
import com.DronaPay.UIServer.ResponseVO.ListVO;
import com.DronaPay.UIServer.model.ListAudit;
import com.DronaPay.UIServer.model.ListReplica;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;

@Component
public class ListManagementVOMapper {

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    public List<ListManagementVO> parse(List<ListVO> listVOList, MenuPermissions mp) {

        List<ListManagementVO> res = new ArrayList<>();
        for (ListVO listVO : listVOList) {
            if (listVO.getRecord_Status() == null) {
                ListManagementVO temp = ListManagementVO.builder().id(listVO.getExternalId()).
                        type(listVO.getListType())
                        .source(listVO.getSource()).startdate(listVO.getEffectiveFrom())
                        .expirydate(listVO.getExpiresAt())
                        .field(listVO.getItemField()).value(listVO.getItemValue()).edit(mp.isEdit())
                        .delete(mp.isDelete())
                        .build();
                res.add(temp);
            }
        }
        return res;
    }

    public List<ListManagementVO> parseListReplica(List<ListReplica> listReplicas, MenuPermissions mp) {
        List<ListManagementVO> res = new ArrayList<>();
        for (ListReplica listVO : listReplicas) {
            if (listVO.getIrecordStatus() == null || listVO.getIrecordStatus() == 0) {
//                String lisType = "";
//                if (listVO.getIListType() == 0) {
//                    lisType = "BLACK";
//                } else if (listVO.getIListType() == 1) {
//                    lisType = "GREY";
//                } else if (listVO.getIListType() == 2) {
//                    lisType = "WHITE";
//                }


                ListManagementVO temp = ListManagementVO.builder().id(listVO.getVcExternalListItemId())
                        .type(DropdownWithObject.builder().label(listVO.getIlistType().getVcName()).value(listVO.getIlistType().getId().getIListMasterID()).build())
                        .source(listVO.getVcSource()).startdate(listVO.getDtEffectiveFrom())
                        .expirydate(listVO.getDtExpiresAt())
                        .field(listVO.getVcField())
                        .value(listVO.getVcValue())
                        .edit(mp.isEdit())
                        .delete(mp.isDelete())
                        .approve(mp.isApprove())
                        .auditExist(false)
                        .auditEntry(false)
                        .makerChecker("M")
                        .listId(listVO.getIListitemId() != null ? listVO.getIListitemId() : null)
                        .note(listVO.getVcNote())
                        .attribs(listVO.getAttribs())
                        .itenantId(listVO.getIlistType().getId().getItenantId().getItenantid())
                        .tenantName(listVO.getIlistType().getId().getItenantId().getTenantName())
                        .build();
                res.add(temp);
            }

        }
        return res;
    }

    public List<ListManagementVO> parseAuditList(List<ListAudit> listAudits, MenuPermissions mp, WebUser loggedInUser) {
        List<ListManagementVO> res = new ArrayList<>();
        for (ListAudit listVO : listAudits) {
            if (listVO.getIRecordStatus() == null || listVO.getIRecordStatus() == 0) {
//                String lisType = "";
//                if (listVO.getIListType() == 0) {
//                    lisType = "BLACK";
//                } else if (listVO.getIListType() == 1) {
//                    lisType = "GREY";
//                } else if (listVO.getIListType() == 2) {
//                    lisType = "WHITE";
//                }
                ListManagementVO temp = ListManagementVO.builder().id(listVO.getVcExternalListItemId())
                        .type(DropdownWithObject.builder().label(
                                        listVO.getIlistType() != null ?
                                                listVO.getIlistType().getVcName() : null)
                                .value(listVO.getIlistType() != null ? listVO.getIlistType().getId().getIListMasterID() : null).build())
                        .source(listVO.getVcSource()).startdate(listVO.getDtEffectiveFrom())
                        .expirydate(listVO.getDtExpiresAt())
                        .field(listVO.getVcField()).value(listVO.getVcValue()).edit(mp.isEdit()).delete(mp.isDelete()).approve(mp.isApprove())
                        .auditExist(false)
                        .auditEntry(true)
                        .makerChecker(listVO.getIEntryUserID().equals(loggedInUser.getIuserID()) ? "M" : "C")
                        .remarks(listVO.getVcRemark())
                        .actions(listVO.getVcAction())
                        .listId(listVO.getIListitemId() != null ? listVO.getIListitemId().getIListitemId() : null)
                        .note(listVO.getVcNote())
                        .attribs(listVO.getAttribs())
                        .itenantId(listVO.getIlistType().getId().getItenantId().getItenantid())
                        .tenantName(listVO.getIlistType().getId().getItenantId().getTenantName())
                        .build();
                res.add(temp);
            }
        }
        return res;
    }

    public ListManagementVO parseAudit(ListAudit listVO, MenuPermissions mp, WebUser loggedInUser) {

        ListManagementVO temp = ListManagementVO.builder().id(listVO.getVcExternalListItemId())
                .type(DropdownWithObject.builder().label(
                                listVO.getIlistType() != null ?
                                        listVO.getIlistType().getVcName() : null)
                        .value(listVO.getIlistType() != null ? listVO.getIlistType().getId().getIListMasterID() : null).build())
                .source(listVO.getVcSource()).startdate(listVO.getDtEffectiveFrom())
                .expirydate(listVO.getDtExpiresAt())
                .field(listVO.getVcField()).value(listVO.getVcValue()).edit(mp.isEdit()).delete(mp.isDelete()).approve(mp.isApprove())
                .auditExist(false)
                .auditEntry(true)
                .makerChecker(listVO.getIEntryUserID().equals( loggedInUser.getIuserID()) ? "M" : "C")
                .remarks(listVO.getVcRemark())
                .actions(listVO.getVcAction())
                .listId(listVO.getIListitemId() != null ? listVO.getIListitemId().getIListitemId() : null)
                .note(listVO.getVcNote())
                .itenantId(listVO.getIlistType().getId().getItenantId().getItenantid())
                .tenantName(listVO.getIlistType().getId().getItenantId().getTenantName())
                .attribs(listVO.getAttribs())
                .build();
        return temp;
    }

}
