package com.repair.query.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.Document;
import com.repair.common.pojo.DocumentType;
import com.repair.common.pojo.ExaminQuestion;
import com.repair.common.pojo.ExaminQuestionType;
import com.repair.common.pojo.ExaminRec;
import com.repair.common.pojo.Question;
import com.repair.common.pojo.QuestionType;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Page;
import com.repair.common.util.PageModel;
import com.repair.common.util.PropertyUtil;
import com.repair.query.dao.PlantManageDao;
import com.repair.common.util.Contains;

public class PlantManageDaoImpl extends AbstractDao implements PlantManageDao{
	
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");

	@SuppressWarnings("unchecked")
	@Override
	public List<DocumentType> listDocumentType(String modelType) {
		String hql = "from DocumentType t where t.status >0 and t.modelType=? ";
		return this.getHibernateTemplate().find(hql, new Object[]{modelType});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DocumentType> listDocumentTypeOfTop(String modelType) {
		String hql = "from DocumentType t where t.parentType.id = ? and t.status > 0 and t.modelType=?";
		return this.getHibernateTemplate().find(hql, new Object[]{Long.parseLong("0"), modelType});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DocumentType> listDocumentTypeOfSec(String modelType) {
		//String hql = "from DocumentType t where t.parentType.id != ? and t.status >0 and t.modelType=?";
		String hql = "from DocumentType t where t.status >0 and t.modelType=?";
		return this.getHibernateTemplate().find(hql, new Object[]{modelType});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DocumentType> listDocumentTypeByPID(Long pid, String modelType) {
		StringBuilder hql = new StringBuilder();
		List param = new ArrayList();
		hql.append("from DocumentType t where 1=1");
		if(pid != null){
			hql.append(" and t.parentType.id=? ");
			param.add(pid);
		}
		if(StringUtils.isNotEmpty(modelType)){
			hql.append(" and t.modelType=?");
			param.add(modelType);
		}
		hql.append(" and t.status > 0");
		return this.getHibernateTemplate().find(hql.toString(), param.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<Document> listDocument(String type, String name, String uploader, String dateStart, String dateEnd, String examiner, String description, String modelType) {
		StringBuilder builder = new StringBuilder();
		builder.append("from Document t where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(name != null && !name.equals("")){
			builder.append(" and t.name like '%"+ name +"%'");
		}
		if(uploader != null && !uploader.equals("")){
			builder.append(" and t.uploader.xm like '%"+ uploader +"%'");
		}
		if(examiner != null && !examiner.equals("")){
			builder.append(" and t.examiner.xm like '%"+ examiner +"%'");
		}
		if(description != null && !description.equals("")){
			builder.append(" and t.description like '%"+ description +"%'");
		}
		if(type != null && !"".equals(type)){
			builder.append(" and t.type.id =? or t.type.parentType.id=?");
			params.add(Long.parseLong(type));
			params.add(Long.parseLong(type));
		}
		if(modelType != null && !"".equals(modelType)){
			builder.append(" and t.type.modelType =?");
			params.add(modelType);
		}else{
			builder.append(" and t.type.id >=?");
			params.add(Long.parseLong("0"));
		}
		builder.append(" order by t.id desc");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void saveOrUpdateDocumentType(DocumentType documentType) {
		this.getHibernateTemplate().saveOrUpdate(documentType);
	}

	@Override
	public DocumentType listDocumentTypeById(Long id) {
		return this.getHibernateTemplate().get(DocumentType.class, id);
	}

	@Override
	public void deleteDocumentType(DocumentType documentType) {
		this.getHibernateTemplate().delete(documentType);
	}

	@Override
	public void saveOrUpdateDocument(Document document) {
		this.getHibernateTemplate().saveOrUpdate(document);
	}

	@Override
	public Document listDocumentById(Long id) {
		return this.getHibernateTemplate().get(Document.class, id);
	}

	@Override
	public void deleteDocument(Document document) {
		this.getHibernateTemplate().delete(document);
	}
	
	/*=========================*/
	
	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionType> listQuestionType() {
		String hql = "from QuestionType t where t.status > 0";
		return this.getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionType> listQuestionTypeOfTop() {
		String hql = "from QuestionType t where t.parentType.id = ? and t.status > 0";
		return this.getHibernateTemplate().find(hql, Long.parseLong("0"));
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionType> listQuestionTypeOfSec() {
		//String hql = "from QuestionType t where t.parentType.id != ? and t.status > 0";
		String hql = "from QuestionType t where t.status > 0";
		return this.getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionType> listQuestionTypeByPID(Long pid) {
		String hql = "from QuestionType t where t.parentType.id=? and t.status > 0";
		return this.getHibernateTemplate().find(hql, pid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<Question> listQuestion(String type, String questions, String uploader, String dateStart, String dateEnd, String examiner) {
		StringBuilder builder = new StringBuilder();
		builder.append("from Question t where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(questions != null && !questions.equals("")){
			builder.append(" and t.question like '%"+ questions +"%'");
		}
		if(uploader != null && !uploader.equals("")){
			builder.append(" and t.uploader.xm like '%"+ uploader +"%'");
		}
		if(examiner != null && !examiner.equals("")){
			builder.append(" and t.examiner.xm like '%"+ examiner +"%'");
		}
		if(type != null && !type.equals("")){
			builder.append(" and t.type.id =? or t.type.parentType.id=?");
			params.add(Long.parseLong(type));
			params.add(Long.parseLong(type));
		}else{
			builder.append(" and t.type.id >=?");
			params.add(Long.parseLong("0"));
		}
		builder.append(" order by t.id desc");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void saveOrUpdateQuestionType(QuestionType questionType) {
		this.getHibernateTemplate().saveOrUpdate(questionType);
	}

	@Override
	public QuestionType listQuestionTypeById(Long id) {
		return this.getHibernateTemplate().get(QuestionType.class, id);
	}

	@Override
	public void deleteQuestionType(QuestionType questionType) {
		this.getHibernateTemplate().delete(questionType);
	}

	@Override
	public void saveOrUpdateQuestion(Question question) {
		this.getHibernateTemplate().saveOrUpdate(question);
	}

	@Override
	public Question listQuestionById(Long id) {
		return this.getHibernateTemplate().get(Question.class, id);
	}

	@Override
	public void deleteQuestion(Question question) {
		this.getHibernateTemplate().delete(question);
	}
	
	/*=========================*/
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestionType> listExaminQuestionType() {
		String hql = "from ExaminQuestionType t where t.status > 0";
		return this.getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeOfTop() {
		String hql = "from ExaminQuestionType t where t.parentType.id = ? and t.status > 0";
		return this.getHibernateTemplate().find(hql, Long.parseLong("0"));
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeOfSec() {
		String hql = "from ExaminQuestionType t where t.status > 0";
		return this.getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestionType> listExaminQuestionTypeByPID(Long pid) {
		String hql = "from ExaminQuestionType t where t.parentType.id=? and t.status > 0";
		return this.getHibernateTemplate().find(hql, pid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<ExaminQuestion> listExaminQuestion(String type, String examinQuestions, String uploader, String dateStart, String dateEnd, String examiner) {
		StringBuilder builder = new StringBuilder();
		builder.append("from ExaminQuestion t where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.uploadtime >= '"+ dateStart +"' and t.uploadtime <= '"+ dateEnd +"'");
		}
		if(examinQuestions != null && !examinQuestions.equals("")){
			builder.append(" and t.question like '%"+ examinQuestions +"%'");
		}
		if(uploader != null && !uploader.equals("")){
			builder.append(" and t.uploader.xm like '%"+ uploader +"%'");
		}
		if(examiner != null && !examiner.equals("")){
			builder.append(" and t.examiner.xm like '%"+ examiner +"%'");
		}
		if(type != null && !type.equals("")){
			builder.append(" and t.dictProTeam.proteamid = ?");
			params.add(Long.parseLong(type));
		}else{
			builder.append(" and t.dictProTeam.proteamid >=?");
			params.add(Long.parseLong("0"));
		}
		builder.append(" order by t.id desc");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void saveOrUpdateExaminQuestionType(ExaminQuestionType examinQuestionType) {
		this.getHibernateTemplate().saveOrUpdate(examinQuestionType);
	}

	@Override
	public ExaminQuestionType listExaminQuestionTypeById(Long id) {
		return this.getHibernateTemplate().get(ExaminQuestionType.class, id);
	}

	@Override
	public void deleteExaminQuestionType (ExaminQuestionType examinQuestionType) {
		this.getHibernateTemplate().delete(examinQuestionType);
	}

	@Override
	public void saveOrUpdateExaminQuestion(ExaminQuestion examinQuestion) {
		this.getHibernateTemplate().saveOrUpdate(examinQuestion);
	}

	@Override
	public ExaminQuestion listExaminQuestionById(Long id) {
		return this.getHibernateTemplate().get(ExaminQuestion.class, id);
	}

	@Override
	public void deleteExaminQuestion(ExaminQuestion examinQuestion) {
		this.getHibernateTemplate().delete(examinQuestion);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestion> listQuestionsPager(Long type, Integer page_Next, Integer page_Size){
		Session session = this.getSession();
		//随机查询questionNum条题目
		String questionNum = PropertyUtil.getResourceByKey("questionnum");
		Query query = session.createSQLQuery(
				"select * from (select * from examin_question t where t.dictProTeam=? order by dbms_random.random)where rownum <= "+ Contains.EXAM_QUES_NUM)
				.addEntity(ExaminQuestion.class).setLong(0, type);
//		Query query = session.createSQLQuery(
//				"select * from (select * from examin_question t where t.dictProTeam=? )where rownum <= "+ questionNum +"")
//				.addEntity(ExaminQuestion.class).setLong(0, type);
		return query.list();
	}

	@Override
	public Integer listQuestionsByType(Long type) {
		Session session = this.getSession();
		//随机查询questionNum条题目
		String questionNum = PropertyUtil.getResourceByKey("questionnum");
		//Query query = session.createSQLQuery(
		//		"select * from (select * from examin_question t where t.dictProTeam=? order by dbms_random.random)where rownum <= "+ questionNum +"")
		//		.addEntity(ExaminQuestion.class).setLong(0, type);
		Query query = session.createSQLQuery(
				"select * from (select * from examin_question t where t.dictProTeam=? )where rownum <= "+ Contains.EXAM_QUES_NUM)
			.addEntity(ExaminQuestion.class).setLong(0, type);
		return query.list().size();
	}
	 
	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestion> listQuestionsPagerById(Long id, Page page) {
		String hql = "from ExaminQuestion as t where t.id=?";
		Query query = this.getSession().createQuery(hql);
		if(null != page){
			query.setFirstResult(page.getStartRow());
			query.setMaxResults(page.getSize());
		}
		query.setLong(0, id);
		return query.list();
	}

	@Override
	public void saveOrUpdateExaminRec(ExaminRec examinRec) {
		this.getHibernateTemplate().saveOrUpdate(examinRec);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<ExaminRec> listExaminRec(String eaxminer, String major, String dateStart, String dateEnd) {
		StringBuilder builder = new StringBuilder();
		builder.append("from ExaminRec t where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.examinDate >= '"+ dateStart +"' and t.examinDate <= '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.examinDate <= '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.examinDate >= '"+ dateStart +"' and t.examinDate <= '"+ dateEnd +"'");
		}
		if(eaxminer != null && !eaxminer.equals("")){
			builder.append(" and t.examiner.xm like '%"+ eaxminer +"%'");
		}
		if(major != null && !major.equals("")){
			builder.append(" and t.type.id = ?");
			params.add(Long.parseLong(major));
		}
		builder.append(" order by t.id desc");
		return findPageModel(builder.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> listFirstUnitNameOfDictFailure() {
		return getHibernateTemplate().find("from DictFirstUnit");
	}

	@Override
	public DictFirstUnit listFirstUnitById(Long id) {
		String hql = "from DictFirstUnit t where t.id=?";
		return (DictFirstUnit) this.getSession().createQuery(hql).setLong(0, id).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ExaminQuestion> listQuestionByType(Long type) {
		String hql ="from ExaminQuestion t where t.dictProTeam.proteamid = ? order by t.id";
		List<ExaminQuestion> tempList = this.getHibernateTemplate().find(hql, type);
		return tempList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> listDictProtem() {
		return getHibernateTemplate().find("from DictProTeam t where t.workflag = 1");
	}

	@Override
	public DictProTeam listDictProtemById(Long id) {
		String hql = "from DictProTeam t where t.proteamid=?";
		return (DictProTeam) this.getSession().createQuery(hql).setLong(0, id).uniqueResult();
	}
}
