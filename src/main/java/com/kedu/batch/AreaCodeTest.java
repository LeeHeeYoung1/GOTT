package com.kedu.batch;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.kedu.commons.ApiUtil;

public class AreaCodeTest {

	private static final String KEY =
			"37e2e99edbaeec122328fc0298b377d9e68117f67d049bade4930aa58662e172";

	public static void main(String[] args) throws Exception {

		String url = "https://apis.data.go.kr/B551011/KorService2/areaCode2"
				+ "?serviceKey=" + KEY
				+ "&MobileOS=ETC&MobileApp=GOTT&_type=json"
				+ "&numOfRows=50&pageNo=1";

		JsonObject root = ApiUtil.get(url);

		try {
			JsonArray items = root.getAsJsonObject("response")
								  .getAsJsonObject("body")
								  .getAsJsonObject("items")
								  .getAsJsonArray("item");

			System.out.println("코드   지역명");
			System.out.println("------------------------");
			for (JsonElement el : items) {
				JsonObject o = el.getAsJsonObject();
				System.out.printf("%-6s %s%n",
						ApiUtil.str(o, "code"), ApiUtil.str(o, "name"));
			}
		} catch (Exception e) {
			System.out.println("응답 확인:");
			ApiUtil.print(root);
		}
	}
}