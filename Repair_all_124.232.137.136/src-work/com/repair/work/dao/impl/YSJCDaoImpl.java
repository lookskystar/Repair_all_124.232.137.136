package com.repair.work.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.YSJCRec;
import com.repair.work.dao.YSJCRecDao;

public class YSJCDaoImpl extends HibernateDaoSupport implements YSJCRecDao{

	@Override
	public void insertYSJCRec(int rjhmId, String jcType) {
		String sql = "insert into ysjc_rec(recid,rjhmid,itemid,classify,itemname,unit,orderno,proteam) " +
				"select SEQ_YSJCREC.NEXTVAL,?,t.itemid,t.classify,t.itemname,t.unit,t.orderno,t.proteam " +
				"from ysjc_item t where t.isuse=1  and t.jctype like ?";
		getSession().createSQLQuery(sql).setInteger(0, rjhmId).setString(1, "%,"+jcType+",%").executeUpdate();
	}
	@Override
	public List<YSJCRec> listYSJCRecByRjhmId(int rjhmId) {
		String hql = "from YSJCRec t where t.datePlanPri.rjhmId=? order by t.orderNo";
		return getHibernateTemplate().find(hql,rjhmId);
	}

	@Override
	public List<YSJCRec> listYSJCRecByRjhmId(int rjhmId,long proteam) {
		String hql = "from YSJCRec t where t.datePlanPri.rjhmId=? and (t.proteam=0 or t.proteam=?) order by t.orderNo";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,proteam});
	}

	@Override
	public void updateYSJCRec(YSJCRec ysjcRec) {
		getHibernateTemplate().update(ysjcRec);
	}

	@Override
	public YSJCRec getYSJCRecById(int recId) {
		return getHibernateTemplate().get(YSJCRec.class, recId);
	}

	@Override
	public void updateSign(List<Integer> recIdList, int typeFlag, String xm,
			String signTime, Integer allFlag, Integer rjhmId) {
		StringBuilder sb = new StringBuilder();
		sb.append("update YSJCRec t set ");
		if(typeFlag==1){
			sb.append("t.tech=?, t.techAffiTime=? where 1=1 ");
		}else if(typeFlag==2){
			sb.append("t.accept=?, t.acceptAffiTime=? where 1=1 ");
		}else{
			sb.append("t.commitLead=?, t.commAffiTime=? where 1=1 ");
		}
		if(allFlag==1){//全签
			sb.append(" and t.datePlanPri.rjhmId=?");
			getSession().createQuery(sb.toString()).setString(0, xm).setString(1, signTime).setInteger(2, rjhmId).executeUpdate();
		}else{
			sb.append(" and t.recId in (:list)");
			getSession().createQuery(sb.toString()).setString(0, xm).setString(1, signTime).setParameterList("list", recIdList).executeUpdate();
		}
	}

	@Override
	public Long countYSJCRec(int rjhmId) {
		String hql = "select count(*) from YSJCRec t where t.datePlanPri.rjhmId=?";
		try{
			Long count = (Long) getHibernateTemplate().find(hql,rjhmId).get(0);
			return count;
		}catch(Exception e){
			return new Long(0);
		}
	}
	
	/**
	 * 交车工长判断签名卡控是否签完
	 */
	public long countBefSignRec(int rjhmId){
		String hql = "select count(*) from YSJCRec t where t.datePlanPri.rjhmId=? and t.tech is null and t.accept is null";
		try{
			Long count = (Long) getHibernateTemplate().find(hql,rjhmId).get(0);
			return count;
		}catch(Exception e){
			return new Long(0);
		}
	}

}
