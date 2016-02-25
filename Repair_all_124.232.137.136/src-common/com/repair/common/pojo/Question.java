/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */
public class Question implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1186564610853019476L;
	
	//问题ID
	private Long id;
	//问题
	private String question;
	//答案
	private String answer;
	//问题类型
	private QuestionType type;
	//添加人
	private UsersPrivs uploader;
	//添加时间
	private String uploadtime;
	//审批人
	private UsersPrivs examiner;
	//审批时间
	private String examintime;
	//状态  0.未审批 1.审批
	private String status;
	//图片URL 
	private String imgPath;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public QuestionType getType() {
		return type;
	}
	public void setType(QuestionType type) {
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
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
}
