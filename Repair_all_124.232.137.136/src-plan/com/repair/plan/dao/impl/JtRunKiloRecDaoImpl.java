package com.repair.plan.dao.impl;

import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JGPlanContent;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.plan.dao.JtRunKiloRecDao;

public class JtRunKiloRecDaoImpl extends HibernateDaoSupport implements JtRunKiloRecDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<JtRunKiloRec> findJtRunKiloRec() {
		return getHibernateTemplate().find("from JtRunKiloRec");
	}

	@Override
	public JtRunKiloRec findJtRunKiloRecById(Long runKiloRecId) {
		return getHibernateTemplate().get(JtRunKiloRec.class, runKiloRecId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcStype> findDictJcStype() {
		return getHibernateTemplate().find("from DictJcStype");
	}

	@Override
	public List listJGPlanContent() {
		StringBuilder builder = new StringBuilder();
		builder
		.append("select  b.jc_type as JCTYPE, " 
				+"(select count(runId) from jt_runkilorec j where j.jctype=b.jc_type) as ALLCOUNT,"
				+"b.jg_content as JGCONTENT," 
				+"b.plan_num as PLANNUM,"
				+"(select count(f.predictid) from dateplan_pri a,jt_predict f where a.rjhmid=f.dateplanpri and f.repsituation=b.jg_content and a.jctype=b.jc_type and f.type=3) as SJNUM"
				+"  from jg_plan_content b  order by b.jc_type");
		List list = getSession().createSQLQuery(builder.toString()).addScalar("JCTYPE", Hibernate.STRING)
				.addScalar("ALLCOUNT", Hibernate.LONG).addScalar("JGCONTENT",
						Hibernate.STRING).addScalar("PLANNUM", Hibernate.LONG)
				.addScalar("SJNUM", Hibernate.LONG).list();
		return list;
	}

	@Override
	public List listJGPlan(String jgContent, String jcType) {
		StringBuilder builder = new StringBuilder();
		builder
		.append("select  a.kcsj as Date,b.jc_type as JCTYPE,a.jcnum as JCNUM,a.comments as COMMENTS  " +
				"  from dateplan_pri a,jt_predict f,jg_plan_content b " +
				"  where a.rjhmid=f.dateplanpri and f.repsituation=b.jg_content and a.jctype=b.jc_type ");
		if(jgContent!=null){
			builder.append(" and b.jg_content ="+jgContent);
		}
		if (jcType != null && !jcType.equals("")) {
			builder.append(" and b.jc_type=" + jcType);
		}
		
		List list = getSession().createSQLQuery(builder.toString()).addScalar("Date", Hibernate.STRING)
				.addScalar("JCTYPE", Hibernate.STRING).addScalar("JCNUM",
						Hibernate.STRING).addScalar("COMMENTS", Hibernate.STRING).list();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> findJcTypes() {
		return getHibernateTemplate().find("select distinct j.jcType from JtRunKiloRec j");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> findJgItems() {
		return getHibernateTemplate().find("select distinct j.jgContent from JGPlanContent j");
	}

	@Override
	public void saveJgItem(JGPlanContent jPlan) {
		getHibernateTemplate().save(jPlan);
	}

	@Override
	public void saveItemDatePlan(DatePlanPri datePlanPri) {
		getHibernateTemplate().save(datePlanPri);
	}

	@Override
	public void saveItemJtPreDict(JtPreDict jtPreDict) {
		getHibernateTemplate().save(jtPreDict);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List findJgByitem(String content) {
		String hql = "from JGPlanContent jt where jt.jgContent = ? order by jt.jcType";
		return getHibernateTemplate().find(hql,content);
	}

	@Override
	public String deleteJGPlanContent(JGPlanContent content) {
		String result = "";
		try {
			this.getHibernateTemplate().delete(content);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "failure";
		}
		return result;
	}

	public String updateJgItem(JGPlanContent jPlan){
		String result = "";
		try{
			String hql = "update JGPlanContent t set t.jgContent=:jgContent,t.planNum=:planNum where t.id=:id";
			getSession().createQuery(hql).setString("jgContent", jPlan.getJgContent()).setInteger("planNum", jPlan.getPlanNum()).setLong("id", jPlan.getId()).executeUpdate();
			result = "success";
		} catch(Exception e) {
			e.printStackTrace();
			result = "failure";
		}
		return result;
	}
	
	
	public String updateJgItemById(JGPlanContent jPlan){
		String result = "";
		try{
			String hql = "update JGPlanContent t set t.planNum=:planNum where t.id=:id";
			getSession().createQuery(hql).setInteger("planNum", jPlan.getPlanNum()).setLong("id", jPlan.getId()).executeUpdate();
			result = "success";
		} catch(Exception e) {
			e.printStackTrace();
			result = "failure";
		}
		return result;
	}
	
	
	@Override
	public List editeJGPlanContent() {
		StringBuilder builder = new StringBuilder();
		builder
		.append("select  b.id as JGID,b.jc_type as JCTYPE, " 
				+"(select count(runId) from jt_runkilorec j where j.jctype=b.jc_type) as ALLCOUNT,"
				+"b.jg_content as JGCONTENT," 
				+"b.plan_num as PLANNUM,"
				+"(select count(f.predictid) from dateplan_pri a,jt_predict f where a.rjhmid=f.dateplanpri and f.repsituation=b.jg_content and a.jctype=b.jc_type and f.type=3) as SJNUM"
				+"  from jg_plan_content b");
		List list = getSession().createSQLQuery(builder.toString()).addScalar("JGID", Hibernate.STRING).addScalar("JCTYPE", Hibernate.STRING)
				.addScalar("ALLCOUNT", Hibernate.LONG).addScalar("JGCONTENT",
						Hibernate.STRING).addScalar("PLANNUM", Hibernate.LONG)
				.addScalar("SJNUM", Hibernate.LONG).list();
		return list;
	}

	@Override
	public List findJcAcounts() {
		String hql = "select j.jcType,count(j.jcType) from jt_runkilorec j group by j.jcType order by j.jcType";
		return getSession().createSQLQuery(hql).list();
	}

	@Override
	public List findJcItemAcount() {
		String sql = "select t.jg_content,t.jc_type,t.plan_num,(select count(b.predictid) from dateplan_pri a,jt_predict b where a.rjhmid=b.dateplanpri and b.repsituation=t.jg_content and a.jctype=t.jc_type and a.fixfreque='JG' and b.type=3) as sjcount,t.id as jgid from jg_plan_content t order by t.jg_content,t.jc_type";
		return getSession().createSQLQuery(sql).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List findJcItemList(String itemName, String jctype) {
		String sql = "select d.jctype,d.jcnum,d.comments,d.sjjcsj,d.rjhmid from dateplan_pri d where 1=1";
		if(jctype!=null && !"".equals(jctype)){
			sql += " and d.jctype ='"+jctype+"'";
		}
		if(itemName!=null && !"".equals(itemName)){
			sql += " and d.rjhmid in (select j.dateplanpri from jt_predict j where j.repsituation ='"+itemName+"' and j.type=3)";
		}
		sql += " and d.fixfreque='JG'";
		return getSession().createSQLQuery(sql).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public long findJGPlanContent(String item) {
		String hql = "select count(*) from JGPlanContent j where j.jgContent='"+item+"'";
		return (Long)getSession().createQuery(hql).uniqueResult();
	}	
}
