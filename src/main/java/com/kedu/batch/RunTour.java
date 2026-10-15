package com.kedu.batch;

public class RunTour {

	public static void main(String[] args) throws Exception {

		TourApiCollector t = new TourApiCollector();

		int[] areas = { 35, 36, 34, 37, 33, 4, 3, 7, 8 };
		// 경북, 경남, 충남, 전북, 충북, 대구, 대전, 울산, 세종
		int[] types = { 12, 32, 39 };     // 관광지, 숙박, 음식점

		for (int a : areas) {
			for (int ty : types) {
				try {
					System.out.println(t.collect(a, ty));
				} catch (Exception e) {
					System.out.println("실패 area=" + a + " type=" + ty + " : " + e.getMessage());
				}
			}
		}
	}
}