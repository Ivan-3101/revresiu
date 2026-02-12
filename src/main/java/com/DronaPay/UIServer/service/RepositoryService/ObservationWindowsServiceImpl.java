package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.ObservationWindows;
import com.DronaPay.UIServer.repository.ObservationsWindowUiRepository;

@Service
public class ObservationWindowsServiceImpl implements ObservationWindowsService {

    @Autowired
    private ObservationsWindowUiRepository observationsWindowUiRepository;

    @Override
    public List<ObservationWindows> findAllNonDeleted() throws Exception {
        // return observationsWindowUiRepository.findAllNonDeleted();
        List<ObservationWindows> listAll = observationsWindowUiRepository.findAll();
        List<ObservationWindows> listNondeleted = listAll.stream().filter(x -> {
            if (x.getIstatus() == null) {
                return x.getIrecordStatus() == 0;
            }
            return (x.getIstatus().getIStatusID() == 1 && x.getIrecordStatus() == 0);
        }).collect(Collectors.toList());
        return listNondeleted;
    }

    @Override
    public List<ObservationWindows> findAllNonDeletedTenant(List<Integer> tenants) throws Exception {
        // return observationsWindowUiRepository.findAllNonDeleted();
        List<ObservationWindows> listAll = observationsWindowUiRepository.findAllByItenantIdIn(tenants);
        List<ObservationWindows> listNondeleted = listAll.stream().filter(x -> {
            if (x.getIstatus() == null) {
                return x.getIrecordStatus() == 0;
            }
            return (x.getIstatus().getIStatusID() == 1 && x.getIrecordStatus() == 0);
        }).collect(Collectors.toList());
        return listNondeleted;
    }

    @Override
    public ObservationWindows saveObservationWindows(ObservationWindows observationWindows) throws Exception {
        return observationsWindowUiRepository.save(observationWindows);
    }

    @Override
    public ObservationWindows findByWId(Integer wid, Integer tenantid) throws Exception {
        return observationsWindowUiRepository.findByWidAndItenantId(wid, tenantid).orElse(null);

    }

    @Override
    public Integer findMaxId() throws Exception {
        // return observationsWindowUiRepository.findMaxId();
        ObservationWindows wid = observationsWindowUiRepository.findTopByOrderByWidDesc();
        if (wid != null) {
            return wid.getWid();
        } else {
            return 0;
        }
    }

    @Override
    public ObservationWindows findByWidowName(String name, Integer tenantid) throws Exception {
        return observationsWindowUiRepository.findByWnameAndIrecordStatusAndItenantId(name, 0, tenantid);
    }

}
