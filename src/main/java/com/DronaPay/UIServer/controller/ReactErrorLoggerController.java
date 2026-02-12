package com.DronaPay.UIServer.controller;

import com.DronaPay.UIServer.requests.ErrorLogRequest;
import com.DronaPay.UIServer.service.ReactErrorLoggerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


@RequestMapping("/")
@RestController
public class ReactErrorLoggerController {


    @Autowired
    private ReactErrorLoggerService reactErrorLoggerService;

    @PostMapping("/log-error")
    public ResponseEntity<?> logErrors(@RequestBody ErrorLogRequest errorLogRequest, Authentication user) {
        return reactErrorLoggerService.logErrors(errorLogRequest, user);
    }

    @GetMapping(value = {"/dronaui/"})
    public ModelAndView redirectWithUsingRedirectPrefix(ModelMap model) {
        return new ModelAndView("/dronaui/auth/login", model);
    }


}
