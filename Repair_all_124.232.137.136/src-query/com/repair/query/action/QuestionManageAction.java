/**
 * 
 */
package com.repair.query.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.Question;
import com.repair.common.pojo.QuestionType;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.query.service.PlantManageService;
import com.repair.work.service.UsersPrivsService;

/**
 * @author eleven
 *
 */
public class QuestionManageAction {
	@Resource(name = "plantManageService")
	private PlantManageService plantManageService;
	@Resource(name = "usersPrivsService")
	private UsersPrivsService usersPrivsService;
	
	//Ajax获取文件,与控件type=File中的name属性一样  
	private File fileMaterial;
	//Ajax获取文件名称,相应的name属性名称+FileName  
	private String fileMaterialFileName;
	
	//问题类型
	private String type;
	//问题
	private String questions;
	//上传人
	private String uploader;
	//开始时间
	private String dateStart;
	//结束时间
	private String dateEnd;
	//审批人
	private String examiner;
	
	private QuestionType questionType;
	private Question question;
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	// 验证字符串是否为正确路径名的正则表达式   
	// 通过 sPath.matches(matches) 方法的返回值判断是否正确   
	// sPath 为路径字符串  
	private static String matches = "[A-Za-z]:\\\\[^:?\"><*]*";
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 查询所有问题类型
	 * @return
	 * @throws Exception
	 */
	public String listQuestionType() throws Exception{
		List<QuestionType> questionTypeList = plantManageService.listQuestionType();
		//封装MAP
		Map<QuestionType, List<QuestionType>> questionTypeMap = new LinkedHashMap<QuestionType, List<QuestionType>>();
		QuestionType tempQuestionType = null;
		List<QuestionType> childQuestionTypeList = null; 
		for(int i = 0; i <= questionTypeList.size()-1; i++){
			tempQuestionType = questionTypeList.get(i);
			if(tempQuestionType.getParentType() == null || tempQuestionType.getParentType().getId() == 0){
				if(questionTypeMap.get(tempQuestionType) == null){
					childQuestionTypeList = plantManageService.listQuestionTypeByPID(tempQuestionType.getId());
					questionTypeMap.put(tempQuestionType, childQuestionTypeList);
				}
			}
		}
		request.setAttribute("questionTypeMap", questionTypeMap);
		return "listQuestionType";
	}
	
	/**
	 * 查询所有的问题
	 * @return
	 * @throws Exception
	 */
	public String listQuestion() throws Exception{
		PageModel<Question> questionPm  = plantManageService.listQuestion(type, questions, uploader, dateStart, dateEnd, examiner);
		request.setAttribute("questionPm", questionPm);
		return	"listQuestion";
	}
	
	/**
	 * 新建问题类型
	 * @return
	 * @throws Exception
	 */
	public String questionTypeAddInput() throws Exception{
		List<QuestionType> questionTypeList = plantManageService.listQuestionTypeOfTop();
		request.setAttribute("questionTypeList", questionTypeList);
		return "questionTypeAddInput";
	}
	
	public String questionTypeAdd() throws Exception{
		//初始问题类型为激活状态
		questionType.setStatus(1);
		plantManageService.saveOrUpdateQuestionType(questionType);
		return listQuestionType();
	}
	
	
	/**
	 * 编辑问题类型
	 * @return
	 * @throws Exception
	 */
	public String questionTypeEditInput() throws Exception{
		String questionTypeId = request.getParameter("id");
		QuestionType questionTypes = plantManageService.listQuestionTypeById(Long.parseLong(questionTypeId));
		List<QuestionType> questionTypeList = plantManageService.listQuestionTypeOfTop();
		request.setAttribute("questionTypes", questionTypes);
		request.setAttribute("questionTypeList", questionTypeList);
		return "questionTypeEditInput";
	}
	
	public String questionTypeEdit() throws Exception{
		plantManageService.saveOrUpdateQuestionType(questionType);
		return listQuestionType();
	}
	
	/**
	 * 删除问题类型
	 * @return
	 * @throws Exception
	 */
	public String questionTypeDelete() throws Exception{
		String result = "";
		String questionIdArray[] = request.getParameter("questionTypes").split(",");
		for (int i = 0; i < questionIdArray.length; i++) {
			QuestionType questionType = plantManageService.listQuestionTypeById(Long.parseLong(questionIdArray[i]));
			//查找该类型是否有子类型
			List<QuestionType> childQuestionTypeList = plantManageService.listQuestionTypeByPID(questionType.getId());
			try {
				if(childQuestionTypeList.size() >0 || childQuestionTypeList != null){
					for (Iterator<QuestionType> iterator = childQuestionTypeList.iterator(); iterator.hasNext();) {
						QuestionType childQuestionType = (QuestionType) iterator.next();
						childQuestionType.setStatus(0);
						plantManageService.saveOrUpdateQuestionType(childQuestionType);
					}
				}
				questionType.setStatus(0);
				plantManageService.saveOrUpdateQuestionType(questionType);
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
	public String questionAddInput() throws Exception{
		List<QuestionType> questionTypeList = plantManageService.listQuestionTypeOfSec();
		request.setAttribute("questionTypeList", questionTypeList);
		return "questionAddInput";
	}
	
	public String questionAddConfirm() throws Exception {
		PrintWriter out = response.getWriter();
		Question question = new Question();
		//问题
		String questions = request.getParameter("fileName");
		question.setQuestion(questions);
		//答案
		String answer = request.getParameter("answer");
		question.setAnswer(answer);
		//问题类型
		String type = request.getParameter("type");
		QuestionType QuestionType = plantManageService.listQuestionTypeById(Long.parseLong(type));
		question.setType(QuestionType);
		//上传人
		String uploaderId = request.getParameter("uploaderId");
		UsersPrivs user = usersPrivsService.getUsersPrivsById(Long.parseLong(uploaderId));
		question.setUploader(user);
		//上传时间 
		question.setUploadtime(YMDHMS_SDFORMAT.format(new Date()));
		//图片URL
		String imgUrl = request.getParameter("imgUrl");
		question.setImgPath(imgUrl);
		try {
			plantManageService.saveOrUpdateQuestion(question);
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
	
	
	
	/**通过Ajax上传文件
     * @return  
     * @throws IOException   
     */  
    public String ajaxUploadFile() throws IOException{  
    	HttpServletResponse response=ServletActionContext.getResponse(); 
        response.setContentType("text/plain");  
        response.setCharacterEncoding("utf-8");  
        if(fileMaterial!=null){  
            String fileName = UUID.randomUUID()+fileMaterialFileName.substring(fileMaterialFileName.indexOf("."));
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            String filePath = "questionImg" + "/" +  dateFormat.format(new Date());
            String fileRealPath=ServletActionContext.getServletContext().getRealPath(filePath);
    		File sysmfile = new File(fileRealPath);
    		if (!fileMaterial.exists()) {
    			fileMaterial.mkdirs();
    		}
            FileUtils.copyFile(fileMaterial, new File(sysmfile.getPath() + "/" + fileName));
            response.getWriter().print(filePath+"/"+fileName+","+fileMaterialFileName+",图片上传成功!");
        }else{  
            response.getWriter().print("请添加要上传的图片!");  
        }  
        return null;  
    } 
    
    
    /**
	 * 删除问题
	 * @return
	 * @throws Exception
	 */
	public String questionDelete() throws Exception{
		String result = "";
		//服务器URL
		String path = ServletActionContext.getServletContext().getRealPath("/");
		String questionIdArray[] = request.getParameter("questions").split(",");
		for (int i = 0; i < questionIdArray.length; i++) {
			Question question = plantManageService.listQuestionById(Long.parseLong(questionIdArray[i]));
			try {
				plantManageService.deleteQuestion(question);
				if((path+question.getImgPath()).matches(matches)){
					DeleteFolder(path+question.getImgPath());
				}
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
	public String questionEditInput() throws Exception{
		String id = request.getParameter("id");
		List<QuestionType> questionTypeList = plantManageService.listQuestionTypeOfSec();
		Question question = plantManageService.listQuestionById(Long.parseLong(id));
		request.setAttribute("questionTypeList", questionTypeList);
		request.setAttribute("question", question);
		return "questionEditInput";
	}
	
	public String questionEditConfirm() throws Exception{
		//服务器URL
		String path = ServletActionContext.getServletContext().getRealPath("/");
		PrintWriter out = response.getWriter();
		//ID
		String id = request.getParameter("questionId");
		Question question = plantManageService.listQuestionById(Long.parseLong(id));
		//问题
		String questions = request.getParameter("question");
		question.setQuestion(questions);
		//答案
		String answer = request.getParameter("answer");
		question.setAnswer(answer);
		//问题类型
		String type = request.getParameter("type");
		QuestionType QuestionType = plantManageService.listQuestionTypeById(Long.parseLong(type));
		question.setType(QuestionType);
		//编辑人
		String uploaderId = request.getParameter("uploaderId");
		UsersPrivs user = usersPrivsService.getUsersPrivsById(Long.parseLong(uploaderId));
		question.setUploader(user);
		//编辑时间 
		question.setUploadtime(YMDHMS_SDFORMAT.format(new Date()));
		if((path+question.getImgPath()).matches(matches)){
			DeleteFolder(path+question.getImgPath());
		}
		//图片URL
		String imgUrl = request.getParameter("imgUrl");
		question.setImgPath(imgUrl);
		try {
			plantManageService.saveOrUpdateQuestion(question);
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
	public String questionOfType() throws Exception{
		PageModel<Question> questionPm  = plantManageService.listQuestion(type, questions, uploader, dateStart, dateEnd, examiner);
		request.setAttribute("questionPm", questionPm);
		return "questionOfType";
	}
	
	/**  
	* 根据路径删除指定的目录或文件，无论存在与否  
	* @param sPath  要删除的目录或文件路径 
	* @return 删除成功返回 true，否则返回 false。  
	*/  
	public boolean DeleteFolder(String sPath) throws Exception{   
	    boolean flag = false;   
	    File file = new File(sPath);   
	    // 判断目录或文件是否存在   
	    if (!file.exists()) {  // 不存在返回 false   
	        return flag;   
	    } else {   
	        // 判断是否为文件   
	        if (file.isFile()) {  // 为文件时调用删除文件方法   
	            return deleteFile(sPath);   
	        } else {  // 为目录时调用删除目录方法   
	            return deleteDirectory(sPath);   
	        }   
	    }   
	}  

	/**  
	 * 删除单个文件  
	 * @param  sPath被删除文件的路径
	 * @return 单个文件删除成功返回true，否则返回false  
	 */  
	public boolean deleteFile(String sPath)throws Exception {   
	    boolean flag = false;   
	    File file = new File(sPath);   
	    // 路径为文件且不为空则进行删除   
	    if (file.isFile() && file.exists()) {   
	        file.delete();   
	        flag = true;   
	    }   
	    return flag;   
	}  
	
	/**  
	 * 删除目录（文件夹）以及目录下的文件  
	 * @param   sPath 被删除目录的文件路径  
	 * @return  目录删除成功返回true，否则返回false  
	 */  
	public boolean deleteDirectory(String sPath)throws Exception {   
		boolean flag = false;   
	    //如果sPath不以文件分隔符结尾，自动添加文件分隔符   
	    if (!sPath.endsWith(File.separator)) {   
	        sPath = sPath + File.separator;   
	    }   
	    File dirFile = new File(sPath);   
	    //如果dir对应的文件不存在，或者不是一个目录，则退出   
	    if (!dirFile.exists() || !dirFile.isDirectory()) {   
	        return false;   
	    }   
	    flag = true;   
	    //删除文件夹下的所有文件(包括子目录)   
	    File[] files = dirFile.listFiles();   
	    for (int i = 0; i < files.length; i++) {   
	        //删除子文件   
	        if (files[i].isFile()) {   
	            flag = deleteFile(files[i].getAbsolutePath());   
	            if (!flag) break;   
	        } //删除子目录   
	        else {   
	            flag = deleteDirectory(files[i].getAbsolutePath());   
	            if (!flag) break;   
	        }   
	    }   
	    if (!flag) return false;   
	    //删除当前目录   
	    if (dirFile.delete()) {   
	        return true;   
	    } else {   
	        return false;   
	    }   
	}  

	public File getFileMaterial() {
		return fileMaterial;
	}

	public void setFileMaterial(File fileMaterial) {
		this.fileMaterial = fileMaterial;
	}

	public String getFileMaterialFileName() {
		return fileMaterialFileName;
	}

	public void setFileMaterialFileName(String fileMaterialFileName) {
		this.fileMaterialFileName = fileMaterialFileName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	public String getQuestions() {
		return questions;
	}

	public void setQuestions(String questions) {
		this.questions = questions;
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

	public QuestionType getQuestionType() {
		return questionType;
	}

	public void setQuestionType(QuestionType questionType) {
		this.questionType = questionType;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}   

}
