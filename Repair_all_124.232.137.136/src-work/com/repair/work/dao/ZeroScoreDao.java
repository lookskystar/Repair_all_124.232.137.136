package com.repair.work.dao;

import com.repair.common.pojo.ZeroScore;

public interface ZeroScoreDao {
	
	
	public void addZeroScore(ZeroScore zeroScore);
	
	public ZeroScore findByJtPreDictId(Integer jtPreDictId);
	
	public void updateZeroScore(ZeroScore zeroScore);
	
	public Double getTotalScoreByRjhid(Integer rjhid);
}
