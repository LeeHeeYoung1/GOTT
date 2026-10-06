package com.kedu.commons;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ApiUtil {

	/** URL 호출 후 JSON 파싱 */
	public static JsonObject get(String url) throws Exception {

		HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
		con.setRequestMethod("GET");
		con.setConnectTimeout(10000);
		con.setReadTimeout(30000);

		BufferedReader br = new BufferedReader(
				new InputStreamReader(con.getInputStream(), "UTF-8"));
		JsonObject root = JsonParser.parseReader(br).getAsJsonObject();
		br.close();

		return root;
	}

	/** null 안전 문자열 추출 */
	public static String str(JsonObject o, String key) {
		JsonElement e = o.get(key);
		return (e == null || e.isJsonNull()) ? "" : e.getAsString().trim();
	}

	/** 보기 좋게 출력 (구조 확인용) */
	public static void print(JsonElement e) {
		Gson g = new GsonBuilder().setPrettyPrinting().create();
		System.out.println(g.toJson(e));
	}
}