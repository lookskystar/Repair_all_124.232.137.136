package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;

public interface RolesDao {

	/**
	 * 保存角色
	 */
	public void saveOrUpdateRole(RolePrivs roleprivs);

	/**
	 * 根据角色ID 删除角色
	 */
	public void deleteRole(long roleid);

	/**
	 * 查找角色下是否存在用户
	 */
	public long findUsers(long roleid);

	/**
	 * 根据角色ID查找角色
	 */
	public RolePrivs findRole(long roleid);

	/**
	 * 修改角色
	 */
	public void editRole(long roleid);
	
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
	public void saveRoleFuncPrivs(RoleFuncPrivs roleFuncPrivs);
	
	/**
	 * 根据角色id删除角色功能关联
	 * */
	public void deleteRoleFuncPrivs(long roleId);
	
	/**
	 * 根据角色id查出功能
	 * */
	public List<RoleFuncPrivs> findRoleFuncs(long roleId);
	
	public List<RoleFuncPrivs> findRoleFunctions(long roleId,long parentId);
	
	/**
	 * 根据角色id查询所有子功能
	 * */
	public List<FunctionPrivs> findAllChildFunctions(long roleId);
}
