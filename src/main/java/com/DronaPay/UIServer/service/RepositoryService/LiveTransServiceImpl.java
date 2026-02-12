package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.LiveTransRepository;
import com.DronaPay.UIServer.model.LiveTrans;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LiveTransServiceImpl implements LiveTransService{

    @Autowired
    private LiveTransRepository liveTransRepository;

    public List<LiveTrans> findAll()
    {
        return liveTransRepository.findAll();
    }

}
