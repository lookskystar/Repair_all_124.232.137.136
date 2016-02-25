package com.repair.work.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.work.dao.SignWorkDao;

public class SignWorkDaoImpl extends AbstractDao implements SignWorkDao{

	@SuppressWarnings("unchecked")
	public List<DatePlanPri> findDyPlanJC(Long bzId, int nodeId) {
		//String hql = "select distinct r.datePlanPri from JCFlowRec r where r.proTeam.proteamid=? and (r.datePlanPri.planStatue=0 or r.datePlanPri.planStatue=1 or r.datePlanPri.planStatue=2) and r.fixflow.jcFlowId=? and r.datePlanPri.projectType=?";
		String hql="from DatePlanPri t where t.planStatue in (0,1,2) order by t.projectType,t.nodeid.jcFlowId";
		return getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	public List<DatePlanPri> findDyPlanJCByStatus(int rtype,Long userId){
		String hql = "from DatePlanPri t where (t.planStatue=0 or t.planStatue=1) and t.projectType=?";
//		if(rtype==2 || rtype==3||rtype==5){
//			hql += " and t.rjhmId in (select distinct c.dpId.rjhmId from JCChoice c where c.userId.userid="+userId+")";
//		}else{
//			hql += " and t.gongZhang.userid="+userId;
//		}
		return getHibernateTemplate().find(hql,Contains.XX_PROJECT_TYPE);
	}
	
	@SuppressWarnings("unchecked")
	public List<JCFixrec> listJCFixrec(Integer rjhmId,Long bzId,Short recStas){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCFixrec t where 1=1");
		if(bzId!=null){
			builder.append(" and t.banzuId=?");
			params.add(bzId);
		}
		if(recStas!=null){
			builder.append(" and t.recStas=?");
			params.add(recStas);
		}
		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<JCFixrec> listJCFixrec(Integer rjhmId,int roleType,Long userId,Integer signFlag){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCFixrec t where 1=1");
		if(roleType==2){
			builder.append(" and t.fixitem.thirdUnitId in (select c.fixitem.thirdUnitId from JCCharge c where c.user.userid=?)");//关联JCCharge
			params.add(userId);
			builder.append(" and t.fixitem.itemCtrlTech=1");
			if(signFlag==0){
				builder.append(" and t.recStas>=2 and t.tech is null");
			}
		}else if(roleType==3){
			builder.append(" and t.fixitem.thirdUnitId in (select c.fixitem.thirdUnitId from JCCharge c where c.user.userid=?)");//关联JCCharge
			params.add(userId);
			builder.append(" and t.fixitem.itemCtrlQI=1");
			if(signFlag==0){
				builder.append(" and t.qi is null and t.recStas>=2");
			}
		}else if(roleType==4){
			builder.append(" and t.fixitem.itemCtrlComLd=1");// and t.datePlanPri.gongZhang.userid=?
			if(signFlag==0){
				builder.append(" and t.commitLead is null  and t.recStas>=2");// and t.datePlanPri.gongZhang.userid=?
			}
//			params.add(userId);
		}else{
			builder.append(" and t.fixitem.itemCtrlAcce=1");
			if(signFlag==0){
				builder.append(" and t.accepter is null and t.recStas>=2");
			}
		}
		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<JCZXFixRec> listJCZXFixRec(Integer rjhmId,Long bzId,Short recStas){
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCZXFixRec t where 1=1");
		if(bzId!=null){
			builder.append(" and t.bzId=?");
			params.add(bzId);
		}
		if(recStas!=null){
			builder.append(" and t.recStas=?");
			params.add(recStas);
		}
		builder.append(" and t.dyPrecId.rjhmId=? and t.nodeId=? order by t.recStas");
		params.add(rjhmId);
		params.add(datePlan.getNodeid().getJcFlowId());
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<JCZXFixRec> listJCZXFixRec(Integer rjhmId,int roleType,Long userId,Integer signFlag){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCZXFixRec t where 1=1");
		if(roleType==2){
			builder.append(" and t.itemId.id in (select c.fixitem.id from JCCharge c where c.user.userid=?)");//关联JCCharge
			params.add(userId);
			builder.append(" and t.itemId.itemCtrlTech=1");
			if(signFlag==0){
				builder.append(" and t.recStas>=2 and t.teachName is null");
			}
		}else if(roleType==3){
			builder.append(" and t.itemId.id in (select c.fixitem.id from JCCharge c where c.user.userid=?)");//关联JCCharge
			params.add(userId);
			builder.append(" and t.itemId.itemCtrlQi=1");
			if(signFlag==0){
				builder.append(" and t.qi is null and t.recStas>=2");
			}
		}else if(roleType==4){
			builder.append(" and t.itemId.itemCtrlComld=1");// and t.datePlanPri.gongZhang.userid=?
			if(signFlag==0){
				builder.append(" and t.commitLead is null  and t.recStas>=2");// and t.datePlanPri.gongZhang.userid=?
			}
//			params.add(userId);
		}else{
			builder.append(" and t.itemId.itemCtrlAcce=1");
			if(signFlag==0){
				builder.append(" and t.acceptEr is null and t.recStas>=2");
			}
		}
		builder.append(" and t.dyPrecId.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	public Long countUnfinishJCFixRec(Integer rjhmId,Long bzId,Short recStas){
		String hql = "select count(t.jcRecId) from JCFixrec t where t.recStas<? and t.banzuId=? and t.datePlanPri.rjhmId=?";
		return (Long)getHibernateTemplate().find(hql, new Object[]{recStas,bzId,rjhmId}).get(0);
	}
	
	@SuppressWarnings("unchecked")
	public List<JCQZFixRec> listJCQZFixRec(Integer rjhmId,Long bzId,Short recStas){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCQZFixRec t where 1=1");
		if(bzId!=null){
			builder.append(" and t.bzId=?");
			params.add(bzId);
		}
		if(recStas!=null){
			builder.append(" and t.recStas=?");
			params.add(recStas);
		}
		builder.append(" and t.jcRecmId.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<JCQZFixRec> listJCQZFixRec(Integer rjhmId,int roleType,Integer signFlag,UsersPrivs user){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JCQZFixRec t where 1=1");
		if(roleType==2){
			if(signFlag==0){
				builder.append(" and t.tech is null and t.recStas>=2 and t.bzId in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
			}else{
				builder.append(" and t.bzId in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
			}
			params.add(user.getUserid());
		}else if(roleType==3){
			if(signFlag==0){
				builder.append(" and t.qi is null and t.recStas>=2 and t.bzId in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
			}else{
				builder.append(" and t.bzId in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
			}
			params.add(user.getUserid());
		}else if(roleType==4 && signFlag==0){
			builder.append(" and t.commitLead is null and t.recStas>=2");
		}else{
			if(signFlag==0){
				builder.append(" and t.accepter is null and t.recStas>=2");
			}
		}
		builder.append(" and t.jcRecmId.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	public Long countUnfinishJCQZFixRec(Integer rjhmId,Long bzId,Short recStas){
		Long count = null;
		Long pjNumCount = null;
		String hql = "select count(t.jcRecId) from JCQZFixRec t where t.recStas<? and t.bzId=? and t.jcRecmId.rjhmId=?";
		count = (Long)getHibernateTemplate().find(hql, new Object[]{recStas,bzId,rjhmId}).get(0);
		pjNumCount = (Long)getHibernateTemplate().find("select count(t.jcRecId) from JCQZFixRec t where t.recStas<? and t.bzId=? and t.jcRecmId.rjhmId=? and t.fixSituation='更换良好' and t.upPjNum is null", new Object[]{recStas,bzId,rjhmId}).get(0);
		return count+pjNumCount;
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listJtPreDict(Integer rjhmId,Long bzId,Short recStas,Short itemType){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JtPreDict t where 1=1 and t.recStas>=1");
		if(bzId!=null){
			builder.append(" and t.proTeamId.proteamid=?");
			params.add(bzId);
		}
		if(recStas!=null){
			builder.append(" and t.recStas=?");
			params.add(recStas);
		}
		if(itemType==Contains.LX_JG_TYPE){
			builder.append(" and t.type=?");
			params.add(Contains.LX_JG_TYPE);
		}else{
			builder.append(" and t.type<>?");
			params.add(Contains.LX_JG_TYPE);
		}
		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	//分班组的角色签认
//	@SuppressWarnings("unchecked")
//	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,Integer signFlag,Short itemType,UsersPrivs user){
//		StringBuilder builder = new StringBuilder();
//		List<Object> params = new ArrayList<Object>();
//		builder.append("from JtPreDict t where 1=1");
//		if(roleType==2){
//			if(signFlag==0){
//				builder.append(" and t.technician is null and t.recStas>=4 and t.proTeamId.proteamid in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
//			}else{
//				builder.append(" and t.proTeamId.proteamid in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
//			}
//			params.add(user.getUserid());
//		}else if(roleType==3){
//			if(signFlag==0){
//				builder.append(" and t.qi is null and t.recStas>=4 and t.proTeamId.proteamid in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
//			}else{
//				builder.append(" and t.recStas>=1 and t.proTeamId.proteamid in (select distinct c.proteamId.proteamid from JCCharge c where c.user.userid=?)");
//			}
//			params.add(user.getUserid());
//		}else if(roleType==4 && signFlag==0){
//			builder.append(" and t.commitLd is null and t.recStas>=4");
//		}else{
//			if(signFlag==0){
//				builder.append(" and t.accepter is null and t.recStas>=4");
//			}
//		}
//		if(signFlag!=0){
//			builder.append(" and t.recStas>=1");
//		}
//		if(itemType==Contains.LX_JG_TYPE){
//			builder.append(" and t.type=?");
//			params.add(Contains.LX_JG_TYPE);
//		}else{
//			builder.append(" and t.type<>?");
//			params.add(Contains.LX_JG_TYPE);
//		}
//		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
//		params.add(rjhmId);
//		return getHibernateTemplate().find(builder.toString(), params.toArray());
//	}
	
	//不分班组的角色签认
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,Integer signFlag,Short itemType,UsersPrivs user){
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from JtPreDict t where 1=1");
		if(roleType==2){
			if(signFlag==0){
				builder.append(" and t.technician is null and t.recStas>=4");
			}
			//params.add(user.getUserid());
		}else if(roleType==3){
			if(signFlag==0){
				builder.append(" and t.qi is null and t.recStas>=4");
			}else{
				builder.append(" and t.recStas>=1");
			}
			//params.add(user.getUserid());
		}else if(roleType==4 && signFlag==0){
			builder.append(" and t.commitLd is null and t.recStas>=4");
		}else{
			if(signFlag==0){
				builder.append(" and t.accepter is null and t.recStas>=4");
			}
		}
		if(signFlag!=0){
			builder.append(" and t.recStas>=1");
		}
		if(itemType==Contains.LX_JG_TYPE){
			builder.append(" and t.type=?");
			params.add(Contains.LX_JG_TYPE);
		}else{
			builder.append(" and t.type<>?");
			params.add(Contains.LX_JG_TYPE);
		}
		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
		params.add(rjhmId);
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	
	public Long countUnfinishJtPreDict(Integer rjhmId,Long bzId,Short recStas,Short itemType){
		Long count = null;
		Long countPjNum = null;
		String hql = "select count(t.preDictId) from JtPreDict t where t.recStas>1 and t.type=? and t.recStas<? and t.proTeamId.proteamid=? and t.datePlanPri.rjhmId=?";
		count = (Long)getHibernateTemplate().find(hql, new Object[]{itemType,recStas,bzId,rjhmId}).get(0);
		countPjNum = (Long)getHibernateTemplate().find("select count(t.preDictId) from JtPreDict t where t.recStas>1 and t.type=? and t.recStas<? and t.proTeamId.proteamid=? and t.datePlanPri.rjhmId=? and t.dealSituation='更换良好' and t.upPjNum is null", new Object[]{itemType,recStas,bzId,rjhmId}).get(0);
		return count+countPjNum;
	}

	@Override
	public Long countUnfinishJcFixrec(int roleType, Integer rjhmId, UsersPrivs usersPrivs) {
		Long count=null;
		Long countPjNum = 0L;
		List<Object> params = new ArrayList<Object>();
		StringBuilder builder = new StringBuilder();
		builder.append("select count(t.jcRecId) from JCFixrec t where 1=1");
		if(roleType==1){//工长 ---查看工人是否都签认完成
			builder.append(" and t.banzuId=? and t.datePlanPri.rjhmId=? and t.empAfformTime is null");
			params.add(usersPrivs.getBzid());
			//更换良好 未填编码记录
			countPjNum = (Long)getHibernateTemplate().find("select count(t.jcRecId) from JCFixrec t where t.banzuId=? and t.datePlanPri.rjhmId=? and t.fixSituation='更换良好' and t.upPjNum is null", new Object[]{usersPrivs.getBzid(), rjhmId}).get(0);
		}else if(roleType==2||roleType==3){//技术或者质检---查看工长是否都签认完成
			builder.append(" and t.fixitem.thirdUnitId in " +
			"(select c.fixitem.thirdUnitId from JCCharge c where c.user.userid=?) and t.datePlanPri.rjhmId=? and t.ldAffirmTime is null");
			params.add(usersPrivs.getUserid());
		}else if(roleType==5){//验收---查看技术或质检需要卡控项目是否都签认完成
			builder.append(" and t.datePlanPri.rjhmId=? and (t.fixitem.itemCtrlTech=1 or t.fixitem.itemCtrlQI=1) and t.qiAffiTime is null and t.techAffiTime is null");
		}
		params.add(rjhmId);
		count=(Long)getHibernateTemplate().find(builder.toString(),params.toArray()).get(0);
		return count+countPjNum;
	}
	
	@Override
	public Long countUnfinishJcZxFixrec(int roleType, Integer rjhmId, UsersPrivs usersPrivs) {
		Long count=null;
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		List<Object> params = new ArrayList<Object>();
		StringBuilder builder = new StringBuilder();
		builder.append("select count(t.id) from JCZXFixRec t where 1=1");
		if(roleType==1){//工长 ---查看工人是否都签认完成
			builder.append(" and t.bzId=? and t.dyPrecId.rjhmId=? and t.nodeId=? and (t.fixEmpTime is null or (t.itemId.itemCtrlRept=1 and t.reptAffirmTime is null))");
			params.add(usersPrivs.getBzid());
		}else if(roleType==2||roleType==3){//技术或者质检---查看工长是否都签认完成
			builder.append(" and t.fixitem.thirdUnitId in " +
			"(select c.fixitem.thirdUnitId from JCCharge c where c.user.userid=?) and t.datePlanPri.rjhmId=? and t.ldAffirmTime is null");
			params.add(usersPrivs.getUserid());
		}else if(roleType==5){//验收---查看技术或质检需要卡控项目是否都签认完成
			builder.append(" and t.datePlanPri.rjhmId=? and (t.fixitem.itemCtrlTech=1 or t.fixitem.itemCtrlQI=1) and t.qiAffiTime is null and t.techAffiTime is null");
		}
		params.add(rjhmId);
		params.add(datePlan.getNodeid().getJcFlowId());
		count=(Long)getHibernateTemplate().find(builder.toString(),params.toArray()).get(0);
		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> listNotChargeProTeam(Integer rjhmId) {
		String hql="from DictProTeam team where team.workflag=1 and exists (select t.banzuId from JCFixrec t where t.datePlanPri.rjhmId=? group by t.banzuId)";
//		String hql = "from DictProTeam team,JCFixrec t where team.proteamid=t.banzuId and team.workflag=1 and t.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql,rjhmId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> listZxNotChargeProTeam(Integer rjhmId) {
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		String hql="from DictProTeam team where team.zxFlag=1 and team.proteamid in (select t.bzId from JCZXFixRec t where t.dyPrecId.rjhmId=? and t.nodeId=? group by t.bzId)";
		return getHibernateTemplate().find(hql,new Object[]{rjhmId,datePlan.getNodeid().getJcFlowId()});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixrec> listNotChargeJCFixrec(int rjhmId,long bzId,UsersPrivs usersPrivs,int flag){
		String hql="";
		if(flag==0){//技术卡控
			hql="from JCFixrec t where t.banzuId=? and t.fixitem.itemCtrlTech=1 and t.datePlanPri.rjhmId=? and t.fixitem.thirdUnitId not in" +
			"(select t1.fixitem.thirdUnitId from JCCharge t1 where t1.proteamId.proteamid=? and t1.user.userid=?) order by t.recStas,t.fixitem.itemOrder";
		}else{
			hql="from JCFixrec t where t.banzuId=? and t.fixitem.itemCtrlQI=1 and t.datePlanPri.rjhmId=? and t.fixitem.thirdUnitId not in" +
			"(select t1.fixitem.thirdUnitId from JCCharge t1 where t1.proteamId.proteamid=? and t1.user.userid=?) order by t.recStas,t.fixitem.itemOrder";
		}
		
		return getHibernateTemplate().find(hql,new Object[]{bzId,rjhmId,bzId,usersPrivs.getUserid()});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCZXFixRec> listNotChargeJCZxFixrec(int rjhmId,long bzId,UsersPrivs usersPrivs,int flag){
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		String hql="";
		if(flag==0){//技术卡控
			hql="from JCZXFixRec t where t.bzId=? and t.itemId.itemCtrlTech=1 and t.dyPrecId.rjhmId=? and t.nodeId=? and t.itemId.id not in" +
			"(select t1.fixitem.id from JCCharge t1 where t1.proteamId.proteamid=? and t1.user.userid=?) order by t.recStas";
		}else{
			hql="from JCZXFixRec t where t.bzId=? and t.itemId.itemCtrlQi=1 and t.dyPrecId.rjhmId=? and t.nodeId=? and t.itemId.id not in" +
			"(select t1.fixitem.id from JCCharge t1 where t1.proteamId.proteamid=? and t1.user.userid=?) order by t.recStas";
		}
		
		return getHibernateTemplate().find(hql,new Object[]{bzId,rjhmId,datePlan.getNodeid().getJcFlowId(),bzId,usersPrivs.getUserid()});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCQZFixRec> listNotChargeJCQZFixRec(int rjhmId, long bzId) {
		String hql="from JCQZFixRec t where t.bzId=? and t.jcRecmId.rjhmId=? order by t.recStas";
		return getHibernateTemplate().find(hql,new Object[]{bzId,rjhmId});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> listNotChargeJtPreDict(int rjhmId, long bzId) {
		String hql="from JtPreDict t where t.proTeamId.proteamid=? and t.type=3 and t.datePlanPri.rjhmId=? order by t.recStas";
		return getHibernateTemplate().find(hql,new Object[]{bzId,rjhmId});
	}

	@Override
	public int countSignedByBz(int rjhmId, long bzId,int roleType) {
		int opt=0;
		//查询班组下要签认的所有项目
		String bzAllHql="";
		//查询班组下已经签认的项目
		String bzSignedHql="";
		if(roleType==2){//技术
			bzAllHql="select count(t.jcRecId) from JCFixrec t where t.fixitem.itemCtrlTech=1 and t.banzuId=? and t.datePlanPri.rjhmId=?";
			bzSignedHql="select count(t.jcRecId) from JCFixrec t where t.tech is not null and t.banzuId=? and t.datePlanPri.rjhmId=?";
		}else{//质检
			bzAllHql="select count(t.jcRecId) from JCFixrec t where t.fixitem.itemCtrlQI=1 and t.banzuId=? and t.datePlanPri.rjhmId=?";
			bzSignedHql="select count(t.jcRecId) from JCFixrec t where t.qi is not null and t.banzuId=? and t.datePlanPri.rjhmId=?";
		}
		long bzAllCount=(Long)getHibernateTemplate().find(bzAllHql,new Object[]{bzId,rjhmId}).get(0);
		long bzSignedCount=(Long)getHibernateTemplate().find(bzSignedHql,new Object[]{bzId,rjhmId}).get(0);
		if(bzAllCount==bzSignedCount){
			opt=1;
		}
		return opt;
	}
	
	@Override
	public int countZxSignedByBz(int rjhmId, long bzId,int roleType) {
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		int opt=0;
		//查询班组下要签认的所有项目
		String bzAllHql="";
		//查询班组下已经签认的项目
		String bzSignedHql="";
		if(roleType==2){//技术
			bzAllHql="select count(t.id) from JCZXFixRec t where t.itemId.itemCtrlTech=1 and t.bzId=? and t.nodeId=? and t.dyPrecId.rjhmId=?";
			bzSignedHql="select count(t.id) from JCZXFixRec t where t.teachName is not null and t.bzId=? and t.nodeId=? and t.dyPrecId.rjhmId=?";
		}else{//质检
			bzAllHql="select count(t.id) from JCZXFixRec t where t.itemId.itemCtrlQi=1 and t.bzId=? and t.nodeId=? and t.dyPrecId.rjhmId=?";
			bzSignedHql="select count(t.id) from JCZXFixRec t where t.qi is not null and t.bzId=? and t.nodeId=? and t.dyPrecId.rjhmId=?";
		}
		long bzAllCount=(Long)getHibernateTemplate().find(bzAllHql,new Object[]{bzId,datePlan.getNodeid().getJcFlowId(),rjhmId}).get(0);
		long bzSignedCount=(Long)getHibernateTemplate().find(bzSignedHql,new Object[]{bzId,datePlan.getNodeid().getJcFlowId(),rjhmId}).get(0);
		if(bzAllCount==bzSignedCount){
			opt=1;
		}
		return opt;
	}
	
	@Override
	/**
	 * 查找角色所处班组是否签认完成
	 * @return
	 */
	public Long countUnfinishRoleJcFixrec(int roleType, Integer rjhmId,long bzId){
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		StringBuilder builder = new StringBuilder();
		builder.append("select count(t.id) from JCZXFixRec t where t.bzId=? and t.dyPrecId.rjhmId=? and t.nodeId=?");
		if(roleType==1){//工长
			builder.append(" and t.comLdAffiTime is null");
		}else if(roleType==2||roleType==3){//质检或技术 (t.itemId.itemCtrlQi=1 or t.itemId.itemCtrlTech=1) and t.qiAffiTime is null and t.teachAffiTime is null
			builder.append(" and t.itemId.itemCtrlQi=1 and t.qiAffiTime is null");
		}else if(roleType==4){//交车工长
			builder.append(" and t.itemId.itemCtrlComld=1 and t.comLdAffiTime is null");
		}else if(roleType==5){//验收员
			builder.append(" and t.itemId.itemCtrlAcce=1 and t.acceAffiTime is null");
		}
		Long count=(Long)getHibernateTemplate().find(builder.toString(),new Object[]{bzId,rjhmId,datePlan.getNodeid().getJcFlowId()}).get(0);
		return count;
	}
	
	@Override
	public Long countUnfinishBzFixFlow(Integer rjhmId,int nodeId) {
		String hql="select count(t.jcFlowRecId) from JCFlowRec t where t.datePlanPri.rjhmId=? and t.fixflow.jcFlowId=? and t.finishStatus=0";
		return (Long)getHibernateTemplate().find(hql,new Object[]{rjhmId,nodeId}).get(0);
	}
	
	/**
	 * 统计角色未签项目( 2：技术 3:质检  4:交车工长 5：验收 )
	 */
	public long countNoSignItemOfRole(int rjhmId,int roleType){
		String hql = "select count(*) from JCFixrec t where t.datePlanPri.rjhmId=?";
		if(roleType==2){
			hql += " and t.itemCtrlTech=1 and t.tech is null";
		}else if(roleType==3){
			hql += " and t.itemCtrlQI=1 and t.qi is null";
		}else if(roleType==4){
			hql += " and t.itemCtrlComLd=1 and t.commitLead is null ";
		}else{
			hql += " and t.itemCtrlAcces=1 and t.accepter is null ";
		}
		return (Long) getHibernateTemplate().find(hql, rjhmId).get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findDyPlanJCBy(String jcNum, String projectType) {
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcnum =?");
			params.add(jcNum);
		}
		if(projectType != null && !projectType.equals("")){
			builder.append(" and t.projectType=?");
			params.add(Integer.valueOf(projectType));
		}
		builder.append(" and t.planStatue in (0,1,2) order by t.projectType, t.kcsj desc,t.jcType");
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findUnfinishedBz(int rjhmId, int roleType) {
		String sql=null;
		if(roleType==2){//技术
			sql="select t.proteam,dp.proteamname,sum(case when (t.itemctrltech=1 and t.tech is null) then 1 else 0 end) as count " +
					"from jc_fixrec t,dict_proteam dp where t.dyprecid=? and dp.proteamid=t.proteam " +
					"group by t.proteam,dp.proteamname order by t.proteam";
		}else{//质检
			sql="select t.proteam,dp.proteamname,sum(case when (t.itemctrlqi=1 and t.qi is null) then 1 else 0 end) as count " +
			"from jc_fixrec t,dict_proteam dp where t.dyprecid=? and dp.proteamid=t.proteam " +
			"group by t.proteam,dp.proteamname order by t.proteam";
		}
		
		return getSession().createSQLQuery(sql).setParameter(0, rjhmId).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]> findUnfinishedZXBz(int rjhmId,int roleType){
		String sql=null;
		if(roleType==2){//技术
			sql="select t.bzid,dp.proteamname,sum(case when (t.itemctrltech=1 and t.teachname is null) then 1 else 0 end) as count " +
					"from jc_zx_fixrec t,dict_proteam dp where t.dyprecid=? and dp.proteamid=t.bzid " +
					"group by t.bzid,dp.proteamname order by t.bzid";
		}else{//质检
			sql="select t.bzid,dp.proteamname,sum(case when (t.itemctrlqi=1 and t.qi is null) then 1 else 0 end) as count " +
			"from jc_zx_fixrec t,dict_proteam dp where t.dyprecid=? and dp.proteamid=t.bzid " +
			"group by t.bzid,dp.proteamname order by t.bzid";
		}
		
		return getSession().createSQLQuery(sql).setParameter(0, rjhmId).list();
	}

	@Override
	public Integer findRoleId(Long userId) {
		String sql = "select roleid from userrole_privs where userid="+userId;
		return Integer.parseInt(getSession().createSQLQuery(sql).uniqueResult()+"");
	}

	@Override
	public int findRoleSign(int roleId, int rjhmId) {
		String sql = "";
		// 查询质检员临修签认情况
		if (roleId == 1) {
			sql = "select count(*) from jt_predict where dateplanpri=" + rjhmId	+ " and qi is null and itemctrqi=1";
		}
		// 查询技术员临修签认情况
		if (roleId == 2) {
			sql = "select count(*) from jt_predict where dateplanpri=" + rjhmId	+ " and technician is null and itemctrltech=1";
		}
		// 查询交车工长临修签认情况
		if (roleId == 3) {
			sql = "select count(*) from jt_predict where dateplanpri=" + rjhmId	+ " and commitld is null and itemctrlcomld=1";
		}
		// 查询验收员临修签认情况
		if (roleId == 4) {
			sql = "select count(*) from jt_predict where dateplanpri=" + rjhmId	+ " and accepter is null and itemctrlacce=1";
		}
		return Integer.parseInt(getSession().createSQLQuery(sql).uniqueResult()	+ "");
	}
}
