package com.repair.ts.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.TsAtRecord;
import com.repair.common.pojo.TsUnit;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.ts.service.TsService;

public class TsAction {

	@Resource(name = "tsService")
	private TsService tsService;
	private TsAtRecord tsAtRecord;
	private HttpServletRequest request = ServletActionContext.getRequest();
	private String btime;
	private String etime;

	/**
	 * 进入报活页面
	 * */
	public String inputDepot() {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		List<TsUnit> units = null;
		if(user.getBzid()!=null){
			int bzid = Integer.parseInt(user.getBzid()+"");
			units = tsService.findAllUnit(bzid);
		}
		List<DictJcStype> jcTypes = tsService.findAllJcTypes();
		List xc = tsService.findAllXc();

		request.setAttribute("units", units);
		request.setAttribute("jcTypes", jcTypes);
		request.setAttribute("xc", xc);
		return "inputDepot";
	}

	/**
	 * 报活
	 * */
	public String tsDepot() {
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String atime = sd.format(date);
		tsAtRecord.setAtTime(atime);
		tsService.saveDepot(tsAtRecord);

		request.setAttribute("jcType2", tsAtRecord.getJcType());
		request.setAttribute("xc2", tsAtRecord.getXc());
		request.setAttribute("unitName2", tsAtRecord.getUnitName());
		request.setAttribute("jcNum", tsAtRecord.getJcNum());
		request.setAttribute("jcFixNum", tsAtRecord.getJcFixNum());
		request.setAttribute("message", "报活成功！");
		return inputDepot();
	}

	/**
	 * 进入报活列表
	 * */
	public String inputDepotList() {
		List<TsAtRecord> depots = tsService.findDepot();
		request.setAttribute("depots", depots);
		return "inputDepotList";
	}

	/**
	 * 进入派工页面
	 * */
	public String inputPaiGong() {
		int id = Integer.parseInt(request.getParameter("id"));
		TsAtRecord depot = tsService.findDepotById(id);
		List<UsersPrivs> tsworker = tsService.findAllTsWorker();

		request.setAttribute("tsworker", tsworker);
		request.setAttribute("id", depot.getId());
		request.setAttribute("jcType", depot.getJcType());
		request.setAttribute("jcNum", depot.getJcNum());
		request.setAttribute("unitName", depot.getUnitName());
		return "inputPaiGong";
	}

	/**
	 * 派工
	 * */
	public String paigong() {
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String fixTime = sd.format(date);

		int id = Integer.parseInt(request.getParameter("id"));
		String firstWorker = request.getParameter("firstWorker");
		String secondWorker = request.getParameter("secondWorker");

		TsAtRecord depot = tsService.findDepotById(id);

		depot.setFirstWorker(firstWorker);
		depot.setSecondWorker(secondWorker);
		depot.setStatus("1");
		depot.setFixTime(fixTime);
		tsService.saveDepot(depot);
		request.setAttribute("message", "已派工！");
		return inputDepotList();
	}

	/**
	 * 进入记录列表
	 * */
	public String inputRecord() {
		List<TsAtRecord> depots = tsService.findDepotRecord();
		request.setAttribute("depots", depots);
		return "inputRecord";
	}

	/**
	 * 进入记录填写页面
	 * */
	public String inputRecordFill() {
		int id = Integer.parseInt(request.getParameter("id"));
		TsAtRecord depot = tsService.findDepotById(id);

		request.setAttribute("id", depot.getId());
		request.setAttribute("jcType", depot.getJcType());
		request.setAttribute("jcNum", depot.getJcNum());
		request.setAttribute("unitName", depot.getUnitName());
		request.setAttribute("firstWorker", depot.getFirstWorker());
		request.setAttribute("secondWorker", depot.getSecondWorker());
		return "inputRecordFill";
	}

	/**
	 * 探伤记录填写
	 * */
	public String recordFill() {
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String tsTime = sd.format(date);

		int id = Integer.parseInt(request.getParameter("id"));
		String tsResult = request.getParameter("tsResult");
		String tsMethod = request.getParameter("tsMethod");
		String tsDeal = request.getParameter("tsDeal");

		TsAtRecord record = tsService.findDepotById(id);
		record.setTsTime(tsTime);
		record.setTsMethod(tsMethod);
		record.setTsResult(tsResult);
		record.setTsDeal(tsDeal);
		record.setStatus("2");
		tsService.saveDepot(record);

		request.setAttribute("message", "探伤记录已填写！");
		return inputRecord();
	}

	/**
	 * 探伤记录查询
	 * */
	public String inputRecordList() {
		PageModel<TsAtRecord> depots = tsService.findRecord(btime, etime);
		request.setAttribute("depots", depots);
		return "inputRecordList";
	}

	/**
	 * 查看探伤记录详情
	 * */
	public String inputDetails() {
		int id = Integer.parseInt(request.getParameter("id"));
		TsAtRecord depot = tsService.findDepotById(id);

		request.setAttribute("depot", depot);
		return "inputDetails";
	}

	public TsAtRecord getTsAtRecord() {
		return tsAtRecord;
	}

	public void setTsAtRecord(TsAtRecord tsAtRecord) {
		this.tsAtRecord = tsAtRecord;
	}

	public String getBtime() {
		return btime;
	}

	public void setBtime(String btime) {
		this.btime = btime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}
}
