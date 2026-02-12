package com.DronaPay.UIServer.service.ControllerService.TicketClose;


import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface TicketCloseService {

    public ResponseEntity<?> closeAllTicket(String parameter, Authentication pr);

    public ResponseEntity<?> claimAllTicket(String parameter, Authentication pr);
}
