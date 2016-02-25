/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */
public class QuestionType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3488496742281185537L;
	//问题分类ID
	private Long id;
	//问题分类名
	private String name;
	//状态 0.未激活 1.激活
	private Integer status;
	//问题分类父类  PID为0表示为顶级父类文档
	private QuestionType parentType; 
	//问题分类子类
	private QuestionType childType;
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
	public QuestionType getParentType() {
		return parentType;
	}
	public void setParentType(QuestionType parentType) {
		this.parentType = parentType;
	}
	public QuestionType getChildType() {
		return childType;
	}
	public void setChildType(QuestionType childType) {
		this.childType = childType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
}
