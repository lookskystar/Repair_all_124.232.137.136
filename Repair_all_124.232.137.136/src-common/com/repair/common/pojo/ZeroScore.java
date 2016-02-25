package com.repair.common.pojo;

import java.sql.Timestamp;

/**
 * 
* @ClassName: ZeroScore
* @Description: TODO  零公里成绩
* @author 周云韬
* @version V1.0  
* @date 2015-10-12 下午5:29:59
 */
public class ZeroScore {
	private int id;
	
	private JtPreDict jtPreDict;
	
	private double score;
	
	private UsersPrivs signUsers;

	private Timestamp signTime=new Timestamp(System.currentTimeMillis());
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public JtPreDict getJtPreDict() {
		return jtPreDict;
	}

	public void setJtPreDict(JtPreDict jtPreDict) {
		this.jtPreDict = jtPreDict;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
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

	public ZeroScore(JtPreDict jtPreDict, double score, UsersPrivs signUsers) {
		super();
		this.jtPreDict = jtPreDict;
		this.score = score;
		this.signUsers = signUsers;
	}

	public ZeroScore() {
		super();
	}
	
	
	
}
