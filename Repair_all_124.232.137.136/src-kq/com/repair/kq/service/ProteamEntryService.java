package com.repair.kq.service;

import java.util.List;

import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.common.pojo.SystemParameter;
import com.repair.common.pojo.UsersPrivs;

public interface ProteamEntryService {

	// 根据班组id查询所有班组人员信息
	public List<UsersPrivs> findUsersById(Long bzid);

	// 保存工时录入list
	public void saveProteamEntry(List<KQWorkTimeCount> workTimeCounts);

	// 保存工时录入
	public void saveProteamEntry(KQWorkTimeCount workTimeCount);

	// 查询记录数
	public int findRecordCount(Long bzid, String time);
	
	// 查询考勤系统是否启用
	public SystemParameter findSystemParameter();
	
	// 查询当天记录
	public List<KQWorkTimeCount> findWorkRecords(Long bzid, String time);
	
	//查询是否结转
	public Integer countWorkRecords(Long bzid, String time);
	
	// 工时结转
	public void updateStatus(Long bzid, String time);
	
	// 更新
	public void updateRecord(KQWorkTimeCount record);
	
	// 查找记录
	public KQWorkTimeCount findRecord(Long id);
	
	// 查找所有班组任务
	public List<KQWorkTimeItem> findProteamItem(Long bzid);
	
	// 根据任务id查找任务
	public KQWorkTimeItem findWorkTimeItem(Long itemId);
	
	// 根据userId查找user
	public UsersPrivs findUser(Long userId);
	
	// 保存派工
	public void saveKQUserItem(KQUserItem userItem);
	
	// 查找当日派工
	public List<KQUserItem> findKQUserItems(String shiJian,Long itemId);
	
	// 删除当日派工
	public void deleteItemCharge(String shiJian,Long itemId);
	
	// 统计状态不为0的派工
	public Integer findChargeCount(String shiJian,Long itemId);
}
