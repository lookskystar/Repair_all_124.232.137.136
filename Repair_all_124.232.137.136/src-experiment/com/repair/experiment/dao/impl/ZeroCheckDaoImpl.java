package com.repair.experiment.dao.impl;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.ZeroCheck;
import com.repair.common.util.Contains;
import com.repair.experiment.dao.BaseDao;
import com.repair.experiment.dao.ZeroCheckDao;

@SuppressWarnings("unchecked")
public class ZeroCheckDaoImpl extends BaseDao implements ZeroCheckDao{

	@Override
	public List<DatePlanPri> findCheckDatePlanPri(UsersPrivs user) {
		String hql="from DatePlanPri dpp where dpp.planStatue=2";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public void saveZeroCheck(ZeroCheck zeroCheck) {
		getHibernateTemplate().save(zeroCheck);
		
	}

	@Override
	public ZeroCheck findZeroCheckByUserDpId(DatePlanPri datePlanPri,
			UsersPrivs user) {
		String hql="from ZeroCheck zc where zc.dpId.rjhmId=? and zc.userId.userid=?";
		List list= getHibernateTemplate().find(hql,new Object[]{datePlanPri.getRjhmId(),user.getUserid()});
		if(list!=null&&list.size()>0){
			return (ZeroCheck)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<ZeroCheck> findZeroCheckByDpId(int dpId) {
		String hql="from ZeroCheck zc where zc.dpId.rjhmId=? order by zc.signTime desc";
		return getHibernateTemplate().find(hql,dpId);
	}

}
