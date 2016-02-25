package com.repair.common.pojo;

/**
 * 排班表
 * @author dell
 *
 */
public class KQWorkSet {
	//主键ID
	private Long id;
	//用户工号
	private String gonghao;
	//用户姓名
	private String xm;
	//班组ID
	private Long bzId;
	//班组姓名
	private String bzName;
	//排班月份 例如:2014-07
	private String workMonth;
	//排班日期 例如：2014-07-28
	private String workDay;
	//排班类型 0：休息 1：白班 2：晚班
	private Integer workType;
	//模板排班类型 0：休息 1：白班 2：晚班
	private Integer template;
	//是否为初始化数据 1:是 0：不是(默认)
	//初始化数据即是用户第一次输入的数据，用户如果更新该数据后，则相应的template数据也应该得到更新
	//如果不是初始化数据，用户更新该数据后，template不更新
	//private Integer isinit;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getGonghao() {
		return gonghao;
	}
	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public Long getBzId() {
		return bzId;
	}
	public void setBzId(Long bzId) {
		this.bzId = bzId;
	}
	public String getBzName() {
		return bzName;
	}
	public void setBzName(String bzName) {
		this.bzName = bzName;
	}
	public String getWorkMonth() {
		return workMonth;
	}
	public void setWorkMonth(String workMonth) {
		this.workMonth = workMonth;
	}
	public String getWorkDay() {
		return workDay;
	}
	public void setWorkDay(String workDay) {
		this.workDay = workDay;
	}
	public Integer getWorkType() {
		return workType;
	}
	public void setWorkType(Integer workType) {
		this.workType = workType;
	}
	public Integer getTemplate() {
		return template;
	}
	public void setTemplate(Integer template) {
		this.template = template;
	}
}
