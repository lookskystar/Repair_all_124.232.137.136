package com.repair.ts.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.TsAtRecord;
import com.repair.common.pojo.TsUnit;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.ts.dao.TsDao;

public class TsDaoImpl extends AbstractDao implements TsDao {

	public void tsDepot(TsAtRecord tsAtRecord) {
		getHibernateTemplate().saveOrUpdate(tsAtRecord);
	}

	public List<TsAtRecord> listDepot() {
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd ");
		String today = sd.format(date);
		String btime = today + "00:00:00";
		String etime = today + "23:59:59";

		return getHibernateTemplate().find(
				"from TsAtRecord t where t.status = 0 and t.atTime > '" + btime
						+ "' and t.atTime < '" + etime + "'");
	}

	public TsAtRecord findDepot(int id) {
		String hql = "from TsAtRecord t where t.id = ?";
		return (TsAtRecord) getSession().createQuery(hql).setInteger(0, id)
				.uniqueResult();

	}

	public List<DictJcStype> findAllJcTypes() {
		return getHibernateTemplate().find("from DictJcStype");
	}

	public List findAllXc() {
		return getHibernateTemplate().find(
				"select distinct flowVal from DictJcFixSeq");
	}

	public List<TsAtRecord> listDepotRecord() {

		return getHibernateTemplate().find(
				"from TsAtRecord t where t.status = 1");
	}

	public PageModel<TsAtRecord> listRecord(String btime, String etime) {
		StringBuilder builder = new StringBuilder();
		List<String> params = new ArrayList<String>();
		builder.append("from TsAtRecord t where t.status = 2");

		if (btime != null && !"".equals(btime)) {
			String begintime = btime + " 00:00:00";
			builder.append(" and t.atTime > ?");
			params.add("" + begintime + "");
		}
		if (etime != null && !"".equals(etime)) {
			String endtime = etime + " 23:59:59";
			builder.append(" and t.atTime < ?");
			params.add("" + endtime + "");
		}
		builder.append(" order by t.atTime desc, t.id ");
		return findPageModel(builder.toString(), params.toArray());
	}

	public List<UsersPrivs> listTsWorker() {
		return getHibernateTemplate()
				.find(
						"from UsersPrivs u where u.bzid = (select d.proteamid from DictProTeam d where d.py = '"
								+ Contains.TSZ_PY + "')");
	}

	public List<TsUnit> listUnit(int bzid) {
		return getHibernateTemplate().find(
				"from TsUnit t where t.bzid = " + bzid + "");
	}

}
