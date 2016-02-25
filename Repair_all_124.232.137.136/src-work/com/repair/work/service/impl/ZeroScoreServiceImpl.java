package com.repair.work.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.repair.common.pojo.ZeroScore;
import com.repair.work.dao.ZeroScoreDao;
import com.repair.work.service.ZeroScoreService;

@Repository("zeroScoreService")
public class ZeroScoreServiceImpl implements ZeroScoreService{
	@Resource(name="zeroScoreDao")
	private ZeroScoreDao zeroScoreDao;
	
	public void addZeroScore(ZeroScore zeroScore){
		zeroScoreDao.addZeroScore(zeroScore);
	}
	
	public ZeroScore findByJtPreDictId(Integer jtPreDictId){
		return zeroScoreDao.findByJtPreDictId(jtPreDictId);
	}
	
	public void updateZeroScore(ZeroScore zeroScore){
		zeroScoreDao.updateZeroScore(zeroScore);
	}
}
