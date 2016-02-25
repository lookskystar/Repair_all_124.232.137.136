package com.repair.part.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;

import com.repair.common.pojo.Addvancetip;
import com.repair.common.pojo.Deliverytip;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictWZNum;
import com.repair.common.pojo.PDeliverytip;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixFlowType;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJHandoverRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.Storetip;
import com.repair.common.util.PageModel;
import com.repair.part.dao.PJDynamicInfoDao;
import com.repair.part.dao.PJManageDao;
import com.repair.part.service.PJManageService;

public class PJManageServiceImpl implements PJManageService {
	@Resource(name="pjManageDao")
	private PJManageDao pjManageDao;
	@Resource(name="pjDynamicInfoDao")
	private PJDynamicInfoDao pjDynamicInfoDao;

	@Override
	public PageModel<PJStaticInfo> findPJStaticInfo(String jcsType,Long firstUnitId,Integer flowTypeId,String pjName, String bzId) {
		return pjManageDao.findPJStaticInfo(jcsType,firstUnitId,flowTypeId,pjName, bzId);
	}
	@Override
	public PageModel<PJStaticInfo> findPJStaticInfo1(String jcsType,String firstUnitName,Integer flowTypeId,String pjName, String bzId) {
		return pjManageDao.findPJStaticInfo1(jcsType,firstUnitName,flowTypeId,pjName, bzId);
	}
	@Override
	public List<DictJcStype> findDictJcStype() {
		return pjManageDao.findDictJcStype();
	}

	@Override
	public List<DictFirstUnit> findDictFirstUnit(String jcsType) {
		return pjManageDao.findDictFirstUnit(jcsType);
	}

	@Override
	public List<PJFixFlowType> findPJFixFlowType() {
		return pjManageDao.findPJFixFlowType();
	}

	@Override
	public void saveOrUpdatePJStaticInfo(PJStaticInfo pjStaticInfo) {
		 pjManageDao.saveOrUpdatePJStaticInfo(pjStaticInfo);
	}

	@Override
	public PJStaticInfo findPJStaticInfoById(Long pjId) {
		return pjManageDao.findPJStaticInfoById(pjId);
	}

	@Override
	public String delPJStaticInfo(String pjIds) {
		String result="信息删除失败!";
		if(pjIds!=null){
			String[] str=pjIds.split(",");
			PJStaticInfo pjStaticInfo=null;
			for(String pjId:str){
				pjStaticInfo=pjManageDao.findPJStaticInfoById(Long.parseLong(pjId));
				pjManageDao.delPJStaticInfo(pjStaticInfo);
			}
			result="信息删除成功!";
		}
		return result;
	}

	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String jcsType,Long firstUnitId,String pjName,
			String pjNum,Integer pjStatus,Integer storePosition,String getOnNum, String bzId) {
		return pjManageDao.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, bzId);
	}
	
	public List<PJDynamicInfo> findPJDynamicInfoHandover(Integer pjStatus,String pjName,String pjNum) {
		return pjManageDao.findPJDynamicInfoHandover(pjStatus,pjName,pjNum);
	}

	@Override
	public String delPJDyInfo(String pjIds) {
		String result="信息删除失败!";
		if(pjIds!=null){
			String[] str=pjIds.split(",");
			PJDynamicInfo pjDynamicInfo=null;
			for(String pjId:str){
				pjDynamicInfo=pjManageDao.findPJDynamicInfoById(Long.parseLong(pjId));
				//删除配件报活
				pjManageDao.delPJPredict(pjDynamicInfo.getPjdid());
				//删除配件检修记录
				pjManageDao.delPJFixRecord(pjDynamicInfo.getPjdid());
				//删除配件动态
				pjManageDao.delPJDyInfo(pjDynamicInfo);
			}
			result="信息删除成功!";
		}
		return result;
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId) {
		return pjManageDao.findPJDynamicInfoById(pjdId);
	}
	
	public long uniquePJNum(String pjnum,Long pjdid){
		return pjManageDao.uniquePJNum(pjnum,pjdid);
	}

	@Override
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pjDynamicInfo) {
		pjManageDao.saveOrUpdatePJDynamicInfo(pjDynamicInfo);
	}
	
	@Override
	public PageModel<Map<PJHandoverRecord, List<PJDynamicInfo>>> findHandoverRecord() {
		PageModel<PJHandoverRecord> pageModel = pjManageDao.findPJHandoverRecord();
		List<Map<PJHandoverRecord, List<PJDynamicInfo>>> list = new ArrayList<Map<PJHandoverRecord,List<PJDynamicInfo>>>();
		for (PJHandoverRecord pjHandoverRecord : pageModel.getDatas()) {
			Map<PJHandoverRecord, List<PJDynamicInfo>> newDatas = new LinkedHashMap<PJHandoverRecord, List<PJDynamicInfo>>();
			List<PJDynamicInfo> handoverFitting = pjManageDao.findPJDynamicInfoByHandoverRecord(pjHandoverRecord.getId());
			newDatas.put(pjHandoverRecord, handoverFitting);
			list.add(newDatas);
		}
		PageModel<Map<PJHandoverRecord, List<PJDynamicInfo>>> newPageModel = new PageModel<Map<PJHandoverRecord, List<PJDynamicInfo>>>();
		newPageModel.setCount(pageModel.getCount());
		newPageModel.setDatas(list);
		return newPageModel;
	}

	@Override
	public void addHandoverRecord(PJHandoverRecord handoverRecord) {
		pjManageDao.addHandoverRecord(handoverRecord);
	}

	@Override
	public void updatePJDynamicInfo(int hrId, List<Long> pjdIds) {
		pjManageDao.updatePJDynamicInfo(hrId, pjdIds);		
	}

	@Override
	public PJHandoverRecord findPJHandoverRecord(int id) {
		return pjManageDao.findPJHandoverRecord(id);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid) {
		return pjManageDao.findPJFixRecord(pjdid);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long recId) {
		return pjManageDao.findPJFixRecord(pjdid,recId);
	}

	@Override
	public String updatePjStatus(String pjIds) {
		String result="状态更新失败!";
		if(pjIds!=null){
			String[] str=pjIds.split(",");
			for(String pjId:str){
				pjManageDao.updatePjStatus(Long.parseLong(pjId));
			}
			result="状态更新成功!";
		}
		return result;
	}

	@Override
	public PageModel<DictWZNum> findDictWzNum(String pjName) {
		return pjManageDao.findDictWzNum(pjName);
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByPJNum(String pjNum) {
		return pjManageDao.findPJDynamicInfoByPJNum(pjNum);
	}

	public List<?> findPartCount(String jcType) {
		return pjManageDao.findPartCount(jcType);
	}
	
	public List<?> findPartCountWith(String jcType){
		return pjManageDao.findPartCountWith(jcType);
	}

	@Override
	public int findCountParts(Long firstUnitId, Integer status, String jcType) {
		return pjManageDao.findCountParts(firstUnitId, status, jcType);
	}

	@Override
	public int findCountPartsOnTrain(Long firstUnitId, Integer storePosition,
			String jcType) {
		return pjManageDao.findCountPartsOnTrain(firstUnitId, storePosition,
				jcType);
	}

	@Override
	public void updatePjComments(Long pjdId, String comments) {
		pjManageDao.updatePjComments(pjdId, comments);
	}

	@Override
	public void savePJFixRecord(PJFixRecord pjFixRecord) {
		pjManageDao.savePJFixRecord(pjFixRecord);
		
	}

	@Override
	public PageModel<Deliverytip> findDeliverytip(PDeliverytip pDeliverytip) {
		return pjManageDao.findDeliverytip(pDeliverytip);
	}

	@Override
	public void saveDeliverytip(PDeliverytip pDeliverytip) throws IllegalAccessException, InvocationTargetException {
		//保存配件交接单
		Deliverytip deliverytipDb = new Deliverytip();
		BeanUtils.copyProperties(deliverytipDb, pDeliverytip);
		String[] pjdidArray =  null;
		List<String> pjnumList = null;
		if(StringUtils.isNotEmpty(pDeliverytip.getId())){
			//配件交接单领取状态 1:交旧 2：承修 ：3发件
			deliverytipDb.setStatus("3");
			if(StringUtils.isNotEmpty(pDeliverytip.getComments())){
				deliverytipDb.setComments("正常");
			}
			//更改发件动态配件存储位置: 1 班组  状态  0  合格
			pjdidArray = pDeliverytip.getReceivepjnum().split(",");
			pjnumList = new ArrayList<String>();
			for (String pjnum : pjdidArray) {
				pjnumList.add(pjnum);
			}
			pjDynamicInfoDao.changePJDynamicInfoStorePosition(pjnumList, 1, 0);
		}else{
			deliverytipDb.setId(UUID.randomUUID().toString());
			deliverytipDb.setStatus("1");
			//更改交旧动态配件存储位置: 1 班组  状态 1 待修
			pjdidArray = pDeliverytip.getOldpjnum().split(",");
			pjnumList = new ArrayList<String>();
			for (String pinum : pjdidArray) {
				pjnumList.add(pinum);
			}
			pjDynamicInfoDao.changePJDynamicInfoStorePosition(pjnumList, 1, 1);
		}
		//配件交接单状态 1:存在 2:删除
		deliverytipDb.setIsactive(1);
		pjManageDao.save(deliverytipDb);
		
	}

	@Override
	public void deleteDeliverytip(List<String> indexs) {
		pjManageDao.deleteDeliverytip(indexs);
	}

	@Override
	public void fixSignDeliverytip(List<String> indexs, String username) {
		//更改交旧动态配件存储位置: 1 班组    配件状态变为：3 检修中
		Deliverytip deliverytip = null;
		String[] pjdidArray = null;
		List<String> pjnumList = new ArrayList<String>();
		for (String id : indexs) {
			if(StringUtils.isNotEmpty(id)){
				deliverytip = pjManageDao.findexchangeTipsById(id);
				pjdidArray = deliverytip.getOldpjnum().split(",");
				for (String pjnum : pjdidArray) {
					pjnumList.add(pjnum);
				}
			}
		}
		pjDynamicInfoDao.changePJDynamicInfoStorePosition(pjnumList, 1, 3);
		//配件交接单 承修班组签章状态变为2:承修
		pjManageDao.fixSignDeliverytip(indexs, username, "2");
		
	}

	@Override
	public PDeliverytip findexchangeTipsById(String id) throws IllegalAccessException, InvocationTargetException {
		PDeliverytip pDeliverytip = new PDeliverytip();
		Deliverytip deliverytip = pjManageDao.findexchangeTipsById(id);
		BeanUtils.copyProperties(pDeliverytip, deliverytip);
		return pDeliverytip;
	}

	@Override
	public PageModel<Addvancetip> addvanceTipsList(String getonnum, String pjname, String pjnum, String addvanceperson, String addvancedate, String type) {
		return pjManageDao.addvanceTipsList(getonnum, pjname, pjnum, addvanceperson, addvancedate, type);
	}

	@Override
	public void addvanceTipsAdd(Addvancetip addvancetip) {
		addvancetip.setId(UUID.randomUUID().toString());
		//配件预领单领取状态 1:预领 2:发件
		addvancetip.setStatus("1");
		//配件预领单状态 1:存在 2:删除
		addvancetip.setIsactive(1);
		pjManageDao.save(addvancetip);
	}

	@Override
	public void deleteAddvancetip(List<String> indexs) {
		pjManageDao.deleteAddvancetip(indexs);
	}

	@Override
	public void addvanceTipsStoreSign(List<String> indexs, String xm) {
		pjManageDao.addvanceTipsStoreSign(indexs, xm);
	}

	@Override
	public Addvancetip addvanceTipsDependence(String id) {
		return pjManageDao.addvanceTipsDependence(id);
	}

	@Override
	public PageModel<Storetip> storeInputTipsList(String getofnum, String pjname, String pjnum, String handler, String inputdate, String type) {
		return pjManageDao.storeInputTipsList(getofnum, pjname, pjnum, handler, inputdate, type);
	}

	@Override
	public void saveStoreInputTips(Storetip storetip) {
		//保存配件库存单
		storetip.setId(UUID.randomUUID().toString());
		storetip.setIsactive(1);
		pjManageDao.saveStoreInputTips(storetip);
		//更改交旧动态配件存储位置: 0 中心库 状态 ： 0合格 
		String[] pjdidArray =  storetip.getPjnum().split(",");
		List<String> pjnumlist = new ArrayList<String>();
		for (String pjnum : pjdidArray) {
			pjnumlist.add(pjnum);
		}
		pjDynamicInfoDao.changePJDynamicInfoStorePosition(pjnumlist, 0, 0);
	}

	@Override
	public void deleteStoretip(List<String> indexs) {
		pjManageDao.deleteStoretip(indexs);
	}

	@Override
	public Long findCountPart(Long firstUnitId, Integer status, String jcType, Integer position) {
		return pjManageDao.findCountPart(firstUnitId, status, jcType, position);
	}

}
