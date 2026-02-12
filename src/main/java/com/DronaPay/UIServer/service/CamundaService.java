package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.requests.CamundaRequests.AddComment;
import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaProfile;
import com.DronaPay.UIServer.requests.CamundaRequests.NewCamundaUser;
import com.DronaPay.UIServer.requests.CreateAuthorization;
import com.DronaPay.UIServer.requests.GetTaskListRequest;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequest;
import org.json.JSONObject;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.util.List;

public interface CamundaService {

    public ResponseEntity<String> addNewUser(NewCamundaUser body, WebUser user) throws Exception;

    public ResponseEntity<String> updateUser(CamundaProfile body, WebUser user) throws Exception;

    public ResponseEntity<String> mapToGroup(WebUserAudit wua, WebUser user, String groupName) throws Exception;

    public ResponseEntity<String> mapToTenant(WebUserAudit wua, WebUser user, String tenantid) throws Exception;

    public ResponseEntity<String> deleteUser(WebUserAudit wua, WebUser user) throws Exception;

    public ResponseEntity<String> deleteUserGroup(WebUserAudit wua, WebUser user, String groupName) throws Exception;

    public ResponseEntity<String> deleteUserTenant(WebUserAudit wua, WebUser user, String tenantid) throws Exception;

    public ResponseEntity<String> getTaskList(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPost(GetTaskListRequest getTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPostHttp(GetTaskListRequest getTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPostHttp(String paramter, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListCompletedHttp(GetTaskListRequest getTaskListRequest, WebUser user, List<String> listOfWorkflowKey) throws Exception;

    public ResponseEntity<String> getTaskListCompletedHistoryHttp(GetTaskListRequest getTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPostCount(String parameter, WebUser user) throws Exception;

    public ResponseEntity<String> getProcessInstHistoryPostCount(String parameter, WebUser user, List<String> listOfWorkflowKey) throws Exception;


    public ResponseEntity<String> getTaskListHistoryPostCount(String parameter, WebUser user) throws Exception;


    public ResponseEntity<String> getTaskListPostCount(JSONObject body) throws Exception;


    public ResponseEntity<String> getTaskListPostLoadMore(LoadMoreTaskListRequest loadMoreTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPostLoadMoreHttp(LoadMoreTaskListRequest loadMoreTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> claimTask(String taskid, String processInstanceId, WebUser user) throws Exception;

    public ResponseEntity<String> claimTaskOpen(String taskid, String processInstanceId, String user) throws Exception;

    public ResponseEntity<String> unClaimTask(String taskid, String processInstanceId, WebUser user) throws Exception;

    public ResponseEntity<String> unClaimTaskOpen(String taskid, String processInstanceId, String user) throws Exception;

    public ResponseEntity<String> getComments(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> addComment(AddComment addComment, WebUser user) throws Exception;

    public ResponseEntity<String> addCommentOpen(AddComment addComment, String user) throws Exception;

    public ResponseEntity<String> addAttachment(MultipartFile file,
                                        String id,
                                        String attachmentName,
                                        String attachmentDescription,
                                        String attachmentType,
                                        String url,
                                        WebUser user) throws Exception;

    public ResponseEntity<String> getAttachment(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> getUserOperation(String taskid, WebUser user) throws Exception;

    public ResponseEntity<byte[]> downloadAttachment(String taskid, String attachmentid, WebUser user) throws Exception;

    public ResponseEntity<String> getFormVariable(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> getRenderedForm(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> submitForm(String taskid, String processInstanceId, String body, WebUser user) throws Exception;

    public ResponseEntity<String> submitFormOpne(String taskid, String processInstanceId, String body, String user) throws Exception;

    public ResponseEntity<String> addVariable(String taskid, JSONObject body, WebUser user) throws Exception;

    public ResponseEntity<String> submitFormJson(String taskid, JSONObject body, WebUser user) throws Exception;

    public ResponseEntity<String> getVariableData(String taskid, String variablename, WebUser user) throws Exception;

    public ResponseEntity<String> getActivityInstance(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskHistory(String taskid, WebUser user) throws Exception;

    public Resource downloadAttachmentFromInputStream(String taskid, String attachmentid, WebUser user) throws Exception;

    public ResponseEntity<String> getProcessDefinationList(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> sendMessage(String body) throws Exception;

    public ResponseEntity<String> createTicket(String body, String key, WebUser user) throws Exception;

    public ResponseEntity<String> createTicket(String body, String key, String tenantid) throws Exception;

    public ResponseEntity<String> getProcessDefinationDetails(String key, WebUser user) throws Exception;

    public ResponseEntity<String> getVariableInstance(String proessInstanceId, WebUser user) throws Exception;

    public ResponseEntity<String> getClaimUnclaim(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> getHistoryDetail(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> postHistoryDetail(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> postHistoryVarInstance(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> getFormVariableNew(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> getBPMN(String processDef, WebUser user) throws Exception;

    public ResponseEntity<String> getDefinition(String proessInstanceId, WebUser user) throws Exception;

    public ResponseEntity<String> getWorkFlowName(LoggedUser user) throws Exception;

    public ResponseEntity<String> getWorkFlowNameAllDeployed(WebUser user, String keys, Integer tenantid) throws Exception;

    public Integer getCount(String url, String body, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskGroups(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> getStatestics(String processDef, String startdate, String endDate, WebUser user) throws Exception;

    public ResponseEntity<String> getHistoryProcessInstance(String body, WebUser user) throws Exception;

    public ResponseEntity<String> getAllProcessInstance(String body, String max, WebUser user) throws Exception;

    public ResponseEntity<String> getAllProcessInstance(String body, Integer max, WebUser user) throws Exception;

    public ResponseEntity<String> getAllProcessInstanceCount(String body, WebUser user) throws Exception;

    public ResponseEntity<String> getHistoricVariableInstance(String parameters, WebUser user) throws Exception;

    public ResponseEntity<String> getTaskListPostCodec(GetTaskListRequest getTaskListRequest, WebUser user) throws Exception;

    public ResponseEntity<String> getDeployed(String taskid, WebUser user) throws Exception;

    public ResponseEntity<String> createAuthorization(CreateAuthorization body, WebUser user) throws Exception;

    public ResponseEntity<String> reassignTask(String taskid, String processInstanceId, WebUser assignedUser, WebUser reassignUser) throws Exception;

    public ResponseEntity<String> getProcessInstance(String body) throws Exception;

    public ResponseEntity<String> getVariableInstance(String body) throws Exception;

    public ResponseEntity<String> createTenant(String tenantid, String tenantname);

    public ResponseEntity<String> editTenant(String tenantid, String tenantname);

    public ResponseEntity<String> deleteTenant(String tenantid);
}
