package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DictJcFixSeq;

public interface DictJcFixSeqDao {
	/**
	 * 查询小辅修 修程修次
	 * @return
	 */
	List<DictJcFixSeq> findDictJcFixSeqs();
}
