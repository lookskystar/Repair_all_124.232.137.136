package com.repair.part.service;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

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

public interface PJManageService {
	
	/**
	 * 根据条件查询所有的静态配件信息
	 * @param jcsType
	 * @param firstUnitId
	 * @param flowTypeId
	 * @param pjName
	 * @return
	 */
	public PageModel<PJStaticInfo> findPJStaticInfo(String jcsType,Long firstUnitId,Integer flowTypeId,String pjName, String bzId);
	
	/**
	 * 唐倩 2015-7-28 根据一级部件名称查询
	 * @param jcsType
	 * @param firstUnitName
	 * @param flowTypeId
	 * @param pjName
	 * @param bzId
	 * @return
	 */
	public PageModel<PJStaticInfo> findPJStaticInfo1(String jcsType,String firstUnitName,Integer flowTypeId,String pjName, String bzId);
	
	/**
	 * 机车类型信息
	 * @return
	 */
	public List<DictJcStype> findDictJcStype();
	
	/**
	 * 查询配件流程类型
	 * @return
	 */
	public List<PJFixFlowType> findPJFixFlowType();
	
 	/**
	 * 根据机车类型得到一级部件信息
	 * @return
	 */
	public List<DictFirstUnit> findDictFirstUnit(String jcsType);
	
	/**
	 * 保存配件静态信息
	 * @param pjStaticInfo
	 */
	public void saveOrUpdatePJStaticInfo(PJStaticInfo pjStaticInfo);
	
	/**
	 * 根据配件ID查询配件静态信息
	 * @param pjId
	 * @return
	 */
	public PJStaticInfo findPJStaticInfoById(Long pjId);
	
	/**
	 * 删除静态配件信息
	 * @param pjIds
	 * @return
	 */
	public String delPJStaticInfo(String pjIds);
	
	/**
	 * 查询配件动态信息
	 * @return
	 */
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String jcsType,Long firstUnitId,String pjName,String pjNum,Integer pjStatus,Integer storePosition,String getOnNum, String bzId);
	/**
	 * 配件交接查询配件动态
	 * @param pjName
	 * @param pjNum
	 * @return
	 */
	public List<PJDynamicInfo> findPJDynamicInfoHandover(Integer pjStatus,String pjName,String pjNum);
	
	/**
	 * 添加动态配件信息
	 */
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pjDynamicInfo);
	
	/**
	 * 根据配件ID查询配件动态信息
	 * @param pjdId
	 * @return
	 */
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId);
	
	/**
	 * 根据配件编号查找配件信息
	 * @param pjNum
	 * @return
	 */
	public PJDynamicInfo findPJDynamicInfoByPJNum(String pjNum);
	
	/**
	 * 判断同类配件编码是否唯一
	 * @param pjnum 配件编码
	 */
	public long uniquePJNum(String pjnum,Long pjdid);
	
	/**
	 * 删除动态配件信息
	 * @param pjIds
	 * @return
	 */
	public String delPJDyInfo(String pjIds);
	
	/**
	 * 查询交接记录
	 * @return
	 */
	PageModel<Map<PJHandoverRecord, List<PJDynamicInfo>>> findHandoverRecord();
	
	/**
	 * 添加配件交接记录
	 * @param handoverRecord
	 */
	void addHandoverRecord(PJHandoverRecord handoverRecord);
	
	/**
	 * 修改动态配件添加交接记录
	 * @param hrId
	 * @param pjdIds
	 */
	void updatePJDynamicInfo(int hrId, List<Long> pjdIds);
	
	/**
	 * 根据ID查找配件交接记录
	 * @param id
	 * @return
	 */
	PJHandoverRecord findPJHandoverRecord(int id);
	
	/**
	 * 根据动态配件ID查询配件检修记录
	 * @param pjdid
	 * @return
	 */
	public List<PJFixRecord> findPJFixRecord(Long pjdid);
	
	/**
	 * 根据动态配件ID和日计划ID查询配件检修记录
	 * @param pjdid
	 * @return
	 */
	public List<PJFixRecord> findPJFixRecord(Long pjdid,Long recId);
	
	/**
	 * 将配件状态改为待修
	 * @param pjIds
	 */
	public String updatePjStatus(String pjIds);
	
	/**
	 * 查询物资编码
	 * @param pjName
	 * @return
	 */
	public PageModel<DictWZNum> findDictWzNum(String pjName);
	
	/**
	 * 查询配件数量信息
	 * */
	public List findPartCount(String jcType);
	
	public List<?> findPartCountWith(String jcType);

	/**
	 * 查询各状态下的配件数量
	 * 
	 * @param firstUnitId
	 * @param status
	 * @return
	 */
	public int findCountParts(Long firstUnitId, Integer status, String jcType);
	
	public Long findCountPart(Long firstUnitId, Integer status, String jcType, Integer position);
	
	/**
	 * 查询各专业已上车配件数量
	 */
	public int findCountPartsOnTrain(Long firstUnitId, Integer storePosition,
			String jcType);
	// /**
	// * 查找配件检修项目
	// * @param pjSid
	// * @return
	// */
	// public List<PJFixItem> findPJFixItemByPjDid(Long pjSid);
	
	/**
	 * 更新配件备注信息
	 */
	public void updatePjComments(Long pjdId,String comments);
	
	/**
	 * 新增一条配件检修记录
	 * @param pjFixRecord
	 */
	void savePJFixRecord(PJFixRecord pjFixRecord);
	
	/**
	 * 查询配件交接单 
	 */
	public PageModel<Deliverytip> findDeliverytip(PDeliverytip pDeliverytip);
	
	/**
	 * 添加配件交接单
	 */
	public void saveDeliverytip(PDeliverytip pDeliverytip)throws IllegalAccessException, InvocationTargetException;
	
	public void deleteDeliverytip(List<String> indexs);

	public void fixSignDeliverytip(List<String> indexs, String username);

	public PDeliverytip findexchangeTipsById(String id)throws IllegalAccessException, InvocationTargetException;

	public PageModel<Addvancetip> addvanceTipsList(String getonnum, String pjname, String pjnum, String addvanceperson, String addvancedate, String type);

	public void addvanceTipsAdd(Addvancetip addvancetip);

	public void deleteAddvancetip(List<String> indexs);

	public void addvanceTipsStoreSign(List<String> indexs, String xm);

	public Addvancetip addvanceTipsDependence(String id);

	public PageModel<Storetip> storeInputTipsList(String getofnum, String pjname, String pjnum, String handler, String inputdate, String type);

	public void saveStoreInputTips(Storetip storetip);

	public void deleteStoretip(List<String> indexs);

}
