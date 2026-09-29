package com.kedu.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

public class PlaceBatchDao {

	private static final String URL  = "jdbc:oracle:thin:@10.5.4.10:1521:xe";
	private static final String USER = "gott";
	private static final String PW   = "gott";

	/**
	 * row = { source, apiContentId, placeType, name, region, sigungu,
	 *         address, tel, lat(Double), lng(Double), imageName, intro }
	 */
	public int saveBatch(List<Object[]> rows) throws Exception {

		if (rows == null || rows.isEmpty()) return 0;

		String sql =
			"MERGE INTO Place p " +
			"USING (SELECT ? src, ? sid, ? ty, ? nm, ? rgn, ? sgg, " +
			"              ? addr, ? tel, ? la, ? lo, ? img, ? intro FROM dual) s " +
			"   ON (p.source = s.src AND p.api_content_id = s.sid) " +
			" WHEN MATCHED THEN UPDATE SET " +
			"      p.name = s.nm, p.region = s.rgn, p.sigungu = s.sgg, " +
			"      p.address = s.addr, p.tel = s.tel, " +
			"      p.latitude = s.la, p.longitude = s.lo, " +
			"      p.image_name = s.img, p.intro = s.intro " +
			" WHEN NOT MATCHED THEN INSERT " +
			"      (place_id, source, api_content_id, place_type, name, region, " +
			"       sigungu, address, tel, latitude, longitude, image_name, intro, " +
			"       avg_rating, review_count, reg_date) " +
			" VALUES (place_seq.NEXTVAL, s.src, s.sid, s.ty, s.nm, s.rgn, " +
			"         s.sgg, s.addr, s.tel, s.la, s.lo, s.img, s.intro, " +
			"         0, 0, SYSTIMESTAMP)";

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(URL, USER, PW);
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);

			for (Object[] r : rows) {
				ps.setString(1,  (String) r[0]);   // source
				ps.setString(2,  (String) r[1]);   // api_content_id
				ps.setString(3,  (String) r[2]);   // place_type
				ps.setString(4,  (String) r[3]);   // name
				ps.setString(5,  (String) r[4]);   // region
				ps.setString(6,  (String) r[5]);   // sigungu
				ps.setString(7,  (String) r[6]);   // address
				ps.setString(8,  (String) r[7]);   // tel

				if (r[8] == null) ps.setNull(9, java.sql.Types.NUMERIC);
				else ps.setDouble(9, (Double) r[8]);            // latitude

				if (r[9] == null) ps.setNull(10, java.sql.Types.NUMERIC);
				else ps.setDouble(10, (Double) r[9]);           // longitude

				ps.setString(11, (String) r[10]);  // image_name
				ps.setString(12, (String) r[11]);  // intro

				ps.addBatch();
			}

			ps.executeBatch();
			conn.commit();
			return rows.size();

		} finally {
			if (ps != null)   try { ps.close(); }   catch (Exception ig) {}
			if (conn != null) try { conn.close(); } catch (Exception ig) {}
		}
	}
}