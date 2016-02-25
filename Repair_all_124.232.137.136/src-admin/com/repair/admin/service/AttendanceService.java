package com.repair.admin.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.AttendanceDate;
import com.repair.common.pojo.AttendanceDetails;
import com.repair.common.pojo.DictProTeam;


/**
 * 考勤
 * @author eleven
 *
 */
public interface AttendanceService {
	
	/**
	 * 保存照片
	 */
	public void saveImgUrl(AttendanceDetails imgUrl);
	
	/**
	 * 保存考勤日记录
	 */
	public void saveAttendance(AttendanceDate attendance);
	
	/**
	 * 查询日记录
	 * @param userid
	 * @return
	 */
	public AttendanceDate findAttendanceById(Long userid, String date);
	
	/**
	 * 根据班组id查询班组
	 */
	public DictProTeam findbz(Long bzid);
	
	/**
	 * 根据日记录id查询日记录
	 */
	public AttendanceDate findAttendanceDate(Long id);

	/**
	 * 查找所有班组
	 * @return
	 */
	public List<DictProTeam> findAllDictProteam();
	
	/**
	 * 工长审核查询
	 */
	public List<Map<String, Object>> findAttendaceDate(Long proteamId,String date);
}
