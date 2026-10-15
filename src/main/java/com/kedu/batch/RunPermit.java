package com.kedu.batch;

public class RunPermit {

	public static void main(String[] args) throws Exception {

		PermitCollector c = new PermitCollector();

		String[] areas = {
			"경상북도", "경상남도", "충청남도", "전라북도", "충청북도",
			"대구광역시", "대전광역시", "울산광역시", "세종특별자치시"
		};

		for (String area : areas) {
			try {
				System.out.println(c.collect("lodgings", "STAY", area));
			} catch (Exception e) {
				System.out.println("실패 STAY " + area + " : " + e.getMessage());
			}
			try {
				System.out.println(c.collect("general_restaurants", "FOOD", area));
			} catch (Exception e) {
				System.out.println("실패 FOOD " + area + " : " + e.getMessage());
			}
		}
	}
}