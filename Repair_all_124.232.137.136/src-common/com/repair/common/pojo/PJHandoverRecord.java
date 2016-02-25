package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 配件交接记录
 * 
 * @author Administrator
 * 
 */
public class PJHandoverRecord implements Serializable {
	private static final long serialVersionUID = 2732410601605611020L;
	private Integer id;
	/** 交件人 **/
	private String comunitPeo;
	/** 接件人 **/
	private String receiptPeo;
	/** 交件时间 **/
	private Date handoverTime;

	public PJHandoverRecord() {
	}

	public PJHandoverRecord(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getComunitPeo() {
		return comunitPeo;
	}

	public void setComunitPeo(String comunitPeo) {
		this.comunitPeo = comunitPeo;
	}

	public String getReceiptPeo() {
		return receiptPeo;
	}

	public void setReceiptPeo(String receiptPeo) {
		this.receiptPeo = receiptPeo;
	}

	public Date getHandoverTime() {
		return handoverTime;
	}

	public void setHandoverTime(Date handoverTime) {
		this.handoverTime = handoverTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PJHandoverRecord other = (PJHandoverRecord) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
