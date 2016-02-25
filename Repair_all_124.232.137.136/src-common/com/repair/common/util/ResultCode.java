package com.repair.common.util;

/**
 * 错误代码集合
 * 其中以 T_ 开头的错误代码是来自实习系统
 * @author Administrator
 *
 */
public class ResultCode {
	
	private int value;
	public ResultCode(int value) {
		this.value=value;
	}
	/**
	 * 比较相等
	 */
	@Override
	public boolean equals(Object obj){
		if(obj !=null && obj instanceof ResultCode){
				return ((ResultCode)obj).value==value;
		}
		return false;
	}
	@Override
	public String toString(){
		return value+"";
	}
	/**
	 * 获得值
	 * @return
	 */
	public int getValue(){
		return value;
	}
	
	/**
	 * 成功
	 */
	public static final ResultCode OK = new ResultCode(0);
	/**
	 * 失败
	 */
	public static final ResultCode FAIL = new ResultCode(-1);
	
	/**
	 * 数据不存在
	 */
	public static final ResultCode UNEXISTS = new ResultCode(-2);
	/**
	 * 数据已经存在
	 */
	public static final ResultCode EXISTS = new ResultCode(-3);
	/**
	 *	机车编号为空
	 */
	public static final ResultCode MISSCODE = new ResultCode(-4);
	/**
	 * 主键ID为空
	 */
	public static final ResultCode MISSID = new ResultCode(-5);
	/**
	 * 机车型号为空
	 */
	public static final ResultCode MISSTYPE = new ResultCode(-6);
}
