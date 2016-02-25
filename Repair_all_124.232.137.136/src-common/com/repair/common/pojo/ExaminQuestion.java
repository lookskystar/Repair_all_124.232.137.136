package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */

public class ExaminQuestion implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2835129601981683687L;
	//问题ID
	private Long id;
	//问题
	private String question;
	//标准答案
	private String answer;
	//答案A
	private String chooseA;
	//答案B
	private String chooseB;
	//答案C
	private String chooseC;
	//答案D
	private String chooseD;
	//问题专业
	private DictProTeam dictProTeam;
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
	public String getChooseA() {
		return chooseA;
	}
	public void setChooseA(String chooseA) {
		this.chooseA = chooseA;
	}
	public String getChooseB() {
		return chooseB;
	}
	public void setChooseB(String chooseB) {
		this.chooseB = chooseB;
	}
	public String getChooseC() {
		return chooseC;
	}
	public void setChooseC(String chooseC) {
		this.chooseC = chooseC;
	}
	public String getChooseD() {
		return chooseD;
	}
	public void setChooseD(String chooseD) {
		this.chooseD = chooseD;
	}
	public DictProTeam getDictProTeam() {
		return dictProTeam;
	}
	public void setDictProTeam(DictProTeam dictProTeam) {
		this.dictProTeam = dictProTeam;
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
}
