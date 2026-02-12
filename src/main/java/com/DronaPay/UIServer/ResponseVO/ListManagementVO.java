package com.DronaPay.UIServer.ResponseVO;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;


@Builder
@Data
public class ListManagementVO {

    private String id;
    private Object type;
    private String field;
    private String value;
    private String source;
    private ZonedDateTime startdate;
    private ZonedDateTime expirydate;
    private Boolean edit;
    private Boolean delete;
    private Boolean approve;
    private Boolean auditExist;
    private Boolean auditEntry;
    private String makerChecker;
    private String remarks;
    private String actions;
    private Integer listId;
    private String note;
    private JsonNode attribs;

    private Integer itenantId;
    private String tenantName;

//    public static List<ListManagementVO> parse(List<ListVO> listVOList, MenuPermissions mp)
//    {
//
//        List<ListManagementVO> res = new ArrayList<>();
//        for(ListVO listVO: listVOList)
//        {
//            ListManagementVO temp = new ListManagementVO();
//            temp.setId(listVO.getExternalId());
//            temp.setType(listVO.getListType());
//            temp.setSource(listVO.getSource());
//            temp.setStartdate(listVO.getEffectiveFrom());
//            temp.setExpirydate(listVO.getExpiresAt());
//            temp.setField(listVO.getItemField());
//            temp.setValue(listVO.getItemValue());
//            temp.setEdit(mp.isEdit());
//            temp.setDelete(mp.isDelete());
//            res.add(temp);
//        }
//        return res;
//    }

}
