package com.repair.common.pojo;


/**
 * Storetip entity. @author MyEclipse Persistence Tools
 */

public class Storetip implements java.io.Serializable {

	// Fields

	private String id;
	private String pjname;
	private String pjnum;
	private String getofnum;
	private Integer inputnum;
	private String inputdate;
	private String handler;
	private String confirmler;
	private String inputype;
	private String comments;
	private Integer isactive;

	// Constructors

	/** default constructor */
	public Storetip() {
	}

	/** minimal constructor */
	public Storetip(String id) {
		this.id = id;
	}

	/** full constructor */
	public Storetip(String id, String pjname, String pjnum, String getofnum, Integer inputnum, String inputdate, String handler, String confirmler, String inputype, String comments, Integer isactive) {
		this.id = id;
		this.pjname = pjname;
		this.pjnum = pjnum;
		this.getofnum = getofnum;
		this.inputnum = inputnum;
		this.inputdate = inputdate;
		this.handler = handler;
		this.confirmler = confirmler;
		this.inputype = inputype;
		this.comments = comments;
		this.isactive = isactive;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPjname() {
		return this.pjname;
	}

	public void setPjname(String pjname) {
		this.pjname = pjname;
	}

	public String getPjnum() {
		return this.pjnum;
	}

	public void setPjnum(String pjnum) {
		this.pjnum = pjnum;
	}

	public Integer getInputnum() {
		return this.inputnum;
	}

	public void setInputnum(Integer inputnum) {
		this.inputnum = inputnum;
	}

	public String getInputdate() {
		return this.inputdate;
	}

	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}

	public String getHandler() {
		return this.handler;
	}

	public void setHandler(String handler) {
		this.handler = handler;
	}

	public String getConfirmler() {
		return this.confirmler;
	}

	public void setConfirmler(String confirmler) {
		this.confirmler = confirmler;
	}

	public String getInputype() {
		return this.inputype;
	}

	public void setInputype(String inputype) {
		this.inputype = inputype;
	}

	public String getComments() {
		return this.comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Integer getIsactive() {
		return this.isactive;
	}

	public void setIsactive(Integer isactive) {
		this.isactive = isactive;
	}

	public String getGetofnum() {
		return getofnum;
	}

	public void setGetofnum(String getofnum) {
		this.getofnum = getofnum;
	}

}