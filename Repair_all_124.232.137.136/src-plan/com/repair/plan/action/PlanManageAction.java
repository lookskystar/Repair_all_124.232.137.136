package com.repair.plan.action;

import static com.repair.common.util.WebUtil.compare;
import static com.repair.common.util.WebUtil.dateConvertString;
import static com.repair.common.util.WebUtil.getSessionUsersPrivs;
import static com.repair.common.util.WebUtil.isEmpty;
import static com.repair.common.util.WebUtil.isUser;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JGPlanContent;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.MonPlanPri;
import com.repair.common.pojo.MonPlanRecorder;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.WeekPlanPri;
import com.repair.common.pojo.WeekPlanRecorder;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.plan.service.PlanManageService;
import com.repair.plan.vo.Dispatch;
import com.repair.work.service.JtPreDictService;

/**
 * 计划管理控制
 * @author zx
 *
 */
public class PlanManageAction extends BaseAction{

	private static final long serialVersionUID = -8573321842630913484L;
	// 计划管理服务
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	// 交车工长管理服务
	@Resource(name = "pdiFroemanManageService")
	private PdiFroemanManageService pdiFroemanManageService;
	@Resource(name = "jtPreDictService")
	private JtPreDictService jtPreDictService;
	@Resource(name="userRolesService")
	private UserRolesService userRolesService;
	
	// 月计划
	private MonPlanPri monPlan;
	private MonPlanRecorder monPlanRecorder;
	private WeekPlanRecorder weekPlanRecorder;
	private MainPlanDetail mainPlanDetail;
	
	// 周计划
	private WeekPlanPri weekPlan;
	
	// 日计划
	private DatePlanPri datePlan;
	
	// 报活项目
	private JtPreDict preDict;
	
	private Dispatch dispatch;
	
	private String id;
	private String trains;
	private String type;
	private String otherId;
	//加改内容
	private String jgContent;
	//车型
	private String jcType;
	
	
	/**
	 * 月计划制定
	 * @return
	 */
	public String monthPlanMake() {
		// 走行机车
		List<JtRunKiloRec> runKiloRecs = planManageService.findJtRunKiloRecs();
		request.put("runKiloRecs", runKiloRecs);
		// 月计划(完成与作废除外)
		List<MonPlanPri> monPlanPris = planManageService.findMonDatePriByImplement();
		request.put("monPlanPris", monPlanPris);
		
		if (!isEmpty(id)) {
			// 月计划下的检修机车记录
			List<MonPlanRecorder> planRecorders = planManageService.findMonPlanRecorders(Integer.parseInt(id));
			request.put("planRecorders", planRecorders);
		}
		return "monthplanmake";
	}
	
	
	/**
	 * 月计划制定输入
	 * @return
	 */
	public String monthPlanMakeInput() {
		return "monthplanmakeinput";
	}
	
	/**
	 * 保存月计划确认
	 * @return
	 */
	public String addMonPlanPriConfirm() {
		if (null != monPlan && isUser()) {
			monPlan.setFmtPeople(getSessionUsersPrivs());
			monPlan.setFmtDate(dateConvertString(new Date()));
			monPlan.setStatus((short)0);
			monPlan.setProjectType(Contains.XX_PROJECT_TYPE);
			planManageService.saveMonPlanPri(monPlan);
			request.put("message", "月计划制定成功！");
		} else {
			request.put("message", "月计划制定失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 删除月计划
	 * @return
	 */
	public String deleteMonPlanPriConfirm() {
		if (!isEmpty(id) && isUser()) {
			MonPlanPri monPlanPri = planManageService.findMonPlanPriById(Integer.parseInt(id));
			if (monPlanPri.getStatus()==0) {
				planManageService.deleteMonPlanPri(Integer.parseInt(id));
				request.put("message", "月计划删除成功！");
			} else {
				request.put("message", "月计划删除失败，已经不为预编制状态！");
			}
		} else {
			request.put("message", "月计划删除失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 提交审核月计划
	 * @return
	 */
	public String submitAuditMonPlanPri() {
		if (!isEmpty(id) && isUser()) {
			MonPlanPri monPlanPri = planManageService.findMonPlanPriById(Integer.parseInt(id));
			if (monPlanPri.getStatus() == 0) {
				planManageService.submitAuditMonPlanPri(Integer.parseInt(id));
				id = null;
				request.put("message", "月计划提交审核成功！");
			} else {
				request.put("message", "月计划已不是预编制状态，不能进行提交审核！");
			}
		} else {
			request.put("message", "月计划提交审核失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 正式发布月计划
	 * @return
	 */
	public String officialIssueMonPlanPri() {
		if (!isEmpty(id) && isUser()) {
			MonPlanPri monPlanPri = planManageService.findMonPlanPriById(Integer.parseInt(id));
			if (monPlanPri.getStatus() == 2) {
				planManageService.officialIssueMonPlanPri(monPlanPri.getMonPlanId());
				id = null;
				request.put("message", "月计划正式发布成功！");
			} else {
				request.put("message", "月计划未审核，不能进行发布！");
			}
		} else {
			request.put("message", "月计划正式发布失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 月计划添加检修机车
	 * @return
	 */
	public String monPlanAddOverHaulTrain(){
		if (!isEmpty(id) && isUser()) {
			if (!isEmpty(trains)) {
				String[] ids = trains.split(",");
				if (!isEmpty(ids)) {
					Long[] runIds = new Long[ids.length];
					for (int i = 0, len = ids.length; i < len; i++) {
						runIds[i] = Long.parseLong(ids[i]);
					}
					Integer result = planManageService.saveMonPlanRecorder(Integer.parseInt(id), runIds);
					switch (result) {
					case 0:
						request.put("message", "月计划添加检修机车失败，已经不为预编制状态！");
						break;

					default:
						request.put("message", "月计划添加检修机车成功！");
						break;
					}
				}
			} else {
				request.put("message", "月计划添加检修机车失败，请选择机车！");
			}
		} else {
			request.put("message", "月计划添加检修机车失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 月计划检修机车记录修改输入
	 * @return
	 */
	public String modifyMonPlanRecorderInput() {
		if (!isEmpty(id)) {
			request.put("monPlanRecorder", planManageService.findMonPlanRecorderById(Long.parseLong(id)));
		}
		request.put("dictJcFixSeqs", planManageService.findDictJcFixSeqs());
		return "modifymonplanrecorderinput";
	}
	
	/**
	 * 周计划检修机车记录修改输入
	 * @return
	 */
	public String modifyWeekPlanRecorderInput() {
		if (!isEmpty(id)) {
			request.put("weekPlanRecorder", planManageService.findWeekPlanRecorderById(Long.parseLong(id)));
		}
		request.put("dictJcFixSeqs", planManageService.findDictJcFixSeqs());
		return "modifyweekplanrecorderinput";
	}
	
	/**
	 * 月计划检修机车记录修改确认
	 * @return
	 */
	public String modifyMonPlanRecorderConfirm() {
		if (null != monPlanRecorder && isUser()) {
			MonPlanPri monPlanPri = planManageService.findMonPlanPriById(monPlanRecorder.getMonPlanId().getMonPlanId());
			if (monPlanPri.getStatus()==0) {
				planManageService.saveOrUpdateMonPlanRecorder(monPlanRecorder);
				id = monPlanPri.getMonPlanId()+"";
				request.put("message", "月计划机车检修记录修改成功！");
			} else {
				request.put("message", "月计划机车检修记录修改失败，已经不为预编制状态！");
			}
			
		}
		return monthPlanMake();
	}
	
	/**
	 * 周计划检修机车记录修改确认
	 * @return
	 */
	public String modifyWeekPlanRecorderConfirm(){
		if (null != weekPlanRecorder && isUser()) {
			WeekPlanPri weekPlanPri = planManageService.findWeekPlanPriById(weekPlanRecorder.getWekPriId().getWeekPriId());
			planManageService.saveOrUpdateWeekPlanRecorder(weekPlanRecorder);
			otherId = weekPlanPri.getWeekPriId()+"";
			request.put("message", "周计划机车检修记录修改成功！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 月计划检修机车记录删除确认
	 * @return
	 */
	public String deleteMonPlanRecorderConfirm() {
		if (!isEmpty(id) && isUser()) {
			MonPlanRecorder planRecorder = planManageService.findMonPlanRecorderById(Long.parseLong(id));
			if (planRecorder.getMonPlanId().getStatus()==0) {
				planManageService.deleteMonPlanRecorder(planRecorder);
				request.put("message", "月计划检修机车记录删除成功！");
			} else {
				request.put("message", "月计划检修机车记录删除失败，已经不为预编制状态！");
			}
			id = planRecorder.getMonPlanId().getMonPlanId()+"";
		} else {
			request.put("message", "月计划检修机车记录删除失败（用户登录是否失效）！");
		}
		return monthPlanMake();
	}
	
	/**
	 * 月计划审核
	 * @return
	 */
	public String monthPlanAudit() {
		List<MonPlanPri> monPlanPris = planManageService.findMonPlanPriByStatus((short)1);
		request.put("monPlanPris", monPlanPris);
		if (!isEmpty(id)) {
			// 月计划下的检修机车记录
			List<MonPlanRecorder> planRecorders = planManageService.findMonPlanRecorders(Integer.parseInt(id));
			request.put("planRecorders", planRecorders);
		}
		return "monthplanaudit";
	}
	
	/**
	 * 月计划审核操作
	 * @return
	 */
	public String monthPlanAuditOperate() {
		if (!isEmpty(trains)&&!isEmpty(id)) {
			String[] strs = trains.split(",");
			Long[] ids = null;
			if (!isEmpty(strs)) {
				ids = new Long[strs.length];
				for (int i = 0, len = strs.length; i < len; i++) {
					ids[i] = Long.parseLong(strs[i]);
				}
				
			}
			if (!isEmpty(type) && "1".equals(type)) {
				if (null != ids && ids.length > 0) {
					planManageService.updateMonPlanRecorderStatus(ids, (short)2);
					request.put("message", "月计划检修记录审核成功！");
				}
			} else {
				if (null != ids && ids.length > 0) {
					planManageService.updateMonPlanRecorderStatus(ids, (short)-1);
					request.put("message", "月计划检修记录作废成功！");
				}
			}
		}
		
		if (!isEmpty(id)&&isEmpty(trains)) {
			planManageService.auditPassMonPlanPri(Integer.parseInt(id));
			id=null;
			request.put("message", "月计划审核成功！");
		}
		return monthPlanAudit();
	}
	
	/**
	 * 周计划制定
	 * @return
	 */
	public String weekPlanMake() {
		List<WeekPlanPri> weekPlanPris = planManageService.findWeekPlanPriByImplement();
		request.put("weekPlanPris", weekPlanPris);
		List<MonPlanRecorder> planRecorders = null;
		List<WeekPlanRecorder> weekPlanRecorders = null;
		
		if (!isEmpty(otherId)) {
			WeekPlanPri weekPlanPri = planManageService.findWeekPlanPriById(Integer.parseInt(otherId));
			weekPlanRecorders = planManageService.findWeekPlanRecorderByWeekPlan(weekPlanPri.getWeekPriId());
			request.put("weekPlanRecorders", weekPlanRecorders);
			id = weekPlanPri.getMonPlanId().getMonPlanId()+"";
		}
		
		// 月计划(完成与作废除外)
		List<MonPlanPri> monPlanPris = planManageService.findMonPlanPriByStatus((short) 3);
		request.put("monPlanPris", monPlanPris);
		
		if (!isEmpty(id)) {
			// 月计划下的检修机车记录
			planRecorders = planManageService.findMonPlanRecorders(Integer.parseInt(id));
			if (null != weekPlanRecorders && !weekPlanRecorders.isEmpty()) {
				if (null != planRecorders && !planRecorders.isEmpty()) {
					for (Iterator<MonPlanRecorder> itr = planRecorders.iterator(); itr.hasNext();) {
						MonPlanRecorder monPlanRecorder = itr.next();
						for (WeekPlanRecorder weekPlanRecorder : weekPlanRecorders) {
							if (compare(weekPlanRecorder.getJcType(), monPlanRecorder.getJcType()) && compare(weekPlanRecorder.getJcNum(), monPlanRecorder.getJcNum()) && compare(weekPlanRecorder.getFixFreque(), monPlanRecorder.getFixFreque())) {
								itr.remove();
								break;
							}
						}
					}
				}
			}
			request.put("planRecorders", planRecorders);
		}
		return "weekplanmake";
	}
	
	/**
	 * 制定周计划输入
	 * @return
	 */
	public String weekPlanMakeInput() {
		List<MonPlanPri> monPlanPris = planManageService.findMonPlanPriByStatus((short) 3);
		request.put("monPlanPris", monPlanPris);
		
		if (!isEmpty(id)) {
			MonPlanPri monPlanPri = planManageService.findMonPlanPriById(Integer.parseInt(id));
			request.put("monPlanPri", monPlanPri);
		}
		return "weekplanmakeinput";
	}
	
	/**
	 * 周计划制定确认
	 * @return
	 */
	public String weekPlanMakeConfirm() {
		if (null != weekPlan && isUser()) {
			if (null != weekPlan.getMonPlanId()) {
				weekPlan.setFmtpeo(getSessionUsersPrivs());
				weekPlan.setFmtDate(dateConvertString(new Date()));
				weekPlan.setStatus((short)0);
				weekPlan.setProjectType(Contains.XX_PROJECT_TYPE);
				planManageService.saveWeekPlanPri(weekPlan);
				id = weekPlan.getMonPlanId().getMonPlanId()+"";
				request.put("message", "周计划制定成功！");
			} else {
				request.put("message", "周计划制定失败，没有选择所在的月计划！");
			}
		} else {
			request.put("message", "周计划制定失败（用户登录是否失效）！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 周计划添加检修机车
	 * @return
	 */
	public String weekPlanAddOverHaulTrain() {
		if (!isEmpty(id) && isUser()) {
			WeekPlanPri weekPlanPri = planManageService.findWeekPlanPriById(Integer.parseInt(id));
			//if (weekPlanPri.getStatus()==0) {
				if (!isEmpty(trains)) {
					String[] ids = trains.split(",");
					if (!isEmpty(ids)) {
						Long[] wekPrecIds = new Long[ids.length];
						for (int i = 0, len = ids.length; i < len; i++) {
							wekPrecIds[i] = Long.parseLong(ids[i]);
						}
						//判断当前添加的月计划记录机车是否已存在于周计划记录机车
						if(planManageService.exitWeekPlanRe(wekPrecIds, weekPlanPri)){
							request.put("message", "机车已存在于周计划检修机车列表中！");
						}else{
							planManageService.saveWeekPlanRecorder(wekPrecIds, weekPlanPri);
							otherId = id;
							request.put("message", "周计划检修机车添加成功！");
						}
						
					}
				}
//			} else {
//				request.put("message", "周计划添加检修机车失败，已经不为预编制状态！");
//			}
		} else {
			request.put("message", "周计划添加检修机车失败（用户登录是否失效）！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 正式发布周计划
	 * @return
	 */
	public String officialIssueWeekPlanPri() {
		if (!isEmpty(id) && isUser()) {
			WeekPlanPri weekPlanPri = planManageService.findWeekPlanPriById(Integer.parseInt(id));
			//if (weekPlanPri.getStatus() == 0) {
				planManageService.officialIssueWeekPlanPri(weekPlanPri.getWeekPriId());
				id = null;
				request.put("message", "周计划正式发布成功！");
//			} else {
//				request.put("message", "周计划正式发布失败，已经不为预编制状态！");
//			}
		} else {
			request.put("message", "周计划正式发布失败（用户登录是否失效）！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 删除周计划机车检修记录
	 * @return
	 */
	public String deleteWeekPlanConfirm() {
		if (!isEmpty(id) && isUser()) {
			WeekPlanPri weekPlanPri = planManageService.findWeekPlanPriById(Integer.parseInt(id));
			//if (weekPlanPri.getStatus()==0) {
				planManageService.deleteWeekPlanPri(weekPlanPri);
				request.put("message", "周计划删除成功！");
//			} else {
//				request.put("message", "周计划删除失败，已经不为预编制状态！");
//			}
		} else {
			request.put("message", "周计划删除失败（用户登录是否失效）！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 周计划检修机车记录删除
	 * @return
	 */
	public String deleteWeekPlanRecorderConfirm() {
		if (!isEmpty(id) && isUser()) {
			WeekPlanRecorder weekPlanRecorder = planManageService.findWeekPlanRecorderById(Long.parseLong(id));
			//if (weekPlanRecorder.getPlanStatus()==0) {
				planManageService.deleteWeekPlanRecorder(weekPlanRecorder);
				request.put("message", "周计划检修机车记录删除成功！");
//			} else {
//				request.put("message", "周计划检修机车记录删除失败，已经不为预编制状态！");
//			}
			otherId = weekPlanRecorder.getWekPriId().getWeekPriId()+"";
		} else {
			request.put("message", "周计划检修机车记录删除失败（用户登录是否失效）！");
		}
		return weekPlanMake();
	}
	
	/**
	 * 日计划制定
	 * @return
	 */
	public String dailyPlanMake() {
		request.put("datePlanPris", planManageService.findInRepairDailyPlan());
		if (!isEmpty(id)) {
			request.put("preDicts", planManageService.findJtPreDictByDatePlan(Integer.parseInt(id)));
		}
		return "dailyplanmake";
	}
	
	/**
	 * 交车工长临修加改日计划制定
	 * @return
	 */
	public String jcgzDailyPlanMake() {
		//request.put("preDicts", planManageService.findJtPreDictByDatePlan(Integer.parseInt(id)));
		if (!isEmpty(id)) {
			List<JtPreDict> dicts =planManageService.findJtPreDictByDatePlan(Integer.parseInt(id));
			List<JtPreDict> smDicts = null;
			String bzNames = "";
			for (JtPreDict jtPreDict : dicts) {
				if(jtPreDict.getProTeamId()!=null){
					bzNames = pdiFroemanManageService.findDictProTeamById(jtPreDict.getProTeamId().getProteamid()).getProteamname()+",";
					smDicts = jtPreDictService.findSmJtPreDicts(jtPreDict.getPreDictId());
					for (JtPreDict temp : smDicts) {
						bzNames += pdiFroemanManageService.findDictProTeamById(temp.getProTeamId().getProteamid()).getProteamname()+",";
					}
					jtPreDict.setSmBzNames(bzNames);
				}
			}
			request.put("preDicts", dicts);
		}
		return "jcgz_dailyplanmake";
	}
	
	/**
	 * 交车工长添加检修内容输入
	 * @return
	 */
	public String jcgzAddOverhaulContentInput() {
			DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.parseInt(id));
			request.put("datePlanPri", datePlanPri);
			return "jcgz_addoverhaulcontentinput";
	}
	
	/**
	 * 交车工长检修内容确认
	 * @return
	 */
	public String jcgzAddOverhaulContentConfirm() {
		if (!isEmpty(id) && isUser()) {
			if (null != preDict) {
				DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.parseInt(id));
				preDict.setDatePlanPri(datePlanPri);
				preDict.setType((short)3);
				preDict.setRecStas((short)0);
				planManageService.saveJtPreDict(preDict);
				request.put("message", "检修内容添加成功！");
			}
		} else {
			request.put("message", "添加检修内容失败（用户登录是否失效）！");
		}
		return jcgzDailyPlanMake();
	}
	
	/**
	 * 删除交车工长日计划检修项目
	 * @return
	 */
	public String deleteJcgzOverhaulContentConfirm() {
		if (!isEmpty(id) && isUser()) {
			if (!isEmpty(trains)) {
				String[] strs = trains.split(",");
				if (!isEmpty(strs)) {
					Integer[] ids = new Integer[strs.length];
					for (int i = 0, len = strs.length; i < len; i++) {
						ids[i] = Integer.parseInt(strs[i]);
					}
					planManageService.deleteJtPreDict(ids);
					request.put("message", "检修内容删除成功！");
				}
			}
		} else {
			request.put("message", "删除检修内容失败（用户登录是否失效）！");
		}
		return jcgzDailyPlanMake();
	}
	
	/**
	 * 交车工长派工确认
	 * @return
	 */
	public String dispatchingConfirm() {
		String ids=ServletActionContext.getRequest().getParameter("ids");
		if(!isEmpty(ids) && isUser()){
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			if (!isEmpty(ids) && null != dispatch) {
				List<Integer> preIds = new ArrayList<Integer>();
				String[] temp = ids.split(",");
				for (int i = 0; i < temp.length; i++) {
					preIds.add(Integer.parseInt(temp[i]));
				}
				pdiFroemanManageService.updateDispatching(preIds, dispatch, usersPrivs,1);//1为交车组判别字段
				request.put("message", "检修内容派工成功！");
			}
		}else{
			request.put("message", "检修内容操作失败（用户登录是否失效）！");
		}
		return jcgzDailyPlanMake();
	}
	
	
	/**
	 * 添加日计划输入
	 * @return
	 */
	public String addDailyPlanInput() {
		List<UsersPrivs> users = planManageService.findUsersPrivsByRoleName(Contains.ROLE_NAME_JCGZ);
		//查询小辅修班组
		List<DictProTeam> proteams=userRolesService.listXXDictProTeam();
		String gdh = ServletActionContext.getRequest().getParameter("gdh");
		String twh = ServletActionContext.getRequest().getParameter("twh");
		if(gdh!=null && twh!=null && !"".equals(gdh) && !"".equals(twh)){
			request.put("gdh", gdh.trim());
			request.put("twh", twh.trim());
		}
		request.put("users", users);
		request.put("proteams", proteams);
		return "adddailyplaninput";
	}
	
	public String addDailyPlanOfBatchInput() {
		List<UsersPrivs> users = planManageService.findUsersPrivsByRoleName(Contains.ROLE_NAME_JCGZ);
		request.put("users", users);
		return "adddailyplanofbatchinput";
	}
	
	/**
	 * 日计划扣车从周计划从查找
	 * @return
	 */
	public String findJcCurriculumByWeekPlan() {
		request.put("weekPlanRecorders", planManageService.findWeekPlanRecordersByStatus((short)1));
		return "findjccurriculumbyweekplan";
	}
	
	/**
	 * 日计划扣车确认
	 * @return
	 */
	public String addDatePlanPriConfirm() {
		if (null != datePlan && isUser()) {
			datePlan.setPlanStatue(-1);
			UsersPrivs user = getSessionUsersPrivs();
			datePlan.setZdr(user.getXm());
			//datePlan.setKcsj(dateConvertString(new Date()));
			datePlan.setZdsj(dateConvertString(new Date()));
			String xcxc = datePlan.getFixFreque().toUpperCase();
			if (xcxc.startsWith("Z") && !xcxc.contains("ZQZZ")&& !xcxc.contains("ZZ")) {
				datePlan.setProjectType(Contains.ZX_PROJECT_TYPE);//设置计划为中修
			} else {
				datePlan.setProjectType(Contains.XX_PROJECT_TYPE);//设置计划为小辅修
			}
			if (!isEmpty(id)) {
				datePlan.setGongZhang(planManageService.findUsersPrivsById((Long.parseLong(id))));
			}
			if (!isEmpty(datePlan.getFixFreque()) && !isEmpty(datePlan.getJcType())) {
				//操作计划是否兑现
				HttpServletRequest req=ServletActionContext.getRequest();
				String mainPlanDetailid=req.getParameter("mainPlanDetailid");
				Integer result = planManageService.saveDailyPlan(datePlan);
				if(mainPlanDetailid!=null&&!"".equals(mainPlanDetailid)){
					Long detailId=Long.parseLong(mainPlanDetailid);
					//判断是否为日计划，更新状态为1
					//else状态为2
					planManageService.updateStatusByDatePlan(detailId,datePlan);
				}
				switch (result) {
				case 1:
					request.put("message", "日计划扣车失败，无法找到该修程修次的流程节点！");
					break;
				
				default:
					if (datePlan.getFixFreque().equals(Contains.PY_LX) || datePlan.getFixFreque().equals(Contains.PY_JG)|| datePlan.getFixFreque().equals(Contains.PY_ZZ)) {
						request.put("message", "日计划扣车成功，请填写计划检修内容！");
					} else {
						request.put("message", "日计划扣车成功！");
						
					}
					break;
				}
			}
		} else {
			request.put("message", "日计划扣车失败（用户登录是否失效）！");
		}
		return "jcgz_main_map";	
	}
	
	/**
	 * 日计划批量扣车确认
	 * @return
	 * @throws JSONException 
	 * @throws IOException 
	 */
	@SuppressWarnings("unchecked")
	public void addDatePlanPriOfBatchConfirm() throws JSONException, IOException {
		String message = "success";
		String dailyString = ServletActionContext.getRequest().getParameter("dailyString");
		JSONObject dailyStrObj = new JSONObject(dailyString);
		JSONArray dailyStrAray = null;
		JSONObject obj = null;
		DatePlanPri datePlan = null;
		try {
			for (Iterator iterator = dailyStrObj.keys(); iterator.hasNext();) {	
				String iterKey = (String) iterator.next();
				dailyStrAray = dailyStrObj.getJSONArray(iterKey);
				for (int i = 0; i < dailyStrAray.length(); i++) {
					datePlan = new DatePlanPri();
					obj = dailyStrAray.getJSONObject(i);
					String mainPlanDetailid = obj.getString("mainPlanDetailid");
					datePlan.setJcType(obj.getString("jcType"));
					datePlan.setJcnum(obj.getString("jcNum"));
					datePlan.setFixFreque(obj.getString("fixFreque"));
					datePlan.setGdh(obj.getString("gdh"));
					datePlan.setTwh(obj.getString("twh"));
					datePlan.setKcsj(obj.getString("kcsj"));
					datePlan.setJhqjsj(obj.getString("jhqjsj"));
					datePlan.setJhjcsj(obj.getString("jhjcsj"));
					datePlan.setComments(obj.getString("comment"));
					datePlan.setGongZhang(
							(obj.getString("jcgz") == null || obj.getString("jcgz").equals(""))? null:userRolesService.getUsersPrivsById(Long.parseLong(obj.getString("jcgz"))) );
					if (isUser()) {
						datePlan.setPlanStatue(-1);
						UsersPrivs user = getSessionUsersPrivs();
						datePlan.setZdr(user.getXm());
						datePlan.setZdsj(dateConvertString(new Date()));
						String xcxc = datePlan.getFixFreque().toUpperCase();
						if (xcxc.startsWith("Z") && !xcxc.contains("ZQZZ")&& !xcxc.contains("ZZ")) {
							datePlan.setProjectType(Contains.ZX_PROJECT_TYPE);//设置计划为中修
						} else {
							datePlan.setProjectType(Contains.XX_PROJECT_TYPE);//设置计划为小辅修
						}
						if (!isEmpty(id)) {
							datePlan.setGongZhang(planManageService.findUsersPrivsById((Long.parseLong(id))));
						}
						if (!isEmpty(datePlan.getFixFreque()) && !isEmpty(datePlan.getJcType())) {
							Integer	result = planManageService.saveDailyPlan(datePlan);
						if(mainPlanDetailid!=null&&!"".equals(mainPlanDetailid)){
							Long detailId=Long.parseLong(mainPlanDetailid);
								//判断是否为日计划，更新状态为1
								//else状态为2
							planManageService.updateStatusByDatePlan(detailId,datePlan);
						}
							switch (result) {
							case 1:
								message = "nonodeid";
								break;
							default:
								if (datePlan.getFixFreque().equals(Contains.PY_LX) || datePlan.getFixFreque().equals(Contains.PY_JG)|| datePlan.getFixFreque().equals(Contains.PY_ZZ)) {
									message = "put";
								}
								break;
							}
						}
					} else {
						message = "failure";
						break;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = "failure";
		} finally {
			ServletActionContext.getResponse().getWriter().write(message);
		}
	}
	
	/**
	 * 日计划修改输入
	 * @return
	 */
	public String modifyDailyPlanInput() {
		if (!isEmpty(id) && isUser()) {
			//查询小辅修班组
			request.put("proteams", userRolesService.listXXDictProTeam());
			
			request.put("datePlan", planManageService.findDatePlanPriById(Integer.parseInt(id)));
			request.put("users", planManageService.findUsersPrivsByRoleName(Contains.ROLE_NAME_JCGZ));
		} else {
			request.put("message", "日计划修改失败（用户登录是否失效）！");
		}
		return "modifydailyplaninput";
	}
	
	/**
	 * 日计划修改确认
	 * @return
	 */
	public String modifyDailyPlanConfrim() {
		if (null != datePlan && isUser()) {
			if (!isEmpty(id)) {
				datePlan.setGongZhang(planManageService.findUsersPrivsById((Long.parseLong(id))));
			}
			
			Integer result = planManageService.updateDailyPlan(datePlan);
			if (result == 1) {
				if (datePlan.getFixFreque().equals(Contains.PY_LX) || datePlan.getFixFreque().equals(Contains.PY_JG)) {
					request.put("message", "日计划修改成功，属于临修加改请填写计划检修内容！");
				} else {
					request.put("message", "日计划修改成功！");
				}
			} else {
				request.put("message", "日计划修改失败，该日计划已经在实施！");
			}
		} else {
			request.put("message", "日计划修改失败（用户登录是否失效）！");
		}
		return "jcgz_main_map";
//		return dailyPlanMake();
	}
	
	/**
	 * 删除日计划确认
	 * @return
	 */
	public String deleteDailyPlanConfirm() {
		if (!isEmpty(id) && isUser()) {
			Integer result = planManageService.deleteDailyPlan(Integer.parseInt(id));
			planManageService.updateStatusBydeleteDatePlan(Integer.parseInt(id));
			if (result == 1) {
				request.put("message", "日计划删除成功！");
			} else {
				request.put("message", "日计划修改失败，该日计划已经在实施！");
			}
		} else {
			request.put("message", "日计划修改失败（用户登录是否失效）！");
		}
		return "jcgz_main_map";
//		return dailyPlanMake();
	}
	
	/**
	 * 添加检修内容输入
	 * @return
	 */
	public String addOverhaulContentInput() {
		if (!isEmpty(id) && isUser()) {
			DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.parseInt(id));
			if (datePlanPri.getFixFreque().equals(Contains.PY_LX) || datePlanPri.getFixFreque().equals(Contains.PY_JG)) {
				request.put("datePlanPri", datePlanPri);
				return "addoverhaulcontentinput";
			} else {
				request.put("message", "不属于临修加改，不需要填写检修内容！");
			}
		} else {
			request.put("message", "添加检修内容失败（用户登录是否失效）！");
		}
		return dailyPlanMake();
	}
	
	/**
	 * 添加检修内容确认
	 * @return
	 */
	public String addOverhaulContentConfirm() {
		if (!isEmpty(id) && isUser()) {
			if (null != preDict) {
				DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.parseInt(id));
				preDict.setDatePlanPri(datePlanPri);
				preDict.setType((short)3);
				preDict.setRecStas((short)0);
				planManageService.saveJtPreDict(preDict);
				request.put("message", "检修内容添加成功！");
			}
		} else {
			request.put("message", "添加检修内容失败（用户登录是否失效）！");
		}
		return dailyPlanMake();
	}
	
	/**
	 * 删除日计划检修项目
	 * @return
	 */
	public String deleteOverhaulContentConfirm() {
		if (!isEmpty(id) && isUser()) {
			if (!isEmpty(trains)) {
				String[] strs = trains.split(",");
				if (!isEmpty(strs)) {
					Integer[] ids = new Integer[strs.length];
					for (int i = 0, len = strs.length; i < len; i++) {
						ids[i] = Integer.parseInt(strs[i]);
					}
					planManageService.deleteJtPreDict(ids);
					request.put("message", "检修内容删除成功！");
				}
			}
		} else {
			request.put("message", "删除检修内容失败（用户登录是否失效）！");
		}
		return dailyPlanMake();
	}
	
	
	/**
	 * 判断当日机车计划是否已存在
	 * @return
	 * @throws Exception 
	 */
	public String ajaxDailyIsExist() throws Exception{
		String result = "";
		HttpServletRequest request = ServletActionContext.getRequest();
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String jcType = request.getParameter("jcType");
		String jcNum = request.getParameter("jcNum");
		String fixFreque = request.getParameter("fixFreque");
		//判断当日机车计划是否存在
		DatePlanPri datePlanPri = null;
		try {
			datePlanPri = planManageService.dailyIsExist(jcType, jcNum, fixFreque);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(datePlanPri == null){
			result = "success";
		}
		out.write(result);
		return null;
	}
	
	/**
	 * 进入月计划查询列表页面
	 * @return
	 */
	public String monthPlanListInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String month=request.getParameter("monthId");
		Integer monthId=month==null||month.equals("")?null:Integer.parseInt(month);
		List<MonPlanPri> monthPlans=planManageService.queryMonPlanPri();
		PageModel<MonPlanRecorder> pm=planManageService.queryMonPlanRecorders(monthId);
		if(month!=null&&!month.equals("")){
			MonPlanPri monthPlan=planManageService.findMonPlanPriById(Integer.parseInt(month));
			request.setAttribute("monthPlan", monthPlan);
		}
		request.setAttribute("monthPlans", monthPlans);
		request.setAttribute("pm", pm);
		request.setAttribute("monthId", monthId);
		return "monthPlanList";
	}
	
	/**
	 * 进入周计划列表页面
	 * @return
	 */
	public String weekPlanListInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<MonPlanPri> monthPlans=planManageService.queryMonPlanPri();
		request.setAttribute("monthPlans", monthPlans);
		String monPlanId=request.getParameter("monPlanId");
		String planType=request.getParameter("planType");
		Integer monthId=monPlanId==null?null:Integer.parseInt(monPlanId);
		Short type=planType==null?null:Short.parseShort(planType);
		List<WeekPlanRecorder> weekRecs=planManageService.queryWeekPlanRecorder(monthId, type);
		request.setAttribute("weekRecs",weekRecs);
		request.setAttribute("monPlanId", monPlanId);
		request.setAttribute("planType",planType);
		return "weekPlanList";
	}
	
	/**
	 * 进入查询加改页面
	 * @return
	 */
	public String queryJGInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("jcAcounts", planManageService.findJcAcounts());
		request.setAttribute("result", planManageService.findJcItemAcount());
//		request.setAttribute("dictjcstype", planManageService.findDictJcStype());
//		request.setAttribute("jglist", planManageService.listJGPlanContent()); //统计加改信息
		return "jgList";
	}
	
	/**
	 * 列出加改详细信息
	 * @return
	 */
	public String listJgPlanInfo(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("dictjcstype", planManageService.findDictJcStype());
		request.setAttribute("jginfo", planManageService.listJGPlan(jgContent, jcType));//按加改内容，车型列出加改详细
		return "jginfo";
	}
	
	
	/**
	 * 进入新增项目页面
	 * */
	public String addJcItemInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<String> jcTypes = planManageService.findJcTypes();
		request.setAttribute("jcTypes", jcTypes);
		return "jgAddItem";
	}
	
	/**
	 * 进入追加项目页面
	 * */
	public String addJcInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String item = request.getParameter("item");
		List<String> jcTypes = planManageService.findJcTypes();
		
		request.setAttribute("jcTypes", jcTypes);
		request.setAttribute("item", item);
		return "addJcInput";
	}
	
	/**
	 * 进入加改编辑页面
	 * @return
	 */
	public String jgEditeInput(){
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("jcAcounts", planManageService.findJcAcounts());
			request.setAttribute("result", planManageService.findJcItemAcount());//统计加改信息
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jgEdite";
	}
	
	/**
	 * 保存追加加改项目
	 * */
	public String saveJcItems() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String result = request.getParameter("result");

		String[] str = result.split("-");
		String message = "加改项目添加成功！";
		for (int i = 0; i < str.length; i++) {
			String[] str2 = str[i].split(",");
			String item = str2[0];
			long size = planManageService.findJGPlanContent(item);
			if (size > 0) {
				message = "加改项目已添加过，请勿重复添加！";
				break;
			} else {
				for (int j = 1; j < str2.length; j++) {
					String[] jc = str2[j].split(":");
					String jcType = jc[0];
					int num = Integer.parseInt(jc[1]);

					JGPlanContent jPlan = new JGPlanContent();
					jPlan.setJgContent(item);
					jPlan.setJcType(jcType);
					jPlan.setPlanNum(num);
					planManageService.saveJgItem(jPlan);
				}
			}
		}
		request.setAttribute("message", message);
		return jgEditeInput();
	}
	
	/**
	 * 保存追加机车
	 * */
	public String saveJc() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String result = request.getParameter("result");
		String item = request.getParameter("item");
		String[] str = result.split("#");

		for (int i = 0; i < str.length; i++) {
			String[] str2 = str[i].split("\\$");
			DatePlanPri datePlanPri = new DatePlanPri();
			JtPreDict jtPreDict = new JtPreDict();
			for (int j = 0; j < str2.length; j++) {
				String date = str2[0];
				String type = str2[1];
				String num = str2[2];
				String note = null;
				if (str2.length > 3) {
					note = str2[3];
				}
				datePlanPri.setPlanStatue(3);
				datePlanPri.setFixFreque("JG");
				datePlanPri.setKcsj(date + " 07:00");
				datePlanPri.setSjjcsj(date + " 07:00");
				datePlanPri.setSjqjsj(date + " 07:00");
				datePlanPri.setJcType(type);
				datePlanPri.setJcnum(num);
				datePlanPri.setComments(note);

				jtPreDict.setRepsituation(item);
				jtPreDict.setDatePlanPri(datePlanPri);
				jtPreDict.setJcType(type);
				jtPreDict.setType(Short.parseShort("3"));
				jtPreDict.setJcNum(num);
				jtPreDict.setRepTime(date);
			}
			planManageService.saveItemDatePlan(datePlanPri);
			planManageService.saveItemJtPreDict(jtPreDict);
		}
		request.setAttribute("message", "加改机车追加成功！");
		return jgEditeInput();
	}
	
	/**
	 * 进入加改修改页面
	 * */
	public String editeJgInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<String> jcTypes = planManageService.findJcTypes();
		request.setAttribute("jcTypes", jcTypes);
		return "jgEditeItem";
	}
	
	/**
	 * 删除加改项目
	 * @return
	 */
	public String deleteJgItem() throws Exception{
		String result = "";
		//删除加改项目
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String[] jgIdArray = ServletActionContext.getRequest().getParameter("jgs").split(",");
		try {
			for(int i=0; i < jgIdArray.length; i++){
				List<JGPlanContent> jgPlanContentList = planManageService.findJgByitem(jgIdArray[i]);
					for(JGPlanContent content: jgPlanContentList){
						result = planManageService.deleteJGPlanContent(content);
					}
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入编辑加改项目页面
	 * */
	public String editeJgItemInput() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String item = request.getParameter("item");
//		item  = URLDecoder.decode(item,"UTF-8");
		List<JGPlanContent> jgitemList = planManageService.findJgByitem(item);
		request.setAttribute("jgitemList", jgitemList);
		request.setAttribute("item",item);
		return "jgitemList";
	}
	
	/**
	 * 编辑加改项目
	 * @return
	 */
	public String editeJgItem(){
		HttpServletResponse out = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		String item = request.getParameter("content");
		String result = request.getParameter("pjNums");
		String[] str = result.split(",");
		JGPlanContent jPlan = new JGPlanContent();
		for (int i = 0; i < str.length; i++) {
			String[] str2 = str[i].split("_");
				long jgId = Long.parseLong(str2[0]);
				int num = Integer.parseInt(str2[1]);
				jPlan.setJgContent(item);
				jPlan.setId(jgId);
				jPlan.setPlanNum(num);
				result = planManageService.updateJgItem(jPlan);
		   }
		try {
			out.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		}
	
	/**
	 * 根据id编辑加改项目
	 * @return
	 */
	public String editeJgItemById(){
		HttpServletResponse out = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		Long jgid = Long.parseLong(request.getParameter("jgid"));
		int planNum = Integer.parseInt(request.getParameter("planNum"));
		JGPlanContent jPlan = new JGPlanContent();
		jPlan.setId(jgid);
		jPlan.setPlanNum(planNum);
		String result = planManageService.updateJgItemById(jPlan);
	try {
		out.getWriter().print(result);
	} catch (IOException e) {
		e.printStackTrace();
	}
	return null;
	}
	
		//查询进行了加改项目的机车
	public String listJc(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String itemName = request.getParameter("itemName");
		String jctype = request.getParameter("jctype");
		
		List list = planManageService.findJcItemList(itemName, jctype);
		request.setAttribute("result", list);
		request.setAttribute("itemName", itemName);
		return "listJc";
	}
	
	//计划管理模块
	/**
	 * 进入计划编制页面
	 */
	public String mainPlanEditInput(){
		return "mainPlanEdit";
	}
	
	/**
	 * 保存计划
	 * 保存主计划和计划详情信息
	 * @return
	 * @throws Exception 
	 */
	public String savePlan() throws Exception{
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		HttpServletRequest request=ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String startTime=request.getParameter("start_time");
		String endTime=request.getParameter("end_time");
		String planTitle=request.getParameter("plan_title");
		String jsonStr=request.getParameter("jsonStr");
		MainPlan mainPlan=new MainPlan();
		mainPlan.setStartTime(startTime);
		mainPlan.setEndTime(endTime);
		mainPlan.setTitle(planTitle);
		mainPlan.setMakePeople(user.getXm());
		mainPlan.setMakeTime(dateConvertString(new Date()));
		mainPlan.setStatus(0);
		
		JSONArray jsonArray=new JSONArray(jsonStr);
		JSONObject jsonObject=null;
		MainPlanDetail mainPlanDetail=null;
		List<MainPlanDetail> list=new ArrayList<MainPlanDetail>();
		for(int i=0;i<jsonArray.length();i++){
			jsonObject=jsonArray.optJSONObject(i);
			mainPlanDetail=new MainPlanDetail();
			mainPlanDetail.setPlanTime(formatter.format(formatter.parse(jsonObject.optString("planTime"))));
			mainPlanDetail.setPlanWeek(jsonObject.optString("planWeek"));
			mainPlanDetail.setJcType(jsonObject.optString("jcType"));
			mainPlanDetail.setJcNum(jsonObject.optString("jcNum"));
			mainPlanDetail.setXcxc(jsonObject.optString("xcxc"));
			mainPlanDetail.setKilometre(jsonObject.optString("kilometre"));
			mainPlanDetail.setRealKilometre(jsonObject.optString("realKilometre"));
			mainPlanDetail.setKcArea(jsonObject.optString("kcArea"));
			mainPlanDetail.setComments(jsonObject.optString("comments"));
			mainPlanDetail.setIsCash(0);
			mainPlanDetail.setNum(i+1);
			list.add(mainPlanDetail);
		}
		String result="failure";
		try {
			planManageService.savePlan(mainPlan, list);
			result="success_"+mainPlan.getId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	/**
	 * 根据日期查询该时间段内是否存在已经编制的计划
	 * @return
	 */
	public String ajaxExistMainPlan(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String startTime=request.getParameter("start_time");
		String endTime=request.getParameter("end_time");
		try {
			List<MainPlanDetail> mianPlanDetails=planManageService.findMainPlanDetail(startTime, endTime);
			String result="success";
			if(mianPlanDetails!=null&&mianPlanDetails.size()>0){
				result="exit_plan";
			}
			ServletActionContext.getResponse().getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查看计划详细信息
	 * @return
	 */
	public String findPlanDetail(){
		HttpServletRequest request=ServletActionContext.getRequest();
		Long mainPlanId=null;
		if(request.getAttribute("mainPlanId")==null){
			mainPlanId=Long.parseLong(request.getParameter("mainPlanId"));
		}else{
			mainPlanId=Long.parseLong(request.getAttribute("mainPlanId")+"");
		}
		MainPlan mainPlan=planManageService.findMainPlanById(mainPlanId);
		List<MainPlanDetail> mainPlanDetails=planManageService.findMainPlanDetailByMainId(mainPlanId);
		request.setAttribute("mainPlan", mainPlan);
		request.setAttribute("mainPlanDetails", mainPlanDetails);
		return "planDetail";
	}

	/**
	 * 查看计划兑现信息
	 * @return
	 */
	public String findCashDetail(){
		HttpServletRequest request=ServletActionContext.getRequest();
		Long mainPlanId=Long.parseLong(request.getParameter("mainPlanId"));
		MainPlan mainPlan=planManageService.findMainPlanById(mainPlanId);
		List<MainPlanDetail> mainPlanDetails=planManageService.findMainPlanDetailByMainId(mainPlanId);
		request.setAttribute("mainPlan", mainPlan);
		request.setAttribute("mainPlanDetails", mainPlanDetails);
		return "cashDetail";
	}
	
	/**
	 * ajax发布计划
	 * @return
	 */
	public String ajaxPublishMainPlan(){
		HttpServletRequest request=ServletActionContext.getRequest();
		Long mainPlanId=Long.parseLong(request.getParameter("mainPlanId"));
		try {
			MainPlan mainPlan=planManageService.findMainPlanById(mainPlanId);
			mainPlan.setStatus(1);
			planManageService.saveOrUpdateMainPlan(mainPlan);
			ServletActionContext.getResponse().getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * ajax删除计划
	 * @return
	 */
	public String ajaxDelPlan(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String mainPlanId=request.getParameter("mainPlanId");
		String mainPlanDetailId=request.getParameter("mainPlanDetailId");
		try {
			planManageService.delPlan(mainPlanId, mainPlanDetailId);
			ServletActionContext.getResponse().getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入主计划查询页面
	 * @return
	 */
	public String queryMainPlanInput(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		PageModel<MainPlan> pm=planManageService.findMainPlanList(startTime,endTime);
		request.setAttribute("pm", pm);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		return "queryMainPlan";
	}
	
	/**
	 * 进入兑现计划查询页面
	 * @return
	 */
	public String cashMainPlanInput(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		PageModel<MainPlan> pm=planManageService.findMainPlanList(startTime,endTime);
		request.setAttribute("pm", pm);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		return "cashMainPlan";
	}
	
	/**
	 * ajax填写计划未兑现原因
	 * @return
	 */
	public String ajaxGetReason(){
		HttpServletRequest request=ServletActionContext.getRequest();
		Long id=Long.parseLong(request.getParameter("id"));
		String reason=request.getParameter("reason");
		try {
			MainPlanDetail mainPlanDetail=planManageService.findMainPlanDetailById(id);
			mainPlanDetail.setCashReason(reason);
			planManageService.saveOrUpdateMainPlanDetail(mainPlanDetail);
			ServletActionContext.getResponse().getWriter().print("success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	
	/**
	 * 日计划扣车从发布计划中查找
	 * @return
	 */
	public String findJcCurriculumByMainPlan() {
		request.put("mainPlanDetail", planManageService.findMainPlanDetailByStatusAndTime());
		return "findweekplan";
	}
	
	/**
	 * 进入计划修改
	 * */
	public String xiuDetailPlanInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		long planId = Long.parseLong(request.getParameter("planId"));
		MainPlanDetail plan = planManageService.findMainPlanDetailById(planId);
		request.setAttribute("plan", plan);
		return "xiuDetailPlanInput";
	}
	
	/**
	 * 跟新详细计划
	 * */
	public String updateMainDetailPlan() {
		HttpServletRequest request = ServletActionContext.getRequest();
		long planId = Long.parseLong(request.getParameter("planId"));
		String jcType = request.getParameter("jcType");
		String jcNum = request.getParameter("jcNum");
		String xcxc = request.getParameter("xcxc");
		String kilometre = request.getParameter("kilometre");
		String kcArea = request.getParameter("kcArea");
		String comments = request.getParameter("comments");
		MainPlanDetail detail = planManageService.findMainPlanDetailById(planId);

		detail.setJcNum(jcNum);
		detail.setComments(comments);
		detail.setJcType(jcType);
		detail.setKcArea(kcArea);
		detail.setKilometre(kilometre);
		detail.setXcxc(xcxc);
		planManageService.saveOrUpdateMainPlanDetail(detail);

		try {
			ServletActionContext.getResponse().getWriter().print("success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * ajax更新计划详情信息
	 * @return
	 */
	public String ajaxUpdateMainDetailPlan(){
		HttpServletRequest request = ServletActionContext.getRequest();
		Long detailId = Long.parseLong(request.getParameter("detailId"));
		String inputName=request.getParameter("inputName");
		String inputVal=request.getParameter("inputVal");
		if(inputName!=null&&!"".equals(inputName)){
			try {
				planManageService.updateMainPlanDetial(detailId, inputName, inputVal);
				ServletActionContext.getResponse().getWriter().print("success");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 根据时间查询已经存在的主计划信息
	 * @return
	 */
	public String querExistMainPlan(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		List<MainPlan> mainPlans=planManageService.findMainPlanByTime(startTime, endTime);
		request.setAttribute("mainPlans", mainPlans);
		return "existMainPlan";
	}
	
	/**
	 * 进入Excel导入页面
	 * @return
	 */
	public String uploadExcelInput(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String planTitle=request.getParameter("planTitle");
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("planTitle", planTitle);
		return "upload_plan_excel";
	}
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTrains() {
		return trains;
	}

	public void setTrains(String trains) {
		this.trains = trains;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOtherId() {
		return otherId;
	}

	public void setOtherId(String otherId) {
		this.otherId = otherId;
	}

	public MonPlanPri getMonPlan() {
		return monPlan;
	}

	public void setMonPlan(MonPlanPri monPlan) {
		this.monPlan = monPlan;
	}

	public MonPlanRecorder getMonPlanRecorder() {
		return monPlanRecorder;
	}

	public void setMonPlanRecorder(MonPlanRecorder monPlanRecorder) {
		this.monPlanRecorder = monPlanRecorder;
	}

	public WeekPlanPri getWeekPlan() {
		return weekPlan;
	}

	public void setWeekPlan(WeekPlanPri weekPlan) {
		this.weekPlan = weekPlan;
	}

	public DatePlanPri getDatePlan() {
		return datePlan;
	}

	public void setDatePlan(DatePlanPri datePlan) {
		this.datePlan = datePlan;
	}

	public JtPreDict getPreDict() {
		return preDict;
	}

	public void setPreDict(JtPreDict preDict) {
		this.preDict = preDict;
	}

	public Dispatch getDispatch() {
		return dispatch;
	}

	public void setDispatch(Dispatch dispatch) {
		this.dispatch = dispatch;
	}

	public WeekPlanRecorder getWeekPlanRecorder() {
		return weekPlanRecorder;
	}

	public void setWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder) {
		this.weekPlanRecorder = weekPlanRecorder;
	}

	public String getJgContent() {
		return jgContent;
	}

	public void setJgContent(String jgContent) {
		this.jgContent = jgContent;
	}

	public String getJcType() {
		return jcType;
	}

	public void setJcType(String jcType) {
		this.jcType = jcType;
	}

	public MainPlanDetail getMainPlanDetail() {
		return mainPlanDetail;
	}

	public void setMainPlanDetail(MainPlanDetail mainPlanDetail) {
		this.mainPlanDetail = mainPlanDetail;
	}
}
