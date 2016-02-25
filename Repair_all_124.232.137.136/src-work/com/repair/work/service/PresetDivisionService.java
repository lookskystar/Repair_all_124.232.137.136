package com.repair.work.service;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCCharge;
import com.repair.common.pojo.JCChoice;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJPresetRelateID;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.PresetRelateID;
import com.repair.common.pojo.UsersPrivs;

/**
 * 预设分工
 * @author Administrator
 *
 */
public interface PresetDivisionService {
	
	/**
	 * 根据机车类型和班组ID查选班组下的预设分工信息
	 * @param jcType
	 * @param proteamid
	 * @return
	 */
	public List<PresetDivision> getPresetDivisonByTypeId(String jcType,Long proteamid,Integer nodeId);
	
	/**
	 * 根据班组ID和机车类型查询班组下的检修项目
	 */
	public List<JCFixitem> getJCFixitemByBzId(String jcType, Long proteamid, Integer nodeId);
	
	/**
	 * 根据班组ID和机车类型查询班组下的检修项目
	 */
	public List<JCZXFixItem> getJCZxFixitemByBzId(String jcType, Long proteamid, Integer nodeId);
	
	/**
	 * 添加预设分工信息
	 * @param pd
	 */
	public void savePresetDivison(PresetDivision pd);
	
	/**
	 * 根据ID获取对象
	 */
	public PresetDivision getPresetDivisionById(Integer presetId);
	
	/**
	 *  根据ID获取对象
	 * @param presetId
	 * @return
	 */
	public PJPresetDivision getPJPresetDivisionById(Long presetId);
	
	/**
	 * 保存项目和预设分类信息
	 * 更新机车项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void savePresetRelateId(String[] ids,Integer presetId);
	
	/**
	 * 保存中修项目和预设分类信息
	 * 更新机车项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void saveZxPresetRelateId(String[] ids,Integer presetId);
	
	/**
	 * 保存配件项目和预设分类信息
	 * 更新机车项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void savePJPresetRelateId(String[] ids,Long presetId);
	
	/**
	 * 根据预设分类Id查找预设项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PresetRelateID> getPresetRelateByYsId(int ysId);
	
	/**
	 * 根据预设分类Id查找预设配件项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PJPresetRelateID> getPJPresetRelateByYsId(Long ysId);
	
	/**
	 * 根据预设分类Id查找预设项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PresetRelateID> getPresetRelateByYsId(Integer[] ysId);
	
	/**
	 * 根据预设ID删除预设信息
	 * @param ysId
	 */
	public void delPresetDivisonByYsId(int ysId);
	
	/**
	 * 根据预设ID删除预设信息
	 * @param ysId
	 */
	public void delPJPresetDivisonByYsId(Long ysId);
	
	/**
	 * 查询所有的机车型号
	 */
	public List<DictJcStype> listJcSType();
	
	/**
	 * 查询我的分工
	 */
	public List<DatePlanPri> listMyJCDivision(long userId);
	
	/**
	 * 得到所有班组信息
	 * @return
	 */
	public List<DictProTeam> getDictProTeamAll();
	
	/**
	 * 根据班组ID获得班组下的检修项目
	 * @param bzId
	 * @return
	 */
	public List<JCFixitem> getJCFixitemByBzId(long bzId,String jcType);
	
	/**
	 * 保存质检、技术管辖班组信息
	 */
	public void saveCharge(String[] itemIds,long teamId,UsersPrivs user,int status);
	
	/**
	 * 保存质检、技术管辖机车信息
	 * @param ids
	 * @param user
	 */
	public void saveChoice(String[] ids,UsersPrivs user);
	
	/**
	 * 根据用户ID查询技术、质检用户下所分配的班组信息
	 * @param user
	 * @return
	 */
	public List<DictProTeam> getJCChargeByBzUser(UsersPrivs user);
	
	/**
	 * 根据班组名获得班组信息
	 * @param proteamid
	 * @return
	 */
	public DictProTeam getDictProTeamById(long proteamid);
	
	/**
	 * 根据检修项目ID查询相应的管辖班组信息
	 * @param itemId
	 * @return
	 */
	public List<JCCharge> getJCChargeByItemId(int itemId);
	
	  /**
     * 根据用户ID和班组ID查询相应的管辖班组信息
     * @param user
     * @param itemId
     * @return
     */
	public List<JCCharge> getJCChargeByItemUserId(UsersPrivs user,long proteamid);
	
	/**
	 * 根据用户ID和班组ID删除相应的管辖班组信息
	 * @param user
	 * @param itemId
	 */
	public void deleteJcCharge(UsersPrivs user,long proteamid);
	
	/**
	 * 查询待修机车
	 * @return
	 */
	public List<DatePlanPri> getDivsionJc();
	
	/**
	 * 根据用户ID查询用户负责的机车
	 * @param user
	 * @return
	 */
	public List<JCChoice> getJCChoiceByUser(UsersPrivs user);
	
	/**
	 * 查询用户负责的在修机车
	 * @param user
	 * @return
	 */
	public List<JCChoice> getJCChoice();
	
	/**
	 * 查询工作班组
	 * @return
	 */
	List<DictProTeam> findWorkDictProTeam();
	
	/**
	 * 查询工作班组
	 * @return
	 */
	List<DictProTeam> findWorkDictProTeam(int zxFlag);
	
	/**
	 * 根据名字查找班组
	 * @param proteamid
	 * @return
	 */
	DictProTeam findDictProTeamByName(String proteamName);
	
	/**
	 * 根据组装项目ID查询预设分类
	 * @param jcChoice
	 */
	public PresetDivision findPresetRelateByFixitemId(int itemId);
	
	/**
	 * 根据组装项目ID查询预设分类
	 * @param jcChoice
	 */
	public PresetDivision findPresetRelateByZxFixitemId(int itemId,String jcType);
	
	/**
	 * 根据机车类型和班组ID查询配件大类信息
	 * @param jcType
	 * @param bzid
	 * @return
	 */
	public List<PJStaticInfo> findPJStaticInfo(String jcType,String bzid);
	
	/**
	 * 根据配件大类信息查询预设分类信息
	 * @param pjsId
	 * @return
	 */
	public List<PJPresetDivision> findPJPresetDivision(Long pjsId);
	
	/**
	 * 根据配件大类信息查询配件检修项目
	 * @param pjsId
	 * @return
	 */
	public List<PJFixItem> findPJFixItem(Long pjsId);
	
	/**
	 * 保存配件分工信息
	 * @param pjPreset
	 */
	public void savePJPresetDivision(PJPresetDivision pjPreset);
	
}
