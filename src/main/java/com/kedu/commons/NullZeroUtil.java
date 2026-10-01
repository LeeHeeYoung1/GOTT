package com.kedu.commons;

public class NullZeroUtil {

	public static String nullZero(String s) {
		if(s == null) {
			return null;				// 이미 null이면 그대로
		}
		else if(s.trim().isEmpty()) {
			return null;				// 공백뿐이면 null로
		}
		else {
			return s;					// 값이 있으면 그대로
		}
	}
}
