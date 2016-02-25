package com.repair.work.dao.impl;

import java.util.List;
import com.repair.common.pojo.JCQZRange;
import com.repair.common.util.AbstractDao;
import com.repair.work.dao.JCQZRangeDao;


public class JCQZRangeDaoImpl extends AbstractDao implements JCQZRangeDao{
	
	
	@Override
	public Long getJcTypePlanTotalCount(String jctype) {
		String hql="select count(*) from JCQZRange where jctype=? and ofYear=extract(year from sysdate)";
		return (Long) getHibernateTemplate().find(hql,jctype).get(0);
	}
	@Override
	public Long getJcTypeRealTotalCount(String jctype){
		String hql="select count(distinct jcnum) from DatePlanPri where  extract(year from to_date(kcsj,'yyyy-MM-dd HH24:mi:ss')) = extract(year from sysdate) and fixFreque=?"
					+"and planStatue=3 and nodeid=107 and jcnum in (select jcnum from JCQZRange where jctype=?) and jctype=?";
		
		return (Long) getHibernateTemplate().find(hql,"QZ",jctype,jctype).get(0);
	}

	
	/**
	 * 获取今年计划 的秋整范围
	 * @return long    
	 * @throws
	 */
	public List<JCQZRange> listPlanJCQZRange(){
		String hql=" from JCQZRange where ofYear=extract(year from sysdate)";
		return  getHibernateTemplate().find(hql);
	}
}
