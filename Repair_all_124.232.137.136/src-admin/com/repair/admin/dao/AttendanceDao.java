package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.AttendanceDate;
import com.repair.common.pojo.AttendanceDetails;
import com.repair.common.pojo.DictProTeam;


/**
 *考勤
 * @author eleven
 *
 */
public interface AttendanceDao {
	/**
	 *保存照片 
	 * @param imgUrl
	 */
	public void saveImgUrl(AttendanceDetails imgUrl);
	
	/**
	 * 保存考勤日记录
	 * @param attendance
	 */
	public void saveAttendance(AttendanceDate attendance);
	
	/**
	 *查询日记录
	 * @param userid
	 * @param date
	 * @return
	 */
	public AttendanceDate findAttendanceById(Long userid, String date);
	
	/**
	 * 根据班组id查询班组
	 * @param id
	 * @return
	 */
	public DictProTeam findbz(Long bzid);
	
	/**
	 * 根据日记录id查询查询日记录
	 * @param id
	 * @return
	 */
	public AttendanceDate findAttendanceDate(Long id);

	/**
	 * 查询所有班组
	 * @return
	 */
	public List<DictProTeam> findAllDictProteam();
	
	/**
	 * 查找考勤日记录
	 * @param proteamId
	 * @param date
	 * @return
	 */
	public List findAttendaceDate(Long proteamId,String date);
	
	/**
	 * 获得打卡次数
	 */
	public int getAttendanceNum(long did);

	/**
	 * 查询考勤详情
	 * @param did
	 * @param num
	 * @return
	 */
	public Object[] getAttendanceInfo(long did,int num);

}
