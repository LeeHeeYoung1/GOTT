package com.kedu.commons;

import java.time.DayOfWeek;
import java.time.LocalDate;

public class PriceUtil {

	public static boolean isWeekend(LocalDate date) {
		if(date.getDayOfWeek()== DayOfWeek.FRIDAY || date.getDayOfWeek() == DayOfWeek.SATURDAY){
			return true;
			}
			else {
				return false;
			}
	}

	public static int totalPrice(String checkIn, String checkOut, Integer priceWeekday, Integer priceWeekend) {
		
		if(checkIn == null || checkIn.trim().equals("")) {
			return 0;
		}
		if(checkOut == null || checkOut.trim().equals("")) {
			return 0;
		}
		if(priceWeekday == null) {
			return 0;
		}
		if(priceWeekend == null) {
			priceWeekend = priceWeekday;
		}
		
		int weekday = priceWeekday.intValue();
		int weekend = priceWeekend.intValue();
		
		LocalDate in = LocalDate.parse(checkIn);
		LocalDate out = LocalDate.parse(checkOut);
		
		int sum = 0;
		for(LocalDate d = in; d.isBefore(out); d = d.plusDays(1)) {
			if(isWeekend(d)) {
				sum += weekend;
			}else {
				sum += weekday;
			}
		}
		
		return sum;
	}
}