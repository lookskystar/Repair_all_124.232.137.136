package com.repair.kq.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQReSignType;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQSignRec;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.kq.dao.SignDao;

public class SignDaoImpl extends AbstractDao implements SignDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<KQSignRec> findReSignRec(String gonghao, String xm,
			Long teamId,Integer isResign,Long reSignTypeId, String beginTime, String endTime) {
		StringBuilder builder=new StringBuilder();
		builder.append("from KQSignRec r where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(gonghao!=null&&!gonghao.equals("")){
			builder.append(" and r.gonghao like ?");
			params.add("%"+gonghao+"%");
		}
		if(xm!=null&&!xm.equals("")){
			builder.append(" and r.xm like ?");
			params.add("%"+xm+"%");
		}
		if(teamId!=null&&!teamId.equals("")){
			builder.append(" and r.proteamId = ?");
			params.add(teamId);
		}
		if(isResign!=null&&!isResign.equals("")){
			builder.append(" and r.isresign = ?");
			params.add(isResign);
		}
		if(reSignTypeId!=null&&!reSignTypeId.equals("")){
			builder.append(" and r.reSignTypeId = ?");
			params.add(reSignTypeId);
		}
		
		if(beginTime!=null&&!beginTime.equals("")){
			builder.append(" and r.day >= ?");
			params.add(beginTime);
		}
		if(endTime!=null&&!endTime.equals("")){
			builder.append(" and r.day <= ?");
			params.add(endTime);
		}
		builder.append("  order by r.day desc");
		return getHibernateTemplate().find(builder.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQSignRec> KQDayQuery(String gonghao, String xm,
			Long teamId, String beginTime, String endTime) {
		StringBuilder builder=new StringBuilder();
		builder.append("from KQSignRec r where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(gonghao!=null&&!gonghao.equals("")){
			builder.append(" and r.gonghao like ?");
			params.add("%"+gonghao+"%");
		}
		if(xm!=null&&!xm.equals("")){
			builder.append(" and r.xm like ?");
			params.add("%"+xm+"%");
		}
		if(teamId!=null&&!teamId.equals("")){
			builder.append(" and r.proteamId = ?");
			params.add(teamId);
		}
		
		if(beginTime!=null&&!beginTime.equals("")){
			builder.append(" and r.day >= ?");
			params.add(beginTime);
		}
		if(endTime!=null&&!endTime.equals("")){
			builder.append(" and r.day <= ?");
			params.add(endTime);
		}
		builder.append("  order by r.day desc");
		return getHibernateTemplate().find(builder.toString(),params.toArray());
		
		
		
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQReSignType> listResignType() {
		String hql = "from KQReSignType t order by t.typeId";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public void saveOrUpdateKQSignRec(KQSignRec signrec) {
		getHibernateTemplate().saveOrUpdate(signrec);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UsersPrivs> findUsersByTeamId(Long teamId) {
		String hql="from UsersPrivs u where bzid=? order by u.userid";
		return getHibernateTemplate().find(hql,teamId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public KQSignRec getKQSignRecByGD(String existGonghao, String existDate) {
		String hql="from KQSignRec t where t.gonghao=? and t.day=?";
		List<KQSignRec> list=getHibernateTemplate().find(hql,new Object[]{existGonghao,existDate});
		if(list!=null&&list.size()>0){
			return (KQSignRec)list.get(0);
		}
		return null;
	}

	@Override
	public KQSignRec getKQSignRecById(long signId) {
		return getHibernateTemplate().get(KQSignRec.class, signId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public KQRule getKQRuleById(long proteamId) {
		String hql="from  KQRule t where t.bzid like ?";
		List<KQRule> list =getHibernateTemplate().find(hql,"%,"+proteamId+",%");
		if(list!=null&&list.size()>0){
			return (KQRule)list.get(0);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findMonthSign(Long proteamId, String gonghao,
			String xm, String month) {
		String sql="select t.proteamid ,t.xm,t.gonghao,count(t.day) as real_day,sum(t.ATTENDANCE) as attendance,sum(t.REAL_ATTENDANCE) as real_attendance,sum(t.IS_RESIGN) as resign_count,(sum(t.IS_LATE)+sum(t.IS_LATE_B)) as late_count,";
		sql=sql+" (sum(t.IS_GOEARLY)+sum(t.IS_GOEARLY_B)) as goearly_count, (sum(t.ATTENDANCE)-sum(t.REAL_ATTENDANCE)) as absenteeism,sum(t.is_absenteeism) as absenteeism_count from kq_signrec t   where 1=1";
		StringBuilder sb=new StringBuilder(sql);
		if(proteamId!=null&&proteamId!=0){
			sb.append("  and t.proteamid="+proteamId);
		}
		if(xm!=null&&!"".equals(xm)){
			sb.append("  and t.xm like '%"+xm+"%'");
		}
		if(gonghao!=null&&!"".equals(gonghao)){
			sb.append("  and t.gonghao like '%"+gonghao+"%'");
		}
		if(month!=null&&!"".equals(month)){
			sb.append("  and t.day like '%"+month+"%'");
		}
		sb.append("  group by t.proteamid,t.xm,t.gonghao order by t.proteamid");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findMonthSignByXm(Long proteamId, String gonghao,
			String xm, String month) {
		String sql="select t.proteamid ,t.xm,t.gonghao from kq_signrec t where 1=1";
		StringBuilder sb=new StringBuilder(sql);
		if(proteamId!=null&&proteamId!=0){
			sb.append("  and t.proteamid="+proteamId);
		}
		if(xm!=null&&!"".equals(xm)){
			sb.append("  and t.xm like '%"+xm+"%'");
		}
		if(gonghao!=null&&!"".equals(gonghao)){
			sb.append("  and t.gonghao like '%"+gonghao+"%'");
		}
		if(month!=null&&!"".equals(month)){
			sb.append("  and t.day like '%"+month+"%'");
		}
		sb.append("  group by t.proteamid,t.xm,t.gonghao order by t.proteamid");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	
	@Override
	public Object countDay(String gonghao, String month) {
		String sql = "select count(*) from kq_work_set t where t.gonghao=? and t.work_month=? ";
		return getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, month).uniqueResult();
	}


	@Override
	public Object queryIsabsenteeism(String gonghao, String day) {
		String sql="select IS_ABSENTEEISM from kq_signrec t where t.gonghao=? and t.day=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, day).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findBasicSign(String gonghao, String day,String otherday,int flag) {
		String sql="select SIGNTIME from kq_basic_signrec  where 1=1";
		StringBuilder sb=new StringBuilder(sql);
		if(gonghao!=null&&!"".equals(gonghao)){
			sb.append("  and ENROLLNUMBER = '"+gonghao+"'");
		}
		if(flag==0){
			if(null!=day&&!"".equals(day)){
				sb.append("  and substr(signtime,0,10) = '"+day+"'");
			}
		}
		if(flag==1){
			if(null!=day&&!"".equals(day)&&null!=otherday&&!"".equals(otherday)){
				sb.append("  and substr(signtime,0,10) = '"+day+"' or substr(signtime,0,10) = '"+otherday+"'");
			}
		}
		sb.append("  order by SIGNTIME");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQHoliday> findHoliByMonth(String month) {
		String hql="from  KQHoliday t where t.endTime  like '"+month+"%' or t.startTime like '"+month+"%'";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public Object queryIsgoearly(String gonghao, String day) {
		String sql="select IS_GOEARLY from kq_signrec t where t.gonghao=? and t.day=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, day).uniqueResult();
	}

	@Override
	public Object queryIslate(String gonghao, String day) {
		String sql="select IS_LATE from kq_signrec t where t.gonghao=? and t.day=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, day).uniqueResult();
	}

	@Override
	public Object queryIsgoearlyB(String gonghao, String day) {
		String sql="select IS_GOEARLY_B from kq_signrec t where t.gonghao=? and t.day=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, day).uniqueResult();
	}

	@Override
	public Object queryIslateB(String gonghao, String day) {
		String sql="select IS_LATE_B from kq_signrec t where t.gonghao=? and t.day=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, gonghao).setParameter(1, day).uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<KQUserItem> findKQUserItem(Long userId,Long proteamId, Integer status,
			String beginTime, String endTime) {
		StringBuilder builder=new StringBuilder();
		builder.append("from KQUserItem u where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(userId!=null&&!userId.equals("")){
			builder.append(" and u.user.userid = ?");
			params.add(userId);
		}
		if(proteamId!=null&&!proteamId.equals("")){
			builder.append(" and u.proteam.proteamid = ?");
			params.add(proteamId);
		}
		if(status!=null&&!status.equals("")){
			builder.append(" and u.status = ?");
			params.add(status);
		}
		
		if(beginTime!=null&&!beginTime.equals("")){
			builder.append(" and u.workTime >= ?");
			params.add(beginTime);
		}
		if(endTime!=null&&!endTime.equals("")){
			builder.append(" and u.workTime <= ?");
			params.add(endTime);
		}
		builder.append("  order by u.workTime desc");
		return getHibernateTemplate().find(builder.toString(),params.toArray());
	}

	@Override
	public void updateKQUserItem(KQUserItem userItem) {
		getHibernateTemplate().update(userItem);
	}

	@Override
	public KQUserItem getKQUserItemById(long userItemId) {
		return getHibernateTemplate().get(KQUserItem.class, userItemId);
	}

	@Override
	public Object updateKQUserItem(Long usrItemId, String workNote) {
		String sql="update  KQ_USER_ITEM set WORK_NOTE=?  where ID=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, workNote).setParameter(1, usrItemId).executeUpdate();
		
	}

	@Override
	public Object updateKQUserItemScore(Long usrItemId, Integer workScore) {
		String sql="update  KQ_USER_ITEM set WORK_SCORE=?  where ID=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, workScore).setParameter(1, usrItemId).executeUpdate();
		
	}

	@Override
	public Object updateKQUserItemSign(Long userItemId,String signTime) {
		String sql="update  KQ_USER_ITEM set STATUS=1,SIGN_TIME=?  where ID=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, signTime).setParameter(1, userItemId).executeUpdate();
		
	}

	@Override
	public Object updateKQUserItemOver(Long userItemId, Long userId,
			String overTime) {
		String sql="update  KQ_USER_ITEM set STATUS=2,OVER_USERID=?,OVER_TIME=?  where ID=?";
		return this.getSession().createSQLQuery(sql).setParameter(0, userId).setParameter(1, overTime).setParameter(2, userItemId).executeUpdate();
	}

	
	

}
