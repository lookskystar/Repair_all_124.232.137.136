package com.repair.admin.service;

import java.util.List;

import com.repair.common.pojo.DictArea;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.util.PageModel;


public interface UserRolesService {
	/**
	 * 查询工作班组
	 */
	public List<DictProTeam> listDictProTeam();
	
	/**
	 * 查询小辅修班组
	 * @return
	 */
	public List<DictProTeam> listXXDictProTeam();
	
	/**
	 * 查询区域
	 */
	public List<DictArea> listDictArea();
	
	/**
	 * 查询机务段
	 */
	public List<DictJwd> listDictJwd();
	
	/**
	 * 新增班组
	 */
	public void saveOrUpdateDictProTeam(DictProTeam dictproteam);
	
	/**
	 * 通过班组名称获取班组信息
	 */
	public DictProTeam getDictProTeam(String proteamname);
	
	/**
	 * 删除班组
	 */
	public String delDictProTeam(long proteamId);
	
	/**
	 * 查询班组信息
	 * @param DictProteam id
	 */
	public DictProTeam getDictProteamById(long id);
	
	/**
	 * 根据bzid或proteamId查找是否存在用户
	 */
	public long findUser(long proteamId);
	
	/**
	 * 新增用户
	 */
	public void saveUserPrivs(UsersPrivs usersPrivs,long roleId);
	
	
	public void saveOrUpdateUserPrivs(UsersPrivs usersPrivs);
	
	/**
	 * 新增用户角色
	 */
	public void saveOrUpdateUserRolePrivs(UserRolePrivs userrolePrivs);
	
	/**
	 * 删除用户及对应的角色
	 */
	public String delUserPrivs(String[] userIdArray);
	
	/**
	 * 查询用户信息
	 * @param UsersPrivs id
	 */
	public UsersPrivs getUsersPrivsById(long id);
	
	/**
	 * 查询用户角色信息
	 * @param UsersPrivs id
	 */
	public UserRolePrivs getUserRolePrivsById(long id);
	
	/**
	 * 获取班组下的所有组员
	 */
	public List<UsersPrivs> listUsersByBzId(Long bzId);
	
	/**
	 * 查询角色
	 * */
	public List<RolePrivs> listRolePrivs();
	
	/**
	 * 查询机车型号
	 * */
	public List<DictJcStype> listDictJcStype();
	
	public PageModel<UsersPrivs> findUsersPrivs(String gonghao,String xm,Long roleid,Long bzId);
	
	/**
	 * 更改用户班组
	 */
	public String UpdateUserBz(String[] userIdArray,int bzId);
	
	/**
	 * 查询用户角色
	 */
	public RolePrivs getRolePrivsById(long roleid);
}
