package com.repair.admin.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.admin.dao.JcManageDao;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;

public class JcManageDaoImpl extends AbstractDao implements JcManageDao{
	
	@Override
	public void saveOrUpdateJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		getHibernateTemplate().saveOrUpdate(jtRunKiloRec);
	}

	@Override
	public void delete(JtRunKiloRec jtRunKiloRec) {
		this.getHibernateTemplate().delete(jtRunKiloRec);
	}

	@Override
	public void update(JtRunKiloRec jtRunKiloRec) {
		this.getHibernateTemplate().update(jtRunKiloRec);
	}

	@Override
	public JtRunKiloRec getById(int id) {
		return this.getHibernateTemplate().get(JtRunKiloRec.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtRunKiloRec> list() {
		String hql = "from JtRunKiloRec jt order by jt.runId asc";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtRunKiloRec> listByJcType(String jcType) {
		String hql = "from JtRunKiloRec jt where jt.jcType = ? order by id asc";
		return getHibernateTemplate().find(hql,jcType);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtRunKiloRec> listByJcTypeAndJcNum(JtRunKiloRec jtRunKiloRec) {
		String hql = "from JtRunKiloRec jt where jt.jcType = ? and jt.jcNum=? order by id desc";
		return (List<JtRunKiloRec>)this.getHibernateTemplate().find(hql,jtRunKiloRec.getJcType(),jtRunKiloRec.getJcNum());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcStype> ListDictJcStype() {
		String hql = "from DictJcStype t";
		return getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	public PageModel<JtRunKiloRec> listJtRunKiloRec(String jcType, String jcNum) {
		StringBuilder builder=new StringBuilder();
		builder.append("from JtRunKiloRec t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(jcType != null && !jcType.equals("")){
			builder.append(" and t.jcType =?");
			params.add(jcType);
		}
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcNum=?");
			params.add(jcNum);
		}
		builder.append(" order by t.runId");
		return findPageModel(builder.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<DatePlanPri> listDatePlanPri(String jcType, String jcNum,
			String fixFreque) {
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where t.planStatue=0");
		List<Object> params=new ArrayList<Object>();
		if(jcType != null && !jcType.equals("")){
			builder.append(" and t.jcType=?");
			params.add(jcType);
		}
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcNum);
		}
		if(fixFreque != null && !fixFreque.equals("")){
			builder.append(" and t.fixFreque=?");
			params.add(fixFreque);
		}
		builder.append(" order by t.rjhmId, t.rjhmId");
		return findPageModel(builder.toString(),params.toArray());
	}
	
	
	@Override
	public String deleteJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		String result = "";
		try {
			this.getHibernateTemplate().delete(jtRunKiloRec);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "failure";
		}
		return result;
	}

	@Override
	public JtRunKiloRec queryJtRunKiloRecById(long runId) {
		String hql = "from JtRunKiloRec t where t.runId=?";
		return (JtRunKiloRec) this.getSession().createQuery(hql).setLong(0, runId).uniqueResult();
	}
	
	@Override
	public JtRunKiloRec listJtRunKiloRecOnly(String jctype, String jcnum) {
		String hql = "from JtRunKiloRec t where t.jcType=? and t.jcNum=?";
		return (JtRunKiloRec) this.getSession().createQuery(hql).setString(0, jctype).setString(1, jcnum).uniqueResult();
	}

	@Override
	public void deleteRepairjc(Long rjhmId) {
		String hql = "delete from DatePlanPri d where d.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
		hql = "delete from JCFixrec d where d.datePlanPri.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
		hql = "delete from JCZXFixRec d where d.dyPrecId.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
		hql = "delete from JcExpRec d where d.dypRecId.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
		hql = "delete from JtPreDict d where d.datePlanPri.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
		hql = "delete from YSJCRec d where d.datePlanPri.rjhmId=?";
		getSession().createQuery(hql).setLong(0, rjhmId).executeUpdate();
	}

	
}
