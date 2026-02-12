package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ActiveLoginToken;
import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.ActiveLoginTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ActiveLoginTokenServiceImpl implements ActiveLoginTokenService {
    @Value("${jwt.auth.refresh_token_expires_in}")
    private Integer refreshExpirationDateInMs;
    @Autowired
    private ActiveLoginTokenRepository activeLoginTokenRepository;

    @Autowired
    private WebUserService webUserService;

    @Override
//    @Cacheable(value = "usertoken", key = "#tokens")
    public ActiveLoginToken findByActiveTokens(String tokens) {
        List<ActiveLoginToken> temp = activeLoginTokenRepository.findByActiveLoginToken(tokens);

        ActiveLoginToken active_login_token;
        if (temp.size() == 0) {
            return null;
        } else {
            active_login_token = temp.get(0);
        }

        if (active_login_token.getIsGeneratedThroughRefreshToken()) {
            deleteToken(active_login_token.getIUserId(), active_login_token.getIorgId(), false);
            active_login_token.setIsGeneratedThroughRefreshToken(false);
            activeLoginTokenRepository.save(active_login_token);
        }
        return active_login_token;
    }


    public Optional<ActiveLoginToken> findByClientUser(String tokens) throws Exception {
        return activeLoginTokenRepository.findByiClientUser_ClientID(tokens);
    }

    @Override
    public Optional<ActiveLoginToken> findByRefreshTokens(String tokens) {
        return activeLoginTokenRepository.findByRefreshToken(tokens)
                .stream()
                .findFirst();
    }

    public ActiveLoginToken verifyExpiry(ActiveLoginToken tokens) {
        if (tokens.getDtExpiryDatetime().compareTo(Instant.now()) < 0) {
            activeLoginTokenRepository.delete(tokens);
            new RuntimeException("Refesh token expired");
        }
        return tokens;
    }


    //    @CacheEvict("usertoken")
    public void deleteToken(String tokens) throws Exception {
        List<ActiveLoginToken> temp = activeLoginTokenRepository.findByActiveLoginToken(tokens);
        List<Integer> tokenids = temp.stream().map(a -> a.getActiveLoginTokenId()).toList();
        activeLoginTokenRepository.deleteAllByIdInBatch(tokenids);
    }


    //    @CacheEvict(value = "usertoken", key = "#iuserid")
    public void deleteToken(Integer iuserid, Integer iorgid, Boolean isgenerated) {
        List<ActiveLoginToken> logintokens = activeLoginTokenRepository.findAllByiUserIdAndIorgIdAndIsGeneratedThroughRefreshToken(
                iuserid,
                iorgid,
                isgenerated);
        List<Integer> tokenids = logintokens.stream().map(a -> a.getActiveLoginTokenId()).toList();
        activeLoginTokenRepository.deleteAllByIdInBatch(tokenids);
    }


    //    @CacheEvict(value = "usertoken", key = "#user.iuserID")
    public void deleteTokenByUserID(WebUser user) throws Exception {
        activeLoginTokenRepository.deleteAllByiUserIdAndIorgId(user.getIuserID(), user.getIorgId().getIorgid());
    }


    @Override
//    @CachePut(value = "usertoken", key = "#user.iuserID")
    public ActiveLoginToken saveToken(String token, WebUser user, String refresh, Boolean isRefreshGenerated) throws Exception {

        List<ActiveLoginToken> temp = activeLoginTokenRepository.findByiUserIdAndIorgIdAndIsGeneratedThroughRefreshToken(
                user.getIuserID(),
                user.getIorgId().getIorgid(),
                isRefreshGenerated);

        ActiveLoginToken activeLoginToken;
        if (temp.size() == 0) {
            activeLoginToken = new ActiveLoginToken();
        } else {
            activeLoginToken = temp.get(0);
        }

        activeLoginToken.setActiveLoginToken(token);
        activeLoginToken.setDtEntryDatetime(ZonedDateTime.now());
        activeLoginToken.setIUserId(user.getIuserID());
        activeLoginToken.setIorgId(user.getIorgId().getIorgid());
        activeLoginToken.setRefreshToken(refresh);
        activeLoginToken.setIsGeneratedThroughRefreshToken(isRefreshGenerated);
        activeLoginToken.setDtExpiryDatetime(Instant.now().plusMillis(refreshExpirationDateInMs * 1000));
        return activeLoginTokenRepository.save(activeLoginToken);
    }


    public ActiveLoginToken saveToken(String token, ClientUser user) throws Exception {
        Optional<ActiveLoginToken> activetoken = findByClientUser(user.getClientID());
        ActiveLoginToken activeLoginToken = activetoken.orElse(new ActiveLoginToken());
        activeLoginToken.setActiveLoginToken(token);
        activeLoginToken.setDtEntryDatetime(ZonedDateTime.now());
        activeLoginToken.setIClientUser(user);
        return activeLoginTokenRepository.save(activeLoginToken);
    }

//    @CachePut(value = "usertoken", key = "#activeLoginToken.activeLoginTokenId")
//    public ActiveLoginToken update(ActiveLoginToken activeLoginToken) throws Exception {
//        activeLoginToken.setDtExpiryDatetime(Instant.now().plusMillis(refreshExpirationDateInMs * 1000));
//        return activeLoginTokenRepository.save(activeLoginToken);
//    }


    @Override
//    @CacheEvict("usertoken")
    public void deletePastWeeksToken(int cleanUpDay) {
        //activeLoginTokenRepository.deleteLastWeeksTokens(cleanUpDay);
        ZonedDateTime targetDate = ZonedDateTime.now().minusDays(cleanUpDay);
        activeLoginTokenRepository.deleteAllByDtEntryDatetimeLessThan(targetDate);
    }


    @Override
    public WebUser findUserbyToken(ActiveLoginToken token) {
        return webUserService.findByUserOrgId(token.getIUserId(), token.getIorgId());
    }

}
