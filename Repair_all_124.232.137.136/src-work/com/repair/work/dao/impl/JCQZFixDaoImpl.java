package com.repair.work.dao.impl;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.work.dao.JCQZFixDao;

public class JCQZFixDaoImpl extends AbstractDao implements JCQZFixDao{
	
	@SuppressWarnings("unchecked")
	public List<JCQZItems> getJCQZFix(String jcfix,Long bzId,String jcstype){
		String hql = "from JCQZItems t where t.jcsType=? and t.xiuci=? and t.banzuId.proteamid=?";
		return getHibernateTemplate().find(hql, new Object[]{jcstype,jcfix,bzId});
	}
	
	public JCQZFixRec getJCQZFixRec(long jcRecId){
		return getHibernateTemplate().get(JCQZFixRec.class, jcRecId);
	}
	
	public void deleteJCQZFixRec(JCQZFixRec jcqzFixRec){
		getHibernateTemplate().delete(jcqzFixRec);
	}
	
	@SuppressWarnings("unchecked")
	public List<DatePlanPri> listMyJCQZFix(long userId){
		String hql = "select distinct t.jcRecmId from JCQZFixRec t where t.jcRecmId.planStatue=0 and t.workerId like '%,'||?||',%' ";
		return getHibernateTemplate().find(hql,userId);
	}
	
	public List<JCQZFixRec> listMyJCQZFixRec(int rjhmId,UsersPrivs user,Short itemType,Integer signFlag,boolean flag){
		String hql = null;
		if(flag){
			hql = "from JCQZFixRec t where t.workerId like '%,'||?||',%' ";
		}else{
			hql = "from JCQZFixRec t where t.workerId not like '%,'||?||',%' and t.bzId="+user.getBzid();
		}
		if(signFlag==0){
			hql += " and ( t.fixEmp not like '%,"+user.getXm()+",%' or t.fixEmp is null)";
		}
		hql += " and t.itemType=?  and t.jcRecmId.rjhmId=?";
		return getHibernateTemplate().find(hql,new Object[]{user.getUserid(),itemType,rjhmId});
	}
	
	public void updateJCQZFixRec(JCQZFixRec jcqzFixRec){
		getHibernateTemplate().update(jcqzFixRec);
	}
}
