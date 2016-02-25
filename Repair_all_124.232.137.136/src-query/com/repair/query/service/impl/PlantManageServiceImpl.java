package com.repair.query.service.impl;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.Document;
import com.repair.common.pojo.DocumentType;
import com.repair.common.pojo.ExaminQuestion;
import com.repair.common.pojo.ExaminQuestionType;
import com.repair.common.pojo.ExaminRec;
import com.repair.common.pojo.Question;
import com.repair.common.pojo.QuestionType;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Page;
import com.repair.common.util.PageModel;
import com.repair.query.dao.PlantManageDao;
import com.repair.query.service.PlantManageService;

public class PlantManageServiceImpl implements PlantManageService{
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Resource(name = "plantManageDao")
	private PlantManageDao plantManageDao;
	
	@Override
	public List<DocumentType> listDocumentType(String modelType) {
		return plantManageDao.listDocumentType(modelType);
	}
	
	@Override
	public List<DocumentType> listDocumentTypeOfTop(String modelType) {
		return plantManageDao.listDocumentTypeOfTop(modelType);
	}

	@Override
	public List<DocumentType> listDocumentTypeByPID(Long pid, String modelType) {
		return plantManageDao.listDocumentTypeByPID(pid, modelType);
	}

	@Override
	public PageModel<Document> listDocument(String type, String name, String uploader, String dateStart, String dateEnd, String examiner, String description, String modelType) {
		return plantManageDao.listDocument(type, name, uploader, dateStart, dateEnd, examiner, description, modelType);
	}

	@Override
	public void saveOrUpdateDocumentType(DocumentType documentType) {
		plantManageDao.saveOrUpdateDocumentType(documentType);
	}

	@Override
	public DocumentType listDocumentTypeById(Long id) {
		return plantManageDao.listDocumentTypeById(id);
	}

	@Override
	public void deleteDocumentType(DocumentType documentType) {
		plantManageDao.deleteDocumentType(documentType);
	}

	@Override
	public void saveOrUpdateDocument(Document document) {
		plantManageDao.saveOrUpdateDocument(document);
	}

	@Override
	public Document listDocumentById(Long id) {
		return plantManageDao.listDocumentById(id);
	}

	@Override
	public void deleteDocument(Document document) {
		plantManageDao.deleteDocument(document);
	}

	@Override
	public List<DocumentType> listDocumentTypeOfSec(String modelType) {
		return plantManageDao.listDocumentTypeOfSec(modelType);
	}
	
	
	/*===============================*/
	@Override
	public List<QuestionType> listQuestionType() {
		return plantManageDao.listQuestionType();
	}
	
	@Override
	public List<QuestionType> listQuestionTypeOfTop() {
		return plantManageDao.listQuestionTypeOfTop();
	}

	@Override
	public List<QuestionType> listQuestionTypeByPID(Long pid) {
		return plantManageDao.listQuestionTypeByPID(pid);
	}

	@Override
	public PageModel<Question> listQuestion(String type, String questions, String uploader, String dateStart, String dateEnd, String examiner) {
		return plantManageDao.listQuestion(type, questions, uploader, dateStart, dateEnd, examiner);
	}

	@Override
	public void saveOrUpdateQuestionType(QuestionType questionType) {
		plantManageDao.saveOrUpdateQuestionType(questionType);
	}

	@Override
	public QuestionType listQuestionTypeById(Long id) {
		return plantManageDao.listQuestionTypeById(id);
	}

	@Override
	public void deleteQuestionType(QuestionType questionType) {
		plantManageDao.deleteQuestionType(questionType);
	}

	@Override
	public void saveOrUpdateQuestion(Question question) {
		plantManageDao.saveOrUpdateQuestion(question);
	}

	@Override
	public Question listQuestionById(Long id) {
		return plantManageDao.listQuestionById(id);
	}

	@Override
	public void deleteQuestion(Question question) {
		plantManageDao.deleteQuestion(question);
	}

	@Override
	public List<QuestionType> listQuestionTypeOfSec() {
		return plantManageDao.listQuestionTypeOfSec();
	}
	
	/*===============================*/
	@Override
	public List<ExaminQuestionType> listExaminQuestionType() {
		return plantManageDao.listExaminQuestionType();
	}
	
	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeOfTop() {
		return plantManageDao.listExaminQuestionTypeOfTop();
	}

	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeByPID(Long pid) {
		return plantManageDao.listExaminQuestionTypeByPID(pid);
	}

	@Override
	public PageModel<ExaminQuestion> listExaminQuestion(String type, String examinQuestions, String uploader, String dateStart, String dateEnd, String examiner) {
		return plantManageDao.listExaminQuestion(type, examinQuestions, uploader, dateStart, dateEnd, examiner);
	}

	@Override
	public void saveOrUpdateExaminQuestionType(ExaminQuestionType examinQuestionType) {
		plantManageDao.saveOrUpdateExaminQuestionType(examinQuestionType);
	}

	@Override
	public ExaminQuestionType listExaminQuestionTypeById(Long id) {
		return plantManageDao.listExaminQuestionTypeById(id);
	}

	@Override
	public void deleteExaminQuestionType(ExaminQuestionType examinQuestionType) {
		plantManageDao.deleteExaminQuestionType(examinQuestionType);
	}

	@Override
	public void saveOrUpdateExaminQuestion(ExaminQuestion examinQuestion) {
		plantManageDao.saveOrUpdateExaminQuestion(examinQuestion);
	}

	@Override
	public ExaminQuestion listExaminQuestionById(Long id) {
		return plantManageDao.listExaminQuestionById(id);
	}

	@Override
	public void deleteExaminQuestion(ExaminQuestion examinQuestion) {
		plantManageDao.deleteExaminQuestion(examinQuestion);
	}

	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeOfSec() {
		return plantManageDao.listExaminQuestionTypeOfSec();
	}

	@Override
	public List<ExaminQuestion> listQuestionsPager(Long type, Integer page_Next, Integer page_Size) {
		return plantManageDao.listQuestionsPager(type, page_Next, page_Size);
	}

	@Override
	public Integer listQuestionsByType(Long type) {
		return plantManageDao.listQuestionsByType(type);
	}

	@Override
	public Map<Double, List<Map<Long, Integer>>> saveExaminOver(String rowCount, JSONObject obj) throws Exception{
		NumberFormat fmt = NumberFormat.getPercentInstance();
		fmt.setMinimumFractionDigits(2);
		//正确率
		Double currectPoints = 0.0D;	
		//答对题数
		Double rightNum = 0.0D;
		Map<Double, List<Map<Long, Integer>>> resltMap = new LinkedHashMap<Double, List<Map<Long, Integer>>>();
		List<Map<Long, Integer>> wrongItemIdList = new ArrayList<Map<Long, Integer>>();
		String wrongString = "";
		Map<Long, Integer> map = null;
		String questionId = "";
		String answer = "";
		String answerDb = "";
		String order = "";
		JSONObject tempObj = null;
		String tempObjString = "";
		for(int i=1; i<= Integer.parseInt(rowCount); i++ ){
			order = ""+ i +"";
			tempObjString = obj.getString(order);
			tempObj = new JSONObject(tempObjString);
			questionId = tempObj.getString("id");
			map = new LinkedHashMap<Long, Integer>();
			ExaminQuestion examinQuestion = null;
			answer= tempObj.getString("answer");
			examinQuestion = plantManageDao.listExaminQuestionById(Long.parseLong(questionId));
			if(examinQuestion !=null){
				answerDb = examinQuestion.getAnswer();
			}else{
				answerDb = "testDB";
			}
			if(answer.equals(answerDb)){
				rightNum = rightNum + 1.0D;
				map.put(Long.parseLong(questionId), 1);
			}else{
				wrongString += "," + questionId;
				map.put(Long.parseLong(questionId), 0);
			}
			wrongItemIdList.add(map);
		}
		currectPoints = rightNum/Double.parseDouble(rowCount);
		resltMap.put(currectPoints, wrongItemIdList);
		UsersPrivs user = (UsersPrivs) ServletActionContext.getContext().getSession().get("session_user");
		//产生记录
		ExaminRec examinRec = new ExaminRec();
		examinRec.setExaminDate(YMDHMS_SDFORMAT.format(new Date()));
		examinRec.setCurrectPoints(fmt.format(currectPoints));
		examinRec.setExaminer(user);
		DictProTeam dictProTeam =  plantManageDao.listDictProtemById(user.getBzid());
		examinRec.setType(dictProTeam);
		plantManageDao.saveOrUpdateExaminRec(examinRec);
		//我的错题 保存到Cookie中
		Cookie cookie = new Cookie(""+ user.getUserid() +"",wrongString); 
		cookie.setMaxAge(3600); 
		//设置路径，这个路径即该工程下都可以访问该cookie 
		cookie.setPath("/"); 
		ServletActionContext.getResponse().addCookie(cookie); 
		return resltMap;
	}

	@Override
	public List<ExaminQuestion> listQuestionsPagerById(Long id,Page page) {
		return plantManageDao.listQuestionsPagerById(id, page);
	}

	@Override
	public PageModel<ExaminRec> listExaminRec(String eaxminer, String major, String dateStart, String dateEnd) {
		return plantManageDao.listExaminRec(eaxminer, major, dateStart, dateEnd);
	}

	@Override
	public List<DictFirstUnit> listFirstUnitNameOfDictFailure() {
		return plantManageDao.listFirstUnitNameOfDictFailure();
	}

	@Override
	public DictFirstUnit listFirstUnitById(Long id) {
		return plantManageDao.listFirstUnitById(id);
	}

	@Override
	public List<ExaminQuestion> listQuestionByType(Long type) {
		return plantManageDao.listQuestionByType(type);
	}

	@Override
	public List<DictProTeam> listDictProtem() {
		return plantManageDao.listDictProtem();
	}

	@Override
	public DictProTeam listDictProtemById(Long id) {
		return plantManageDao.listDictProtemById(id);
	}
}
