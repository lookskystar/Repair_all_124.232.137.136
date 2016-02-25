package com.repair.kq.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.util.fusioncharts.MSArea2DChartSet;
import com.repair.kq.service.AnomalouService;
import com.repair.kq.service.RewardService;

public class AnomalouAction {

	private AnomalouService anomalouService;

	private RewardService rewardService;
	

	/** request */
	private HttpServletRequest request = ServletActionContext.getRequest();

	private static final SimpleDateFormat YM = new SimpleDateFormat("yyyy-MM");

	@Resource
	public void setAnomalouService(AnomalouService anomalouService) {
		this.anomalouService = anomalouService;
	}
	
	@Resource
	public void setRewardService(RewardService rewardService) {
		this.rewardService = rewardService;
	}




	/**
	 * 创建MSArea2D
	 */
	public String createMSArea2DCharts() throws Exception {
		String monthNow = YM.format(new Date());
		String month = (null == request.getParameter("month") ? monthNow : request.getParameter("month"));
		String proteamId = request.getParameter("proteamId");
		String userName = request.getParameter("userName");
		Map<String, String> params = new HashMap<String, String>();
		params.put("month", month);
		params.put("proteamId", proteamId);
		params.put("userName", userName);
		MSArea2DChartSet msArea2DChart = anomalouService.createMSArea2D(params);
		List<DictProTeam> proteams = rewardService.findWorkProTeam();
		String jsonData = JSON.toJSONStringWithDateFormat(msArea2DChart, "yyyy-MM-dd HH:mm:ss");
		request.setAttribute("jsonData", jsonData);
		request.setAttribute("proteams", proteams);
		request.setAttribute("proteamId", proteamId);
		request.setAttribute("userName", userName);
		request.setAttribute("month", month);
		return "createMSArea2DCharts";
	}
}
