package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.LiveTrans;

import java.util.List;

public interface LiveTransService {
    List<LiveTrans> findAll();

}
