package com.repair.work.service;

import java.util.List;

import com.repair.common.pojo.YSJCRec;

/**
 * 验收交车试验
 * @author Administrator
 *
 */
public interface YSJCRecService {
	
	/**
	 * 统计记录是否存在
	 */
	public Long countYSJCRec(int rjhmId);
	
	/**
	 * 查询记录
	 */
	public List<YSJCRec> listYSJCRec(int rjhmId);
	
	/**
	 * 查询记录
	 */
	public List<YSJCRec> listYSJCRec(int rjhmId,long proteam);
	
	/**
	 * 插入记录
	 */
	public void addYSJCRec(int rjhmId);
	
	/**
	 * 根据ID查询记录
	 */
	public YSJCRec getYSJCRecById(int recId);
	
	/**
	 * 更新
	 */
	public void updateYSJCRec(YSJCRec ysjcRec);
	
	/**
	 * 质检技术或验收、交车工长签字
	 * @param recIdList 签认的记录ID
	 * @param typeFlag 1:质检技术 2:验收 3:交车工长
	 * @param xm 签认人姓名
	 * @param allFlag 是否全签 0：否 1：是
	 * @param rjhmId 日计划ID
	 */
	public void updateSign(List<Integer> recIdList,int typeFlag,String xm,Integer allFlag,Integer rjhmId);
	
	/**
	 * 交车工长判断签名卡控是否签完
	 */
	public long countBefSignRec(int rjhmId); 
}
