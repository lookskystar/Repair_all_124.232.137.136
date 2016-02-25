package com.repair.common.util;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.Entity;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public abstract class DaoManageSupport extends HibernateDaoSupport implements DaoManage{
	@Resource  
    public void setMySessionFactory(SessionFactory sessionFactory){  
        super.setSessionFactory(sessionFactory);  
    } 

	@Override
	public void save(Object entity) {
		getHibernateTemplate().setFlushMode(HibernateTemplate.FLUSH_EAGER);
		getHibernateTemplate().persist(entity);
	}

	@Override
	public void update(Object entity) {
		getHibernateTemplate().setFlushMode(HibernateTemplate.FLUSH_EAGER);
		getHibernateTemplate().merge(entity);
	}
	
	@Override
	public <T> void delete(Class<T> entityClass, Object entityId) {
		delete(entityClass, new Object[] {entityId});
	}

	@Override
	public <T> void delete(Class<T> entityClass, Object[] entityIds) {
		for (Object entityId : entityIds) {
			getHibernateTemplate().delete(getHibernateTemplate().get(entityClass, (Serializable) entityId));
		}
	}

	@Override
	public <T> T find(Class<T> entityClass, Object entityId) {
		return (T) getHibernateTemplate().get(entityClass, (Serializable) entityId);
	}
	
	@Override
	public <T> List<T> find(Class<T> entityClass) {
		return find(entityClass, null, null,null);
	}
	
	@Override
	public <T> List<T> find(Class<T> entityClass, String wherehql, Object[] queryParams) {
		return find(entityClass, wherehql, queryParams, null);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <T> List<T> find(Class<T> entityClass, String wherehql, Object[] queryParams, LinkedHashMap<String, String> orderby) {
		String entityName = getEntityName(entityClass);
		Query query = getSession().createQuery("select o from " + entityName + " o" + (wherehql == null ? "" : " where " + wherehql) + buildOrderBy(orderby));
		setQueryParams(query, queryParams);
		return query.list();
	}

	@Override
	public <T> PageModel<T> getScrollData(Class<T> entityClass, String wherehql,
			Object[] queryParams) {
		return getScrollData(entityClass, wherehql, queryParams, null);
	}

	@Override
	public <T> PageModel<T> getScrollData(Class<T> entityClass, LinkedHashMap<String, String> orderby) {
		return getScrollData(entityClass, null, null, orderby);
	}

	@Override
	public <T> PageModel<T> getScrollData(Class<T> entityClass) {
		return getScrollData(entityClass, null, null, null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> PageModel<T> getScrollData(Class<T> entityClass,String wherehql,
			Object[] queryParams, LinkedHashMap<String, String> orderby) {
		PageModel<T> result = new PageModel<T>();
		String entityName = getEntityName(entityClass);
		Query query = getSession().createQuery("select o from " + entityName + " o" + (wherehql == null ? "" : " where " + wherehql) + buildOrderBy(orderby));
		setQueryParams(query, queryParams);
		query.setFirstResult(SystemContext.getOffset());
		query.setMaxResults(SystemContext.getPageSize());
		result.setDatas(query.list());
		query = getSession().createQuery("select count(o) from " + entityName + " o" + (wherehql == null ? "" : " where " + wherehql));
		setQueryParams(query, queryParams);
		result.setCount(query.uniqueResult().hashCode());
		return result;
	}
	
	/**
	 * 给查询语句设置参数
	 * @param query 查询对象
	 * @param queryParams 参数数组
	 */
	protected void setQueryParams(Query query, Object[] queryParams) {
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i, queryParams[i]);
			}
		}
	}
	
	/**
	 * 组装order by语句
	 * @param orderby 传入的order by集合
	 * @return
	 */
	protected String buildOrderBy(LinkedHashMap<String, String> orderby) {
		StringBuffer orderbyql = new StringBuffer("");
		if (orderby != null && orderby.size() > 0) {
			orderbyql.append(" order by ");
			for (String key : orderby.keySet()) {
				orderbyql.append(key).append(" ").append(orderby.get(key)).append(",");
			}
			
			orderbyql.deleteCharAt(orderbyql.length() - 1);
		}
		return orderbyql.toString();
	}
	
	/**
	 * 获取实体类的名称
	 * @param <T>
	 * @param entityClass 实体类
	 * @return
	 */
	public <T> String getEntityName(Class<T> entityClass) {
		String entityName = entityClass.getSimpleName();
		Entity entity = entityClass.getAnnotation(Entity.class);
		if (entity != null) {
			if (entity.name() != null && !("").equals(entity.name())) {
				entityName = entity.name();
			}
		}
		return entityName;
	}
}
