package com.repair.work.dao;

import java.io.IOException;
import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

/**
 * 检修作业
 * @author Administrator
 *
 */
public interface WorkDao {
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 根据pjdid得到PJDynamicInfo对象
	 * @param pjdid
	 * @return pJDynamicInfo
	 */
	public PJDynamicInfo getPJDynamicInfoByPjdid(Long pjdid);
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 修改PJDynamicInfo对象的storePosition属性为2，把上车编码更新到getOnNum属性中（上车编号在action中通过日计划id获得）
	 * @param pJDynamicInfo
	 */
	public void updateStorePositionAndGetOnNumForPJDynamicInfoByPjdid(PJDynamicInfo pJDynamicInfo);
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 保存JtPreDict对象
	 * @param preDictId
	 * @return
	 */
	public void updateUpPjNumForJtPreDictByPreDictId(JtPreDict jtPreDict);
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 通过preDictId得到JtPreDict对象
	 * @param preDictId
	 * @return
	 */
	public JtPreDict getJtPreDictBypreDictId(Integer preDictId);

	/**
	 * 作者：黄亮
	 * 时间：2015-5-25
	 * 通过pjdid（配件动态id）修改PJDynamicInfo表的storePosition字段值为2,把getOnNum更新为jcnum。
	 */
	public void updateStorePositionByPjdid(String pjdid,Integer storePosition,String jcnum);
	
	/**
	 * 查询日计划机车列表(状态)
	 * @param bzId 班组ID
	 * @param planStatue 计划状态
	 */
	public List<DatePlanPri> findDyPlanJC(long bzId,int statue,Integer nodeId);
	
	/**
	 * 查询作业分工(工长分工时查看作业分工记录--机修)
	 */
	public List<JCDivision> listJCDivision(int rjhmId, Long bzId);
	
	/**
	 * 查询作业分工(工长分工)
	 */
	public List<JCDivision> listJCDivision(int rjhmId, int presetId);
	
	/**
	 * 新增派工（机修）
	 */
	public void addJCDivision(JCDivision division);
	
	/**
	 * 新增派工记录表
	 */
	public void saveOrUpdateJCFixrec(int rjhmId,int presetId, String workersId, long bzId,String jcnum, String jctype,String date);
	
	/**
	 * 判断用户是否已存在该大类的分工(机修)
	 */
	public JCDivision getJCDivision(long userId, int presetId,int rjhmId);
	
	/**
	 * 根据ID获取分工大类(机修)
	 */
	public JCDivision getJCDivisionById(int divisionId);
	
	/**
	 * 统计工人已完成项目数(机修)
	 */
	public long countWorkedItems(int presetId,String userXM, int rjhmId);
	
	/**
	 * 删除分工(机修)
	 */
	public void deleteDivison(JCDivision division);
	
	/**
	 * 修改检修人（机修）
	 */
	public void updateJcFixrecWorkersId(String workersId,int rjhmId,int presetId);
	
	/**
	 * 删除检修记录（机修）
	 */
	public void deleteJcFixRec(int rjhmId,int presetId);
	
	/**
	 * 工人查询派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 * @param signFlag 0:未签 1：全部
	 * @param flag true 查询我的项目  false 查询不是我的检修项目
	 */
	public List<JCFixrec>  listMyJCFixRec(int rjhmId,UsersPrivs userId,short itemType,Integer signFlag,boolean flag);
	
	/**
	 * 工人查询中修派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 * @param flag true 查询我的项目  false 查询不是我的检修项目
	 */
	public List<JCZXFixRec>  listMyJCZxFixRec(int rjhmId,UsersPrivs userId,short itemType,Integer signFlag,boolean flag);
	
	/**
	 * 查询中修记录
	 */
	public List<JCZXFixRec> listJCZXFixRec(int rjhmId,Long bzId);
	
	/**
	 * 修改接活时间(机修)
	 */
	public void updateJCFixRec(String jhTime,int rjhmId,long userId);
	
	/**
	 * 查询已分工的项目记录(临修、加改)
	 */
	public List<JtPreDict> listJtPreDictByDivisionStatus(int rjhmId,Long bzId);
	
	/**
	 * 查询已分工的项目记录(春鉴、秋整)
	 */
	public List<JCQZFixRec> listJCQZFixRec(int rjhmId,Long bzId);
	
	/**
	 * 添加或修改项目记录(春鉴、秋整)
	 */
	public void saveOrUpdateJCQZFixRec(JCQZFixRec jcqzFixRec);
	
	/**
	 * 根据ID获取春鉴、秋整项目
	 */
	public JCQZItems getJCQZItemsById(int itemId);
	
	/**
	 * 根据ID获取记录JCFixrec
	 */
	public JCFixrec getJCFixrecById(long jcRecId);
	
	/**
	 * 根据ID获取记录JCZXFixRec
	 */
	public JCZXFixRec getJCZXFixRecById(long jcRecId);
	
	/**
	 * 修改
	 */
	public void updateJCFixRec(JCFixrec jcFixrec);
	
	/**
	 * 修改中修
	 */
	public void updateJCZXFixRec(JCZXFixRec jcFixrec);
	
	/**
	 * 查询检修记录
	 * @param jcrecid
	 * @return
	 */
	public JCFixrec queryJCFixrecByID(long jcrecid);
	
	/**
	 * 查询中修检修记录
	 * @param jcrecid
	 * @return
	 */
	public JCZXFixRec queryJCZxFixrecByID(long jcrecid);
	
	/**
	 * 查询检修项目
	 * @param thirdunitid
	 * @return
	 */
	public JCFixitem queryJCFixitemByID(int thirdunitid);
	
	/**
	 * 查询中修检修项目
	 * @param thirdunitid
	 * @return
	 */
	public JCZXFixItem queryJCZxFixitemByID(int thirdunitid);
	
	/**
	 * 根据预设分工ID查询报活项目
	 * @param divisionId
	 * @return
	 */
	public List<JtPreDict> queryJtPreDictByDivisionId(Integer divisionId);
	
	/**
	 * 根据日计划查找内燃机车交车试验数据
	 */
	public NrJcJyzb queryNrJcJyzb(Integer rjhmId);
	
	/**
	 * 根据日计划查找电力机车交车试验数据
	 */
	public DlJcJyZb queryDlJcJyZb(Integer rjhmId);
	
	/**
	 * 根据电力机车交车项目主表查找明细表
	 */
	public List<DlJcJyMxb> queryDlJcJyMxb(Integer jyzId);
	
	/**
	 * 保存内燃机车交车试验
	 */
	public void saveOrUpdateNrJcJyzb(NrJcJyzb nrJcJyzb);
	
	/**
	 * 保存电力机车交车试验主表
	 */
	public String saveOrUpdateDlJcJyzb(DlJcJyZb dlJcJyZb);
	
	/**
	 * 保存电力机车交车试验明细表
	 */
	public String saveOrUpdateDlJcJyMxb(DlJcJyMxb dlJcJyMxb);
	
	/**
	 * 查找明细表
	 */
	public DlJcJyMxb queryDlJcJyMxbById(Integer jymxId);
	
	/**
	 * 判断配件编号是否存在于动态配件信息中
	 * @param pjNum
	 * @return
	 */
	public Long countPjInfoByPjNum(String pjNum);
	
	/**
	 * 保存项目记录信息
	 * @param jcZxFixRec
	 */
	public void saveOrUpdateJCZXFixRec(JCZXFixRec jcZxFixRec);
	
	/**
	 * 查询配件动态信息
	 * @return
	 */
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String type, String pjName,String pjNum,String jcType);
	
	/**
	 * 根据配件ID查询配件动态信息
	 * @param pjdId
	 * @return
	 */
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId);
	
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
	public List<PJFixRecord> findPJFixRecord(Long pjdid,Long planId);
	
	/**
	 * 查找中修检修记录
	 * @param id
	 * @return
	 */
	public JCZXFixRec findJCZXFixRec(Long id);
	
	/**
	 * 查询配件静态信息
	 * @return
	 */
	public PJDynamicInfo findPJDynamicInfoByNum(String pjNum);
	
	/**
	 * 查找配件检修记录
	 * @param pjDid
	 * @return
	 */
	public PJFixRecord findPJFixRecordByPjDid(Long pjDid);
	
	public PJFixRecord getPJFixRecordByPjRecId(Long recId);
	/**
	 * 保存更新配件检修记录
	 * @param pJFixRecord
	 */
	public void saveOrUpdatePJFixRecord(PJFixRecord pJFixRecord);
	
	
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pJDynamicInfo);
	
	public List<PJFixItem> findPJFixItemByPjSid(Long pjSid);
	
	/**
	 * 复探签字
	 */
	public void updateReptSign(List<Long> ids,UsersPrivs user,String time,int type);
	
}
