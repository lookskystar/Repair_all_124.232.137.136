package com.repair.part.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PJDatePlan;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixFlow;
import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJPredict;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PJUnitPart;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.part.dao.PJDatePlanDao;
import com.repair.part.dao.PJDynamicInfoDao;
import com.repair.part.dao.PJFixFlowDao;
import com.repair.part.dao.PJFixRecordDao;
import com.repair.part.dao.PJStaticInfoDao;
import com.repair.part.service.PartFixService;
import com.repair.work.dao.UsersPrivsDao;

public class PartFixServiceImpl implements PartFixService {

	@Resource(name = "pjDatePlanDao")
	private PJDatePlanDao pjDatePlanDao;
	@Resource(name="pjStaticInfoDao")
	private PJStaticInfoDao pjStaticInfoDao;
	@Resource(name="pjDynamicInfoDao")
	private PJDynamicInfoDao pjDynamicInfoDao;
	@Resource(name="pjFixRecordDao")
	private PJFixRecordDao pjFixRecordDao;
	@Resource(name="pjFixFlowDao")
	private PJFixFlowDao pjFixFlowDao;
	@Resource(name="usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	
	private PageModel pageModel;
	public PageModel getPageModel() {
		return pageModel;
	}

	public void setPageModel(PageModel pageModel) {
		this.pageModel = pageModel;
	}
	
	
	@Override
	public PageModel findPageModelPartPlan() {
		return pjDatePlanDao.findPageModelPartPlan();
	}

	@Override
	public List<String> findJcTypeValueFromDictFirstUnit() {
		return pjDatePlanDao.findJcTypeValueFromDictFirstUnit();
	}
	
	@Override
	public PageModel findPageModelPJStaticInfoByJcTypeAndProfession(
			String jcTypeVal, Long firstUnitId,String keyword) {
		return pjDatePlanDao.findPageModelPJStaticInfoByJcTypeAndProfession(jcTypeVal, firstUnitId,keyword);
	}


	@Override
	public List<DictFirstUnit> findDictFirstUnitsByJcType(String jcType) {
		return pjDatePlanDao.findDictFirstUnitsByJcType(jcType);
	}

	@Override
	public PJStaticInfo getPJStaticInfo(long pjId) {
		return pjStaticInfoDao.getPJStaticInfo(pjId);
	}
	
	@Override
	public PageModel findPageModelPJDynamicByPJSid(long pjsid,int flag) {
		return pjDynamicInfoDao.findPageModelPJDynamicByPJSid(pjsid,flag);
	}
	
	@Override
	public List findPartChoicedByDatePlan(long pid) {
		return pjDynamicInfoDao.findPartChoicedByDatePlan(pid);
	}

	/**
	 * 选择日计划需检修的动态配件
	 * @param pjDatePlan 配件检修日计划
	 * @param pjdidStr 动态配件id集合
	 */
	public void saveChoiceDatePlanPJDynamic(PJDatePlan pjDatePlan,String pjdidStr,String number) {
		long pjdId = Long.parseLong(pjdidStr);
		PJDynamicInfo pjDynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjdId);
		PJStaticInfo pjStaticInfo = pjDynamicInfo.getPjStaticInfo();
		List<PJStaticInfo> childPJs = pjStaticInfoDao.findChildPJByParentPJFromFixItem(pjStaticInfo.getPjsid());
		PJFixRecord pjFixRecord = new PJFixRecord();
		pjFixRecord.setJwdCode("0809");
		pjFixRecord.setPjDynamicInfo(pjDynamicInfo);
		pjFixRecord.setPjname(pjDynamicInfo.getPjName());
//		pjFixRecord.setUppjnum(number);//上车编号
		pjFixRecord.setType(0);//类型为：配件
		if(childPJs!=null && childPJs.size()>0){
			pjFixRecord.setRecstas(1); //状态：新建且有子配件
		}else{
			pjFixRecord.setRecstas(0); //状态：新建
		}
		pjFixRecordDao.savePJFixRecord(pjFixRecord);
		
		//设置当前配件进入对应配件检修流程的第一个流程步骤
		int flowTypeId = pjStaticInfo.getPjFixFlowType().getFlowTypeId();
		List<PJFixFlow> fixFlows = pjFixFlowDao.findPJFixFlowListByFlowType(flowTypeId);
		PJFixFlow pjFixFlow = fixFlows.get(0);
		List<DictProTeam> teams = pjFixFlowDao.findFixFlowTeam(pjStaticInfo.getPjsid(),pjFixFlow.getNodeId());
		PJFixFlowRecord flowRecord = null;
		for (DictProTeam dictProTeam : teams) {
			flowRecord = new PJFixFlowRecord();
			flowRecord.setJwdCode("0809");
			flowRecord.setDatePlan(pjDatePlan);
			flowRecord.setPjDynamicInfo(pjDynamicInfo);
			flowRecord.setPjFixFlow(pjFixFlow);
			flowRecord.setTeam(dictProTeam);
			flowRecord.setStatus(0);
			pjFixFlowDao.savePJFixFlowRecord(flowRecord);
		}
		
		pjDynamicInfo.setGetOnNum(number);//上车编号
		pjDynamicInfo.setPjStatus(3);//设置当前动态配件的状态为“检修中”
		pjDynamicInfo.setFixFlowName(pjFixFlow.getNodeName());//设置当前动态配件的检修流程
		pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
			
		int num = pjDatePlanDao.findChoicedPJNum(pjDatePlan.getPlanId());
		if(num==pjDatePlan.getAmount()){
			pjDatePlan.setStatus((short)1);//设置日计划状态为已完成配件的选择
			pjDatePlanDao.updateDatePlan(pjDatePlan);
		}
	}
	
	/**
	 * 创建一个配件检修
	 */
	public void saveCreatePJFix(PJDatePlan pjDatePlan,String pjdidStr){
		long pjdId = Long.parseLong(pjdidStr);
		PJDynamicInfo pjDynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjdId);
		PJStaticInfo pjStaticInfo = pjDynamicInfo.getPjStaticInfo();
		List<PJStaticInfo> childPJs = pjStaticInfoDao.findChildPJByParentPJFromFixItem(pjStaticInfo.getPjsid());
		PJFixRecord partRecord = new PJFixRecord();
		partRecord.setPjDynamicInfo(pjDynamicInfo);
		partRecord.setPjname(pjDynamicInfo.getPjName());
		partRecord.setType(0);//类型为：配件
		if(childPJs!=null && childPJs.size()>0){
			partRecord.setRecstas(1); //状态：新建且有子配件
		}else{
			partRecord.setRecstas(0); //状态：新建
		}
		pjFixRecordDao.savePJFixRecord(partRecord);
		
		//设置当前配件进入对应配件检修流程的第一个流程步骤
		int flowTypeId = pjStaticInfo.getPjFixFlowType().getFlowTypeId();
		//查询出当前配件所有的流程节点
		List<PJFixFlow> fixFlows = pjFixFlowDao.findPJFixFlowListByFlowType(flowTypeId);
		PJFixFlowRecord flowRecord = null;
		PJFixRecord fixRecord = null;
		String partTeams = partRecord.getTeams();
		for (PJFixFlow pjFixFlow : fixFlows) {
			//查询出负责当前流程节点检修项目的班组
			List<DictProTeam> teams = pjFixFlowDao.findFixFlowTeam(pjStaticInfo.getPjsid(),pjFixFlow.getNodeId());
			for (DictProTeam dictProTeam : teams) {//生成班组检修对应的流程节点记录
				flowRecord = new PJFixFlowRecord();
				flowRecord.setJwdCode("0809");
				flowRecord.setDatePlan(pjDatePlan);
				flowRecord.setPjDynamicInfo(pjDynamicInfo);
				flowRecord.setPjFixFlow(pjFixFlow);
				flowRecord.setTeam(dictProTeam);
				flowRecord.setStatus(0);
				pjFixFlowDao.savePJFixFlowRecord(flowRecord);
				
				//查询出当前班组在当前流程节点的检修项目
				List<PJFixItem> fixItems = pjFixRecordDao.findPJFixItemListByPJAndFlowAndTeam(pjStaticInfo.getPjsid(),
						pjFixFlow.getNodeId(),dictProTeam.getProteamid());
				for (PJFixItem fixItem : fixItems) {//遍历当前的所有检修项目，产生对应的记录
					fixRecord = new PJFixRecord();
					fixRecord.setPjFixItem(fixItem);
					fixRecord.setPjFixFlowRecord(flowRecord);
					fixRecord.setPjDynamicInfo(pjDynamicInfo);
					fixRecord.setPjname(pjDynamicInfo.getPjName());
					fixRecord.setPjFixRecSid(partRecord.getPjRecId()); //检修配件的配件记录id
					fixRecord.setType(1); //为检修项目记录
					fixRecord.setTeams(dictProTeam.getProteamid()+""); //负责该项目的班组id
					fixRecord.setRecstas(0);  //状态为新建
					pjFixRecordDao.savePJFixRecord(fixRecord);
				}
				//向配件记录中添加当前班组id
				long teamId = dictProTeam.getProteamid();
				if(partTeams==null){
					partTeams = ","+teamId+",";
				}else{
					if(!partTeams.contains(","+teamId+",")){
						partTeams += dictProTeam.getProteamid();
						partTeams +=",";
					}
				}
			}
		}
		partRecord.setTeams(partTeams);//设置当前配件记录的班组id集合
		pjFixRecordDao.updatePJFixRecord(partRecord);
		
		pjDynamicInfo.setPjStatus(3);//设置当前动态配件的状态为“检修中”
		pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
			
		pjDatePlan.setStatus((short)1);//设置日计划状态为已完成配件的选择
		pjDatePlanDao.updateDatePlan(pjDatePlan);
	}
	
	public void saveTrustPjFix(Long pjdid,String trustFactory,String trustother){
		PJDynamicInfo pjDynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjdid);
		PJFixRecord partRecord = new PJFixRecord();
		partRecord.setPjDynamicInfo(pjDynamicInfo);
		partRecord.setPjname(pjDynamicInfo.getPjName());
		partRecord.setType(2);//类型为：委外检修
		partRecord.setAccepttime(new Date());
		partRecord.setRecstas(7);//完成检修fixemp
		partRecord.setFixemp(trustFactory);//检修人名字在委外检修中为厂家名称
		partRecord.setFixsituation(trustother);//检修情况再委外检修中为备注信息
		pjFixRecordDao.savePJFixRecord(partRecord);
		
		pjDynamicInfo.setPjStatus(0);//设置当前动态配件的状态为“合格”
		pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
	}
	
	@Override
	public PJDatePlan getPJDatePlanById(long planId) {
		return pjDatePlanDao.getPJDatePlanById(planId);
	}
	
	@Override
	public void savePjDatePlan(PJDatePlan datePlan) {
		pjDatePlanDao.savePjDatePlan(datePlan);
	}
	
	@Override
	public PJDynamicInfo getPJDynamicInfoById(long pjdId) {
		return pjDynamicInfoDao.getPJDynamicInfoById(pjdId);
	}
	
	@Override
	public void savePJFixRecord(PJFixRecord pjFixRecord) {
		pjFixRecordDao.savePJFixRecord(pjFixRecord);
	}
	
	@Override
	public List<PJFixFlow> findPJFixFlowListByFlowType(int flowTypeId) {
		return pjFixFlowDao.findPJFixFlowListByFlowType(flowTypeId);
	}
	
	@Override
	public List<DictProTeam> findFixFlowTeam(Long pjsid, Long nodeId) {
		return pjFixFlowDao.findFixFlowTeam(pjsid, nodeId);
	}
	
	@Override
	public PageModel findPageModelPJFixFlowRecordByBZId(long teamId) {
		return pjFixFlowDao.findPageModelPJFixFlowRecordByBZId(teamId);
	}
	
	@Override
	public PJFixFlowRecord getPJFixFlowRecordById(Long flowRecId) {
		return pjFixFlowDao.getPJFixFlowRecordById(flowRecId);
	}

	@Override
	public PageModel findPageModelPJFixItemByPjSid(long pjSid, long flowId,long bzId) {
		return pjFixRecordDao.findPageModelPJFixItemByPjSid(pjSid, flowId, bzId);
	}
	
	@Override
	public Long findPJRecIdByDatePlanAndPJDynamic(long planId, long pjDid) {
		return pjFixRecordDao.findPJRecIdByDatePlanAndPJDynamic(planId, pjDid);
	}

	@Override
	public List findPJFixRecByPJFixFlowRecAndPJRecId(PJFixFlowRecord fixFlowRecord, Long pjRecId) {
		return pjFixRecordDao.findPJFixRecByPJFixFlowRecAndPJRecId(fixFlowRecord, pjRecId);
	}

	/**
	 * 给工人分配配件检修项目
	 * @param items 检修项目id集合
	 * @param userid 工人id
	 * @param userName 工人名
	 * @param flowRecId 当前配件所在流程的流程记录id
	 */
	public void saveAssignFixItem(String[] items, String userid,String userName, String flowRecId) {
		long userId = Long.parseLong(userid);
		long flowRecordId = Long.parseLong(flowRecId);
		PJFixFlowRecord fixFlowRec = pjFixFlowDao.getPJFixFlowRecordById(flowRecordId);
		PJDatePlan datePlan = fixFlowRec.getDatePlan();
		PJDynamicInfo pjDynamicInfo = fixFlowRec.getPjDynamicInfo();
		Long pjFixRecSid = pjFixRecordDao.findPJRecIdByDatePlanAndPJDynamic(datePlan.getPlanId(),pjDynamicInfo.getPjdid());
		long itemId = 0;
		PJFixItem pjFixItem = null;
		for (int i = 0; i < items.length; i++) {
			itemId = Long.parseLong(items[i]);
			pjFixItem = pjFixRecordDao.getPJFixItemById(itemId);
			PJFixRecord pjFixRecord = new PJFixRecord();
			pjFixRecord.setPjFixItem(pjFixItem);
			pjFixRecord.setPjFixFlowRecord(fixFlowRec);
			pjFixRecord.setFixempid(userId);
			pjFixRecord.setFixemp(userName);
			pjFixRecord.setAccepttime(new Date());
			pjFixRecord.setJwdCode("0809");
			pjFixRecord.setPjDynamicInfo(pjDynamicInfo);
			pjFixRecord.setPjname(pjDynamicInfo.getPjName());
			pjFixRecord.setPjFixRecSid(pjFixRecSid); //检修配件的配件记录id
			pjFixRecord.setType(1);
			pjFixRecord.setRecstas(1);
			pjFixRecordDao.savePJFixRecord(pjFixRecord);
		}
		
	}
	
	/**
	 * 工人接活
	 * @param items 配件检修项目id集合
	 * @param user 当前用户
	 * @param flowRecId 当前检修配件的流程记录id
	 */
	public void saveChoiceFixItem(String[] items, UsersPrivs user,String flowRecId) {
		long flowRecordId = Long.parseLong(flowRecId);
		PJFixFlowRecord fixFlowRec = pjFixFlowDao.getPJFixFlowRecordById(flowRecordId);
		PJDatePlan datePlan = fixFlowRec.getDatePlan();
		PJDynamicInfo pjDynamicInfo = fixFlowRec.getPjDynamicInfo();
		Long pjFixRecSid = pjFixRecordDao.findPJRecIdByDatePlanAndPJDynamic(datePlan.getPlanId(),pjDynamicInfo.getPjdid());
		long itemId = 0;
		PJFixItem pjFixItem = null;
		for (int i = 0; i < items.length; i++) {
			itemId = Long.parseLong(items[i]);
			pjFixItem = pjFixRecordDao.getPJFixItemById(itemId);
			PJFixRecord pjFixRecord = new PJFixRecord();
			pjFixRecord.setPjFixItem(pjFixItem);
			pjFixRecord.setPjFixFlowRecord(fixFlowRec);
			pjFixRecord.setFixempid(user.getUserid());
			pjFixRecord.setFixemp(user.getXm());
			pjFixRecord.setAccepttime(new Date());
			pjFixRecord.setJwdCode("0809");
			pjFixRecord.setPjDynamicInfo(pjDynamicInfo);
			pjFixRecord.setPjname(pjDynamicInfo.getPjName());
			pjFixRecord.setPjFixRecSid(pjFixRecSid); //检修配件的配件记录id
			pjFixRecord.setType(1);
			pjFixRecord.setRecstas(1);
			pjFixRecordDao.savePJFixRecord(pjFixRecord);
		}
	}
	
	@Override
	public PageModel findPageModelUnfinishedPJFixItem(String role,UsersPrivs user) {
		return pjFixRecordDao.findPageModelUnfinishedPJFixItem(role, user);
	}
	
	/**
	 * 分页查询工人（工长）未完成的检查项目
	 */
	public PageModel findPageModelUnfinishedInspectionItem(String pjDid,long teamId,Long pjRecId) {
		long pjdid = Long.parseLong(pjDid);
		return pjFixRecordDao.findPageModelUnfinishedInspectionItem(pjdid,teamId,pjRecId);
	}
	
	public Long findSignedInspectionItem(String pjDid,long teamId,Long pjRecId,int role){
		long pjdid = Long.parseLong(pjDid);
		return pjFixRecordDao.findSignedInspectionItem(pjdid, teamId, pjRecId, role);
	}

	/**
	 * 分页查询工人（工长）未完成的检测项目
	 */
	public PageModel findPageModelUnfinishedDetectItem(String pjDid,Long teamId,Long pjRecId) {
		long pjdid = Long.parseLong(pjDid);
		return pjFixRecordDao.findPageModelUnfinishedDetectItem(pjdid,teamId,pjRecId);
	}
	
	public Long findSignedDetectItem(String pjDid,long teamId,Long pjRecId,int role){
		long pjdid = Long.parseLong(pjDid);
		return pjFixRecordDao.findSignedDetectItem(pjdid, teamId, pjRecId, role);
	}
	
	/**
	 * 签认未完成的检修项目
	 */
	public String saveSignFixItem(UsersPrivs user,String records, String status, String roleFlag) throws Exception{
		String msg = "操作成功";  //默认为签认成功
		String[] recordArr = records.split(",");
		String roles = user.getRoles();
		if(roles.contains(",GR,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				if(pjFixRecord.getFixemp()==null){
					pjFixRecord.setFixemp(user.getXm());
				}else{
					if(!pjFixRecord.getFixemp().contains(user.getXm())){
						pjFixRecord.setFixemp(pjFixRecord.getFixemp()+","+user.getXm());
					}
				}
				pjFixRecord.setFixempid(user.getUserid());
				pjFixRecord.setFixsituation(status);
				pjFixRecord.setEmpaffirmtime(new Date());
				pjFixRecord.setRecstas(2);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}else if(roles.contains(",GZ,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				//pjFixRecord.setFixemp(user.getXm());
				//2015-05-19 配件项目同一项目多人签认 ning
				if(pjFixRecord.getFixemp()==null){
					pjFixRecord.setFixemp(user.getXm());
				}else{
					if(!pjFixRecord.getFixemp().contains(user.getXm())){
						pjFixRecord.setFixemp(pjFixRecord.getFixemp()+","+user.getXm());
					}
				}
				pjFixRecord.setFixempid(user.getUserid());
				pjFixRecord.setFixsituation(status);
				pjFixRecord.setEmpaffirmtime(new Date());
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}else if(roles.contains(",ZJY,") || roles.contains(",DSZJ,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				pjFixRecord.setQiid(user.getUserid());
				pjFixRecord.setQi(user.getXm());
				pjFixRecord.setQiaffitime(new Date());
				pjFixRecord.setRecstas(5);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}else if(roles.contains(",JSY,") || roles.contains(",DSJS,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				pjFixRecord.setTechId(user.getUserid());
				pjFixRecord.setTechName(user.getXm());
				pjFixRecord.setTechTime(new Date());
				pjFixRecord.setRecstas(4);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}else if(roles.contains(",JCGZ,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				pjFixRecord.setCommitleadid(user.getUserid());
				pjFixRecord.setCommitlead(user.getXm());
				pjFixRecord.setComldaffitime(new Date());
				pjFixRecord.setRecstas(6);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}else if(roles.contains(",YSY,")){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				pjFixRecord.setAccepterid(user.getUserid());
				pjFixRecord.setAccepter(user.getXm());
				pjFixRecord.setAcceaffitime(new Date());
				pjFixRecord.setRecstas(7);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}
		return msg;
	}
	
	
	@Override
	public String saveSignDetectFixItem(UsersPrivs user, String records,String status){
		String msg = "操作成功";  //默认为签认成功
		try {
			long recId =Long.parseLong(records);
			PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
			String fixStatus = pjFixRecord.getFixsituation();
			String roles = user.getRoles();
			String preFixemp = pjFixRecord.getFixemp();
			String nowFixemp = user.getXm();
			boolean flag = false;
			if(roles.contains(",GR,")){
				if(fixStatus==null){
					pjFixRecord.setFixemp(user.getXm());
					pjFixRecord.setFixempid(user.getUserid());
					pjFixRecord.setFixsituation(status);
					pjFixRecord.setEmpaffirmtime(new Date());
					pjFixRecord.setRecstas(2);
					pjFixRecordDao.updatePJFixRecord(pjFixRecord);
					saveToFinishRecord(pjFixRecord);
				}else{
					String[] preFixempArray = preFixemp.split(",");
					for(int i=0; i<= preFixempArray.length-1; i++) {
						if(preFixempArray[i].equals(nowFixemp)){
							flag = true;
							break;
						}
					}
					if(!flag){
						pjFixRecord.setFixemp(preFixemp + ","+ nowFixemp);
					}
					pjFixRecord.setFixempid(user.getUserid());
					pjFixRecord.setFixsituation(status);
					pjFixRecord.setEmpaffirmtime(new Date());
					pjFixRecordDao.updatePJFixRecord(pjFixRecord);
					saveToFinishRecord(pjFixRecord);
//					if(pjFixRecord.getFixempid().compareTo(user.getUserid())==0){
//						pjFixRecord.setFixsituation(status);
//						pjFixRecordDao.updatePJFixRecord(pjFixRecord);
//					}else{
//						return "您不是填写当前组装配件编码的检修员，不能修改当前记录";
//					}
				}
			}else if(roles.contains(",GZ,")){
				if(fixStatus==null){//该检测值还未填时
					pjFixRecord.setFixemp(user.getXm());
					pjFixRecord.setFixempid(user.getUserid());
					pjFixRecord.setFixsituation(status);
					pjFixRecord.setEmpaffirmtime(new Date());
					pjFixRecordDao.updatePJFixRecord(pjFixRecord);
					saveToFinishRecord(pjFixRecord);//判断当前配件是否检修完成
				}else{//该检测值已经填写了时
					if(pjFixRecord.getLeadid()==null){//工长还未签认
						pjFixRecord.setLeadid(user.getUserid());
						pjFixRecord.setLead(user.getXm());
						pjFixRecord.setLdaffirmtime(new Date());
						pjFixRecord.setRecstas(3);
						saveToFinishRecord(pjFixRecord);//判断当前配件是否检修完成
					}else{
						if(pjFixRecord.getLeadid().compareTo(user.getUserid())==0){
							pjFixRecord.setFixsituation(status);
							pjFixRecordDao.updatePJFixRecord(pjFixRecord);
						}else{
							return "您不是填写当前组装配件编码的检修员，不能修改当前记录";
						}
					}
				}
			}
		} catch (Exception e) {
			msg = "操作失败";
		}
		return msg;
	}
	
	/**
	 * 判断当前检修项目是否完成
	 */
	private void saveToFinishRecord(PJFixRecord record) throws Exception{
		PJFixItem item = record.getPjFixItem();
		boolean flag = true; //初始化为完成
		if(item.getItemctrllead()!=null && item.getItemctrllead().longValue()==1){//工长需要签认
			if(record.getLeadid()==null){
				flag = false;
				return;
			}
		}
		if(item.getItemctrltech()!=null && item.getItemctrltech().longValue()==1){//技术员需要签认
			if(record.getTechId()==null){
				flag = false;
				return;
			}
		}
		if(item.getItemctrlqi()!=null && item.getItemctrlqi().longValue()==1){//质检员需要签认
			if(record.getQiid()==null){
				flag = false;
				return;
			}
		}
		if(item.getItemctrlcomld()!=null && item.getItemctrlcomld().longValue()==1){//交车工长需要签认
			if(record.getCommitleadid()==null){
				flag = false;
				return;
			}
		}
		if(item.getItemctrlacce()!=null && item.getItemctrlacce().longValue()==1){//验收员需要签认
			if(record.getAccepterid()==null){
				flag = false;
				return;
			}
		}
		if(flag == true){
			record.setRecstas(7);//完成该检测项目的验收
			pjFixRecordDao.updatePJFixRecord(record);
			saveToFinishFlowNode(record); //检测该检测项目的配件检修是否完成检测
		}
	}
	
	/**
	 * 判断当前班组在当前流程节点的检修项目是否完成检测
	 * @param record
	 */
	public void saveToFinishFlowNode(PJFixRecord record) throws Exception{
		PJDynamicInfo pjDynamicInfo = record.getPjDynamicInfo();
		PJStaticInfo pjStaticInfo = pjDynamicInfo.getPjStaticInfo();
		long pjsid = pjStaticInfo.getPjsid(); //检测配件
		long pjRecId = record.getPjFixRecSid();//当前检测配件配件检测记录的id
		int pjItemCount = pjFixRecordDao.findPJFixItemCount(pjsid);//当前配件的检修项目个数
		int pjRecordCount = pjFixRecordDao.findPJFixRecordCount(pjRecId);//当前配件已完成检修的记录个数
		if(pjItemCount==pjRecordCount){
			PJFixRecord pjRecord = pjFixRecordDao.getPJFixRecordById(pjRecId);
			pjRecord.setRecstas(7);//设置当前配件检修记录完成
			pjFixRecordDao.updatePJFixRecord(pjRecord);
			
			pjDynamicInfo.setPjStatus(0);//修改动态配件的状态为”合格“
			pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
		}
	}

	/**
	 * 修改配件流程记录
	 * @param fixFlowRecord
	 */
	private void updatePJFixFlowRecord(PJFixFlowRecord fixFlowRecord) {
		pjFixFlowDao.updatePJFixFlowRecord(fixFlowRecord);
	}
	
	/**
	 * 修改配件检修记录
	 * @param pjRecord
	 */
	private void updatePJFixRecord(PJFixRecord pjRecord) {
		pjFixRecordDao.updatePJFixRecord(pjRecord);
	}

	/**
	 * 分页查询正在检修拥有子配件的大部件
	 * @return
	 */
	public PageModel findPageModelUnitHasPart() {
		return pjFixRecordDao.findPageModelUnitHasPart();
	}
	
	/**
	 * 根据配件检修项目中的配件id查询所有子配件
	 * @param pjsid 配件id
	 * @return
	 */
	public List<PJStaticInfo> findChildPJByParentPJFromFixItem(long pjsid) {
		return pjStaticInfoDao.findChildPJByParentPJFromFixItem(pjsid);
	}
	
	/**
	 * 保存一条配件检修大部件的子配件记录
	 * @param unitPart
	 */
	public void savePJUnitPart(PJUnitPart unitPart) {
		pjDynamicInfoDao.savePJUnitPart(unitPart);
	}
	
	/**
	 * 获取配件检修记录
	 * @param recordId 配件检修记录id
	 */
	public PJFixRecord getPJFixRecordById(long recordId) {
		return pjFixRecordDao.getPJFixRecordById(recordId);
	}
	
	/**
	 * 获取配件检修记录
	 * @param recordId 配件检修记录id
	 * @return
	 */
	public void saveChoiceUnitPart(String recordid,List<Long> pjdids, UsersPrivs user) {
		long recordId = Long.parseLong(recordid);
		PJUnitPart unitPart = null;
		PJFixRecord fixRecord = pjFixRecordDao.getPJFixRecordById(recordId);
		PJDynamicInfo parentPJ = fixRecord.getPjDynamicInfo();
		for (int i = 0; i < pjdids.size(); i++) {
			long pjdid = (Long)pjdids.get(i);
			PJDynamicInfo childPJ = pjDynamicInfoDao.getPJDynamicInfoById(pjdid);
			
			unitPart = new PJUnitPart();
			unitPart.setChildPJ(childPJ);
			unitPart.setChildFacNum(childPJ.getFactoryNum());
			unitPart.setParentPJ(parentPJ);
			unitPart.setUser(user);
			pjDynamicInfoDao.savePJUnitPart(unitPart);
		}
		fixRecord.setRecstas(2);//设置状态为完成配件选择
		pjFixRecordDao.savePJFixRecord(fixRecord);
	}
	
	/**
	 * 配件检修时报活
	 */
	public void saveCreatePredict(UsersPrivs user, String bzid, String bzname,
			String approveVal, String desc, Long pjRecordId) {
		Long bzId = Long.parseLong(bzid);
		int needApprove = Integer.parseInt(approveVal);
		PJFixRecord pjFixRec = pjFixRecordDao.getPJFixRecordById(pjRecordId);
		//报活记录
		PJPredict predict = new PJPredict();
		predict.setBzId(bzId);
		predict.setBzName(bzname);
		predict.setPjDynamicInfo(pjFixRec.getPjDynamicInfo());
		predict.setPjFixRecord(pjFixRec);
		predict.setDescription(desc);
		predict.setMakerId(user.getUserid());
		predict.setMaker(user.getXm());
		predict.setMakeDate(new Date());
		predict.setPjFixRecId(pjFixRec.getPjFixRecSid());
		predict.setNeedApprove(needApprove);
		predict.setStatus(0);
		savePJPredict(predict);
		
		//更新报活产生的配件检修记录中报活id
		pjFixRec.setPjPredictId(predict.getPredictId());
		pjFixRec.setPreStatus(1);//设置当前检修记录为已报活
		pjFixRecordDao.updatePJFixRecord(pjFixRec);
		
	}
	
	/**
	 * 新增一个报活
	 * @param predict
	 */
	void savePJPredict(PJPredict predict){
		pjFixRecordDao.savePJPredict(predict);
	}
	
	/**
	 * 查询当前所有报活待派工的项目
	 * @param user 当前用户
	 * @param flag 标识：0表示不需要调度审批的报活，1表示需要调度审批的报活，2表示已完成派工
	 */
	public PageModel findPageModelPJPredict(UsersPrivs user, int flag) {
		return pjFixRecordDao.findPageModelPJPredict(user,flag);
	}
	
	@Override
	public void saveAssignPredict(String predictid, String userid,String userName) {
		long predictId = Long.parseLong(predictid);
		long userId = Long.parseLong(userid);
		PJPredict predict = pjFixRecordDao.getPJPredictById(predictId);
		predict.setFixempid(userId);
		predict.setFixemp(userName);
		predict.setAccepttime(new Date());
		predict.setStatus(1);
		pjFixRecordDao.updatePJPredict(predict);
	}
	
	/**
	 * 报活检修签认
	 * @param user 当前用户
	 * @param predictid 报活id
	 * @param flag 标识：1工人签认、2工长签认
	 */
	public String saveSignPredict(UsersPrivs user, String predictid, String flag) {
		long predictId = Long.parseLong(predictid);
		PJPredict predict = pjFixRecordDao.getPJPredictById(predictId);
		String msg = "签认成功";
		if("1".equals(flag)){//工人签认
			if(user.getUserid().compareTo(predict.getFixempid())==0){
				predict.setEmpaffirmtime(new Date());
				predict.setStatus(2);
				pjFixRecordDao.updatePJPredict(predict);
			}else{
				msg = "您不是当前检修员，不能签认当前报活！";
			}
		}else if("2".equals(flag)){//工长签认
			List roleIds = new ArrayList(); //该用户的角色集合
			UsersPrivs us = usersPrivsDao.getUsersPrivsById(user.getUserid());
			Set set = us.getRolePrivs();
			for (Object object : set) {
				RolePrivs r = (RolePrivs) object;
				roleIds.add(r.getRoleid());
			}
			if(roleIds.contains(3L)){ //该用户具有工长角色
				if(predict.getStatus()==2){
					predict.setLeadid(us.getUserid());
					predict.setLead(us.getXm());
					predict.setLdaffirmtime(new Date());
					predict.setStatus(3);
					pjFixRecordDao.updatePJPredict(predict);
					
					PJFixRecord fixRecord = predict.getPjFixRecord();
					fixRecord.setPreStatus(2);
					pjFixRecordDao.updatePJFixRecord(fixRecord);
				}else{
					msg = "工人未签认，工长不能签认！";
				}
			}else{
				msg = "您不具有工长的角色，不能签认当前报活！";
			}
		}
		return msg;
	}
	
	/**
	 * 给需审批的报活指派班组
	 * @param user 当前审批用户
	 * @param predictid 报活id
	 * @param bzid 班组id
	 * @param bzName 班组名
	 */
	public void saveAssignPredictBZ(UsersPrivs user, String predictid, String bzid, String bzName) {
		long predictId = Long.parseLong(predictid);
		long bzId = Long.parseLong(bzid);
		PJPredict predict = pjFixRecordDao.getPJPredictById(predictId);
		predict.setBzId(bzId);
		predict.setBzName(bzName);
		predict.setApproverId(user.getUserid());
		predict.setApprover(user.getXm());
		predict.setApproveDate(new Date());
		predict.setNeedApprove(2);
		pjFixRecordDao.updatePJPredict(predict);
	}
	
	@Override
	public String saveCreatePJNum(String pjdidStr, String pjNum,String py) {
		Long pjdId = Long.parseLong(pjdidStr);
		PJDynamicInfo dynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjdId);
		if(pjNum == null){//自动生成
			dynamicInfo.setPjNum(autoCreatePJNum(py));
		}else{//手动输入
			List<PJDynamicInfo> pjDynamics = pjDynamicInfoDao.findPJDynamicInfoListByPJNum(pjNum); 
			if(pjDynamics ==null || pjDynamics.size()==0){
				dynamicInfo.setPjNum(pjNum);
			}else{
				return "该编码已经被一个配件使用了，请重新填写一个的配件编码！";
			}
		}
		pjDynamicInfoDao.updatePJDynamicInfo(dynamicInfo);
		return "操作成功";
		
	}
	
	public String saveCreatePJNum(String pjIds){
		if(pjIds!=null&&!"".equals(pjIds)){
			String[] array=pjIds.split(",");
			PJDynamicInfo dynamicInfo = null;
			for(String str:array){
				Long pjdId=Long.parseLong(str);
				dynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjdId);
				if(dynamicInfo.getPjNum()==null){
					dynamicInfo.setPjNum(autoCreatePJNum(""));
					pjDynamicInfoDao.updatePJDynamicInfo(dynamicInfo);
				}
			}
		}
		return "操作成功";
	}
	
	/**
	 * 产生一个配件出厂编码
	 * @return
	 */
	private String autoCreatePJNum(String py){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String num = sdf.format(new Date());
		Random random = new Random();
		int rand = random.nextInt(99)+1;
		String pjNum = py + num + rand;
		List<PJDynamicInfo> pjDynamics = pjDynamicInfoDao.findPJDynamicInfoListByPJNum(pjNum);
		if(pjDynamics!=null && pjDynamics.size()>0){
			pjNum = autoCreatePJNum(py);
		}
		return pjNum;
	}
	
	public List listUnfinishedPartCount(UsersPrivs user,String jcsType,Long firstUnitId,String pjName,Long tsBzId){
		String roles = user.getRoles();
		Long bzId = null;
		Integer type = null;
		boolean flag = false;//是否为探伤组
		if(roles.contains(",GR,")){ //工人
			bzId = user.getBzid();
			if(bzId.equals(tsBzId)){
				flag = true;
			}
			type = 1;
		}else if(roles.contains(",GZ,")){//工长
			bzId = user.getBzid();
			if(bzId.equals(tsBzId)){
				flag = true;
			}
			type = 2;
		}else if(roles.contains(",JSY,")){//技术
			type = 3;
		}else if(roles.contains(",ZJY,")){//质检
			type = 4;
		}else if(roles.contains(",JCGZ,")){//交车工长
			type = 5;
		}else if(roles.contains(",YSY,")){//验收
			type = 6;
		}
		return pjFixRecordDao.listUnfinishedPartCount(bzId,type,jcsType,firstUnitId,pjName,flag);
	}
	
	/**
	 * 分页查询当前班组负责检修还未检修完的配件
	 * @param user
	 */
	public PageModel findPageModelPJPartFixRecordByUser(UsersPrivs user,String jcsType,Long firstUnitId,String pjName,String pjNum,Integer type) {
		return pjFixRecordDao.findPageModelPJPartFixRecordByBZUser(user,jcsType,firstUnitId,pjName,pjNum,type);
	}
	
	@Override
	public PageModel findPageModelPJDynamic(String jcType,Long firstUnitId,String pjName,String pjNum,Integer pjStatus,Long bzId) {
		return pjDynamicInfoDao.findPageModelPJDynamic(jcType,firstUnitId,pjName,pjNum,pjStatus,bzId);
	}
	
	/**
	 * 选择一个动态配件做检修
	 */
	public void saveChoicePJFix(String pjdid) {
		String[] ids = pjdid.split(",");
		Long pjDynmicId;
		PJDynamicInfo pjDynamicInfo;
		PJStaticInfo pjStaticInfo;
		List<PJStaticInfo> childPJs;
		PJFixRecord partRecord;
		int flowTypeId = 0;
		List<PJFixFlow> fixFlows = null;
		PJFixFlowRecord flowRecord = null;
		PJFixRecord fixRecord = null;
		String partTeams = null;
		List<DictProTeam> teams = null;
		List<PJFixItem> fixItems = null;
		long teamId;
		for(String pid : ids){
			pjDynmicId = Long.parseLong(pid);
			pjDynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjDynmicId);
			
			pjStaticInfo = pjDynamicInfo.getPjStaticInfo();
			childPJs = pjStaticInfoDao.findChildPJByParentPJFromFixItem(pjStaticInfo.getPjsid());
			partRecord = new PJFixRecord();
			partRecord.setPjDynamicInfo(pjDynamicInfo);
			partRecord.setPjname(pjDynamicInfo.getPjName());
			partRecord.setType(0);//类型为：配件
			partRecord.setAccepttime(new Date());//检修时间
			if(childPJs!=null && childPJs.size()>0){
				partRecord.setRecstas(1); //状态：新建且有子配件
			}else{
				partRecord.setRecstas(0); //状态：新建
			}
			pjFixRecordDao.savePJFixRecord(partRecord);
			//设置当前配件进入对应配件检修流程的第一个流程步骤
			flowTypeId = pjStaticInfo.getPjFixFlowType().getFlowTypeId();
			//查询出当前配件所有的流程节点
			fixFlows = pjFixFlowDao.findPJFixFlowListByFlowType(flowTypeId);
			partTeams = partRecord.getTeams();
			for (PJFixFlow pjFixFlow : fixFlows) {
				//查询出负责当前流程节点检修项目的班组
				teams = pjFixFlowDao.findFixFlowTeam(pjStaticInfo.getPjsid(),pjFixFlow.getNodeId());
				for (DictProTeam dictProTeam : teams) {//生成班组检修对应的流程节点记录
					flowRecord = new PJFixFlowRecord();
					flowRecord.setPjDynamicInfo(pjDynamicInfo);
					flowRecord.setPjFixFlow(pjFixFlow);
					flowRecord.setTeam(dictProTeam);
					flowRecord.setStatus(0);
					pjFixFlowDao.savePJFixFlowRecord(flowRecord);
					
					//查询出当前班组在当前流程节点的检修项目
					fixItems = pjFixRecordDao.findPJFixItemListByPJAndFlowAndTeam(pjStaticInfo.getPjsid(),
							pjFixFlow.getNodeId(),dictProTeam.getProteamid());
					for (PJFixItem fixItem : fixItems) {//遍历当前的所有检修项目，产生对应的记录
						fixRecord = new PJFixRecord();
						fixRecord.setPjFixItem(fixItem);
						fixRecord.setPjFixFlowRecord(flowRecord);
						fixRecord.setPjDynamicInfo(pjDynamicInfo);
						fixRecord.setPjname(pjDynamicInfo.getPjName());
						fixRecord.setPjFixRecSid(partRecord.getPjRecId()); //检修配件的配件记录id
						fixRecord.setType(1); //为检修项目记录
						fixRecord.setTeams(dictProTeam.getProteamid()+""); //负责该项目的班组id
						fixRecord.setRecstas(0);  //状态为新建
						fixRecord.setParentId(partRecord.getPjRecId());
						pjFixRecordDao.savePJFixRecord(fixRecord);
					}
					//向配件记录中添加当前班组id
					teamId = dictProTeam.getProteamid();
					if(partTeams==null){
						partTeams = ","+teamId+",";
					}else{
						if(!partTeams.contains(","+teamId+",")){
							partTeams += dictProTeam.getProteamid();
							partTeams +=",";
						}
					}
				}
			}
			partRecord.setTeams(partTeams);//设置当前配件记录的班组id集合
			pjFixRecordDao.updatePJFixRecord(partRecord);
			
			pjDynamicInfo.setPjStatus(3);//设置当前动态配件的状态为“检修中”
			pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
		}
	}
	
	/**
	 * 选择一个动态配件做检修(没有和节点关联)
	 */
	public void saveChoicePJFixNew(String pjdid) {
		String[] ids = pjdid.split(",");
		Long pjDynmicId;
		PJDynamicInfo pjDynamicInfo;
		PJStaticInfo pjStaticInfo;
		List<PJStaticInfo> childPJs;
		PJFixRecord partRecord;
		PJFixFlowRecord flowRecord = null;
		PJFixRecord fixRecord = null;
		String partTeams = null;
		List<DictProTeam> teams = null;
		List<PJFixItem> fixItems = null;
		long teamId;
		for(String pid : ids){
			pjDynmicId = Long.parseLong(pid);
			pjDynamicInfo = pjDynamicInfoDao.getPJDynamicInfoById(pjDynmicId);
			pjStaticInfo = pjDynamicInfo.getPjStaticInfo();
			childPJs = pjStaticInfoDao.findChildPJByParentPJFromFixItem(pjStaticInfo.getPjsid());
			partRecord = new PJFixRecord();
			partRecord.setPjDynamicInfo(pjDynamicInfo);
			partRecord.setPjname(pjDynamicInfo.getPjName());
			partRecord.setType(0);//类型为：配件
			partRecord.setAccepttime(new Date());//检修时间
			if(childPJs!=null && childPJs.size()>0){
				partRecord.setRecstas(1); //状态：新建且有子配件
			}else{
			partRecord.setRecstas(0); //状态：新建
			}
			pjFixRecordDao.savePJFixRecord(partRecord);
			//查询出当前配件所有的流程节点
			flowRecord = null;
			fixRecord = null;
			partTeams = partRecord.getTeams();
			//查询出相应静态配件信息检修项目
			fixItems = pjFixRecordDao.findPJFixItemListByPJAndFlowAndTeam(pjStaticInfo.getPjsid());
			for (PJFixItem fixItem : fixItems) {//遍历当前的所有检修项目，产生对应的记录
				fixRecord = new PJFixRecord();
				fixRecord.setPjFixItem(fixItem);
				fixRecord.setPjFixFlowRecord(flowRecord);
				fixRecord.setPjDynamicInfo(pjDynamicInfo);
				fixRecord.setPjname(pjDynamicInfo.getPjName());
				fixRecord.setPjFixRecSid(partRecord.getPjRecId()); //检修配件的配件记录id
				fixRecord.setType(1); //为检修项目记录
				fixRecord.setTeams(fixItem.getTeam().getProteamid()+""); //负责该项目的班组id
				fixRecord.setRecstas(0);  //状态为新建
				fixRecord.setParentId(partRecord.getPjRecId());
				
				//与项目关联字段
				fixRecord.setPosiName(fixItem.getPosiName());
				fixRecord.setFixItem(fixItem.getFixItem());
				fixRecord.setUnit(fixItem.getUnit());
				fixRecord.setItemctrlcomld(fixItem.getItemctrlcomld());
				fixRecord.setItemctrlacce(fixItem.getItemctrlacce());
				fixRecord.setItemctrllead(fixItem.getItemctrllead());
				fixRecord.setItemctrlqi(fixItem.getItemctrlqi());
				fixRecord.setItemctrltech(fixItem.getItemctrltech());
				fixRecord.setItemctrlrept(fixItem.getItemctrlrept());
				pjFixRecordDao.savePJFixRecord(fixRecord);
			}
			//查询出项目检修班组
			teams = pjFixFlowDao.findFixFlowTeam(pjStaticInfo.getPjsid());
			for (DictProTeam dictProTeam : teams) {//生成班组检修对应的流程节点记录
				//向配件记录中添加当前班组id
				teamId = dictProTeam.getProteamid();
				if(partTeams==null){
					partTeams = ","+teamId+",";
				}else{
					if(!partTeams.contains(","+teamId+",")){
						partTeams += dictProTeam.getProteamid();
						partTeams +=",";
					}
				}
			}
			partRecord.setTeams(partTeams);//设置当前配件记录的班组id集合
			pjFixRecordDao.updatePJFixRecord(partRecord);
			
			pjDynamicInfo.setPjStatus(3);//设置当前动态配件的状态为“检修中”
			pjDynamicInfoDao.updatePJDynamicInfo(pjDynamicInfo);
		}
	}
	
	/**
	 * 除工人和工长外其他角色查询所有正在检修中的配件
	 */
	public PageModel findPageModelFixingPJDynamic(String pjDid, UsersPrivs user,Long pjRecId) {
		long pjdid = Long.parseLong(pjDid);
		return pjFixRecordDao.findPageModelFixingPJDynamic(pjdid,user,pjRecId);
	}
	
	/**
	 * 填写组装配件的编码
	 */
	public String savePjNumberIntoRecord(UsersPrivs user, String recId,String pjNumber) {
		try {
			long recordId = Long.parseLong(recId);
			PJFixRecord record = pjFixRecordDao.getPJFixRecordById(recordId);
			String roles = user.getRoles();
			if(roles.contains(",GR,")){
				record.setFixemp(user.getXm());
				record.setFixempid(user.getUserid());
				record.setFixsituation("良好");
				record.setEmpaffirmtime(new Date());
				record.setPjNum(pjNumber);
				record.setRecstas(2);
				pjFixRecordDao.updatePJFixRecord(record);
			}else if(roles.contains(",GZ,")){
				if(record.getFixemp()==null){//检修员为空时
					record.setFixemp(user.getXm());
					record.setFixempid(user.getUserid());
					record.setFixsituation("良好");
					record.setEmpaffirmtime(new Date());
					record.setPjNum(pjNumber);
					record.setLeadid(user.getUserid());
					record.setLead(user.getXm());
					record.setLdaffirmtime(new Date());
					record.setRecstas(3);
				}else{
					record.setLeadid(user.getUserid());
					record.setLead(user.getXm());
					record.setLdaffirmtime(new Date());
					record.setPjNum(pjNumber);
					record.setRecstas(3);
				}
				pjFixRecordDao.updatePJFixRecord(record);
			}
			saveToFinishRecord(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "操作失败";
		}
		return "操作成功";
	}

	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String pjName, String pjNum) {
		return pjDynamicInfoDao.findPJDynamicInfo(pjName, pjNum);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long bzid, String flag) {
		return pjFixRecordDao.findPJFixRecord(pjdid, bzid, flag);
	}

	@Override
	public String saveSignFixItem(UsersPrivs user, String records) throws Exception {
		String[] recordArr = records.split(",");
		String result = "success";
		boolean flag = true;
		for (int i = 0; i < recordArr.length; i++) {
			long recId = Long.parseLong(recordArr[i]);
			PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
			if(null == pjFixRecord.getFixemp() || 
					(pjFixRecord.getPjFixItem().getItemctrlrept()!=null &&pjFixRecord.getPjFixItem().getItemctrlrept()==1 && pjFixRecord.getRept()==null)){
				flag = false;
				result = "havefixemp";
				break;
			}
		}
		if(flag){
			for (int i = 0; i < recordArr.length; i++) {
				long recId = Long.parseLong(recordArr[i]);
				PJFixRecord pjFixRecord = pjFixRecordDao.getPJFixRecordById(recId);
				pjFixRecord.setLeadid(user.getUserid());
				pjFixRecord.setLead(user.getXm());
				pjFixRecord.setLdaffirmtime(new Date());
				pjFixRecord.setRecstas(3);
				pjFixRecordDao.updatePJFixRecord(pjFixRecord);
				saveToFinishRecord(pjFixRecord);
			}
		}
		return result;
	}

	@Override
	public PJFixRecord findPJFixRecordById(Long recId) {
		return pjFixRecordDao.findPJFixRecordById(recId);
	}

	@Override
	public List listPJDynamicInfo(String jcType, Long firstUnitId,
			String pjName, Long bzId) {
		
		return pjDynamicInfoDao.listPJDynamicInfo(jcType, firstUnitId, pjName, bzId);
	}
	
	public List<PJPresetDivision> findPJStaticInfoPreset(Long pjsId){
		return pjStaticInfoDao.findPJStaticInfoPreset(pjsId);
	}

	@Override
	public List<PJFixRecord> findPJFixRecordByPresetRelateID(Long presetId, Long pjRecId, int type) {
		return pjFixRecordDao.findPJFixRecordByPresetRelateID(presetId, pjRecId, type);
	}

	@Override
	public int countSignedPreset(Long presetId, Long pjRecId, int type) {
		return pjFixRecordDao.countSignedPreset(presetId,pjRecId,type);
	}

	@Override
	public int countPJPresetItem(Long presetId, int type) {
		return pjFixRecordDao.countPJPresetItem(presetId, type);
	}
}
