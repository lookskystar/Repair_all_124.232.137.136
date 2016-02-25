package com.repair.work.action;


import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.util.CollectionUtils;

import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.service.ProteamEntryService;
import com.repair.work.service.UsersPrivsService;

/**
 * 用户登录Action
 * @author jiangxiaolong
 *
 */
public class LoginAction implements ServletRequestAware{

	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="userRolesService")
	private UserRolesService userRolesService;
	@Resource(name="proteamEntryService")
	private ProteamEntryService proteamEntryService; 
	
	private HttpServletRequest request;
	private UsersPrivs user;
	
	/**
	 * 用户登录
	 * @return
	 */
	public String login(){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String idkid = request.getParameter("idkid");
		String userid = request.getParameter("userid");
		String pj=request.getParameter("pj");
		//判断考勤系统是否启用
		String parameterValue = proteamEntryService.findSystemParameter().getParameterValue();
		request.getSession().setAttribute("parameterValue", parameterValue);
		if(idkid!=null && !"".equals(idkid)){
			user = usersPrivsService.login(idkid);
			if(user == null){
				request.setAttribute("loginError", "读卡错误,请确认IC卡！");
				return "loginOut";
			}
		}else if (userid!=null && !"".equals(userid)){
			try{
				user = usersPrivsService.getUsersPrivsById(Long.parseLong(userid));
				if(user == null){
					request.setAttribute("loginError", "连接错误,请输入用户名和密码登陆！");
					return "loginOut";
				}
			}catch(Exception e){
				request.setAttribute("loginError", "连接错误,请输入用户名和密码登陆！");
				return "loginOut";
			}
		}else{
			user = usersPrivsService.login(username,password);
			if(user == null){
				request.setAttribute("loginError", "您输入的用户名或密码不对，请重新输入！");
				return "loginOut";
			}
			if(user.getBzid() != null){
				DictProTeam proteam = userRolesService.getDictProteamById(user.getBzid());
				request.getSession().setAttribute("session_user_proteam", proteam);
			}
		}
		request.getSession().setAttribute("session_user", user);
		String roles = ",";
		if(user.getRolePrivs()!=null){
			for (Iterator it = user.getRolePrivs().iterator(); it.hasNext();) {
				RolePrivs rp = (RolePrivs) it.next();
				roles = roles + rp.getPy()+",";
			}
		}
		user.setRoles(roles);
		if(pj!=null&&pj.equals("pjjx")){
			return "pj_main";
		}
		if(",DZ,".equals(user.getRoles()) || ",DLD,".equals(user.getRoles()) || ",ZR,".equals(user.getRoles())){
			return "lead_main";
		}else if(",JCGZ,".equals(user.getRoles())||",DD,".equals(user.getRoles())){
			return "jcgz_main";
		}else if(",JTLD,".equals(user.getRoles())){
			request.setAttribute("type", 1);
			return "count";
		}else{
			return "main";
		}
		//return "main";
	}
	
	@Override
	public void setServletRequest(HttpServletRequest req) {
		this.request = req;
		
	}
	
	/**
	 * 用户通过Ajax登陆
	 * @return
	 */
	public String ajaxLogin(){
		HttpServletResponse response=ServletActionContext.getResponse();
		String result="success";
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String idkid = request.getParameter("idkid");
		if(idkid!=null && !"".equals(idkid)){
			user = usersPrivsService.login(idkid);
		}else{
			user = usersPrivsService.login(username,password);
		}
		if(user==null){
			result="login_failure";
		}else{
			String roles = ",";
			if(user.getRolePrivs()!=null){
				for (Iterator it = user.getRolePrivs().iterator(); it.hasNext();) {
					RolePrivs rp = (RolePrivs) it.next();
					roles = roles + rp.getPy()+",";
				}
			}
			user.setRoles(roles);
			if(request.getSession().getAttribute("session_signer") != null){
			   request.getSession().removeAttribute("session_signer");
			}
			request.getSession().setAttribute("session_signer", user);
		}
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入相应的用户页面
	 * @return
	 */
	public String userMainInput(){
		user=(UsersPrivs)request.getSession().getAttribute("session_user");
		if(",DZ,".equals(user.getRoles()) || ",DLD,".equals(user.getRoles()) || ",ZR,".equals(user.getRoles())){
			return "lead_main";
		}else if(",JCGZ,".equals(user.getRoles())||",DD,".equals(user.getRoles())){
			return "jcgz_main";
		}else{
			return "main";
		}
	}
	
	/**
	 * 用户退出
	 * @return
	 */
	public String loginOut(){
		request.getSession().removeAttribute("session_user");
		request.getSession().setAttribute("session_user", null);
		return "loginOut";
	}
	
	/**
	 * 用户修改密码
	 * @return
	 */
	public String updatePwd(){
		HttpServletResponse response=ServletActionContext.getResponse();
		String new_pwd=request.getParameter("new_pwd");
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String result="failure";
		if(user==null){
			result="session_null";
		}else{
			user.setPwd(new_pwd);
			usersPrivsService.saveOrUpdateUser(user);
			result="success";
		}
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Ajax登陆窗口
	 */
	public String ajaxLoginInput(){
		String rjhmId = request.getParameter("rjhmId");
		request.setAttribute("rjhmId", rjhmId);
		return "ajaxLoginInput" ;
	}
	
	/**
	 * 用户权限读取
	 * */
	public String getUserFuncs(){
		int type = Integer.parseInt(request.getParameter("type"));
		UsersPrivs user = (UsersPrivs)request.getSession().getAttribute("session_user");
		user = usersPrivsService.login(user.getGonghao(),user.getPwd());
		Map<String, List<RoleFuncPrivs>> resultMap = null;
		List<UserRolePrivs> userRolePrivsList = usersPrivsService.findRolePrivsByUserId(user.getUserid());
		RolePrivs rolePrivs = null;
		if(!CollectionUtils.isEmpty(userRolePrivsList)){
			for (UserRolePrivs userRolePrivs : userRolePrivsList) {
				rolePrivs = userRolePrivs.getRole();
				resultMap = usersPrivsService.getDictFunctionsByUser(type,rolePrivs.getRoleid());
			}
		}
		request.setAttribute("resultMap", resultMap);
		return "z_left";
	}
}
