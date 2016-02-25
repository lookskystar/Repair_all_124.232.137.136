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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.Document;
import com.repair.common.pojo.DocumentType;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.query.service.PlantManageService;
import com.repair.work.service.UsersPrivsService;


public class DocumentManageAction {
	@Resource(name = "plantManageService")
	private PlantManageService plantManageService;
	@Resource(name = "usersPrivsService")
	private UsersPrivsService usersPrivsService;
	//文档类型
	private String type;
	private String modelType;
	//文件名
	private String name;
	//上传人
	private String uploader;
	//开始时间
	private String dateStart;
	//结束时间
	private String dateEnd;
	
	//审批人
	private String examiner;
	//文档简介
	private String description;
	
	private DocumentType documentType;
	
	//Ajax获取文件,与控件type=File中的name属性一样  
	private File fileMaterial;
	//Ajax获取文件名称,相应的name属性名称+FileName  
	private String fileMaterialFileName;
	
	
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
	 * 查询所有文档类型
	 * @return
	 * @throws Exception
	 */
	public String listDocumentType() throws Exception{
		List<DocumentType> documentTypeList = plantManageService.listDocumentType(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		//封装MAP
		Map<DocumentType, List<DocumentType>> documentTypeMap = new LinkedHashMap<DocumentType, List<DocumentType>>();
		DocumentType tempDocumentType = null;
		List<DocumentType> childDocumentTypeList = null; 
		for(int i = 0; i <= documentTypeList.size()-1; i++){
			tempDocumentType = documentTypeList.get(i);
			if(tempDocumentType.getParentType() == null || tempDocumentType.getParentType().getId() == 0){
				if(documentTypeMap.get(tempDocumentType) == null){
					childDocumentTypeList = plantManageService.listDocumentTypeByPID(tempDocumentType.getId(), StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
					documentTypeMap.put(tempDocumentType, childDocumentTypeList);
				}
			}
		}
		request.setAttribute("documentTypeMap", documentTypeMap);
		request.setAttribute("modelType", StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		return "listDocumentType";
	}
	
	/**
	 * 标准查询
	 * @return
	 * @throws Exception
	 */
	public String listDocumentTypeStandard() throws Exception{
		List<DocumentType> documentTypeList = plantManageService.listDocumentType(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		//封装MAP
		Map<DocumentType, List<DocumentType>> documentTypeMap = new LinkedHashMap<DocumentType, List<DocumentType>>();
		DocumentType tempDocumentType = null;
		List<DocumentType> childDocumentTypeList = null; 
		for(int i = 0; i <= documentTypeList.size()-1; i++){
			tempDocumentType = documentTypeList.get(i);
			if(tempDocumentType.getParentType() == null || tempDocumentType.getParentType().getId() == 0){
				if(documentTypeMap.get(tempDocumentType) == null){
					childDocumentTypeList = plantManageService.listDocumentTypeByPID(tempDocumentType.getId(), StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
					documentTypeMap.put(tempDocumentType, childDocumentTypeList);
				}
			}
		}
		request.setAttribute("documentTypeMap", documentTypeMap);
		return "listDocumentTypeQuery";
	}
	
	/**
	 * 查询所有的文档
	 * @return
	 * @throws Exception
	 */
	public String listDocument() throws Exception{
		PageModel<Document> documentPm  = plantManageService.listDocument(type, name, uploader, dateStart, dateEnd, examiner, description, modelType);
		request.setAttribute("documentPm", documentPm);
		request.setAttribute("modelType", StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		return	"listDocument";
	}
	
	/**
	 * 标准查询文档
	 * @return
	 * @throws Exception
	 */
	public String listDocumentStandard() throws Exception{
		PageModel<Document> documentPm  = plantManageService.listDocument(type, name, uploader, dateStart, dateEnd, examiner, description, modelType);
		request.setAttribute("documentPm", documentPm);
		return	"listDocumentQuery";
	}
	
	/**
	 * 新建文档类型
	 * @return
	 * @throws Exception
	 */
	public String documentTypeAddInput() throws Exception{
		List<DocumentType> documentTypeList = plantManageService.listDocumentTypeOfTop(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		request.setAttribute("documentTypeList", documentTypeList);
		request.setAttribute("modelType", StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		return "documentTypeAddInput";
	}
	
	public String documentTypeAdd() throws Exception{
		//初始文档类型为激活状态
		documentType.setStatus(1);
		plantManageService.saveOrUpdateDocumentType(documentType);
		return listDocumentType();
	}
	
	
	/**
	 * 编辑文档类型
	 * @return
	 * @throws Exception
	 */
	public String documentTypeEditInput() throws Exception{
		String documentTypeId = request.getParameter("id");
		DocumentType documentTypes = plantManageService.listDocumentTypeById(Long.parseLong(documentTypeId));
		List<DocumentType> documentTypeList = plantManageService.listDocumentTypeOfTop(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		request.setAttribute("documentTypes", documentTypes);
		request.setAttribute("documentTypeList", documentTypeList);
		request.setAttribute("modelType", StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		return "documentTypeEditInput";
	}
	
	public String documentTypeEdit() throws Exception{
		plantManageService.saveOrUpdateDocumentType(documentType);
		return listDocumentType();
	}
	
	/**
	 * 删除文档类型
	 * @return
	 * @throws Exception
	 */
	public String documentTypeDelete() throws Exception{
		String result = "";
		String documentIdArray[] = request.getParameter("documentTypes").split(",");
		for (int i = 0; i < documentIdArray.length; i++) {
			DocumentType documentType = plantManageService.listDocumentTypeById(Long.parseLong(documentIdArray[i]));
			//查找该类型是否有子类型
			List<DocumentType> childDocumentTypeList = plantManageService.listDocumentTypeByPID(documentType.getId(), null);
			try {
				if(childDocumentTypeList.size() > 0 || childDocumentTypeList != null){
					for (Iterator<DocumentType> iterator = childDocumentTypeList.iterator(); iterator.hasNext();) {
						DocumentType childDocumentType = (DocumentType) iterator.next();
						childDocumentType.setStatus(0);
						plantManageService.saveOrUpdateDocumentType(childDocumentType);
					}
				}
				documentType.setStatus(0);
				plantManageService.saveOrUpdateDocumentType(documentType);
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
	 * 新建文档 
	 * @return
	 * @throws Exception
	 */
	public String documentAddInput() throws Exception{
		List<DocumentType> documentTypeList = plantManageService.listDocumentTypeOfSec(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		request.setAttribute("documentTypeList", documentTypeList);
		request.setAttribute("modelType", StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
		return "documentAddInput";
	}
	
	public String doumentAddConfirm() throws Exception {
		PrintWriter out = response.getWriter();
		Document document = new Document();
		//文档名称 
		String fileName = request.getParameter("fileName");
		document.setName(fileName);
		//文档类型
		String type = request.getParameter("type");
		DocumentType documentType = plantManageService.listDocumentTypeById(Long.parseLong(type));
		document.setType(documentType);
		//上传人
		String uploaderId = request.getParameter("uploaderId");
		UsersPrivs user = usersPrivsService.getUsersPrivsById(Long.parseLong(uploaderId));
		document.setUploader(user);
		//文档简介
		String description = request.getParameter("description");
		document.setDescription(description);
		//上传时间 
		document.setUploadtime(YMDHMS_SDFORMAT.format(new Date()));
		//文档URL
		String fileUrl = request.getParameter("fileUrl");
		document.setFilePath(fileUrl);
		try {
			plantManageService.saveOrUpdateDocument(document);
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
            String filePath = "uploadfile" + "/" +  dateFormat.format(new Date());
            String fileRealPath=ServletActionContext.getServletContext().getRealPath(filePath);
    		File sysmfile = new File(fileRealPath);
    		if (!fileMaterial.exists()) {
    			fileMaterial.mkdirs();
    		}
            FileUtils.copyFile(fileMaterial, new File(sysmfile.getPath() + "/" + fileName));
            response.getWriter().print(filePath+"/"+fileName+","+fileMaterialFileName+",文件上传成功!");
        }else{  
            response.getWriter().print("请添加要上传的文件!");  
        }  
        return null;  
    } 
    
    
    /**
	 * 删除文档
	 * @return
	 * @throws Exception
	 */
	public String documentDelete() throws Exception{
		String result = "";
		//服务器URL
		String path = ServletActionContext.getServletContext().getRealPath("/");
		String documentIdArray[] = request.getParameter("documents").split(",");
		for (int i = 0; i < documentIdArray.length; i++) {
			Document document = plantManageService.listDocumentById(Long.parseLong(documentIdArray[i]));
			try {
				plantManageService.deleteDocument(document);
				if((path+document.getFilePath()).matches(matches)){
					DeleteFolder(path+document.getFilePath());
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
	 * 分类显示
	 * @return
	 * @throws Exception
	 */
	public String documentOfType() throws Exception{
		PageModel<Document> DocumentPm  = plantManageService.listDocument(type, name, uploader, dateStart, dateEnd, examiner, description, modelType);
		request.setAttribute("DocumentPm", DocumentPm);
		return "documentOfType";
	}
	
	
	/**
	 * AJAX 获取文档类型
	 * @throws IOException 
	 */
	public void ajaxGetDocumentTypeList() {
		PrintWriter out =  null;
		JSONArray resultArray = new JSONArray();
		JSONObject resultRow = null;
		try {
			out = response.getWriter();	
			//获取文档类型
			List<DocumentType> documentTypeList = plantManageService.listDocumentType(StringUtils.isNotEmpty(modelType)? modelType: documentType.getModelType());
			for (DocumentType documentType : documentTypeList) {
				resultRow = new JSONObject();
				resultRow.put("id", documentType.getId());
				resultRow.put("name", documentType.getName());
				resultArray.add(resultRow);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.write(resultArray.toString());
		}
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


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public DocumentType getDocumentType() {
		return documentType;
	}

	public void setDocumentType(DocumentType documentType) {
		this.documentType = documentType;
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
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getModelType() {
		return modelType;
	}

	public void setModelType(String modelType) {
		this.modelType = modelType;
	}
}