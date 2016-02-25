package com.repair.experiment.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.gxp.org.apache.xerces.impl.Constants;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JcExpSignRec;
import com.repair.common.pojo.JcExperimentItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.experiment.dao.JcExpRecDao;
import com.repair.experiment.dao.JcExperimentItemDao;
import com.repair.experiment.service.ExperimentService;

public class ExperimentServiceImpl  implements ExperimentService {

	private static SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	@Autowired
	private JcExperimentItemDao jcExperimentItemDao;
	@Autowired
	private JcExpRecDao jcExpRecDao;
	
	@Override
	public String findChoicedItemStrs(Long userid, int rjhmId) {
		String items = "";
		List list = jcExpRecDao.findUserChoicedItemRecNames(userid,rjhmId);
		for (int i = 0; i < list.size(); i++) {
			items = items +list.get(i)+",";
		}
		return items;
	}
	
	@Override
	public DatePlanPri findDatePlanPriById(int rjhmId) {
		return jcExpRecDao.findDatePlanPriById(rjhmId);
	}
	
	/**
	 * 根据机车试验流程节点和机车类型查询当前机车所有的试验
	 * @param flowId 试验流程节点id
	 * @param jcType  机车类型：SS3B、DF4等
	 */
	public List<JcExperimentItem> findJcExperimentsByFlowIdAndJcType(int flowId, String jcType) {
		return jcExperimentItemDao.findJcExperimentsByFlowIdAndJcType(flowId,jcType);
	}

	/**
	 * 查询当前试验已经签认的试验项目
	 * @param expId 试验id
	 * @param rjhmId 日计划id
	 * @return
	 */
	public Map<String, String> findSignedExpItems(String expId,int rjhmId) {
		int experimentId = Integer.parseInt(expId);
		Map<String,String> map = new LinkedHashMap<String, String>();
		List list = jcExpRecDao.findSignedItemRecNameAndVal(rjhmId,experimentId);
		for (int i = 0; i < list.size(); i++) {
			Object[] objs = (Object[])list.get(i);
			map.put(objs[0]+"", objs[1]+"");
			map.put(objs[0]+"id", objs[2]+"");
			map.put(objs[0]+"info", "检修员："+objs[3]+",");
		}
		return map;
	}
	
	@Override
	public void saveSignExperimentItemByWorker(UsersPrivs user,
			String itemName, String itemVal, int rjhmId, long experimentId) {
		DatePlanPri datePlan = jcExpRecDao.findDatePlanPriById(rjhmId);
		int parentId = new Long(experimentId).intValue();
		JcExperimentItem expItem = jcExperimentItemDao.findExperimentItemByItemName(parentId,itemName);
		JcExpRec record = jcExpRecDao.findJcExpRec(rjhmId, experimentId, itemName);
		if(record == null){
			JcExpRec jcExpRec = new JcExpRec();
			jcExpRec.setJcnum(datePlan.getJcnum());
			jcExpRec.setDypRecId(datePlan);
			jcExpRec.setXc(datePlan.getFixFreque());
			jcExpRec.setItemId(expItem);
			jcExpRec.setItemName(expItem.getItemName());
			jcExpRec.setExpStatus(itemVal);
			jcExpRec.setFixSigneeId(user.getUserid().intValue());
			jcExpRec.setFixSignee(user.getXm());
			jcExpRec.setEmpAffirmTime(SDF.format(new Date()));
			jcExpRec.setExpType(0);
			jcExpRec.setRecStas((short)0);
			jcExpRecDao.saveJcExpRec(jcExpRec);
			
			//还需往试验记录中添加当前检修人名字
			JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
			String fixIds = experiment.getFixEmpId()==null?"":experiment.getFixEmpId();
			if(!fixIds.contains(user.getUserid()+",")){//当前用户在试验的检修人中不存在
				experiment.setFixEmpId(user.getUserid()+",");
				experiment.setFixEmp(user.getXm()+",");
				jcExpRecDao.updateJcExpRec(experiment);//把当前用户添加到试验的检修人中
			}
		}else{//工人在填写检修情况后，立即修改检修记录
			record.setExpStatus(itemVal);
			jcExpRecDao.updateJcExpRec(record);
		}
		
	}
	
	@Override
	public String saveChangeExpItemRecValByWorker(UsersPrivs user, long itemRecId,String itemVal) {
		JcExpRec jcExpRec = jcExpRecDao.findJcExpRecById(itemRecId);
		int datePlanId = jcExpRec.getDypRecId().getRjhmId();
		int expId = jcExpRec.getItemId().getParentId();
		Long experimentId = Long.parseLong(expId+"");
		JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(datePlanId,experimentId);
		if(experiment.getCommitLead()!=null){
			return "交车工长已经签认，您不能再修改记录了";
		}else{
			String fixIds = experiment.getFixEmpId()==null?"":experiment.getFixEmpId();
			if(!fixIds.contains(user.getUserid()+",")){//当前用户在试验的检修人中不存在
				String fixNames = experiment.getFixEmp()==null ? "":experiment.getFixEmp();
				experiment.setFixEmpId(fixIds+","+user.getUserid()+",");
				experiment.setFixEmp(fixNames+","+user.getXm()+",");
				jcExpRecDao.updateJcExpRec(experiment);//把当前用户添加到试验的检修人中
			}
			
			jcExpRec.setExpStatus(itemVal);
			jcExpRec.setFixSigneeId(user.getUserid().intValue());
			jcExpRec.setFixSignee(user.getXm());
			jcExpRecDao.updateJcExpRec(jcExpRec);
		}
		return "保存成功";
	}
	
	@Override
	public void saveJcExperimentByDatePlanAndExpId(int rjhmId, String expId) {
		Long experimentId = Long.parseLong(expId);
		JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
		if(experiment == null){
			DatePlanPri datePlan = jcExpRecDao.findDatePlanPriById(rjhmId);
			JcExperimentItem expItem = jcExperimentItemDao.findExperimentItemById(experimentId);
			JcExpRec jcExpRec = new JcExpRec();
			jcExpRec.setJcnum(datePlan.getJcnum());
			jcExpRec.setDypRecId(datePlan);
			jcExpRec.setXc(datePlan.getFixFreque());
			jcExpRec.setItemId(expItem);
			jcExpRec.setItemName(expItem.getItemName());
			jcExpRec.setFixEmpId(",");
			jcExpRec.setFixEmp(",");
			jcExpRec.setExpType(1);
			jcExpRec.setRecStas((short)0);
			jcExpRecDao.saveJcExpRec(jcExpRec);
		}
	}
	
	@Override
	public void saveSignJcExperimentTime(UsersPrivs user, String expTime,
			int rjhmId, Long experimentId) {
		// TODO Auto-generated method stub
		JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
		experiment.setEmpAffirmTime(expTime);
		jcExpRecDao.updateJcExpRec(experiment);
	}
	
	@Override
	public JcExpRec findJcExperimentByDatePlanAndExpId(int rjhmId, String expId) {
		long experimentId = Long.parseLong(expId);
		JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
		return experiment;
	}
	
	@Override
	public String saveSignExperimentItemByLead(UsersPrivs user,
			String itemName, int rjhmId, long experimentId, String roleFlag) {
		try {
			DatePlanPri datePlan = jcExpRecDao.findDatePlanPriById(rjhmId);
			JcExperimentItem experimentItem = jcExperimentItemDao.findExperimentItemById(experimentId);
			JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
			List<JcExpRec> records = jcExpRecDao.findJcExpRecList(rjhmId,experimentId,itemName);
			List<Long> roles = new LinkedList<Long>();
			List list = jcExpRecDao.findUserRolesByUserId(user.getUserid());
			for (int i = 0; i < list.size(); i++) {
				roles.add((Long)list.get(i));
			}
			if(roleFlag.equals("2")){//工长签认
				if(roles.contains(3L)){
					JcExpSignRec signRec = jcExpRecDao.findJcExpSignRecByPlanAndItemName(rjhmId,itemName);
					if(null == signRec ){
						JcExpSignRec signRecord = new JcExpSignRec();
						signRecord.setJwdCode("0888");
						signRecord.setDatePlan(datePlan);
						signRecord.setExperiment(experimentItem);
						signRecord.setItemName(itemName);
						signRecord.setLeadId(user.getUserid().intValue());
						signRecord.setLeader(user.getXm());
						signRecord.setLdAffirmTime(SDF.format(new Date()));
						signRecord.setRecStas((short)1);
						jcExpRecDao.saveJcExpSignRec(signRecord);
					}
					for (JcExpRec jcExpRec : records) {
						jcExpRec.setLeadId(user.getUserid().intValue());
						jcExpRec.setLeader(user.getXm());
						jcExpRec.setLdAffirmTime(SDF.format(new Date()));
						jcExpRec.setRecStas((short)2);
						jcExpRecDao.updateJcExpRec(jcExpRec);
						
						String lead = experiment.getLeader();
						if(lead == null){
							lead = user.getXm()+ ",";
							experiment.setLeadId(user.getUserid().intValue());
							experiment.setLeader(lead);
							experiment.setRecStas((short)2);
							jcExpRecDao.updateJcExpRec(experiment);
						}else{
							if(!lead.contains(jcExpRec.getLeader())){
								lead += user.getXm();
								lead += ",";
								experiment.setLeadId(user.getUserid().intValue());
								experiment.setLeader(lead);
								experiment.setRecStas((short)2);
								jcExpRecDao.updateJcExpRec(experiment);
							}
						}
					}
				}else{
					return "您不具有工长角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("3")){//质检员
				if(roles.contains(6L)||roles.contains(13L)){
					JcExpSignRec signRec = jcExpRecDao.findJcExpSignRecByPlanAndItemName(rjhmId,itemName);
					if(signRec==null || signRec.getLeader() == null){//工长还未签认
						return "工长还未签认，暂时不能签认当前的项目";
					}else{
						if(null == signRec ){
							JcExpSignRec signRecord = new JcExpSignRec();
							signRecord.setDatePlan(datePlan);
							signRecord.setExperiment(experimentItem);
							signRecord.setItemName(itemName);
							signRecord.setQiId(user.getUserid().intValue());
							signRecord.setQi(user.getXm());
							signRecord.setQiAffiTime(SDF.format(new Date()));
							signRecord.setRecStas((short)2);
							jcExpRecDao.saveJcExpSignRec(signRecord);
						}else{
							signRec.setQiId(user.getUserid().intValue());
							signRec.setQi(user.getXm());
							signRec.setQiAffiTime(SDF.format(new Date()));
							signRec.setRecStas((short)2);
							jcExpRecDao.updateJcExpSignRec(signRec);
						}
						for (JcExpRec jcExpRec : records) {
							if(jcExpRec.getItemId().getItemCtrlQi()!=null && jcExpRec.getItemId().getItemCtrlQi().intValue()==1){
								jcExpRec.setQiId(user.getUserid().intValue());
								jcExpRec.setQi(user.getXm());
								jcExpRec.setQiAffiTime(SDF.format(new Date()));
								jcExpRec.setRecStas((short)3);
								jcExpRecDao.updateJcExpRec(jcExpRec);
								
								String qis = experiment.getQi();
								if(qis == null){
									qis += user.getXm();
									qis += ",";
									experiment.setQiId(user.getUserid().intValue());
									experiment.setQi(qis);
									experiment.setRecStas((short)3);
									jcExpRecDao.updateJcExpRec(experiment);
								}else{
									if(!qis.contains(jcExpRec.getQi())){
										qis += user.getXm();
										qis += ",";
										experiment.setQiId(user.getUserid().intValue());
										experiment.setQi(qis);
										experiment.setRecStas((short)3);
										jcExpRecDao.updateJcExpRec(experiment);
									}
								}
							}
						}
					}
				}else{
					return "您不具有质检员角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("4")){//技术
				if(roles.contains(7L)||roles.contains(14L)){
					JcExpSignRec signRec = jcExpRecDao.findJcExpSignRecByPlanAndItemName(rjhmId,itemName);
					if(signRec==null || signRec.getLeader() == null){//工长还未签认
						return "工长还未签认，暂时不能签认当前的项目";
					}else{
						if(null == signRec ){
							JcExpSignRec signRecord = new JcExpSignRec();
							signRecord.setDatePlan(datePlan);
							signRecord.setExperiment(experimentItem);
							signRecord.setItemName(itemName);
							signRecord.setTeachId(user.getUserid().intValue());
							signRecord.setTeachName(user.getXm());
							signRecord.setTeachFiTime(SDF.format(new Date()));
							signRecord.setRecStas((short)3);
							jcExpRecDao.saveJcExpSignRec(signRecord);
						}else{
							signRec.setTeachId(user.getUserid().intValue());
							signRec.setTeachName(user.getXm());
							signRec.setTeachFiTime(SDF.format(new Date()));
							signRec.setRecStas((short)3);
							jcExpRecDao.updateJcExpSignRec(signRec);
						}
						for (JcExpRec jcExpRec : records) {
							if(jcExpRec.getItemId().getItemCtrlTech()!=null && jcExpRec.getItemId().getItemCtrlTech().intValue()==1){
								jcExpRec.setTeachId(user.getUserid().intValue());
								jcExpRec.setTeachName(user.getXm());
								jcExpRec.setTeachFiTime(SDF.format(new Date()));
								jcExpRec.setRecStas((short)4);
								jcExpRecDao.updateJcExpRec(jcExpRec);
								
								String teas = experiment.getTeachName();
								if(teas==null){
									teas = user.getXm()+ ",";
									experiment.setTeachId(user.getUserid().intValue());
									experiment.setTeachName(teas);
									experiment.setRecStas((short)4);
									jcExpRecDao.updateJcExpRec(experiment);
								}else if(!teas.contains(jcExpRec.getTeachName())){
									teas += user.getXm();
									teas += ",";
									experiment.setTeachId(user.getUserid().intValue());
									experiment.setTeachName(teas);
									experiment.setRecStas((short)4);
									jcExpRecDao.updateJcExpRec(experiment);
								}
							}
						}
					}
				}else{
					return "您不具有技术员角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("5")){//交车工长
				if(roles.contains(9L)){
					for (JcExpRec jcExpRec : records) {
						Short ctrlLead = jcExpRec.getItemId().getItemCtrlLead();
						if(jcExpRec.getLeader()==null && (ctrlLead!=null && ctrlLead==1)){
							return "还有工人未签认的项目，您暂时不能签认";
						}
					}
					List<JcExpSignRec> signRecs = jcExpRecDao.findJcExpSignRecListByPlan(rjhmId);
					if(signRecs != null){//加入交车工长签认
						for (JcExpSignRec sr : signRecs) {
							sr.setCommitLeadId(user.getUserid().intValue());
							sr.setCommitLead(user.getXm());
							sr.setComLdAffiTime(SDF.format(new Date()));
							sr.setRecStas((short)4);
							jcExpRecDao.updateJcExpSignRec(sr);
						}
					}
					for (JcExpRec jcExpRec : records) {
						jcExpRec.setCommitLeadId(user.getUserid().intValue());
						jcExpRec.setCommitLead(user.getXm());
						jcExpRec.setComLdAffiTime(SDF.format(new Date()));
						jcExpRec.setRecStas((short)5);
						jcExpRecDao.updateJcExpRec(jcExpRec);
					}
					String comLead = experiment.getCommitLead();
					if(comLead == null){
						experiment.setCommitLeadId(user.getUserid().intValue());
						experiment.setCommitLead(user.getXm());
						experiment.setComLdAffiTime(SDF.format(new Date()));
						experiment.setRecStas((short)5);
						jcExpRecDao.updateJcExpRec(experiment);
					}
				}else{
					return "您不是交车工长角色，不能全签当前项目";
				}
			}else if(roleFlag.equals("6")){//验收员
				if(roles.contains(8L)){
					for (JcExpRec jcExpRec : records) {
						if(jcExpRec.getCommitLead()==null){
							return "交车工长还未签认，您暂时不能签认";
						}
					}
					List<JcExpSignRec> signRecs = jcExpRecDao.findJcExpSignRecListByPlan(rjhmId);
					if(signRecs != null){//加入验收员签认
						for (JcExpSignRec sr : signRecs) {
							sr.setAccepterId(user.getUserid().intValue());
							sr.setAccepter(user.getXm());
							sr.setAcceAffiTime(SDF.format(new Date()));
							sr.setRecStas((short)5);
							jcExpRecDao.updateJcExpSignRec(sr);
						}
					}
					for (JcExpRec jcExpRec : records) {
						jcExpRec.setAccepterId(user.getUserid().intValue());
						jcExpRec.setAccepter(user.getXm());
						jcExpRec.setAcceAffiTime(SDF.format(new Date()));
						jcExpRec.setRecStas((short)6);
						jcExpRecDao.updateJcExpRec(jcExpRec);
					}
					//验收员都签认完成
					//if(jcExpRecDao.countJcYsExpRecList(rjhmId, experimentId)==0){
					//设置当前试验完成
					experiment.setAccepterId(user.getUserid().intValue());
					experiment.setAccepter(user.getXm());
					experiment.setAcceAffiTime(SDF.format(new Date()));
					experiment.setRecStas((short)6);
					jcExpRecDao.updateJcExpRec(experiment);
					//判断试验是否完成
					isFinished(rjhmId,experimentId);
					//}
				}else{
					return "您不具有验收员角色，不能全签当前项目";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "操作失败";
		}
		return "操作成功";
	}

	/**
	 * 判断当前流程节点的试验是否完成
	 * @param rjhmId
	 * @param experimentId
	 */
	private void isFinished(int rjhmId, Long experimentId) {
		DatePlanPri datePlan = jcExpRecDao.findDatePlanPriById(rjhmId);
		int jcFlowId = datePlan.getNodeid().getJcFlowId();
		if(jcFlowId==Contains.ZX_SY_NODEID){//试验流程
			List<JcExpRec> records = jcExpRecDao.findJcExpRecByPlanAndExp(rjhmId,jcFlowId,experimentId);
			boolean finished = true;
			for (JcExpRec jcExpRec : records) {
				if(jcExpRec.getRecStas().intValue()!=6){//还有项目没签完
					finished = false;
					break;
				}
			}
			if(finished){//当前试验已经完成
				boolean ofinished = true;
				List<JcExpRec> exprimentList = jcExpRecDao.findJcExperimentsByPlanAndFlow(rjhmId,jcFlowId);
				if(exprimentList.size()>1){//当前机车试验节点的两个试验都开始检修了
					for (JcExpRec jcExpRec : exprimentList) {
						if(jcExpRec.getRecStas().intValue()!=6){//试验未完成
							System.out.println("当前流程节点还有试验未完成");
							ofinished = false;
							break;
						}
					}
					if(ofinished){//该日计划的所有试验都完成了，进入试运行节点
						JCFixflow flow = jcExpRecDao.findJcFixflowById(Contains.ZX_SYX_NODEID);
						datePlan.setNodeid(flow);
						jcExpRecDao.updateDatePlanPri(datePlan);
					}
				}
			}
		}else if(jcFlowId==Contains.ZX_SYX_NODEID){//试运行试验流程
			List<JcExpRec> records = jcExpRecDao.findJcExpRecByPlanAndExp(rjhmId,jcFlowId,experimentId);
			boolean finished = true;
			for (JcExpRec jcExpRec : records) {
				if(jcExpRec.getRecStas().intValue()!=6){//还有项目没签完
					finished = false;
					break;
				}
			}
			if(finished){//当前日计划完成
				datePlan.setPlanStatue(1);
				jcExpRecDao.updateDatePlanPri(datePlan);
			}
		}
		
	}
	
	@Override
	public String saveSignExperimentItemAll(UsersPrivs user, int rjhmId,Long experimentId, String roleFlag) {
		JcExpRec experiment = jcExpRecDao.findJcExperimentByDatePlanAndExpId(rjhmId,experimentId);
		int expItemCount = jcExperimentItemDao.findExperimentAllItemCount(experimentId.intValue());
		jcExpRecDao.deleteJcExpRec(rjhmId);//删除JC_EXP_REC表中的重复记录
		List<JcExpRec> expRecList = jcExpRecDao.findExperimentAllRec(rjhmId,experimentId.intValue());
		int expRecCount = expRecList==null?0:expRecList.size();
		if(expItemCount != expRecCount){
			return "检修员还有项目未签完，您暂时不能全签";
		}else{
			List<Long> roles = new LinkedList<Long>();
			List list = jcExpRecDao.findUserRolesByUserId(user.getUserid());
			for (int i = 0; i < list.size(); i++) {
				roles.add((Long)list.get(i));
			}
			if(roleFlag.equals("2")){
				if(roles.contains(3L)){
					for (JcExpRec jcExpRec : expRecList) {
						jcExpRec.setLeadId(user.getUserid().intValue());
						jcExpRec.setLeader(user.getXm());
						jcExpRec.setLdAffirmTime(SDF.format(new Date()));
						jcExpRec.setRecStas((short)2);
						jcExpRecDao.updateJcExpRec(jcExpRec);
					}
					experiment.setLeadId(user.getUserid().intValue());
					experiment.setLeader(user.getXm());
					experiment.setLdAffirmTime(SDF.format(new Date()));
					experiment.setRecStas((short)2);
					jcExpRecDao.updateJcExpRec(experiment);
				}else{
					return "您不具有工长角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("3")){
				if(roles.contains(6L)||roles.contains(13L)){
					for (JcExpRec jcExpRec : expRecList) {
						if(jcExpRec.getItemId().getItemCtrlQi()!=null && jcExpRec.getItemId().getItemCtrlQi().intValue()==1){
							jcExpRec.setQiId(user.getUserid().intValue());
							jcExpRec.setQi(user.getXm());
							jcExpRec.setQiAffiTime(SDF.format(new Date()));
							jcExpRec.setRecStas((short)3);
							jcExpRecDao.updateJcExpRec(jcExpRec);
						}
					}
					String qis = experiment.getQi();
					if(qis == null){
						experiment.setQiId(user.getUserid().intValue());
						experiment.setQi(user.getXm());
						experiment.setQiAffiTime(SDF.format(new Date()));
						experiment.setRecStas((short)3);
						jcExpRecDao.updateJcExpRec(experiment);
					}
				}else{
					return "您不具有质检员角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("4")){
				if(roles.contains(7L)||roles.contains(14L)){
					for (JcExpRec jcExpRec : expRecList) {
						if(jcExpRec.getItemId().getItemCtrlTech()!=null && jcExpRec.getItemId().getItemCtrlTech().intValue()==1){
							jcExpRec.setTeachId(user.getUserid().intValue());
							jcExpRec.setTeachName(user.getXm());
							jcExpRec.setTeachFiTime(SDF.format(new Date()));
							jcExpRec.setRecStas((short)4);
							jcExpRecDao.updateJcExpRec(jcExpRec);
						}
					}
					String teas = experiment.getTeachName();
					if(teas == null){
						experiment.setTeachId(user.getUserid().intValue());
						experiment.setTeachName(user.getXm());
						experiment.setTeachFiTime(SDF.format(new Date()));
						experiment.setRecStas((short)4);
						jcExpRecDao.updateJcExpRec(experiment);
					}
				}else{
					return "您不具有技术员角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("5")){
				if(roles.contains(9L)){
					for (JcExpRec jcExpRec : expRecList) {
						if(jcExpRec.getLeader()==null){
							return "还有工人未签认的项目，您暂时不能签认";
						}
					}
					for (JcExpRec jcExpRec : expRecList) {
						jcExpRec.setCommitLeadId(user.getUserid().intValue());
						jcExpRec.setCommitLead(user.getXm());
						jcExpRec.setComLdAffiTime(SDF.format(new Date()));
						jcExpRec.setRecStas((short)5);
						jcExpRecDao.updateJcExpRec(jcExpRec);
					}
					experiment.setCommitLeadId(user.getUserid().intValue());
					experiment.setCommitLead(user.getXm());
					experiment.setComLdAffiTime(SDF.format(new Date()));
					experiment.setRecStas((short)5);
					jcExpRecDao.updateJcExpRec(experiment);
				}else{
					return "您不具有交车工长角色，不能签认当前项目";
				}
			}else if(roleFlag.equals("6")){//验收员签认
				if(roles.contains(8L)){
					if(experiment.getCommitLead()==null){
						return "交车工长还未签认，您暂时不能签认";
					}else{
						for (JcExpRec jcExpRec : expRecList) {
							jcExpRec.setAccepterId(user.getUserid().intValue());
							jcExpRec.setAccepter(user.getXm());
							jcExpRec.setAcceAffiTime(SDF.format(new Date()));
							jcExpRec.setRecStas((short)6);
							jcExpRecDao.updateJcExpRec(jcExpRec);
						}
					}
					experiment.setAccepterId(user.getUserid().intValue());
					experiment.setAccepter(user.getXm());
					experiment.setAcceAffiTime(SDF.format(new Date()));
					experiment.setRecStas((short)6);
					jcExpRecDao.updateJcExpRec(experiment);
					//判断试验是否完成
					isFinished(rjhmId,experimentId);
				}else{
					return "您不具有验收员角色，不能签认当前项目";
				}
			}
			return "操作成功";
		}
		
	}
	
	@Override
	public List<JcExpSignRec> findJcExpSignRecsByPlanAndExp(int rjhmId,String expId) {
		long experimentId = Long.parseLong(expId);
		List<JcExpSignRec> list = jcExpRecDao.findJcExpSignRecsByPlanAndExp(rjhmId,experimentId);
		return list;
	}
}
