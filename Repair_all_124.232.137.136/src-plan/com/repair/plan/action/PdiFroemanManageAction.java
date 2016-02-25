package com.repair.plan.action;

import static com.repair.common.util.WebUtil.getSessionUsersPrivs;
import static com.repair.common.util.WebUtil.isEmpty;
import static com.repair.common.util.WebUtil.isUser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.morph.context.contexts.HttpServletContext;

import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UsersPrivs;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.plan.service.PlanManageService;
import com.repair.plan.vo.Dispatch;
import com.repair.work.service.JtPreDictService;
import com.repair.work.service.YSJCRecService;


/**
 * 交车工长复检控制
 * @author Administrator
 *
 */
public class PdiFroemanManageAction extends BaseAction{

	private static final long serialVersionUID = -4563797581750664423L;
	// 交车工长管理服务
	@Resource(name = "pdiFroemanManageService")
	private PdiFroemanManageService pdiFroemanManageService;
	// 计划管理服务
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	@Resource(name = "jtPreDictService")
	private JtPreDictService jtPreDictService;
	@Resource(name="ysjcRecService")
	private YSJCRecService ysjcRecService;
	
	private Dispatch dispatch;
	
	private String id;
	private String ids;
	private String type;
	
	/**
	 * 查询交车工长签字日计划
	 * @return
	 */
	public String findDatePlanBySign() {
		if (isUser()) {
			request.put("datePlanPris", pdiFroemanManageService.findDatePlanByPdiFroeman(getSessionUsersPrivs()));
			if (!isEmpty(id)) {
				List<JtPreDict> dicts =planManageService.findJtPreDictByDatePlan(Integer.parseInt(id));
				List<JtPreDict> smDicts = null;
				String bzNames = "";
				for (JtPreDict jtPreDict : dicts) {
					if(jtPreDict.getProTeamId()!=null){
						bzNames = pdiFroemanManageService.findDictProTeamById(jtPreDict.getProTeamId().getProteamid()).getProteamname()+",";
						smDicts = jtPreDictService.findSmJtPreDicts(jtPreDict.getPreDictId());
						for (JtPreDict temp : smDicts) {
							bzNames += pdiFroemanManageService.findDictProTeamById(temp.getProTeamId().getProteamid()).getProteamname()+",";
						}
						jtPreDict.setSmBzNames(bzNames);
					}
				}
				request.put("preDicts", dicts);
			}
		} else {
			request.put("message", "查询日计划失败（用户登录是否失效）！");
		}
		return "jcgz_main_map";	
//		return "finddateplanbysign";
	}
	
	/**
	 * 派工输入
	 * @return
	 */
	public String dispatchingInput() {
		request.put("dictProTeams", pdiFroemanManageService.findWorkDictProTeam());
		if (!isEmpty(type) && "1".equals(type)) {
			request.put("preDict", pdiFroemanManageService.findJtPreDictById(Integer.parseInt(ids)));
		}
		return "dispatchinginput";
	}
	
	/**
	 * 派工确认
	 * @return
	 */
	public String dispatchingConfirm() {
		if(!isEmpty(ids) && isUser()){
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			if (!isEmpty(ids) && null != dispatch) {
				List<Integer> preIds = new ArrayList<Integer>();
				String[] temp = ids.split(",");
				for (int i = 0; i < temp.length; i++) {
					preIds.add(Integer.parseInt(temp[i]));
				}
				pdiFroemanManageService.updateDispatching(preIds, dispatch, usersPrivs,1);//1为交车组判别字段
				request.put("message", "检修内容派工成功！");
			}
		}else{
			request.put("message", "检修内容操作失败（用户登录是否失效）！");
		}
		return findDatePlanBySign();
	}
	
	/**
	 * 派工删除
	 */
	public String ajaxDispatchingDelete(){
		String result="failure";
		if (isUser()) {
			if (!isEmpty(ids)) {
				JtPreDict preDict = null;
				String[] temp = ids.split(",");
				List<JtPreDict> smPreDicts = null;
				boolean flag = true;
				for (int i = 0; i < temp.length; i++) {
					preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(temp[i]));
					if (preDict.getRecStas()==0) {
						result="success";
					}else if(preDict.getRecStas()==1){
						
						smPreDicts = jtPreDictService.findSmJtPreDicts(preDict.getPreDictId());
						for (JtPreDict dt : smPreDicts) {
							if(dt.getRecStas()>1){
								flag = false;
								break;
							}
						}
						if(flag){
							jtPreDictService.delJtPreDictOfCancle(Integer.parseInt(temp[i]));
							result="success";
						}else{
							result="no_cancle";
						}
					}else{
						result="no_cancle";
					}
				}
			}
		} else {
			result="no_user";
		}
		HttpServletResponse out = (HttpServletResponse) ServletActionContext.getResponse();
		try {
			out.getWriter().write(result);
		} catch (Exception e) {
			try {
				out.getWriter().write("failure");
			} catch (IOException exception) {
				exception.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 日计划交车工长签字
	 * @return
	 */
	public String datePlanSign() {
		UsersPrivs user = getSessionUsersPrivs();
		if (!isEmpty(id) && isUser()) {
			Integer result = pdiFroemanManageService.updateDatePlanSign(Integer.parseInt(id),user.getUserid());
			//查询交车记录表是否有记录
			Long count = ysjcRecService.countYSJCRec(Integer.valueOf(id));
			if(count <= 0){
				//如果记录表不存在 生成记录
				ysjcRecService.addYSJCRec(Integer.valueOf(id));
			}
			switch (result) {
			case 1:
				request.put("message", "日计划签认失败，无法找到下一个流程节点！");
				break;
			case 2:
				request.put("message", "日计划签认失败，找不到下一个流程节点的检修班组！");
				break;
			case 4:
				request.put("message", "日计划签认失败，检修内容为空或还未分工完成！");
				break;
			case 5:
				request.put("message", "日计划下的检修记录已经存在！");
				break;

			default:
				request.put("message", "日计划签认成功！");
				id = null;
				break;
			}
		} else {
			request.put("message", "日计划签认失败（用户登录是否失效）！");
		}
		return findDatePlanBySign();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Dispatch getDispatch() {
		return dispatch;
	}

	public void setDispatch(Dispatch dispatch) {
		this.dispatch = dispatch;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
