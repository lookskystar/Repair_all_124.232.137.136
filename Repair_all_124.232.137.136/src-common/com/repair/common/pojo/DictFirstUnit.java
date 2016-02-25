package com.repair.common.pojo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
/**
 * 一级部件实体类
 * @author jiangxiaolong
 *
 */
public class DictFirstUnit implements Serializable{

	private static final long serialVersionUID = -7771248239568079422L;
	/**
	 * 主键
	 */
	private Long firstunitid;
	/**
	 * 一级部件名
	 */
	private String firstunitname;
	/**
	 * 部件拼音
	 */
	private String py;
	/**
	 * 机车型号值
	 */
	private String jcstypevalue;
	/**
	 * 访问报告的URL
	 */
	private String url;
	/*private Set<DictPosition> dictPositions = new HashSet<DictPosition>();
	private Set<DictFailure> dictFailures = new HashSet<DictFailure>();
	private Set<PJStaticInfo> pjStaticinfos = new HashSet<PJStaticInfo>();*/
	private Set<DictSecunit> dictSecunits = new HashSet<DictSecunit>();
	private Set<PJStaticInfo> pjStaticinfos = new HashSet<PJStaticInfo>();
	
	public Set<PJStaticInfo> getPjStaticinfos() {
		return pjStaticinfos;
	}
	public void setPjStaticinfos(Set<PJStaticInfo> pjStaticinfos) {
		this.pjStaticinfos = pjStaticinfos;
	}
	public Long getFirstunitid() {
		return firstunitid;
	}
	public void setFirstunitid(Long firstunitid) {
		this.firstunitid = firstunitid;
	}
	public String getFirstunitname() {
		return firstunitname;
	}
	public void setFirstunitname(String firstunitname) {
		this.firstunitname = firstunitname;
	}
	public String getPy() {
		return py;
	}
	public void setPy(String py) {
		this.py = py;
	}
	public String getJcstypevalue() {
		return jcstypevalue;
	}
	public void setJcstypevalue(String jcstypevalue) {
		this.jcstypevalue = jcstypevalue;
	}
	public Set<DictSecunit> getDictSecunits() {
		return dictSecunits;
	}
	public void setDictSecunits(Set<DictSecunit> dictSecunits) {
		this.dictSecunits = dictSecunits;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
}