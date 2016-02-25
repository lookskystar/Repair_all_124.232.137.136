package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.plan.dao.DatePlanPriDao;

public class DatePlanPriDaoImpl extends AbstractDao implements DatePlanPriDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findDatePlanPriByStatus(Integer status) {
		return getHibernateTemplate().find("from DatePlanPri as dpp where dpp.planStatue<? and dpp.projectType=?", new Object[]{status,Contains.XX_PROJECT_TYPE});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findDatePlanPriByInRepair() {
		return getHibernateTemplate().find("from DatePlanPri as dpp where dpp.planStatue=-1 or dpp.planStatue=0 and dpp.projectType=? order by dpp.planStatue asc, dpp.rjhmId desc",Contains.XX_PROJECT_TYPE);
	}

	@Override
	public void saveOrUpdate(DatePlanPri datePlanPri) {
		getHibernateTemplate().saveOrUpdate(datePlanPri);
	}

	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return getHibernateTemplate().get(DatePlanPri.class, rjhmId);
	}

	@Override
	public boolean isJcFixRecByDatePlanPri(final Integer rjhmId) {
		return getHibernateTemplate().execute(new HibernateCallback<Boolean>() {

			@Override
			public Boolean doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("select count(*) from JCFixrec as jfr where jfr.datePlanPri.rjhmId=:rjhmId");
				query.setParameter("rjhmId", rjhmId);
				Long result = (Long) query.uniqueResult();
				if (result>0) {
					return true;
				}
				return false;
			}
		});
	}

	@Override
	public void delete(DatePlanPri datePlanPri) {
		getHibernateTemplate().delete(datePlanPri);
	}

	@Override
	public void merge(DatePlanPri datePlanPri) {
		getHibernateTemplate().merge(datePlanPri);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findDatePlanPriByFroeman(UsersPrivs usersPrivs) {
		return getHibernateTemplate().find("from DatePlanPri as dpp where dpp.planStatue=-1 and dpp.projectType=? and (dpp.gongZhang.userid=? or  dpp.gongZhang is null)", new Object[]{Contains.XX_PROJECT_TYPE,usersPrivs.getUserid()});
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDict(final Long proteamid) {
		return getHibernateTemplate().execute(new HibernateCallback<List<DatePlanPri>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<DatePlanPri> doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = null;
				if (proteamid != null) {
					query = session.createSQLQuery("select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue between 0 and 1 and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.RECSTAS between 1 and 2 and jpd.TYPE!=3 and jpd.PROTEAMID=:proteamid group by dpp.RJHMID)").addEntity(DatePlanPri.class);
					query.setParameter("proteamid", proteamid).setParameter("projectType", Contains.XX_PROJECT_TYPE);
					
				} else {
					query = session.createSQLQuery("select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue between 0 and 1 and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.RECSTAS between 0 and 2 and jpd.TYPE!=3 group by dpp.RJHMID)").addEntity(DatePlanPri.class);
					query.setParameter("projectType", Contains.XX_PROJECT_TYPE);
				}
				return query.list();
			}
		});
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDict(final Long proteamid,
			final Short status) {
		return getHibernateTemplate().execute(new HibernateCallback<List<DatePlanPri>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<DatePlanPri> doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = null;
				if (proteamid != null) {
					if(status==3){
						query = session.createSQLQuery("select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue between 0 and 1 and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.RECSTAS>=2 and jpd.TYPE!=3 and jpd.PROTEAMID=:proteamid group by dpp.RJHMID)").addEntity(DatePlanPri.class);
						query.setParameter("proteamid", proteamid).setParameter("projectType", Contains.XX_PROJECT_TYPE);
					}else{
						query = session.createSQLQuery("select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue between 0 and 1 and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.RECSTAS=:status and jpd.TYPE!=3 and jpd.PROTEAMID=:proteamid group by dpp.RJHMID)").addEntity(DatePlanPri.class);
						query.setParameter("proteamid", proteamid).setParameter("projectType", Contains.XX_PROJECT_TYPE);
						query.setParameter("status", status);
					}
				
				} else {
					query = session.createSQLQuery("select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue between 0 and 1 and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.RECSTAS=:status and jpd.TYPE!=3 and jpd.PROTEAMID is null group by dpp.RJHMID)").addEntity(DatePlanPri.class);
					query.setParameter("projectType", Contains.XX_PROJECT_TYPE);
					query.setParameter("status", status);
				}
				return query.list();
			}
		});
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDictSign(final Long userid,final Integer roleType) {
		return getHibernateTemplate().execute(new HibernateCallback<List<DatePlanPri>>() {

			@SuppressWarnings({ "unchecked", "null" })
			@Override
			public List<DatePlanPri> doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = null;
				String sql = null;
//				if (roleType==1) {
//					sql = "select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.ITEMCTRLTECH=1 and jpd.TYPE!=3 group by dpp.RJHMID)";
//				} else if (roleType==2) {
//					sql = "select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.ITEMCTRQI=1 and jpd.TYPE!=3 group by dpp.RJHMID)";
//				} else if (roleType==3) {
//					sql = "select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.ITEMCTRLCOMLD=1 and jpd.TYPE!=3 group by dpp.RJHMID)";
//				} else {
//					sql = "select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.ITEMCTRLACCE=1 and jpd.TYPE!=3 group by dpp.RJHMID)";
//				}
				if(roleType!=3){//质检、技术、验收,查询自己所分班组下的日计划
					sql="select dppi.* from DATEPLAN_PRI dppi left join jc_choice jcc on dppi.rjhmid=jcc.jcrecmid where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and jcc.userid=:userid";
					query = session.createSQLQuery(sql).addEntity(DatePlanPri.class);
					query.setParameter("projectType", Contains.XX_PROJECT_TYPE).setParameter("userid", userid);
				}else{//交车工长，根据日计划中的交车工长指定查询日计划
					sql = "select dppi.* from DATEPLAN_PRI dppi where dppi.PROJECTTYPE=:projectType and dppi.planStatue in(0,1) and dppi.gongzhang=:gongzhang and dppi.RJHMID in (select dpp.RJHMID from DATEPLAN_PRI dpp join JT_PREDICT jpd on dpp.RJHMID = jpd.DATEPLANPRI where jpd.TYPE!=3 group by dpp.RJHMID)";
					query = session.createSQLQuery(sql).addEntity(DatePlanPri.class);
					query.setParameter("projectType", Contains.XX_PROJECT_TYPE).setParameter("gongzhang", userid);
				}
				return query.list();
			}
			
		});
	}

	@Override
	public DatePlanPri dailyIsExist(String jcType, String jcNum, String fixFreque) {
		String hql = "from DatePlanPri t where t.jcType=? and t.jcnum=? and t.fixFreque=? and t.planStatue!=3";
		List list=this.getHibernateTemplate().find(hql, new Object[]{jcType, jcNum, fixFreque});
		if(list!=null&&list.size()>0){
			return (DatePlanPri) this.getHibernateTemplate().find(hql, new Object[]{jcType, jcNum, fixFreque}).get(0);
		}else{
			return null;
		}
	}

	@Override
	public void saveOrUpdateMainPlan(MainPlan mainPlan) {
		getHibernateTemplate().saveOrUpdate(mainPlan);
	}

	@Override
	public void saveOrUpdateMainPlanDetail(MainPlanDetail mainPlanDetail) {
		getHibernateTemplate().saveOrUpdate(mainPlanDetail);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MainPlanDetail> findMainPlanDetail(String startTime,String endTime) {
		String hql="from MainPlanDetail t where t.planTime>=? and t.planTime<=?";
		return getHibernateTemplate().find(hql,new Object[]{startTime,endTime});
	}

	@Override
	public MainPlan findMainPlanById(Long Id) {
		return getHibernateTemplate().get(MainPlan.class, Id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MainPlanDetail> findMainPlanDetailByMainId(Long mainPlanId) {
		String hql="from MainPlanDetail t where t.mainPlanId.id=? order by t.num";
		return getHibernateTemplate().find(hql,mainPlanId);
	}

	@Override
	public void delMainPlanById(Long mainPlanId) {
		String hql="delete from MainPlan t where t.id=?";
		getSession().createQuery(hql).setLong(0, mainPlanId).executeUpdate();
	}

	@Override
	public void delMainPlanDetailById(Long mainPlanId, Long mainPlanDetailId) {
		String hql=null;
		if(mainPlanId!=null){
			hql="delete from MainPlanDetail t where t.mainPlanId.id=?";
			getSession().createQuery(hql).setLong(0, mainPlanId).executeUpdate();
		}else if(mainPlanDetailId!=null){
			hql="delete from MainPlanDetail t where t.id=?";
			getSession().createQuery(hql).setLong(0, mainPlanDetailId).executeUpdate();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MainPlan> findMainPlanList() {
		return getHibernateTemplate().find("from MainPlan t order by t.id desc");
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<MainPlan> findMainPlanList(String startTime, String endTime) {
		String hql="from MainPlan t where 1=1";
		List<String> params=new ArrayList<String>();
		if(startTime!=null&&!"".equals(startTime)){
			hql+=" and t.startTime>=?";
			params.add(startTime);
		}
		if(endTime!=null&&!"".equals(endTime)){
			hql+=" and t.endTime<=?";
			params.add(endTime);
		}
		hql+=" order by t.startTime desc, t.id";
		return findPageModel(hql,params.toArray());
	}

	@Override
	public MainPlanDetail findMainPlanDetailById(Long id) {
		return getHibernateTemplate().get(MainPlanDetail.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MainPlan> findMainPlanByTime(String startTime, String endTime) {
		String hql="from MainPlan mp where mp.id in (select mpd.mainPlanId.id from MainPlanDetail mpd where mpd.planTime>=? and mpd.planTime<=?) order by mp.startTime desc";
		return getSession().createQuery(hql).setString(0, startTime).setString(1, endTime).list();
	}

	@Override
	public void updateMainPlanDetial(Long id, String inputName, String inputVal) {
		String hql="update MainPlanDetail t set t."+inputName+"=? where t.id=?";
		getSession().createQuery(hql).setString(0, inputVal).setLong(1, id).executeUpdate();
	}
}
