package com.repair.query.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.query.dao.FittingDao;
import com.repair.query.service.FittingService;

public class FittingServiceImpl implements FittingService {
	@Autowired
	private FittingDao fittingDao;

	@Override
	public List<DictFirstUnit> findDictFistUnitForDatePlan(int rjhmId) {
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId);
		if (null != fittingNums && !fittingNums.isEmpty()) {
			return fittingDao.forFittingNumbers(fittingNums);
		}
		return null;
	}
	
	public List<String> findPjNums(int rjhmId){
		return fittingDao.findFittingNumberForFixRec(rjhmId);
	}
	
	public 	List<String> findXXPJNums(int rjhmId,int type){
		return fittingDao.findXXPJNums(rjhmId, type);
	}

	@Override
	public List<PJFixRecord> forFirstUnit(long firstunitid,int rjhmId) {
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId);
		return fittingDao.forFirstUnit(firstunitid,fittingNums);
	}
	
	@Override
	public List<PJFixRecord> forPjStaticId(long staticId,int rjhmId) {
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId);
		return fittingDao.forFirstUnit(staticId,fittingNums);
	}

	@Override
	public List<PJFixRecord> forNumAndDataPlan(String pjNum) {
		return fittingDao.forFirstUnit(pjNum);
	}

	@Override
	public PJDynamicInfo findDynamicInfoByPjNum(String pjNum) {
		return fittingDao.findDynamicInfoByPjNum(pjNum);
	}
	
	public Map<String,List<PJStaticInfo>> findPJStaticInfoByFirstId(int rjhmId){
		Map<String,List<PJStaticInfo>> map=new HashMap<String,List<PJStaticInfo>>();
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId);
		List<DictFirstUnit> dictFirsts=null;
		if (null != fittingNums && !fittingNums.isEmpty()) {
			dictFirsts= fittingDao.forFittingNumbers(fittingNums);
			for(DictFirstUnit dictFirst:dictFirsts){
				List<PJStaticInfo> staticInfos=fittingDao.findPJStaticInfoByFirstId(dictFirst.getFirstunitid());
				map.put(dictFirst.getFirstunitname(), staticInfos);
			}
		}
		return map;
	}
	
	public List<PJStaticInfo> findPJStaticInfo(int rjhmId){
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId);
		List<DictFirstUnit> dictFirsts=null;
		List<Long> list=new ArrayList<Long>();
		if (null != fittingNums && !fittingNums.isEmpty()) {
			dictFirsts= fittingDao.forFittingNumbers(fittingNums);
			for(DictFirstUnit dictFirst:dictFirsts){
				list.add(dictFirst.getFirstunitid());
			}
			return fittingDao.forStaticInfo(list);
		}
		return null;
	}
	
	public List<PJStaticInfo> findPJStaticInfo(int rjhmId,long bzId){
		List<String> fittingNums = fittingDao.findFittingNumberForFixRec(rjhmId,bzId);
		List<DictFirstUnit> dictFirsts=null;
		List<Long> list=new ArrayList<Long>();
		if (null != fittingNums && !fittingNums.isEmpty()) {
			dictFirsts= fittingDao.forFittingNumbers(fittingNums);
			for(DictFirstUnit dictFirst:dictFirsts){
				list.add(dictFirst.getFirstunitid());
			}
			return fittingDao.forStaticInfo(list);
		}
		return null;
	}

	@Override
	public PJStaticInfo findPJStaticInfoById(Long pjsid) {
		return fittingDao.findPJStaticInfoById(pjsid);
	}

	@Override
	public List<PJFixItem> findPjFixItemByStaticId(long staticId) {
		return fittingDao.findPjFixItemByStaticId(staticId);
	}

	@Override
	public List<PJFixRecord> findPJFixRecordByDid(Long pjdid) {
		return fittingDao.findPJFixRecordByDid(pjdid);
	}

	@Override
	public int findDynamicInZxFixItem(Long pjsid, List<String> pjNums) {
		return fittingDao.findDynamicInZxFixItem(pjsid, pjNums);
	}

	@Override
	public List<PJDynamicInfo> findPJDynamicInfoByPjNums(Long pjsid, List<String> pjNums) {
		return fittingDao.findPJDynamicInfoByPjNums(pjsid, pjNums);
	}

	@Override
	public PJFixRecord findPJFixRecordByRjhmId(Integer rjhmId,Long pjdid) {
		return fittingDao.findPJFixRecordByRjhmId(rjhmId,pjdid);
	}

	@Override
	public List<PJFixRecord> findPJFixRecordByDid(Long pjdid, Long pjRecId,Long bzId) {
		return fittingDao.findPJFixRecordByDid(pjdid,pjRecId,bzId);
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByDID(Long pjdid) {
		return fittingDao.findPJDynamicInfoByDID(pjdid);
	}

	@Override
	public List<PJStaticInfo> findPJStaticInfoByXXPJNums(List<String> pjNums) {
		return fittingDao.findPJStaticInfoByXXPJNums(pjNums);
	}
}
