package com.repair.plan.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.plan.dao.JcFixflowDao;

public class JcFixflowDaoImpl extends HibernateDaoSupport implements
		JcFixflowDao {

	@SuppressWarnings("unchecked")
	@Override
	public JCFixflow findJcFixFlowFirstByRepairs(String repairs, String jctype) {
		List<JCFixflow> fixflows = getHibernateTemplate().find("from JCFixflow as jff where jff.repairSeq like ? and jff.jcsTypeValue like ? order by nodeOrder asc", "%"+repairs+"%", "%"+jctype+",%");
		if (null != fixflows && !fixflows.isEmpty()) {
			return fixflows.get(0);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public JCFixflow findNextJcFixFlow(JCFixflow fixflow, DatePlanPri datePlanPri) {
		List<JCFixflow> jcFixflows = getHibernateTemplate().find("from JCFixflow where jcFlowId in (select jfr.jcFlowId from JCFixflow as jfr where jfr.nodeOrder>?) and repairSeq like ? and jcsTypeValue like ? order by nodeOrder asc", fixflow.getNodeOrder(), "%"+datePlanPri.getFixFreque()+"%", "%"+datePlanPri.getJcType()+",%");
		if (null != jcFixflows && !jcFixflows.isEmpty()) {
			return jcFixflows.get(0);
		}
		return null;
	}

}
