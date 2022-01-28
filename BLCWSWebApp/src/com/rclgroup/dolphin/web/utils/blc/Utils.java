/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.utils.blc;
/* ------------------------- Change Log ---------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    14/03/20       chandu               Initial Version
-------------------------------------------------------------------------------
*/

/**
 * This class contain method to convert db code into respective String.
 * 
 * @author Cognis
 *
 */
public class Utils {

	
	public static String getTimeTaken(long startTime, long endTime) {
		long diff = endTime - startTime;
		return diff / 1000+" Seconds ";
	}

	public static String getStatusDesc(String str) {
		if (str == null || str.trim().length() == 0)
			return null;
		else {
			if (str.equalsIgnoreCase("0"))
				str = "Web Entry";
			if (str.equalsIgnoreCase("1"))
				str = "Entry";
			if (str.equalsIgnoreCase("2"))
				str = "Confirmed";
			if (str.equalsIgnoreCase("3"))
				str = "Printed";
			if (str.equalsIgnoreCase("4"))
				str = "Manifested";
			if (str.equalsIgnoreCase("6"))
				str = "Waitlisted";
			if (str.equalsIgnoreCase("7"))
				str = "Split B/L";
			if (str.equalsIgnoreCase("0"))
				str = "Rejected";
			if (str.equalsIgnoreCase("0"))
				str = "Cancelled";
			return str;
		}
	}

	// sets the string received as parameter equal to "0.00" if null,
	// if found empty , is replaced with "0.00"
	// if last indexof . in the string is <0 ".00" is appended to it
	// else the string is returned as it is.
	public static String setInt(String str) {
		if (str == null)
			return "0.00";
		else if (str.trim().equalsIgnoreCase("") || str.trim().equalsIgnoreCase("0"))
			return "0.00";
		else if (str.lastIndexOf(".") < 0)
			return str + ".00";
		else if (str.length() - str.lastIndexOf(".") == 2)
			return str + "0";
		else
			return str;
	}
	
	  	 public static String getSOC(String val) {
		    if (val.trim().equals("S"))
		      return "SOC"; 
		    if (val.trim().equals("C"))
		      return "COC"; 
		    if (val.trim().equals("B"))
			      return "Both"; 
		    return "Others";
		  }
	 

	public static String getDirectionAsString(String direction) {
		if ("N".equalsIgnoreCase(direction)) {
			return "NORTH";
		}
		if ("S".equalsIgnoreCase(direction)) {
			return "SOUTH";
		}
		if ("E".equalsIgnoreCase(direction)) {
			return "EAST";
		}
		if ("W".equalsIgnoreCase(direction)) {
			return "WEST";
		}
		if ("R".equalsIgnoreCase(direction)) {
			return "ROUND";
		}
		if ("NE".equalsIgnoreCase(direction)) {
			return "NORTH EAST";
		}
		if ("NW".equalsIgnoreCase(direction)) {
			return "NORTH WEST";

		}
		if ("SE".equalsIgnoreCase(direction)) {
			return "SOUTH EAST";
		}
		if ("SW".equalsIgnoreCase(direction)) {
			return "SOUTH WEST";
		}
		return "";
	}
	
	public static String getDirectionAsCode(String direction) {
		if ("NORTH".equalsIgnoreCase(direction)) {
			return "N";
		}
		if ("SOUTH".equalsIgnoreCase(direction)) {
			return "S";
		}
		if ("EAST".equalsIgnoreCase(direction)) {
			return "E";
		}
		if ("WEST".equalsIgnoreCase(direction)) {
			return "W";
		}
		if ("ROUND".equalsIgnoreCase(direction)) {
			return "R";
		}
		if ("NORTH EAST".equalsIgnoreCase(direction)) {
			return "NE";
		}
		if ("NORTH WEST".equalsIgnoreCase(direction)) {
			return "NW";

		}
		if ("SOUTH EAST".equalsIgnoreCase(direction)) {
			return "SE";
		}
		if ("SOUTH WEST".equalsIgnoreCase(direction)) {
			return "SW";
		}
		return "";
	}
	

	public static String setBillType(String str) {
		if (str == null)
			return "";
		else if (str.equalsIgnoreCase("T"))
			return "Through";
		else if (str.equalsIgnoreCase("M"))
			return "Memo";
		else if (str.equalsIgnoreCase("D"))
			return "Draft";
		else if (str.equalsIgnoreCase("S"))
			return "Sea Way B/L";
		else
			return str.trim();
	}
	
	public static String setBillTypeAsString(String str) {
		if (str == null)
			return "";
		else if (str.equalsIgnoreCase("Through"))
			return "T";
		else if (str.equalsIgnoreCase("Memo"))
			return "M";
		else if (str.equalsIgnoreCase("Draft"))
			return "D";
		else if (str.equalsIgnoreCase("Sea Way B/L"))
			return "S";
		else
			return str.trim();
	}
}
