package com.kedu.batch;

import com.kedu.commons.CoordUtil;

public class CoordTest {

	public static void main(String[] args) {

		// 실제 API 응답에서 가져온 값
		String[][] samples = {
			{ "더브릭호텔 (광산구 첨단)", "186057.14967087",  "190805.269656945" },
			{ "고흥 (고흥읍)",          "226129.718717202", "123417.04658747"  },
			{ "보성 (회천면)",          "208230.601834907", "130248.543224418" },
			{ "울릉 (북면 추산)",        "540943.218188984", "455313.18571662"  },
		};

		for (String[] s : samples) {
			double[] c = CoordUtil.toWgs84(s[1], s[2]);
			if (c == null) {
				System.out.printf("%-22s 변환 실패%n", s[0]);
			} else {
				System.out.printf("%-22s %.5f, %.5f%n", s[0], c[0], c[1]);
			}
		}
	}
}