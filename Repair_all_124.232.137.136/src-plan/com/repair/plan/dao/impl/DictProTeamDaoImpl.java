package com.repair.plan.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.util.Contains;
import com.repair.plan.dao.DictProTeamDao;

public class DictProTeamDaoImpl extends HibernateDaoSupport implements
		DictProTeamDao {

	@Override
	public List<DictProTeam> findDictProTeamsByFixFlow(final JCFixflow fixflow, final DatePlanPri datePlanPri) {
		return getHibernateTemplate().execute(new HibernateCallback<List<DictProTeam>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<DictProTeam> doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = null;
				if (datePlanPri.getFixFreque().equals(Contains.PY_LX) || datePlanPri.getFixFreque().equals(Contains.PY_JG)|| datePlanPri.getFixFreque().equals(Contains.PY_ZZ)) {
					query = session.createSQLQuery("select distinct dpt.* from DICT_PROTEAM dpt join JT_PREDICT jpd on dpt.PROTEAMID = jpd.PROTEAMID where jpd.TYPE=3 and jpd.DATEPLANPRI=:datePlanPri").addEntity(DictProTeam.class);
					query.setParameter("datePlanPri", datePlanPri.getRjhmId());
					return query.list();
					
				} else if (datePlanPri.getFixFreque().equals(Contains.PY_CJ) || datePlanPri.getFixFreque().equals(Contains.PY_QZ)) {
//					String jctype = datePlanPri.getJcType();
//					query = session.createSQLQuery("select distinct dpt.* from DICT_PROTEAM dpt join JC_QZ_ITEMS jqi on dpt.PROTEAMID = jqi.BZID where jqi.JCSTYPE=:jcsType and jqi.XIUCI=:xiuci").addEntity(DictProTeam.class);
//					if (jctype.contains(Contains.JC_TYPE_ELECTRIC_PREFIX)) {
//						query.setParameter("jcsType", Contains.JC_TYPE_ELECTRIC);
//					} else if(jctype.contains(Contains.JC_TYPE_OIL_PREFIX)) {
//						query.setParameter("jcsType", Contains.JC_TYPE_OIL);
//					} else {
//						throw new RuntimeException("春鉴与秋整检修项目没有匹配到机车类型");
//					}
//					query.setParameter("xiuci", datePlanPri.getFixFreque());
//					return query.list();
					/** 2015 10 18   周云韬   秋整从jc_fix_item表中查询节点*/
					query = session.createQuery("select jfi.banzuId.proteamid from JCFixitem jfi where jfi.jcsType like :jcsType and jfi.xcxc like :xcxc and jfi.jcFixflow.jcFlowId = :jcFlowId group by jfi.banzuId.proteamid");
					query.setParameter("jcFlowId", fixflow.getJcFlowId());
					query.setParameter("xcxc", "%,"+datePlanPri.getFixFreque()+",%");
					query.setParameter("jcsType", "%"+datePlanPri.getJcType()+",%");
					List<Integer> proteams = query.list();
					if (null != proteams && !proteams.isEmpty()) {
						query = session.createQuery("from DictProTeam dpt where dpt.proteamid in (:proteamids)");
						query.setParameterList("proteamids", proteams);
						return query.list();
					}
					
				} else if (datePlanPri.getFixFreque().startsWith("Z") && !"ZQZZ".equals(datePlanPri.getFixFreque())&& !"ZZ".equals(datePlanPri.getFixFreque()) && !"ZDZZ".equals(datePlanPri.getFixFreque())){
					query = session.createQuery("select jfi.bzId.proteamid from JCZXFixItem jfi where jfi.bzId is not null and jfi.jcsType like :jcsType and jfi.xcxc like :xcxc and jfi.nodeId.jcFlowId = :jcFlowId group by jfi.bzId.proteamid");
					query.setParameter("jcFlowId", fixflow.getJcFlowId());
					query.setParameter("xcxc", "%,"+datePlanPri.getFixFreque()+",%");
					query.setParameter("jcsType", "%"+datePlanPri.getJcType()+",%");
					List<Integer> proteams = query.list();
					if (null != proteams && !proteams.isEmpty()) {
						query = session.createQuery("from DictProTeam dpt where dpt.proteamid in (:proteamids)");
						query.setParameterList("proteamids", proteams);
						return query.list();
					}
				} else  {
					query = session.createQuery("select jfi.banzuId.proteamid from JCFixitem jfi where jfi.jcsType like :jcsType and jfi.xcxc like :xcxc and jfi.jcFixflow.jcFlowId = :jcFlowId group by jfi.banzuId.proteamid");
					query.setParameter("jcFlowId", fixflow.getJcFlowId());
					query.setParameter("xcxc", "%,"+datePlanPri.getFixFreque()+",%");
					query.setParameter("jcsType", "%"+datePlanPri.getJcType()+",%");
					List<Integer> proteams = query.list();
					if (null != proteams && !proteams.isEmpty()) {
						query = session.createQuery("from DictProTeam dpt where dpt.proteamid in (:proteamids)");
						query.setParameterList("proteamids", proteams);
						return query.list();
					}
				}
				return null;
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findDictProTeam() {
		return getHibernateTemplate().find("from DictProTeam as dpt where dpt.workflag=1 or dpt.zxFlag=1 order by dpt.proteamid asc");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findWorkDictProTeam() {
		return getHibernateTemplate().find("from DictProTeam as dpt where dpt.workflag=1 or dpt.zxFlag=1 order by dpt.proteamid asc");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findWorkDictProTeam(int zxFlag) {
		if(zxFlag==1){//中修班组
			return getHibernateTemplate().find("from DictProTeam as dpt where dpt.zxFlag=1 order by dpt.proteamid asc");
		}else{
			return getHibernateTemplate().find("from DictProTeam as dpt where dpt.workflag=1 order by dpt.proteamid asc");
		}
		
	}

	@Override
	public DictProTeam findDictProTeamById(Long proteamid) {
		return getHibernateTemplate().get(DictProTeam.class, proteamid);
	}

	@Override
	public DictProTeam findDictProTeamByName(String proteamname) {
		String hql = "from DictProTeam d where d.proteamname=?";
		return (DictProTeam) getSession().createQuery(hql).setString(0, proteamname).uniqueResult();
	}
	
	public DictProTeam findDictProTeamByPY(String py){
		String hql = "from DictProTeam d where d.py=?";
		try{
			return (DictProTeam) getSession().createQuery(hql).setString(0, py).uniqueResult();
		}catch (Exception e) {
			return null;
		}
	}
}
