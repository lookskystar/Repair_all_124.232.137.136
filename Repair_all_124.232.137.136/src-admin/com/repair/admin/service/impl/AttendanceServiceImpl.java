package com.repair.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.admin.dao.AttendanceDao;
import com.repair.admin.service.AttendanceService;
import com.repair.common.pojo.AttendanceDate;
import com.repair.common.pojo.AttendanceDetails;
import com.repair.common.pojo.DictProTeam;


/**
 * 考勤管理
 * @author eleven
 *
 */
public class AttendanceServiceImpl implements AttendanceService{
	@Resource(name="attendanceDao")
	private AttendanceDao attendanceDao;
	/**
	 * 保存详情记录
	 */
	public void saveImgUrl(AttendanceDetails imgUrl){
		attendanceDao.saveImgUrl(imgUrl);
	}
	/**
	 * 保存日记录
	 */
	@Override
	public void saveAttendance(AttendanceDate attendance) {
		attendanceDao.saveAttendance(attendance);
	}
	/**
	 * 查询日记录
	 */
	@Override
	public AttendanceDate findAttendanceById(Long userid, String dates) {
		return attendanceDao.findAttendanceById(userid, dates);
	}

	//查询所有班组
	public List<DictProTeam> findAllDictProteam(){
		return attendanceDao.findAllDictProteam();
	}
	
	//工长审核查询
	@Override
	public List<Map<String, Object>> findAttendaceDate(Long proteamId, String date) {
		List<Map<String, Object>> attDate = new ArrayList<Map<String, Object>>();
		List list = attendanceDao.findAttendaceDate(proteamId, date);//u.xm,t.id ,t.users,t.bzid,t.datetime,t.comments,t.confirm
		Map<String, Object> map = null;
		Object[] obj = null;
		Object[] obj2 = null;
		//int num = 0;
		long did = 0;
		for (int i = 0; i < list.size(); i++) {
			map = new HashMap<String, Object>();
			obj = (Object[]) list.get(i);
			map.put("xm", obj[0]);
			map.put("id", obj[1]);
			map.put("comments", obj[5]);
			map.put("confirm", obj[6]);
			if(obj[1]!=null){
				did = Long.parseLong(obj[1]+"");
				//num = attendanceDao.getAttendanceNum(did);
				for (int j = 0; j < 4; j++) {
					obj2 = attendanceDao.getAttendanceInfo(did, j);
					if( obj2 != null ){
						map.put("time_"+j, obj2[0]+"");
						map.put("imgurl_"+j, obj2[1]);
					}
				}
				if(map.get("time_0")!=null && map.get("time_1")!=null && map.get("time_0").equals(map.get("time_1"))){
					map.put("time_1", "");
					map.put("imgurl_1", "");
				}
				if(map.get("time_2")!=null && map.get("time_3")!=null && map.get("time_2").equals(map.get("time_3"))){
					map.put("time_3", "");
					map.put("imgurl_3", "");
				}
			}
			attDate.add(map);
		}
		return attDate;
	}
	//查询班组
	@Override
	public DictProTeam findbz(Long bzid) {
		return attendanceDao.findbz(bzid);
	}
	//查询日记录
	@Override
	public AttendanceDate findAttendanceDate(Long id) {
		return attendanceDao.findAttendanceDate(id);
	}

}
