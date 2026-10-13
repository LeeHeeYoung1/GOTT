package com.kedu.batch;

public class RunTour {

	public static void main(String[] args) throws Exception {

		TourApiCollector t = new TourApiCollector();

		int[] areas = { 32, 39 };          // 경기, 인천, 부산
		int[] types = { 12, 32, 39 };     // 관광지, 숙박, 음식점

		for (int a : areas) {
			for (int ty : types) {
				System.out.println(t.collect(a, ty));
			}
		}
	}
}