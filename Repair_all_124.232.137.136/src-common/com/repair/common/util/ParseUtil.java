package com.repair.common.util;
/**
 * 字符串转为为数字类型
 * @author Administrator
 *
 */
public class ParseUtil {

	public static short parseShort(String s, short num){
		if(s==null || "".equals(s)){
			return num;
		}
		try{
			return Short.parseShort(s);
		}catch (Exception e) {
			return num;
		}
	}
	
	public static int parseInt(String s, int num){
		if(s==null || "".equals(s)){
			return num;
		}
		try{
			return Integer.parseInt(s);
		}catch (Exception e) {
			return num;
		}
	}
	
	public static double parseDouble(String s, double num){
		if(s==null || "".equals(s)){
			return num;
		}
		try{
			return Double.parseDouble(s);
		}catch (Exception e) {
			return num;
		}
	}
	
	public static long parseLong(String s, long num){
		if(s==null || "".equals(s)){
			return num;
		}
		try{
			return Long.parseLong(s);
		}catch (Exception e) {
			return num;
		}
	}
	
	public static float parseFloat(String s, float num){
		if(s==null || "".equals(s)){
			return num;
		}
		try{
			return Float.parseFloat(s);
		}catch (Exception e) {
			return num;
		}
	}
}
