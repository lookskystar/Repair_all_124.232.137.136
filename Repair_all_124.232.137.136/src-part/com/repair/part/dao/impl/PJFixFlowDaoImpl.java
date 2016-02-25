package com.repair.part.dao.impl;

import java.util.LinkedHashMap;
import java.util.List;


import com.repair.part.dao.PJFixFlowDao;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PJFixFlow;
import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.util.DaoManageSupport;
import com.repair.common.util.PageModel;

public class PJFixFlowDaoImpl extends DaoManageSupport implements PJFixFlowDao {

	@Override
	public List<PJFixFlow> findPJFixFlowListByFlowType(int flowTypeId) {
		String hql = "from PJFixFlow flow where flow.pjFixFlowType.flowTypeId=? order by flow.nodeOrder asc";
		return getHibernateTemplate().find(hql, flowTypeId);
	}

	@Override
	public List<DictProTeam> findFixFlowTeam(Long pjsid, Long nodeId) {
		String hql = "select distinct item.team from PJFixItem item where item.pjStaticInfo.pjsid=? and item.pjFixFlow.nodeId=?";
		return getHibernateTemplate().find(hql, new Object[]{pjsid,nodeId});
	}
	
	@Override
	public List<DictProTeam> findFixFlowTeam(Long pjsid) {
		String hql = "select distinct item.team from PJFixItem item where item.pjStaticInfo.pjsid=?";
		return getHibernateTemplate().find(hql, new Object[]{pjsid});
	}
	
	@Override
	public void savePJFixFlowRecord(PJFixFlowRecord flowRecord) {
		getHibernateTemplate().save(flowRecord);
	}
	
	@Override
	public PageModel findPageModelPJFixFlowRecordByBZId(long teamId) {
		String wherehql =  "status=0 and team.proteamid=?";
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("recId", "asc");
		return getScrollData(PJFixFlowRecord.class, wherehql, new Object[]{teamId}, orderby);
	}
	
	@Override
	public PJFixFlowRecord getPJFixFlowRecordById(Long flowRecId) {
		return getHibernateTemplate().get(PJFixFlowRecord.class, flowRecId);
	}
	
	
	@Override
	public void updatePJFixFlowRecord(PJFixFlowRecord fixFlowRecord) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(fixFlowRecord);
	}
	
	@Override
	public List<PJFixFlowRecord> findPJFixFlowRecordListByFlowId(PJFixFlowRecord flowRec) {
		String hql = "from PJFixFlowRecord ffrec where ffrec.pjFixFlow.nodeId=? and ffrec.pjDynamicInfo.pjdid=? and ffrec.datePlan.planId=?";
		return getHibernateTemplate().find(hql, new Object[]{flowRec.getPjFixFlow().getNodeId(),flowRec.getPjDynamicInfo().getPjdid(),flowRec.getDatePlan().getPlanId()});
	}
	
}
