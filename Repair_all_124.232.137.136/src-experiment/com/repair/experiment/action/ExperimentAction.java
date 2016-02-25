package com.repair.experiment.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JcExpSignRec;
import com.repair.common.pojo.JcExperimentItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.experiment.service.ExperimentService;


public class ExperimentAction extends BaseAction{

	private static final long serialVersionUID = 6820047462639009727L;
	@Autowired
	private ExperimentService experimentService;
	
	/**
	 * 进入试验
	 * @return
	 */
	public String enterExperiment(){
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		request.setAttribute("rjhmId", rjhmId);
		request.setAttribute("xtype", getItemType(request.getParameter("xx")));
		DatePlanPri datePlan = experimentService.findDatePlanPriById(rjhmId);
		int flowId = datePlan.getNodeid().getJcFlowId();
//		if(flowId == Contains.ZX_SY_NODEID){
//			List<JcExperimentItem> experiments = experimentService.findJcExperimentsByFlowIdAndJcType(flowId,datePlan.getJcType());
//			request.setAttribute("experiments", experiments);
//			request.setAttribute("jcTypeNum", datePlan.getJcType()+"-"+datePlan.getJcnum());
//			request.setAttribute("datePlan", datePlan);
//			if(datePlan.getJcType().contains(Contains.JC_TYPE_OIL_PREFIX)){//DF
//				return "zx_experiment";
//			}else if(datePlan.getJcType().contains(Contains.JC_TYPE_ELECTRIC_PREFIX)){//SS
//				return "zx_experiment";
//			}else{//其他类型机车
//				return "zx_no_experiment";
//			}
//		}else if(flowId == Contains.ZX_SYX_NODEID){
//			return "zx_tryrun";
//		}
		List<JcExperimentItem> experiments = experimentService.findJcExperimentsByFlowIdAndJcType(flowId,datePlan.getJcType());
		request.setAttribute("experiments", experiments);
		request.setAttribute("jcTypeNum", datePlan.getJcType()+"-"+datePlan.getJcnum());
		request.setAttribute("datePlan", datePlan);
		return "zx_experiment";
	}
	
	/**
	 * 进入签认试验项目页面
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String tosignExpItem() throws UnsupportedEncodingException{
//		String expType = new String(request.getParameter("expType").getBytes("iso-8859-1"),"utf-8");
		String expType = request.getParameter("expType");
		//expType = new String(expType.getBytes("ISO8859-1"), "UTF-8");

		String expId = request.getParameter("expId");
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		String roleFlag = request.getParameter("roleFlag"); //角色标识
		String major = request.getParameter("major");  //专业标识
		UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
		String itemStrs = experimentService.findChoicedItemStrs(user.getUserid(),rjhmId);
		DatePlanPri datePlanPri = experimentService.findDatePlanPriById(rjhmId);
		Map<String,String> itemRecs =experimentService.findSignedExpItems(expId,rjhmId); 
		request.setAttribute("itemStrs", itemStrs);
		request.setAttribute("datePlan", datePlanPri);
		request.setAttribute("expId", expId);
		request.setAttribute("roleFlag", roleFlag);
		request.setAttribute("itemRecs", itemRecs);
		//初次进入试验时，产生一条试验记录
		experimentService.saveJcExperimentByDatePlanAndExpId(rjhmId,expId);
		JcExpRec expriment = experimentService.findJcExperimentByDatePlanAndExpId(rjhmId,expId);
		request.setAttribute("experiment", expriment);
		Map<String, String> recMap = new LinkedHashMap<String, String>();
		if(expType.contains("水阻")){
			List<JcExpSignRec> signRecs = experimentService.findJcExpSignRecsByPlanAndExp(rjhmId,expId);
			if(signRecs!=null && signRecs.size()>0){
				int role = Integer.parseInt(roleFlag);
				switch (role) {
				case 2:
					//在页面上显示签认人的信息
					for (JcExpSignRec esRec : signRecs) {
						recMap.put(esRec.getItemName(), esRec.getLeader());
						StringBuilder sb = new StringBuilder();
						if(esRec.getLeader()!=null){
							sb.append("工长：").append(esRec.getLeader()).append(",");
							if(esRec.getQi()!=null){
								sb.append("质检员：").append(esRec.getQi()).append(",");
							}
							if(esRec.getTeachName()!=null){
								sb.append("技术员：").append(esRec.getTeachName()).append(",");
							}
						}
						sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
						recMap.put(esRec.getItemName()+"info", sb.toString());
					}
					break;
				case 3:
					for (JcExpSignRec esRec : signRecs) {
						recMap.put(esRec.getItemName(), esRec.getQi());
						StringBuilder sb = new StringBuilder();
						if(esRec.getLeader()!=null){
							sb.append("工长：").append(esRec.getLeader()).append(",");
							if(esRec.getQi()!=null){
								sb.append("质检员：").append(esRec.getQi()).append(",");
							}
							if(esRec.getTeachName()!=null){
								sb.append("技术员：").append(esRec.getTeachName()).append(",");
							}
						}
						sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
						recMap.put(esRec.getItemName()+"info", sb.toString());
					}
					break;
				case 4:
					for (JcExpSignRec esRec : signRecs) {
						recMap.put(esRec.getItemName(), esRec.getTeachName());
						StringBuilder sb = new StringBuilder();
						if(esRec.getLeader()!=null){
							sb.append("工长：").append(esRec.getLeader()).append(",");
							if(esRec.getQi()!=null){
								sb.append("质检员：").append(esRec.getQi()).append(",");
							}
							if(esRec.getTeachName()!=null){
								sb.append("技术员：").append(esRec.getTeachName()).append(",");
							}
						}
						sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
						recMap.put(esRec.getItemName()+"info", sb.toString());
					}
					break;
				case 5:
					for (JcExpSignRec esRec : signRecs) {
						StringBuilder sb = new StringBuilder();
						if(esRec.getLeader()!=null){
							sb.append("工长：").append(esRec.getLeader()).append(",");
							if(esRec.getQi()!=null){
								sb.append("质检员：").append(esRec.getQi()).append(",");
							}
							if(esRec.getTeachName()!=null){
								sb.append("技术员：").append(esRec.getTeachName()).append(",");
							}
						}
						sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
						recMap.put(esRec.getItemName()+"info", sb.toString());
					}
					break;
				case 6:
					for (JcExpSignRec esRec : signRecs) {
						StringBuilder sb = new StringBuilder();
						if(esRec.getLeader()!=null){
							sb.append("工长：").append(esRec.getLeader()).append(",");
							if(esRec.getQi()!=null){
								sb.append("质检员：").append(esRec.getQi()).append(",");
							}
							if(esRec.getTeachName()!=null){
								sb.append("技术员：").append(esRec.getTeachName()).append(",");
							}
							if(esRec.getCommitLead()!=null){
								sb.append("交车工长：").append(esRec.getCommitLead()).append(",");
							}
						}
						sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
						recMap.put(esRec.getItemName()+"info", sb.toString());
					}
					break;
				}
			}
			request.setAttribute("recMap", recMap);
			if("1".equals(roleFlag.trim())){
				return "szsySignItem";
			}else if("5".equals(roleFlag.trim()) || "6".equals(roleFlag.trim())){
				return "szsySignAllItem";
			}else{
				return "szsyLeadSignItem";
			}
		}else if(expType.contains("高低压")){
			if("1".equals(roleFlag.trim())){
				return "gdysySignItem";
			}else{
				return "gdysyLeadSignItem";
			}
		}else if(expType.contains("顶轮")){
			if("1".equals(roleFlag.trim())){
				return "dlsySignItem";
			}else{
				return "dlsyLeadSignItem";
			}
		}else{//试运行
			//东风车试运行
			if(datePlanPri.getJcType().contains("DF")){
				if("1".equals(roleFlag.trim())){
					return "syxsySignItem";
				}else{
					StringBuilder sb = new StringBuilder();
					if(expriment.getLeader()!=null){
						sb.append("工长：").append(expriment.getLeader()).append(",");
						if(expriment.getQi()!=null){
							sb.append("质检员：").append(expriment.getQi()).append(",");
						}
						if(expriment.getTeachName()!=null){
							sb.append("技术员：").append(expriment.getTeachName()).append(",");
						}
					}
					sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
					recMap.put("others", sb.toString());
					request.setAttribute("recMap", recMap);
					return "syxsyLeadSignItem";
				}
			}else if(datePlanPri.getJcType().contains("SS")){
				if("1".equals(roleFlag.trim())){
					return "rrSyxsySignItem";
				}else{
					StringBuilder sb = new StringBuilder();
					if(expriment.getLeader()!=null){
						sb.append("工长：").append(expriment.getLeader()).append(",");
						if(expriment.getQi()!=null){
							sb.append("质检员：").append(expriment.getQi()).append(",");
						}
						if(expriment.getTeachName()!=null){
							sb.append("技术员：").append(expriment.getTeachName()).append(",");
						}
					}
					sb = sb.toString().contains(",")?sb.deleteCharAt(sb.lastIndexOf(",")):sb;
					recMap.put("others", sb.toString());
					request.setAttribute("recMap", recMap);
					return "rrSyxsyLeadSignItem";
				}
			}else{
				return null;
			}
		}
	}
	
	/**
	 * 签认试验时间
	 */
	public void signExpTime(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = response.getWriter();
			UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
			String expTime = request.getParameter("time");
			if(null==expTime || "".equals(expTime.trim())){
				result = "error";
			}else{
				int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
				String expId = request.getParameter("expId");
				Long experimentId = Long.parseLong(expId);
				experimentService.saveSignJcExperimentTime(user,expTime,rjhmId,experimentId);
			}
		} catch (IOException e) {
			result = "error";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}

	/**
	 * 工人签认试验项目
	 * @return
	 */
	public void signExpItem(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = response.getWriter();
			UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
			String itemName = request.getParameter("itemName");
			String itemVal = request.getParameter("itemVal");
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
			String expId = request.getParameter("expId");
			long experimentId = Long.parseLong(expId);
			experimentService.saveSignExperimentItemByWorker(user,itemName,itemVal,rjhmId,experimentId);
		} catch (IOException e) {
			result = "error";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	/**
	 * 修改一个试验项目的记录
	 */ 
	public void changeExpItemRec(){
		PrintWriter pw = null;
		String result = "保存成功";
		try {
			pw = response.getWriter();
			UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
			String recId = request.getParameter("recId");
			String itemVal = request.getParameter("itemVal");
			long itemRecId = Long.parseLong(recId);
			result = experimentService.saveChangeExpItemRecValByWorker(user,itemRecId,itemVal);
		} catch (IOException e) {
			result = "保存失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	/**
	 * 除工人以外的角色签认实验项目
	 */
	public void leadSignExpItem(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = response.getWriter();
			UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
			String itemName = request.getParameter("itemName");
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
			String expId = request.getParameter("expId");
			String roleFlag = request.getParameter("roleFlag");
			long experimentId = Long.parseLong(expId);
			result = experimentService.saveSignExperimentItemByLead(user,itemName,rjhmId,experimentId,roleFlag);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	/**
	 * 全签(工长、质检员、技术员、交车工长、验收员)
	 * @return
	 */
	public void signItemAll(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = response.getWriter();
			UsersPrivs user	= (UsersPrivs) request.getSession().getAttribute("session_user");
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
			String expId = request.getParameter("expId");
			String roleFlag = request.getParameter("roleFlag");
			Long experimentId = Long.parseLong(expId);
			result = experimentService.saveSignExperimentItemAll(user,rjhmId,experimentId,roleFlag);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	
	/**
	 * 判断修程修次
	 * 0：检修项目  1：临修、加改项目 2：秋整、春鉴项目
	 */
	private int getItemType(String jcfix){
		int type = 0;
		String temp = jcfix.replaceAll("[0-9]", "");
		if(Contains.PY_LX.equalsIgnoreCase(temp) || Contains.PY_JG.equalsIgnoreCase(temp)){
			type = 1;
		}else if(Contains.PY_QZ.equalsIgnoreCase(temp) || Contains.PY_CJ.equalsIgnoreCase(temp)){
			type = 2;
		}
		return type;
	}
}
