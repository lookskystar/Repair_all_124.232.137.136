package com.repair.common.util;

import java.util.LinkedHashMap;
import java.util.List;

public interface DaoManage {
	/**
	 * 保存实体
	 * @param entity 实体对象
	 */
	public void save(Object entity);
	
	/**
	 * 更新实体
	 * @param entity 实体对象
	 */
	public void update(Object entity);
	
	/**
	 * 删除实体
	 * @param entityClass 实体类
	 * @param entityId 实体ID
	 */
	public <T> void delete(Class<T> entityClass, Object entityId);
	
	/**
	 * 删除实体
	 * @param entityClass 实体类
	 * @param entityIds 实体ID数组
	 */
	public <T> void delete(Class<T> entityClass, Object[] entityIds);
	
	/**
	 * 查找实体
	 * @param <T>
	 * @param eneityClass 实体类
	 * @param entityId 实体ID
	 * @return
	 */
	public <T> T find(Class<T> entityClass, Object entityId);
	
	/**
	 * 查找实体所有
	 * @param <T>
	 * @param entityClass 实体类
	 * @return
	 */
	public <T> List<T> find(Class<T> entityClass);
	
	/**
	 * 查找实体所有
	 * @param <T>
	 * @param entityClass 实体类
	 * @param wherehql 查询语句where条件串
	 * @param queryParams 条件串需要传入的参数集合
	 * @return
	 */
	public <T> List<T> find(Class<T> entityClass, String wherehql, Object[] queryParams);
	
	/**
	 * 查找实体所有
	 * @param <T>
	 * @param entityClass 实体类
	 * @param wherehql 查询语句where条件串
	 * @param queryParams 条件串需要传入的参数集合
	 * @param orderby 实体属性：desc/asc order by key1 desc, key2 asc, xxx desc
	 * @return
	 */
	public <T> List<T> find(Class<T> entityClass, String wherehql, Object[] queryParams, LinkedHashMap<String, String> orderby);
	
	/**
	 * 获取实体所有数据
	 * @param <T>
	 * @param entityClass
	 * @return
	 */
	public <T> PageModel<T> getScrollData(Class<T> entityClass);
	
	/**
	 * 获取分页数据
	 * @param <T>
	 * @param entityClass 实体类
	 * @param wherejpql 查询语句where条件串
	 * @param queryParams 条件串需要传入的参数集合
	 * @return
	 */
	public <T> PageModel<T> getScrollData(Class<T> entityClass, String wherehql, Object[] queryParams);
	
	/**
	 * 获取分页数据
	 * @param <T>
	 * @param entityClass 实体类
	 * @param orderby 实体属性：desc/asc order by key1 desc, key2 asc, xxx desc 
	 * @return
	 */
	public <T> PageModel<T> getScrollData(Class<T> entityClass, LinkedHashMap<String, String> orderby);
	
	/**
	 * 获取分页数据(使用LinkedHashMap保证添加的顺序和取出来的数据顺序是一致的)
	 * @param <T>
	 * @param entityClass 实体类
	 * @param wherejpql 查询语句where条件串
	 * @param queryParams 条件串需要传入的参数集合
	 * @param orderby 实体属性：desc/asc order by key1 desc, key2 asc, xxx desc  
	 * @return
	 */
	public <T> PageModel<T> getScrollData(Class<T> entityClass, String wherehql, Object[] queryParams, LinkedHashMap<String, String> orderby);
}
