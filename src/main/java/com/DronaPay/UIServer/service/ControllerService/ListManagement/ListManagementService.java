package com.DronaPay.UIServer.service.ControllerService.ListManagement;


import com.DronaPay.UIServer.requests.AddNewPaymentRequest;
import com.DronaPay.UIServer.requests.ApproveListRequest;
import com.DronaPay.UIServer.requests.DeleteListRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface ListManagementService {

    public ResponseEntity<?> getListManagement(Authentication pr);

    public ResponseEntity<?> getListMasterDropdown(Integer tenantid,Authentication pr);

    public ResponseEntity<?> getListWhiteDropdown(Authentication pr);

    public ResponseEntity<?> getParameterType(Integer tenantId, Authentication pr);

    public ResponseEntity<?> addList(AddNewPaymentRequest req, Authentication pr);

    public ResponseEntity<?> deleteListItem(DeleteListRequest deleteListRequest, Authentication pr);

    public ResponseEntity<?> approveList(ApproveListRequest approveListRequest, Authentication pr);

    public ResponseEntity<?> editList(AddNewPaymentRequest addNewPaymentRequest, Authentication pr);

    public ResponseEntity<?> addListWithoutAudit(String req, Authentication pr);


    public ResponseEntity<?> getlistByIListID(Integer ilistid,Integer tenantid, Authentication pr);

    public ResponseEntity<?> getDecisionAndRules(Authentication pr, Integer tenantid);

}
