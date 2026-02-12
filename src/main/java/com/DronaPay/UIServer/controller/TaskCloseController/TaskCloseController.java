package com.DronaPay.UIServer.controller.TaskCloseController;


import com.DronaPay.UIServer.service.ControllerService.TicketClose.TicketCloseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/v1/close-tickets")
public class TaskCloseController {

    @Autowired
    private TicketCloseService ticketCloseService;

    @PostMapping("/close")
    private ResponseEntity<?> closeAllTickets(@RequestBody String parameters, Authentication pr) {
        return ticketCloseService.closeAllTicket(parameters, pr);

    }

    @PostMapping("/claim")
    private ResponseEntity<?> claimAllTickets(@RequestBody String parameters, Authentication pr) {
        return ticketCloseService.claimAllTicket(parameters, pr);

    }

}
