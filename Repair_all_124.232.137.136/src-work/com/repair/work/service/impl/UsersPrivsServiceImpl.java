package com.repair.work.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.admin.service.RolesService;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.work.dao.UsersPrivsDao;
import com.repair.work.service.UsersPrivsService;

public class UsersPrivsServiceImpl implements UsersPrivsService {

	@Resource(name = "usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	@Resource(name = "rolesService")
	private RolesService roleService;

	public UsersPrivs login(String username, String password) {
		return usersPrivsDao.login(username, password);
	}

	public UsersPrivs login(String idkid) {
		return usersPrivsDao.login(idkid);
	}

	public boolean isHasRole(long userId, String roleName) {
		return usersPrivsDao.isHasRole(userId, roleName);
	}

	public UsersPrivs getUsersPrivsById(long userId) {
		return usersPrivsDao.getUsersPrivsById(userId);
	}

	public UsersPrivs getUserPrivsByCard(String cardnum) {
		return usersPrivsDao.getUserPrivsByCard(cardnum);
	}

	public Map<String, List<UsersPrivs>> getUsersPrivsById(final List<JCFixrec> fixrecs) {
		return usersPrivsDao.getUsersPrivsById(fixrecs);
	}

	public List<UsersPrivs> getUsersPrivsByRoleName(String roleName) {
		return usersPrivsDao.getUsersPrivsByRoleName(roleName);
	}

	public List<UsersPrivs> listUsersByBzId(Long bzId) {
		return usersPrivsDao.listUsersByBzId(bzId);
	}

	@Override
	public Object[] getUserMessage(long userId) {
		return usersPrivsDao.getUserMessage(userId);
	}

	@Override
	public List<UsersPrivs> getZJJSUsers() {
		return usersPrivsDao.getZJJSUsers();
	}

	@Override
	public void saveOrUpdateUser(UsersPrivs user) {
		usersPrivsDao.saveOrUpdateUser(user);
	}

	/**
	 * 查询机务段所有的班组
	 * 
	 * @return
	 */
	public List<DictProTeam> findBZList() {
		return usersPrivsDao.findBZList();
	}

	/**
	 * 分页查询当前用户所在班组的所有成员
	 * 
	 * @param user
	 *            当前用户
	 */
	public PageModel findPageModelBZWorkers(UsersPrivs user) {
		return usersPrivsDao.findPageModelBZWorkers(user);
	}

	@Override
	public Map<String, List<RoleFuncPrivs>> getDictFunctionsByUser(int type, long roleId) {
		// 所有大模块下的子功能
		List<FunctionPrivs> secondFunctions = roleService.findFunctions(type);
		Map<String, List<RoleFuncPrivs>> map = new HashMap<String, List<RoleFuncPrivs>>();
		for (FunctionPrivs functionPrivs : secondFunctions) {
			String parentName = functionPrivs.getFunname();
			List<RoleFuncPrivs> roleFuncPrivs = roleService.findRoleFunctions(roleId, functionPrivs.getFid());
			if (roleFuncPrivs != null && roleFuncPrivs.size() > 0) {
				map.put(parentName, roleFuncPrivs);
			}
		}
		return map;
	}

	@Override
	public List<UserRolePrivs> findRolePrivsByUserId(Long userId) {
		return usersPrivsDao.findRolePrivsByUserId(userId);
	}
}
