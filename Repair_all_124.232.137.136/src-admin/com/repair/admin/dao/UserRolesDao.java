package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.DictArea;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;


/**
 * 用户角色管理
 * @author lll
 *
 */
public interface UserRolesDao {
	/**
	 * 查询班组
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
	 * 通过ID获取班组信息
	 * @param DictProteam id
	 */
	public DictProTeam getDictProteamById(long id);
	
	/**
	 * 删除班组
	 */
	public void delDictProTeam(long proteamId);
	
	/**
	 * 查询班组下是否有用户
	 */
	public long findUser(long proteamId);
	
	/**
	 * 新增用户
	 */
	public void saveOrUpdateUserPrivs(UsersPrivs usersPrivs);
	
	/**
	 * 新增用户角色
	 */
	public void saveOrUpdateUserRolePrivs(UserRolePrivs userrolePrivs);
	
	/**
	 * 删除用户
	 */
	public void delUserPrivs(long userId);
	
	/**
	 * 删除用户角色
	 */
	public void delUserRolePrivs(long userId);
	
	/**
	 * 查询用户信息
	 * @param UsersPrivs id
	 */
	public UsersPrivs getUsersPrivsById(long id);
	
	/**
	 * 查询用户角色信息
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
	
	/**
	 * 根据条件查询人员信息,分页
	 * @return
	 */
	public PageModel<UsersPrivs> findUsersPrivs(String gonghao,String xm,Long roleid,Long bzId);
	
	/**
	 * 更改用户班组
	 */
	public void UpdateUserBz(long userId,int bzId);
	
	/**
	 * 查询用户角色
	 */
	public RolePrivs getRolePrivsById(long roleid);
}
