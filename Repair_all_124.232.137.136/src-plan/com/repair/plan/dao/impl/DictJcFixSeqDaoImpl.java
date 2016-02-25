package com.repair.plan.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DictJcFixSeq;
import com.repair.plan.dao.DictJcFixSeqDao;

public class DictJcFixSeqDaoImpl extends HibernateDaoSupport implements DictJcFixSeqDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcFixSeq> findDictJcFixSeqs() {
		return getHibernateTemplate().find("from DictJcFixSeq as djfs where djfs.fixValue not like 'Z%'");
	}

}
