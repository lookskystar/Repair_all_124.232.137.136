package com.repair.kq.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.KQReSignType;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQSignRec;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.UsersPrivs;

public interface SignService {
	
	/**
	 * 根据条件查询手工补签,分页
	 * @return
	 */
	public List<KQSignRec> findReSignRec(String gonghao,String xm,Long teamId,Integer isResign,Long reSignTypeId,String beginTime,String endTime);
	
	/**
	 * 根据条件查询考勤日报
	 * @return
	 */
	public List<KQSignRec> KQDayQuery(String gonghao,String xm,Long teamId,String beginTime,String endTime);
	
	/**
	 * 查询所有补签类型
	 */
	public List<KQReSignType> listResignType();
	
	/**
	 * 保存签到表,List(休假录入时用到)
	 */
	public void saveOrUpdateKQSignRec(List<KQSignRec> list);
	
	/**
	 * 保存签到表(补签时用到)
	 */
	public void saveOrUpdateKQSignRec(KQSignRec signrec);
	
	/**
	 * 根据班组ID查询班组下的用户
	 * @param teamId
	 * @return
	 */
	public List<UsersPrivs> findUsersByTeamId(Long teamId);

	/**
	 * 根据工号及日期得到签到信息
	 */
	public KQSignRec getKQSignRecByGD(String existGonghao, String existDate);

	/**
	 * 根据ID(主键)得到签到信息
	 */
	public KQSignRec getKQSignRecById(long signId);
	
	/**
	 * 根据班组ID得到考勤规则
	 */
	public KQRule getKQRuleById(long proteamId);
	
	/**
	 * 查询考勤月报
	 */
	public List<Map<Object, Object>> findMonthSign(Long proteamId, String gonghao,String xm,String month) throws Exception;
	
	/**
	 * 根据用户，查询考勤月报
	 */
	public List<Map<Object, Object>> findMonthSignByXm(Long proteamId, String gonghao,String xm,String month) throws Exception;
	
	/**
	 * 查询其他签到数据(kq_basic_signrec)
	 */
	public List<Object[]> findBasicSign(String gonghao,String day,String otherday,int flag);
	
	
	/**
	 * 根据条件查询考勤项目表
	 * @return
	 */
	public List<KQUserItem> findKQUserItem(Long userId,Long proteamId,Integer status,String beginTime,String endTime);
	
	/**
	 * 保存工人签认表
	 */
	public void updateKQUserItemSign(String[] userItemIdArray,String signTime);
	
	public void updateKQUserItemOver(String[] userItemIdArray,Long userId,String overTime);
	
	
	public void updateKQUserItem(KQUserItem userItem);
	
	/**
	 * 通过ID获取考勤用户项目表
	 */
	public KQUserItem getKQUserItemById(long userItemId);
	
	/**
	 * 根据ID修改备注
	 */
	public void updateKQUserItem(Long usrItemId,String workNote);
	
	/**
	 * 根据ID修改工时得分
	 */
	public void updateKQUserItemScore(Long usrItemId,Integer workScore);
	
	

}
