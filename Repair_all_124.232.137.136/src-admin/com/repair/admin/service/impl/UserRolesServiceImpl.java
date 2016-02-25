package com.repair.admin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.admin.dao.UserRolesDao;
import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.DictArea;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public class UserRolesServiceImpl implements UserRolesService{
	
	@Resource(name="userRolesDao")
	private UserRolesDao userRolesDao;
	

	@Override
	public String delDictProTeam(long proteamId) {
		userRolesDao.delDictProTeam(proteamId);
		return "success";
		
	}

	@Override
	public long findUser(long proteamId) {
		long count=userRolesDao.findUser(proteamId);
		return count;
	}
	
	@Override
	public void saveOrUpdateDictProTeam(DictProTeam dictproteam) {
		userRolesDao.saveOrUpdateDictProTeam(dictproteam);
		
	}

	/**
	 * 新增用户及角色
	 */
	public void saveUserPrivs(UsersPrivs usersPrivs,long roleId) {
		userRolesDao.saveOrUpdateUserPrivs(usersPrivs);
		
		RolePrivs role = new RolePrivs();
		role.setRoleid(roleId);
		UserRolePrivs userrolePrivs = new UserRolePrivs();
		userrolePrivs.setRole(role);
		userrolePrivs.setUser(usersPrivs);
		userRolesDao.saveOrUpdateUserRolePrivs(userrolePrivs);
	}
	
	/**
	 * 修改用户及角色
	 */
	public void saveOrUpdateUserPrivs(UsersPrivs usersPrivs) {
		userRolesDao.saveOrUpdateUserPrivs(usersPrivs);
	}
	
	@Override
	public void saveOrUpdateUserRolePrivs(UserRolePrivs userrolePrivs) {
		userRolesDao.saveOrUpdateUserRolePrivs(userrolePrivs);
		
	}
	
	@Override
	public String delUserPrivs(String[] userIdArray) {
		for (int i = 0; i < userIdArray.length; i++) {
			userRolesDao.delUserPrivs(Long.parseLong(userIdArray[i]));
			userRolesDao.delUserRolePrivs(Long.parseLong(userIdArray[i]));
		}
		return  "success";
	}
	
	public List<UsersPrivs> listUsersByBzId(Long bzId){
		return userRolesDao.listUsersByBzId(bzId);
	}

	@Override
	public List<RolePrivs> listRolePrivs() {
		return userRolesDao.listRolePrivs();
	}

	@Override
	public List<DictProTeam> listDictProTeam() {
		return userRolesDao.listDictProTeam();
	}
	
	@Override
	public List<DictProTeam> listXXDictProTeam() {
		return userRolesDao.listXXDictProTeam();
	}

	@Override
	public UsersPrivs getUsersPrivsById(long id) {
		return userRolesDao.getUsersPrivsById(id);
	}

	@Override
	public UserRolePrivs getUserRolePrivsById(long id) {
		return userRolesDao.getUserRolePrivsById(id);
	}
	
	@Override
	public List<DictJcStype> listDictJcStype() {
		return userRolesDao.listDictJcStype();
	}

	@Override
	public DictProTeam getDictProteamById(long id) {
		return userRolesDao.getDictProteamById(id);
	}
	
	@Override
	public PageModel<UsersPrivs> findUsersPrivs(String gonghao,String xm,Long roleid,Long bzId) {
		return userRolesDao.findUsersPrivs(gonghao,xm,roleid,bzId);
	}

	@Override
	public String UpdateUserBz(String[] userIdArray, int bzId) {
		for (int i = 0; i < userIdArray.length; i++) {
			userRolesDao.UpdateUserBz(Long.parseLong(userIdArray[i]), bzId);
		}
		return  "success";
		
	}

	@Override
	public List<DictArea> listDictArea() {
		return userRolesDao.listDictArea();
	}

	@Override
	public List<DictJwd> listDictJwd() {
		return userRolesDao.listDictJwd();
	}

	@Override
	public RolePrivs getRolePrivsById(long roleid) {
		return userRolesDao.getRolePrivsById(roleid);
	}

	@Override
	public DictProTeam getDictProTeam(String proteamname) {
		return userRolesDao.getDictProTeam(proteamname);
	}

	

	
}
