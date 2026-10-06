package com.kedu.batch;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.kedu.commons.ApiUtil;
import com.kedu.commons.CoordUtil;

import java.util.ArrayList;
import java.util.List;

public class TourApiCollector {

	private static final String KEY =
			"37e2e99edbaeec122328fc0298b377d9e68117f67d049bade4930aa58662e172";

	private static final String BASE = "https://apis.data.go.kr/B551011/KorService2";

	private PlaceBatchDao dao = new PlaceBatchDao();

	/**
	 * @param areaCode      5=광주, 38=전남
	 * @param contentTypeId 12=관광지, 32=숙박, 39=음식점
	 */
	public String collect(int areaCode, int contentTypeId) throws Exception {

		String placeType = typeOf(contentTypeId);
		int page = 1, saved = 0, skipped = 0;

		while (true) {

			String url = BASE + "/areaBasedList2"
					+ "?serviceKey="    + KEY
					+ "&MobileOS=ETC&MobileApp=GOTT&_type=json"
					+ "&areaCode="      + areaCode
					+ "&contentTypeId=" + contentTypeId
					+ "&numOfRows=100"
					+ "&pageNo="        + page
					+ "&arrange=A";

			JsonObject root = ApiUtil.get(url);
			JsonArray items = items(root);
			if (items == null || items.size() == 0) break;

			if (page == 1) {
				int total = root.getAsJsonObject("response").getAsJsonObject("body")
								.get("totalCount").getAsInt();
				System.out.println(">> area=" + areaCode + " type=" + contentTypeId
						+ " 대상 " + total + "건");
			}

			List<Object[]> batch = new ArrayList<Object[]>();

			for (JsonElement el : items) {
				JsonObject o = el.getAsJsonObject();

				String id   = ApiUtil.str(o, "contentid");
				String name = ApiUtil.str(o, "title");
				String lats = ApiUtil.str(o, "mapy");   // 위도
				String lngs = ApiUtil.str(o, "mapx");   // 경도

				if (id.isEmpty() || name.isEmpty()
				 || lats.isEmpty() || lngs.isEmpty()) { skipped++; continue; }

				double lat, lng;
				try {
					lat = Double.parseDouble(lats);
					lng = Double.parseDouble(lngs);
				} catch (Exception e) { skipped++; continue; }

				if (!CoordUtil.isValid(lat, lng)) { skipped++; continue; }

				String addr  = ApiUtil.str(o, "addr1");
				String addr2 = ApiUtil.str(o, "addr2");
				if (!addr2.isEmpty()) addr = addr + " " + addr2;
				if (addr.isEmpty()) { skipped++; continue; }

				addr = normalizeAddr(addr);          // ★ 행정구역명 통일

				String[] rs = splitRegion(addr);
				String img  = ApiUtil.str(o, "firstimage");

				batch.add(new Object[] {
						"TOURAPI",                   // source
						cut(id, 50),                 // api_content_id
						placeType,                   // place_type
						cut(name, 200),              // name
						cut(rs[0], 100),             // region
						cut(rs[1], 100),             // sigungu
						cut(addr, 300),              // address
						cut(ApiUtil.str(o, "tel"), 30),
						Double.valueOf(lat),
						Double.valueOf(lng),
						cut(img, 300),               // image_name ← 사진
						null                         // intro
				});
			}

			saved += dao.saveBatch(batch);
			System.out.println("   [" + page + "p] 저장 " + saved + " / 제외 " + skipped);

			if (items.size() < 100) break;
			page++;
			Thread.sleep(150);
		}

		return "area=" + areaCode + " type=" + contentTypeId
				+ " → 저장 " + saved + "건, 제외 " + skipped + "건";
	}

	/** TourAPI의 통합 이전 행정구역명을 통합시 명칭으로 변환 */
	private String normalizeAddr(String addr) {
		if (addr == null) return null;
		if (addr.startsWith("광주광역시"))
			return "전남광주통합특별시" + addr.substring("광주광역시".length());
		if (addr.startsWith("전라남도"))
			return "전남광주통합특별시" + addr.substring("전라남도".length());
		return addr;
	}

	private String typeOf(int id) {
		if (id == 32) return "STAY";
		if (id == 39) return "FOOD";
		return "SPOT";
	}

	private String[] splitRegion(String addr) {
		String[] p = addr.trim().split("\\s+");
		String region  = p.length > 0 ? p[0] : "기타";
		String sigungu = p.length > 1 ? p[1] : null;
		return new String[] { region, sigungu };
	}

	private String cut(String s, int len) {
		if (s == null || s.isEmpty()) return null;
		return s.length() <= len ? s : s.substring(0, len);
	}

	/** response.body.items.item 이 0건이면 items가 빈 문자열로 옴 */
	private JsonArray items(JsonObject root) {
		try {
			JsonElement items = root.getAsJsonObject("response")
									.getAsJsonObject("body").get("items");

			if (items == null || items.isJsonPrimitive()) return null;

			return items.getAsJsonObject().getAsJsonArray("item");

		} catch (Exception e) {
			System.out.println("=== 응답 확인 필요 ===");
			ApiUtil.print(root);
			return null;
		}
	}
}