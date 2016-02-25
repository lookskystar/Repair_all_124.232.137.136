package com.repair.admin.dao.impl;

import java.util.List;

import com.repair.admin.dao.AttendanceDao;
import com.repair.common.pojo.AttendanceDate;
import com.repair.common.pojo.AttendanceDetails;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.util.AbstractDao;

/**
 * 考勤管理
 * @author eleven
 *
 */
public class AttendacneDaoImpl extends AbstractDao implements AttendanceDao{

	@Override
	public void saveImgUrl(AttendanceDetails imgUrl) {
		this.getHibernateTemplate().saveOrUpdate(imgUrl);
	}

	@Override
	public void saveAttendance(AttendanceDate attendance) {
		this.getHibernateTemplate().saveOrUpdate(attendance);
	}

	@Override
	public AttendanceDate findAttendanceById(Long userid, String dates) {
		String hql = "from AttendanceDate t where t.datetime = ? and t.users.userid=?";
		List list= this.getSession().createQuery(hql).setString(0, dates).setLong(1, userid).list();
		if(list!=null&&list.size()>0){
			return (AttendanceDate)list.get(0);
		}
		return  null;
	}


	@SuppressWarnings("unchecked")
	public List<DictProTeam> findAllDictProteam(){
		String hql ="from DictProTeam t where workflag = 1";
		return this.getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List findAttendaceDate(Long proteamId, String date) {
		StringBuffer sql = new StringBuffer();
		sql.append("select u.xm,t.id ,t.users,t.bzid,t.datetime,t.comments,t.confirm from users_privs u ");	
		sql.append("left join (select * from attendance_date where bzid='"+proteamId+"' and datetime='"+date+"') t on u.userid=t.users where u.bzid='"+proteamId+"'");
		return this.getSession().createSQLQuery(sql.toString()).list();
	}
	
	public int getAttendanceNum(long did){
		String sql = "select count(*) from attendance_details t where t.did=?";
		try{
			return Integer.parseInt(getSession().createSQLQuery(sql).setLong(0, did).uniqueResult()+"");
		}catch (Exception e) {
			return 0;
		}
	}
	
	public Object[] getAttendanceInfo(long did,int num){
		String sql = null;
		switch(num){
			case 0 :
				sql = "select imgtime,imgurl from (select * from attendance_details a where substr(a.imgtime,12)<'12:30:00' and a.did=? order by a.imgtime) where rownum=1";
				break;
			case 1 :
				sql = "select imgtime,imgurl from (select * from attendance_details a where substr(a.imgtime,12)<'12:30:00' and a.did=? order by a.imgtime desc) where rownum=1";
				break;
			case 2 :
				sql = "select imgtime,imgurl from (select * from attendance_details a where substr(a.imgtime,12)>'12:30:00' and a.did=? order by a.imgtime) where rownum=1";
				break;
			case 3 : 
				sql = "select imgtime,imgurl from (select * from attendance_details a where substr(a.imgtime,12)>'12:30:00' and a.did=? order by a.imgtime desc) where rownum=1";
				break;
		}
		try{
			return	(Object[]) getSession().createSQLQuery(sql).setLong(0, did).uniqueResult();
		}catch (Exception e) {
			return new Object[2];
		}
	}

	@Override
	public DictProTeam findbz(Long bzid) {
		String hql ="from DictProTeam t where t.proteamid =?";
		return (DictProTeam)this.getSession().createQuery(hql).setLong(0, bzid).uniqueResult();
	}

	@Override
	public AttendanceDate findAttendanceDate(Long id) {
		String hql ="from AttendanceDate t where t.id =?";
		return (AttendanceDate)this.getSession().createQuery(hql).setLong(0, id).uniqueResult();
	}
}
