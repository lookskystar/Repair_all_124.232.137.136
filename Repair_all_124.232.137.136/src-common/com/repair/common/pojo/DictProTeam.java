package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 专业班组类
 * @author cuisine
 *
 */
public class DictProTeam implements Serializable{

	private static final long serialVersionUID = -8331104173205472175L;
	/**
	 * 主键
	 */
	private Long proteamid;
	/**
	 * 专业班组名
	 */
	private String proteamname;
	/**
	 * 班组拼音
	 */
	private String py;
	
	/**
	 * 机车类型
	 */
	private String jctype;
	
	/**
	 * 对应状态
	 */
	private Integer workflag;
	
	/**
	 * 中修判别字段
	 */
	private Integer zxFlag;
	
	/**
	 * 考勤判别字段
	 */
	private Integer kqflag;

	public Long getProteamid() {
		return proteamid;
	}

	public void setProteamid(Long proteamid) {
		this.proteamid = proteamid;
	}

	public String getProteamname() {
		return proteamname;
	}

	public void setProteamname(String proteamname) {
		this.proteamname = proteamname;
	}

	public String getPy() {
		return py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	public String getJctype() {
		return jctype;
	}

	public void setJctype(String jctype) {
		this.jctype = jctype;
	}


	public Integer getWorkflag() {
		return workflag;
	}

	public void setWorkflag(Integer workflag) {
		this.workflag = workflag;
	}

	public Integer getZxFlag() {
		return zxFlag;
	}

	public void setZxFlag(Integer zxFlag) {
		this.zxFlag = zxFlag;
	}
	
	public Integer getKqflag() {
		return kqflag;
	}

	public void setKqflag(Integer kqflag) {
		this.kqflag = kqflag;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((proteamid == null) ? 0 : proteamid.hashCode());
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
		DictProTeam other = (DictProTeam) obj;
		if (proteamid == null) {
			if (other.proteamid != null)
				return false;
		} else if (!proteamid.equals(other.proteamid))
			return false;
		return true;
	}

}