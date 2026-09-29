package com.kedu.batch;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.kedu.commons.ApiUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomCollector {

	private static final String KEY =
			"37e2e99edbaeec122328fc0298b377d9e68117f67d049bade4930aa58662e172";

	private static final String DB_URL  = "jdbc:oracle:thin:@10.5.4.10:1521:xe";
	private static final String DB_USER = "gott";
	private static final String DB_PW   = "gott";

	// 편의시설 필드 → 표시명
	private static final String[][] AMENITY = {
		{ "roomaircondition", "에어컨" }, { "roomtv", "TV" },
		{ "roomrefrigerator", "냉장고" }, { "roomhairdryer", "드라이기" },
		{ "roominternet", "인터넷" },     { "roompc", "PC" },
		{ "roomcook", "취사" },           { "roomsofa", "소파" },
		{ "roombathfacility", "욕실" },   { "roomtoiletries", "세면도구" },
		{ "roomcable", "케이블TV" },      { "roomhometheater", "홈시어터" }
	};

	public void run() throws Exception {

		List<Object[]> stays = loadStays();     // TourAPI 숙박 목록
		System.out.println("대상 숙소 " + stays.size() + "곳\n");

		int totalRoom = 0, withPrice = 0, withImg = 0, noRoom = 0;

		for (Object[] s : stays) {
			int    placeId   = (Integer) s[0];
			String contentId = (String)  s[1];
			String placeName = (String)  s[2];

			List<Object[]> rooms = fetchRooms(placeId, contentId);

			if (rooms.isEmpty()) { noRoom++; continue; }

			for (Object[] r : rooms) {
				totalRoom++;
				if (r[5] != null && ((Integer) r[5]) > 0) withPrice++;  // price_weekday
				if (r[7] != null) withImg++;                            // image1
			}

			save(rooms);
			System.out.printf("%-28s 객실 %d개%n", cut(placeName, 26), rooms.size());

			Thread.sleep(120);
		}

		System.out.println("\n========== 수집 결과 ==========");
		System.out.println("숙소          : " + stays.size() + "곳 (객실정보 없음 " + noRoom + ")");
		System.out.println("객실          : " + totalRoom + "개");
		System.out.println("요금 있는 객실 : " + withPrice + "개");
		System.out.println("사진 있는 객실 : " + withImg + "개");
	}

	/** Place에서 TourAPI 숙박 목록 읽기 */
	private List<Object[]> loadStays() throws Exception {

		List<Object[]> list = new ArrayList<Object[]>();
		String sql = "SELECT place_id, api_content_id, name FROM Place " +
					 " WHERE source = 'TOURAPI' AND place_type = 'STAY' " +
					 "   AND api_content_id IS NOT NULL";

		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);

		while (rs.next())
			list.add(new Object[] {
					Integer.valueOf(rs.getInt(1)), rs.getString(2), rs.getString(3) });

		rs.close(); st.close(); conn.close();
		return list;
	}

	/** detailInfo2 호출 → 객실 목록 */
	private List<Object[]> fetchRooms(int placeId, String contentId) {

		List<Object[]> rooms = new ArrayList<Object[]>();

		try {
			String url = "https://apis.data.go.kr/B551011/KorService2/detailInfo2"
					+ "?serviceKey=" + KEY
					+ "&MobileOS=ETC&MobileApp=GOTT&_type=json"
					+ "&contentId="     + contentId
					+ "&contentTypeId=32"
					+ "&numOfRows=30&pageNo=1";

			JsonObject root = ApiUtil.get(url);
			JsonObject body = root.getAsJsonObject("response").getAsJsonObject("body");

			JsonElement itemsEl = body.get("items");
			if (itemsEl == null || itemsEl.isJsonPrimitive()) return rooms;

			JsonArray items = itemsEl.getAsJsonObject().getAsJsonArray("item");

			for (JsonElement el : items) {
				JsonObject o = el.getAsJsonObject();

				String name = ApiUtil.str(o, "roomtitle");
				if (name.isEmpty()) continue;

				rooms.add(new Object[] {
						Integer.valueOf(placeId),
						cut(name, 200),
						Integer.valueOf(num(o, "roomcount", 1)),      // 0이면 1
						Integer.valueOf(num(o, "roombasecount", 2)),
						Integer.valueOf(num(o, "roommaxcount", 4)),
						Integer.valueOf(num(o, "roomoffseasonminfee1", 0)),
						Integer.valueOf(num(o, "roomoffseasonminfee2", 0)),
						nvl(cut(ApiUtil.str(o, "roomimg1"), 300)),
						cut(amenities(o), 300),
						cut(ApiUtil.str(o, "roomintro").trim(), 2000)
				});
			}
		} catch (Exception e) {
			System.out.println("   실패 contentId=" + contentId + " : " + e.getMessage());
		}
		return rooms;
	}

	/** 숫자 파싱, 0이거나 실패하면 기본값 */
	private int num(JsonObject o, String key, int def) {
		try {
			int v = Integer.parseInt(ApiUtil.str(o, key).replace(",", ""));
			return v > 0 ? v : def;
		} catch (Exception e) { return def; }
	}

	/** Y인 편의시설을 쉼표로 이어붙이기 */
	private String amenities(JsonObject o) {
		StringBuilder sb = new StringBuilder();
		for (String[] a : AMENITY) {
			if ("Y".equalsIgnoreCase(ApiUtil.str(o, a[0]))) {
				if (sb.length() > 0) sb.append(",");
				sb.append(a[1]);
			}
		}
		return sb.toString();
	}

	private void save(List<Object[]> rows) throws Exception {

		if (rows.isEmpty()) return;

		String sql =
			"MERGE INTO Room r " +
			"USING (SELECT ? pid, ? nm, ? cnt, ? bc, ? mc, ? pw, ? pe, " +
			"              ? img, ? amn, ? intro FROM dual) s " +
			"   ON (r.place_id = s.pid AND r.room_name = s.nm) " +
			" WHEN MATCHED THEN UPDATE SET " +
			"      r.room_count = s.cnt, r.base_count = s.bc, r.max_count = s.mc, " +
			"      r.price_weekday = s.pw, r.price_weekend = s.pe, " +
			"      r.image1 = s.img, r.amenities = s.amn, r.intro = s.intro " +
			" WHEN NOT MATCHED THEN INSERT " +
			"      (room_id, place_id, room_name, room_count, base_count, max_count, " +
			"       price_weekday, price_weekend, image1, amenities, intro) " +
			" VALUES (room_seq.NEXTVAL, s.pid, s.nm, s.cnt, s.bc, s.mc, " +
			"         s.pw, s.pe, s.img, s.amn, s.intro)";

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);

			for (Object[] r : rows) {
				ps.setInt(1,    ((Integer) r[0]).intValue());
				ps.setString(2, (String) r[1]);
				ps.setInt(3,    ((Integer) r[2]).intValue());
				ps.setInt(4,    ((Integer) r[3]).intValue());
				ps.setInt(5,    ((Integer) r[4]).intValue());
				ps.setInt(6,    ((Integer) r[5]).intValue());
				ps.setInt(7,    ((Integer) r[6]).intValue());
				ps.setString(8, (String) r[7]);
				ps.setString(9, (String) r[8]);
				ps.setString(10,(String) r[9]);
				ps.addBatch();
			}
			ps.executeBatch();
			conn.commit();

		} finally {
			if (ps != null)   try { ps.close(); }   catch (Exception ig) {}
			if (conn != null) try { conn.close(); } catch (Exception ig) {}
		}
	}

	private String cut(String s, int len) {
		if (s == null || s.isEmpty()) return null;
		return s.length() <= len ? s : s.substring(0, len);
	}

	private String nvl(String s) { return (s == null || s.isEmpty()) ? null : s; }

	public static void main(String[] args) throws Exception {
		new RoomCollector().run();
	}
}