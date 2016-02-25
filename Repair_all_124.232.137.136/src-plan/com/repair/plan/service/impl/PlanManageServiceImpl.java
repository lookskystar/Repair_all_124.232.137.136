package com.repair.plan.service.impl;

import static com.repair.common.util.WebUtil.isEmpty;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcFixSeq;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JGPlanContent;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.MonPlanPri;
import com.repair.common.pojo.MonPlanRecorder;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.WeekPlanPri;
import com.repair.common.pojo.WeekPlanRecorder;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.plan.dao.DictJcFixSeqDao;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.plan.dao.JcFixflowDao;
import com.repair.plan.dao.JcFlowRecDao;
import com.repair.plan.dao.JtRunKiloRecDao;
import com.repair.plan.dao.MonPlanPriDao;
import com.repair.plan.dao.MonPlanRecorderDao;
import com.repair.plan.dao.WeekPlanPriDao;
import com.repair.plan.dao.WeekPlanRecorderDao;
import com.repair.plan.service.PlanManageService;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.PresetDivisionDao;
import com.repair.work.dao.UsersPrivsDao;
import com.repair.work.dao.WorkDao;

@Repository("planManageService")
public class PlanManageServiceImpl implements PlanManageService {
	private SimpleDateFormat formmat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	@Resource(name = "jtRunKiloRecDao")
	private JtRunKiloRecDao jtRunKiloRecDao;
	@Resource(name = "monPlanPriDao")
	private MonPlanPriDao monPlanPriDao;
	@Resource(name = "monPlanRecorderDao")
	private MonPlanRecorderDao monPlanRecorderDao;
	@Resource(name = "dictJcFixSeqDao")
	private DictJcFixSeqDao dictJcFixSeqDao;
	@Resource(name = "weekPlanPriDao")
	private WeekPlanPriDao weekPlanPriDao;
	@Resource(name = "weekPlanRecorderDao")
	private WeekPlanRecorderDao weekPlanRecorderDao;
	@Resource(name = "datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	@Resource(name= "usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	@Resource(name = "jcFixflowDao")
	private JcFixflowDao jcFixflowDao;
	@Resource(name = "jtPreDictDao")
	private JtPreDictDao jtPreDictDao;
	@Resource(name = "jcFlowRecDao")
	private JcFlowRecDao jcFlowRecDao;
	@Resource(name = "dictProTeamDao")
	private DictProTeamDao dictProTeamDao;
	@Resource(name = "presetDivisionDao")
	private PresetDivisionDao presetDivisionDao;
	@Resource(name = "workDao")
	private WorkDao workDao;
	

	@Override
	public List<JtRunKiloRec> findJtRunKiloRecs() {
		return jtRunKiloRecDao.findJtRunKiloRec();
	}

	@Override
	public List<MonPlanPri> findMonDatePriByImplement() {
		return monPlanPriDao.findMonDatePri();
	}

	@Override
	public void saveMonPlanPri(MonPlanPri monPlanPri) {
		monPlanPriDao.saveOrUpdate(monPlanPri);
	}

	@Override
	public void deleteMonPlanPri(Integer monPlanId) {
		monPlanPriDao.deleteMonPlanPri(monPlanId);
	}

	@Override
	public void deleteMonPlanPri(MonPlanPri monPlanPri) {
		monPlanPriDao.deleteMonPlanPri(monPlanPri);
	}

	@Override
	public MonPlanPri findMonPlanPriById(Integer monPlanId) {
		return monPlanPriDao.findMonDatePriById(monPlanId);
	}

	@Override
	public List<MonPlanRecorder> findMonPlanRecorders(Integer monPlanId) {
		return monPlanRecorderDao.findMonPlanRecorders(monPlanId);
	}

	@Override
	public Integer saveMonPlanRecorder(Integer monPlanId, Long[] runIds) {
		MonPlanPri monPlanPri = monPlanPriDao.findMonDatePriById(monPlanId);
		if (monPlanPri.getStatus()==0) {
				for (int i = 0, len = runIds.length; i < len; i++) {
					MonPlanRecorder planRecorder = new MonPlanRecorder();
					JtRunKiloRec jtRunKiloRec = jtRunKiloRecDao.findJtRunKiloRecById(runIds[i]);
					planRecorder.setJwdCode(jtRunKiloRec.getJwdCode());
					planRecorder.setJcType(jtRunKiloRec.getJcType());
					planRecorder.setJcNum(jtRunKiloRec.getJcNum());
					String runKilo = null;
					if (!isEmpty(jtRunKiloRec.getLarRunKilo())) {
						runKilo = jtRunKiloRec.getLarRunKilo();
					} else if (!isEmpty(jtRunKiloRec.getMidRunKilo())) {
						runKilo = jtRunKiloRec.getMidRunKilo();
					} else if (!isEmpty(jtRunKiloRec.getSmaRunKilo())) {
						runKilo = jtRunKiloRec.getSmaRunKilo();
					} else {
						runKilo = jtRunKiloRec.getMinorRunKilo();
					}
					planRecorder.setRunKilo(runKilo!=null?Integer.parseInt(runKilo):0);
					planRecorder.setTotalRunKilo(!isEmpty(jtRunKiloRec.getTotalRunKilo())?Integer.parseInt(jtRunKiloRec.getTotalRunKilo()):0);
					planRecorder.setPlanStatus((short) 0);
					planRecorder.setMonPlanId(monPlanPri);
					
					monPlanRecorderDao.saveOrUpdate(planRecorder);
				}
				return 1;
		} else {
			return 0;
		}
	}
	
	public void saveOrUpdateMonPlanRecorder(MonPlanRecorder monPlanRecorder) {
		monPlanRecorderDao.saveOrUpdate(monPlanRecorder);
	}

	@Override
	public MonPlanRecorder findMonPlanRecorderById(Long monPrecId) {
		return monPlanRecorderDao.findMonPlanRecorderById(monPrecId);
	}

	@Override
	public void deleteMonPlanRecorder(MonPlanRecorder planRecorder) {
		monPlanRecorderDao.deleteMonPlanRecorder(planRecorder);
	}

	@Override
	public JtRunKiloRec findJtRunKiloRecById(Long runKiloRecId) {
		return jtRunKiloRecDao.findJtRunKiloRecById(runKiloRecId);
	}

	@Override
	public List<DictJcFixSeq> findDictJcFixSeqs() {
		return dictJcFixSeqDao.findDictJcFixSeqs();
	}

	@Override
	public void submitAuditMonPlanPri(Integer monPlanId) {
		monPlanPriDao.updateStatus(monPlanId, (short)1);
		monPlanRecorderDao.updateMonPlanRecorderByMonPlan(monPlanId, (short)0, (short)1);
	}

	@Override
	public void officialIssueMonPlanPri(Integer monPlanId) {
		monPlanPriDao.updateStatus(monPlanId, (short)3);
		monPlanRecorderDao.updateMonPlanRecorderByMonPlan(monPlanId, (short)2, (short)3);
	}

	@Override
	public void auditPassMonPlanPri(Integer monPlanId) {
		monPlanPriDao.updateStatus(monPlanId, (short)2);
		monPlanRecorderDao.updateMonPlanRecorderByMonPlan(monPlanId, (short)1, (short)2);
	}

	@Override
	public List<MonPlanPri> findMonPlanPriByStatus(Short status) {
		return monPlanPriDao.findMonDatePri(status);
	}

	@Override
	public void updateMonPlanRecorderStatus(Long[] monPrecIds, Short status) {
		monPlanRecorderDao.updateMonPlanRecorderStatusByIds(monPrecIds, status);
	}

	@Override
	public List<WeekPlanPri> findWeekPlanPriByImplement() {
		return weekPlanPriDao.findWeekPlanPriByImplement();
	}
	

	@Override
	public WeekPlanPri findWeekPlanPriById(Integer weekPriId) {
		return weekPlanPriDao.findWeekPlanPriById(weekPriId);
	}

	@Override
	public List<WeekPlanRecorder> findWeekPlanRecorderByWeekPlan(Integer weekPriId) {
		return weekPlanRecorderDao.findWeekPlanRecorderByWeekPlan(weekPriId);
	}

	@Override
	public WeekPlanRecorder findWeekPlanRecorderById(Long wekPrecId) {
		return weekPlanRecorderDao.findWeekPlanPriById(wekPrecId);
	}

	@Override
	public void deleteWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder) {
		weekPlanRecorderDao.deleteWeekPlanRecorder(weekPlanRecorder);
	}

	@Override
	public void saveWeekPlanPri(WeekPlanPri weekPlanPri) {
		weekPlanPriDao.saveOrUpdate(weekPlanPri);
	}
	
	public void deleteWeekPlanPri(WeekPlanPri weekPlanPri) {
		weekPlanPriDao.delete(weekPlanPri);
	}

	@Override
	public void saveWeekPlanRecorder(Long[] wekPrecIds, WeekPlanPri weekPlanPri) {
		for (int i = 0, len = wekPrecIds.length; i < len; i++) {
			WeekPlanRecorder planRecorder = new WeekPlanRecorder();
			MonPlanRecorder monPlanRecorder = monPlanRecorderDao.findMonPlanRecorderById(wekPrecIds[i]);
			planRecorder.setWekPriId(weekPlanPri);
			planRecorder.setJcType(monPlanRecorder.getJcType());
			planRecorder.setJcNum(monPlanRecorder.getJcNum());
			planRecorder.setPlanFixDate(monPlanRecorder.getPlanFixDate());
			planRecorder.setBefFixDate(monPlanRecorder.getBefFixDate());
			planRecorder.setFixFreque(monPlanRecorder.getFixFreque());
			planRecorder.setRunKilo(monPlanRecorder.getRunKilo());
			planRecorder.setTotalRunKilo(monPlanRecorder.getTotalRunKilo());
			planRecorder.setGuessRunKilo(monPlanRecorder.getGuessRunKilo());
			planRecorder.setPlanStatus((short)0);
			weekPlanRecorderDao.saveOrUpdate(planRecorder);
		}
		
	}

	@Override
	public void officialIssueWeekPlanPri(Integer weekPriId) {
		weekPlanPriDao.updateStatus(weekPriId, (short)1);
		weekPlanRecorderDao.updateWeekPlanRecorderByWeekPlan(weekPriId, (short)1);
	}

	@Override
	public List<DatePlanPri> findInRepairDailyPlan() {
		return datePlanPriDao.findDatePlanPriByInRepair();
	}
	
	public List<UsersPrivs> findUsersPrivsByRoleName(String roleName) {
		return usersPrivsDao.getUsersPrivsByRoleName(roleName);
	}

	@Override
	public UsersPrivs findUsersPrivsById(Long userId) {
		return usersPrivsDao.getUsersPrivsById(userId);
	}

	@Override
	public List<WeekPlanRecorder> findWeekPlanRecordersByStatus(Short status) {
		return weekPlanRecorderDao.findWeekPlanRecordersByStatus(status);
	}

	@Override
	public Integer saveDailyPlan(DatePlanPri datePlan) {
		JCFixflow fixflow = jcFixflowDao.findJcFixFlowFirstByRepairs(datePlan.getFixFreque(), datePlan.getJcType());
		if (null != fixflow) {
			datePlan.setNodeid(fixflow);
			datePlanPriDao.saveOrUpdate(datePlan);
			// 更新周计划检修机车状态为：实施
			weekPlanRecorderDao.updateStatusByTrain(datePlan.getJcType(), datePlan.getJcnum(), datePlan.getFixFreque(), (short)4);
			return 2;
		} else {
			return 1;
		}
	}
	
	public void updateStatusByDatePlan(Long detailId,DatePlanPri datePlan){
		MainPlanDetail mpd = weekPlanRecorderDao.findTimeByDatePlan(detailId);
		//更新计划明细表状态
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if(mpd.getPlanTime().equals(format.format(new Date()))){
			weekPlanRecorderDao.updateStatusByDatePlan(detailId,1,datePlan);
		}else{
			weekPlanRecorderDao.updateStatusByDatePlan(detailId,2,datePlan);
		}
	}

	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return datePlanPriDao.findDatePlanPriById(rjhmId);
	}

	@Override
	public Integer updateDailyPlan(DatePlanPri datePlanPri) {
		if (datePlanPri.getPlanStatue() == 0) {
			return 0;
		} else {
			DatePlanPri datePlanPriOld = datePlanPriDao.findDatePlanPriById(datePlanPri.getRjhmId());
			if (datePlanPri.getJcType().equals(datePlanPriOld.getJcType()) && datePlanPri.getJcnum().equals(datePlanPriOld.getJcnum()) && datePlanPri.getFixFreque().equals(datePlanPriOld.getFixFreque())) {
				datePlanPriDao.merge(datePlanPri);
			} else {
				datePlanPriDao.merge(datePlanPri);
				weekPlanRecorderDao.updateStatusByTrain(datePlanPriOld.getJcType(), datePlanPriOld.getJcnum(), datePlanPriOld.getFixFreque(), (short)1);
			}
			return 1;
		}
	}

	@Override
	public Integer deleteDailyPlan(Integer rjhmId) {
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
		if (datePlanPri.getPlanStatue() == 0) {
			return 0;
		} else {
			datePlanPriDao.delete(datePlanPri);
			return 1;
		}
	}
	
	public void saveOrUpdateDatePlanPri(DatePlanPri datePlanPri){
		datePlanPriDao.saveOrUpdate(datePlanPri);
	}
	
	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId) {
		return jtPreDictDao.findJtPreDictByDatePlan(rjhmId, (short)3);
	}

	@Override
	public void saveJtPreDict(JtPreDict preDict) {
		jtPreDictDao.saveOrUpdate(preDict);
	}

	@Override
	public void deleteJtPreDict(Integer[] preDictIds) {
		jtPreDictDao.delete(preDictIds);
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByStatus(Integer status) {
		return datePlanPriDao.findDatePlanPriByStatus(status);
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDict(Long proteamid) {
		return datePlanPriDao.findDatePlanPriByJtPreDict(proteamid);
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDict(Long proteamid,
			Short status) {
		return datePlanPriDao.findDatePlanPriByJtPreDict(proteamid,status);
	}

	@Override
	public List<DatePlanPri> findDatePlanPriByJtPreDictSign(Long userid,Integer roleType) {
		return datePlanPriDao.findDatePlanPriByJtPreDictSign(userid,roleType);
	}

	@Override
	/**
	 * 工长强制完成
	 */
	public String updateForcFinishJCFlow(Integer rjhmId,Long bzId,Integer nodeId){
		JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, bzId, nodeId);
		flowRec.setFinishStatus(1);
		flowRec.setFinishTime(new Date());
		jcFlowRecDao.saveOrUpdate(flowRec);
		long count = jcFlowRecDao.countUnfinishRec(rjhmId, nodeId);
		if(count==0){
			DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
			JCFixflow fixflow = new JCFixflow();
			fixflow.setJcFlowId(Contains.XX_SY_NODEID);
			datePlanPri.setNodeid(fixflow);
			datePlanPriDao.saveOrUpdate(datePlanPri);
		}
		return null;
	}

	@Override
	public boolean exitWeekPlanRe(Long[] wekPrecIds, WeekPlanPri weekPlanPri) {
		//根据周计划查找检修机车
		ArrayList<WeekPlanRecorder> weekPlanRecorderList = (ArrayList<WeekPlanRecorder>) weekPlanRecorderDao.findWeekPlanRecorderByWeekPlan(weekPlanPri.getWeekPriId());;
		for (int i = 0, len = wekPrecIds.length; i < len; i++) {
			// 根据ID查找月计划检修机车记录实体
			MonPlanRecorder monPlanRecorder = monPlanRecorderDao.findMonPlanRecorderById(wekPrecIds[i]);
			for (WeekPlanRecorder weekPlanRecorder : weekPlanRecorderList) {
				if(weekPlanRecorder.getJcNum().equals(monPlanRecorder.getJcNum()) && weekPlanRecorder.getJcType().equals(monPlanRecorder.getJcType())){
					return true;
				}
			}
		}
		
		return false;
	}

	@Override
	public void saveOrUpdateWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder) {
		weekPlanRecorderDao.saveOrUpdate(weekPlanRecorder);
	}
	
	@Override
	public Integer nodeToReverse(int rjhmId, Long userId, int noteId) {
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
		JCFixflow fixflow=new JCFixflow();
		fixflow.setJcFlowId(noteId);
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
				jcFlowRecDao.saveJcFixRec(datePlanPri, noteId);
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
	public List listJGPlan(String jgContent, String jcType) {
		return jtRunKiloRecDao.listJGPlan(jgContent, jcType);
	}
	
	@Override
	public DatePlanPri dailyIsExist(String jcType, String jcNum, String fixFreque) {
		return datePlanPriDao.dailyIsExist(jcType, jcNum, fixFreque);
	}

	@Override
	public List<MonPlanPri> queryMonPlanPri() {
		return monPlanPriDao.queryMonPlanPri();
	}

	@Override
	public PageModel<MonPlanRecorder> queryMonPlanRecorders(Integer monPlanId) {
		return monPlanRecorderDao.queryMonPlanRecorders(monPlanId);
	}

	@Override
	public List<WeekPlanRecorder> queryWeekPlanRecorder(Integer monPlanId, Short planType) {
		return weekPlanRecorderDao.queryWeekPlanRecorder(monPlanId, planType);
	}

	@Override
	public List<DictJcStype> findDictJcStype() {
		
		return jtRunKiloRecDao.findDictJcStype();
	}

	@Override
	public List listJGPlanContent() {
		return jtRunKiloRecDao.listJGPlanContent();
	}
	
	@Override
	public List<String> findJcTypes() {
		return jtRunKiloRecDao.findJcTypes();
	}

	@Override
	public List<String> findJgItems() {
		return jtRunKiloRecDao.findJgItems();
	}

	@Override
	public void saveJgItem(JGPlanContent jPlan) {
		jtRunKiloRecDao.saveJgItem(jPlan);
	}

	@Override
	public void saveItemDatePlan(DatePlanPri datePlanPri) {
		jtRunKiloRecDao.saveItemDatePlan(datePlanPri);
	}

	@Override
	public void saveItemJtPreDict(JtPreDict jtPreDict) {
		jtRunKiloRecDao.saveItemJtPreDict(jtPreDict);
	}
	
	@Override
	public List editeJGPlanContent() {
		return jtRunKiloRecDao.editeJGPlanContent();
	}

	@Override
	public List<JGPlanContent> findJgByitem(String content) {
		return jtRunKiloRecDao.findJgByitem(content);
	}

	@Override
	public String deleteJGPlanContent(JGPlanContent content) {
		return jtRunKiloRecDao.deleteJGPlanContent(content);
	}

	@Override
	public String updateJgItem(JGPlanContent jPlan) {
		return jtRunKiloRecDao.updateJgItem(jPlan);
	}

	@Override
	public List findJcAcounts() {
		return jtRunKiloRecDao.findJcAcounts();
	}

	@Override
	public Map<String, List<Map<String, String>>> findJcItemAcount() {
		List acounts = jtRunKiloRecDao.findJcItemAcount();
		Map<String, List<Map<String, String>>> map = new LinkedHashMap<String, List<Map<String, String>>>();
		Object[] array = null;
		String item = null;
		Map<String, String> temp = null;
		for (int i = 0; i < acounts.size(); i++) {
			array = (Object[]) acounts.get(i);
			item = (String) array[0];
			if (map.get(item) == null) {
				map.put(item, new ArrayList<Map<String, String>>());
			}
			temp = new LinkedHashMap<String, String>();
			temp.put("jctype", array[1]+"");
			temp.put("planNum", array[2]+"");
			temp.put("sjNum", array[3]+"");
			temp.put("jgid", array[4]+"");
			map.get(item).add(temp);
		}
		return map;
	}

	@Override
	public List findJcItemList(String itemName, String jctype) {
			return jtRunKiloRecDao.findJcItemList(itemName, jctype);
	}
	
	@Override
	public String updateJgItemById(JGPlanContent jPlan) {
		return jtRunKiloRecDao.updateJgItemById(jPlan);
	}
	
	@Override
	public void savePlan(MainPlan mainPlan, List<MainPlanDetail> list) {
		datePlanPriDao.saveOrUpdateMainPlan(mainPlan);
		for(MainPlanDetail mainPlanDetail:list){
			mainPlanDetail.setMainPlanId(mainPlan);
			datePlanPriDao.saveOrUpdateMainPlanDetail(mainPlanDetail);
		}
	}

	@Override
	public List<MainPlanDetail> findMainPlanDetail(String startTime,String endTime) {
		return datePlanPriDao.findMainPlanDetail(startTime,endTime);
	}

	@Override
	public MainPlan findMainPlanById(Long Id) {
		return datePlanPriDao.findMainPlanById(Id);
	}

	@Override
	public List<MainPlanDetail> findMainPlanDetailByMainId(Long mainPlanId) {
		return datePlanPriDao.findMainPlanDetailByMainId(mainPlanId);
	}

	@Override
	public void saveOrUpdateMainPlan(MainPlan mainPlan) {
		datePlanPriDao.saveOrUpdateMainPlan(mainPlan);
	}

	@Override
	public void delPlan(String mainPlanId, String mainPlanDetailId) {
		Long tempId=null;
		if(mainPlanId!=null&&!"".equals(mainPlanId)){
			tempId=Long.parseLong(mainPlanId);
			datePlanPriDao.delMainPlanDetailById(tempId, null);
			datePlanPriDao.delMainPlanById(tempId);
		}else if(mainPlanDetailId!=null&&!"".equals(mainPlanDetailId)){
			tempId=Long.parseLong(mainPlanDetailId);
			datePlanPriDao.delMainPlanDetailById(null, tempId);
		}
	}
	
	public List<MainPlan> findMainPlanList(){
		return datePlanPriDao.findMainPlanList();
	}

	@Override
	public PageModel<MainPlan> findMainPlanList(String startTime, String endTime) {
		return datePlanPriDao.findMainPlanList(startTime, endTime);
	}
	
	public MainPlanDetail findMainPlanDetailById(Long id){
		return datePlanPriDao.findMainPlanDetailById(id);
	}
	
	public void saveOrUpdateMainPlanDetail(MainPlanDetail mainPlanDetail){
		datePlanPriDao.saveOrUpdateMainPlanDetail(mainPlanDetail);
	}

	@Override
	public List<MainPlan> findMainPlanByTime(String startTime, String endTime) {
		return datePlanPriDao.findMainPlanByTime(startTime, endTime);
	}

	@Override
	public long findJGPlanContent(String item) {
		return jtRunKiloRecDao.findJGPlanContent(item);
	}
	
	@Override
	public void updateMainPlanDetial(Long id, String inputName, String inputVal) {
		datePlanPriDao.updateMainPlanDetial(id, inputName, inputVal);
	}	
	@Override
	public List<MainPlanDetail> findMainPlanDetailByStatusAndTime() {
		return weekPlanRecorderDao.findMainPlanDetailByStatusAndTime();
	}

	@Override
	public void updateStatusBydeleteDatePlan(Integer rjhmid) {
		weekPlanRecorderDao.updateStatusBydeleteDatePlan(rjhmid);
	}
}
