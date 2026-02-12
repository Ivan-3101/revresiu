package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import com.DronaPay.UIServer.model.Channels;

public interface ChannelService {
    
    public List<Channels> findAll() throws Exception;
}
