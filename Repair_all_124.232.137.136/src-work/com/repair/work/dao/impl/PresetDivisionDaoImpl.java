package com.repair.work.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCCharge;
import com.repair.common.pojo.JCChoice;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJPresetRelateID;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.PresetRelateID;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.work.dao.PresetDivisionDao;

public class PresetDivisionDaoImpl extends HibernateDaoSupport implements PresetDivisionDao{

	@SuppressWarnings("unchecked")
	public List<PresetDivision> getPresetDivisonByTypeId(String jcType,Long proteamid,Integer nodeId) {
		String hql="from PresetDivision pd where pd.jcValue=? and pd.proTeam.proteamid=? and pd.nodeId=? order by proSetId asc";
		return getHibernateTemplate().find(hql,new Object[]{jcType,proteamid,nodeId});
	}
	
	/**
	 * 根据机车类型获取大类
	 */
	@SuppressWarnings("unchecked")
	public List<PresetDivision> listPresetDivisionByJctype(String jcType){
		String hql = "from PresetDivision pd where pd.jcValue=?";
		return getHibernateTemplate().find(hql,jcType);
	}
	
	@SuppressWarnings("unchecked")
	public List<JCFixitem> getJCFixitemByBzId(String jcType, Long proteamid, Integer nodeId){
		String hql="from JCFixitem ji where ji.banzuId.proteamid=? and ji.jcsType like ? and ji.jcFixflow.jcFlowId=? order by ji.itemOrder asc,ji.posiName asc";
		return getHibernateTemplate().find(hql,new Object[]{proteamid,"%"+jcType+",%",nodeId}); 
	}
	
	@SuppressWarnings("unchecked")
	public List<JCZXFixItem> getJCZxFixitemByBzId(String jcType, Long proteamid, Integer nodeId){
		String hql="from JCZXFixItem ji where ji.bzId.proteamid=? and ji.jcsType like ? and ji.nodeId.jcFlowId=?";
		return getHibernateTemplate().find(hql,new Object[]{proteamid,"%"+jcType+",%",nodeId}); 
	}
	
	@Override
	public void savePresetDivison(PresetDivision pd) {
		getHibernateTemplate().saveOrUpdate(pd);
	}
	
	public PresetDivision getPresetDivisionById(Integer presetId){
		return getHibernateTemplate().get(PresetDivision.class, presetId);
	}
	
	public PJPresetDivision getPJPresetDivisionById(Long presetId){
		return getHibernateTemplate().get(PJPresetDivision.class, presetId);
	}
	
	public void delPresetRelateId(int presetId){
		String hql="delete from PresetRelateID prd where prd.presetId.proSetId=?";
		getSession().createQuery(hql).setInteger(0, presetId).executeUpdate();
	}
	
	public void delPJPresetRelateId(Long presetId){
		String hql="delete from PJPresetRelateID t where t.pjPresetId.presetId=?";
		getSession().createQuery(hql).setLong(0, presetId).executeUpdate();
	}
	
	@Override
	public void savePresetRelateId(PresetRelateID presetRelateId) {
		getHibernateTemplate().save(presetRelateId);
	}
	
	public void savePJPresetRelateId(PJPresetRelateID pjPresetRelateId){
		getHibernateTemplate().save(pjPresetRelateId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PresetRelateID> getPresetRelateByYsId(int ysId) {
		String hql="from PresetRelateID prd where prd.presetId.proSetId=?";
		return getHibernateTemplate().find(hql,ysId);
	}
	
	@SuppressWarnings("unchecked")
	public List<PJPresetRelateID> getPJPresetRelateByYsId(Long ysId){
		String hql="from PJPresetRelateID t where t.pjPresetId.presetId=?";
		return getHibernateTemplate().find(hql,ysId);
	}
	
	@SuppressWarnings("unchecked")
	public List<PresetRelateID> getPresetRelateByYsId(final Integer[] ysId) {
		return getHibernateTemplate().execute(new HibernateCallback<List<PresetRelateID>>() {

			@Override
			public List<PresetRelateID> doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from PresetRelateID prd where prd.presetId.proSetId in(:proSetId)");
				query.setParameterList("proSetId", ysId);
				return query.list();
			}
		});
	}

	@Override
	public void delPresetDivisonByYsId(final int ysId) {
		getHibernateTemplate().execute(new HibernateCallback<Void>() {

			@Override
			public Void doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery("from PresetDivision pd where pd.proSetId=?");
				query.setParameter(0, ysId);
				PresetDivision division = (PresetDivision) query.uniqueResult();
				query = session.createQuery("select count(jd.divideId) from JCDivision jd where jd.dayPlan.rjhmId in (select dpp.rjhmId from DatePlanPri dpp where dpp.jcType = ? and dpp.planStatue<=1  group by dpp.rjhmId) and jd.leader=? and jd.presetDivision=?");
				query.setParameter(0, division.getJcValue());
				query.setEntity(1, division.getProTeam());
				query.setEntity(2, division);
				Long result =  (Long) query.uniqueResult();
				if (result==0L) {
					String hql="delete from PresetRelateID prd where prd.presetId.proSetId=?";//删除预设分类项目关联表中的预设分类信息
					String hql2="delete from PresetDivision pd where pd.proSetId=?";//删除预设分类表中的预设分类信息
					session.createQuery(hql).setInteger(0, ysId).executeUpdate();
					session.createQuery(hql2).setInteger(0, ysId).executeUpdate();
				}
				return null;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<DictJcStype> listJcSType(){
		return getHibernateTemplate().find("from DictJcStype");
	}
	
	public List<DatePlanPri> listMyJCDivision(long userId){
		String hql = "select distinct jd.dayPlan from JCDivision jd where jd.dayPlan.planStatue=0 and jd.user.userid=?";
		return getHibernateTemplate().find(hql, userId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> getDictProTeamAll() {
		return getHibernateTemplate().find("from DictProTeam t where t.workflag=1");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixitem> getJCFixitemByBzId(long bzId,String jcType) {
		String hql="from JCFixitem jf where jf.banzuId.proteamid=? and jf.jcsType like ?";
		return getHibernateTemplate().find(hql,new Object[]{bzId,"%"+jcType+",%"});
	}

	@Override
	public void saveCharge(JCCharge jcCharge) {
		getHibernateTemplate().save(jcCharge);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> getJCChargeByBzUser(UsersPrivs user) {
		String sql="select dp.* from dict_proteam dp where EXISTS (select distinct proteamid from jc_charge jc where userid=? and jc.proteamid=dp.proteamid)";
		return getSession().createSQLQuery(sql).addEntity(DictProTeam.class).setLong(0, user.getUserid()).list();
	}

	@Override
	public DictProTeam getDictProTeamById(long proteamid) {
		return getHibernateTemplate().get(DictProTeam.class, proteamid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCCharge> getJCChargeByItemId(int itemId) {
		String hql="from JCCharge jc where jc.fixitem.thirdUnitId=?";
		return getHibernateTemplate().find(hql,itemId);
	}

	@Override
	public void deleteJcCharge(UsersPrivs user, long proteamid) {
		String hql="delete from JCCharge jc where jc.user.userid=? and jc.proteamId.proteamid=?";
		getSession().createQuery(hql).setEntity(0, user).setLong(1, proteamid).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCCharge> getJCChargeByItemUserId(UsersPrivs user,
			long proteamid) {
		String hql="from JCCharge jc where jc.user.userid=? and jc.proteamId.proteamid=?";
		return getHibernateTemplate().find(hql,new Object[]{user.getUserid(),proteamid});
	}

	@Override
	public List<DatePlanPri> getDivsionJc() {
		String hql="from DatePlanPri dp where dp.planStatue=0 and dp.projectType=?";
		return getHibernateTemplate().find(hql,Contains.XX_PROJECT_TYPE);
	}

	@Override
	public void saveChoice(JCChoice jcChoice) {
		getHibernateTemplate().save(jcChoice);
	}
	
	public JCChoice getJCChoiceByUserDpId(int dpId,UsersPrivs user){
		String hql="from JCChoice jcc where jcc.dpId.rjhmId=? and jcc.userId.userid=?";
		List list=getHibernateTemplate().find(hql,new Object[]{dpId,user.getUserid()});
		if(list!=null&&list.size()>0){
			return (JCChoice)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<JCChoice> getJCChoiceByUser(UsersPrivs user) {
		String hql="from JCChoice jcc where jcc.userId.userid=? and jcc.dpId.planStatue=0";
		return getHibernateTemplate().find(hql,user.getUserid());
	}
	
	@Override
	public List<JCChoice> getJCChoice() {
		String hql="from JCChoice jcc where jcc.dpId.planStatue=0";
		return getHibernateTemplate().find(hql);
	}

	@Override
	public PresetDivision findPresetRelateByFixitemId(int itemId) {
		String hql = "select pr.presetId from PresetRelateID pr where pr.fixitem=?";
		return (PresetDivision) this.getSession().createQuery(hql).setInteger(0, itemId).list().get(0);
		
	}

	@Override
	public PresetDivision findPresetRelateByZxFixitemId(int itemId,String jcType) {
		String hql = "select pr.presetId from PresetRelateID pr where pr.jcZXFixItemId=? and pr.presetId.jcValue like ?";
		return (PresetDivision) this.getSession().createQuery(hql).setInteger(0, itemId).setString(1, "%"+jcType+"%").list().get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJStaticInfo> findPJStaticInfo(String jcType, String bzid) {
		String hql="from PJStaticInfo t where t.jcType like ? and t.bzIds like ? order by t.pjsid";
		return getHibernateTemplate().find(hql,new Object[]{"%,"+jcType+",%","%,"+bzid+",%"});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJPresetDivision> findPJPresetDivision(Long pjsId) {
		String hql="from PJPresetDivision t where t.pjsId.pjsid=?";
		return getHibernateTemplate().find(hql,pjsId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixItem> findPJFixItem(Long pjsId) {
		String hql="from PJFixItem t where t.pjStaticInfo.pjsid=?";
		return getHibernateTemplate().find(hql,pjsId);
	}

	@Override
	public void savePJPresetDivision(PJPresetDivision pjPreset) {
		getHibernateTemplate().saveOrUpdate(pjPreset);
	}
	
	public void delPJPresetDivision(Long presetId){
		String hql="delete from PJPresetDivision t where t.presetId=?";
		getSession().createQuery(hql).setLong(0, presetId).executeUpdate();
	}
}
