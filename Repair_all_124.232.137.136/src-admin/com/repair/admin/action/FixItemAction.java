package com.repair.admin.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.admin.service.FixItemService;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;

/**
 * 检修项目Action
 * @author Administrator
 *
 */
public class FixItemAction {
	@Resource(name="fixItemService")
	private FixItemService fixItemService;
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response=ServletActionContext.getResponse();
	private String jcsType;//机车类型
	private Integer first;//一级部件ID
	private Integer second;//二级部件ID
	private Long teamId;//班组ID
	private String itemName;//项目名称
	private int itemType;//项目类型 0 全部 1 检查项目 2 检测项目
	//检修项目
	private JCFixitem fixItem;
	//中修检修项目
	private JCZXFixItem zxfixItem;
	 
	

	/**
	 * 进入项目信息页面
	 * @return
	 */
	public String itemListInput(){
		PageModel<JCFixitem> pm=fixItemService.findJcFixItem(jcsType,first,second,teamId,itemName,itemType);
		request.setAttribute("pm", pm);
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		return "itemList"; 
	}
	
	/**
	 * ajax根据机车类型得到一级部件
	 * @return
	 * @throws JSONException 
	 */
	public String ajaxGetFirstUnit() throws JSONException{
		String jcsType=request.getParameter("jcsType");
		List<DictFirstUnit> firstunits=fixItemService.findDictFirstUnit(jcsType);
		JSONArray array=new JSONArray();
		JSONObject map=new JSONObject();
		JSONObject obj=null;
		for(DictFirstUnit firstUnit:firstunits){
			obj=new JSONObject();
			obj.put("firstUnitId", firstUnit.getFirstunitid());
			obj.put("firstUnitName",firstUnit.getFirstunitname());
			array.put(obj);
		}
		map.put("firstUnits", array);
		response.setContentType("plain/text");
		try {
			response.getWriter().print(map.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * ajax得到一级部件下的二级部件
	 * @return
	 * @throws JSONException 
	 */
	public String ajaxGetSecondUnit() throws JSONException{
		Long firstUnitId=Long.parseLong(request.getParameter("firstUnitId"));
		List<DictSecunit> secUnits=fixItemService.findDictSecunit(firstUnitId);
		JSONArray array=new JSONArray();
		JSONObject map=new JSONObject();
		JSONObject obj=null;
		for(DictSecunit secUnit:secUnits){
			obj=new JSONObject();
			obj.put("secunitId", secUnit.getSecunitid());
			obj.put("secunitName", secUnit.getSecunitname());
			array.put(obj);
		}
		map.put("secunits", array);
		response.setContentType("plain/text");
		try {
			response.getWriter().print(map.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入项目详细信息
	 * @return
	 */
	public String itemInfoInput(){
		Integer itemId=Integer.parseInt(request.getParameter("itemId"));
		request.setAttribute("jcFixitem", fixItemService.findJCFixitemById(itemId));
		return "itemInfo";
	}
	
	/**
	 * 进入添加项目页面
	 * @return
	 */
	public String addItemInput(){
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		return "addItem";
	}
	
	/**
	 * 进入编辑项目页面
	 * @return
	 */
	public String editItemInput(){
		Integer itemId=Integer.parseInt(request.getParameter("itemId"));
		JCFixitem jcFixitem = fixItemService.findJCFixitemById(itemId);
		request.setAttribute("jcFixitem", jcFixitem);
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		return "editItem";
	}

	/**
	 * 添加项目信息
	 * 
	 * @return
	 */
	public String addItem() {
		JCFixflow fixflow = new JCFixflow();
		fixflow.setJcFlowId(Contains.XX_JX_NODEID);
		fixItem.setJcFixflow(fixflow);// 设置小辅修项目节点
		fixItem.setIsUsed((short) 1);// 设置启用
		fixItem.setItemCtrlLead(1);// 设置工长卡控		
		fixItemService.saveOrUpdateFixItem(fixItem);
		request.setAttribute("message", "项目信息添加成功!");
		return itemListInput();
	}

	/**
	 * 修改项目
	 */
	public String editItem() {
		Integer itemId = Integer.parseInt(request.getParameter("thirdUnitId"));
		JCFixitem jcFixitem = fixItemService.findJCFixitemById(itemId);

		jcFixitem.setJcsType(fixItem.getJcsType());
		jcFixitem.setFirstUnitId(fixItem.getFirstUnitId());
		jcFixitem.setUnitName(fixItem.getUnitName());
		jcFixitem.setSecUnitId(fixItem.getSecUnitId());
		jcFixitem.setSecUnitName(fixItem.getSecUnitName());
		jcFixitem.setPosiName(fixItem.getPosiName());

		String bzId = request.getParameter("proteamid");
		DictProTeam dictProteam = new DictProTeam();
		dictProteam.setProteamid(Long.valueOf(bzId));
		jcFixitem.setBanzuId(dictProteam);

		jcFixitem.setFillDefaVal(fixItem.getFillDefaVal());
		jcFixitem.setUnit(fixItem.getUnit());
		jcFixitem.setMin(fixItem.getMin());
		jcFixitem.setMax(fixItem.getMax());
		jcFixitem.setItemCtrlTech(fixItem.getItemCtrlTech());
		jcFixitem.setItemCtrlQI(fixItem.getItemCtrlQI());
		jcFixitem.setItemCtrlComLd(fixItem.getItemCtrlComLd());
		jcFixitem.setItemCtrlAcce(fixItem.getItemCtrlAcce());
		jcFixitem.setItemName(fixItem.getItemName());
		jcFixitem.setXcxc(fixItem.getXcxc());
		jcFixitem.setDuration(fixItem.getDuration());

		fixItemService.saveOrUpdateFixItem(jcFixitem);
		request.setAttribute("message", "项目信息修改成功!");
		return itemListInput();
	}

	/**
	 * 删除项目
	 */
	public String deleteItemInfo() throws Exception {
		String result = "failure";
		String itemArray[] = request.getParameter("itemId").split(",");
		if (itemArray.length > 0) {
			fixItemService.deleteItemInfo(itemArray);
			result = "success";
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}
	
	/**
	 * 查找中修项目
	 * @return
	 */
	public String zxFixItemList(){
		PageModel<JCZXFixItem> pm = fixItemService.findJcZxFixItem(jcsType, first, teamId, itemName , itemType);
		request.setAttribute("pm", pm);
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		return "zxFixItemList"; 
	}
	
	/**
	 * 删除中修项目
	 */
	public String deleteZxItemInfo() throws Exception {
		String result = "failure";
		String itemArray[] = request.getParameter("zxitemId").split(",");
		if (itemArray.length > 0) {
			fixItemService.deleteZxItemInfo(itemArray);
			result = "success";
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}
	
	/**
	 * 进入中修项目详细信息
	 * @return
	 */
	public String zxitemInfo(){
		Integer itemId=Integer.parseInt(request.getParameter("itemId"));
		request.setAttribute("jcZxFixitem", fixItemService.findJCZXFixItemById(itemId));
		request.setAttribute("pJStaticInfoList", fixItemService.listPJStaticInfo());
		return "zxitemInfo";
	}
	
	/**
	 * 进入添加中修项目页面
	 * @return
	 */
	public String addZxItemInput(){
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		request.setAttribute("pJStaticInfoList", fixItemService.listPJStaticInfo());
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		request.setAttribute("jcfixflow", fixItemService.findJCFixflow());
		return "addZxItem";
	}
	
	/**
	 * 添加中修项目信息
	 * 
	 * @return
	 */
	public String addZxItem() {
		zxfixItem.setItemCtrlLead((short)1);
		fixItemService.saveZxFixItem(zxfixItem);
		request.setAttribute("message", "项目信息添加成功!");
		return zxFixItemList();
	}
	
	/**
	 * 进入编辑项目页面
	 * @return
	 */
	public String editzxItemInput(){
		Integer itemId=Integer.parseInt(request.getParameter("itemId"));
		request.setAttribute("jczxFixitem", fixItemService.findJCZXFixItemById(itemId));
		request.setAttribute("pJStaticInfoList", fixItemService.listPJStaticInfo());
		request.setAttribute("proTeams", fixItemService.findDictProTeam());
		request.setAttribute("jcsTypes", fixItemService.findDictJcStype());
		request.setAttribute("jcfixflow", fixItemService.findJCFixflow());
		return "editzxItem";
	}
	
	/**
	 * 修改中修项目
	 */
	public String editzxItem() {
		Integer itemId = Integer.parseInt(request.getParameter("id"));
		JCZXFixItem jczxFixitem = fixItemService.findJCZXFixItemById(itemId);
		
		jczxFixitem.setFirstUnitId(zxfixItem.getFirstUnitId());
		jczxFixitem.setUnitName(zxfixItem.getUnitName());
		jczxFixitem.setPosiName(zxfixItem.getPosiName());
		
		jczxFixitem.setNodeId(zxfixItem.getNodeId());
		
		jczxFixitem.setItemName(zxfixItem.getItemName());
		jczxFixitem.setFillDefaval(zxfixItem.getFillDefaval());
		jczxFixitem.setMin(zxfixItem.getMin());
		jczxFixitem.setMax(zxfixItem.getMax());
		jczxFixitem.setUnit(zxfixItem.getUnit());
		jczxFixitem.setItemCtrlComld(zxfixItem.getItemCtrlComld());
		jczxFixitem.setItemCtrlQi(zxfixItem.getItemCtrlQi());
		jczxFixitem.setItemCtrlTech(zxfixItem.getItemCtrlTech());
		jczxFixitem.setItemCtrlAcce(zxfixItem.getItemCtrlAcce());
		jczxFixitem.setJcsType(zxfixItem.getJcsType());
		jczxFixitem.setXcxc(zxfixItem.getXcxc());
		jczxFixitem.setDuration(zxfixItem.getDuration());
		jczxFixitem.setAmount(zxfixItem.getAmount());
		jczxFixitem.setStdPJId(zxfixItem.getStdPJId());
		jczxFixitem.setItemCtrlRept(zxfixItem.getItemCtrlRept());
		
		String bzId = request.getParameter("zxfixItem.bzId.proteamid");
		jczxFixitem.setProTeam(bzId);
		DictProTeam dictProteam = new DictProTeam();
		dictProteam.setProteamid(Long.valueOf(bzId));
		jczxFixitem.setBzId(dictProteam);

		fixItemService.updateZxFixItem(jczxFixitem);
		request.setAttribute("message", "项目信息修改成功!");
		return zxFixItemList();
	}
	
	

	public JCZXFixItem getZxfixItem() {
		return zxfixItem;
	}

	public void setZxfixItem(JCZXFixItem zxfixItem) {
		this.zxfixItem = zxfixItem;
	}
	
	public JCFixitem getFixItem() {
		return fixItem;
	}

	public void setFixItem(JCFixitem fixItem) {
		this.fixItem = fixItem;
	}

	public String getJcsType() {
		return jcsType;
	}

	public void setJcsType(String jcsType) {
		this.jcsType = jcsType;
	}

	public Integer getFirst() {
		return first;
	}

	public void setFirst(Integer first) {
		this.first = first;
	}

	public Integer getSecond() {
		return second;
	}

	public void setSecond(Integer second) {
		this.second = second;
	}

	public Long getTeamId() {
		return teamId;
	}

	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemType() {
		return itemType;
	}

	public void setItemType(int itemType) {
		this.itemType = itemType;
	}
	
}
