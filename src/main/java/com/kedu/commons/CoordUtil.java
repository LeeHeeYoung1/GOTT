package com.kedu.commons;

import org.locationtech.proj4j.CRSFactory;
import org.locationtech.proj4j.CoordinateReferenceSystem;
import org.locationtech.proj4j.CoordinateTransform;
import org.locationtech.proj4j.CoordinateTransformFactory;
import org.locationtech.proj4j.ProjCoordinate;

/**
 * 怨듦났�뜲�씠�꽣 醫뚰몴(EPSG:5174) �넂 �쐞寃쎈룄(WGS84) 蹂��솚
 */
public class CoordUtil {

	private static final String EPSG_5174 = "+proj=tmerc +lat_0=38 +lon_0=127.0028902777778 +k=1 "
			+ "+x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs "
			+ "+towgs84=-115.80,474.99,674.11,1.16,-2.31,-1.63,6.43";

	private static final String WGS84 = "+proj=longlat +datum=WGS84 +no_defs";

	private static final CoordinateTransform TF;

	static {
		CRSFactory crsFactory = new CRSFactory();

		CoordinateReferenceSystem src = crsFactory.createFromParameters("EPSG5174", EPSG_5174);
		CoordinateReferenceSystem dst = crsFactory.createFromParameters("WGS84", WGS84);

		CoordinateTransformFactory ctFactory = new CoordinateTransformFactory();
		TF = ctFactory.createTransform(src, dst);
	}

	/**
	 * @param xs 醫뚰몴X (CRD_INFO_X)
	 * @param ys 醫뚰몴Y (CRD_INFO_Y)
	 * @return double[]{�쐞�룄, 寃쎈룄} �� 媛믪씠 �뾾嫄곕굹 踰붿쐞瑜� 踰쀬뼱�굹硫� null
	 */
	public static double[] toWgs84(String xs, String ys) {

		if (xs == null || ys == null || xs.isEmpty() || ys.isEmpty())
			return null;

		try {
			double x = Double.parseDouble(xs);
			double y = Double.parseDouble(ys);
			if (x == 0 || y == 0)
				return null;

			ProjCoordinate out = new ProjCoordinate();
			TF.transform(new ProjCoordinate(x, y), out);

			double lat = out.y; // �쐞�룄
			double lng = out.x; // 寃쎈룄

			if (!isValid(lat, lng))
				return null;

			return new double[] { lat, lng };

		} catch (Exception e) {
			return null;
		}
	}

	/** ���븳誘쇨뎅 踰붿쐞 �븞�씤吏� (TourAPI 醫뚰몴 寃�利앹슜) */
	public static boolean isValid(double lat, double lng) {
		return lat >= 33 && lat <= 39 && lng >= 124 && lng <= 132;
	}
}