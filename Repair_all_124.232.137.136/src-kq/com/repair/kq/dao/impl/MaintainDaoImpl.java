package com.repair.kq.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQEquip;
import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.kq.dao.MaintainDao;

public class MaintainDaoImpl extends HibernateDaoSupport implements MaintainDao{

	@SuppressWarnings("unchecked")
	public List<KQEquip> findAllEquip() {
		return getHibernateTemplate().find("from KQEquip as equip order by id");
	}

	@Override
	public void saveKQEquip(KQEquip equip) {
		this.getHibernateTemplate().saveOrUpdate(equip);
	}

	@Override
	public KQEquip queryEquipById(Long id) {
		return this.getHibernateTemplate().get(KQEquip.class, id);
	}

	@Override
	public void saveOrUpdateEquip(KQEquip equip) {
		getHibernateTemplate().saveOrUpdate(equip);
	}
	
	@Override
	public void deleteEquip(KQEquip equip) {
		this.getHibernateTemplate().delete(equip);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQRule> queryRule() {
		return getHibernateTemplate().find("from KQRule as rule order by id");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findDictProTeam() {
		return getHibernateTemplate().find("from DictProTeam");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQHoliday> queryHoliday() {
		return getHibernateTemplate().find("from KQHoliday order by id");
	}

	@Override
	public void saveOrUpdateKQHoliday(KQHoliday holiday) {
		getHibernateTemplate().saveOrUpdate(holiday);
	}

	@Override
	public void deleteHoliday(KQHoliday holiday) {
		this.getHibernateTemplate().delete(holiday);
	}

	@Override
	public KQHoliday queryHolidayById(Long id) {
		return this.getHibernateTemplate().get(KQHoliday.class, id);
	}


	@Override
	public void saveOrUpdateHoliday(KQHoliday holiday) {
		getHibernateTemplate().saveOrUpdate(holiday);
	}

	@Override
	public void deleteRule(KQRule rule) {
		this.getHibernateTemplate().delete(rule);
	}

	@Override
	public KQRule queryRuleById(Long id) {
		return this.getHibernateTemplate().get(KQRule.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<KQRule> isexist(String bzids) {
		String hql="from KQRule t where t.bzid like ?";
		return getHibernateTemplate().find(hql,"%,"+bzids+",%");
	}
	
	@Override
	public void saveOrUpdateKQRule(KQRule rule) {
		getHibernateTemplate().saveOrUpdate(rule);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<KQRule> existence(Long ruleId,String bzids) {
		String hql="from KQRule t where t.id !=? and t.bzid like ?";
		Object[] value ={ruleId,"%,"+bzids+",%"};
		return getHibernateTemplate().find(hql,value);
	}

	@Override
	public void saveOrUpdateRule(KQRule rule) {
		getHibernateTemplate().saveOrUpdate(rule);
	}

	@Override
	public DictProTeam queryBzById(Long proteamid) {
		return this.getHibernateTemplate().get(DictProTeam.class, proteamid);
	}

	@SuppressWarnings("unchecked")
	public List<KQWorkTimeItem> findWorkTimeItems(Long proteamId,String itemName) {
		StringBuilder sb=new StringBuilder("from KQWorkTimeItem t where isused=1");
		List<Object> params=new ArrayList<Object>();
		if(proteamId!=null&&proteamId!=0){
			sb.append(" and t.proteam.proteamid=?");
			params.add(proteamId);
		}
		if(itemName!=null&&!"".equals(itemName)){
			sb.append(" and t.itemName like ?");
			params.add("%"+itemName+"%");
		}
		sb.append(" order by t.id desc");
		return getHibernateTemplate().find(sb.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<DictProTeam> findWorkProTeam() {
		return getHibernateTemplate().find("from DictProTeam t where t.workflag=1 or t.zxFlag=1");
	}
	
	@Override
	public void saveWorkTimeItem(KQWorkTimeItem workTimeItem) {
		this.getHibernateTemplate().saveOrUpdate(workTimeItem);
	}
	
	@Override
	public KQWorkTimeItem queryWorkTimeItemById(Long id) {
		return this.getHibernateTemplate().get(KQWorkTimeItem.class, id);
	}

	@Override
	public void saveOrUpdateWorkTimeItem(KQWorkTimeItem workTimeItem) {
		getHibernateTemplate().saveOrUpdate(workTimeItem);
	}

	@Override
	public void delWorkTimeItem(KQWorkTimeItem workTimeItem) {
		getHibernateTemplate().saveOrUpdate(workTimeItem);
	}
}
