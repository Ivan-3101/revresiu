package com.DronaPay.UIServer.util;

import java.net.MalformedURLException;
import java.net.URL;

public class URLChecker {
    public boolean isURL(String str) {
        try {
            // Attempt to create a URL object from the provided string
            URL url = new URL(str);

            // If the URL is valid, return false (i.e., it is a URL)
            return true;
        } catch (MalformedURLException e) {
            // If the URL is not valid, return true (i.e., it is not a URL)
            return false;
        }
    }
}
