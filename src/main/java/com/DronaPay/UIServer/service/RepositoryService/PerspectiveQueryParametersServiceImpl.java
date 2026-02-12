package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.PerspectiveQueryParametersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PerspectiveQueryParametersServiceImpl implements PerspectiveQueryParametersService {

    @Autowired
    private PerspectiveQueryParametersRepository perspectiveQueryParametersRepository;


}
