package com.repair.kq.dao;

import java.util.List;

import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQReSignType;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQSignRec;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.UsersPrivs;


/**
 * 查询统计
 * @author L
 */

public interface SignDao {
	
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
	 * 保存签到表
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
	public List<Object[]> findMonthSign(Long proteamId, String gonghao,String xm,String month);
	
	/**
	 * 根据用户，查询考勤月报
	 */
	public List<Object[]> findMonthSignByXm(Long proteamId, String gonghao,String xm,String month);
	
	/**
	 * 根据工号及月份查询排班天数
	 */
	public Object countDay(String gonghao,String month);
	
	/**
	 * 根据月份(放假结束时期)查询放假
	 */
	public List<KQHoliday> findHoliByMonth(String month);
	
	
	/**
	 * 根据工号及日期查询是否旷工
	 */
	public Object queryIsabsenteeism(String gonghao,String day);
	
	/**
	 * 根据工号及日期查询【上午】是否迟到
	 */
	public Object queryIslate(String gonghao,String day);
	
	/**
	 * 根据工号及日期查询【上午】是否早退
	 */
	public Object queryIsgoearly(String gonghao,String day);
	/**
	 * 根据工号及日期查询【下午】是否迟到
	 */
	public Object queryIslateB(String gonghao,String day);
	
	/**
	 * 根据工号及日期查询【下午】是否早退
	 */
	public Object queryIsgoearlyB(String gonghao,String day);
	
	/**
	 * 查询其他签到数据(kq_basic_signrec)
	 * flag=0,正常上班；1，轮流倒班
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
	public void updateKQUserItem(KQUserItem userItem);
	
	public Object updateKQUserItemSign(Long userItemId,String signTime);
	
	public Object updateKQUserItemOver(Long userItemId,Long userId,String overTime);
	
	/**
	 * 通过ID获取考勤用户项目表
	 */
	public KQUserItem getKQUserItemById(long userItemId);
	
	/**
	 * 根据ID修改备注
	 */
	public Object updateKQUserItem(Long usrItemId,String workNote);
	
	/**
	 * 根据ID修改工时得分
	 */
	public Object updateKQUserItemScore(Long usrItemId,Integer workScore);
	

}
