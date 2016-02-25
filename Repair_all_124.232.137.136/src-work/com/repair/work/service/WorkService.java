package com.repair.work.service;

import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

/**
 * 检修作业
 * @author Administrator
 *
 */
public interface WorkService {
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 内容：
	 * 根据pjdid(配件id)修改PJ_DynamicInfo表中StorePosition字段值为2(存储位置：0-中心库，1-班组，2-车上，3-外地，4-配件上)，GetOnNum字段为jcnum(机车编号)。
	 * 并把pjNums(配件编号)，以字符串类型的格式，如：001，002...存储在变量，pjNum中，然后根据preDictId（报活主键id），查找jt_PreDict（报活记录表），
	 * 找出报活记录，修改其UpPjNum字段（配件编号），把pjNum的值更新其中。
	 * @param pjNumArray（更新配件编号数组),pjNumOldArray(原配件编号数组),jcnum(机车编号),preDictId（报活记录id）
	 * @return void
	 */
	public void updatePJDynamicInfosByPjNumAndJtPreDict(String[] pjNumArray,String [] pjNumOldArray,String jcnum,Integer preDictId,Integer planId);
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 内容：
	 * 根据pjdid(配件id)修改PJ_DynamicInfo表中StorePosition字段值为2(存储位置：0-中心库，1-班组，2-车上，3-外地，4-配件上)，GetOnNum字段为jcnum(机车编号)。
	 * 并把pjNum(配件编号)，以字符串类型的格式，如：001，002...存储在变量，pjNum中，然后根据preDictId（报活主键id），查找jt_PreDict（报活记录表），
	 * 找出报活记录，修改其UpPjNum字段（配件编号），把pjNum的值更新其中。
	 * @param pjNumArray{字符串数组，存储元素格式[(pjdid-配件动态id，唯一的）：pjNum-配件编码，有可能重复)]},jcnum(机车编号),preDictId（报活记录id）
	 * @return void
	 */
	public void updateStorePositionsAndGetOnNumsByPjdidForPJDynamicInfos_updateUpPjNumByPreDictIdForJtPreDict
	(String [] pjNumArray,String jcnum,Integer preDictId);

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
	 * 查询作业分工(机修)
	 */
	public List<JCDivision> listJCDivision(int rjhmId, Long bzId);
	
	/**
	 * 添加作业分工(机修)
	 * @param rjhmId 日计划ID
	 * @param presetId 预设大类ID
	 * @param leader 工长
	 * @param workersId 分配的工人ID "125,125,125"
	 * @param jcnum 机车号
	 * @param jctype 机车类型
	 */
	public void saveJCDivision(int rjhmId, String presetId,UsersPrivs leader,String workersId,String jcnum,String jctype);
	
	/**
	 * 删除作业分工(机修)
	 */
	public long deleteJCDivision(int proSetId);
	
	/**
	 * 工人查询派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 * @param flag true 查询我的项目  false 查询不是我的检修项目
	 */
	public List<JCFixrec>  listMyJCFixRec(int rjhmId,UsersPrivs userId,short itemType,boolean flag);
	
	/**
	 * 修改检修记录（机修）
	 */
	public void updateJCFixRec(JCFixrec jcFixrec);
	
	/**
	 * 工人查询中修派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 * @param flag true 查询我的项目  false 查询不是我的检修项目
	 */
	public List<JCZXFixRec>  listMyJCZxFixRec(int rjhmId,UsersPrivs userId,short itemType,boolean flag);
	
	/**
	 * 查询中修记录
	 */
	public List<JCZXFixRec> listJCZXFixRec(int rjhmId,Long bzId);
	
	/**
	 * 查询已分工的项目记录(报活、临修、加改)
	 */
	public List<JtPreDict> listJtPreDictByDivisionStatus(int rjhmId,Long bzId);
	
	/**
	 * 修改项目记录(报活、临修、加改)
	 */
	public void updateJtPreDict(int recId, String workersId);
	
	/**
	 * 取消分工(报活、临修、加改)
	 */
	public long deleteJtPreDictDivision(int recId);
	
	/**
	 * 查询已分工的项目记录(春鉴、秋整)
	 */
	public List<JCQZFixRec> listJCQZFixRec(int rjhmId,Long bzId);
	
	/**
	 * 添加项目记录(春鉴、秋整)
	 */
	public void saveJCQZFixRec(int rjhmId,int itemId,String workersId,long bzId);
	
	/**
	 * 删除项目记录(春鉴、秋整)
	 */
	public long deleteJCQZFixRec(long recId);
	
	/**
	 * 工人签字(机修)
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 * @throws JSONException 
	 * @throws Exception 
	 */
	public String updateJCFixRecOfWokerRatify(short type,int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker, JSONObject itemJsonObj) throws Exception;
	
	/**
	 * 中修工人签字(机修)
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 * @throws JSONException 
	 * @throws Exception 
	 */
	public String updateJCZxFixRecOfWokerRatify(short type,int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker, JSONObject itemJsonObj) throws Exception;
	
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
	 * 根据日计划查找内燃交车试验数据
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
	 * 查找明细表
	 */
	public DlJcJyMxb queryDlJcJyMxbById(Integer jymxId);
	
	/**
	 * 保存内燃机车交车项目
	 * @throws Exception 
	 */
	public void saveOrUpdateNrFinishItem(NrJcJyzb nrJcJyzb);
	
	/**
	 * 保存电力机车交车试验明细表
	 */
	public String saveOrUpdateDlJcJyMxb(DlJcJyMxb dlJcJyMxb);
	
	/**
	 * 保存电力机车交车试验主表
	 */
	public String saveOrUpdateDlJcJyzb(DlJcJyZb dlJcJyZb);
	
	
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
	 * 查询配动态信息
	 * @return
	 */
	public PJDynamicInfo findPJDynamicInfoByNum(String pjNum);
	
	/**
	 * 查询配件静态信息
	 */
	public PJStaticInfo findPJStaticInfoById(Long stdId);
	
	/**
	 * 查找配件检修记录
	 * @param pjDid
	 * @return
	 */
	public PJFixRecord findPJFixRecordByPjDid(Long pjDid);
	
	/**
	 * 保存更新配件检修记录
	 * @param pJFixRecord
	 */
	public void saveOrUpdatePJFixRecord(PJFixRecord pJFixRecord);
	
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pJDynamicInfo);
	
	/**
	 * 查找配件检修项目
	 * @param pjSid
	 * @return
	 */
	public List<PJFixItem> findPJFixItemByPjSid(Long pjSid);
	
	/**
	 * 根据拼音查询班组
	 */
	public DictProTeam findDictProTeamByPY(String py);
	
	/**
	 * 更新探伤裂损情况
	 */
	public void updateJCFixRecOfDealSituation(Long id,String dealSituation);
	
	/**
	 * 复探签字
	 * @param type 1:中修 2：配件
	 */
	public void updateReptSign(List<Long> ids,UsersPrivs user,String time,int type);
	
	/**
	 * 更新配件检修--探伤裂损情况
	 */
	public void updatePJFixRecOfDealSituation(Long id,String dealSituation);
	
	/**
	 * 根据id查询中修记录
	 */
	public JCZXFixRec findZxFixRecordById(Long recId);
	
	
	
	/**
	 * 根据ID获取记录JCFixrec
	 */
	public JCFixrec getJCFixrecById(long jcRecId);
}
