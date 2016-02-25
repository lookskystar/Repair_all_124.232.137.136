package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.MonPlanRecorder;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;
import com.repair.plan.dao.MonPlanRecorderDao;

public class MonPlanRecorderDaoImpl extends AbstractDao implements MonPlanRecorderDao {

	@Override
	public void saveOrUpdate(MonPlanRecorder monPlanRecorder) {
		getHibernateTemplate().saveOrUpdate(monPlanRecorder);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MonPlanRecorder> findMonPlanRecorders(Integer monPlanId) {
		return getHibernateTemplate().find("from MonPlanRecorder as mpr where mpr.monPlanId.monPlanId=?", monPlanId);
	}

	@Override
	public MonPlanRecorder findMonPlanRecorderById(Long monPrecId) {
		return getHibernateTemplate().get(MonPlanRecorder.class, monPrecId);
	}

	@Override
	public void deleteMonPlanRecorder(MonPlanRecorder planRecorder) {
		getHibernateTemplate().delete(planRecorder);
	}

	@Override
	public void updateMonPlanRecorderByMonPlan(final Integer monPlanId, final Short beforeStatus, final Short afterStatus) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update MonPlanRecorder as mpr set mpr.planStatus=:afterStatus where mpr.planStatus=:beforeStatus and mpr.monPlanId.monPlanId=:monPlanId");
				query.setParameter("monPlanId", monPlanId);
				query.setParameter("afterStatus", afterStatus);
				query.setParameter("beforeStatus", beforeStatus);
				return query.executeUpdate();
			}
		});
	}
	
	public void updateMonPlanRecorderStatusByIds(final Long[] monPrecIds, final Short status) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update MonPlanRecorder as mpr set mpr.planStatus=:status where mpr.monPrecId in (:monPrecIds)");
				query.setParameter("status", status);
				query.setParameterList("monPrecIds", monPrecIds);
				return query.executeUpdate();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<MonPlanRecorder> queryMonPlanRecorders(Integer monPlanId) {
		String hql="from MonPlanRecorder t where 1=1";
		List<Object> params=new ArrayList<Object>();
		if(monPlanId!=null&&monPlanId!=0){
			hql+=" and t.monPlanId.monPlanId=?";
			params.add(monPlanId);
		}
		return findPageModel(hql,params.toArray());
	}
}
