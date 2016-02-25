package com.repair.work.service.impl;

import java.util.List;

import javax.annotation.Resource;

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
import com.repair.plan.dao.DictProTeamDao;
import com.repair.work.dao.PresetDivisionDao;
import com.repair.work.service.PresetDivisionService;

/**
 * 预设分工
 * @author Administrator
 *
 */
public class PresetDivisionServiceImpl implements PresetDivisionService{
	
	@Resource(name="presetDivisionDao")
	private PresetDivisionDao presetDivisionDao;
	@Resource(name="dictProTeamDao")
	private DictProTeamDao dictProTeamDao;
	
	/**
	 * 根据机车类型和班组ID查选班组下的预设分工信息
	 * @param jcType
	 * @param proteamid
	 * @return
	 */
	public List<PresetDivision> getPresetDivisonByTypeId(String jcType,Long proteamid,Integer nodeId){
		return presetDivisionDao.getPresetDivisonByTypeId(jcType, proteamid, nodeId);
	}
	
	/**
	 * 根据班组ID和机车类型查询班组下的检修项目
	 */
	public List<JCFixitem> getJCFixitemByBzId(String jcType, Long proteamid, Integer nodeId){
		return presetDivisionDao.getJCFixitemByBzId(jcType, proteamid, nodeId);
	}
	
	/**
	 * 根据班组ID和机车类型查询班组下的检修项目
	 */
	public List<JCZXFixItem> getJCZxFixitemByBzId(String jcType, Long proteamid, Integer nodeId){
		return presetDivisionDao.getJCZxFixitemByBzId(jcType, proteamid, nodeId);
	}
	
	/**
	 * 添加预设分工信息
	 * @param pd
	 */
	public void savePresetDivison(PresetDivision pd){
		presetDivisionDao.savePresetDivison(pd);
	}
	
	/**
	 * 根据ID获取对象
	 */
	public PresetDivision getPresetDivisionById(Integer presetId){
		return presetDivisionDao.getPresetDivisionById(presetId);
	}
	
	/**
	 *  根据ID获取对象
	 * @param presetId
	 * @return
	 */
	public PJPresetDivision getPJPresetDivisionById(Long presetId){
		return presetDivisionDao.getPJPresetDivisionById(presetId);
	}
	/**
	 * 保存检修项目和预设分类信息
	 * 更新机车分解项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void savePresetRelateId(String[] ids,Integer presetId){
		PresetRelateID presetRelateId = null;
		presetDivisionDao.delPresetRelateId(presetId);
		for(String s:ids){
    		presetRelateId=new PresetRelateID();
    		JCFixitem jcFixitem=new JCFixitem();
    		jcFixitem.setThirdUnitId(Integer.parseInt(s));
    		presetRelateId.setFixitem(jcFixitem);
    		PresetDivision preset=new PresetDivision();
    		preset.setProSetId(presetId);
    		presetRelateId.setPresetId(preset);
    		presetDivisionDao.savePresetRelateId(presetRelateId);
    	}
	}
	
	/**
	 * 保存中修项目和预设分类信息
	 * 更新机车分解项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void saveZxPresetRelateId(String[] ids,Integer presetId){
		PresetRelateID presetRelateId = null;
		presetDivisionDao.delPresetRelateId(presetId);
		for(String s:ids){
    		presetRelateId=new PresetRelateID();
    		JCZXFixItem jcZxFixitem=new JCZXFixItem();
    		jcZxFixitem.setId(Integer.parseInt(s));
    		presetRelateId.setJcZXFixItemId(jcZxFixitem);
    		PresetDivision preset=new PresetDivision();
    		preset.setProSetId(presetId);
    		presetRelateId.setPresetId(preset);
    		presetDivisionDao.savePresetRelateId(presetRelateId);
    	}
	}
	
	/**
	 * 保存配件项目和预设分类信息
	 * 更新机车项目和预设分工大类关联起来
	 * @param jcPartId
	 * @param ysId
	 */
	public void savePJPresetRelateId(String[] ids,Long presetId){
		PJPresetRelateID pjPresetRelateId=null;
		presetDivisionDao.delPJPresetRelateId(presetId);
		for(String s:ids){
			pjPresetRelateId=new PJPresetRelateID();
			PJPresetDivision pjPreset=new PJPresetDivision();
			pjPreset.setPresetId(presetId);
			PJFixItem pjFixItem=new PJFixItem();
			pjFixItem.setPjItemId(Long.parseLong(s));
			pjPresetRelateId.setPjPresetId(pjPreset);
			pjPresetRelateId.setPjFixItemId(pjFixItem);
			presetDivisionDao.savePJPresetRelateId(pjPresetRelateId);
		}
	}
	
	/**
	 * 根据预设分类Id查找预设项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PresetRelateID> getPresetRelateByYsId(int ysId){
		return presetDivisionDao.getPresetRelateByYsId(ysId);
	}
	
	/**
	 * 根据预设分类Id查找预设配件项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PJPresetRelateID> getPJPresetRelateByYsId(Long ysId){
		return presetDivisionDao.getPJPresetRelateByYsId(ysId);
	}
	
	/**
	 * 根据预设分类Id查找预设项目关系表中的信息
	 * @param ysId
	 * @return
	 */
	public List<PresetRelateID> getPresetRelateByYsId(Integer[] ysId){
		return presetDivisionDao.getPresetRelateByYsId(ysId);
	}
	
	/**
	 * 根据预设ID删除预设信息
	 * @param ysId
	 */
	public void delPresetDivisonByYsId(int ysId){
		presetDivisionDao.delPresetDivisonByYsId(ysId);
	}
	
	public void delPJPresetDivisonByYsId(Long ysId){
		presetDivisionDao.delPJPresetDivision(ysId);
		presetDivisionDao.delPJPresetRelateId(ysId);
	}
	
	/**
	 * 查询所有的机车型号
	 */
	public List<DictJcStype> listJcSType(){
		return presetDivisionDao.listJcSType();
	}
	
	/**
	 * 查询我的分工
	 */
	public List<DatePlanPri> listMyJCDivision(long userId){
		return presetDivisionDao.listMyJCDivision(userId);
	}
	

	@Override
	public List<DictProTeam> getDictProTeamAll() {
		return presetDivisionDao.getDictProTeamAll();
	}

	@Override
	public List<JCFixitem> getJCFixitemByBzId(long bzId,String jcType) {
		return presetDivisionDao.getJCFixitemByBzId(bzId,jcType);
	}

	@Override
	public void saveCharge(String[] itemIds, long teamId, UsersPrivs user,
			int status) {
		if(itemIds!=null&&itemIds.length!=0){
			for(String str:itemIds){
				int itemId=Integer.parseInt(str);
				JCCharge jcCharge=new JCCharge();
				JCFixitem fixitem=new JCFixitem();
				fixitem.setThirdUnitId(itemId);
				jcCharge.setFixitem(fixitem);
				
				DictProTeam proteam=new DictProTeam();
				proteam.setProteamid(teamId);
				jcCharge.setProteamId(proteam);
				
				jcCharge.setUser(user);
				jcCharge.setStatus(status);
				presetDivisionDao.saveCharge(jcCharge);
			}
		}
	}

	@Override
	public List<DictProTeam> getJCChargeByBzUser(UsersPrivs user) {
		return presetDivisionDao.getJCChargeByBzUser(user);
	}

	@Override
	public DictProTeam getDictProTeamById(long proteamid) {
		return presetDivisionDao.getDictProTeamById(proteamid); 
	}

	@Override
	public List<JCCharge> getJCChargeByItemId(int itemId) {
		return presetDivisionDao.getJCChargeByItemId(itemId);
	}

	@Override
	public void deleteJcCharge(UsersPrivs user, long proteamid) {
		presetDivisionDao.deleteJcCharge(user, proteamid);
	}

	@Override
	public List<JCCharge> getJCChargeByItemUserId(UsersPrivs user,
			long proteamid) {
		return presetDivisionDao.getJCChargeByItemUserId(user, proteamid);
	}

	@Override
	public List<DatePlanPri> getDivsionJc() {
		return presetDivisionDao.getDivsionJc();
	}

	@Override
	public void saveChoice(String[] ids, UsersPrivs user) {
		if(ids!=null&&ids.length!=0){
			for(String str:ids){
				int dpId=Integer.parseInt(str);//获得日计划ID信息
				DatePlanPri datePlan=new DatePlanPri();
				datePlan.setRjhmId(dpId);
				JCChoice jcChoice=presetDivisionDao.getJCChoiceByUserDpId(dpId, user);
				if(jcChoice==null){
					jcChoice=new JCChoice();
					jcChoice.setDpId(datePlan);
					jcChoice.setUserId(user);
					presetDivisionDao.saveChoice(jcChoice);
				}
			}
		}
		
	}

	@Override
	public List<JCChoice> getJCChoiceByUser(UsersPrivs user) {
		return presetDivisionDao.getJCChoiceByUser(user);
	}
	
	public List<JCChoice> getJCChoice(){
		return presetDivisionDao.getJCChoice();
	}

	@Override
	public List<DictProTeam> findWorkDictProTeam() {
		return dictProTeamDao.findWorkDictProTeam();
	}
	
	@Override
	public List<DictProTeam> findWorkDictProTeam(int zxFlag) {
		return dictProTeamDao.findWorkDictProTeam(zxFlag);
	}

	@Override
	public DictProTeam findDictProTeamByName(String proteamname) {
		return dictProTeamDao.findDictProTeamByName(proteamname);
	}
	
	public PresetDivision findPresetRelateByFixitemId(int itemId) {
		return presetDivisionDao.findPresetRelateByFixitemId(itemId);
	}

	@Override
	public PresetDivision findPresetRelateByZxFixitemId(int itemId,String jcType) {
		return presetDivisionDao.findPresetRelateByZxFixitemId(itemId,jcType);
	}

	@Override
	public List<PJStaticInfo> findPJStaticInfo(String jcType, String bzid) {
		return presetDivisionDao.findPJStaticInfo(jcType, bzid);
	}

	@Override
	public List<PJPresetDivision> findPJPresetDivision(Long pjsId) {
		return presetDivisionDao.findPJPresetDivision(pjsId);
	}

	@Override
	public List<PJFixItem> findPJFixItem(Long pjsId) {
		return presetDivisionDao.findPJFixItem(pjsId);
	}

	@Override
	public void savePJPresetDivision(PJPresetDivision pjPreset) {
		presetDivisionDao.savePJPresetDivision(pjPreset);
	}
}
