package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.TaskLHSMap;
import com.DronaPay.UIServer.repository.TaskLHSMapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskLHSMapServiceImpl implements TaskLHSMapService {

    @Autowired
    private TaskLHSMapRepository taskLHSMapRepository;

    @Override
    public List<TaskLHSMap> findByOption(String label) throws Exception {
        return taskLHSMapRepository.findByOptionId_Vclabel(label);
    }

}
