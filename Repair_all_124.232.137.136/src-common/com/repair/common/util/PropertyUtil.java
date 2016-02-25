package com.repair.common.util;

import java.util.ResourceBundle;

public class PropertyUtil {

	private static final ResourceBundle resource = ResourceBundle.getBundle("system");

	public static String getResourceByKey(String key) {
		if(key==null || "".equals(key)){
			return "";
		}
		try {
			return resource.getString(key);
		} catch (Exception e) {
			return "";
		}
	}
}
