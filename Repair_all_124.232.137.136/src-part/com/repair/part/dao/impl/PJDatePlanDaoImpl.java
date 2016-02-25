package com.repair.part.dao.impl;

import java.util.LinkedHashMap;
import java.util.List;

import com.repair.part.dao.PJDatePlanDao;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.PJDatePlan;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.util.DaoManageSupport;
import com.repair.common.util.PageModel;

public class PJDatePlanDaoImpl extends DaoManageSupport implements PJDatePlanDao {

	@Override
	public PageModel findPageModelPartPlan() {
		LinkedHashMap<String,String> map = new LinkedHashMap<String, String>();
		map.put("status", "asc");
		map.put("makeDate", "desc");
		map.put("planId", "asc");
		return  getScrollData(PJDatePlan.class,map);
	}
	
	@Override
	public List<String> findJcTypeValueFromDictFirstUnit() {
		String hql = "select jcStypeValue from DictJcStype";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public List<DictFirstUnit> findDictFirstUnitsByJcType(String jcType) {
		String hql = "from DictFirstUnit dfu where dfu.jcstypevalue like '%"+jcType+",%'";
		return getHibernateTemplate().find(hql);
	}
	
	@Override
	public PageModel findPageModelPJStaticInfoByJcTypeAndProfession(String jcTypeVal, Long firstUnitId,String keyword) {
		String wherehql = "firstUnit.firstunitid=? and jcType like '%"+jcTypeVal+"%' and pjName like '%"+keyword+"%'";
		return getScrollData(PJStaticInfo.class,wherehql,new Object[]{firstUnitId});
	}
	
	@Override
	public void savePjDatePlan(PJDatePlan datePlan) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(datePlan);
	}
	
	@Override
	public PJDatePlan getPJDatePlanById(long planId) {
		return getHibernateTemplate().get(PJDatePlan.class, planId);
	}
	
	@Override
	public int findChoicedPJNum(long planId) {
		String hql = "select count(*) from PJFixRecord pjrec where pjrec.type=0 and pjrec.datePlan.planId=:planId";
		String paramName = "planId";
		Long pid = planId;
		List list = getHibernateTemplate().findByNamedParam(hql, paramName, pid);
		return ((Long)list.get(0)).intValue();
	}
	
	@Override
	public void updateDatePlan(PJDatePlan pjDatePlan) {
		getHibernateTemplate().update(pjDatePlan);
	}

	@Override
	public List<PJFixRecord> findPJDynamicFixRecListByDatePlan(PJDatePlan pjDatePlan) {
		String hql = "from PJFixRecord rec where rec.type=0 and rec.datePlan.planId=?";
		return getHibernateTemplate().find(hql, pjDatePlan.getPlanId());
	}
}
