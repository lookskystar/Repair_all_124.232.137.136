package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 资源（功能）类
 */

public class FunctionPrivs implements Serializable {

	private static final long serialVersionUID = -806795011792083430L;
	/**
	 * 主键
	 */
	private Long fid;
	/**
	 * 菜单（操作功能）名
	 */
	private String funname;
	/**
	 * 菜单URL
	 */
	private String url;
	/**
	 * 说明
	 * */
	private String note;
	/**
	 * 父级操作功能
	 * */
	private Long parentId;
	/**
	 * 是否启用 0启用 1不启用
	 * */
	private int isuse;
	/**
	 * 功能顺序
	 * */
	private int funOrder;

	public Long getFid() {
		return fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
	}

	public String getFunname() {
		return funname;
	}

	public void setFunname(String funname) {
		this.funname = funname;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public int getIsuse() {
		return isuse;
	}

	public void setIsuse(int isuse) {
		this.isuse = isuse;
	}

	public int getFunOrder() {
		return funOrder;
	}

	public void setFunOrder(int funOrder) {
		this.funOrder = funOrder;
	}
}
