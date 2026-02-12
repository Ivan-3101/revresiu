package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import com.DronaPay.UIServer.model.TaskLHSMap;

public interface TaskLHSMapService {
    public List<TaskLHSMap> findByOption(String label) throws Exception;
}
