package com.repair.experiment.service;

import java.util.List;

import com.repair.common.pojo.JcExpRec;

public interface JcExpRecService {
	/**
	 * 查询机车实验记录
	 * 
	 * @param rjhmId
	 *            日计划ID
	 * @param jceiId
	 *            实验主项目ID
	 * @return
	 */
	List<JcExpRec> findJcExpRecs(int rjhmId, long jceiId);
}
