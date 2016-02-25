package com.repair.work.dao.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.DaoManageSupport;
import com.repair.common.util.PageModel;
import com.repair.work.dao.UsersPrivsDao;

public class UsersPrivsDaoImpl extends DaoManageSupport implements
		UsersPrivsDao {

	@SuppressWarnings("unchecked")
	public UsersPrivs login(String username, String password) {
		String hql = "from UsersPrivs u where (u.name=? or u.gonghao=?) and u.pwd=?";
		List<UsersPrivs> users = getHibernateTemplate().find(hql,new Object[]{username,username,password});
		if(users==null || users.size()==0){
			return null;
		}
		return users.get(0);
	}

	@Override
	public UsersPrivs login(String idkid) {
		String hql = "from UsersPrivs u where u.idkid=?";
		List<UsersPrivs> users = getHibernateTemplate().find(hql,new Object[]{idkid});
		if(users==null || users.size()==0){
			return null;
		}
		if(users.size()>1){
			System.out.println("该卡号存在多个用户");
			return null;
		}
		return users.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public boolean isHasRole(long userId, String roleName) {
		String hql = "from UserRolePrivs ur where ur.role.rolename=? and  ur.user.id=?";
		List<UserRolePrivs> userRoles = getHibernateTemplate().find(hql, new Object[]{roleName,userId});
		if(userRoles==null || userRoles.size()==0){
			return false;
		}
		return true;
	}

	@Override
	public UsersPrivs getUsersPrivsById(long userId) {
		return getHibernateTemplate().get(UsersPrivs.class, userId);
	}
	
	@SuppressWarnings("unchecked")
	public UsersPrivs getUserPrivsByCard(String cardnum){
		String hql = "from UsersPrivs u where u.idkid=?";
		List<UsersPrivs> users = getHibernateTemplate().find(hql,cardnum);
		if(users==null || users.size()==0){
			return null;
		}
		return users.get(0);
	}

	public Map<String, List<UsersPrivs>> getUsersPrivsById(final List<JCFixrec> fixrecs) {
		return getHibernateTemplate().execute(new HibernateCallback<Map<String, List<UsersPrivs>>>() {

			@SuppressWarnings("unchecked")
			@Override
			public Map<String, List<UsersPrivs>> doInHibernate(Session session) throws HibernateException,
					SQLException {
				if (null != fixrecs && !fixrecs.isEmpty()) {
					Map<String, List<UsersPrivs>> map = new LinkedHashMap<String, List<UsersPrivs>>();
					for (JCFixrec jcFixrec : fixrecs) {
						String[] arrs = jcFixrec.getFixEmp().split(",");
						Long[] ids = new Long[arrs.length];
						for (int i = 0, len = arrs.length; i < len; i++) {
							ids[i] = Long.parseLong(arrs[i]);
						}
						Query query = session.createQuery("from UsersPrivs as ups where ups.userid in (:userids)");
						query.setParameterList("userids", ids);
						map.put(jcFixrec.getJcRecId()+"", query.list());
					}
					return map;
				}
				return null;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<UsersPrivs> getUsersPrivsByRoleName(String roleName) {
		return getHibernateTemplate().find("from UsersPrivs as ups where ups.userid in (select urp.user.userid from UserRolePrivs as urp where urp.role.rolename=?)", roleName);
	}
	
	@SuppressWarnings("unchecked")
	public List<UsersPrivs> listUsersByBzId(Long bzId){
		String hql="from UsersPrivs user where user.bzid=?";
		return getHibernateTemplate().find(hql, bzId);
	}

	@Override
	public Object[] getUserMessage(long userId) {
		String sql="select u.userid,u.gonghao,u.xm,rp.rolename,team.proteamname from users_privs u,userrole_privs ur,role_privs rp,dict_proteam team where u.userid=ur.userid and ur.roleid=rp.roleid and u.bzid=team.proteamid and u.userid=?";
		List list=getSession().createSQLQuery(sql).setLong(0, userId).list();
		if(list!=null&&list.size()>0){
			return (Object[])list.get(0);
		}
		return null;
	}

	@Override
	public List<UsersPrivs> getZJJSUsers() {
		return this.getHibernateTemplate().find("from UsersPrivs as ups where ups.userid in (select urp.user.userid from UserRolePrivs as urp where urp.role.py='ZJY' or urp.role.py='JSY')");
	}

	@Override
	public void saveOrUpdateUser(UsersPrivs user) {
		this.getHibernateTemplate().saveOrUpdate(user);
	}
	
	@Override
	public List<DictProTeam> findBZList() {
		return getHibernateTemplate().find("from DictProTeam where workflag=1 or zxFlag=1");
	}
	
	@Override
	public PageModel findPageModelBZWorkers(UsersPrivs user) {
		return getScrollData(UsersPrivs.class, "bzid=?", new Object[]{user.getBzid()});
	}
	
	public List<UserRolePrivs> findRolePrivsByUserId(Long userId){
		String hql = "from UserRolePrivs t where t.user.userid= ?";
		return getHibernateTemplate().find(hql, new Object[]{userId});
	}
}
