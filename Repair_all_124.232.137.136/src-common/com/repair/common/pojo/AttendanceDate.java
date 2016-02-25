/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * Ա考勤日记录
 * @author eleven
 *
 */
public class AttendanceDate implements Serializable {

	
	private static final long serialVersionUID = 7758714130707159787L;
	
	//id
	private Long id;
	//工人
	private UsersPrivs users;
	//班组
	private DictProTeam bzid;
	//日期
	private String datetime;
	//备注ע
	private String comments;
	//状态״̬
	private String confirm;
	//姓名
	private String xm;
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public UsersPrivs getUsers() {
		return users;
	}
	public void setUsers(UsersPrivs users) {
		this.users = users;
	}
	
	public DictProTeam getBzid() {
		return bzid;
	}
	public void setBzid(DictProTeam bzid) {
		this.bzid = bzid;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	
	
	
}
