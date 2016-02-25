package com.repair.admin.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

/**
 * 用户角色
 * @author lll
 */
public class UserRolesAction {
	
	@Resource(name="userRolesService")
	private UserRolesService userRolesService;
	
	private UsersPrivs usersPrivs;
	private DictProTeam dictproteam;
	private UserRolePrivs userrolePrivs;
	private String gonghao;
	private String xm;
	private Long roleid;
	private Long bzId;
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	/**
	 * 进入用户角色管理页面
	 */
	public String usersInput() throws Exception {
		List<DictProTeam> dictProTeamList = userRolesService.listDictProTeam();//查询班组
		List<RolePrivs> rolePrivsList=userRolesService.listRolePrivs();//查询角色
		
		request.setAttribute("dictProTeamList", dictProTeamList);
		request.setAttribute("rolePrivsList",rolePrivsList);
		
		return "userindex";
	}
	
	/**
	 * 查询班组用户
	 */
	public String listUsers() throws Exception{
		PageModel<UsersPrivs> pm=userRolesService.findUsersPrivs(gonghao,xm,roleid,bzId);
		request.setAttribute("pm", pm);
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		request.setAttribute("bzid", bzId);
		return "users";
	}
	
	/**
	 * 进入新增班组
	 */
	public String addDictProTeamInput() throws Exception {
		List<DictJcStype> dictJcStypeList = userRolesService.listDictJcStype();//查询车型
		List<DictProTeam> dictProTeamList = userRolesService.listDictProTeam();//查询班组
		
		request.setAttribute("dictProTeamList", dictProTeamList);
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "adddictproteam";
	}
	
	
	/**
	 * 新增班组
	 * @return
	 * @throws Exception
	 */
	public String addDictProTeam() throws Exception{
		DictProTeam proteam = userRolesService.getDictProTeam(dictproteam.getProteamname());
		if (proteam == null) {
			String flag = request.getParameter("flag");
			if (flag.equals("0")) {
				dictproteam.setWorkflag(1);
				dictproteam.setZxFlag(0);
			} else if (flag.equals("1")) {
				dictproteam.setZxFlag(1);
				dictproteam.setWorkflag(0);
			} else if (flag.equals("2")) {
				dictproteam.setZxFlag(1);
				dictproteam.setWorkflag(1);
			} else if (flag.equals("3")) {
				dictproteam.setZxFlag(0);
				dictproteam.setWorkflag(0);
			}
			userRolesService.saveOrUpdateDictProTeam(dictproteam);
			request.setAttribute("message", "班组添加成功!");
			
		}else{
			request.setAttribute("message", "班组已经存在，添加失败!");
		}
		
		return usersInput();
	}
	
	/**
	 * 进入编辑班组
	 */
	public String editDictProTeamInput() throws Exception {
		DictProTeam dictproteam=userRolesService.getDictProteamById(Long.valueOf(request.getParameter("proteamId")));
		request.setAttribute("dictProTeamList", userRolesService.listDictProTeam());
		request.setAttribute("dictproteam", dictproteam);
		request.setAttribute("dictJcStypeList", userRolesService.listDictJcStype());
		return "editdictproteam";
	}
	
	/**
	 * 编辑班组
	 * @return
	 * @throws Exception
	 */
	public String editDictProTeam() throws Exception{
		DictProTeam proteam=userRolesService.getDictProteamById(Long.valueOf(request.getParameter("proteamId")));
		proteam.setProteamname(dictproteam.getProteamname());
		proteam.setPy(dictproteam.getPy());
		proteam.setJctype(dictproteam.getJctype());
		String flag = request.getParameter("flag");
		if (flag.equals("0")) {
			proteam.setWorkflag(1);
			proteam.setZxFlag(0);
		} else if (flag.equals("1")) {
			proteam.setZxFlag(1);
			proteam.setWorkflag(0);
		} else if (flag.equals("2")) {
			proteam.setZxFlag(1);
			proteam.setWorkflag(1);
		} else if (flag.equals("3")) {
			proteam.setZxFlag(0);
			proteam.setWorkflag(0);
		}
		
		userRolesService.saveOrUpdateDictProTeam(proteam);
		request.setAttribute("message", "班组修改成功!");
		return usersInput();
	}
	
	/**
	 * 删除班组
	 */
	public String delDictProTeam() throws Exception {
		long dictproteamid = Long.parseLong(request.getParameter("id"));
		long count = userRolesService.findUser(dictproteamid);
		if (count == 0) {
			userRolesService.delDictProTeam(dictproteamid);
			request.setAttribute("message", "班组信息删除成功!");
		} else {
			request.setAttribute("message", "该班组存在用户不能删除!");
		}
		return usersInput();
	}
		
	/**
	 * 进入新增用户
	 */
	public String addUserPrivsInput() throws Exception {
		request.setAttribute("dictProTeamList", userRolesService.listDictProTeam());
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		request.setAttribute("dictAreaList", userRolesService.listDictArea());
		request.setAttribute("dictJwdList", userRolesService.listDictJwd());
		return "adduser";
	}
	
	/**
	 * 新增用户
	 * @return
	 * @throws Exception
	 */
	public String addUserPrivs() throws Exception{
		try{
			String roleId = request.getParameter("roleid");
			userRolesService.saveUserPrivs(usersPrivs,Long.parseLong(roleId));
			request.setAttribute("message", "用户信息添加成功!");
		}catch (Exception e) {
			request.setAttribute("message", "用户信息添加失败!");
		}
		return usersInput();
	}
	
	/**
	 * 进入编辑用户
	 */
	public String editUserPrivsInput() throws Exception {
		UsersPrivs user=userRolesService.getUsersPrivsById(Long.valueOf(request.getParameter("userId")));
		request.setAttribute("dictProTeamList", userRolesService.listDictProTeam());
		request.setAttribute("dictAreaList", userRolesService.listDictArea());
		request.setAttribute("dictJwdList", userRolesService.listDictJwd());
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		
		request.setAttribute("user", user);
		return "edituser";
	}
	
	/**
	 * 编辑用户
	 * @return
	 * @throws Exception
	 */
	public String editUserPrivs() throws Exception{
		Long userId = Long.valueOf(request.getParameter("userId"));
		//获得当前UsersPrivs
		UsersPrivs user = userRolesService.getUsersPrivsById(userId);
		//获得要改变的角色id
		Long roleId = Long.valueOf(request.getParameter("roleid"));
		RolePrivs rolePrivs = userRolesService.getRolePrivsById(roleId);
		UserRolePrivs userrole=userRolesService.getUserRolePrivsById(userId);
		user.setJwdcode(usersPrivs.getJwdcode());
		user.setAreaid(usersPrivs.getAreaid());
		user.setIsuse(usersPrivs.getIsuse());
		user.setDepatid(usersPrivs.getDepatid());
		user.setBzid(usersPrivs.getBzid());
		user.setZwid(usersPrivs.getZwid());
		user.setXm(usersPrivs.getXm());
		user.setName(usersPrivs.getName());
		user.setGonghao(usersPrivs.getGonghao());
		user.setIdkid(usersPrivs.getIdkid());
		user.setPwd(usersPrivs.getPwd());
		user.setLogintime(usersPrivs.getLogintime());
		user.setProteamid(usersPrivs.getProteamid());
		user.setUptime(usersPrivs.getUptime());
		user.setSex(usersPrivs.getSex());
		user.setQue(usersPrivs.getQue());
		user.setAns(usersPrivs.getAns());
		user.setTel(usersPrivs.getTel());
		user.setFax(usersPrivs.getFax());
		user.setMobile(usersPrivs.getMobile());
		user.setMobile2(usersPrivs.getMobile2());
		user.setHomephone(usersPrivs.getHomephone());
		user.setAddress(usersPrivs.getAddress());
		user.setIp(usersPrivs.getIp());
		user.setQita(usersPrivs.getQita());
		userrole.setUser(user);
		userrole.setRole(rolePrivs);
		userRolesService.saveOrUpdateUserPrivs(user);
		userRolesService.saveOrUpdateUserRolePrivs(userrole);
		request.setAttribute("message", "用户信息编辑成功!");
		return usersInput();
	}
	
	
	/**
	 * 进入查看用户详情
	 */
	public String userInfoListInput() throws Exception {
		UsersPrivs user=userRolesService.getUsersPrivsById(Long.valueOf(request.getParameter("userId")));
		request.setAttribute("dictProTeamList", userRolesService.listDictProTeam());
		request.setAttribute("dictAreaList", userRolesService.listDictArea());
		request.setAttribute("dictJwdList", userRolesService.listDictJwd());
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		request.setAttribute("user", user);
		return "userinfolist";
	}

	/**
	 * 删除用户
	 * @return
	 * @throws Exception
	 */
	public String delUserPrivs() throws Exception {
		String result="failure";
		String userIdArray[] = ServletActionContext.getRequest().getParameter("users").split(",");
		if (userIdArray.length > 0) {
			userRolesService.delUserPrivs(userIdArray);
			result = "success";
		}
		
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}
	
	/**
	 * 进入角色管理
	 */
	public String rolesInput() throws Exception {
		List<RolePrivs> rolePrivsList=userRolesService.listRolePrivs();
		request.setAttribute("rolePrivsList",rolePrivsList);
		return "roles";
	}

	/**
	 * 进入更改用户班组
	 */
	public String updateUserBzInput() throws Exception {
		String userIds= request.getParameter("userIds");
		request.setAttribute("dictProTeamList", userRolesService.listDictProTeam());
		request.setAttribute("userIds", userIds);
		return "updateuserbz";
	}

	/**
	 * 更改用户班组
	 */
	public String updateUserBz() throws Exception {
		//参数
		String userIds = request.getParameter("userIds");
		String bzId = request.getParameter("bzId");
		String result="failure";
		String userIdArray[] =userIds.split(",");
		if(userIdArray.length>0){
		    userRolesService.UpdateUserBz(userIdArray,Integer.parseInt(bzId));
		    result="success";
		  }
		response.setContentType("text/plain");
		response.getWriter().write(result);
		request.setAttribute("message", "用户班组信息修改成功!");
		return usersInput();
	}
	
	public UserRolePrivs getUserrolePrivs() {
		return userrolePrivs;
	}

	public void setUserrolePrivs(UserRolePrivs userrolePrivs) {
		this.userrolePrivs = userrolePrivs;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public Long getRoleid() {
		return roleid;
	}

	public void setRoleid(Long roleid) {
		this.roleid = roleid;
	}

	public Long getBzId() {
		return bzId;
	}

	public void setBzId(Long bzId) {
		this.bzId = bzId;
	}

	public String getGonghao() {
		return gonghao;
	}

	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}

	public UsersPrivs getUsersPrivs() {
		return usersPrivs;
	}

	public void setUsersPrivs(UsersPrivs usersPrivs) {
		this.usersPrivs = usersPrivs;
	}
	
	public DictProTeam getDictproteam() {
		return dictproteam;
	}

	public void setDictproteam(DictProTeam dictproteam) {
		this.dictproteam = dictproteam;
	}

}
