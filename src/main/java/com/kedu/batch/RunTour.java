package com.kedu.batch;

public class RunTour {

	public static void main(String[] args) throws Exception {

		TourApiCollector t = new TourApiCollector();

		int[] areas = { 1 };          // 광주, 전남
		int[] types = { 12, 32, 39 };     // 관광지, 숙박, 음식점

		for (int a : areas) {
			for (int ty : types) {
				System.out.println(t.collect(a, ty));
			}
		}
	}
}