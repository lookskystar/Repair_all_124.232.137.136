package com.repair.work.dao;

import java.util.List;
import java.util.Map;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.util.Page;

public interface DictUnitDao{
	/**
	 * 查询一级部件
	 * @return
	 */
	List<DictFirstUnit> findDictFirstUnitAll(String jcType);
	
	/**
	 * 根据一级部件查询二级部件
	 * @param firstunitid
	 * @return
	 */
	List<DictSecunit> findDictSecunitByFirstId(Long firstunitid);
	
	/**
	 * 查询故障信息总数
	 * @return
	 */
	public Long queryAllDictFailure(Map<String, String> conditionMap);
	
	/**
	 * 查询故障信息
	 * @param DictFailure id
	 */
	public DictFailure queryDictFailureById(int id);
	
	/**
	 * 分页查询故障信息
	 * @param DictFailure
	 * @return
	 */
	public List<DictFailure> queryDictFailurePage(Page page, Map<String, String> conditionMap);
	
	/**
	 * 添加故障信息
	 * @param DictFailure
	 * @return
	 */
	public void saveOrUpdateDictFailure(DictFailure dictFailure);
	
	
	/**
	 *  删除故障信息
	 * @param DictFailure
	 * @return
	 */
	public void deleteDictFailure(DictFailure dictFailure);
}
