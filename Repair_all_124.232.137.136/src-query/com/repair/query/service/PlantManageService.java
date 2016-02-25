package com.repair.query.service;

import java.util.List;
import java.util.Map;

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
import com.repair.common.util.Page;
import com.repair.common.util.PageModel;


public interface PlantManageService {
	
	/**
	 * 查询所有文档类型
	 * @return
	 */
	public List<DocumentType> listDocumentType(String modelType);
	
	/**
	 * 查询文档类型
	 * @param id
	 * @return
	 */
	public DocumentType listDocumentTypeById(Long id);
	
	/**
	 * 查询文档
	 * @param id
	 * @return
	 */
	public Document listDocumentById(Long id);
	
	/**
	 * 查询所有顶层文档类型
	 * @return
	 */
	public List<DocumentType> listDocumentTypeOfTop(String modelType);
	
	/**
	 * 查询所有次层文档类型
	 * @return
	 */
	public List<DocumentType> listDocumentTypeOfSec(String modelType);
	
	/**
	 * 根据父类文档ID查询所有子类文档
	 * @param pid 父类文档ID
	 * @return
	 */
	public List<DocumentType> listDocumentTypeByPID(Long pid, String modelType);
	
	/**
	 * 查询所有的文档 
	 * @param document
	 * @return
	 */
	public PageModel<Document> listDocument(String type, String name, String uploader, String dateStart, String dateEnd, String examiner, String description, String modelType);
	
	/**
	 * 保存更新文档类型 
	 * @param documentType
	 */
	public void saveOrUpdateDocumentType(DocumentType documentType);
	
	/**
	 * 删除文档分类
	 * @param id
	 * @return
	 */
	public void deleteDocumentType(DocumentType documentType);
	
	/**
	 * 新增修改文档
	 * @param document
	 */
	public void saveOrUpdateDocument(Document document);
	
	/**
	 * 删除文档
	 * @param document
	 */
	public void deleteDocument(Document document);
	
	
	/*=======================================*/
	
	/**
	 * 查询所有问题类型
	 * @return
	 */
	public List<QuestionType> listQuestionType();
	
	/**
	 * 查询问题类型
	 * @param id
	 * @return
	 */
	public QuestionType listQuestionTypeById(Long id);
	
	/**
	 * 查询问题
	 * @param id
	 * @return
	 */
	public Question listQuestionById(Long id);
	
	/**
	 * 查询所有顶层问题类型
	 * @return
	 */
	public List<QuestionType> listQuestionTypeOfTop();
	
	/**
	 * 查询所有次层问题类型
	 * @return
	 */
	public List<QuestionType> listQuestionTypeOfSec();
	
	/**
	 * 根据父类问题ID查询所有子类问题
	 * @param pid 父类问题ID
	 * @return
	 */
	public List<QuestionType> listQuestionTypeByPID(Long pid);
	
	/**
	 * 查询所有的问题 
	 * @param question
	 * @return
	 */
	public PageModel<Question> listQuestion(String type, String questions, String uploader, String dateStart, String dateEnd, String examiner);
	
	/**
	 * 保存更新问题类型 
	 * @param questionType
	 */
	public void saveOrUpdateQuestionType(QuestionType questionType);
	
	/**
	 * 删除问题分类
	 * @param questionType
	 * @return
	 */
	public void deleteQuestionType(QuestionType questionType);
	
	/**
	 * 新增修改问题
	 * @param question
	 */
	public void saveOrUpdateQuestion(Question question);
	
	/**
	 * 删除问题
	 * @param question
	 */
	public void deleteQuestion(Question question);
	
	
	/*=======================================*/
	
	/**
	 * 查询所有问题类型
	 * @return
	 */
	public List<ExaminQuestionType> listExaminQuestionType();
	
	/**
	 * 查询问题类型
	 * @param id
	 * @return
	 */
	public ExaminQuestionType listExaminQuestionTypeById(Long id);
	
	/**
	 * 查询问题
	 * @param id
	 * @return
	 */
	public ExaminQuestion listExaminQuestionById(Long id);
	
	/**
	 * 查询所有顶层问题类型
	 * @return
	 */
	public List<ExaminQuestionType> listExaminQuestionTypeOfTop();
	
	/**
	 * 查询所有次层问题类型
	 * @return
	 */
	public List<ExaminQuestionType> listExaminQuestionTypeOfSec();
	
	/**
	 * 根据父类问题ID查询所有子类问题
	 * @param pid 父类问题ID
	 * @return
	 */
	public List<ExaminQuestionType> listExaminQuestionTypeByPID(Long pid);
	
	/**
	 * 查询所有的问题 
	 * @param question
	 * @return
	 */
	public PageModel<ExaminQuestion> listExaminQuestion(String type, String questions, String uploader, String dateStart, String dateEnd, String examiner);
	
	/**
	 * 保存更新问题类型 
	 * @param ExaminQuestionType
	 */
	public void saveOrUpdateExaminQuestionType(ExaminQuestionType examinQuestionType);
	
	/**
	 * 删除问题分类
	 * @param ExaminQuestionType
	 * @return
	 */
	public void deleteExaminQuestionType(ExaminQuestionType examinQuestionType);
	
	/**
	 * 新增修改问题
	 * @param question
	 */
	public void saveOrUpdateExaminQuestion(ExaminQuestion examinQuestion);
	
	/**
	 * 删除问题
	 * @param question
	 */
	public void deleteExaminQuestion(ExaminQuestion examinQuestion);
	
	/**
	 * 题库总数
	 */
	public Integer listQuestionsByType(Long type);
	
	/**
	 * 所有题库
	 * @param type
	 */
	public List<ExaminQuestion> listQuestionByType(Long type);
	/**
	 * 题库分页
	 * @return
	 */
	public List<ExaminQuestion> listQuestionsPager(Long type, Integer page_Next, Integer page_Size);
	
	/**
	 * 题库分页
	 * @param ID
	 * @return
	 */
	public List<ExaminQuestion> listQuestionsPagerById(Long id, Page page);
	
	/**
	 * 交卷
	 * @return
	 * @throws Exception 
	 */
	public Map<Double, List<Map<Long, Integer>>> saveExaminOver(String rowCount, JSONObject obj) throws Exception;
	
	/**
	 * 查询所有考试记录
	 * @param examinrec
	 * @return
	 */
	public PageModel<ExaminRec> listExaminRec(String eaxminer, String major, String dateStart, String dateEnd);
	
	/**
	 * 查询所有专业
	 */
	public List<DictFirstUnit> listFirstUnitNameOfDictFailure();
	
	/**
	 * 查询专业
	 * @param id
	 */
	public DictFirstUnit listFirstUnitById(Long id);
	
	/**
	 * 查询所有的工作班组
	 */
	public List<DictProTeam> listDictProtem();
	
	/**
	 * 查询班组
	 * @param id
	 */
	public DictProTeam listDictProtemById(Long id);

	
}
	