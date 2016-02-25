package com.repair.kq.dao.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.kq.dao.AnomalouDao;

public class AnomalouDaoImpl extends HibernateDaoSupport implements AnomalouDao {

	@Override
	public List<Object> countAnomalousEarly(String month, String proteamId, String userName) {
		String sql = "select ed, (sum(is_goearly)+sum(is_goearly_b)) early from ";
		sql += " (select * from " ;
		sql += " (select to_char(s_date, 'yyyy-mm-dd') ed from ";
		sql += " (select to_date('"+ month +"','yyyy-mm') + (rownum-1) s_date from dual connect by rownum <= last_day(to_date('"+ month +"','yyyy-mm')) - to_date('"+ month +"','yyyy-mm')+1)) ms";
		sql += " left join (select * from kq_signrec where 1=1";
		if (StringUtils.isNotEmpty(proteamId)) {
			sql += " and proteamid = "+ proteamId +"";
		}
		if (StringUtils.isNotBlank(userName)) {
			sql += " and xm = '"+ userName +"'";
		}
		sql += " ) ks on ms.ed = ks.day)";
		sql += " group by ed order by ed";
		List<Object> results = this.getSession().createSQLQuery(sql).list();
		return results;
	}

	@Override
	public List<Object> countAnomalousLate(String month, String proteamId, String userName) {
		String sql = "select ed, (sum(is_late)+sum(is_late_b)) late from ";
		sql += " (select * from " ;
		sql += " (select to_char(s_date, 'yyyy-mm-dd') ed from ";
		sql += " (select to_date('"+ month +"','yyyy-mm') + (rownum-1) s_date from dual connect by rownum <= last_day(to_date('"+ month +"','yyyy-mm')) - to_date('"+ month +"','yyyy-mm')+1)) ms";
		sql += " left join (select * from kq_signrec where 1=1";
		if (StringUtils.isNotEmpty(proteamId)) {
			sql += " and proteamid = "+ proteamId +"";
		}
		if (StringUtils.isNotBlank(userName)) {
			sql += " and xm = '"+ userName +"'";
		}
		sql += " ) ks on ms.ed = ks.day)";
		sql += " group by ed order by ed";
		List<Object> results = this.getSession().createSQLQuery(sql).list();
		return results;
	}

}
