package com.kedu.batch;

public class RunTour {

	public static void main(String[] args) throws Exception {

		TourApiCollector t = new TourApiCollector();

		int[] areas = { 5, 38 };          // ±¤ÁÖ, Àü³²
		int[] types = { 12, 32, 39 };     // °ü±¤Áö, ¼÷¹Ú, À½½ÄÁ¡

		for (int a : areas) {
			for (int ty : types) {
				System.out.println(t.collect(a, ty));
			}
		}
	}
}