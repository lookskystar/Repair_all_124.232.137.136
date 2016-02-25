package com.repair.admin.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.admin.dao.UserRolesDao;
import com.repair.common.pojo.DictArea;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;

public class UserRolesDaoImpl extends AbstractDao implements UserRolesDao{

	@Override
	public void delUserPrivs(long userId) {
		String hql = "delete from UsersPrivs u where u.userid=?";
		getSession().createQuery(hql).setLong(0, userId).executeUpdate();
	}

	@Override
	public void delUserRolePrivs(long userId) {
		String hql = "delete from UserRolePrivs u where u.user.userid=?";
		getSession().createQuery(hql).setLong(0, userId).executeUpdate();
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> listDictProTeam() {
		String hql = "from DictProTeam t order by t.proteamid";
		return getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> listXXDictProTeam() {
		String hql = "from DictProTeam t where t.workflag=1";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RolePrivs> listRolePrivs() {
		String hql = "from RolePrivs t order by roleid";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UsersPrivs> listUsersByBzId(Long bzId) {
		if(bzId!=null){
			return getHibernateTemplate().find("from UsersPrivs u where u.bzid=?", bzId);
		}else{
			return getHibernateTemplate().find("from UsersPrivs u");
		}
	}

	@Override
	public UsersPrivs getUsersPrivsById(long id) {
		return getHibernateTemplate().get(UsersPrivs.class, id);
	}
	
	@Override
	public UserRolePrivs getUserRolePrivsById(long id) {
		String hql = "from UserRolePrivs u where u.user.userid=?";
		return (UserRolePrivs) getHibernateTemplate().find(hql,id).get(0);
	}

	@Override
	public void saveOrUpdateUserPrivs(UsersPrivs usersPrivs) {
		getHibernateTemplate().saveOrUpdate(usersPrivs);
	}

	@Override
	public void saveOrUpdateUserRolePrivs(UserRolePrivs userrolePrivs) {
		getHibernateTemplate().saveOrUpdate(userrolePrivs);
		
	}
	
	@Override
	public void delDictProTeam(long proteamId) {
		String hql = "delete from DictProTeam d where d.proteamid=?";
		getSession().createQuery(hql).setLong(0, proteamId).executeUpdate();
		
	}

	@Override
	public void saveOrUpdateDictProTeam(DictProTeam dictproteam) {
		getHibernateTemplate().saveOrUpdate(dictproteam);
		
	}

	@Override
	public long findUser(long proteamId) {
		String hql = "select count(*) from UsersPrivs u where u.bzid=?";
		return (Long) getHibernateTemplate().find(hql, proteamId).get(0);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcStype> listDictJcStype() {
		String hql = "from DictJcStype d";
		return getHibernateTemplate().find(hql);
	}
	
	@Override
	public DictProTeam getDictProteamById(long id) {
		return getHibernateTemplate().get(DictProTeam.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<UsersPrivs> findUsersPrivs(String gonghao,String xm,Long roleid,Long bzId) {
		StringBuilder builder=new StringBuilder();
		builder.append("from UsersPrivs t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(gonghao!=null&&!gonghao.equals("")){
			builder.append(" and t.gonghao like ?");
			params.add("%"+gonghao+"%");
		}
		if(xm!=null&&!xm.equals("")){
			builder.append(" and t.xm like ?");
			params.add("%"+xm+"%");
		}
		if(roleid!=null&&!roleid.equals("")){
			builder.append(" and t.userid in ( select u.user.userid  from  UserRolePrivs u where u.role.roleid=?)");
			params.add(roleid);
		}
		if(bzId!=null&&!bzId.equals("")){
			builder.append(" and t.bzid = ?");
			params.add(bzId);
		}
		builder.append(" order by t.userid");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void UpdateUserBz(long userId, int bzId) {
		String hql = "update UsersPrivs u set u.bzid=:bzId where u.userid=:userId";
		getSession().createQuery(hql).setLong("userId", userId).setInteger("bzId", bzId).executeUpdate();
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictArea> listDictArea() {
		String hql = "from DictArea t";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJwd> listDictJwd() {
		String hql = "from DictJwd t";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public RolePrivs getRolePrivsById(long roleid) {
		return this.getHibernateTemplate().get(RolePrivs.class, roleid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public DictProTeam getDictProTeam(String proteamname) {
		String hql = "from DictProTeam d where d.proteamname=?";
		List<DictProTeam> list=getHibernateTemplate().find(hql,proteamname);
		if(list!=null&&list.size()>0){
			return (DictProTeam)list.get(0);
		}
		return null;
	}
	

}
