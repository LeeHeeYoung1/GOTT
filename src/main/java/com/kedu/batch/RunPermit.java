package com.kedu.batch;

public class RunPermit {

	public static void main(String[] args) throws Exception {

		PermitCollector p = new PermitCollector();

		// 숙박 먼저 (약 60페이지, 2분)
		System.out.println(p.collect("lodgings", "STAY"));

		// 확인 후 아래 주석 해제 (약 456페이지, 10분)
		System.out.println(p.collect("general_restaurants", "FOOD"));
	}
}