package com.kedu.commons;

public class TagSplitUtil {

	public static String[] tagSplit(String tags) {
		if (tags == null || tags.trim().equals("")) {
			return new String[0];
		}
		return tags.split(",");
	}
}