package com.DronaPay.UIServer.controller.CaseManagementController;

import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.Mockito.any;
import static org.mockito.Mockito.when;

@ContextConfiguration(classes = {TasksController.class})
@ExtendWith(SpringExtension.class)
class TasksControllerTest {
    @Autowired
    private TasksController tasksController;

    @MockBean
    private TasksService tasksService;

    @Test
    void testGetWorkFlowNames() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(requestBuilder);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }

    @Test
    void testGetWorkFlowNames2() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder getResult = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        getResult.contentType("https://example.org/example");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(getResult);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }

    @Test
    void testGetWorkFlowNames3() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(requestBuilder);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }

    @Test
    void testGetWorkFlowNames4() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder getResult = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        getResult.contentType("https://example.org/example");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(getResult);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }

    @Test
    void testGetWorkFlowNames5() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(requestBuilder);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }

    @Test
    void testGetWorkFlowNames6() throws Exception {
        when(this.tasksService.getWorkFlowName((org.springframework.security.core.Authentication) any()))
                .thenReturn(new ResponseEntity<>(HttpStatus.CONTINUE));
        MockHttpServletRequestBuilder getResult = MockMvcRequestBuilders
                .get("/api/v1/case-management/tasks/get-workflow-names");
        getResult.contentType("https://example.org/example");
        ResultActions actualPerformResult = MockMvcBuilders.standaloneSetup(this.tasksController)
                .build()
                .perform(getResult);
        actualPerformResult.andExpect(MockMvcResultMatchers.status().is(100));
    }
}

