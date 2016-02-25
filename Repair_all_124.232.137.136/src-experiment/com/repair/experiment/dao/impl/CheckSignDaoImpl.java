package com.repair.experiment.dao.impl;

import java.util.List;

import org.hibernate.Query;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCSignature;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.experiment.dao.BaseDao;
import com.repair.experiment.dao.CheckSignDao;

@SuppressWarnings("unchecked")
public class CheckSignDaoImpl extends BaseDao implements CheckSignDao{

	@Override
	public List<DatePlanPri> findCheckJc() {
		String hql="from DatePlanPri dpp where dpp.planStatue=1 and dpp.projectType=?";
		return (List<DatePlanPri>)getHibernateTemplate().find(hql,Contains.XX_PROJECT_TYPE);
	}
	
	/**
	 * 根据节点查询是否存在所有验收未签字--临时急用
	 */
//	public long countAccepterUnSignItem(DatePlanPri datePlanPri){
//		String fixFreque = datePlanPri.getFixFreque();
//		long count = 0;
//		String hql = "";
//		if("LX".equals(fixFreque)||"JG".equals(fixFreque)){
//			hql = "select count(t.preDictId) from JtPreDict t where t.accepter is not null and t.type=3 and t.datePlanPri.rjhmId=?";
//		}else if("QZ".equals(fixFreque)||"CJ".equals(fixFreque)){
//			hql = "select count(t.jcRecId) from JCQZFixRec t where t.accepter is not null and t.jcRecmId.rjhmId=?";
//		}else {
//			hql = "select count(t.jcRecId) from JCFixrec t where t.accepter is not null and t.datePlanPri.rjhmId=?";
//		}
//		count = (Long) getHibernateTemplate().find(hql, datePlanPri.getRjhmId()).get(0);
//		return count;
//	}

	@Override
	public List<DatePlanPri> findCheckJc(int nodeId,Long userId) {
//		String hql="from DatePlanPri dpp where dpp.nodeid.jcFlowId=? and dpp.planStatue=0 and dpp.projectType=?";
//		return  getHibernateTemplate().find(hql,new Object[]{nodeId,Contains.XX_PROJECT_TYPE});
        String sql="select dp.* from dateplan_pri dp where dp.nodeid=? and dp.planStatue=0 and dp.projectType=? and dp.rjhmid not in(select distinct jp.dateplanpri from  jt_predict jp where (jp.recstas=2 or jp.recstas=3) and jp.type!=3)";
        //--and dp.gongZhang=?不要只显示自己的车  .setLong(1, userId)
		Query query=getSession().createSQLQuery(sql).addEntity(DatePlanPri.class).setInteger(0, nodeId).setInteger(1, Contains.XX_PROJECT_TYPE);
		return query.list();
	}

	@Override
	public void saveSignature(JCSignature signature) {
		getHibernateTemplate().save(signature);
		
	}

	@Override
	public DatePlanPri findDatePlanPriById(int rjhmId) {
		return (DatePlanPri)getHibernateTemplate().get(DatePlanPri.class, rjhmId);
	}

	@Override
	public List<JCSignature> findJCSignatureByDatePlanId(int datePlanId) {
		String hql="from JCSignature jcs where jcs.datePlanId.rjhmId=? order by jcs.signTime desc";
		return getHibernateTemplate().find(hql,datePlanId);
	}
	
	public List<DictProTeam> listFixProTeam(int datePlanId){
		String hql = "select t.proTeam from JCFlowRec t where t.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql,datePlanId);
	}

	@Override
	public void saveDlJcJyZbMxb(DlJcJyZb djz) {
		List<DlJcJyZb> djzs = getHibernateTemplate().find("from DlJcJyZb djz where djz.dpId=?",djz.getDpId());
		if (djzs == null || djzs.isEmpty()) {
			this.getHibernateTemplate().save(djz);
			DlJcJyMxb djm1 = new DlJcJyMxb();
			djm1.setJyzId(djz);
			djm1.setStatus((short)0);
			djm1.setJcxm("低压电器试验");
			
			DlJcJyMxb djm2 = new DlJcJyMxb();
			djm2.setJyzId(djz);
			djm2.setStatus((short)0);
			djm2.setJcxm("高压实验");
			
			DlJcJyMxb djm3 = new DlJcJyMxb();
			djm3.setJyzId(djz);
			djm3.setStatus((short)0);
			djm3.setJcxm("打风时间");
			
			DlJcJyMxb djm4 = new DlJcJyMxb();
			djm4.setJyzId(djz);
			djm4.setStatus((short)0);
			djm4.setJcxm("制动机性能实验");
			
			this.getHibernateTemplate().save(djm1);
			this.getHibernateTemplate().save(djm2);
			this.getHibernateTemplate().save(djm3);
			this.getHibernateTemplate().save(djm4);
		}
		
	}

	@Override
	public List<DlJcJyMxb> findDlJcJyMxbByDpId(int datePlanId) {
		String sql="select dm.* from dljcjyzb dz,dljcjymxb dm where dz.JYZID=dm.jyzid and dz.DPID=:datePlanId";
		Query query=getSession().createSQLQuery(sql).addEntity(DlJcJyMxb.class).setParameter("datePlanId",datePlanId);
		return query.list();
	}

	@Override
	public DlJcJyMxb findDlJcJyMxbById(int djmId) {
		return getHibernateTemplate().get(DlJcJyMxb.class, djmId);
	}

	@Override
	public void saveDlJcJyMxb(DlJcJyMxb djm) {
		getHibernateTemplate().save(djm);
	}

	@Override
	public NrJcJyzb findNrJcJyzbByDpId(int dpId) {
		String hql="from NrJcJyzb njj where njj.dpId=?";
		List list= getHibernateTemplate().find(hql,dpId);
		if(list!=null&&list.size()>0){
			return (NrJcJyzb)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public void saveNrJcJyzb(NrJcJyzb nrJcJyzb) {
		getHibernateTemplate().save(nrJcJyzb);
	}

	@Override
	public void updateNrJcJyzb(NrJcJyzb nrJcJyzb) {
		getHibernateTemplate().update(nrJcJyzb);
	}

	@Override
	public JCSignature findJCSignatureByUserDpId(UsersPrivs user,
			DatePlanPri datePlan) {
		String hql="from JCSignature jcs where jcs.datePlanId.rjhmId=? and jcs.user.userid=?";
		List list= getHibernateTemplate().find(hql,new Object[]{datePlan.getRjhmId(),user.getUserid()});
		if(list!=null&&list.size()>0){
			return (JCSignature)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<DlJcJyMxb> findDlJcJyMxbByIdStatus(int jyzId, short status) {
		String hql="from DlJcJyMxb dm where dm.jyzId.jyzId=? and dm.status=?";
		return getHibernateTemplate().find(hql,new Object[]{jyzId,status});
	}

	@Override
	public DlJcJyZb findDlJcJyZbByDpId(DatePlanPri datePlan) {
		String hql="from DlJcJyZb dz where dz.dpId=?";
		List list= getHibernateTemplate().find(hql,datePlan.getRjhmId());
		if(list!=null&&list.size()>0){
			return (DlJcJyZb)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public void updateDatePlanPri(DatePlanPri datePlan) {
		getHibernateTemplate().update(datePlan);
	}

	@Override
	public UsersPrivs getUsersPrivsByGonghao(String gonghao) {
		String hql="from UsersPrivs user where user.gonghao=?";
		List list=getHibernateTemplate().find(hql,gonghao);
		if(list!=null&&list.size()>0){
			return (UsersPrivs)list.get(0);
		}
		return null;
	}

	@Override
	public List<JtPreDict> findPredicts(Integer rjhmId) {
		String hql = "from JtPreDict j where j.recStas!=4 and j.datePlanPri.rjhmId="+rjhmId;
		return getHibernateTemplate().find(hql);
	}

	@Override
	public List<DictJwd> findDictJwds() {
		return getHibernateTemplate().find("from DictJwd t where t.isUsed=1");
	}
		
}
