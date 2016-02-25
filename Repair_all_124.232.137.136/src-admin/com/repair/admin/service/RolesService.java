package com.repair.admin.service;

import java.util.List;

import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;

public interface RolesService {

	/**
	 * 保存角色
	 */
	public void saveOrUpdateRole(RolePrivs rolePrivs);

	/**
	 * 删除角色
	 */
	public String deleteRoleById(long roleid);

	/**
	 * 根据roleid查找是否存在用户
	 */
	public long findUser(long roleid);
	
	/**
	 * 根据roleid查找角色
	 */
	public RolePrivs findRole(long roleid);
	
	/**
	 * 根据parentId查询功能
	 * */
	public List<FunctionPrivs> findFunctions(long parentId);
	
	/**
	 * 根据parentId查询父级功能名称
	 * */
	public String findFunName(long parentId);
	
	/**
	 * 保存角色功能关联
	 * */
	public void saveRoleFuncPrivs(String[] ids,long roleId);
	
	/**
	 * 根据角色id查出功能
	 * */
	public List<RoleFuncPrivs> findRoleFuncs(long roleId);	

	/**
	 * 根据角色id查询所有子功能
	 * */
	public List<FunctionPrivs> findAllChildFunctions(long roleId);
	 
	public List<RoleFuncPrivs> findRoleFunctions(long roleId,long parentId);
	
}
