package com.kedu.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbTest {

	public static final String URL  = "jdbc:oracle:thin:@10.5.4.10:1521:xe";
	public static final String USER = "gott";
	public static final String PW   = "gott";

	public static void main(String[] args) {

		System.out.println("[1] main 진입");

		Connection conn = null;

		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println("[2] 드라이버 로딩 완료");

			// 10초 안에 응답 없으면 포기
			DriverManager.setLoginTimeout(10);

			System.out.println("[3] 접속 시도 : " + URL);
			conn = DriverManager.getConnection(URL, USER, PW);
			System.out.println("[4] 접속 성공");

			Statement st = conn.createStatement();

			System.out.println("\n== 테이블 목록 ==");
			ResultSet rs = st.executeQuery(
					"SELECT table_name FROM user_tables ORDER BY table_name");
			boolean hasPlace = false, any = false;
			while (rs.next()) {
				String t = rs.getString(1);
				System.out.println("   - " + t);
				any = true;
				if ("PLACE".equals(t)) hasPlace = true;
			}
			if (!any) System.out.println("   (테이블 없음)");
			rs.close();

			if (hasPlace) {
				System.out.println("\n== Place 컬럼 ==");
				rs = st.executeQuery(
						"SELECT column_name, data_type, data_length, nullable" +
						"  FROM user_tab_columns" +
						" WHERE table_name = 'PLACE' ORDER BY column_id");
				while (rs.next())
					System.out.printf("   %-20s %s(%d) %s%n",
							rs.getString(1), rs.getString(2),
							rs.getInt(3), rs.getString(4));
				rs.close();

				rs = st.executeQuery("SELECT COUNT(*) FROM Place");
				if (rs.next()) System.out.println("\n건수: " + rs.getInt(1));
				rs.close();
			} else {
				System.out.println("\n== Place 테이블 없음 → 생성 필요 ==");
			}

			System.out.println("\n== 시퀀스 ==");
			rs = st.executeQuery(
					"SELECT sequence_name FROM user_sequences ORDER BY sequence_name");
			boolean anySeq = false;
			while (rs.next()) {
				System.out.println("   - " + rs.getString(1));
				anySeq = true;
			}
			if (!anySeq) System.out.println("   (시퀀스 없음)");
			rs.close();

			st.close();

		} catch (Throwable e) {
			System.out.println("\n[에러] " + e.getClass().getName());
			System.out.println("       " + e.getMessage());
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try { conn.close(); } catch (Exception ig) {}
			}
			System.out.println("\n[끝]");
		}
	}
}