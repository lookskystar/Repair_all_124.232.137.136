package com.repair.work.service;

import java.util.List;

import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.UsersPrivs;

/**
 * 秋整、春鉴Service
 * @author Administrator
 *
 */
public interface JCQZFixService {
	
	/**
	 * 根据ID获取
	 */
	public JCQZFixRec getJCQZFixRec(long recId);
	
	/**
	 * 保存或修改
	 */
	public void updateJCQZFixRec(JCQZFixRec jcqzFixRec);
	
	/**
	 * 根据修次修次与班组、机车类型(电力、内燃)获取项目
	 */
	public List<JCQZItems> getJCQZFix(String jcfix,Long bzId,String jcstype);
	
	/**
	 * 查询的分工记录
	 * @param userId 用户ID
	 */
	public List<DatePlanPri> listMyJCQZFix(long userId);
	
	/**
	 * 查询我的分工
	 * @param flag true 我的分工 false 非我的分工
	 */
	public List<JCQZFixRec> listMyJCQZFixRec(int rjhmId,UsersPrivs user,Short itemType,boolean flag);
	
	/**
	 * 秋整春鉴工人签字
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 */
	public String updateJCQZFixRecOfWorkerRatify(short type,int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker, JSONObject itemJsonObj) throws Exception;
}
