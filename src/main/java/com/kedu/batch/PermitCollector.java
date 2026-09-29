package com.kedu.batch;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.kedu.commons.ApiUtil;
import com.kedu.commons.CoordUtil;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class PermitCollector {

	private static final String KEY =
			"37e2e99edbaeec122328fc0298b377d9e68117f67d049bade4930aa58662e172";

	private static final String AREA = "전남광주통합특별시";

	/** 여행 서비스에 부적합한 업태 */
	private static final Set<String> BLOCK = new HashSet<String>(Arrays.asList(
			"룸살롱", "단란주점", "간이주점", "감성주점", "다방",
			"여인숙업", "이동조리", "출장조리",
			"식품소분업", "식품등 수입판매업"));

	private PlaceBatchDao dao = new PlaceBatchDao();

	/**
	 * @param service   "general_restaurants" / "lodgings"
	 * @param placeType "FOOD" / "STAY"
	 */
	public String collect(String service, String placeType) throws Exception {

		int page = 1, saved = 0, skipped = 0;

		while (true) {

			String url = "https://apis.data.go.kr/1741000/" + service + "/info"
					+ "?serviceKey=" + KEY
					+ "&pageNo="     + page
					+ "&numOfRows=100"
					+ "&cond%5BROAD_NM_ADDR::LIKE%5D=" + URLEncoder.encode(AREA, "UTF-8")
					+ "&cond%5BSALS_STTS_CD::EQ%5D=01";

			JsonObject root = ApiUtil.get(url);
			JsonArray items = items(root);
			if (items == null || items.size() == 0) break;

			if (page == 1) {
				int total = root.getAsJsonObject("response").getAsJsonObject("body")
								.get("totalCount").getAsInt();
				System.out.println(">> " + service + " 대상 " + total + "건, 약 "
						+ ((total / 100) + 1) + "페이지");
			}

			List<Object[]> batch = new ArrayList<Object[]>();

			for (JsonElement el : items) {
				JsonObject o = el.getAsJsonObject();

				String name  = ApiUtil.str(o, "BPLC_NM");
				String uptae = ApiUtil.str(o, "BZSTAT_SE_NM");
				String tel   = ApiUtil.str(o, "TELNO");
				String mngNo = ApiUtil.str(o, "MNG_NO");

				if (name.isEmpty() || mngNo.isEmpty())      { skipped++; continue; }
				if (BLOCK.contains(uptae))                  { skipped++; continue; }
				if ("기타".equals(uptae) && tel.isEmpty())   { skipped++; continue; }
				if (!ApiUtil.str(o, "CLSBIZ_YMD").isEmpty()) { skipped++; continue; }

				double[] c = CoordUtil.toWgs84(
						ApiUtil.str(o, "CRD_INFO_X"),
						ApiUtil.str(o, "CRD_INFO_Y"));
				if (c == null) { skipped++; continue; }

				String addr = ApiUtil.str(o, "ROAD_NM_ADDR");
				if (addr.isEmpty()) addr = ApiUtil.str(o, "LOTNO_ADDR");
				if (addr.isEmpty()) { skipped++; continue; }

				String[] rs = splitRegion(addr);

				batch.add(new Object[] {
						"PERMIT",                       // source
						cut(mngNo, 50),                 // api_content_id
						placeType,                      // place_type
						cut(name, 200),                 // name
						cut(rs[0], 100),                // region
						cut(rs[1], 100),                // sigungu
						cut(addr, 300),                 // address
						cut(tel, 30),                   // tel
						Double.valueOf(c[0]),           // latitude
						Double.valueOf(c[1]),           // longitude
						null,                           // image_name
						cut(uptae, 2000)                // intro (업태를 임시로)
				});
			}

			saved += dao.saveBatch(batch);

			if (page % 20 == 0 || items.size() < 100)
				System.out.println("[" + service + " " + page + "p] 저장 " + saved
						+ " / 제외 " + skipped);

			if (items.size() < 100) break;
			page++;
			Thread.sleep(120);
		}

		return service + " → 저장 " + saved + "건, 제외 " + skipped + "건";
	}

	/** "전남광주통합특별시 광산구 ..." → {"전남광주통합특별시", "광산구"} */
	private String[] splitRegion(String addr) {
		String[] p = addr.trim().split("\\s+");
		String region  = p.length > 0 ? p[0] : "기타";
		String sigungu = p.length > 1 ? p[1] : null;
		return new String[] { region, sigungu };
	}

	/** 컬럼 길이 초과 방지 */
	private String cut(String s, int len) {
		if (s == null || s.isEmpty()) return null;
		return s.length() <= len ? s : s.substring(0, len);
	}

	private JsonArray items(JsonObject root) {
		try {
			JsonObject res = root.getAsJsonObject("response");

			String code = res.getAsJsonObject("header").get("resultCode").getAsString();
			if (!"0".equals(code)) {
				System.out.println("API 에러: " + res.getAsJsonObject("header"));
				return null;
			}

			return res.getAsJsonObject("body")
					  .getAsJsonObject("items")
					  .getAsJsonArray("item");

		} catch (Exception e) {
			System.out.println("=== 응답 구조 확인 필요 ===");
			ApiUtil.print(root);
			return null;
		}
	}
}