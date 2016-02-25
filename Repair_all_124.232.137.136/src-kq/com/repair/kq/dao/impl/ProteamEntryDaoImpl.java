package com.repair.kq.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.common.pojo.SystemParameter;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.dao.ProteamEntryDao;

public class ProteamEntryDaoImpl extends HibernateDaoSupport implements	ProteamEntryDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<UsersPrivs> findUsersById(Long bzid) {
		String hql = "from UsersPrivs u where u.bzid = " + bzid + "";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public void saveProteamEntry(KQWorkTimeCount workTimeCount) {
		getHibernateTemplate().saveOrUpdate(workTimeCount);
	}

	@Override
	public int findRecordCount(Long bzid, String time) {
		String hql = "select count(*) from KQWorkTimeCount k where k.proteam.proteamid = " + bzid + " and k.time = '" + time + "'";
		return Integer.parseInt(getSession().createQuery(hql).uniqueResult()+ "");
	}

	@Override
	public SystemParameter findSystemParameter() {
		String hql = "from SystemParameter s where s.parameterName = 'is_use_kq'";
		return (SystemParameter)getHibernateTemplate().find(hql).get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkTimeCount> findWorkRecords(Long bzid, String time) {
		String hql = "from KQWorkTimeCount k where k.proteam.proteamid = " + bzid + " and k.time = '" + time + "'";
		return getHibernateTemplate().find(hql);
	}
	
	public Integer countWorkRecords(Long bzid, String time){
		String hql="select count(k.id) from KQWorkTimeCount k where k.proteam.proteamid=? and k.time=? and k.status=0";
		return Integer.parseInt(getSession().createQuery(hql).setLong(0, bzid).setString(1, time).uniqueResult()+"");
	}

	@Override
	public void updateStatus(Long bzid, String time) {
		String hql = "update KQWorkTimeCount k set k.status = 1 where k.proteam.proteamid = " + bzid + " and k.time = '" + time + "'";
		getSession().createQuery(hql).executeUpdate();
	}

	@Override
	public void updateRecord(KQWorkTimeCount record) {
		getHibernateTemplate().saveOrUpdate(record);
	}

	@Override
	public KQWorkTimeCount findRecord(Long id) {
		return getHibernateTemplate().get(KQWorkTimeCount.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQWorkTimeItem> findProteamItem(Long bzid) {
		String hql = "from KQWorkTimeItem k where k.proteam.proteamid="+bzid+"";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public UsersPrivs findUser(Long userId) {
		return getHibernateTemplate().get(UsersPrivs.class, userId);
	}

	@Override
	public KQWorkTimeItem findWorkTimeItem(Long itemId) {
		return getHibernateTemplate().get(KQWorkTimeItem.class, itemId);
	}

	@Override
	public void saveKQUserItem(KQUserItem userItem) {
		getHibernateTemplate().saveOrUpdate(userItem);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQUserItem> findKQUserItems(String shiJian, Long itemId) {
		String hql = "from KQUserItem k where k.item.id = "+itemId+" and k.workTime = '"+shiJian+"'";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public void deleteItemCharge(String shiJian, Long itemId) {
		String hql = "delete from KQUserItem k where k.item.id = "+itemId+" and k.workTime = '"+shiJian+"'";
		getSession().createQuery(hql).executeUpdate();
	}

	@Override
	public Integer findChargeCount(String shiJian, Long itemId) {
		String hql = "select count(*) from KQUserItem k where k.item.id = "+itemId+" and k.workTime = '"+shiJian+"' and k.status != 0";
		return Integer.parseInt(getSession().createQuery(hql).uniqueResult()+"");
	}

}
