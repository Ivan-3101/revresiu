package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.model.WebUser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Base64;

@Service
public class CamundaBasicAuthUtil {


    @Value("${camunda.webusers.password}")
    private String camundaUserPass;

    // @Value("${camunda.yellowai.password}")
    // private String camundaYellowAIPass;


    // @Value("${camunda.yellowai.username}")
    // private String camundaYellowAIUserName;

    @Value("${camunda.frmuser.username}")
    private String camundaFrmuser;

    @Value("${camunda.frmuser.password}")
    private String camundaFrmuserPass;

    public String getBasicAuth(WebUser loggedin) {
        String res = loggedin.getIuserID() + ":" + camundaUserPass;
        String response = "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
        return response;
    }

    public String getBasicAuthOpen(String loggedin) {
        String res = loggedin + ":" + camundaUserPass;
        String response = "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
        return response;
    }

    public String getBasicAuth(String username, String password) {
        String res = username + ":" + password;
        String response = "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
        return response;
    }

    // public String getYellowAIUser() {
    //     String res = camundaYellowAIUserName + ":" + camundaYellowAIPass;
    //     String response = "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
    //     return response;
    // }

    public String getFrmuser() {
        String res = camundaFrmuser + ":" + camundaFrmuserPass;
        String response = "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
        return response;
    }


}
