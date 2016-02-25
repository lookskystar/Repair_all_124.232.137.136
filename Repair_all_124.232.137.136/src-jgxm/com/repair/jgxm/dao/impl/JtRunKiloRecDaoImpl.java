package com.repair.jgxm.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.AbstractDao;
import com.repair.jgxm.dao.JtRunKiloRecDao;

/**
 * 
 * @author 周云韬
 * @Date	2015年10月30日14:41:17
 * 机车走行公里记录 dao层
 */

public class JtRunKiloRecDaoImpl extends AbstractDao  implements JtRunKiloRecDao{

	/**
	 * 通过机车型号和机车号获得对应得机车走行公里对象
	 * @param jcsType	机车类型
	 * @param jcnum		机车号
	 * @return	机车走行公里对象
	 */
	public JtRunKiloRec findByJcSTypeAndJcNum(String jcsType,String jcnum){
		List<JtRunKiloRec> list=getHibernateTemplate().
				find("from JtRunKiloRec where jcType=? and jcNum=?",jcsType,jcnum);
		
		return list.size() == 0 ? null : list.get(0);
	}
	
	
}
