package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ListReplica;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.ZonedDateTime;
import java.util.List;

public interface ListReplicaRepository extends JpaRepository<ListReplica, Integer> {

    public ListReplica findByVcExternalListItemIdAndIlistType_Id_ItenantId_Itenantid(String vcExternalListItemId, Integer tenantid);

    public List<ListReplica> findByIrecordStatusIsNullOrIrecordStatus(Integer zero);

    public List<ListReplica> findAllByIlistType_Id_ItenantId_ItenantidIn(List<Integer> tenants);

    @Query("SELECT count(*) FROM ListReplica l " +
            "WHERE l.vcField = :field " +
            "AND l.vcValue = :value " +
            "AND l.ilistType.id.iListMasterID NOT IN :listTypes " +
            "AND ( " +
            "     (:effectiveFrom BETWEEN l.dtEffectiveFrom AND l.dtExpiresAt) " +
            "     OR (:expiresAt BETWEEN l.dtEffectiveFrom AND l.dtExpiresAt) " +
            "     OR (l.dtEffectiveFrom BETWEEN :effectiveFrom AND :expiresAt) " +
            "     OR (l.dtExpiresAt BETWEEN :effectiveFrom AND :expiresAt) " +
            ") " +
            "AND l.ilistType.id.itenantId.itenantid = :itenantId " +
            "AND (l.attribs IS NULL " +
            "OR CAST(jsonb_extract_path_text(l.attribs, 'rule') AS BOOLEAN) = true)"
    )
    Integer findOverlappingEntriesWithoutAttribs(String field,
                                                 String value,
                                                 List<Integer> listTypes,
                                                 ZonedDateTime effectiveFrom,
                                                 ZonedDateTime expiresAt,
                                                 Integer itenantId
    );

    @Query(value = "SELECT count(*) FROM masters.lists " +
            "WHERE vcfield = :field " +
            "AND vcvalue = :value " +
            "AND ilisttype NOT IN :listTypes " +
            "AND ( " +
            "     (CAST(:effectiveFrom AS DATE) BETWEEN CAST(dteffectivefrom AS DATE) AND CAST(dtexpiresat AS DATE)) " +
            "     OR (CAST(:expiresAt AS DATE) BETWEEN CAST(dteffectivefrom AS DATE) AND CAST(dtexpiresat AS DATE)) " +
            "     OR (CAST(dteffectivefrom AS DATE) BETWEEN CAST(:effectiveFrom AS DATE) AND CAST(:expiresAt AS DATE)) " +
            "     OR (CAST(dtexpiresat AS DATE) BETWEEN CAST(:effectiveFrom AS DATE) AND CAST(:expiresAt AS DATE)) " +

            ") " +
            "AND itenantid = :itenantId " +
            "AND irecordstatus = 0 " +
            "AND (attribs = 'null' " +
            "OR CAST(jsonb_extract_path_text(attribs, 'rule') AS BOOLEAN) = true)", nativeQuery = true)
    Integer findOverlappingEntriesWithoutAttribsForMaster(String field,
                                                          String value,
                                                          List<Integer> listTypes,
                                                          ZonedDateTime effectiveFrom,
                                                          ZonedDateTime expiresAt,
                                                          Integer itenantId);

    @Query("SELECT l.attribs FROM ListReplica l " +
            "WHERE l.vcField = :field " +
            "AND l.vcValue = :value " +
            "AND l.ilistType.id.iListMasterID = 2 " +
            "AND ( " +
            "     (:effectiveFrom BETWEEN l.dtEffectiveFrom AND l.dtExpiresAt) " +
            "     OR (:expiresAt BETWEEN l.dtEffectiveFrom AND l.dtExpiresAt) " +
            "     OR (l.dtEffectiveFrom BETWEEN :effectiveFrom AND :expiresAt) " +
            "     OR (l.dtExpiresAt BETWEEN :effectiveFrom AND :expiresAt) " +

            ") " +
            "AND l.ilistType.id.itenantId.itenantid = :itenantId " +
            "AND l.attribs is NOT NULL"
    )
    List<JsonNode> findOverLappingEntriesForWhitelistWithAttribs(
            String field,
            String value,
            ZonedDateTime effectiveFrom,
            ZonedDateTime expiresAt,
            Integer itenantId
    );

    @Query(value = "SELECT cast(attribs as text) FROM masters.lists " +
            "WHERE vcfield = :field " +
            "AND vcvalue = :value " +
            "AND ilisttype = 2 " +
            "AND irecordstatus = 0 " +
            "AND ( " +
            "     (CAST(:effectiveFrom AS DATE) BETWEEN CAST(dteffectivefrom AS DATE) AND CAST(dtexpiresat AS DATE)) " +
            "     OR (CAST(:expiresAt AS DATE) BETWEEN CAST(dteffectivefrom AS DATE) AND CAST(dtexpiresat AS DATE)) " +
            "     OR (CAST(dteffectivefrom AS DATE) BETWEEN CAST(:effectiveFrom AS DATE) AND CAST(:expiresAt AS DATE)) " +
            "     OR (CAST(dtexpiresat AS DATE) BETWEEN CAST(:effectiveFrom AS DATE) AND CAST(:expiresAt AS DATE)) " +
            ") " +
            "AND itenantid = :itenantId " +
            "AND (attribs != 'null' AND attribs IS NOT NULL)", nativeQuery = true)
    List<String> findOverLappingEntriesForWhitelistWithAttribsforMaster(String field,
                                                                        String value,
                                                                        ZonedDateTime effectiveFrom,
                                                                        ZonedDateTime expiresAt,
                                                                        Integer itenantId);

    @Query("SELECT count(*) FROM ListReplica l " +
            "WHERE l.vcField = :field " +
            "AND l.vcValue = :value " +
            "AND l.ilistType.id.iListMasterID = :listType " +
            "AND l.ilistType.id.itenantId.itenantid = :itenantId " +
            "AND l.dtExpiresAt >= :effectiveFrom")
    Integer findEntriesWithEffectiveFromAfterExpiryAt(String field,
                                                      String value,
                                                      Integer listType,
                                                      ZonedDateTime effectiveFrom,
                                                      Integer itenantId);

    @Query(value = "SELECT count(*) FROM masters.lists " +
            "WHERE vcfield = :field " +
            "AND vcvalue = :value " +
            "AND ilisttype = :listType " +
            "AND itenantid = :itenantId " +
            "AND irecordstatus = 0 " +
            "AND CAST(dtexpiresat AS DATE) >= CAST(:effectiveFrom AS DATE)", nativeQuery = true)
    Integer findEntriesWithEffectiveFromAfterExpiryAtformaster(String field,
                                                               String value,
                                                               Integer listType,
                                                               ZonedDateTime effectiveFrom,
                                                               Integer itenantId);
}
