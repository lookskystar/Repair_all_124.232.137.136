package com.repair.work.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.util.Page;
import com.repair.work.dao.DictUnitDao;

public class DictUnitDaoImpl extends HibernateDaoSupport implements
		DictUnitDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> findDictFirstUnitAll(String jcType) {
		String jcTypes = jcType.substring(0,2);
		return getHibernateTemplate().find("from DictFirstUnit dfu where dfu.jcstypevalue like '"+ jcTypes +"%' order by dfu.firstunitid asc");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictSecunit> findDictSecunitByFirstId(Long firstunitid) {
		String hql="from DictSecunit ds where ds.dictFirstunit.firstunitid=?";
		return getHibernateTemplate().find(hql,firstunitid);
	}

	@Override
	public void saveOrUpdateDictFailure(DictFailure dictFailure) {
		this.getHibernateTemplate().saveOrUpdate(dictFailure);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFailure> queryDictFailurePage(Page page, Map<String, String> conditionMap) {
		StringBuilder builder = new StringBuilder();
		builder.append("from DictFailure as t where 1=1");
		if(!"".equals(conditionMap.get("yjbj")) && null !=conditionMap.get("yjbj")){
			builder.append(" and t.firstUnitName='"+ conditionMap.get("yjbj") +"'");
		}
		if(!"".equals(conditionMap.get("ejbj")) && null !=conditionMap.get("ejbj")){
			builder.append(" and t.secUnitName='"+ conditionMap.get("ejbj") +"'");
		}
		if(!"".equals(conditionMap.get("sjbj")) && null !=conditionMap.get("sjbj")){
			builder.append(" and t.thirdUnitName='"+ conditionMap.get("sjbj") +"'");
		}
		if(!"".equals(conditionMap.get("keys")) && null !=conditionMap.get("keys")){
			builder.append(" and t.content like '%"+ conditionMap.get("keys") +"%'");
		}
		builder.append(" order by t.id desc");
		Query query = this.getSession().createQuery(builder.toString());
		query.setFirstResult(page.getStartRow());
		query.setMaxResults(page.getSize());
		return query.list();
	}

	@Override
	public Long queryAllDictFailure(Map<String, String> conditionMap) {
		StringBuilder builder = new StringBuilder();
		builder.append("select max(rownum) from DictFailure t where 1=1");
		if(!"".equals(conditionMap.get("yjbj")) && null !=conditionMap.get("yjbj")){
			builder.append(" and t.firstUnitName='"+ conditionMap.get("yjbj") +"'");
		}
		if(!"".equals(conditionMap.get("ejbj")) && null !=conditionMap.get("ejbj")){
			builder.append(" and t.secUnitName='"+ conditionMap.get("ejbj") +"'");
		}
		if(!"".equals(conditionMap.get("sjbj")) && null !=conditionMap.get("sjbj")){
			builder.append(" and t.thirdUnitName='"+ conditionMap.get("sjbj") +"'");
		}
		if(!"".equals(conditionMap.get("keys")) && null !=conditionMap.get("keys")){
			builder.append(" and t.content like '%"+ conditionMap.get("keys") +"%'");
		}
		return (Long) this.getSession().createQuery(builder.toString()).uniqueResult();
	}

	@Override
	public void deleteDictFailure(DictFailure dictFailure) {
		 this.getHibernateTemplate().delete(dictFailure);
	}

	@Override
	public DictFailure queryDictFailureById(int id) {
		String hql = "from DictFailure t where t.id=?";
		return (DictFailure) this.getSession().createQuery(hql).setInteger(0, id).uniqueResult();
	}
}
