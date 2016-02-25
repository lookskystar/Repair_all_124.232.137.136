package com.repair.jgxm.service.impl;

import java.util.List;
import com.repair.common.pojo.DictJcType;
import com.repair.jgxm.dao.DictJcTypeDao;

/**
 * 
 * @author 周云韬
 * @Date	2015年10月30日14:22:25
 * 机车类型service层
 */

public class DictJcTypeServiceImpl {
	
	private DictJcTypeDao dictJcTypeDao;
	
	/** 通过机车类型ID获得机车类型对象 */
	public DictJcType findById(Integer id){
		return dictJcTypeDao.findById(id);
	}
	
	/** 获取所有机车类型 */
	public List<DictJcType> listDictJcType(){
		return dictJcTypeDao.listDictJcType();
	}
	
	
}
