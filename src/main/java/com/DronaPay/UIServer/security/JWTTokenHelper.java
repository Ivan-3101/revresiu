package com.DronaPay.UIServer.security;


import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.Organization;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.util.UrlJwkProvider;
import com.auth0.jwk.Jwk;
import com.auth0.jwk.JwkException;
import com.auth0.jwk.JwkProvider;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.JsonNode;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JWTTokenHelper {


    private static final Logger LOGGER = LoggerFactory.getLogger(JWTTokenHelper.class);

    @Value("${jwt.auth.app}")
    private String appName;

    @Value("${jwt.auth.secret_key}")
    private String secretKey;

    @Value("${jwt.auth.expires_in}")
    private Integer expiresIn;

    private Map<Integer, JwkProvider> providerMap = new HashMap<>();
    private SignatureAlgorithm SIGNATURE_ALGORITHM = SignatureAlgorithm.HS256;

    private JwkProvider getProvider(Integer orgid, String url) {
        if (providerMap.containsKey(orgid)) {
            return providerMap.get(orgid);
        } else {
            JwkProvider provider = new UrlJwkProvider(url);
            providerMap.put(orgid, provider);
            return provider;
        }
    }

    private Claims getAllClaimsFromToken(String token) {
        Claims claims;
        try {
            claims = Jwts.parser()
                    .setSigningKey(secretKey)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            claims = null;
        }
        return claims;
    }


    public String getUsernameFromToken(String token) {
        String username;
        try {
            final Claims claims = this.getAllClaimsFromToken(token);
            username = claims.getSubject();
        } catch (Exception e) {
            username = null;
        }
        return username;
    }

    public String generateToken(String username) throws InvalidKeySpecException, NoSuchAlgorithmException {

        return Jwts.builder()
                .setIssuer(appName)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(generateExpirationDate())
                .signWith(SIGNATURE_ALGORITHM, secretKey)
                .compact();
    }

    private Date generateExpirationDate() {
        return new Date(new Date().getTime() + expiresIn * 1000);
    }

    public Boolean validateToken(String token, WebUser webUser) throws JwkException {


        Organization org = webUser.getIorgId();

        JsonNode settings = org.getAttribs();
        Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
        if (sso) {

            String url = settings.at("/ssoConfig/spring.security.oauth2.resourceserver.jwt.jwk-set-uri").asText();
            DecodedJWT jwt = null;
            try {
                jwt = JWT.decode(token);
            } catch (Exception e) {
                LOGGER.error("error decoding token. Token : " + token);
                throw e;
            }
            
            JwkProvider provider = getProvider(org.getIorgid(), url);
            Jwk jwk = provider.get(jwt.getKeyId());
            Algorithm algorithm = Algorithm.RSA256((RSAPublicKey) jwk.getPublicKey(), null);
            algorithm.verify(jwt);

            String user_name_attrib = settings.at("/ssoConfig/spring.security.oauth2.resourceserver.jwt.user-name-attribute").asText();

            final String username = jwt.getClaim(user_name_attrib).asString();
            return username != null
                    && jwt.getExpiresAt().after(new Date())
                    && username.equals(webUser.getVcUserName());
        } else {

            final String username = getUsernameFromToken(token);
            return (
                    username != null &&
                            username.equals(webUser.getUsername()) &&
                            !isTokenExpired(token)
            );
        }
    }

    public Boolean validateToken(String token, ClientUser webUser) {
        final String username = getUsernameFromToken(token);
        return (
                username != null &&
                        username.equals(webUser.getUsername()) &&
                        !isTokenExpired(token)
        );
    }

    public boolean isTokenExpired(String token) {
        Date expireDate = getExpirationDate(token);
        return expireDate.before(new Date());
    }


    private Date getExpirationDate(String token) {
        Date expireDate;
        try {
            final Claims claims = this.getAllClaimsFromToken(token);
            expireDate = claims.getExpiration();
        } catch (Exception e) {
            expireDate = null;
        }
        return expireDate;
    }


    public Date getIssuedAtDateFromToken(String token) {
        Date issueAt;
        try {
            final Claims claims = this.getAllClaimsFromToken(token);
            issueAt = claims.getIssuedAt();
        } catch (Exception e) {
            issueAt = null;
        }
        return issueAt;
    }

    public String getToken(HttpServletRequest request) {

        String authHeader = getAuthHeaderFromHeader(request);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }

        return null;
    }

    public String getAuthHeaderFromHeader(HttpServletRequest request) {
        return request.getHeader("Authorization");
    }
}
