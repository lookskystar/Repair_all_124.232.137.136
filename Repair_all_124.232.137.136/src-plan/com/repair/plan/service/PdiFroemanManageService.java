package com.repair.plan.service;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UsersPrivs;
import com.repair.plan.vo.Dispatch;

public interface PdiFroemanManageService {
	/**
	 * 查找交车工长需要签认的日计划
	 * @param usersPrivs
	 * @return
	 */
	List<DatePlanPri> findDatePlanByPdiFroeman(UsersPrivs usersPrivs);
	
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
	 * 根据ID查找检修内容实体
	 * @param preDictId
	 * @return
	 */
	JtPreDict findJtPreDictById(Integer preDictId);
	
	
	/**
	 * 临修加改派工
	 * @param preDictIds
	 */
	void updateDispatching(Integer[] preDictIds, Dispatch dispatch, UsersPrivs usersPrivs);
	
	/**
	 * 交车组派工
	 * @param preDictIds
	 * Integer opt:判断字段
	 */
	String updateDispatching(List<Integer> preDictIds, Dispatch dispatch, UsersPrivs usersPrivs,Integer opt);
	
	/**
	 * 删除派工
	 * @param preDictIds
	 * @param rjhmId
	 */
	void deleteDispatching(Integer[] preDictIds);
	
	/**
	 * 日计划签认
	 * @param datePlanPri
	 */
	Integer updateDatePlanSign(Integer rjhmId,Long userId);
	
	/**
	 * 根据ID查找班组
	 * @param proteamid
	 * @return
	 */
	DictProTeam findDictProTeamById(Long proteamid);
}
