/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.utils.blc;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * This class mainly intended for form the date in different format.
 * 
 * @author Cognis Solution
 *
 */
public class DateUtils {
	public static final SimpleDateFormat simpleDateFormatInput = new SimpleDateFormat("dd/MM/yyyy");
	public static final SimpleDateFormat simpleDateFormatSQL = new SimpleDateFormat("yyyyMMdd");

	public static String getDateFromDefaultDateStringYYYYMMDD(String defaultDate) {
		String sdfYYYMMDDValue = "";
		if (defaultDate == null)
			return null;
		if (defaultDate.equals(""))
			return null;
		System.out.println("defaultDate  " + defaultDate);

		Date date = new Date();
		try {
			date = simpleDateFormatInput.parse(defaultDate);
			System.out.println("date " + date.toString());
			sdfYYYMMDDValue = simpleDateFormatSQL.format(date);
		} catch (Exception e) {
			return null;
		}
		return sdfYYYMMDDValue;
	}

	public static String getDefaultDateYYYYMMDD(int numberOfDays) {
		Date date = new Date();
		date.setDate(date.getDate()+numberOfDays);
		return simpleDateFormatSQL.format(date);

	}
}
