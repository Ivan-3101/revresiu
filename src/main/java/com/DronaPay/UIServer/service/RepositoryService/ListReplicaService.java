package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ListReplica;
import com.DronaPay.UIServer.service.Audit;
import com.fasterxml.jackson.databind.JsonNode;

import java.time.ZonedDateTime;
import java.util.List;

// @Service
public abstract class ListReplicaService implements Audit<ListReplica> {

    abstract List<ListReplica> findAllActiveLists() throws Exception;

    abstract ListReplica findByExternalId(String externalId, Integer tenantid) throws Exception;

    abstract List<ListReplica> findAllActiveListsTenants(List<Integer> tenants) throws Exception;

    abstract Integer findOverlappingEntriesWithoutAttribs(String vcfield, String vcvalue, List<Integer> listTypes, ZonedDateTime dtEffectiveFrom,
                                                          ZonedDateTime expireAt, Integer itenantid, boolean ui);

    abstract List<JsonNode> findOverLappingEntriesForWhitelistWithAttribs(String vcfield, String vcvalue, ZonedDateTime dtEffectiveFrom, ZonedDateTime expireAt,
                                                                          Integer itenantid, boolean ui);

    abstract Integer findEntriesWithEffectiveFromAfterExpiryAt(String vcfield, String vcvalue, Integer listype, ZonedDateTime dtEffectiveFrom,
                                                               Integer itenantid, boolean ui);

}
