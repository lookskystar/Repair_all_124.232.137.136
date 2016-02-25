package com.repair.part.dao;

import java.util.List;

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

/**
 * 配件管理Dao类
 * @author Administrator
 *
 */
public interface PJManageDao {
	
	/**
	 * 查询所有的静态配件信息
	 * @return
	 */
	public PageModel<PJStaticInfo> findPJStaticInfo(String jcsType,Long firstUnitId,Integer flowTypeId,String pjName, String bzId);
	
	public PageModel<PJStaticInfo> findPJStaticInfo1(String jcsType,String firstUnitName,Integer flowTypeId,String pjName, String bzId);
	/**
	 * 机车类型信息
	 * @return
	 */
	public List<DictJcStype> findDictJcStype();
	
	/**
	 * 根据机车类型得到一级部件信息
	 * @return
	 */
	public List<DictFirstUnit> findDictFirstUnit(String jcsType);
	
	/**
	 * 查询配件流程类型
	 * @return
	 */
	public List<PJFixFlowType> findPJFixFlowType();
	
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
	 * @param pjStaticInfo
	 */
	public void delPJStaticInfo(PJStaticInfo pjStaticInfo);
	
	/**
	 * 查询配件动态信息
	 * @return
	 */
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String jcsType,Long firstUnitId,String pjName,
			String pjNum,Integer pjStatus,Integer storePosition,String getOnNum, String bzId);
	
	
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
	public void delPJDyInfo(PJDynamicInfo pjDynamicInfo);
	
	/**
	 * 删除配件检修记录
	 */
	public void delPJFixRecord(Long pjDynamicId);
	
	/**
	 * 删除配件报活
	 */
	public void delPJPredict(Long pjDynamicId);
	
	/**
	 * 获取配件交接记录
	 * @return
	 */
	PageModel<PJHandoverRecord> findPJHandoverRecord();
	
	/**
	 * 根据配件交接记录找到交接配件
	 * @param hrId 配件交接记录标识
	 * @return
	 */
	List<PJDynamicInfo> findPJDynamicInfoByHandoverRecord(int hrId);

	/**
	 * 添加配件交接记录
	 * @param handoverRecord
	 */
	void addHandoverRecord(PJHandoverRecord handoverRecord);

	/**
	 * 配件交接查询配件动态
	 * @param pjName
	 * @param pjNum
	 * @return
	 */
	List<PJDynamicInfo> findPJDynamicInfoHandover(Integer pjStatus,String pjName,String pjNum);

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
	public void updatePjStatus(Long pjId);

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

	/**
	 * 查询各状态下的配件数量
	 * 
	 * @param firstUnitId
	 * @param status
	 * @return
	 */
	public int findCountParts(Long firstUnitId, Integer status, String jcType);

	/**
	 * 查询各专业已上车配件数量
	 */
	public int findCountPartsOnTrain(Long firstUnitId, Integer storePosition,
			String jcType);
	
	/**
	 * 更新配件备注信息
	 */
	public void updatePjComments(Long pjdId,String comments);
	
	/**
	 * 新增一条配件检修记录
	 * @param pjFixRecord
	 */
	void savePJFixRecord(PJFixRecord pjFixRecord);
	
	public PageModel<Deliverytip> findDeliverytip(PDeliverytip pDeliverytip);
	
	public void save(Deliverytip deliverytip);
	
	public Integer deleteDeliverytip(List<String> indexs);

	public void fixSignDeliverytip(List<String> indexs, String username, String status);

	public Deliverytip findexchangeTipsById(String id);

	public PageModel<Addvancetip> addvanceTipsList(String getonnum, String pjname, String pjnum, String addvanceperson, String addvancedate, String type);

	public void save(Addvancetip addvancetip);

	public Integer deleteAddvancetip(List<String> indexs);

	public void addvanceTipsStoreSign(List<String> indexs, String xm);

	public Addvancetip addvanceTipsDependence(String id);

	public PageModel<Storetip> storeInputTipsList(String getofnum, String pjname, String pjnum, String handler, String inputdate, String type);

	public void saveStoreInputTips(Storetip storetip);

	public Integer deleteStoretip(List<String> indexs);

	public Long findCountPart(Long firstUnitId, Integer status, String jcType, Integer position);
	
	public List<?> findPartCountWith(String jcType);

}
