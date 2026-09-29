package com.kedu.commons;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptionUtils {

	public static String encryptSHA512(String pw) {
	    if (pw == null) return null;
	    try {
	        byte[] hash = MessageDigest.getInstance("SHA-512")
	                                   .digest(pw.getBytes(StandardCharsets.UTF_8));
	        return String.format("%0128x", new BigInteger(1, hash));
	    } catch (NoSuchAlgorithmException e) {
	        throw new RuntimeException(e);
	    }
	}
	
}
