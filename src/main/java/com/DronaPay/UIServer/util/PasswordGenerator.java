package com.DronaPay.UIServer.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class PasswordGenerator {

    @Value("${minimum.password.length}")
    private int minLength;

    @Value("${max.password.length}")
    private int maxLength;

    private static final SecureRandom secureRandom = new SecureRandom();

    // Method to generate the password
    public String generateSecurePassword() {
        // Randomly decide the password length between min and max
        int length = minLength + secureRandom.nextInt(maxLength - minLength + 1);

        // Ensure at least one of each required character type
        String upperCase = generateRandomString(1, 65, 90);  // Uppercase A-Z
        String lowerCase = generateRandomString(1, 97, 122);  // Lowercase a-z
        String digit = generateRandomString(1, 48, 57);  // Digits 0-9
        String specialChar = generateRandomString(1, 33, 47);  // Special characters (ASCII 33-47)

        // Fill the rest with random characters from the full range (ASCII 33 to 122)
        String remainingChars = generateRandomString(length - 4, 33, 122); // From special chars to lowercase letters

        // Combine all parts and shuffle to remove patterns
        String combinedChars = upperCase + lowerCase + digit + specialChar + remainingChars;
        List<Character> pwdChars = combinedChars.chars()
                .mapToObj(c -> (char) c)
                .collect(Collectors.toList());
        Collections.shuffle(pwdChars);

        // Convert shuffled list back to string
        return pwdChars.stream()
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
    }

    // Helper method to generate a random string from a given ASCII range
    private String generateRandomString(int length, int lowerBound, int upperBound) {
        return secureRandom.ints(lowerBound, upperBound + 1) // Generate random numbers between lowerBound and upperBound
                .limit(length) // Limit to the specified length
                .mapToObj(c -> String.valueOf((char) c)) // Convert the integer to the corresponding character
                .collect(Collectors.joining()); // Join all characters into a single string
    }
}
