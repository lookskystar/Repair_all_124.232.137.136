package com.repair.admin.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.SystemService;

/**
 * 系统设置
 * @author Administrator
 *
 */
public class SystemAction {
	
	@Resource(name="systemService")
	private SystemService systemService;
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	
	/**
	 * 进入系统设置
	 */
	public String setInput() throws Exception {
		request.setAttribute("paramter", systemService.listSystemParameter());
		return "system";
	}
	
	/**
	 * 修改设置
	 */
	public String set() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("is_use_report", request.getParameter("is_use_report"));
		systemService.updateSystemParameter(map);
		return "reload";
	}
}
