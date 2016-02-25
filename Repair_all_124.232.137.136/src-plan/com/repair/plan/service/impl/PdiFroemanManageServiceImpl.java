package com.repair.plan.service.impl;

import static com.repair.common.util.WebUtil.dateConvertString;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.plan.dao.JcFixflowDao;
import com.repair.plan.dao.JcFlowRecDao;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.plan.vo.Dispatch;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.PresetDivisionDao;
import com.repair.work.dao.WorkDao;

@Repository("pdiFroemanManageService")
public class PdiFroemanManageServiceImpl implements PdiFroemanManageService {

	@Resource(name = "datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	@Resource(name = "dictProTeamDao")
	private DictProTeamDao dictProTeamDao;
	@Resource(name = "jtPreDictDao")
	private JtPreDictDao jtPreDictDao;
	@Resource(name = "jcFixflowDao")
	private JcFixflowDao jcFixflowDao;
	@Resource(name = "jcFlowRecDao")
	private JcFlowRecDao jcFlowRecDao;
	@Resource(name = "presetDivisionDao")
	private PresetDivisionDao presetDivisionDao;
	@Resource(name = "workDao")
	private WorkDao workDao;
	
	private SimpleDateFormat formmat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	@Override
	public List<DatePlanPri> findDatePlanByPdiFroeman(UsersPrivs usersPrivs) {
		return datePlanPriDao.findDatePlanPriByFroeman(usersPrivs);
	}

	@Override
	public List<DictProTeam> findDictProTeam() {
		return dictProTeamDao.findDictProTeam();
	}
	
	@Override
	public List<DictProTeam> findWorkDictProTeam() {
		return dictProTeamDao.findWorkDictProTeam();
	}

	@Override
	public JtPreDict findJtPreDictById(Integer preDictId) {
		return jtPreDictDao.findJtPreDictById(preDictId);
	}
	
//	@Override
	public void updateDispatching(Integer[] preDictIds, Dispatch dispatch, UsersPrivs usersPrivs){
		for (int i = 0, len = preDictIds.length; i < len; i++) {
			JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictIds[i]);
			preDict.setItemCtrlTech(dispatch.getItemCtrlTech());
			preDict.setItemCtrlQI(dispatch.getItemCtrlQI());
			preDict.setItemCtrlComLd(dispatch.getItemCtrlComLd());
			preDict.setItemCtrlAcce(dispatch.getItemCtrlAcce());
			preDict.setRecStas((short)1);
			preDict.setVerifier(usersPrivs.getXm());
			preDict.setVerifyTime(dateConvertString(new Date()));
			DictProTeam dictProTeam = null;
			JtPreDict temp = null;
			//----重写下面的方法
//			Long[] proTeamIds = dispatch.getProTeamIds();
//			for(int j=0;j<proTeamIds.length;j++){
//				if(j > 0){
//					temp = JtPreDict.copyObject(preDict);
//					dictProTeam = new DictProTeam();
//					dictProTeam.setProteamid(proTeamIds[j]);
//					temp.setProTeamId(dictProTeam);
//					jtPreDictDao.saveOrUpdate(temp);
//				}else{
//					dictProTeam = new DictProTeam();
//					dictProTeam.setProteamid(proTeamIds[0]);
//					preDict.setProTeamId(dictProTeam);
//					jtPreDictDao.saveOrUpdate(preDict);
//				}
//			}
		}
	}

	@Override
	public String updateDispatching(List<Integer> preDictIds, Dispatch dispatch, UsersPrivs usersPrivs,Integer opt) {
		DictProTeam dictProTeam;
		List<DictProTeam> teams = new ArrayList<DictProTeam>();
		String[] bzIds = dispatch.getBzIds().split(",");
		for (int i = 0; i < bzIds.length; i++) {
			dictProTeam = new DictProTeam();
			dictProTeam.setProteamid(Long.parseLong(bzIds[i].trim()));
			teams.add(dictProTeam);
		}
		
		JtPreDict preDict,temp;
		for (int i=0;i<preDictIds.size();i++) {
			preDict = jtPreDictDao.findJtPreDictById(preDictIds.get(i));
			for (int j=0; j<teams.size();j++) {
				if(j==0){
					preDict.setProTeamId(teams.get(j));
					preDict.setItemCtrlTech(dispatch.getItemCtrlTech());
					preDict.setItemCtrlQI(dispatch.getItemCtrlQI());
					preDict.setItemCtrlComLd(dispatch.getItemCtrlComLd());
					preDict.setItemCtrlAcce(dispatch.getItemCtrlAcce());
					preDict.setRecStas((short)2);
					preDict.setReceiptPeo(usersPrivs.getXm());
					preDict.setReceTime(dateConvertString(new Date()));
					jtPreDictDao.saveOrUpdate(preDict);
				}else{
					temp = JtPreDict.copyObject(preDict);
					temp.setProTeamId(teams.get(j));
					temp.setRecStas((short)2);
					temp.setSmpPreDictId(preDict.getPreDictId());
					jtPreDictDao.saveOrUpdate(temp);
				}
			}
		}
		return "";
	}
	
	@Override
	public Integer updateDatePlanSign(Integer rjhmId,Long userId) {
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
		//查询日计划下的检修记录是否存在，防止重复提交产生重复记录,为0表示不存在记录
		Long recCount=jcFlowRecDao.countFixRecByPlanId(rjhmId, datePlanPri.getProjectType());
		if (datePlanPri.getProjectType() == 0&&recCount==0) {//小辅修
			return XXJieChe(datePlanPri, userId);
		} else if(datePlanPri.getProjectType() == 1&&recCount==0){//中修
			return ZXJieChe(datePlanPri, userId);
		}else{
			return 5;
		}
	}
	
	private Integer XXJieChe(DatePlanPri datePlanPri, Long userId) {
		if(datePlanPri.getNodeid().getJcFlowId()!=Contains.XX_FJ_NODEID){
			return 1;
		}
		if (datePlanPri.getFixFreque().equals(Contains.PY_LX) || datePlanPri.getFixFreque().equals(Contains.PY_JG)|| datePlanPri.getFixFreque().equals(Contains.PY_ZZ)) {
			if (!jtPreDictDao.isJtPreDictDispatchingByDatePlan(datePlanPri)) {
				return 4;
			}
		}
//		JCFixflow fixflow = jcFixflowDao.findNextJcFixFlow(datePlanPri.getNodeid(), datePlanPri);
		JCFixflow fixflow=new JCFixflow();
		fixflow.setJcFlowId(Contains.XX_JX_NODEID);
//		System.out.println(fixflow.getNodeName());
		if (null != fixflow) {
			List<DictProTeam> dictProTeams = dictProTeamDao.findDictProTeamsByFixFlow(fixflow, datePlanPri);
			if (null != dictProTeams && !dictProTeams.isEmpty()) {
				datePlanPri.setNodeid(fixflow);
				datePlanPri.setPlanStatue(0);
				if(datePlanPri.getGongZhang()==null){
					UsersPrivs user = new UsersPrivs();
					user.setUserid(userId);
					datePlanPri.setGongZhang(user);
				}
				datePlanPriDao.saveOrUpdate(datePlanPri);
				
				//是否指定承修班组
				Long datePlanProteamId=datePlanPri.getProteamId();
				String workTeams=datePlanPri.getWorkTeam();
				List<Long> workTeamList=null;
				if(datePlanProteamId!=null){
					List<Long> teamIds=new ArrayList<Long>();
					teamIds.add(datePlanProteamId);
					if(workTeams!=null&&!"".equals(workTeams)){
						workTeamList=new ArrayList<Long>();
						for(String str:workTeams.split(",")){
							//查询该机车类型、修程修程、班组下是否存在检修项目，如果存在，则该班组需要工作
							Long count=jcFlowRecDao.countJcFixItemByBZ(datePlanPri, Long.parseLong(str));
							if(count!=0){//存在需要检修的项目
								teamIds.add(Long.parseLong(str));
								workTeamList.add(Long.parseLong(str));
							}
						}
					}
					for(Long teamId:teamIds){
						DictProTeam proTeam=dictProTeamDao.findDictProTeamById(teamId);
						JCFlowRec flowRec = new JCFlowRec();
						flowRec.setFixflow(fixflow);
						flowRec.setFinishStatus(0);
						flowRec.setDatePlanPri(datePlanPri);
						flowRec.setProTeam(proTeam);
						jcFlowRecDao.saveOrUpdate(flowRec);
					}
				}else{
					for (DictProTeam dictProTeam : dictProTeams) {
						JCFlowRec flowRec = new JCFlowRec();
						flowRec.setFixflow(fixflow);
						flowRec.setFinishStatus(0);
						flowRec.setDatePlanPri(datePlanPri);
						flowRec.setProTeam(dictProTeam);
						jcFlowRecDao.saveOrUpdate(flowRec);
					}
				}
				
				
				
				
				//将项目插入到记录信息表中	
				//2015-10-18  周云韬 修改
//				if (!datePlanPri.getFixFreque().equals(Contains.PY_LX) && !datePlanPri.getFixFreque().equals(Contains.PY_JG)&& !datePlanPri.getFixFreque().equals(Contains.PY_ZZ)
//						&& !datePlanPri.getFixFreque().equals(Contains.PY_CJ) && !datePlanPri.getFixFreque().equals(Contains.PY_QZ)) {
				if (!datePlanPri.getFixFreque().equals(Contains.PY_LX) && !datePlanPri.getFixFreque().equals(Contains.PY_JG)&& !datePlanPri.getFixFreque().equals(Contains.PY_ZZ)
						&& !datePlanPri.getFixFreque().equals(Contains.PY_CJ) ) {
					jcFlowRecDao.saveJcFixRec(datePlanPri);
					if(datePlanProteamId!=null){
						if(workTeamList!=null&&workTeamList.size()>0){
							jcFlowRecDao.updateJcFixRecProteam(datePlanPri.getRjhmId(), datePlanProteamId,workTeamList);
						}else{
							jcFlowRecDao.updateJcFixRecProteam(datePlanPri.getRjhmId(), datePlanProteamId);
						}
					}
				}
				//插入分工表
				List<PresetDivision> presetDivisions = presetDivisionDao.listPresetDivisionByJctype(datePlanPri.getJcType());
				String[] userids;
				String time = formmat.format(new Date());
				JCDivision division = null;
				UsersPrivs user = null;
				for (PresetDivision pd : presetDivisions) {
					if(pd.getFixEmpIds()!=null && !"".equals(pd.getFixEmpIds())){
						userids = pd.getFixEmpIds().split(",");
						for (String uid : userids) {
							user = new UsersPrivs();
							if(uid!=null && !"".equals(uid)){
								division = new JCDivision();
								division.setDayPlan(datePlanPri);
								division.setFgDate(time);
								division.setPresetDivision(pd);
								user.setUserid(Long.parseLong(uid));
								division.setUser(user);
								workDao.addJCDivision(division);
							}
						}
					}
				}
				return 3;
			} else {
				return 2;
			}
		} else {
			return 1;
		}
	}
	
	private Integer ZXJieChe(DatePlanPri datePlanPri, Long userId) {
		if(datePlanPri.getNodeid().getJcFlowId()!=Contains.ZX_FG_NODEID){
			return 1;
		}
		JCFixflow fixflow=new JCFixflow();
		fixflow.setJcFlowId(Contains.ZX_FG_NODEID);
		if (null != fixflow) {
			List<DictProTeam> dictProTeams = dictProTeamDao.findDictProTeamsByFixFlow(fixflow, datePlanPri);
			if (null != dictProTeams && !dictProTeams.isEmpty()) {
				datePlanPri.setNodeid(fixflow);
				datePlanPri.setPlanStatue(0);
				if(datePlanPri.getGongZhang()==null){
					UsersPrivs user = new UsersPrivs();
					user.setUserid(userId);
					datePlanPri.setGongZhang(user);
				}
				datePlanPriDao.saveOrUpdate(datePlanPri);
				
				for (DictProTeam dictProTeam : dictProTeams) {
					JCFlowRec flowRec = new JCFlowRec();
					flowRec.setFixflow(fixflow);
					flowRec.setFinishStatus(0);
					flowRec.setDatePlanPri(datePlanPri);
					flowRec.setProTeam(dictProTeam);
					jcFlowRecDao.saveOrUpdate(flowRec);
				}
				jcFlowRecDao.saveJcFixRec(datePlanPri, Contains.ZX_FG_NODEID);
				//插入分工表
				List<PresetDivision> presetDivisions = presetDivisionDao.listPresetDivisionByJctype(datePlanPri.getJcType());
				String[] userids;
				String time = formmat.format(new Date());
				JCDivision division = null;
				UsersPrivs user = null;
				for (PresetDivision pd : presetDivisions) {
					if(pd.getFixEmpIds()!=null && !"".equals(pd.getFixEmpIds())){
						userids = pd.getFixEmpIds().split(",");
						for (String uid : userids) {
							user = new UsersPrivs();
							if(uid!=null && !"".equals(uid)){
								division = new JCDivision();
								division.setDayPlan(datePlanPri);
								division.setFgDate(time);
								division.setPresetDivision(pd);
								user.setUserid(Long.parseLong(uid));
								division.setUser(user);
								workDao.addJCDivision(division);
							}
						}
					}
				}
				return 3;
			} else {
				return 2;
			}
		} else {
			return 1;
		}
	}

	@Override
	public DictProTeam findDictProTeamById(Long proteamid) {
		return dictProTeamDao.findDictProTeamById(proteamid);
	}
	
	public void deleteDispatching(Integer[] preDictIds){
		jtPreDictDao.delete(preDictIds);
	}
}
