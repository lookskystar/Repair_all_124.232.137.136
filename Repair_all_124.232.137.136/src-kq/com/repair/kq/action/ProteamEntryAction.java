package com.repair.kq.action;

import java.io.IOException;
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
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.service.ProteamEntryService;

public class ProteamEntryAction {

	@Resource(name="proteamEntryService")
	private ProteamEntryService proteamEntryService; 
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	public static final SimpleDateFormat YMDHMS_FORMAT = new SimpleDateFormat("yyyy-MM-dd"); 
	
	/**
	 * 进入班组录入页面
	 * */
	public String proteamEntryInput() {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String riqi = request.getParameter("riqi");
		if(" ".equals(riqi) || riqi == null){
			riqi = YMDHMS_FORMAT.format(new Date());
		}
		int count = proteamEntryService.findRecordCount(user.getBzid(), riqi);
		if(count > 0){
			List<KQWorkTimeCount> workRecords = proteamEntryService.findWorkRecords(user.getBzid(), riqi);
			request.setAttribute("workRecords", workRecords);
			request.setAttribute("riqi", riqi);
		}else{
			List<UsersPrivs> users = proteamEntryService.findUsersById(user.getBzid());
			request.setAttribute("users", users);
			request.setAttribute("riqi", riqi);
		}
		request.setAttribute("count", proteamEntryService.countWorkRecords(user.getBzid(), riqi));
		return "proteamEntryInput";
	}
	
	/**
	 * 保存工时录入
	 * */
	public String saveProteamEntry() throws Exception {
		DictProTeam proteam = (DictProTeam) request.getSession().getAttribute("session_user_proteam");
		String jsonStr = request.getParameter("jsonStr");
		JSONArray jsonArray = new JSONArray(jsonStr);
		JSONObject jsonObject = null;
		KQWorkTimeCount workTimeCount = null;
		List<KQWorkTimeCount> list = new ArrayList<KQWorkTimeCount>();
		for (int i = 0; i < jsonArray.length(); i++) {
			jsonObject = jsonArray.optJSONObject(i);
			workTimeCount = new KQWorkTimeCount();
			workTimeCount.setProteam(proteam);
			workTimeCount.setName(jsonObject.optString("xm"));
			workTimeCount.setGonghao(jsonObject.optString("gonghao"));
			workTimeCount.setTime(jsonObject.optString("time"));
			workTimeCount.setWorkContent(jsonObject.optString("content"));
			workTimeCount.setWorkScore(jsonObject.optString("score"));
			workTimeCount.setWorkNote(jsonObject.optString("note"));
			list.add(workTimeCount);
		}
		String result = "failure";
		try {
			proteamEntryService.saveProteamEntry(list);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	/**
	 * 进入Excel导入页面
	 */
	public String uploadExcelInput() {
		return "upload_workTimeCount_excel";
	}
	
	/**
	 * 判断所选日期是否存在记录
	 * */
	public String checkRecord() throws Exception {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String riqi = request.getParameter("riqi");

		int count = proteamEntryService.findRecordCount(user.getBzid(), riqi);
		String result = "success";
		if (count > 0) {
			result = "failure";
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	/**
	 * 工时结转
	 * */
	public String transfer(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String riqi = request.getParameter("riqi");
		
		proteamEntryService.updateStatus(user.getBzid(), riqi);
		List<KQWorkTimeCount> workRecords = proteamEntryService.findWorkRecords(user.getBzid(), riqi);
		
		request.setAttribute("workRecords", workRecords);
		request.setAttribute("riqi", riqi);
		request.setAttribute("message", "已结转！");
		return "proteamEntryInput";
	}
	
	/**
	 * 跟新工时录入信息
	 * */
	public String updateRecord() throws IOException{
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		String score = request.getParameter("score");
		String note = request.getParameter("note");
		KQWorkTimeCount record = proteamEntryService.findRecord(Long.parseLong(id));
		if(record.getStatus() == 1){
			ServletActionContext.getResponse().getWriter().print("failure");
		}else{
			record.setWorkContent(content);
			record.setWorkNote(note);
			if(score != null && !"".equals(score)){
				record.setWorkScore(score);
			}
			proteamEntryService.updateRecord(record);
			ServletActionContext.getResponse().getWriter().print("success");
		}
		return null;
	}
	
	/**
	 * 进入工时派工页面
	 * */
	public String workDivisionInput(){
		Date date = new Date();
		String today = YMDHMS_FORMAT.format(date);
		
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		List<UsersPrivs> users = proteamEntryService.findUsersById(user.getBzid());
		List<KQWorkTimeItem> items = proteamEntryService.findProteamItem(user.getBzid());
		
		request.setAttribute("today", today);
		request.setAttribute("users", users);
		request.setAttribute("items", items);
		return "workDivisionInput";
	}
	
	/**
	 * 保存派工
	 * */
	public String saveProteamCharge()throws Exception{
		String shiJian = request.getParameter("shiJian");
		String itemId = request.getParameter("itemId");
		String userStr = request.getParameter("userStr");
		String[] userId = userStr.split(",");
		
		//派工之前先清空派工
		proteamEntryService.deleteItemCharge(shiJian, Long.parseLong(itemId));
		
		for (int i = 0; i < userId.length; i++) {
			KQUserItem item = new KQUserItem();
			KQWorkTimeItem workItem = proteamEntryService.findWorkTimeItem(Long.parseLong(itemId));
			UsersPrivs user = proteamEntryService.findUser(Long.parseLong(userId[i]));
			
			item.setProteam(workItem.getProteam());
			item.setItem(workItem);
			item.setUser(user);
			item.setWorkTime(shiJian);
			item.setStatus(0);
			item.setWorkScore(workItem.getItemScore()/userId.length);
			
			proteamEntryService.saveKQUserItem(item);
		}
		ServletActionContext.getResponse().getWriter().print("派工成功！");
		return null;
	}
	
	/**
	 * 查看项目派工情况
	 * */
	public String checkCharge() throws Exception {
		String shiJian = request.getParameter("shiJian");
		String itemId = request.getParameter("itemId");
		List<KQUserItem> items = proteamEntryService.findKQUserItems(shiJian,Long.parseLong(itemId));

		String str = "";
		for (int i = 0; i < items.size(); i++) {
			str += items.get(i).getUser().getUserid() + ",";
		}
		int count = proteamEntryService.findChargeCount(shiJian, Long.parseLong(itemId));
		if (count > 0) {
			str += "c";
		} else {
			str += "n";
		}
		ServletActionContext.getResponse().getWriter().print(str);
		return null;
	}
}
