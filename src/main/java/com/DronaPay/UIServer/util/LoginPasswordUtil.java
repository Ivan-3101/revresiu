package com.DronaPay.UIServer.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Service
public class LoginPasswordUtil {
    @Autowired
    private Environment env;

    @Value(value = "${user.login.private.key}")
    private String privatekey;

    // Get RSA keys. Uses key size of 2048.
    private static Map<String, String> generateRSAKeys() throws Exception {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(2048);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        PrivateKey privateKey = keyPair.getPrivate();
        PublicKey publicKey = keyPair.getPublic();

        Map<String, String> keys = new HashMap<String, String>();
        keys.put("private", Base64.getEncoder().encodeToString(privateKey.getEncoded()));
        keys.put("public", Base64.getEncoder().encodeToString(publicKey.getEncoded()));
        return keys;
    }

    public static PublicKey getPublicKey(String publicK) {
        PublicKey pubKey = null;
        try {
            byte[] publicBytes = Base64.getDecoder().decode(publicK);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicBytes);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            pubKey = keyFactory.generatePublic(keySpec);
        } catch (Exception ex) {
            // ex.printStackTrace();
        }
        return pubKey;
    }

    // Encrypt using RSA private key
    private static String encryptMessage(String plainText, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(plainText.getBytes()));
    }

    // Decrypt using RSA public key
    public String decryptUserPassword(String encryptedString) throws Exception {

//        System.out.println(generateRSAKeys());
        PrivateKey privateKey = getPrivateKey(privatekey);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        return new String(cipher.doFinal(Base64.getDecoder().decode(encryptedString)));

    }

    public PrivateKey getPrivateKey(String privateK) throws Exception {
        byte[] privateBytes = Base64.getDecoder().decode(privateK);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PrivateKey prvKey = keyFactory.generatePrivate(keySpec);
        return prvKey;
    }


} 
