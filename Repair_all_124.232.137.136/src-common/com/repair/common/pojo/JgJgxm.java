package com.repair.common.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * 
 * @author 周云涛
 * 加改项目
 *
 */
public class JgJgxm {
	/** @Fields   id：主键  */
	private Long id;
	
	/** @Fields	jgxmName：加改项目 */
	private String jgxmName;
	
	/** @Fields jcType：机车类型 */
	private DictJcType jcType;
	
	
	/** @Fields  jgxmRunKiloRecSet：加改项目-走行公里集合*/
	private Set<JgxmRunKiloRec> jgxmRunKiloRecSet=new HashSet<JgxmRunKiloRec>(0);
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getJgxmName() {
		return jgxmName;
	}

	public void setJgxmName(String jgxmName) {
		this.jgxmName = jgxmName;
	}

	public DictJcType getJcType() {
		return jcType;
	}

	public void setJcType(DictJcType jcType) {
		this.jcType = jcType;
	}

	public Set<JgxmRunKiloRec> getJgxmRunKiloRecSet() {
		return jgxmRunKiloRecSet;
	}

	public void setJgxmRunKiloRecSet(Set<JgxmRunKiloRec> jgxmRunKiloRecSet) {
		this.jgxmRunKiloRecSet = jgxmRunKiloRecSet;
	}
	
	
	
}
