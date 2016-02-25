package com.repair.work.service;

import com.repair.common.pojo.ZeroScore;

public interface ZeroScoreService {
	
	
	public void addZeroScore(ZeroScore zeroScore);
	
	public ZeroScore findByJtPreDictId(Integer jtPreDictId);
	
	public void updateZeroScore(ZeroScore zeroScore);
}
