package com.repair.admin.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.ReportTemplateService;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.ItemRelation;
import com.repair.common.pojo.JCFixitem;

/**
 * 报表模板
 * @author Administrator
 *
 */
public class ReportTemplateAction {

	HttpServletRequest request = ServletActionContext.getRequest();
	
	@Resource(name="reportTemplateService")
	private ReportTemplateService reportTemplateService;
	
	/**
	 * 查询报表模板项目
	 * @return
	 * @throws Exception
	 */
	public String searchTemplateItem() throws Exception {
		String jcType = request.getParameter("jctype");
		List<DictJcStype> jcTypes = reportTemplateService.listDictSTypes();
		if(jcType==null || "".equals(jcType)){
			jcType = jcTypes.get(0).getJcStypeValue();
		}
		List<ItemRelation> relations = reportTemplateService.listItemRelation(jcType);
		request.setAttribute("jcType", jcType);
		request.setAttribute("jcTypes", jcTypes);
		
		Map<String,Map<String,List>> result = new LinkedHashMap<String, Map<String,List>>(); 
		String firstUnitName;
		String itemName;
		for (ItemRelation itr : relations) {
			firstUnitName = itr.getFirstUnitName();
			itemName = itr.getFixItem();
			if(result.get(firstUnitName)==null){
				result.put(firstUnitName, new LinkedHashMap<String,List>());
			}
			if(result.get(firstUnitName).get(itemName)==null){
				result.get(firstUnitName).put(itemName, new ArrayList<ItemRelation>());
			}
			result.get(firstUnitName).get(itemName).add(itr);
		}
		
		request.setAttribute("map", result);
		return "template";
	}
	
	/**
	 * 查询检修项目
	 */
	public String searchFixItem() throws Exception {
		String jcType = request.getParameter("jctype");
		request.setAttribute("jctype", jcType);
		
		List<DictFirstUnit> units = null;
		if(jcType!=null && !"".equals(jcType)){
			units = reportTemplateService.listDictFirstUnits(jcType);
			request.setAttribute("units", units);
			List<JCFixitem> fixitems = reportTemplateService.listJCFixitem(jcType,null);
			request.setAttribute("fixitems", fixitems);
			
			Map<String, Map<String, List<JCFixitem>>> result = new LinkedHashMap<String, Map<String,List<JCFixitem>>>();
			String firstUnitName;
			String secondUnitName;
			for (JCFixitem itm : fixitems) {
				firstUnitName = itm.getUnitName();
				secondUnitName = itm.getSecUnitName();
				if(result.get(firstUnitName)==null){
					result.put(firstUnitName, new LinkedHashMap<String, List<JCFixitem>>());
				}
				if(result.get(firstUnitName).get(secondUnitName)==null){
					result.get(firstUnitName).put(secondUnitName, new ArrayList<JCFixitem>());
				}
				result.get(firstUnitName).get(secondUnitName).add(itm);
			}
			request.setAttribute("map", result);
		}
		return "fixitem";
	}
	
	/**
	 * 保存关联
	 */
	public String saveRelation() throws Exception {
		try{
			//模板ID
			String tpId = request.getParameter("tpid"); 
			//关联的项目IDS
			String itemsIds = request.getParameter("itmids");
			reportTemplateService.updateItemRelation(Integer.parseInt(tpId), itemsIds);
			ServletActionContext.getResponse().getWriter().print("success");
		}catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failure");
		}
		return null;
	}
}
