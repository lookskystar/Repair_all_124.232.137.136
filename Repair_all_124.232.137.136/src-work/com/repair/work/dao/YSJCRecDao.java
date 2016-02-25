package com.repair.work.dao;

import java.util.List;

import com.repair.common.pojo.YSJCRec;

/**
 * 
 * 验收交车
 * @author Administrator
 *
 */
public interface YSJCRecDao {
	
	/**
	 * 统计记录是否存在
	 */
	public Long countYSJCRec(int rjhmId);
	
	/**
	 * 根据日计划,班组查询交车记录
	 */
	public List<YSJCRec> listYSJCRecByRjhmId(int rjhmId,long proteam);
	
	/**
	 * 根据日计划查询交车记录
	 */
	public List<YSJCRec> listYSJCRecByRjhmId(int rjhmId);
	
	/**
	 * 根据日计划插入交车记录
	 */
	public void insertYSJCRec(int rjhmId,String jcType);
	
	/**
	 * 更新记录
	 */
	public void updateYSJCRec(YSJCRec ysjcRec);
	
	/**
	 * 根据ID获取记录
	 */
	public YSJCRec getYSJCRecById(int recId);
	
	/**
	 * 质检技术或验收、交车工长签字
	 * @param recIdList 签认的记录ID
	 * @param typeFlag 1:质检技术 2:验收 3:交车工长
	 * @param xm 签认人姓名
	 * @param signTime 签认时间
	 * @param allFlag 是否全签 0：否 1：是
	 * @param rjhmId 日计划ID
	 */
	public void updateSign(List<Integer> recIdList,int typeFlag,String xm,String signTime,Integer allFlag,Integer rjhmId);
	
	/**
	 * 交车工长判断签名卡控是否签完
	 */
	public long countBefSignRec(int rjhmId); 
}
