package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ListReplica;
import com.DronaPay.UIServer.repository.ListReplicaRepository;
import com.DronaPay.UIServer.service.ApiServices.ListApiService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j
public class ListReplicaServiceImpl extends ListReplicaService {


    public static final Logger LOGGER = LoggerFactory.getLogger(ListReplicaServiceImpl.class);
    @Autowired
    private ListReplicaRepository listReplicaRepository;


    @Autowired
    private ListApiService listApiService;

    @Override
    public ListReplica saveAudit(ListReplica input) {
        ResponseEntity<String> clientResponse;
        if (input.getIstatus().getIStatusID() == 1) {


            DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");


            JSONObject bodyJson = new JSONObject();
            bodyJson.put("externalId", input.getVcExternalListItemId());
            bodyJson.put("source", input.getVcSource());
            bodyJson.put("listType", input.getIlistType().getId().getIListMasterID());
            bodyJson.put("itemField", input.getVcField());
            bodyJson.put("itemValue", input.getVcValue());
            bodyJson.put("effectiveFrom", inputFormat.format(input.getDtEffectiveFrom()));
            bodyJson.put("expiresAt", inputFormat.format(input.getDtExpiresAt()));
            bodyJson.put("note", input.getVcNote());
            bodyJson.put("record_Status", 0);

            if (input.getAttribs() != null) {

                bodyJson.put("attribs", new JSONObject(input.getAttribs().toString()));
            }

            String body = bodyJson.toString();
            clientResponse = listApiService.addlist(body, input.getIlistType().getId().getItenantId().getItenantid());


            if (clientResponse != null) {
                // System.out.println(body);
                // System.out.println(clientResponse.bodyToMono(String.class).block());

                if (clientResponse.getStatusCode() == HttpStatus.OK) {
                    return listReplicaRepository.save(input);
                } else {
                    log.error("Response status code " + clientResponse.getStatusCode() + " response: " + clientResponse.getBody());
                    return null;
                }
            } else {
                return null;
            }
        } else if (input.getIstatus().getIStatusID() == 4) {

            clientResponse = listApiService.deleteList(input);
            if (clientResponse != null) {
                if (clientResponse.getStatusCode() == HttpStatus.OK) {
                    return listReplicaRepository.save(input);
                } else {
                    log.error("Response status code " + clientResponse.getStatusCode() + " response: " + clientResponse.getBody());
                    return null;
                }
            } else {
                return null;
            }
        } else {

            return null;
        }

    }

    @Override
    public List<ListReplica> findAllActiveListsTenants(List<Integer> tenants) throws Exception {
        return listReplicaRepository.findAllByIlistType_Id_ItenantId_ItenantidIn(tenants)
                .stream()
                .filter(lt -> (lt.getIrecordStatus() == null || lt.getIrecordStatus() == 0))
                .collect(Collectors.toList());
    }

    @Override
    public List<ListReplica> findAllActiveLists() throws Exception {
        //return listReplicaRepository.findAllActive();
        return listReplicaRepository.findByIrecordStatusIsNullOrIrecordStatus(0);
    }

    @Override
    public ListReplica findByExternalId(String externalId, Integer tenantid) throws Exception {
        return listReplicaRepository.findByVcExternalListItemIdAndIlistType_Id_ItenantId_Itenantid(externalId, tenantid);
    }

    @Override
    public Integer findOverlappingEntriesWithoutAttribs(String vcfield, String vcvalue, List<Integer> listTypes, ZonedDateTime dtEffectiveFrom,
                                                        ZonedDateTime expireAt, Integer itenantid, boolean ui) {

        if (ui)

            return listReplicaRepository.findOverlappingEntriesWithoutAttribs(vcfield,
                    vcvalue,
                    listTypes,
                    dtEffectiveFrom,
                    expireAt,
                    itenantid);
        else
            return listReplicaRepository.findOverlappingEntriesWithoutAttribsForMaster(vcfield,
                    vcvalue,
                    listTypes,
                    dtEffectiveFrom,
                    expireAt,
                    itenantid);

    }

    @Override
    public List<JsonNode> findOverLappingEntriesForWhitelistWithAttribs(String vcfield, String vcvalue, ZonedDateTime dtEffectiveFrom, ZonedDateTime expireAt,
                                                                        Integer itenantid, boolean ui) {

        if (ui) {
            return listReplicaRepository.findOverLappingEntriesForWhitelistWithAttribs(vcfield,
                    vcvalue,
                    dtEffectiveFrom,
                    expireAt,
                    itenantid
            );
        } else {
            ObjectMapper mapper = new ObjectMapper();

            return listReplicaRepository.findOverLappingEntriesForWhitelistWithAttribsforMaster(vcfield,
                    vcvalue,
                    dtEffectiveFrom,
                    expireAt,
                    itenantid
            ).stream().map(a -> {
                try {
                    return mapper.readTree(a);
                } catch (JsonProcessingException e) {
                    LOGGER.error("failed to parse json");
                    return null;
                }
            }).collect(Collectors.toList());
        }
    }

    @Override
    public Integer findEntriesWithEffectiveFromAfterExpiryAt(String vcfield, String vcvalue, Integer listype, ZonedDateTime dtEffectiveFrom,
                                                             Integer itenantid, boolean ui) {

        if (ui)
            return listReplicaRepository.findEntriesWithEffectiveFromAfterExpiryAt(vcfield,
                    vcvalue,
                    listype,
                    dtEffectiveFrom,
                    itenantid);
        else
            return listReplicaRepository.findEntriesWithEffectiveFromAfterExpiryAtformaster(vcfield,
                    vcvalue,
                    listype,
                    dtEffectiveFrom,
                    itenantid);
    }
}
