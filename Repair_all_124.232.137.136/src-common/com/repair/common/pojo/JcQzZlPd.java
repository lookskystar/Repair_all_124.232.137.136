package com.repair.common.pojo;

import java.sql.Timestamp;

/**
 * 秋整机车质量评定（段领导签字）
* @ClassName: JcZlPd
* @Description: TODO	修次为秋整时 段领导必须对机车进行签字评分，用于存储评定人。
* @author 周云韬	
* @version V1.0  
* @date 2015-10-15 上午8:37:36
 */
public class JcQzZlPd {
	private Integer id;
	
	private DatePlanPri datePlanPri;
	
	private UsersPrivs signUsers;
	
	private Timestamp signTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public DatePlanPri getDatePlanPri() {
		return datePlanPri;
	}

	public void setDatePlanPri(DatePlanPri datePlanPri) {
		this.datePlanPri = datePlanPri;
	}

	public UsersPrivs getSignUsers() {
		return signUsers;
	}

	public void setSignUsers(UsersPrivs signUsers) {
		this.signUsers = signUsers;
	}

	public Timestamp getSignTime() {
		return signTime;
	}

	public void setSignTime(Timestamp signTime) {
		this.signTime = signTime;
	}

	public JcQzZlPd(DatePlanPri datePlanPri, UsersPrivs signUsers,
			Timestamp signTime) {
		super();
		this.datePlanPri = datePlanPri;
		this.signUsers = signUsers;
		this.signTime = signTime;
	}
	
	public JcQzZlPd() {
		// TODO Auto-generated constructor stub
	}
}
