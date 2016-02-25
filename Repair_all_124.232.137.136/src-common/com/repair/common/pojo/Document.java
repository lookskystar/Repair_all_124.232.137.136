/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */
public class Document implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -894155330429227097L;
	//文档ID
	private Long id;
	//文档名
	private String name;
	//文档类型
	private DocumentType type;
	//上传人
	private UsersPrivs uploader;
	//上传时间
	private String uploadtime;
	//审批人
	private UsersPrivs examiner;
	//审批时间
	private String examintime;
	//状态  0.未审批 1.审批
	private String status;
	//文件URL 
	private String filePath;
	//文档简介
	private String description;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public DocumentType getType() {
		return type;
	}
	public void setType(DocumentType type) {
		this.type = type;
	}
	public UsersPrivs getUploader() {
		return uploader;
	}
	public void setUploader(UsersPrivs uploader) {
		this.uploader = uploader;
	}
	public String getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}
	public UsersPrivs getExaminer() {
		return examiner;
	}
	public void setExaminer(UsersPrivs examiner) {
		this.examiner = examiner;
	}
	public String getExamintime() {
		return examintime;
	}
	public void setExamintime(String examintime) {
		this.examintime = examintime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
