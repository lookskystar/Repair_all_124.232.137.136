package com.repair.part.dao.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Hibernate;

import com.repair.part.dao.PJDynamicInfoDao;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJUnitPart;
import com.repair.common.util.DaoManageSupport;
import com.repair.common.util.PageModel;

public class PJDynamicInfoDaoImpl extends DaoManageSupport implements
		PJDynamicInfoDao {

	@Override
	public PageModel findPageModelPJDynamicByPJSid(long pjsid,int flag) {
		if(flag==1){
			return getScrollData(PJDynamicInfo.class, "pjStaticInfo.pjsid=? and pjstatus=1 and storePosition<2", new Object[]{pjsid});
		}else{
			return getScrollData(PJDynamicInfo.class, "pjStaticInfo.pjsid=?", new Object[]{pjsid});
		}
	}

	@Override
	public List findPartChoicedByDatePlan(long pid) {
		String hql = "select pjrec.pjDynamicInfo.pjdid from PJFixRecord pjrec where pjrec.type=0 and pjrec.datePlan.planId=?";
		return getHibernateTemplate().find(hql, pid);
	}

	@Override
	public PJDynamicInfo getPJDynamicInfoById(long pjdId) {
		return getHibernateTemplate().get(PJDynamicInfo.class, pjdId);
	}
	
	@Override
	public void updatePJDynamicInfo(PJDynamicInfo pjDynamicInfo) {
		getHibernateTemplate().update(pjDynamicInfo);
	}
	
	@Override
	public void savePJUnitPart(PJUnitPart unitPart) {
		getHibernateTemplate().save(unitPart);
	}
	
	@Override
	public List<PJDynamicInfo> findPJDynamicInfoListByPJNum(String pjNum) {
		String hql = "from PJDynamicInfo pj where pj.pjNum=?";
		return getHibernateTemplate().find(hql, pjNum);
	}
	
	@Override
	public PageModel findPageModelPJDynamic(String jcType,Long firstUnitId,String pjName,String pjNum,Integer pjStatus,Long bzId) {
		StringBuilder builder=new StringBuilder();
		List<Object> params=new ArrayList<Object>();
		builder.append("1=1");
		if(jcType!=null&&!jcType.equals("")){
			builder.append(" and pjStaticInfo.jcType like ?");
			params.add("%"+jcType+",%");
		}
		if(firstUnitId!=null&&!firstUnitId.equals("")){
			builder.append(" and pjStaticInfo.firstUnit.firstunitid=?");
			params.add(firstUnitId);
		}
		if(pjName!=null&&!pjName.equals("")){
			builder.append(" and pjName like ?");
			params.add("%"+pjName+"%");
		}
		if(pjNum!=null&&!pjNum.equals("")){
			builder.append(" and pjNum like ?");
			params.add("%"+pjNum+"%");
		}
		if(pjStatus!=null&&!pjStatus.equals("")){
			builder.append(" and pjStatus=?");
			params.add(pjStatus);
		}else{
			builder.append(" and (pjstatus=1 or pjstatus=3)");
		}
		if(bzId!=null){
			builder.append(" and pjStaticInfo.bzIds like '%,"+bzId+",%'");
		}
		//builder.append(" and storePosition<2");
		LinkedHashMap<String, String> orderMap = new LinkedHashMap<String, String>();
		orderMap.put("pjstatus", "asc");
		orderMap.put("pjdid", "asc");
		return getScrollData(PJDynamicInfo.class, builder.toString(), params.toArray(),orderMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String pjName,String pjNum) {
		StringBuilder builder=new StringBuilder();
		List<Object> params=new ArrayList<Object>();
		builder.append("1=1");
		if(pjName!=null&&!pjName.equals("")){
			builder.append(" and pjName like ?");
			params.add("%"+pjName+"%");
		}
		if(pjNum!=null&&!pjNum.equals("")){
			builder.append(" and pjNum like ?");
			params.add("%"+pjNum+"%");
		}
		builder.append(" order by pjdid asc, t.pjdid");
		return getScrollData(PJDynamicInfo.class,builder.toString(),params.toArray());
	}

	@Override
	public List listPJDynamicInfo(String jcType, Long firstUnitId,
			String pjName, Long bzId) {
		StringBuilder bulider = new StringBuilder();
		bulider
				.append("select t1.pjname as pjname,t2.jctype as jcType,"
						+ "sum(case when t1.pjstatus=1 then 1 else 0 end) as repaireds,"
						+ "sum(case when t1.pjstatus=3 then 1 else 0 end) as repairings,"
						+ "sum(case when t1.pjstatus=0 and t1.storeposition<2 then 1 else 0 end) as qualifieds "
						+ " from pj_dynamicinfo t1,pj_staticinfo t2 where t1.pjsid=t2.pjsid  ");

		if(bzId!=null){
			bulider.append(" and t2.bzIds like '%,"+bzId+",%'");
		}
		if (pjName != null && !pjName.equals("")) {
			bulider.append(" and t1.pjname like '%" + pjName + "%'");
		}
		if (jcType != null && !jcType.equals("")) {
			bulider.append(" and t2.jcType like '%" + jcType + ",%'");
		}
		if (firstUnitId != null && !firstUnitId.equals("")) {
			bulider.append(" and t2.FIRSTUNITID="+firstUnitId);
		}
		bulider.append(" group by t1.pjname,t2.jctype");
		List list = getSession().createSQLQuery(bulider.toString()).addScalar(
				"pjname", Hibernate.STRING).addScalar("jcType", Hibernate.STRING)
				.addScalar("repaireds", Hibernate.LONG).addScalar("repairings",
						Hibernate.LONG).addScalar("qualifieds", Hibernate.LONG)
				.list();
		return list;
	}
	
	public Integer changePJDynamicInfoStorePosition(List<String> pjnumList, Integer position, Integer pjStatus){
		Integer returnRows;
		String hql = "update PJDynamicInfo t set t.storePosition = :position, t.pjStatus = :pjStatus where t.pjNum in (:pjNums)";
		returnRows = this.getSession().createQuery(hql).setParameter("position", position).setParameter("pjStatus", pjStatus).setParameterList("pjNums", pjnumList).executeUpdate();
		return returnRows;
	}

}
