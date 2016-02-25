package com.repair.experiment.dao;

import java.io.Serializable;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


@SuppressWarnings( { "hiding", "unchecked" })
public class BaseDao<T> extends HibernateDaoSupport {

	/**
	 * 查找所有的entity
	 * 
	 * @param entityClass
	 * @return
	 */
	public <T> List<T> getAll(final Class<T> entityClass) {
		return getSession().createCriteria(entityClass).list();
	}
	
	
	/**
	 * 查找指定数目entity并排序
	 * 
	 * @param <T>
	 * @param entityClass
	 * @return
	 */
	public <T> List<T> findBy(Class<T> entityClass, String orderBy, boolean isAsc, int maxCount, Criterion... criterions) {
		return createCriteria(entityClass, orderBy, isAsc, criterions).setMaxResults(maxCount).list();
	}
	
	/**
	 * 查找指定条件内entity并排序
	 * 
	 * @param <T>
	 * @param entityClass
	 * @return
	 */
	public <T> List<T> findBy(Class<T> entityClass,String orderBy, boolean isAsc, Criterion... criterions) {
		return createCriteria(entityClass, orderBy, isAsc, criterions).list();
	}

	/**
	 * 查找entity
	 * 
	 * @param entityClass
	 * @param id
	 * @return
	 */
	public <T> T get(final Class<T> entityClass, final Serializable id) {
		return (T) getHibernateTemplate().get(entityClass, id);
	}
	
	/**
	 * 查找entity
	 * 
	 * @param entityClass
	 * @param id
	 * @return
	 */
	public int getFetchSize(final Class<T> entityClass) {
		return  getHibernateTemplate().getFetchSize();
	}
	/**
	 * 创建或修改entity
	 * 
	 * @param instance
	 */
	public void saveOrUpdate(final T instance) {
		getHibernateTemplate().saveOrUpdate(instance);
	}

	/**
	 * 修改entity
	 * 
	 * @param hql
	 */
	public void update(final String hql) {
		Query query = getSession().createQuery(hql);
		query.executeUpdate();
	}

	/**
	 * 修改字段
	 * 
	 * @param hql
	 */
	public void updateField(String ObjectName, String FieldName,
			Object updateValue, int id) {
		String hql = "update " + ObjectName + " o set o." + FieldName
				+ " = ? where id = ?";
		this.createQuery(hql, updateValue, id).executeUpdate();
	}
	

	/**
	 * 删除entity
	 * 
	 * @param obj
	 */
	public void remove(final T obj) {
		getHibernateTemplate().delete(obj);
	}

	/**
	 * 删除entity
	 * 
	 * @param entityClass
	 * @param id
	 */
	public void removeById(Class<T> entityClass, Serializable id) {
		remove(get(entityClass, id));
	}

	/**
	 * 查找所有entity
	 * 
	 * @param hql
	 * @param values
	 * @return
	 */
	public List find(final String hql, final Object... values) {
		return createQuery(hql, values).list();
	}
	/**
	 * 查找所有entity
	 * 
	 * @param hql
	 * @return
	 */
	public List find(final String hql) {
		List list = getHibernateTemplate().find(hql);
		return list;
	}
	/**
	 * 查找所有entity
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> List<T> findBy(Class<T> entityClass, String propertyName,
			Object value) {
		return createCriteria(entityClass, Restrictions.eq(propertyName, value)).list();
	}

	/**
	 * 查找所有entity
	 * @param <T>
	 * @param entityClass
	 * @param criterions
	 * @return
	 */
	public <T> List<T> findBy(Class<T> entityClass,Criterion... criterions){
		return createCriteria(entityClass, criterions).list();
	}
	
	/**
	 * 查找entity并排序
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param propertyName
	 * @param value
	 * @param orderBy
	 * @param isAsc
	 * @return
	 */
	public <T> List<T> findBy(Class<T> entityClass, String propertyName,
			Object value, String orderBy, boolean isAsc) {
		return createCriteria(entityClass, orderBy, isAsc,
				Restrictions.eq(propertyName, value)).list();
	}
	
	/**
	 * 查找entity
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> T findUniqueBy(Class<T> entityClass, String propertyName,
			Object value) {
		return (T) createCriteria(entityClass,
				Restrictions.eq(propertyName, value)).uniqueResult();
	}
	
	
	/**
	 * 删除选中entity
	 * 
	 * @param hql
	 * @return
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	@SuppressWarnings("unused")
	private static String removeSelect(String hql) {
		int beginPos = hql.toLowerCase().indexOf("from");
		return hql.substring(beginPos);
	}

	/**
	 * @param hql
	 * @return
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	@SuppressWarnings("unused")
	private static String removeOrders(String hql) {
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 创建Query
	 * 
	 * @param hql
	 * @param values
	 * @return
	 */
	private Query createQuery(String hql, Object... values) {
		Query query = getSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			if (values[i] instanceof String) {
				query.setString(i, (String) values[i]);
			}
			if (values[i] instanceof Integer) {
				query.setInteger(i, (Integer) values[i]);
			}
		}
		return query;
	}

	/**
	 * 创建Criteria
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param criterions
	 * @return
	 */
	public <T> Criteria createCriteria(Class<T> entityClass,
			Criterion... criterions) {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}
	
	/**
	 * 创建Criteria
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param orderBy
	 * @param isAsc
	 * @param criterions
	 * @return
	 */
	private <T> Criteria createCriteria(Class<T> entityClass, String orderBy,
			boolean isAsc, Criterion... criterions) {
		Criteria criteria = createCriteria(entityClass, criterions);
		if (isAsc) {
			criteria.addOrder(Order.asc(orderBy));
		} else {
			criteria.addOrder(Order.desc(orderBy));
		}
		return criteria;
	}
	
}
