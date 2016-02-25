package com.repair.plan.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.util.Contains;
import com.repair.plan.dao.JcFlowRecDao;

public class JcFlowRecDaoImpl extends HibernateDaoSupport implements
		JcFlowRecDao {
	
	@Override
	public void saveOrUpdate(JCFlowRec flowRec) {
		getHibernateTemplate().saveOrUpdate(flowRec);
	}

	public void saveJcFixRec(DatePlanPri datePlanPri) {

		String sql = "insert into jc_fixrec(jcrecid,jwdcode,dyprecid,jcnum,jctype,thirdunitid,itemname,recstas,proteam,fixempid,itemtype,duration,FIRSTUNITID,UNITNAME,SECUNITNAME,POSINAME,UNIT,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE)"
				+ " select SEQ_JCFIXREC.NEXTVAL,t.jwdcode,"
				+datePlanPri.getRjhmId()+",'"+datePlanPri.getJcnum()+"','"+datePlanPri.getJcType()+"',t.thirdunitid,t.itemname,0,"
				+"t.proteam,b.fixempids,(case when t.filldefaval is null then 1 else 0 end),t.duration,t.FIRSTUNITID,t.UNITNAME,t.SECUNITNAME,t.POSINAME,t.UNIT,t.ITEMCTRLLEAD,t.ITEMCTRLCOMLD,t.ITEMCTRLQI,t.ITEMCTRLTECH,t.ITEMCTRLACCE"
				+ " from jc_fixitem t,preset_relateid a,proset_division b where t.thirdunitid=a.fixitem(+) and a.prosetid=b.prosetid and t.nodeid="+Contains.XX_JX_NODEID+" and b.jcvalue='"
				+datePlanPri.getJcType()+"' and t.xiuci like '%,"+datePlanPri.getFixFreque()+",%'";
		getSession().createSQLQuery(sql).executeUpdate();
	}
	
	public void saveJcFixRec(DatePlanPri datePlanPri, int noteid) {

		String sql = "insert into jc_zx_fixrec(id,jwdcode,dyprecid,jcnum,jctype,ITEMID,itemname,recstas,BZID,fixempid,itemtype,NODEID,duration,UNIT,POSINAME,FIRSTUNITID,UNITNAME,ITEMCTRLLEAD,ITEMCTRLCOMLD,ITEMCTRLQI,ITEMCTRLTECH,ITEMCTRLACCE,ITEMCTRLREPT)"
				+ " select SEQ_JCZXFIXREC.NEXTVAL,t.jwdcode,"
				+datePlanPri.getRjhmId()+",'"+datePlanPri.getJcnum()+"','"+datePlanPri.getJcType()+"',t.id,t.itemname,0,"
				+"t.proteam,b.fixempids,(case when t.filldefaval is null then 1 else 0 end),"+noteid+",t.duration,t.UNIT,t.POSINAME,t.FIRSTUNITID,t.UNITNAME,t.ITEMCTRLLEAD,t.ITEMCTRLCOMLD,t.ITEMCTRLQI,t.ITEMCTRLTECH,t.ITEMCTRLACCE,t.ITEMCTRLREPT"
				+ " from jc_zx_fixitem t,preset_relateid a,proset_division b where t.id=a.THIRDUNITID(+) and a.prosetid=b.prosetid and t.nodeid="+noteid+" and b.jcValue='"
				+datePlanPri.getJcType()+"' and t.XCXC like '%,"+datePlanPri.getFixFreque()+",%'";
		getSession().createSQLQuery(sql).executeUpdate();
	}

	@Override
	public Long countUnfinishRec(int rjhmId, int nodeId) {
		String hql = "select count(t.jcFlowRecId) from JCFlowRec t where t.finishStatus=0 and t.fixflow.jcFlowId=? and  t.datePlanPri.rjhmId=?";
		return (Long) getHibernateTemplate().find(hql,
				new Object[] { nodeId, rjhmId }).get(0);
	}

	@Override
	public JCFlowRec getJCFlowRec(int rjhmId, long bzId, int nodeId) {
		String hql = "from JCFlowRec t where t.proTeam.proteamid=? and t.fixflow.jcFlowId=? and t.datePlanPri.rjhmId=?";
		return (JCFlowRec) getHibernateTemplate().find(hql,
				new Object[] { bzId, nodeId, rjhmId }).get(0);
	}
	
	public void updateJcFixRecProteam(int rjhmId,Long proteamId){
		String hql="update JCFixrec t set t.banzuId=? where t.datePlanPri.rjhmId=?";
		getSession().createQuery(hql).setLong(0, proteamId).setInteger(1, rjhmId).executeUpdate();
	}
	
	public void updateJcFixRecProteam(int rjhmId,Long proteamId,List<Long> workTeamList){
		String hql="update JCFixrec t set t.banzuId=:banzuId where t.datePlanPri.rjhmId=:rjhmId and t.banzuId not in(:workTeams)";
		getSession().createQuery(hql).setLong("banzuId", proteamId).setInteger("rjhmId", rjhmId).setParameterList("workTeams", workTeamList).executeUpdate();
	}

	@Override
	public Long countJcFixItemByBZ(DatePlanPri datePlanPri, Long proteamId) {
		String hql="select count(t.thirdUnitId) from JCFixitem t where t.jcsType like ? and t.xcxc like ? and t.banzuId.proteamid=?";
		return (Long) getHibernateTemplate().find(hql,
				new Object[] { "%"+datePlanPri.getJcType()+",%", "%,"+datePlanPri.getFixFreque()+",%",proteamId}).get(0);
				
	}
	
	@Override
	public Long countFixRecByPlanId(int rjhmId,int projectType){
		String hql=null;
		if(projectType==Contains.XX_PROJECT_TYPE){
			hql="select count(t.jcRecId) from JCFixrec t where t.datePlanPri.rjhmId=?";
		}else if(projectType==Contains.ZX_PROJECT_TYPE){
			hql="select count(t.id) from JCZXFixRec t where t.dyPrecId.rjhmId=?";
		}
		return (Long) getHibernateTemplate().find(hql,rjhmId).get(0);
	}

}
