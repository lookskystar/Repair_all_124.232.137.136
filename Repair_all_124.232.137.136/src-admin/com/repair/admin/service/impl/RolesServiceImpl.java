package com.repair.admin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.admin.dao.RolesDao;
import com.repair.admin.service.RolesService;
import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;

public class RolesServiceImpl implements RolesService {

	@Resource(name = "rolesDao")
	private RolesDao rolesDao;

	@Override
	public void saveOrUpdateRole(RolePrivs rolePrivs) {
		rolesDao.saveOrUpdateRole(rolePrivs);
	}

	@Override
	public String deleteRoleById(long roleid) {
		rolesDao.deleteRole(roleid);
		return "success";
	}

	@Override
	public long findUser(long roleid) {
		long count = rolesDao.findUsers(roleid);
		return count;
	}

	@Override
	public RolePrivs findRole(long roleid) {
		RolePrivs role = rolesDao.findRole(roleid);
		return role;
	}

	@Override
	public List<FunctionPrivs> findFunctions(long parentId) {
		return rolesDao.findFunctions(parentId);
	}

	@Override
	public String findFunName(long parentId) {
		return rolesDao.findFunName(parentId);
	}

	@Override
	public void saveRoleFuncPrivs(String[] ids, long roleId) {
		rolesDao.deleteRoleFuncPrivs(roleId);
		for(String id : ids){
			RolePrivs rolePrivs = new RolePrivs();
			FunctionPrivs functionPrivs = new FunctionPrivs();
			RoleFuncPrivs roleFuncPrivs = new RoleFuncPrivs();
			rolePrivs.setRoleid(roleId);
			functionPrivs.setFid(Long.parseLong(id));
			roleFuncPrivs.setRole(rolePrivs);
			roleFuncPrivs.setFunction(functionPrivs);
			rolesDao.saveRoleFuncPrivs(roleFuncPrivs);
		}
	}

	@Override
	public List<RoleFuncPrivs> findRoleFuncs(long roleId) {
		return rolesDao.findRoleFuncs(roleId);
	}
	
	public List<RoleFuncPrivs> findRoleFunctions(long roleId,long parentId){
		return rolesDao.findRoleFunctions(roleId,parentId);
	}

	@Override
	public List<FunctionPrivs> findAllChildFunctions(long roleId) {
		return rolesDao.findAllChildFunctions(roleId);
	}
}
