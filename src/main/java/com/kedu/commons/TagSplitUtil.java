package com.kedu.commons;

import java.util.List;

public class TagSplitUtil {

	public static String[] tagSplit(String tags){
		String[] splitTags = tags.split(",");
		return splitTags;
	}
}
