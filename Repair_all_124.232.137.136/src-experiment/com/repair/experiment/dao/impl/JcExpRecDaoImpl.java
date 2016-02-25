package com.repair.experiment.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JcExpSignRec;
import com.repair.experiment.dao.BaseDao;
import com.repair.experiment.dao.JcExpRecDao;

public class JcExpRecDaoImpl extends BaseDao<JcExpRec> implements JcExpRecDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<JcExpRec> findJcExpRecs(final int rjhmId, final long jceiId) {
		return getHibernateTemplate().execute(new HibernateCallback<List<JcExpRec>>() {

			@Override
			public List<JcExpRec> doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createSQLQuery("select jer.* from jc_exp_rec jer join jc_experiment_item jei on jer.itemid = jei.jceiid where jei.parentid=? and jer.dyprecid=?").addEntity(JcExpRec.class);
				query.setParameter(0, jceiId);
				query.setParameter(1, rjhmId);
				return query.list();
			}
		});
	}
	
	@Override
	public JcExpRec findJcExpRecById(long itemRecId) {
		return getHibernateTemplate().get(JcExpRec.class, itemRecId);
	}
	
	
	@Override
	public void updateJcExpRec(JcExpRec jcExpRec) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(jcExpRec);
	}
	
	@Override
	public List findUserChoicedItemRecNames(Long userid, int rjhmId) {
		String hql = "select rec.itemName from JcExpRec as rec where rec.dypRecId.rjhmId=? and  rec.fixEmpId like '%,"+userid+",%'";
		return getHibernateTemplate().find(hql, rjhmId);
	}
	
	@Override
	public void saveJcExpRec(JcExpRec jcExpRec) {
		getHibernateTemplate().save(jcExpRec);
	}
	
	@Override
	public DatePlanPri findDatePlanPriById(int rjhmId) {
		return getHibernateTemplate().get(DatePlanPri.class, rjhmId);
	}
	
	@Override
	public List findSignedItemRecNameAndVal(int rjhmId, int experimentId) {
		String hql = "select rec.itemName,rec.expStatus,rec.jceRId,rec.fixSignee from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and  rec.expType=0";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,experimentId});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public JcExpRec findJcExperimentByDatePlanAndExpId(int datePlanId, long expId) {
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.jceiId=? and rec.expType=1";
		List<JcExpRec> list = getHibernateTemplate().find(hql, new Object[]{datePlanId,expId});
		if(null != list && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
	@Override
	public List<JcExpRec> findJcExpRecList(int rjhmId, long experimentId, String itemName) {
		int parentId = ((Long) experimentId).intValue();
		List<JcExpRec> list = null;
		if("all".equals(itemName)){
			String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and rec.expType=0";
			list = getHibernateTemplate().find(hql,new Object[]{rjhmId,parentId});
		}else{
			String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and rec.expType=0 and rec.itemName like '%"+itemName+"%'";
			list = getHibernateTemplate().find(hql,new Object[]{rjhmId,parentId});
		}
		return list;
	}
	
	@Override
	public Long countJcYsExpRecList(int rjhmId, long experimentId){
		int parentId = ((Long) experimentId).intValue();
		String hql="select count(rec.jceRId) from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and rec.expType=0 and rec.accepter is null";
		return (Long)getHibernateTemplate().find(hql,new Object[]{rjhmId,parentId}).get(0);
	}
	
	@Override
	public List findUserRolesByUserId(Long userid) {
		String hql = "select role.roleid from UserRolePrivs ur where ur.user.userid=?";
		return getHibernateTemplate().find(hql, userid);
	}
	
	@Override
	public List<JcExpRec> findJcExpRecByPlanAndExp(int rjhmId,int jcFlowId, Long experimentId) {
		int parentId = ((Long) experimentId).intValue();
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.dypRecId.nodeid.jcFlowId=? and rec.itemId.parentId=? and rec.expType=0";
		return getHibernateTemplate().find(hql,new Object[]{rjhmId,jcFlowId,parentId});
	}
	
	@Override
	public List<JcExpRec> findOthersJcExpRecByPlan(int rjhmId,int jcFlowId, Long experimentId) {
		int parentId = ((Long) experimentId).intValue();
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.dypRecId.nodeid.jcFlowId=? and rec.itemId.parentId<>? and rec.expType=0";
		return getHibernateTemplate().find(hql,new Object[]{rjhmId,jcFlowId,parentId});
	}
	
	@Override
	public JCFixflow findJcFixflowById(Integer flowId) {
		return getHibernateTemplate().get(JCFixflow.class, flowId);
	}
	
	@Override
	public void updateDatePlanPri(DatePlanPri datePlan) {
		getHibernateTemplate().update(datePlan);
	}
	
	@Override
	public List<JcExpRec> findExperimentAllRec(int rjhmId, int parentId) {
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and rec.expType=0";
		List<JcExpRec> list = getHibernateTemplate().find(hql,new Object[]{rjhmId,parentId});
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}
	
	@Override
	public List<JcExpRec> findJcExperimentsByPlanAndFlow(int rjhmId,
			int jcFlowId) {
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.dypRecId.nodeid.jcFlowId=? and rec.expType=1";
		return getHibernateTemplate().find(hql,new Object[]{rjhmId,jcFlowId});
	}
	
	@Override
	public JcExpSignRec findJcExpSignRecByPlanAndItemName(int rjhmId,String itemName) {
		String hql = "from JcExpSignRec esr where esr.datePlan.rjhmId=? and esr.itemName=?";
		List<JcExpSignRec> recs = getHibernateTemplate().find(hql, new Object[]{rjhmId,itemName});
		if(recs!=null && recs.size()>0){
			return recs.get(0);
		}
		return null;
	}
	
	@Override
	public List<JcExpSignRec> findJcExpSignRecListByPlan(int rjhmId) {
		String hql = "from JcExpSignRec esr where esr.datePlan.rjhmId=?";
		List<JcExpSignRec> recs = getHibernateTemplate().find(hql, rjhmId);
		if(recs!=null && recs.size()>0){
			return recs;
		}
		return null;
	}
	
	@Override
	public void saveJcExpSignRec(JcExpSignRec signRecord) {
		getHibernateTemplate().save(signRecord);
	}
	
	@Override
	public List<JcExpSignRec> findJcExpSignRecsByPlanAndExp(int rjhmId,long experimentId) {
		String hql = "from JcExpSignRec esr where esr.datePlan.rjhmId=? and esr.experiment.jceiId=?";
		return getHibernateTemplate().find(hql,new Object[]{rjhmId,experimentId});
	}
	
	@Override
	public void updateJcExpSignRec(JcExpSignRec signRec) {
		getHibernateTemplate().update(signRec);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public JcExpRec findJcExpRec(int rjhmId, long experimentId, String itemName) {
		int parentId = ((Long)experimentId).intValue();
		String hql = "from JcExpRec as rec where rec.dypRecId.rjhmId=? and rec.itemId.parentId=? and rec.expType=0 and rec.itemName=?";
		List<JcExpRec> list = getHibernateTemplate().find(hql,new Object[]{rjhmId,parentId,itemName});
		if(list != null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

	@Override
	public void deleteJcExpRec(int rjhmId) {
		String sql="delete from jc_exp_rec a where  a.itemid in (select itemid from jc_exp_rec where dyprecid="+rjhmId+" group by itemid having count(*) > 1)";
		sql=sql+" and a.dyprecid="+rjhmId+"  and rowid not in (select min(rowid) from jc_exp_rec where dyprecid="+rjhmId+" group by itemid having count(*)>1)";
		this.getSession().createSQLQuery(sql).executeUpdate();
	}
}
