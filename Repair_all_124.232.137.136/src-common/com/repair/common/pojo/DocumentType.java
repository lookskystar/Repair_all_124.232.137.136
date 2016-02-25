/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */
public class DocumentType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2448675161055497280L;
	//文档分类ID
	private Long id;
	//文档分类名
	private String name;
	//状态 0.未激活 1.激活
	private Integer status;
	//文档分类父类  PID为NULL表示为顶级父类文档
	private DocumentType parentType; 
	//文档分类子类
	private DocumentType childType;
	//模块分类 1:为车间管理 2为标注管理
	private String modelType;
	
	
	public DocumentType() {
		super();
	}
	public DocumentType(Long id) {
		super();
		this.id = id;
	}
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
	public DocumentType getParentType() {
		return parentType;
	}
	public void setParentType(DocumentType parentType) {
		this.parentType = parentType;
	}
	public DocumentType getChildType() {
		return childType;
	}
	public void setChildType(DocumentType childType) {
		this.childType = childType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getModelType() {
		return modelType;
	}
	public void setModelType(String modelType) {
		this.modelType = modelType;
	}
	
}
