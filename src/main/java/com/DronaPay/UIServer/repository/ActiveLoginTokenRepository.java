package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ActiveLoginToken;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface ActiveLoginTokenRepository extends JpaRepository<ActiveLoginToken, Integer> {

    public List<ActiveLoginToken> findByActiveLoginToken(String activeLoginTokens);

    public List<ActiveLoginToken> findByRefreshToken(String refreshToken);

    // @Query(value ="DELETE FROM ui.activelogintokens acl WHERE acl.dtentrydatetime < current_date - :cleanupday)",nativeQuery = true )
    // @Modifying
    // @Transactional
    // public void deleteLastWeeksTokens(@Param("cleanupday") int cleanUpDay);


    public Optional<ActiveLoginToken> findByiClientUser_ClientID(String clientID);


    @Transactional
    public void deleteAllByDtEntryDatetimeLessThan(ZonedDateTime date);
    
    
    public List<ActiveLoginToken> findAllByiUserIdAndIorgIdAndIsGeneratedThroughRefreshToken(Integer iuserid, Integer iorgid,
                                                                             Boolean isGeneratedToken);


    @Transactional
    public void deleteAllByiUserIdAndIorgId(Integer iuserid, Integer iorgid);

    public List<ActiveLoginToken> findByiUserIdAndIorgIdAndIsGeneratedThroughRefreshToken(Integer iuserid, Integer iorgid,
                                                                                          Boolean isGeneratedToken);

}
