package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.MonPlanPri;
import com.repair.common.util.Contains;
import com.repair.plan.dao.MonPlanPriDao;

public class MonPlanPriDaoImpl extends HibernateDaoSupport implements MonPlanPriDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<MonPlanPri> findMonDatePri() {
		return getHibernateTemplate().find("from MonPlanPri as mpp where mpp.projectType=? and mpp.status between 0 and 3 order by mpp.status asc, mpp.monPlanId desc",Contains.XX_PROJECT_TYPE);
	}
	
	@SuppressWarnings("unchecked")
	public List<MonPlanPri> findMonDatePri(Short status) {
		return getHibernateTemplate().find("from MonPlanPri as mpp where mpp.projectType=? and mpp.status=? order by mpp.status asc, mpp.monPlanId desc", new Object[]{Contains.XX_PROJECT_TYPE,status});
	}
	
	@Override
	public void saveOrUpdate(MonPlanPri monPlanPri) {
		getHibernateTemplate().saveOrUpdate(monPlanPri);
	}

	@Override
	public void deleteMonPlanPri(final Integer monPlanId) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("delete from MonPlanPri where monPlanId=:monPlanId");
				query.setParameter("monPlanId", monPlanId);
				return query.executeUpdate();
			}
		});
	}

	@Override
	public void deleteMonPlanPri(MonPlanPri monPlanPri) {
		getHibernateTemplate().delete(monPlanPri);
	}

	@Override
	public MonPlanPri findMonDatePriById(Integer monPlanId) {
		return getHibernateTemplate().get(MonPlanPri.class, monPlanId);
	}

	@Override
	public void updateStatus(final Integer monPlanId, final Short status) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update MonPlanPri as mpp set mpp.status=:status where mpp.monPlanId=:monPlanId");
				query.setParameter("monPlanId", monPlanId);
				query.setParameter("status", status);
				return query.executeUpdate();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MonPlanPri> queryMonPlanPri() {
		String hql="from MonPlanPri t order by t.fmtDate desc";
		return getHibernateTemplate().find(hql);
	}
}
