package com.repair.common.pojo;


/**
 * 机破信息表
 * @author eleven
 *
 */
public class TrainFault {
	//主键ID
	private Integer id;
	//机车型号
	private String jctype;
	//机车编号
	private String jcnum;
	//机车段属
	private String locomotive;
	//机破日期
	private String faultDate;
	//机破原因
	private String faultCause;
	//机破段属
	private String faultmotive;
	//登记日期
	private String regDate;
	//登记人
	private String register;
	//处理情况
	private String dealcondition;
	//备注
	private String comments;
	
	/**
	 * 关联机车走行表
	 * @return
	 */
	private JtRunKiloRec jtRunKiloRec;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getJctype() {
		return jctype;
	}
	public void setJctype(String jctype) {
		this.jctype = jctype;
	}
	public String getJcnum() {
		return jcnum;
	}
	public void setJcnum(String jcnum) {
		this.jcnum = jcnum;
	}
	public String getLocomotive() {
		return locomotive;
	}
	public void setLocomotive(String locomotive) {
		this.locomotive = locomotive;
	}
	public String getFaultDate() {
		return faultDate;
	}
	public void setFaultDate(String faultDate) {
		this.faultDate = faultDate;
	}
	public String getFaultmotive() {
		return faultmotive;
	}
	public void setFaultmotive(String faultmotive) {
		this.faultmotive = faultmotive;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getDealcondition() {
		return dealcondition;
	}
	public void setDealcondition(String dealcondition) {
		this.dealcondition = dealcondition;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public JtRunKiloRec getJtRunKiloRec() {
		return jtRunKiloRec;
	}
	public void setJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		this.jtRunKiloRec = jtRunKiloRec;
	}
	public String getFaultCause() {
		return faultCause;
	}
	public void setFaultCause(String faultCause) {
		this.faultCause = faultCause;
	}
	
}
