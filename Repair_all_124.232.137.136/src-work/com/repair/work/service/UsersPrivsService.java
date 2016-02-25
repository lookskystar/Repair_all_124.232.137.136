package com.repair.work.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface UsersPrivsService {

	/**
	 * 用户登录
	 * @param username 用户名
	 * @param password 密码
	 * @return
	 */
	UsersPrivs login(String username, String password);
	
	/**
	 * 判断用户是否拥有指定角色
	 * @param userId 用户ID
	 * @param roleName 角色中文名字
	 */
	boolean isHasRole(long userId, String roleName);
	
	/**
	 * 根据ID获取用户
	 */
	public UsersPrivs getUsersPrivsById(long userId);
	
	/**
	 * 根据刷卡卡号获取用户
	 */
	public UsersPrivs getUserPrivsByCard(String cardnum);
	
	/**
	 * 根据检修记录中的检修人字符串查找用户
	 * @param fixrecs
	 * @return
	 */
	public Map<String, List<UsersPrivs>> getUsersPrivsById(List<JCFixrec> fixrecs);

	/**
	 * 用户刷卡登录
	 * @param idkid 卡号
	 * @return
	 */
	UsersPrivs login(String idkid);
	
	/**
	 * 根据角色名查找角色下的用户
	 * @param roleName
	 * @return
	 */
	public List<UsersPrivs> getUsersPrivsByRoleName(String roleName);
	
	/**
	 * 获取班组下的所有组员
	 */
	public List<UsersPrivs> listUsersByBzId(Long bzId);
	
	/**
	 * 根据用户ID得到用户的信息
	 * Object[0]：用户ID
	 * Object[1]：用户工号
	 * Object[2]：用户姓名
	 * Object[3]：角色名称
	 * Object[4]：所在班组名称
	 * @param userId
	 * @return
	 */
	public Object[] getUserMessage(long userId);
	
	/**
	 * 查找质检技术人员
	 * @return
	 */
	public List<UsersPrivs> getZJJSUsers();
	
	/**
	 * 更新或保存用户信息
	 * @param user
	 */
	public void saveOrUpdateUser(UsersPrivs user);
	
	/**
	 * 查询机务段所有的班组
	 * @return
	 */
	List<DictProTeam> findBZList();

	/**
	 * 分页查询当前用户所在班组的所有成员
	 * @param user 当前用户
	 * @return
	 */
	PageModel findPageModelBZWorkers(UsersPrivs user);

	/**
	 * 根据用户，获取功能列表
	 * */
	public Map<String,List<RoleFuncPrivs>> getDictFunctionsByUser(int id ,long roleId);
	
	/**
	 * 查找用户角色
	 * @param userId
	 * @return
	 */
	public List<UserRolePrivs> findRolePrivsByUserId(Long userId);
}
