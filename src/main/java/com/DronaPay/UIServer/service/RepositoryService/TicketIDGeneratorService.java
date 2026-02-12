package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.model.TicketIDGenerator;

public interface TicketIDGeneratorService {
    public TicketIDGenerator save(TicketIDGenerator ticketIDGenerator) throws Exception;
}
