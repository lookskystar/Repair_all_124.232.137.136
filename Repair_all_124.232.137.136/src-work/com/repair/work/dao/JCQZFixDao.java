package com.repair.work.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.UsersPrivs;

/**
 * 秋整、春鉴Dao
 * @author Administrator
 *
 */
public interface JCQZFixDao {
	
	/**
	 * 根据修次修次与班组获取项目
	 */
	public List<JCQZItems> getJCQZFix(String jcfix,Long bzId,String jcstype);
	
	/**
	 * 根据ID获取记录
	 */
	public JCQZFixRec getJCQZFixRec(long jcRecId);
	
	/**
	 * 删除
	 */
	public void deleteJCQZFixRec(JCQZFixRec jcqzFixRec);
	
	/**
	 * 查询的分工记录
	 * @param userId 用户ID
	 */
	public List<DatePlanPri> listMyJCQZFix(long userId);
	
	/**
	 * 查询我的分工
	 * @param signFlag 0:未签 1：全部
	 * @param flag true 我的分工 false 非我的分工
	 */
	public List<JCQZFixRec> listMyJCQZFixRec(int rjhmId,UsersPrivs user,Short itemType,Integer signFlag,boolean flag);
	
	/**
	 * 修改
	 */
	public void updateJCQZFixRec(JCQZFixRec jcqzFixRec);

}
