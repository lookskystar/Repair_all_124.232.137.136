package com.repair.jgxm.dao.impl;

import java.util.List;

import com.repair.common.pojo.DictJcType;
import com.repair.common.util.AbstractDao;
import com.repair.jgxm.dao.DictJcTypeDao;

/**
 * 
 * @author 周云韬
 * @Date	2015年10月30日14:22:25
 * 机车类型dao层实现
 */
public class DictJcTypeDaoImpl extends AbstractDao implements DictJcTypeDao {
	
	
	@Override
	public DictJcType findById(Integer id) {
		return getHibernateTemplate().get(DictJcType.class, id);
	}

	@Override
	public List<DictJcType> listDictJcType() {
		return getHibernateTemplate().find("from DictJcType");
	}

}
