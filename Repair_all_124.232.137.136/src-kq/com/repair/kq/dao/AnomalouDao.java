package com.repair.kq.dao;

import java.util.List;

public interface AnomalouDao {
	
	/**
	 * 查询早退出勤次数
	 * @param eachDateStr
	 * @param proteamId
	 * @param userName
	 * @return
	 */
	List<Object> countAnomalousEarly(String month, String proteamId, String userName);
	
	/**
	 * 查询迟到出勤次数
	 * @param eachDateStr
	 * @param proteamId
	 * @param userName
	 * @return
	 */
	List<Object> countAnomalousLate(String month, String proteamId, String userName);

}
