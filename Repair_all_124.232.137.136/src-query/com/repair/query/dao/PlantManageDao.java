package com.repair.query.dao;

import java.util.List;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.Document;
import com.repair.common.pojo.DocumentType;
import com.repair.common.pojo.ExaminQuestion;
import com.repair.common.pojo.ExaminQuestionType;
import com.repair.common.pojo.ExaminRec;
import com.repair.common.pojo.Question;
import com.repair.common.pojo.QuestionType;
import com.repair.common.util.Page;
import com.repair.common.util.PageModel;


/**
 * 
 * 车间管理
 * @author eleven
 *
 */
public interface PlantManageDao {

	public List<DocumentType> listDocumentType(String modelType);
	
	public DocumentType listDocumentTypeById(Long id);
	
	public List<DocumentType> listDocumentTypeOfTop(String modelType);
	
	public List<DocumentType> listDocumentTypeOfSec(String modelType);
	
	public List<DocumentType> listDocumentTypeByPID(Long pid, String modelType);
	
	public PageModel<Document> listDocument(String type, String name, String uploader, String dateStart, String dateEnd, String examiner, String description, String modelType);
	
	public void saveOrUpdateDocumentType(DocumentType documentType);
	
	public void deleteDocumentType(DocumentType documentType);
	
	public void saveOrUpdateDocument(Document document);

	public Document listDocumentById(Long id);
	
	public void deleteDocument(Document document);
	
	
	public List<QuestionType> listQuestionType();
	
	public QuestionType listQuestionTypeById(Long id);
	
	public Question listQuestionById(Long id);
	
	public List<QuestionType> listQuestionTypeOfTop();
	
	public List<QuestionType> listQuestionTypeOfSec();
	
	public List<QuestionType> listQuestionTypeByPID(Long pid);
	
	public PageModel<Question> listQuestion(String type, String questions, String uploader, String dateStart, String dateEnd, String examiner);
	
	public void saveOrUpdateQuestionType(QuestionType questionType);
	
	public void deleteQuestionType(QuestionType questionType);
	
	public void saveOrUpdateQuestion(Question question);
	
	public void deleteQuestion(Question question);
	
	
	public List<ExaminQuestionType> listExaminQuestionType();
	
	public ExaminQuestionType listExaminQuestionTypeById(Long id);
	
	public ExaminQuestion listExaminQuestionById(Long id);
	
	public List<ExaminQuestionType> listExaminQuestionTypeOfTop();
	
	public List<ExaminQuestionType> listExaminQuestionTypeOfSec();
	
	public List<ExaminQuestionType> listExaminQuestionTypeByPID(Long pid);
	
	public PageModel<ExaminQuestion> listExaminQuestion(String type, String examinQuestions, String uploader, String dateStart, String dateEnd, String examiner);
	
	public void saveOrUpdateExaminQuestionType(ExaminQuestionType examinQuestionType);
	
	public void deleteExaminQuestionType(ExaminQuestionType examinQuestionType);
	
	public void saveOrUpdateExaminQuestion(ExaminQuestion examinQuestion);
	
	public void deleteExaminQuestion(ExaminQuestion examinQuestion);
	
	public Integer listQuestionsByType(Long type);
	
	public List<ExaminQuestion> listQuestionsPager(Long type, Integer page_Next, Integer page_Size);
	
	public List<ExaminQuestion> listQuestionsPagerById(Long id,Page page);
	
	public void saveOrUpdateExaminRec(ExaminRec examinRec);
	
	public PageModel<ExaminRec> listExaminRec(String eaxminer, String major, String dateStart, String dateEnd);
	
	public List<DictFirstUnit> listFirstUnitNameOfDictFailure();
	
	public DictFirstUnit listFirstUnitById(Long id);
	
	public List<ExaminQuestion> listQuestionByType(Long type);
	
	public List<DictProTeam> listDictProtem();
	
	public DictProTeam listDictProtemById(Long id);
	
	
}
