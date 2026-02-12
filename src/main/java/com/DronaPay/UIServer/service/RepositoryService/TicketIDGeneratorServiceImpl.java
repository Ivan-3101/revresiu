package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.TicketIDGeneratorRepository;
import com.DronaPay.UIServer.model.TicketIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketIDGeneratorServiceImpl implements TicketIDGeneratorService {

    @Autowired
    private TicketIDGeneratorRepository ticketIDGeneratorRepository;

    public TicketIDGenerator save(TicketIDGenerator ticketIDGenerator) throws Exception
    {
//        int year = Year.now().getValue();
//        ticketIDGenerator.setIID(ticketIDGeneratorRepository.findLastTicketIDByIYear(year) +1);
//        ticketIDGenerator.setIYear(year);
//        ticketIDGenerator.setTicketIDWithYear(Integer.parseInt(ticketIDGenerator.getIYear() + String.format("%06d", ticketIDGenerator.getIID())));
//        try{
            return ticketIDGeneratorRepository.save(ticketIDGenerator);
//        }
//        catch (DataIntegrityViolationException e)
//        {
//             return save(ticketIDGenerator);
//        }
    }
}

