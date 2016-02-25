package com.repair.common.pojo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


/**
 * 二级部件实体类
 * @author jiangxiaolong
 *
 */
public class DictSecunit implements Serializable{


	private static final long serialVersionUID = 415226107385664447L;
	/**
	 * 主键
	 */
	private Long secunitid;
	/**
	 * 一件部件
	 */
	private DictFirstUnit dictFirstunit;
	/**
	 * 二级部件名
	 */
	private String secunitname;
	/**
	 * 二级部件拼音
	 */
	private String py;
	/**
	 * 访问报告的URL
	 */
	private String url;
	/*private Set<DictFailure> dictFailures = new HashSet<DictFailure>();*/
	private Set<PJStaticInfo> pjStaticinfos = new HashSet<PJStaticInfo>();
	public Long getSecunitid() {
		return secunitid;
	}
	public void setSecunitid(Long secunitid) {
		this.secunitid = secunitid;
	}
	
	public DictFirstUnit getDictFirstunit() {
		return dictFirstunit;
	}
	public void setDictFirstunit(DictFirstUnit dictFirstunit) {
		this.dictFirstunit = dictFirstunit;
	}
	public String getSecunitname() {
		return secunitname;
	}
	public void setSecunitname(String secunitname) {
		this.secunitname = secunitname;
	}
	public String getPy() {
		return py;
	}
	public void setPy(String py) {
		this.py = py;
	}
	public Set<PJStaticInfo> getPjStaticinfos() {
		return pjStaticinfos;
	}
	public void setPjStaticinfos(Set<PJStaticInfo> pjStaticinfos) {
		this.pjStaticinfos = pjStaticinfos;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

}