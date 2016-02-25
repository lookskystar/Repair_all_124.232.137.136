package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixflow;

public interface DictProTeamDao {

	/**
	 * 根据流程节点查找检修项目中的班组
	 * @param fixflows
	 * @param jcType
	 * @param xcxc
	 * @return
	 */
	List<DictProTeam> findDictProTeamsByFixFlow(JCFixflow fixflow, DatePlanPri datePlanPri);
	
	/**
	 * 查询所有班组
	 * @return
	 */
	List<DictProTeam> findDictProTeam();
	
	/**
	 * 查询工作班组
	 * @return
	 */
	List<DictProTeam> findWorkDictProTeam();
	
	/**
	 * 查询工作班组
	 * @return
	 */
	List<DictProTeam> findWorkDictProTeam(int zxFlag);
	
	/**
	 * 根据ID查找班组
	 * @param proteamid
	 * @return
	 */
	DictProTeam findDictProTeamById(Long proteamid);
	
	/**
	 * 根据名字查找班组
	 * @param proteamid
	 * @return
	 */
	DictProTeam findDictProTeamByName(String proteamName);
	
	/**
	 * 根据班组拼音查询班组
	 */
	public DictProTeam findDictProTeamByPY(String py);
}
