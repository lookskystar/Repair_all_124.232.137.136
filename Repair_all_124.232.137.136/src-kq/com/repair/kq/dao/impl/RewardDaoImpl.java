package com.repair.kq.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQNoticeInfo;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkSet;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.dao.RewardDao;

public class RewardDaoImpl extends HibernateDaoSupport implements RewardDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<KQAssessReward> findKQAssessReward(Long proteamId,String reportTime,String reportPerson,String rewardPerson,Integer status) {
		StringBuilder sb=new StringBuilder("from KQAssessReward t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteam.proteamid=?");
			params.add(proteamId);
		}
		if(reportTime!=null&&!"".equals(reportTime)){
			sb.append(" and t.reportTime=?");
			params.add(reportTime);
		}
		if(reportPerson!=null&&!"".equals(reportPerson)){
			sb.append(" and t.reportPerson like ?");
			params.add("%"+reportPerson+"%");
		}
		if(rewardPerson!=null&&!"".equals(rewardPerson)){
			sb.append(" and t.rewardPerson like ?");
			params.add("%"+rewardPerson+"%");
		}
		if(status==null){
			sb.append(" and t.rewardStatus!=2");
		}
		if(status!=null&&status==2){
			sb.append(" and t.rewardStatus=2");
		}
		sb.append(" order by t.rewardTime desc");
		return getHibernateTemplate().find(sb.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findDictProTeam() {
		return getHibernateTemplate().find("from DictProTeam");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findWorkProTeam() {
		return getHibernateTemplate().find("from DictProTeam t where t.kqflag=1 order by t.proteamid");
	}

	@Override
	public void saveOrUpdateKQAssessReward(KQAssessReward reward) {
		getHibernateTemplate().saveOrUpdate(reward);
	}

	@Override
	public void deleteRewardInfo(Long id) {
		String hql="delete from KQAssessReward t where t.id=?";
		getSession().createQuery(hql).setLong(0, id).executeUpdate();
	}

	@Override
	public KQAssessReward findKQAssessRewardById(Long rewardId) {
		return getHibernateTemplate().get(KQAssessReward.class, rewardId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UsersPrivs> findUsersPrivs(Long proteamId) {
		return getHibernateTemplate().find("from UsersPrivs t where t.bzid=?",proteamId);
	}

	@Override
	public void deleteNoticeInfo(Long noticeId) {
		String hql="delete from KQNoticeInfo t where t.id=?";
		getSession().createQuery(hql).setLong(0, noticeId).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQNoticeInfo> findKQNoticeInfo() {
		return getHibernateTemplate().find("from KQNoticeInfo t order by t.startTime desc");
	}

	@Override
	public KQNoticeInfo findKQNoticeInfoById(Long noticeId) {
		return getHibernateTemplate().get(KQNoticeInfo.class, noticeId);
	}

	@Override
	public void saveOrUpdateKQNoticeInfo(KQNoticeInfo noticeInfo) {
		getHibernateTemplate().saveOrUpdate(noticeInfo);
	}

	@Override
	public void updateNoticeStatus(Long noticeId, Integer status) {
		String hql="update KQNoticeInfo t set t.noticeStatus=? where t.id=?";
		getSession().createQuery(hql).setInteger(0, status).setLong(1,noticeId).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQNoticeInfo> findKQNoticeInfo(String nowTime) {
		String hql="from KQNoticeInfo t where t.startTime<=? and t.endTime>=? and t.noticeStatus=0";
		return getHibernateTemplate().find(hql,new Object[]{nowTime,nowTime});
	}

	@SuppressWarnings("unchecked")
	@Override
	public DictProTeam findDictProTeamByName(String proteamName) {
		String hql="from DictProTeam t where t.proteamname=?";
		List<DictProTeam> list=getHibernateTemplate().find(hql,proteamName);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
	@Override
	public DictProTeam findDictProTeamById(Long proteamId){
		return getHibernateTemplate().get(DictProTeam.class, proteamId);
	}

	@Override
	public void updateNoticeStatus(Integer status, String nowTime) {
		String sql="update kq_notice_info t set t.notice_status=? where t.id in(select t2.id from kq_notice_info t2 where t2.notice_status!=? and t2.end_time<?)";
		getSession().createSQLQuery(sql).setInteger(0, status).setInteger(1, status).setString(2, nowTime).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkTimeCount> findKQWorkTimeCount(Long proteamId,
			String time, String userName, String gonghao) {
		StringBuilder sb=new StringBuilder("from KQWorkTimeCount t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteam.proteamid=?");
			params.add(proteamId);
		}
		if(time!=null&&!"".equals(time)){
			sb.append(" and t.time=?");
			params.add(time);
		}
		if(userName!=null&&!"".equals(userName)){
			sb.append(" and t.name like ?");
			params.add("%"+userName+"%");
		}
		if(gonghao!=null&&!"".equals(gonghao)){
			sb.append(" and t.gonghao=?");
			params.add(gonghao);
		}
		sb.append(" order by t.time desc");
		return getHibernateTemplate().find(sb.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<KQUserItem> findKQUserItem(Long proteamId,
			String time, String userName, String gonghao) {
		StringBuilder sb=new StringBuilder("from KQUserItem t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteam.proteamid=?");
			params.add(proteamId);
		}
		if(time!=null&&!"".equals(time)){
			sb.append(" and t.workTime=?");
			params.add(time);
		}
		if(userName!=null&&!"".equals(userName)){
			sb.append(" and t.user.xm like ?");
			params.add("%"+userName+"%");
		}
		if(gonghao!=null&&!"".equals(gonghao)){
			sb.append(" and t.user.gonghao=?");
			params.add(gonghao);
		}
		sb.append(" and t.status=2");//工时结转的才能查询得到
		sb.append(" order by t.workTime desc");
		return getHibernateTemplate().find(sb.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<KQUserItem> findKQUserItem(String time,String gonghao){
		String hql="from KQUserItem t where t.user.gonghao=? and t.status=2 and t.workTime like ? order by t.workTime";
		return getHibernateTemplate().find(hql,new Object[]{gonghao,"%"+time+"%"});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findMonthReport(Long proteamId, String time) {
		StringBuilder sb=new StringBuilder("select t.proteamid,t.gonghao,t.name,sum(t.work_score)as count1 from kq_work_timecount t  where 1=1");
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteamid="+proteamId);
		}
		if(time!=null&&!"".equals(time)){
			sb.append(" and t.time like '%"+time+"%'");
		}
		sb.append(" group by t.proteamid,t.gonghao,t.name order by count1 desc");
		return getSession().createSQLQuery(sb.toString()).list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findMonthReportNew(Long proteamId, String time) {
		StringBuilder sb=new StringBuilder("select t.proteamid,u.gonghao,u.xm,sum(t.work_score)as count1 from kq_user_item t,users_privs u where t.userid=u.userid");
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteamid="+proteamId);
		}
		if(time!=null&&!"".equals(time)){
			sb.append(" and t.work_time like '%"+time+"%'");
		}
		sb.append(" and t.status=2");//工时结转的才能查询得到
		sb.append(" group by t.proteamid,u.gonghao,u.xm order by count1 desc");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkTimeCount> findKQWorkTimeCount(String time, String gonghao) {
		String hql="from KQWorkTimeCount t where t.gonghao=? and t.time like ? order by time";
		return getHibernateTemplate().find(hql,new Object[]{gonghao,"%"+time+"%"});
	}

	@SuppressWarnings("unchecked")
	@Override
	public KQWorkSet findKQWorkSet(String gonghao, String workDay) {
		String hql="from KQWorkSet t where t.gonghao=? and t.workDay=?";
		List list=getHibernateTemplate().find(hql,new Object[]{gonghao,workDay});
		if(list!=null&&list.size()>0){
			return (KQWorkSet)list.get(0);
		}
		return null;
	}
	
	@Override
	public void saveOrUpdateKQWorkSet(KQWorkSet kqWorkSet){
		getHibernateTemplate().saveOrUpdate(kqWorkSet);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkSet> findKQWorkSet(Long bzId, String workMonth) {
		String hql="from KQWorkSet t where t.bzId=? and t.workMonth=?";
		return getHibernateTemplate().find(hql,new Object[]{bzId,workMonth});
	}

	@Override
	public void deleteKQWorkSet(KQWorkSet workSet) {
		getHibernateTemplate().delete(workSet);
	}

	@Override
	public Integer countMonthWorkSet(Long bzId,String month) {
		String hql="select count(t.id) from KQWorkSet t where t.bzId=? and t.workMonth=?";
		Object obj=getSession().createQuery(hql).setLong(0, bzId).setString(1, month).uniqueResult();
		return Integer.valueOf(obj+"");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkSet> findUserWorkset(String gonghao,
			List<String> lastFourDays) {
		String hql="from KQWorkSet t where t.gonghao=:gonghao and t.workDay in(:lastFourDays) order by t.workDay";
		return getSession().createQuery(hql).setParameter("gonghao", gonghao)
		.setParameterList("lastFourDays", lastFourDays).list();
	}
}
