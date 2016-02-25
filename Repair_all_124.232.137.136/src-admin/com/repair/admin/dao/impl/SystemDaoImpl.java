package com.repair.admin.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.admin.dao.SystemDao;
import com.repair.common.pojo.SystemParameter;

public class SystemDaoImpl extends HibernateDaoSupport implements SystemDao {

	public String getParameterValueById(int id) {
		SystemParameter obj = getHibernateTemplate().get(SystemParameter.class, id);
		if(obj==null){
			return null;
		}else{
			return obj.getParameterValue();
		}
	}

	@SuppressWarnings("unchecked")
	public List<SystemParameter> listSystemParameter() {
		return getHibernateTemplate().find(
				"from SystemParameter sp order by sp.id");
	}

	@Override
	public void updateSystemParameter(String parameterName,
			String parameterValue) {
		getSession()
				.createQuery(
						"update SystemParameter sp set sp.parameterValue=? where sp.parameterName=?")
				.setString(0, parameterValue).setString(1, parameterName)
				.executeUpdate();
	}

}
