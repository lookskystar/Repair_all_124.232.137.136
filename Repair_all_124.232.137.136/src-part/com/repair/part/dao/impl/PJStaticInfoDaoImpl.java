package com.repair.part.dao.impl;



import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.part.dao.PJStaticInfoDao;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.util.DaoManageSupport;

public class PJStaticInfoDaoImpl extends DaoManageSupport implements
		PJStaticInfoDao {

	@Override
	public PJStaticInfo getPJStaticInfo(Long pjsid) {
		return getHibernateTemplate().get(PJStaticInfo.class, pjsid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJStaticInfo> findChildPJByParentPJFromFixItem(Long pjsid) {
//		String hql = "select fit.childPJ from PJFixItem fit where fit.pjStaticInfo.pjsid=?";
		final String sql = "select distinct childpjid,childpjname from pj_fixitem  where childpjid is not null and pjsid="+pjsid;
		return (List<PJStaticInfo>) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				List list = session.createSQLQuery(sql).list();
				return list;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<PJPresetDivision> findPJStaticInfoPreset(Long pjsId){
		String hql="from PJPresetDivision t where t.pjsId.pjsid=? order by t.presetId";
		return getHibernateTemplate().find(hql,pjsId);
	}
}
