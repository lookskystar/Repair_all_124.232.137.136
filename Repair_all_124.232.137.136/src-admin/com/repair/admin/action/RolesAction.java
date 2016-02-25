package com.repair.admin.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;

import com.repair.admin.service.RolesService;
import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;

public class RolesAction {

	@Resource(name = "rolesService")
	private RolesService roleService;

	@Resource(name = "userRolesService")
	private UserRolesService userRolesService;

	private RolePrivs role;

	public RolePrivs getRole() {
		return role;
	}

	public void setRole(RolePrivs role) {
		this.role = role;
	}

	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response = ServletActionContext.getResponse();

	/**
	 * 进入角色管理
	 */
	public String rolesInput() throws Exception {
		List<RolePrivs> rolePrivsList = userRolesService.listRolePrivs();
		request.setAttribute("rolePrivsList", rolePrivsList);
		return "roles";
	}

	/**
	 * 添加角色
	 */
	public String addRole() throws Exception {
		roleService.saveOrUpdateRole(role);
		request.setAttribute("message", "角色信息添加成功!");
		return rolesInput();
	}

	/**
	 * 删除角色
	 */
	public String deleteRoleById() throws Exception {
		long roleid = Long.parseLong(request.getParameter("id"));
		long count = roleService.findUser(roleid);
		if (count == 0) {
			roleService.deleteRoleById(roleid);
			request.setAttribute("message", "角色信息删除成功!");
		} else {
			request.setAttribute("message", "该角色存在用户不能删除!");
		}
		return rolesInput();
	}

	/**
	 * 进入编辑角色
	 */
	public String editRoleInput() {
		long roleid = Long.parseLong(request.getParameter("roleid"));
		RolePrivs role = roleService.findRole(roleid);
		request.setAttribute("role", role);
		return "editrole";
	}

	/**
	 * 编辑角色
	 */
	public String editRole() throws Exception {
		long roleid = Long.parseLong(request.getParameter("roleid"));
		RolePrivs rolePrivs = roleService.findRole(roleid);

		rolePrivs.setRolename(role.getRolename());
		rolePrivs.setPy(role.getPy());
		rolePrivs.setRolenote(role.getRolenote());

		roleService.saveOrUpdateRole(rolePrivs);
		request.setAttribute("message", "角色信息修改成功!");
		return rolesInput();
	}
	
	/**
	 * 进入角色授权页面
	 * */
	public String toPowerInput() {
		long roleId = Long.parseLong(request.getParameter("roleId"));
		RolePrivs rolePrivs = roleService.findRole(roleId);

		List<FunctionPrivs> grandFunctions = roleService.findFunctions(0);
		Map<String, Map<String, List<FunctionPrivs>>> funmap = new LinkedHashMap<String, Map<String, List<FunctionPrivs>>>();

		for (FunctionPrivs grandFunction : grandFunctions) {
			String grandFunctionName = grandFunction.getFunname();
			if (funmap.get(grandFunctionName) == null) {
				funmap.put(grandFunctionName,new LinkedHashMap<String, List<FunctionPrivs>>());
			}
			List<FunctionPrivs> fatherFunctions = roleService.findFunctions(grandFunction.getFid());
			for (FunctionPrivs fatherFunction : fatherFunctions) {
				String fatherFunctionName = fatherFunction.getFunname();
				if (funmap.get(grandFunctionName).get(fatherFunctionName) == null) {
					funmap.get(grandFunctionName).put(fatherFunctionName,new ArrayList<FunctionPrivs>());
				}
				List<FunctionPrivs> childFunctions = roleService.findFunctions(fatherFunction.getFid());
				for (FunctionPrivs child : childFunctions) {
					funmap.get(grandFunctionName).get(fatherFunctionName).add(child);
				}
			}
		}
		
		request.setAttribute("funMap", funmap);
		request.setAttribute("role", rolePrivs);
		return "toPowerInput";
	}
	
	/**
	 * 保存角色和功能
	 * */
	public String updaterolefunprivs() throws Exception{
		long roleid = Long.parseLong(request.getParameter("roleid"));
		String ids = request.getParameter("ids");
		if(ids!=null){
			String[] str = ids.split("-");
			roleService.saveRoleFuncPrivs(str, roleid);
		}else{
	    	roleService.saveRoleFuncPrivs(new String[]{},roleid);
	    }
	    response.setContentType("text/plain");
		response.getWriter().print("success");		
		return null;
	}
	
	/**
	 * 根据角色Id获得该角色所拥有的功能
	 */
	public String getRoleFunPrivsById() throws Exception {
		long roleID = Long.parseLong(request.getParameter("roleId"));
		List<RoleFuncPrivs> rolefun = null;
		try {
			rolefun=roleService.findRoleFuncs(roleID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject obj=new JSONObject();
		JSONArray array=new JSONArray();
		JSONObject obj2=null;
		for(RoleFuncPrivs list:rolefun){
			obj2=new JSONObject();
			obj2.put("funId", list.getFunction().getFid());
			array.put(obj2);
		}
		obj.put("funIds", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj.toString());
		return null;
	}
}
