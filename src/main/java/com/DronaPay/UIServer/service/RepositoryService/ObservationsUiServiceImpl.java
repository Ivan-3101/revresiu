package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.ObservationsUi;
import com.DronaPay.UIServer.repository.ObservationsUiRepository;

@Service
public class ObservationsUiServiceImpl implements ObservationsUiService {

    @Autowired
    private ObservationsUiRepository observationsUiRepository;

    @Override
    public List<ObservationsUi> findAllNonDeleted() throws Exception {
       //return observationsUiRepository.findAllNonDeleted();
       List<ObservationsUi> listAll = observationsUiRepository.findAll();
       List<ObservationsUi> listNondeleted = listAll.stream().filter(x -> 
        {
            if(x.getIstatus() == null) {
                return x.getIrecordStatus() == 0;
            }
            return (x.getIstatus().getIStatusID() == 1 && x.getIrecordStatus() == 0);
        }).collect(Collectors.toList());
        return listNondeleted;

    }

    @Override
    public List<ObservationsUi> findAllNonDeletedTenants(List<Integer> tenanat) {
       System.out.println("t11 " + System.currentTimeMillis());
       List<ObservationsUi> listAll = observationsUiRepository.findAllByItenantIdIn(tenanat);
       System.out.println("t12 " + System.currentTimeMillis());
       List<ObservationsUi> listNondeleted = listAll.stream().filter(x -> 
        {
            if(x.getIstatus() == null) {
                return x.getIrecordStatus() == 0;
            }
            return (x.getIstatus().getIStatusID() == 1 && x.getIrecordStatus() == 0);
        }).collect(Collectors.toList());
        System.out.println("t13 " + System.currentTimeMillis());
        return listNondeleted;
    }

    @Override
    public ObservationsUi saveObservations(ObservationsUi observationsUi) throws Exception {
        return observationsUiRepository.save(observationsUi);
    }

    @Override
    public ObservationsUi findByObservationId(Integer oId, Integer wid, Integer tenantid) throws Exception {
       return observationsUiRepository.findByOidAndWidAndItenantId(oId, wid, tenantid).orElse(null);
    }

    @Override
    public List<ObservationsUi> findByWid(Integer wId, Integer tenantid) throws Exception {
        // TODO Auto-generated method stub
        //return observationsUiRepository.findAllBywId(wId);
        return observationsUiRepository.findAllByWidAndItenantIdAndIrecordStatus(wId, tenantid, 0);
    }

    @Override
    public Integer findMaxId() throws Exception {
        // TODO Auto-generated method stub
        //return observationsUiRepository.findMaxId();
        ObservationsUi obs = observationsUiRepository.findTopByOrderByOidDesc();
        if(obs == null) {
            return 0;
        } else {
            return obs.getOid();
        }
    }

    @Override
    public ObservationsUi findByObservationName(String name) throws Exception {
        //return observationsUiRepository.findByOName(name);
        return observationsUiRepository.findByOnameAndIrecordStatus(name, 0);
    }

    @Override
    public Optional<ObservationsUi> findByOnameAndItenantId(String oname, Integer itenantid) throws Exception {
        return observationsUiRepository.findByOnameAndItenantIdAndIrecordStatus(oname, itenantid, 0);
    }


}
