package com.repair.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.comet4j.core.CometConnection;
import org.comet4j.core.CometContext;
import org.comet4j.core.CometEngine;
import org.json.JSONException;
import org.json.JSONObject;

public class CometUtil {
	
	private static Map<Long, List<String>> connMap = new HashMap<Long, List<String>>();
	
	/**
	 * 发送消息
	 * @param rjhmId 日计划ID
	 * @param xx 修程修次
	 * @param bzId 有报活的班组
	 * @param jctype 车型
	 * @param jcnum 车号
	 * @param nodeId 当前日计划节点ID
	 */
	public static void send(int rjhmId,String xx,Long bzId,String jcType, String jcNum,Integer projectType,Integer nodeId) {
		CometContext context = CometContext.getInstance();
		CometEngine engine = context.getEngine();
		List<String>  ids = connMap.get(bzId);
		List<CometConnection> list = new ArrayList<CometConnection>();
		JSONObject obj = new JSONObject();
		String info = null;
		try {
			obj.accumulate("rjhmId", rjhmId);
			obj.accumulate("xx", xx);
			obj.accumulate("jctype", jcType);
			obj.accumulate("jcnum", jcNum);
			obj.accumulate("projectType", projectType);
			obj.accumulate("nodeId", nodeId);
			info = obj.toString();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		if(ids!=null && ids.size()>0){
			for(String id : ids) {
				list.add(engine.getConnection(id));
			}
			engine.sendTo("report", list, info);
		}
	}
	
	/**
	 * 新增连接
	 * @param bzId
	 * @param connId
	 */
	public static void addConnect(Long bzId,String connId){
		if(CometUtil.connMap.get(bzId)==null){
			CometUtil.connMap.put(bzId, new ArrayList<String>());
		}
		CometUtil.connMap.get(bzId).add(connId);
	}
	
	/**
	 * 断开连接
	 * @param bzId
	 * @param connId
	 */
	public static void removeConnect(Long bzId,String connId){
		if(CometUtil.connMap.get(bzId)!=null  && connId!=null && !"".equals(connId)){
			CometUtil.connMap.get(bzId).remove(connId);
		}
	}
}
