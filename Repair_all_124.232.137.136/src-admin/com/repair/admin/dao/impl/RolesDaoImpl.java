package com.repair.admin.dao.impl;

import java.util.List;

import com.repair.admin.dao.RolesDao;
import com.repair.common.pojo.FunctionPrivs;
import com.repair.common.pojo.RoleFuncPrivs;
import com.repair.common.pojo.RolePrivs;
import com.repair.common.util.AbstractDao;

public class RolesDaoImpl extends AbstractDao implements RolesDao {

	@Override
	public void saveOrUpdateRole(RolePrivs rolePrivs) {
		getHibernateTemplate().saveOrUpdate(rolePrivs);
	}

	@Override
	public void deleteRole(long roleid) {
		String hql = "delete from RolePrivs r where r.roleid=?";
		this.getSession().createQuery(hql).setLong(0, roleid).executeUpdate();
	}

	@Override
	public long findUsers(long roleid) {
		String hql = "select count(*) from UserRolePrivs u where u.role.roleid=?";
		return (Long) getHibernateTemplate().find(hql, roleid).get(0);
	}

	@Override
	public RolePrivs findRole(long roleid) {
		String hql = "from RolePrivs r where r.roleid=?";
		return (RolePrivs) getHibernateTemplate().find(hql, roleid).get(0);
	}

	@Override
	public void editRole(long roleid) {

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FunctionPrivs> findFunctions(long parentId) {
		String hql = "from FunctionPrivs f where f.parentId =? and f.isuse=0 order by f.funOrder asc";
		return getHibernateTemplate().find(hql, parentId);
	}

	@Override
	public String findFunName(long parentId) {
		String hql = "select funname from FunctionPrivs f where f.parentId=? ";
		return (String) getHibernateTemplate().find(hql, parentId).get(0);
	}

	@Override
	public void saveRoleFuncPrivs(RoleFuncPrivs roleFuncPrivs) {
		getHibernateTemplate().saveOrUpdate(roleFuncPrivs);
	}

	@Override
	public void deleteRoleFuncPrivs(long roleId) {
		String hql = "delete from RoleFuncPrivs r where r.role.roleid=?";
		getSession().createQuery(hql).setLong(0, roleId).executeUpdate();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RoleFuncPrivs> findRoleFuncs(long roleId) {
		String hql = "from RoleFuncPrivs r where r.role.roleid=? and r.function.isuse=0";
		return getHibernateTemplate().find(hql, roleId);
	}

	@SuppressWarnings("unchecked")
	public List<RoleFuncPrivs> findRoleFunctions(long roleId, long parentId) {
		String hql = "from RoleFuncPrivs t where t.role.roleid=? and t.function.parentId=? and t.function.isuse=0";
		return getHibernateTemplate().find(hql,	new Object[] { roleId, parentId });
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FunctionPrivs> findAllChildFunctions(long roleId) {
		String hql = "select * from RoleFuncPrivs r r.role.roleid=?)";
		return getHibernateTemplate().find(hql, roleId);
	}
}
