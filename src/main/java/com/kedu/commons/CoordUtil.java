package com.kedu.commons;

public class CoordUtil {

	/** 대한민국 범위 안인지 (TourAPI 좌표 검증용) */
	public static boolean isValid(double lat, double lng) {
		return lat >= 33 && lat <= 39 && lng >= 124 && lng <= 132;
	}
}