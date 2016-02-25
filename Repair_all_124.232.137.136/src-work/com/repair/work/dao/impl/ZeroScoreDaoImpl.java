package com.repair.work.dao.impl;

import java.util.List;

import org.hibernate.FlushMode;

import com.repair.common.pojo.ZeroScore;
import com.repair.common.util.AbstractDao;
import com.repair.work.dao.ZeroScoreDao;

public class ZeroScoreDaoImpl extends AbstractDao implements ZeroScoreDao{

	@Override
	public void addZeroScore(ZeroScore zeroScore) {
		getHibernateTemplate().save(zeroScore);
	}

	@Override
	public ZeroScore findByJtPreDictId(Integer jtPreDictId) {
		String hql="from ZeroScore where jtPreDict.id=?";
		List<ZeroScore> list=getHibernateTemplate().find(hql,jtPreDictId);
		return list.size() == 0 ? null :list.get(0);
	}

	@Override
	public void updateZeroScore(ZeroScore zeroScore) {
		getHibernateTemplate().update(zeroScore);
	}
	
	public Double getTotalScoreByRjhid(Integer rjhid){
		String hql="select sum(score) from ZeroScore where jtPreDict.datePlanPri.rjhmId=?";
		return (Double) getHibernateTemplate().find(hql).get(0);
	}

}
