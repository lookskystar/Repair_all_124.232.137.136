package com.repair.kq.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.admin.dao.UserRolesDao;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQReSignType;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQSignRec;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.dao.SignDao;
import com.repair.kq.service.SignService;

public class SignServiceImpl implements SignService{
	
	@Resource(name="signDao")
	private SignDao signDao;
	@Resource(name="userRolesDao")
	private UserRolesDao userRolesDao;
	
	private static final SimpleDateFormat YM = new SimpleDateFormat("yyyy-MM");
	private static final SimpleDateFormat YMD = new SimpleDateFormat("yyyy-MM-dd");
	
	

	@Override
	public List<KQSignRec> findReSignRec(String gonghao, String xm,
			Long teamId,Integer isResign,Long reSignTypeId, String beginTime, String endTime) {
		return signDao.findReSignRec(gonghao, xm, teamId,isResign, reSignTypeId,beginTime, endTime);
	}

	@Override
	public List<KQSignRec> KQDayQuery(String gonghao, String xm,
			Long teamId, String beginTime, String endTime) {
		return signDao.KQDayQuery(gonghao, xm, teamId, beginTime, endTime);
	}

	@Override
	public List<KQReSignType> listResignType() {
		return signDao.listResignType();
	}

	@Override
	public void saveOrUpdateKQSignRec(List<KQSignRec> list) {

		for(KQSignRec signrec:list){
			signDao.saveOrUpdateKQSignRec(signrec);
			
		}
	}

	@Override
	public void saveOrUpdateKQSignRec(KQSignRec signrec) {
		signDao.saveOrUpdateKQSignRec(signrec);
		
	}

	@Override
	public List<UsersPrivs> findUsersByTeamId(Long teamId) {
		return signDao.findUsersByTeamId(teamId);
	}

	@Override
	public KQSignRec getKQSignRecByGD(String existGonghao, String existDate) {
		return signDao.getKQSignRecByGD(existGonghao,existDate);
	}

	@Override
	public KQSignRec getKQSignRecById(long signId) {
		return signDao.getKQSignRecById(signId);
	}

	@Override
	public KQRule getKQRuleById(long proteamId) {
		
		return signDao.getKQRuleById(proteamId);
	}

	@SuppressWarnings("deprecation")
	@Override
	public List<Map<Object, Object>> findMonthSign(Long proteamId,
			String gonghao, String xm, String month) throws Exception {
		List<Map<Object, Object>>  dataList = new ArrayList<Map<Object,Object>>();
		// 处理时间
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int minMonthDay = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
		
		List<Object[]> monthCount=signDao.findMonthSign(proteamId, gonghao, xm, month);
		Map<Object, Object> dataMap = null;
		Map<Object,Object> map=null;
		DictProTeam proteam=null;
		String mapValue=null;
		int workDay=0;
		int should_day=0;//应出勤天数
		int holi_day=0;//放假天数
		int absenteeism=0;//旷工
		Calendar calmax  = Calendar.getInstance();
		calmax.setTime(monthNow);
		for (int i = 0; i < maxMonthDay; i++) {
			// 将日期设置为每一天
			calendar.set(Calendar.DAY_OF_MONTH, minMonthDay + i);
			Date eachDay =  calendar.getTime();
			if (eachDay.getDay() != 6 && eachDay.getDay() != 0)  { workDay++; }
		}
		holi_day=getHoliday(month);
		for(Object[] obj:monthCount){
			
			Object countDay=signDao.countDay(obj[2].toString(), month);
			if(Integer.parseInt(countDay+"")==0){//排班天数为零
				should_day=workDay-holi_day;
			}else{
				should_day=Integer.parseInt(countDay+"");
			}
			absenteeism=should_day-Integer.parseInt(obj[3]+"");
			proteam=userRolesDao.getDictProteamById(Long.parseLong(obj[0]+""));
			dataMap = new HashMap<Object, Object>();
			map = new HashMap<Object,Object>();
			map.put("proteamName", proteam.getProteamname());
			map.put("xm", obj[1]);
			map.put("gonghao", obj[2]);
			map.put("should_day", should_day);
			map.put("real_day", obj[3]);
			map.put("attendance", obj[4]);
			map.put("real_attendance", obj[5]);
			map.put("resign_count", obj[6]);
			map.put("late_count", obj[7]);
			map.put("goearly_count", obj[8]);
			map.put("absenteeism", obj[9]);
			map.put("absenteeism_count", absenteeism);//应出天减实出天等于旷工（考虑到存储过程不方便执行is_absenteeism字段）
			dataMap.put("base", map);
			
			for (int i = 0; i < maxMonthDay; i++) {
				// 将日期设置为每一天
				calendar.set(Calendar.DAY_OF_MONTH, minMonthDay + i);
				Date eachDay =  calendar.getTime();
				String eachDayStr = YMD.format(eachDay);
				Object isabsenteeism_count = signDao.queryIsabsenteeism(map.get("gonghao")+"", eachDayStr);//是否旷工
				Object islate_morn = signDao.queryIslate(map.get("gonghao")+"", eachDayStr);//上午是否迟到
				Object isgoearly_morn = signDao.queryIsgoearly(map.get("gonghao")+"", eachDayStr);//上午是否早退
				Object islate_after = signDao.queryIslateB(map.get("gonghao")+"", eachDayStr);//下午是否迟到
				Object isgoearly_after = signDao.queryIsgoearlyB(map.get("gonghao")+"", eachDayStr);//下午是否早退
				
				KQSignRec exist_rec=signDao.getKQSignRecByGD(map.get("gonghao")+"", eachDayStr);//是否有签到信息
				if(exist_rec == null){
					dataMap.put((i+1), "\\");
				}else if(exist_rec.getSignCount()==2){
					if (null != isabsenteeism_count && Integer.parseInt(isabsenteeism_count + "") == 1) {
						dataMap.put((i+1), "旷");
					}else if (Integer.parseInt(islate_morn + "") == 0
							&& Integer.parseInt(isgoearly_morn + "") == 0
							&& Integer.parseInt(islate_after + "") == 0
							&& Integer.parseInt(isgoearly_after + "") == 0) {
						dataMap.put((i + 1), "√ ");
					}else{
						if(null != islate_morn && Integer.parseInt(islate_morn + "") == 1){
							mapValue="迟  ";
						}else{
							mapValue="√ ";
						}
						if(null != isgoearly_morn && Integer.parseInt(isgoearly_morn + "") == 1){
							mapValue=mapValue+"早";
						}else{
							mapValue+="√";
						}
						mapValue+="<br/>";
						if(null != islate_after && Integer.parseInt(islate_after + "") == 1){
							mapValue=mapValue+"迟  ";
						}else{
							mapValue+="√ ";
						}
						if(null != isgoearly_after && Integer.parseInt(isgoearly_after + "") == 1){
							mapValue=mapValue+"早";
						}else{
							mapValue+="√ ";
						}
						dataMap.put((i+1), mapValue);
					}//end of else
				}else{//签到四次
					if (null != isabsenteeism_count && Integer.parseInt(isabsenteeism_count + "") == 1) {
						dataMap.put((i+1), "旷");
					}else if (Integer.parseInt(islate_morn + "") == 0
							&& Integer.parseInt(isgoearly_morn + "") == 0) {
						dataMap.put((i + 1), "√ ");
					}else{
						if(null != islate_morn && Integer.parseInt(islate_morn + "") == 1){
							mapValue="迟  ";
						}else{
							mapValue="√ ";
						}
						mapValue+="<br/>";
						if(null != isgoearly_morn && Integer.parseInt(isgoearly_morn + "") == 1){
							mapValue=mapValue+"早";
						}else{
							mapValue+="√";
						}
						dataMap.put((i+1), mapValue);
					}//end of else
				}
			}// end of  for(int i = 0; i < maxMonthDay; i++)
			dataList.add(dataMap);
		}// end of for(Object[] obj:monthCount)
		
		return  dataList;
	}

	
	@Override
	public List<Map<Object, Object>> findMonthSignByXm(Long proteamId,
			String gonghao, String xm, String month) throws Exception {
		List<Map<Object, Object>>  dataList = new ArrayList<Map<Object,Object>>();
		// 处理时间
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int minMonthDay = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
		
		List<Object[]> monthCount=signDao.findMonthSignByXm(proteamId, gonghao, xm, month);
		Map<Object, Object> dataMap = null;
		Map<Object,Object> map=null;
		DictProTeam proteam=null;
		String mapValue=null;
		Calendar calmax  = Calendar.getInstance();
		calmax.setTime(monthNow);
		for(Object[] obj:monthCount){
			
			proteam=userRolesDao.getDictProteamById(Long.parseLong(obj[0]+""));
			dataMap = new HashMap<Object, Object>();
			map = new HashMap<Object,Object>();
			map.put("proteamName", proteam.getProteamname());
			map.put("xm", obj[1]);
			map.put("gonghao", obj[2]);
			dataMap.put("base", map);
			
			for (int i = 0; i < maxMonthDay; i++) {
				// 将日期设置为每一天
				calendar.set(Calendar.DAY_OF_MONTH, minMonthDay + i);
				Date eachDay =  calendar.getTime();
				String eachDayStr = YMD.format(eachDay);
				KQSignRec rec=signDao.getKQSignRecByGD(map.get("gonghao")+"", eachDayStr);
				if(rec == null){
					dataMap.put((i+1), "");
				}else if(rec.getSignCount()==2){
					if(null != rec.getSigntimeA()){
						mapValue=rec.getSigntimeA().substring(11, 16)+"--";
					}else{
						mapValue="--";
					}
					if(null != rec.getSigntimeB()){
						mapValue+=rec.getSigntimeB().substring(11, 16)+"<br/>";
					}else{
						mapValue+="<br/>";
					}
					if(null != rec.getSigntimeC()){
						mapValue+=rec.getSigntimeC().substring(11, 16)+"--";
					}else{
						mapValue+="--";
					}
					if(null != rec.getSigntimeD()){
						mapValue+=rec.getSigntimeD().substring(11,16);
					}
					dataMap.put((i+1), mapValue);
				}else{
					if(null != rec.getSigntimeA()){
						mapValue=rec.getSigntimeA().substring(11, 16)+"--";
					}else{
						mapValue="--";
					}
					if(null != rec.getSigntimeB()){
						mapValue+=rec.getSigntimeB().substring(11, 16);
					}else{
						mapValue+="";
					}
					dataMap.put((i+1), mapValue);
				}
			}
			dataList.add(dataMap);
		}
		
		return  dataList;
	}
	
	
	@Override
	public List<Object[]> findBasicSign(String gonghao, String day,String otherday,int flag) {
		return signDao.findBasicSign(gonghao, day,otherday,flag);
	}

	@Override
	public List<KQUserItem> findKQUserItem(Long userId, Long proteamId,Integer status,
			String beginTime, String endTime) {
		return signDao.findKQUserItem(userId,proteamId, status, beginTime, endTime);
	}

	@Override
	public void updateKQUserItemSign(String[] userItemIdArray,String signTime) {
		for (int i = 0; i < userItemIdArray.length; i++) {
			signDao.updateKQUserItemSign(Long.parseLong(userItemIdArray[i]),signTime);
		}
	}

	@Override
	public KQUserItem getKQUserItemById(long userItemId) {
		return signDao.getKQUserItemById(userItemId);
	}

	@Override
	public void updateKQUserItem(KQUserItem userItem) {
		signDao.updateKQUserItem(userItem);
		
	}

	@Override
	public void updateKQUserItem(Long usrItemId, String workNote) {
		 signDao.updateKQUserItem(usrItemId, workNote);
		
	}

	@Override
	public void updateKQUserItemScore(Long usrItemId, Integer workScore) {
		signDao.updateKQUserItemScore(usrItemId, workScore);
		
	}

	@Override
	public void updateKQUserItemOver(String[] userItemIdArray, Long userId,
			String overTime) {
		for (int i = 0; i < userItemIdArray.length; i++) {
			signDao.updateKQUserItemOver(Long.parseLong(userItemIdArray[i]),userId,overTime);
		}
		
	}

	private int getHoliday(String month) throws Exception{
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int minMonthDay = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
		
		Calendar calmax  = Calendar.getInstance();
		calmax.setTime(monthNow);
		int holi_day=0;
		List<KQHoliday> holi_list=signDao.findHoliByMonth(month);//计算放假天数
		for(int a=0;a<holi_list.size();a++){
			KQHoliday holi_day_a=holi_list.get(a);
			Date holi_startTime=YMD.parse(holi_day_a.getStartTime());
			Date holi_endTime=YMD.parse(holi_day_a.getEndTime());
			calendar.set(Calendar.DAY_OF_MONTH, minMonthDay );
			Date oneDay =  calendar.getTime();//本月第一天
			calmax.set(Calendar.DAY_OF_MONTH,maxMonthDay);
			Date endDay=calmax.getTime();//本月最后一天
			if(holi_endTime.compareTo(endDay)<=0){//放假结束日期小于本月最后一天
				if(holi_startTime.compareTo(oneDay) <= 0){//放假开始日期小于本月第一天
					while (oneDay.compareTo(holi_endTime) <= 0) {  
						holi_day++;  
						oneDay.setDate(oneDay.getDate() + 1);  
					}  
				}else{
					while (holi_startTime.compareTo(holi_endTime) <= 0) {  
						holi_day++;  
						holi_startTime.setDate(holi_startTime.getDate() + 1);  
					}
				}
			}else{
				if(holi_startTime.compareTo(oneDay) <= 0){//放假开始日期小于本月第一天
					while (oneDay.compareTo(endDay) <= 0) {  
						holi_day++;  
						oneDay.setDate(oneDay.getDate() + 1);  
					}  
				}else{
					while (holi_startTime.compareTo(endDay) <= 0) {  
						holi_day++;  
						holi_startTime.setDate(holi_startTime.getDate() + 1);  
					}
				}
			}//end of else
		}//end of for
		return  holi_day;
	}

		
}
