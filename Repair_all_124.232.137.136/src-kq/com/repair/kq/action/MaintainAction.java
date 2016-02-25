package com.repair.kq.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQEquip;
import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.kq.service.MaintainService;
import com.repair.kq.service.RewardService;

/**
 * 维护设置Action
 *
 */
public class MaintainAction {
	
	@Resource(name="maintainService")
	private MaintainService maintainService;
	@Resource(name="rewardService")
	private RewardService rewardService;
	
	private KQEquip equip;
	private KQHoliday holiday;
	private KQRule rule;
	private KQWorkTimeItem workTimeItem;
	
	private Long proteamId;
	private String itemName;

	private HttpServletRequest request = ServletActionContext.getRequest();
	public static final SimpleDateFormat YMDHMS_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 查询设备信息
	 */
	public String getEquipInput(){
		List<KQEquip> equip = maintainService.getEquip();
		request.setAttribute("equip", equip);
		return "equip";
	}
	
	/**
	 * 进入新增页面
	 */
	public String addEquipInput() throws Exception{
		return "addEquip";
	}
	
	/**
	 * 新增设备
	 */
	public String saveEquip() throws Exception{
		try{	
			maintainService.saveKQEquip(equip);
			request.setAttribute("message", "新增设备成功！");
		}catch (Exception e) {
			request.setAttribute("message", "设备添加失败!");
		}
		return getEquipInput();
	}
	
	/**
	 * 进入修改设备页面
	 */
	public String editEquipInput() throws Exception{
		KQEquip kqequip = maintainService.queryEquipById(Long.valueOf(request.getParameter("equipId")));
		request.setAttribute("kqequip", kqequip);
		return "editKqequip";
	}
	
	/**
	 * 修改设备信息
	 */
	public String editEquip() throws Exception{
		Long equipId = Long.valueOf(request.getParameter("equipId"));
		KQEquip kqequips = maintainService.queryEquipById(Long.valueOf(equipId));
		kqequips.setEquipName(equip.getEquipName());
		kqequips.setEquipType(equip.getEquipType());
		kqequips.setEquipNum(equip.getEquipNum());
		kqequips.setEquipPosition(equip.getEquipPosition());
		kqequips.setEquipIp(equip.getEquipIp());
		kqequips.setEquipState(equip.getEquipState());
		kqequips.setEquipPort(equip.getEquipPort());
		maintainService.saveOrUpdateEquip(kqequips);
		request.setAttribute("message", "设备信息编辑成功!");
		return getEquipInput();
	}
	
	/**
	 * 删除设备
	 */
	public String deleteEquipAjax() throws Exception{
		String result = "";
		//删除设备
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String[] equipIdArray = ServletActionContext.getRequest().getParameter("faults").split(",");
		try {
			for(int i=0; i < equipIdArray.length; i++){
				KQEquip kqequip = maintainService.queryEquipById(Long.valueOf(equipIdArray[i]));
				maintainService.deleteEquip(kqequip);
				result = "success";
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查询考勤设置信息
	 */
	@SuppressWarnings("unchecked")
	public String getRuleInput(){
		List<KQRule> rule = maintainService.getRuleInput();
		for(int i = 0 ; i<rule.size();i++){
			List list = new ArrayList();
			String bz =rule.get(i).getBzid();
			String[] sa = bz.split(",");
			for(String s : sa){
				if(s !=null && !"".equals(s)){
					Long bzid = Long.valueOf(String.valueOf(s)).longValue();
					DictProTeam proteam = maintainService.queryBzById(bzid);
					list.add(proteam.getProteamname());
				}
			}
			String bzName =list.toString().replace("[", "").replace("]", "");
			rule.get(i).setBzid(bzName);
		}
		request.setAttribute("rule", rule);
		return "rule";
	}
	
	
	
	/**
	 * 查询班组 
	 */
	public String findAllBz(){
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		return "proteams";
	}
	
	/**
	 * 进入新增考勤规则页面
	 */
	public String addRuleInput() throws Exception{
		List<DictProTeam> proteams=maintainService.findDictProTeam();
		request.setAttribute("proteams", proteams);
		return "addRule";
	}
	
	/**
	 * 查询节假日信息
	 */
	public String getHolidayInput(){
		List<KQHoliday> holiday = maintainService.getHolidayInput();
		request.setAttribute("holiday", holiday);
		return "holiday";
	}
	
	/**
	 * 进入批量新增页面
	 */
	public String addHolidayInput() throws Exception{
		return "addHoliday";
	}
	
	/**
	 * 进入单个新增页面
	 */
	public String addSinHolidayInput() throws Exception{
		return "addSinHoliday";
	}
	
	/**
	 * 添加多个节假日安排
	 */
	public String saveHoliday() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		List<KQHoliday> holidays = maintainService.getHolidayInput();
		String jsonStr=request.getParameter("jsonStr");
		JSONArray jsonArray=new JSONArray(jsonStr);
		JSONObject jsonObject=null;
		List<KQHoliday> list=new ArrayList<KQHoliday>();
		boolean flag=true;
		for(int i=0;i<jsonArray.length();i++){
			jsonObject=jsonArray.optJSONObject(i);
			holiday=new KQHoliday();
			holiday.setHolidayName(jsonObject.optString("holidayName"));
			holiday.setStartTime(jsonObject.optString("startTime"));
			holiday.setEndTime(jsonObject.optString("endTime"));
			Date t1= YMDHMS_FORMAT.parse(holiday.getStartTime());
			Date t3= YMDHMS_FORMAT.parse(holiday.getEndTime());
			for(int j=0;j<holidays.size();j++){
				Date t2= YMDHMS_FORMAT.parse(holidays.get(j).getStartTime());
				Date t4= YMDHMS_FORMAT.parse(holidays.get(j).getEndTime());
				if((t1.compareTo(t2) <0 && t3.compareTo(t2) >=0) ||((t1.compareTo(t2)) >=0 && (t1.compareTo(t4)) <=0)){
					flag=false;
					break;
				}
			}
			if(flag){
				list.add(holiday);
			}else{
				flag=false;
			}
		}
		String result="failure";
		try {
			if(flag){
				maintainService.saveHoliday(list);
				result="success";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	/**
	 * 新增单个节假日安排
	 */
	public String saveSinHoliday() throws Exception{
		try{
			List<KQHoliday> holidays = maintainService.getHolidayInput();
			Date t1= YMDHMS_FORMAT.parse(holiday.getStartTime());
			Date t3= YMDHMS_FORMAT.parse(holiday.getEndTime());
			boolean flag=true;
			for(int i=0;i<holidays.size();i++){
				Date t2= YMDHMS_FORMAT.parse(holidays.get(i).getStartTime());
				Date t4= YMDHMS_FORMAT.parse(holidays.get(i).getEndTime());
				if((t1.compareTo(t2) <0 && t3.compareTo(t2) >=0) ||((t1.compareTo(t2)) >=0 && (t1.compareTo(t4)) <=0)){
					flag=false;
					break;
				}
			}
			if(flag){
				maintainService.saveSinHoliday(holiday);
				request.setAttribute("message", "新增节假日成功！");
			}else{
				request.setAttribute("message", "你所设定的日期已是放假日期！");
			}
			
		}catch (Exception e) {
			request.setAttribute("message", "节假日添加失败!");
		}
		return getHolidayInput();
	}
	
	/**
	 * 删除设备
	 */
	public String deleteHolidayAjax() throws Exception{
		String result = "";
		//删除设备
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String[] holidayIdArray = ServletActionContext.getRequest().getParameter("faults").split(",");
		try {
			for(int i=0; i < holidayIdArray.length; i++){
				KQHoliday holiday = maintainService.queryHolidayById(Long.valueOf(holidayIdArray[i]));
				maintainService.deleteHoliday(holiday);
				result = "success";
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入编辑放假设置
	 */
	public String editHolidayInput() throws Exception{
		KQHoliday holiday = maintainService.queryHolidayById(Long.valueOf(request.getParameter("holidayId")));
		request.setAttribute("holiday", holiday);
		return "editHoliday";
	}
	
	/**
	 * 编辑放假设置
	 * 
	 */
	public String editHoliday() throws Exception{
		Long holidayId = Long.valueOf(request.getParameter("holidayId"));
		KQHoliday holidays = maintainService.queryHolidayById(Long.valueOf(holidayId));
		holidays.setHolidayName(holiday.getHolidayName());
		holidays.setStartTime(holiday.getStartTime());
		holidays.setEndTime(holiday.getEndTime());
		maintainService.saveOrUpdateHoliday(holidays);
		request.setAttribute("message", "放假信息编辑成功!");
		return getHolidayInput();
	}
	
	/**
	 * 删除考勤规则设置
	 */
	public String deleteRuleAjax() throws Exception{
		String result = "";
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		Long ruleId = Long.valueOf(request.getParameter("ruleId"));
		try {
			KQRule rule = maintainService.queryRuleById(ruleId);
			maintainService.deleteRule(rule);
			result = "success";
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加考勤规则设置
	 */
	public String saveRule() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		String jsonStr=request.getParameter("jsonStr");
		JSONArray jsonArray=new JSONArray(jsonStr);
		JSONObject jsonObject=null;
		List<KQRule> list=new ArrayList<KQRule>();
		for(int i=0;i<jsonArray.length();i++){
			jsonObject=jsonArray.optJSONObject(i);
			rule=new KQRule();
			rule.setBzid(","+jsonObject.optString("bzid")+",");
			rule.setDuration(jsonObject.optString("duration"));
			rule.setFirstStartTime(jsonObject.optString("firstStartTime"));
			rule.setSecStartTime(jsonObject.optString("secStartTime"));
			rule.setFirstEndTime(jsonObject.optString("firstEndTime"));
			rule.setSecEndTime(jsonObject.optString("secEndTime"));
			rule.setLateValid(jsonObject.optInt("lateValid"));
			rule.setLateNot(jsonObject.optInt("lateNot"));
			rule.setAfterValid(jsonObject.optInt("afterValid"));
			rule.setLeaveEarly(jsonObject.optInt("leaveEarly"));
			rule.setWorkType(jsonObject.optString("workType"));
			list.add(rule);
		}
			String result = maintainService.saveRule(list);
			ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	/**
	 * 进入编辑考勤规则设置
	 */
	public String editRuleInput() throws Exception{
		KQRule rule = maintainService.queryRuleById(Long.valueOf(request.getParameter("ruleId")));
		String bzids= rule.getBzid().substring(1,rule.getBzid().length()-1);
		String[] bz =rule.getBzid().substring(1).split(",");
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < bz.length; i++){
			DictProTeam proteam =maintainService.queryBzById(Long.parseLong(bz[i]));
		 sb. append(proteam.getProteamname()+",");
		}
		String proteamName = sb.deleteCharAt(sb.length()-1).toString();
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("bzids", bzids);
		request.setAttribute("proteamName", proteamName);
		request.setAttribute("proteams", proteams);
		request.setAttribute("rule", rule);
		return "editRule";
	}
	
	/**
	 * 编辑考勤规则
	 * 
	 */
	public String editRule() throws Exception{
		Long ruleId = Long.valueOf(request.getParameter("ruleId"));
//		KQRule rules = maintainService.queryRuleById(ruleId);
		KQRule rules = new KQRule();
		rules.setId(ruleId);
		String bzName = rule.getBzid().replace(" ", "");
		rules.setBzid(","+bzName+",");
		rules.setWorkType(rule.getWorkType());
		rules.setDuration(rule.getDuration());
		rules.setLateValid(rule.getLateValid());
		rules.setAfterValid(rule.getAfterValid());
		rules.setLateNot(rule.getLateNot());
		rules.setLeaveEarly(rule.getLeaveEarly());
		rules.setFirstStartTime(rule.getFirstStartTime());
		rules.setFirstEndTime(rule.getFirstEndTime());
		rules.setSecStartTime(rule.getSecStartTime());
		rules.setSecEndTime(rule.getSecEndTime());
		String result = maintainService.saveOrUpdateRule(rules,ruleId);
			if(result.equals("success")){
				request.setAttribute("message", "考勤信息编辑成功!");
			}else{
				request.setAttribute("message", "添加的班组已有对应规则!");
			}
		return getRuleInput();
	}
	
	/**
	 * 查询工时项目
	 */
	public String getWorkTimeItems(){
		List<KQWorkTimeItem> workTimeItem = maintainService.getworkTimeItems(proteamId,itemName);
		List<DictProTeam> proteams=maintainService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		request.setAttribute("workTimeItem", workTimeItem);
		return "workTimeItem";
	}
	
	/**
	 * 进入新增页面
	 */
	public String addWorkTimeItem() throws Exception{
		List<DictProTeam> proteams=maintainService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		return "addWorkTimeItem";
	}
	
	/**
	 * 新增工时项目
	 */
	public String saveWorkTimeItem() throws Exception{
		
		try{	
			workTimeItem.setIsused(Integer.valueOf(1));
			maintainService.saveWorkTimeItem(workTimeItem);
			request.setAttribute("message", "新增工时项目成功！");
		}catch (Exception e) {
			request.setAttribute("message", "工时项目添加失败!");
		}
		return getWorkTimeItems();
	}
	
	/**
	 * 进入修改工时项目页面
	 */
	public String editWorkTimeItemInput() throws Exception{
		KQWorkTimeItem workTimeItem = maintainService.queryWorkTimeItemById(Long.valueOf(request.getParameter("workTimeItemId")));
		List<DictProTeam> proteams=maintainService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		request.setAttribute("workTimeItem", workTimeItem);
		return "editWorkTimeItem";
	}
	
	/**
	 * 修改工时项目信息
	 */
	public String editWorkTimeItem() throws Exception{
		Long workTimeItemId = Long.valueOf(request.getParameter("workTimeItemId"));
		KQWorkTimeItem workTimeItems = maintainService.queryWorkTimeItemById(workTimeItemId);
		workTimeItems.setProteam(workTimeItem.getProteam());
		workTimeItems.setItemScore(workTimeItem.getItemScore());
		workTimeItems.setItemName(workTimeItem.getItemName());
		maintainService.saveOrUpdateWorkTimeItem(workTimeItems);
		request.setAttribute("message", "设备信息编辑成功!");
		return getWorkTimeItems();
	}
	
	/**
	 * 删除工时项目
	 */
	public String delWorkTimeItem() throws Exception{
		String result = "";
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		Long workTimeItemId = Long.valueOf(request.getParameter("workTimeItemId"));
		KQWorkTimeItem workTimeItems = maintainService.queryWorkTimeItemById(workTimeItemId);
		workTimeItems.setIsused(Integer.valueOf(0));
		maintainService.saveOrUpdateWorkTimeItem(workTimeItems);
		result = "success";
		out.write(result);
		return null;
	}
	
	public KQEquip getEquip() {
		return equip;
	}
	public void setEquip(KQEquip equip) {
		this.equip = equip;
	}

	public KQHoliday getHoliday() {
		return holiday;
	}

	public void setHoliday(KQHoliday holiday) {
		this.holiday = holiday;
	}

	public KQRule getRule() {
		return rule;
	}

	public void setRule(KQRule rule) {
		this.rule = rule;
	}

	public KQWorkTimeItem getWorkTimeItem() {
		return workTimeItem;
	}

	public void setWorkTimeItem(KQWorkTimeItem workTimeItem) {
		this.workTimeItem = workTimeItem;
	}

	public Long getProteamId() {
		return proteamId;
	}

	public void setProteamId(Long proteamId) {
		this.proteamId = proteamId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	
}
