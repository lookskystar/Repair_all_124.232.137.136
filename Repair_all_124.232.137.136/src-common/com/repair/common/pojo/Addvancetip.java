package com.repair.common.pojo;


/**
 * Addvancetip entity. @author MyEclipse Persistence Tools
 */

public class Addvancetip implements java.io.Serializable {

	// Fields

	private String id;
	private String pjname;
	private Deliverytip deliverytip;
	private String pjnum;
	private String getonnum;
	private String xcxc;
	private Integer addvancenum;
	private String addvanceperson;
	private String deliveryperson;
	private String status;
	private String comments;
	private Integer isactive;
	private String addvancedate;

	// Constructors

	/** default constructor */
	public Addvancetip() {
	}

	/** minimal constructor */
	public Addvancetip(String id) {
		this.id = id;
	}

	/** full constructor */
	public Addvancetip(String id, String pjname, Deliverytip deliverytip, String pjnum, String getonnum, String xcxc, Integer addvancenum, String addvanceperson, String deliveryperson, String status, String comments, Integer isactive, String addvancedate) {
		this.id = id;
		this.pjname = pjname;
		this.deliverytip = deliverytip;
		this.pjnum = pjnum;
		this.getonnum = getonnum;
		this.xcxc = xcxc;
		this.addvancenum = addvancenum;
		this.addvanceperson = addvanceperson;
		this.deliveryperson = deliveryperson;
		this.status = status;
		this.comments = comments;
		this.isactive = isactive;
		this.addvancedate = addvancedate;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Deliverytip getDeliverytip() {
		return this.deliverytip;
	}

	public void setDeliverytip(Deliverytip deliverytip) {
		this.deliverytip = deliverytip;
	}

	public String getPjnum() {
		return this.pjnum;
	}

	public void setPjnum(String pjnum) {
		this.pjnum = pjnum;
	}

	public String getGetonnum() {
		return this.getonnum;
	}

	public void setGetonnum(String getonnum) {
		this.getonnum = getonnum;
	}

	public String getXcxc() {
		return this.xcxc;
	}

	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public Integer getAddvancenum() {
		return this.addvancenum;
	}

	public void setAddvancenum(Integer addvancenum) {
		this.addvancenum = addvancenum;
	}

	public String getAddvanceperson() {
		return this.addvanceperson;
	}

	public void setAddvanceperson(String addvanceperson) {
		this.addvanceperson = addvanceperson;
	}

	public String getDeliveryperson() {
		return this.deliveryperson;
	}

	public void setDeliveryperson(String deliveryperson) {
		this.deliveryperson = deliveryperson;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getAddvancedate() {
		return this.addvancedate;
	}

	public void setAddvancedate(String addvancedate) {
		this.addvancedate = addvancedate;
	}

	public String getPjname() {
		return pjname;
	}

	public void setPjname(String pjname) {
		this.pjname = pjname;
	}

}