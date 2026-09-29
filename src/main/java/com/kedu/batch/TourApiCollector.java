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
	 * @param areaCode      5=愿묒＜, 38=�쟾�궓
	 * @param contentTypeId 12=愿�愿묒�, 32=�닕諛�, 39=�쓬�떇�젏
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
						+ " ���긽 " + total + "嫄�");
			}

			List<Object[]> batch = new ArrayList<Object[]>();

			for (JsonElement el : items) {
				JsonObject o = el.getAsJsonObject();

				String id   = ApiUtil.str(o, "contentid");
				String name = ApiUtil.str(o, "title");
				String lats = ApiUtil.str(o, "mapy");   // �쐞�룄
				String lngs = ApiUtil.str(o, "mapx");   // 寃쎈룄

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

				addr = normalizeAddr(addr);          // �쁾 �뻾�젙援ъ뿭紐� �넻�씪

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
						cut(img, 300),               // image_name �넀 �궗吏�
						null                         // intro
				});
			}

			saved += dao.saveBatch(batch);
			System.out.println("   [" + page + "p] ���옣 " + saved + " / �젣�쇅 " + skipped);

			if (items.size() < 100) break;
			page++;
			Thread.sleep(150);
		}

		return "area=" + areaCode + " type=" + contentTypeId
				+ " �넂 ���옣 " + saved + "嫄�, �젣�쇅 " + skipped + "嫄�";
	}

	/** TourAPI�쓽 �넻�빀 �씠�쟾 �뻾�젙援ъ뿭紐낆쓣 �넻�빀�떆 紐낆묶�쑝濡� 蹂��솚 */
	private String normalizeAddr(String addr) {
		if (addr == null) return null;
		if (addr.startsWith("愿묒＜愿묒뿭�떆"))
			return "�쟾�궓愿묒＜�넻�빀�듅蹂꾩떆" + addr.substring("愿묒＜愿묒뿭�떆".length());
		if (addr.startsWith("�쟾�씪�궓�룄"))
			return "�쟾�궓愿묒＜�넻�빀�듅蹂꾩떆" + addr.substring("�쟾�씪�궓�룄".length());
		return addr;
	}

	private String typeOf(int id) {
		if (id == 32) return "STAY";
		if (id == 39) return "FOOD";
		return "SPOT";
	}

	private String[] splitRegion(String addr) {
		String[] p = addr.trim().split("\\s+");
		String region  = p.length > 0 ? p[0] : "湲고�";
		String sigungu = p.length > 1 ? p[1] : null;
		return new String[] { region, sigungu };
	}

	private String cut(String s, int len) {
		if (s == null || s.isEmpty()) return null;
		return s.length() <= len ? s : s.substring(0, len);
	}

	/** response.body.items.item �� 0嫄댁씠硫� items媛� 鍮� 臾몄옄�뿴濡� �샂 */
	private JsonArray items(JsonObject root) {
		try {
			JsonElement items = root.getAsJsonObject("response")
									.getAsJsonObject("body").get("items");

			if (items == null || items.isJsonPrimitive()) return null;

			return items.getAsJsonObject().getAsJsonArray("item");

		} catch (Exception e) {
			System.out.println("=== �쓳�떟 �솗�씤 �븘�슂 ===");
			ApiUtil.print(root);
			return null;
		}
	}
}