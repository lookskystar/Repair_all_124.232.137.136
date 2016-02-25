/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 考勤详情表
 * @author eleven
 *
 */
public class AttendanceDetails implements Serializable {

	private static final long serialVersionUID = -100412416666732890L;
	//id
	private long id;
	//日记录id
	private AttendanceDate did;
	//拍摄时间
	private String imgtime;
	//照片地址ַ
	private String imgurl;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public AttendanceDate getDid() {
		return did;
	}
	public void setDid(AttendanceDate did) {
		this.did = did;
	}
	public String getImgtime() {
		return imgtime;
	}
	public void setImgtime(String imgtime) {
		this.imgtime = imgtime;
	}
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	
}
