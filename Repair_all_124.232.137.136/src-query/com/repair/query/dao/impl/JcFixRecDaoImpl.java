package com.repair.query.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.query.dao.JcFixRecDao;

public class JcFixRecDaoImpl extends AbstractDao implements JcFixRecDao{

	@SuppressWarnings("unchecked")
	@Override
	public Map<Integer, PageModel<Object[]>> getTotalDuration(String startDate, String endDate,
			String jcNum, String fixEmp) {
		Map<Integer, PageModel<Object[]>> map = new HashMap<Integer, PageModel<Object[]>>();
		StringBuffer dataBuffer = new StringBuffer();
		dataBuffer.append("select r.fixEmp, sum(r.duration) as duration from JCFixrec r where r.fixEmp is not null");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			dataBuffer.append("  and r.empAfformTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			dataBuffer.append("  and  r.jcNum = '"+jcNum+"'");
		}
		if(fixEmp != null && !"".equals(fixEmp)){
			dataBuffer.append("  and  r.fixEmp like '%"+fixEmp+"%'");
		}
		dataBuffer.append("  group by r.fixEmp order by r.fixEmp");
		String hql = "select count(distinct fixEmp) from jc_fixrec";
		Object dataSize = this.getSession().createSQLQuery(hql).uniqueResult();
		map.put(Integer.parseInt(dataSize.toString()), findPageModel(dataBuffer.toString()));
		return map;
	}
	
	
	@SuppressWarnings("unchecked")
	public Map<Integer, PageModel<Object[]>> getZxDuration(String startDate, String endDate,
			String jcNum, String fixEmp) {
		Map<Integer, PageModel<Object[]>> map = new HashMap<Integer, PageModel<Object[]>>();
		StringBuffer dataBuffer = new StringBuffer();
		dataBuffer.append("select z.fixEmp, sum(z.duration) as duration from JCZXFixRec z where z.fixEmp is not null");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			dataBuffer.append("  and z.fixEmpTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			dataBuffer.append("  and  z.jcNum = '"+jcNum+"'");
		}
		if(fixEmp != null && !"".equals(fixEmp)){
			dataBuffer.append("  and  z.fixEmp like '%"+fixEmp+"%'");
		}
		dataBuffer.append("  group by z.fixEmp order by z.fixEmp");
		
		String hql = "select count(distinct fixEmp) from jc_zx_fixrec";
		Object dataSize = this.getSession().createSQLQuery(hql).uniqueResult();
		map.put(Integer.parseInt(dataSize.toString()), findPageModel(dataBuffer.toString()));
		return map;
	}
	
	
	
	public PageModel<JCFixrec> itemTime(String startDate, String endDate,
			String jcNum,String fixEmp) {
		StringBuffer hql = new StringBuffer();
		hql.append("from JCFixrec r where r.fixEmp like '%"+fixEmp+"%'");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			hql.append("  and r.empAfformTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			hql.append("  and  r.jcNum = '"+jcNum+"'");
		}
		hql.append(" order by r.empAfformTime desc, r.jcRecId");
		return findPageModel(hql.toString());
	}
	//唐倩 2015-7-7 增加角色、班组、机车类型查询条件
	@SuppressWarnings("unchecked")
	public Map<Object, PageModel<Object[]>> repCount(String startDate, String endDate,
			String jcNum,String dealFixEmp,Long type,Long roleid,Long bzid) {
		Map<Object, PageModel<Object[]>> resultMap = new HashMap<Object, PageModel<Object[]>>();
		//记录hql
		StringBuffer recHql = new StringBuffer();
		//计数sql
		StringBuffer countSQL = new StringBuffer();
		
		/*if(roleid != null && !"".equals(roleid)){
			recHql.append("select d.dealFixEmp,count(d.repsituation) as zeroKiloRecId from JtPreDict d where d.fixEmpId in(select u.user.userid from UserRolePrivs u where u.role.roleid="+roleid+")");
			countSQL.append("select count(*) from (select jt.dealFixEmp jtDealFixEmp,count(jt.repsituation) as zeroKiloRecId  from JT_PREDICT jt where jt.fixEmpId in (select u.userid from UserRole_Privs u where u.roleid="+roleid+")");
		}*/
		recHql.append("select d.dealFixEmp,count(d.repsituation) as zeroKiloRecId from JtPreDict d where 1=1");
		countSQL.append("select count(*) from (select jt.dealFixEmp jtDealFixEmp,count(jt.repsituation) as zeroKiloRecId  from JT_PREDICT jt where 1=1  ");
		
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			recHql.append("  and d.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
			countSQL.append("  and " + "jt.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			recHql.append("  and  d.jcNum = '"+jcNum+"'");
			countSQL.append("  and  jt.jcNum = '"+jcNum+"'");
		}
		//唐倩 2015-7-7
		if(type != null && !"".equals(type)){//机车类型
			recHql.append("  and  d.type = '"+type+"'");
			countSQL.append("  and  jt.type = '"+type+"'");
		}
		if(bzid != null && !"".equals(bzid)){//班组
			recHql.append("  and  d.proTeamId.proteamid = '"+bzid+"'");
			countSQL.append("  and  jt.PROTEAMID = '"+bzid+"'");
		}
		if(dealFixEmp != null && !"".equals(dealFixEmp)){
			recHql.append("  and  d.dealFixEmp like '%"+dealFixEmp+"%'");
			countSQL.append("  and  jt.dealFixEmp like '%"+dealFixEmp+"%'");
		}
		recHql.append(" group by d.dealFixEmp having dealFixEmp is not null order by count(d.repsituation) desc");
		countSQL.append(" group by jt.dealFixEmp having dealFixEmp is not null ) realRec");
		Object countRec = this.getSession().createSQLQuery(countSQL.toString()).uniqueResult();
		resultMap.put(countRec, findPageModel(recHql.toString()));
		return resultMap;
	}
	//唐倩 2015-7-7 增加角色、班组、机车类型查询条件
	@SuppressWarnings("unchecked")
	public Map<Object, PageModel<Object[]>> reportCount(String startDate, String endDate,
			String jcNum,String dealFixEmp,Long type,Long roleid,Long bzid) {
		Map<Object, PageModel<Object[]>> resultMap = new HashMap<Object, PageModel<Object[]>>();
		//记录hql
		StringBuffer recHql = new StringBuffer();
		//计数sql
		StringBuffer countSQL = new StringBuffer();
		/*if(roleid != null && !"".equals(roleid)){
			recHql.append("select d.repemp,count(d.preDictId) as count1,sum(score) as score from JtPreDict d where d.repempNo in(select u.gonghao from UsersPrivs u where u.roleid="+roleid+")");
			countSQL.append("select count(*) from (select jt.repemp repemp,count(jt.preDictId) as zeroKiloRecId  from JT_PREDICT jt where jt.REPEMPNO in (select u.gonghao from Users_Privs u where u.roleid="+roleid+")");
		}*/
		recHql.append("select d.repemp,count(d.preDictId) as count1,sum(score) as score from JtPreDict d where 1=1");
		countSQL.append("select count(*) from (select jt.repemp repemp,count(jt.preDictId) as zeroKiloRecId  from JT_PREDICT jt where 1=1");
		
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			recHql.append("  and d.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
			countSQL.append("  and " +
					"jt.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			recHql.append("  and  d.jcNum = '"+jcNum+"'");
			countSQL.append("  and  jt.jcNum = '"+jcNum+"'");
		}
		//唐倩 2015-7-7
		if(type != null && !"".equals(type)){//机车类型
			recHql.append("  and  d.type = '"+type+"'");
			countSQL.append("  and  jt.type = '"+type+"'");
		}
		if(bzid != null && !"".equals(bzid)){//班组
			recHql.append("  and  d.proTeamId.proteamid = '"+bzid+"'");
			countSQL.append("  and  jt.PROTEAMID = '"+bzid+"'");
		}
		if(dealFixEmp != null && !"".equals(dealFixEmp)){
			recHql.append("  and  d.repemp like '%"+dealFixEmp+"%'");
			countSQL.append("  and  jt.repemp like '%"+dealFixEmp+"%'");
		}
		recHql.append(" and d.dealFixEmp is not null");//故障处理完成
		recHql.append(" group by d.repemp having repemp is not null order by count(d.preDictId) desc,sum(score) desc");
		
		countSQL.append(" and jt.dealFixEmp is not null group by jt.repemp having repemp is not null ) realRec");
		Object countRec = this.getSession().createSQLQuery(countSQL.toString()).uniqueResult();
		resultMap.put(countRec, findPageModel(recHql.toString()));
		return resultMap;
	}
	
	public PageModel<JtPreDict> repItem(String startDate, String endDate,
			String jcNum,String dealFixEmp,Long type) {
		StringBuffer hql = new StringBuffer();
		hql.append("from JtPreDict d where d.dealFixEmp like '%"+dealFixEmp+"%'");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			hql.append("  and d.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			hql.append("  and  d.datePlanPri.jcnum like '%"+jcNum+"%'");
		}
		if(type != null && !"".equals(type)){
			hql.append("  and  d.type = "+type+"");
		}
		hql.append(" order by d.fixEndTime desc, d.preDictId");
		return findPageModel(hql.toString());
	}
	
	public PageModel<JtPreDict> reportItem(String startDate, String endDate,
			String jcNum,String dealFixEmp,Long type) {
		StringBuffer hql = new StringBuffer();
		hql.append("from JtPreDict d where d.repemp like '%"+dealFixEmp+"%'");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			hql.append("  and d.fixEndTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			hql.append("  and  d.datePlanPri.jcnum like '%"+jcNum+"%'");
		}
		if(type != null && !"".equals(type)){
			hql.append("  and  d.type = "+type+"");
		}
		hql.append(" and d.dealFixEmp is not null");//故障处理完成
		hql.append(" order by d.fixEndTime desc, d.preDictId");
		return findPageModel(hql.toString());
	}


	@Override
	public PageModel<JCZXFixRec> zxItemTime(String startDate, String endDate,
			String jcNum, String fixEmp) {
		StringBuffer hql = new StringBuffer();
		hql.append("from JCZXFixRec r where r.fixEmp like '%"+fixEmp+"%'");
		if(startDate != null && !"".equals(endDate) && endDate != null && !"".equals(endDate)){
			hql.append("  and r.fixEmpTime between '"+startDate+"' and '"+endDate+"' ");
		}
		if(jcNum != null && !"".equals(jcNum)){
			hql.append("  and  r.jcNum = '"+jcNum+"'");
		}
		hql.append(" order by r.fixEmpTime desc, r.id");
		return findPageModel(hql.toString());
	}
	
	/**
	 * 从小辅修记录表中获取以及部件
	 * @param rjhmId
	 * @return
	 */
	public List<DictFirstUnit> listFirstUnitsOfJCFixRec(Integer rjhmId,int type){
		String sql=null;
		if(type==0){//小辅修
			sql="select distinct t.firstunitid as firstUnitId,t.unitname as firstUnitName from jc_fixrec t where t.dyprecid=?";
		}else{//中修
			sql="select distinct t.firstunitid as firstUnitId,t.unitname as firstUnitName from jc_zx_fixrec t where t.dyprecid=?";
		}
		return getSession().createSQLQuery(sql).setInteger(0, rjhmId).list();
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixrec> listLeftWorkRecord(Integer rjhmId) {
		String hql = "from JCFixrec po where po.datePlanPri.rjhmId=?";
		return this.getHibernateTemplate().find(hql, new Object[]{rjhmId});
	}
	
	public List<JCZXFixRec> listZXLeftWorkRecord(Integer rjhmId) {
		String hql = "from JCZXFixRec po where po.dyPrecId.rjhmId=?";
		return this.getHibernateTemplate().find(hql, new Object[]{rjhmId});
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findFixDatePlanPri() {
		String hql="from DatePlanPri t where t.planStatue<3 and t.fixFreque!=? order by t.planStatue";
		return getHibernateTemplate().find(hql,Contains.PY_LX);
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictByRjhmId(Integer rjhmId) {
		String hql="from JtPreDict t where t.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql,rjhmId);
	}


	@Override
	public void updateJtPreDictScore(Integer preDictId, Integer score) {
		String hql="update JtPreDict t set t.score=? where t.preDictId=?";
		getSession().createQuery(hql).setInteger(0, score).setInteger(1, preDictId).executeUpdate();
	}


	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return getHibernateTemplate().get(DatePlanPri.class, rjhmId);
	}
}
