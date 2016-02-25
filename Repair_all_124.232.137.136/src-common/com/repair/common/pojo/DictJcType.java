package com.repair.common.pojo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * 机车类型
 * 
 * @author zx
 * 
 */
public class DictJcType implements Serializable{
	private static final long serialVersionUID = -337697809874958906L;
	// 类型ID
	private Integer jcTypeId;
	// 类型值
	private String jcTypeValue;

	//加改项目集合（增加加改项目模块时所需要的）
	private Set<JgJgxm> jgxmSet=new HashSet<JgJgxm>(0);
	
	//机车型号集合（增加加改项目模块时所需要的）
	private Set<DictJcStype> dictJcSTypeSet=new HashSet<DictJcStype>(0);
	
	public Integer getJcTypeId() {
		return jcTypeId;
	}

	public DictJcType() {

	}

	public void setJcTypeId(Integer jcTypeId) {
		this.jcTypeId = jcTypeId;
	}

	public String getJcTypeValue() {
		return jcTypeValue;
	}

	public void setJcTypeValue(String jcTypeValue) {
		this.jcTypeValue = jcTypeValue;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((jcTypeId == null) ? 0 : jcTypeId.hashCode());
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
		DictJcType other = (DictJcType) obj;
		if (jcTypeId == null) {
			if (other.jcTypeId != null)
				return false;
		} else if (!jcTypeId.equals(other.jcTypeId))
			return false;
		return true;
	}

	public Set<JgJgxm> getJgxmSet() {
		return jgxmSet;
	}

	public void setJgxmSet(Set<JgJgxm> jgxmSet) {
		this.jgxmSet = jgxmSet;
	}

	public Set<DictJcStype> getDictJcSTypeSet() {
		return dictJcSTypeSet;
	}

	public void setDictJcSTypeSet(Set<DictJcStype> dictJcSTypeSet) {
		this.dictJcSTypeSet = dictJcSTypeSet;
	}
	
	
	
}
