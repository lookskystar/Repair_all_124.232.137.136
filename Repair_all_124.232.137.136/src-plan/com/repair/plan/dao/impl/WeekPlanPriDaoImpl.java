package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.WeekPlanPri;
import com.repair.common.util.Contains;
import com.repair.plan.dao.WeekPlanPriDao;

public class WeekPlanPriDaoImpl extends HibernateDaoSupport implements
		WeekPlanPriDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<WeekPlanPri> findWeekPlanPriByImplement() {
		return getHibernateTemplate().find("from WeekPlanPri as wpp where wpp.projectType=? and wpp.status between 0 and 1 order by wpp.status asc, wpp.weekPriId desc",Contains.XX_PROJECT_TYPE);
	}

	@Override
	public WeekPlanPri findWeekPlanPriById(Integer weekPriId) {
		return getHibernateTemplate().get(WeekPlanPri.class, weekPriId);
	}

	@Override
	public void saveOrUpdate(WeekPlanPri weekPlanPri) {
		getHibernateTemplate().saveOrUpdate(weekPlanPri);
	}

	@Override
	public void delete(WeekPlanPri weekPlanPri) {
		getHibernateTemplate().delete(weekPlanPri);
	}

	@Override
	public void updateStatus(final Integer weekPriId, final Short status) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update WeekPlanPri as wpp set wpp.status=:status where wpp.weekPriId=:weekPriId");
				query.setParameter("weekPriId", weekPriId);
				query.setParameter("status", status);
				return query.executeUpdate();
			}
		});
	}
}
