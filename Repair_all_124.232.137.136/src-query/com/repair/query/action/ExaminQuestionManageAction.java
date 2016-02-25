/**
 * 
 */
package com.repair.query.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.ExaminQuestion;
import com.repair.common.pojo.ExaminQuestionType;
import com.repair.common.pojo.ExaminRec;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.common.util.PropertyUtil;
import com.repair.query.service.PlantManageService;
import com.repair.work.service.UsersPrivsService;

/**
 * @author eleven
 *
 */
public class ExaminQuestionManageAction {
	@Resource(name = "plantManageService")
	private PlantManageService plantManageService;
	@Resource(name = "usersPrivsService")
	private UsersPrivsService usersPrivsService;
	
	//问题类型
	private String type;
	//问题
	private String examinQuestions;
	//上传人
	private String uploader;
	//开始时间
	private String dateStart;
	//结束时间
	private String dateEnd;
	//审批人
	private String examiner;
	//考试人
	private String eaxminer;
	//考试专业
	private String major; 
	
	private ExaminQuestionType examinQuestionType;
	private ExaminQuestion examinQuestion;
	
	//分页参数
	private int page_First = 1;
	private int page_Next = 1;
	private static final int page_Size = 1;
//	private static final String page_RowCount = PropertyUtil.getResourceByKey("questionnum");
		
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 查询所有问题类型
	 * @return
	 * @throws Exception
	 */
	public String listExaminQuestionType() throws Exception{
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionType();
		//封装MAP
		Map<ExaminQuestionType, List<ExaminQuestionType>> examinQuestionTypeMap = new LinkedHashMap<ExaminQuestionType, List<ExaminQuestionType>>();
		ExaminQuestionType tempExaminQuestionType = null;
		List<ExaminQuestionType> childExaminQuestionTypeList = null; 
		for(int i = 0; i <= examinQuestionTypeList.size()-1; i++){
			tempExaminQuestionType = examinQuestionTypeList.get(i);
			if(tempExaminQuestionType.getParentType() == null || tempExaminQuestionType.getParentType().getId() == 0){
				if(examinQuestionTypeMap.get(tempExaminQuestionType) == null){
					childExaminQuestionTypeList = plantManageService.listExaminQuestionTypeByPID(tempExaminQuestionType.getId());
					examinQuestionTypeMap.put(tempExaminQuestionType, childExaminQuestionTypeList);
				}
			}
		}
		request.setAttribute("examinQuestionTypeMap", examinQuestionTypeMap);
		return "listExaminQuestionType";
	}
	
	/**
	 * 查询所有的问题
	 * @return
	 * @throws Exception
	 */
	public String listExaminQuestion() throws Exception{
		PageModel<ExaminQuestion> examinQuestionPm  = plantManageService.listExaminQuestion(type, examinQuestions, uploader, dateStart, dateEnd, examiner);
		request.setAttribute("examinQuestionPm", examinQuestionPm);
		return	"listExaminQuestion";
	}
	
	/**
	 * 新建问题类型
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionTypeAddInput() throws Exception{
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionTypeOfTop();
		List<DictProTeam> dictProTeams = plantManageService.listDictProtem();
		request.setAttribute("dictProTeams", dictProTeams);
		request.setAttribute("examinQuestionTypeList", examinQuestionTypeList);
		return "examinQuestionTypeAddInput";
	}
	
	public String examinQuestionTypeAdd() throws Exception{
		//初始问题类型为激活状态
		examinQuestionType.setStatus(1);
		plantManageService.saveOrUpdateExaminQuestionType(examinQuestionType);
		return listExaminQuestionType();
	}
	
	
	/**
	 * 编辑问题类型
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionTypeEditInput() throws Exception{
		String ExaminQuestionTypeId = request.getParameter("id");
		ExaminQuestionType examinQuestionTypes = plantManageService.listExaminQuestionTypeById(Long.parseLong(ExaminQuestionTypeId));
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionTypeOfTop();
		request.setAttribute("examinQuestionTypes", examinQuestionTypes);
		request.setAttribute("examinQuestionTypeList", examinQuestionTypeList);
		return "examinQuestionTypeEditInput";
	}
	
	public String examinQuestionTypeEdit() throws Exception{
		plantManageService.saveOrUpdateExaminQuestionType(examinQuestionType);
		return listExaminQuestionType();
	}
	
	/**
	 * 删除问题类型
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionTypeDelete() throws Exception{
		String result = "";
		String examinQuestionIdArray[] = request.getParameter("examinQuestionTypes").split(",");
		for (int i = 0; i < examinQuestionIdArray.length; i++) {
			ExaminQuestionType examinQuestionType = plantManageService.listExaminQuestionTypeById(Long.parseLong(examinQuestionIdArray[i]));
			//查找该类型是否有子类型
			List<ExaminQuestionType> childExaminQuestionTypeList = plantManageService.listExaminQuestionTypeByPID(examinQuestionType.getId());
			try {
				if(childExaminQuestionTypeList.size() >0 || childExaminQuestionTypeList != null){
					for (Iterator<ExaminQuestionType> iterator = childExaminQuestionTypeList.iterator(); iterator.hasNext();) {
						ExaminQuestionType childExaminQuestionType = (ExaminQuestionType) iterator.next();
						childExaminQuestionType.setStatus(0);
						plantManageService.saveOrUpdateExaminQuestionType(childExaminQuestionType);
					}
				}
				examinQuestionType.setStatus(0);
				plantManageService.saveOrUpdateExaminQuestionType(examinQuestionType);
				result = "success";
			} catch (Exception e) {
				e.printStackTrace();
				result = "failure";
			}
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}
	
	/**
	 * 新建问题 
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionAddInput() throws Exception{
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionTypeOfSec();
		request.setAttribute("examinQuestionTypeList", examinQuestionTypeList);
		return "examinQuestionAddInput";
	}
	
	public String examinQuestionAddConfirm() throws Exception {
		PrintWriter out = response.getWriter();
		ExaminQuestion examinQuestion = new ExaminQuestion();
		//问题
		String examinQuestions = request.getParameter("fileName");
		examinQuestion.setQuestion(examinQuestions);
		//答案
		String answer = request.getParameter("answer");
		examinQuestion.setAnswer(answer);
		//答案A
		String chooseA = request.getParameter("chooseA");
		examinQuestion.setChooseA(chooseA);
		//答案B
		String chooseB = request.getParameter("chooseB");
		examinQuestion.setChooseB(chooseB);
		//答案C
		String chooseC = request.getParameter("chooseC");
		examinQuestion.setChooseC(chooseC);
		//答案D
		String chooseD = request.getParameter("chooseD");
		examinQuestion.setChooseD(chooseD);
		//问题专业
		String type = request.getParameter("type");
		DictProTeam dictProTeam = plantManageService.listDictProtemById(Long.parseLong(type));
		examinQuestion.setDictProTeam(dictProTeam);
		//上传人
		String uploaderId = request.getParameter("uploaderId");
		UsersPrivs user = usersPrivsService.getUsersPrivsById(Long.parseLong(uploaderId));
		examinQuestion.setUploader(user);
		//上传时间 
		examinQuestion.setUploadtime(YMDHMS_SDFORMAT.format(new Date()));
		try {
			plantManageService.saveOrUpdateExaminQuestion(examinQuestion);
			out.write("success");
		} catch (Exception e) {
			out.write("failure");
			e.printStackTrace();
			
		}finally{
			if(null != out){
				out.close();
			}
		}
		return null;
	}
    
    /**
	 * 删除问题
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionDelete() throws Exception{
		String result = "";
		String examinQuestionIdArray[] = request.getParameter("examinQuestions").split(",");
		for (int i = 0; i < examinQuestionIdArray.length; i++) {
			ExaminQuestion examinQuestion = plantManageService.listExaminQuestionById(Long.parseLong(examinQuestionIdArray[i]));
			try {
				plantManageService.deleteExaminQuestion(examinQuestion);
				result = "success";
			} catch (Exception e) {
				result = "failure";
				e.printStackTrace();
			}
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}
	
	/**
	 * 编辑问题 
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionEditInput() throws Exception{
		String id = request.getParameter("id");
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionTypeOfSec();
		ExaminQuestion examinQuestion = plantManageService.listExaminQuestionById(Long.parseLong(id));
		request.setAttribute("examinQuestionTypeList", examinQuestionTypeList);
		request.setAttribute("examinQuestion", examinQuestion);
		return "examinQuestionEditInput";
	}
	
	public String examinQuestionEditConfirm() throws Exception{
		PrintWriter out = response.getWriter();
		//ID
		String id = request.getParameter("questionId");
		ExaminQuestion examinQuestion = plantManageService.listExaminQuestionById(Long.parseLong(id));
		//问题
		String examinQuestions = request.getParameter("examinQuestion");
		examinQuestion.setQuestion(examinQuestions);
		//答案
		String answer = request.getParameter("answer");
		examinQuestion.setAnswer(answer);
		//答案A
		String chooseA = request.getParameter("chooseA");
		examinQuestion.setChooseA(chooseA);
		//答案B
		String chooseB = request.getParameter("chooseB");
		examinQuestion.setChooseB(chooseB);
		//答案C
		String chooseC = request.getParameter("chooseC");
		examinQuestion.setChooseC(chooseC);
		//答案D
		String chooseD = request.getParameter("chooseD");
		examinQuestion.setChooseD(chooseD);
		//问题专业
		String type = request.getParameter("type");
		DictProTeam dictProTeam = plantManageService.listDictProtemById(Long.parseLong(type));
		examinQuestion.setDictProTeam(dictProTeam);
		//编辑人
		String uploaderId = request.getParameter("uploaderId");
		UsersPrivs user = usersPrivsService.getUsersPrivsById(Long.parseLong(uploaderId));
		examinQuestion.setUploader(user);
		//编辑时间 
		examinQuestion.setUploadtime(YMDHMS_SDFORMAT.format(new Date()));
		try {
			plantManageService.saveOrUpdateExaminQuestion(examinQuestion);
			out.write("success");
		} catch (Exception e) {
			out.write("failure");
			e.printStackTrace();
			
		}finally{
			if(null != out){
				out.close();
			}
		}
		return null;
	}
	
	/**
	 * 分类显示
	 * @return
	 * @throws Exception
	 */
	public String examinQuestionOfType() throws Exception{
		PageModel<ExaminQuestion> examinQuestionPm  = plantManageService.listExaminQuestion(type, examinQuestions, uploader, dateStart, dateEnd, examiner);
		request.setAttribute("examinQuestionPm", examinQuestionPm);
		return "examinQuestionOfType";
	}
	
	/**
	 * 按班组取题
	 * @return
	 * @throws JSONException 
	 * @throws IOException 
	 */
	public String ajaxExaminQuestionList() throws Exception{ 
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		UsersPrivs user = (UsersPrivs) ServletActionContext.getContext().getSession().get("session_user");
		boolean flag = true;
		String minutes = "";
		String secondes = "";
		//题库专业
		Long type = user.getBzid();
		if(type != null){
			Cookie[] cookies = request.getCookies();
			if(cookies.length != 0){
				for(Cookie cookie : cookies){ 
				    String name = cookie.getName();
				    if(name.equals(user.getUserid()+"m") || name.equals(user.getUserid()+"s")){
				    	flag = false;
				    	minutes = PropertyUtil.getResourceByKey("examintime");
				    	secondes = "0";
				    }
				} 
			}
			if(flag){
				//设置答题时间
				Cookie cookieM = new Cookie(user.getUserid() +"m","45"); 
				Cookie cookieS = new Cookie(user.getUserid() +"s","0"); 
				cookieM.setMaxAge(1000*60); 
				cookieS.setMaxAge(1000*60); 
				cookieM.setPath("/"); 
				cookieS.setPath("/"); 
				ServletActionContext.getResponse().addCookie(cookieM); 
				ServletActionContext.getResponse().addCookie(cookieS); 
			}
			//生成初始答题记录
			JSONObject idAndAnswerObj = new JSONObject();
			JSONObject tempObj = null;
			List<ExaminQuestion> examinQuestionList = plantManageService.listQuestionsPager(type, page_Next, page_Size);
			int page_RowCount=plantManageService.listQuestionsByType(type);
			for(int i=0; i<examinQuestionList.size(); i++){
				tempObj = new JSONObject();
				tempObj.put("id", ""+examinQuestionList.get(i).getId()+"");
				tempObj.put("order", ""+(i+1)+"");
				tempObj.put("answer", "false");
				idAndAnswerObj.put(""+(i+1)+"", tempObj);
			}
			JSONObject examinObj = null;
			//封装Json字符串
			JSONArray examinArray = new JSONArray();
			if(examinQuestionList.size() > 0){
				ExaminQuestion examinQiestion = examinQuestionList.get(0);
				examinObj = new JSONObject();
				//ID
				examinObj.put("id", examinQiestion.getId());
				//题目
				examinObj.put("question", examinQiestion.getQuestion());
				//正确答案  
				examinObj.put("answer", examinQiestion.getAnswer());
				//答案A
				examinObj.put("chooseA", examinQiestion.getChooseA());
				//答案B
				examinObj.put("chooseB", examinQiestion.getChooseB());
				//答案C
				examinObj.put("chooseC", examinQiestion.getChooseC());
				//答案D
				examinObj.put("chooseD", examinQiestion.getChooseD());
				examinArray.put(examinObj);
			}
			JSONObject object = new JSONObject();
			object.put("datas", examinArray);
			object.put("type", type);
			object.put("pageNext", page_Next);
			object.put("pageFirst", page_First);
			object.put("rowCount", page_RowCount);
			object.put("initAnswer", idAndAnswerObj);
			object.put("userId", user.getUserid());
			object.put("minutes", minutes);
			object.put("secondes", secondes);
			out.write(object.toString());
		}else{
			out.write("");
		}
		return null;
	}
	
	/**
	 * 考试错题
	 * @return
	 * @throws Exception
	 */
	public String ajaxWorngExamin() throws Exception{
		String examinId = request.getParameter("id");
		JSONArray examinArray = new JSONArray();
		JSONObject examinObj = new JSONObject();
		ExaminQuestion examinQuestion = plantManageService.listExaminQuestionById(Long.parseLong(examinId));
		//ID
		examinObj.put("id", examinQuestion.getId());
		//题目
		examinObj.put("question", examinQuestion.getQuestion());
		//正确答案
		examinObj.put("answer", examinQuestion.getAnswer());
		//答案A
		examinObj.put("chooseA", examinQuestion.getChooseA());
		//答案B
		examinObj.put("chooseB", examinQuestion.getChooseB());
		//答案C
		examinObj.put("chooseC", examinQuestion.getChooseC());
		//答案D
		examinObj.put("chooseD", examinQuestion.getChooseD());
		examinArray.put(examinObj);
		JSONObject object = new JSONObject();
		object.put("datas", examinArray);
		response.getWriter().write(object.toString());
		return null;
	}
	
	/**
	 * 考试交卷
	 * @return
	 * @throws JSONException 
	 * @throws IOException 
	 */
	@SuppressWarnings("unchecked")
	public String ajaxExaminOver() throws Exception{ 
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String initAnswer = request.getParameter("initAnswer");
		String rowCount = request.getParameter("rowCount");
		JSONObject initAnswerObj = new JSONObject(initAnswer);
		Map<Double, List<Map<Long, Integer>>> resultMap = plantManageService.saveExaminOver(rowCount, initAnswerObj);
		NumberFormat fmt = NumberFormat.getPercentInstance();
		fmt.setMinimumFractionDigits(2);
		Double correctPoints = null;
		for (Iterator iterator = resultMap.keySet().iterator(); iterator.hasNext();) {
			correctPoints = (Double) iterator.next();
		}
		JSONArray wrongExaminArray = new JSONArray();
		JSONObject wrongExaminObj = null;
		List<Map<Long, Integer>> wrongExaminIdList = resultMap.get(correctPoints);
		for (Map<Long, Integer> map : wrongExaminIdList) {
			for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
				Long examinId = (Long) iterator.next();
				wrongExaminObj = new JSONObject();
				wrongExaminObj.put("id", examinId);
				wrongExaminObj.put("value", map.get(examinId));
				wrongExaminArray.put(wrongExaminObj);
			}
		}
		JSONObject object = new JSONObject();
		object.put("points", fmt.format(correctPoints));
		object.put("examins", wrongExaminArray);
		out.write(object.toString());
		return null;
	}
	
	/**
	 * 考试专业查询
	 * @return
	 * @throws Exception
	 */
	public String listExaminRecType() throws Exception{
		List<ExaminQuestionType> examinQuestionTypeList = plantManageService.listExaminQuestionType();
		//封装MAP
		Map<ExaminQuestionType, List<ExaminQuestionType>> examinQuestionTypeMap = new LinkedHashMap<ExaminQuestionType, List<ExaminQuestionType>>();
		ExaminQuestionType tempExaminQuestionType = null;
		List<ExaminQuestionType> childExaminQuestionTypeList = null; 
		for(int i = 0; i <= examinQuestionTypeList.size()-1; i++){
			tempExaminQuestionType = examinQuestionTypeList.get(i);
			if(tempExaminQuestionType.getParentType() == null || tempExaminQuestionType.getParentType().getId() == 0){
				if(examinQuestionTypeMap.get(tempExaminQuestionType) == null){
					childExaminQuestionTypeList = plantManageService.listExaminQuestionTypeByPID(tempExaminQuestionType.getId());
					examinQuestionTypeMap.put(tempExaminQuestionType, childExaminQuestionTypeList);
				}
			}
		}
		request.setAttribute("examinQuestionTypeMap", examinQuestionTypeMap);
		return "listExaminRecType";
	}
	
	/**
	 * 考试记录查询
	 * @return
	 * @throws Exception
	 */
	public String listExaminRec() throws Exception{
		PageModel<ExaminRec> examinRecPm  = plantManageService.listExaminRec(eaxminer, major, dateStart, dateEnd);
		request.setAttribute("examinRecPm", examinRecPm);
		return "listExaminRec";
	}
	
	/**
	 * 用户错题查询
	 * @return
	 * @throws Exception
	 */
	public String ajaxUserExaminQuestionList() throws Exception{
		UsersPrivs user = (UsersPrivs) ServletActionContext.getContext().getSession().get("session_user");
		//从Cookie中取出错题集ID
		Cookie[] cookies = request.getCookies();
		String examinQuestionId[] = {};
		for(Cookie cookie : cookies){ 
		    String userId = cookie.getName();
		    if(user.getUserid().toString().equals(userId)){
		    	examinQuestionId = cookie.getValue().split(",");
		    }
		} 
		if(examinQuestionId.length >0){
			ExaminQuestion examinQuestion = plantManageService.listExaminQuestionById(Long.parseLong(examinQuestionId[1]));
			JSONArray examinArray = new JSONArray();
			for (int i = 1; i < examinQuestionId.length; i++) {
				examinArray.put(examinQuestionId[i]);
			}
			JSONObject examinObj = new JSONObject();
			//ID
			examinObj.put("id", examinQuestion.getId());
			//题目
			examinObj.put("question", examinQuestion.getQuestion());
			//正确答案
			examinObj.put("answer", examinQuestion.getAnswer());
			//答案A
			examinObj.put("chooseA", examinQuestion.getChooseA());
			//答案B
			examinObj.put("chooseB", examinQuestion.getChooseB());
			//答案C
			examinObj.put("chooseC", examinQuestion.getChooseC());
			//答案D
			examinObj.put("chooseD", examinQuestion.getChooseD());
			JSONObject object = new JSONObject();
			object.put("datas", examinArray);
			object.put("firstExamin", examinObj);
			response.getWriter().write(object.toString());
		}else{
			response.getWriter().write("");
		}
		return null;
	}
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	public String getExaminQuestions() {
		return examinQuestions;
	}

	public void setExaminQuestions(String examinQuestions) {
		this.examinQuestions = examinQuestions;
	}

	public String getUploader() {
		return uploader;
	}

	public void setUploader(String uploader) {
		this.uploader = uploader;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

	public String getExaminer() {
		return examiner;
	}

	public void setExaminer(String examiner) {
		this.examiner = examiner;
	}

	public ExaminQuestionType getExaminQuestionType() {
		return examinQuestionType;
	}

	public void setExaminQuestionType(ExaminQuestionType examinQuestionType) {
		this.examinQuestionType = examinQuestionType;
	}

	public ExaminQuestion getExaminQuestion() {
		return examinQuestion;
	}

	public void setExaminQuestion(ExaminQuestion examinQuestion) {
		this.examinQuestion = examinQuestion;
	}
	public String getEaxminer() {
		return eaxminer;
	}

	public void setEaxminer(String eaxminer) {
		this.eaxminer = eaxminer;
	}
	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public int getPage_First() {
		return page_First;
	}

	public void setPage_First(int pageFirst) {
		page_First = pageFirst;
	}

	public int getPage_Next() {
		return page_Next;
	}

	public void setPage_Next(int pageNext) {
		page_Next = pageNext;
	}
	
}
