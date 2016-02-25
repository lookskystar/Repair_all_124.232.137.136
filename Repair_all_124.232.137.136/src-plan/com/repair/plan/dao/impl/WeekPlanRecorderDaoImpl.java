package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.WeekPlanRecorder;
import com.repair.plan.dao.WeekPlanRecorderDao;

public class WeekPlanRecorderDaoImpl extends HibernateDaoSupport implements
		WeekPlanRecorderDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<WeekPlanRecorder> findWeekPlanRecorderByWeekPlan(
			Integer weekPriId) {
		return getHibernateTemplate().find("from WeekPlanRecorder as wpr where wpr.wekPriId.weekPriId=?", weekPriId);
	}

	@Override
	public WeekPlanRecorder findWeekPlanPriById(Long wekPriId) {
		return getHibernateTemplate().get(WeekPlanRecorder.class, wekPriId);
	}

	@Override
	public void deleteWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder) {
		getHibernateTemplate().delete(weekPlanRecorder);
	}

	@Override
	public void saveOrUpdate(WeekPlanRecorder weekPlanRecorder) {
		getHibernateTemplate().saveOrUpdate(weekPlanRecorder);
	}

	@Override
	public void updateWeekPlanRecorderByWeekPlan(final Integer weekPriId,
			final Short status) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update WeekPlanRecorder as wpr set wpr.planStatus=:status where wpr.wekPriId.weekPriId=:weekPriId");
				query.setParameter("weekPriId", weekPriId);
				query.setParameter("status", status);
				return query.executeUpdate();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WeekPlanRecorder> findWeekPlanRecordersByStatus(Short status) {
		return getHibernateTemplate().find("from WeekPlanRecorder as wpr where wpr.planStatus=?", status);
	}

	@Override
	public void updateStatusByTrain(final String jcType, final String jcNum,
			final String fixFreque, final Short status) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("update WeekPlanRecorder set planStatus=:status where jcType=:jcType and jcNum=:jcNum and fixFreque=:fixFreque");
				query.setParameter("jcType", jcType);
				query.setParameter("jcNum", jcNum);
				query.setParameter("fixFreque", fixFreque);
				query.setParameter("status", status);
				return query.executeUpdate();
			}
		});
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WeekPlanRecorder> queryWeekPlanRecorder(Integer monPlanId, Short planType) {
		String hql=null;
		List<Object> params=new ArrayList<Object>();
		if(monPlanId!=null&&planType!=null){
		    hql="from WeekPlanRecorder wpr where wpr.wekPriId.weekPriId in (select wpp.weekPriId from WeekPlanPri wpp where wpp.monPlanId.monPlanId=? and wpp.planType=?)";
		    params.add(monPlanId);
		    params.add(planType);
		}else{
			hql="from WeekPlanRecorder where rownum<=30 order by wekPrecId";
		}
		return getHibernateTemplate().find(hql,params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MainPlanDetail> findMainPlanDetailByStatusAndTime() {
		String sql ="select mpd.* from MainPlanDetail mpd,MainPlan mp where mpd.mainplanid=mp.id and mp.status=1 and mpd.isCash=0 and " +
				"mpd.plantime >=(to_char(trunc(sysdate, 'd') + 1,'yyyy-mm-dd')) and mpd.plantime <=(to_char(trunc(sysdate, 'd') + 7,'yyyy-mm-dd'))";
		return getSession().createSQLQuery(sql).addEntity(MainPlanDetail.class).list();
	}
	
	@SuppressWarnings("unchecked")
	public MainPlanDetail findTimeByDatePlan(Long detailId){
		return getHibernateTemplate().get(MainPlanDetail.class, detailId);
	}
	
	@Override
	public void updateStatusByDatePlan(Long mainPlanDetaiId,Integer status, DatePlanPri datePlan) {
		String hql="update MainPlanDetail t set t.isCash=?, t.rjhmId=? where t.id=?";
		getSession().createQuery(hql).setInteger(0, status).setInteger(1, datePlan.getRjhmId()).setLong(2, mainPlanDetaiId).executeUpdate();
	}
	
	public void updateStatusBydeleteDatePlan(Integer rjhmid){
		String hql="update MainPlanDetail t set t.isCash=0,t.rjhmId=null where t.rjhmId=?";
		getSession().createQuery(hql).setInteger(0, rjhmid).executeUpdate();
	}
}
