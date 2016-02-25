package com.repair.experiment.dao.impl;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.experiment.dao.BaseDao;
import com.repair.experiment.dao.CheckDealJcDao;

@SuppressWarnings("unchecked")
public class CheckDealJcDaoImpl extends BaseDao implements CheckDealJcDao{

	@Override
	public List<Object[]> findCheckDealDatePlan() {
		String hql="select dpp.rjhmId,dpp.jcType,dpp.jcnum,dpp.fixFreque,dpp.kcsj,dpp.planStatue,jf.nodeName, dpp.gongZhang.xm from DatePlanPri dpp,JCFixflow jf where dpp.nodeid.jcFlowId=jf.jcFlowId and (dpp.planStatue=0 or dpp.planStatue=1)";
		return getSession().createQuery(hql).list();
	}

	@Override
	public void saveSignedForFinish(SignedForFinish signedForFinish) {
		getHibernateTemplate().save(signedForFinish);
	}

	@Override
	public void saveDatePlanPri(DatePlanPri datePlanPri) {
		getHibernateTemplate().save(datePlanPri);
	}

	@Override
	public int findJtPreDictByStatus(int type,int rjhmId) {
		String hql="select count(t.preDictId) from JtPreDict t where t.datePlanPri.rjhmId=?";
		if(type==0){
			hql+=" and t.recStas<4 and t.recStas!=0";
		}else{
			hql+=" and t.recStas=0";
		}
		Object obj=getHibernateTemplate().find(hql,rjhmId).get(0);
		return Integer.parseInt(obj+"");
	}
}
