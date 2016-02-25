package com.repair.common.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Deliverytip entity. @author MyEclipse Persistence Tools
 */

public class Deliverytip implements java.io.Serializable {

	// Fields

	private String id;
	private String pjname;
	private String oldpjnum;
	private String getoffnum;
	private String xcxc;
	private Integer deliverynum;
	private String deliverydate;
	private String deliveryperson;
	private String fixproteam;
	private String fixperson;
	private String receivepjnum;
	private String getonnum;
	private Integer receivenum;
	private String receivedate;
	private String receiveperson;
	private String status;
	private String comments;
	private Integer isactive;
	private Set addvancetips = new HashSet(0);

	// Constructors

	/** default constructor */
	public Deliverytip() {
	}

	/** minimal constructor */
	public Deliverytip(String id) {
		this.id = id;
	}

	/** full constructor */
	public Deliverytip(String id, String pjname, String oldpjnum, String getoffnum, String xcxc, Integer deliverynum, String deliverydate, String deliveryperson, String fixproteam, String fixperson, String receivepjnum, String getonnum, Integer receivenum, String receivedate, String receiveperson, String status, String comments, Integer isactive, Set addvancetips) {
		this.id = id;
		this.pjname = pjname;
		this.oldpjnum = oldpjnum;
		this.getoffnum = getoffnum;
		this.xcxc = xcxc;
		this.deliverynum = deliverynum;
		this.deliverydate = deliverydate;
		this.deliveryperson = deliveryperson;
		this.fixproteam = fixproteam;
		this.fixperson = fixperson;
		this.receivepjnum = receivepjnum;
		this.getonnum = getonnum;
		this.receivenum = receivenum;
		this.receivedate = receivedate;
		this.receiveperson = receiveperson;
		this.status = status;
		this.comments = comments;
		this.isactive = isactive;
		this.addvancetips = addvancetips;
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

	public String getOldpjnum() {
		return this.oldpjnum;
	}

	public void setOldpjnum(String oldpjnum) {
		this.oldpjnum = oldpjnum;
	}

	public String getGetoffnum() {
		return this.getoffnum;
	}

	public void setGetoffnum(String getoffnum) {
		this.getoffnum = getoffnum;
	}

	public String getXcxc() {
		return this.xcxc;
	}

	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public Integer getDeliverynum() {
		return this.deliverynum;
	}

	public void setDeliverynum(Integer deliverynum) {
		this.deliverynum = deliverynum;
	}

	public String getDeliverydate() {
		return this.deliverydate;
	}

	public void setDeliverydate(String deliverydate) {
		this.deliverydate = deliverydate;
	}

	public String getDeliveryperson() {
		return this.deliveryperson;
	}

	public void setDeliveryperson(String deliveryperson) {
		this.deliveryperson = deliveryperson;
	}

	public String getFixproteam() {
		return this.fixproteam;
	}

	public void setFixproteam(String fixproteam) {
		this.fixproteam = fixproteam;
	}

	public String getFixperson() {
		return this.fixperson;
	}

	public void setFixperson(String fixperson) {
		this.fixperson = fixperson;
	}

	public String getReceivepjnum() {
		return this.receivepjnum;
	}

	public void setReceivepjnum(String receivepjnum) {
		this.receivepjnum = receivepjnum;
	}

	public String getGetonnum() {
		return this.getonnum;
	}

	public void setGetonnum(String getonnum) {
		this.getonnum = getonnum;
	}

	public Integer getReceivenum() {
		return this.receivenum;
	}

	public void setReceivenum(Integer receivenum) {
		this.receivenum = receivenum;
	}

	public String getReceivedate() {
		return this.receivedate;
	}

	public void setReceivedate(String receivedate) {
		this.receivedate = receivedate;
	}

	public String getReceiveperson() {
		return this.receiveperson;
	}

	public void setReceiveperson(String receiveperson) {
		this.receiveperson = receiveperson;
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

	public Set getAddvancetips() {
		return this.addvancetips;
	}

	public void setAddvancetips(Set addvancetips) {
		this.addvancetips = addvancetips;
	}

}