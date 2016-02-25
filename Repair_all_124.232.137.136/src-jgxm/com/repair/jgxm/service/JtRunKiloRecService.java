package com.repair.jgxm.service;

import com.repair.common.pojo.JtRunKiloRec;

/**
 * 
 * @author 周云韬
 * @Date	2015年10月30日14:41:17
 * 机车走行公里记录 service层
 */

public interface JtRunKiloRecService {

	/**
	 * 通过机车型号和机车号获得对应得机车走行公里对象
	 * @param jcsType	机车类型
	 * @param jcnum		机车号
	 * @return	机车走行公里对象
	 */
	public JtRunKiloRec findByJcSTypeAndJcNum(String jcsType,String jcnum);
	
	
}
