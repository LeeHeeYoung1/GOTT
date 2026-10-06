package com.kedu.batch;

public class RunPermit {

	public static void main(String[] args) throws Exception {

		PermitCollector c = new PermitCollector();

		System.out.println(c.collect("lodgings", "STAY", "서울특별시"));
	}
}