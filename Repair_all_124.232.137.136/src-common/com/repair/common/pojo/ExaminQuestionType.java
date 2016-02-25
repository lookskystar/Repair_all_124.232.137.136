package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */

public class ExaminQuestionType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7247824868824676393L;
	//问题分类ID
	private Long id;
	//问题分类名
	private String name;
	//状态 0.未激活 1.激活
	private Integer status;
	private Long type;
	//问题分类父类  PID为0表示为顶级父类文档
	private ExaminQuestionType parentType; 
	//问题分类子类
	private ExaminQuestionType childType;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public ExaminQuestionType getParentType() {
		return parentType;
	}
	public void setParentType(ExaminQuestionType parentType) {
		this.parentType = parentType;
	}
	public ExaminQuestionType getChildType() {
		return childType;
	}
	public void setChildType(ExaminQuestionType childType) {
		this.childType = childType;
	}
	public Long getType() {
		return type;
	}
	public void setType(Long type) {
		this.type = type;
	}
}
