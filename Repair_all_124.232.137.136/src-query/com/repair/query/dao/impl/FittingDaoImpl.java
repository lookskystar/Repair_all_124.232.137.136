package com.repair.query.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.query.dao.FittingDao;

public class FittingDaoImpl extends HibernateDaoSupport implements FittingDao {

	@Override
	public List<String> findFittingNumberForFixRec(final int rjhmId) {
		return getHibernateTemplate().execute(new HibernateCallback<List<String>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<String> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select jzf.uppjnum from jc_zx_fixrec jzf  where jzf.uppjnum is not null and jzf.dyprecid=?");
				sqlQuery.setParameter(0, rjhmId);
				List<String> list = sqlQuery.list();
				if (null != list && !list.isEmpty()) {
					List<String> numList = new ArrayList<String>();
					for (String string : list) {
						if (null!=string && !"".equals(string)) {
							if (string.indexOf(",") != -1) {
								String[] strs = string.split(",");
								List<String> subNumList = Arrays.asList(strs);
								numList.addAll(subNumList);
							} else {
								numList.add(string);
							}
						}
					}
					return numList;
				}
				return null;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> findXXPJNums(int rjhmId,int type){
		String sql=null;
		if(type==0){//小修
			sql="select t.UPPJNUM from JC_FIXREC t where t.UPPJNUM is not null and t.DYPRECID=?";
		}else if(type==1){//临修
			sql="select t.UPPJNUM from JT_PREDICT t where t.UPPJNUM is not null and t.DATEPLANPRI=?";
		}else{//春整
			sql="select t.UPPJNUM from JC_QZ_FIXREC t where t.UPPJNUM is not null and t.JCRECMID=?";
		}
		SQLQuery sqlQuery = getSession().createSQLQuery(sql);
		sqlQuery.setParameter(0, rjhmId);
		List<String> list = sqlQuery.list();
		if (null != list && !list.isEmpty()) {
			List<String> numList = new ArrayList<String>();
			for (String string : list) {
				if (null!=string && !"".equals(string)) {
					if (string.indexOf(",") != -1) {
						String[] strs = string.split(",");
						List<String> subNumList = Arrays.asList(strs);
						numList.addAll(subNumList);
					} else {
						numList.add(string);
					}
				}
			}
			return numList;
		}
		return null;
	}
	
	@Override
	public List<String> findFittingNumberForFixRec(final int rjhmId,final long bzId) {
		return getHibernateTemplate().execute(new HibernateCallback<List<String>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<String> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select jzf.uppjnum from jc_zx_fixrec jzf  where jzf.uppjnum is not null and jzf.dyprecid=? and jzf.bzid=?");
				sqlQuery.setParameter(0, rjhmId);
				sqlQuery.setParameter(1, bzId);
				List<String> list = sqlQuery.list();
				if (null != list && list.size()>0) {
					List<String> numList = new ArrayList<String>();
					for (String string : list) {
						if (null!=string && !"".equals(string)) {
							if (string.indexOf(",") != -1) {
								String[] strs = string.split(",");
								List<String> subNumList = Arrays.asList(strs);
								numList.addAll(subNumList);
							} else {
								numList.add(string);
							}
						}
					}
					return numList;
				}
				return null;
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> forFittingNumbers(final List<String> fittingNums) {
		return getHibernateTemplate().executeFind(new HibernateCallback<List<DictFirstUnit>>() {

			@Override
			public List<DictFirstUnit> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select distinct dfu.* from DICT_FIRSTUNIT dfu join PJ_STATICINFO psi on dfu.FIRSTUNITID=psi.FIRSTUNITID join PJ_DYNAMICINFO pdi on psi.PJSID = pdi.PJSID where pdi.PJNUM in (:PJNUMS)").addEntity(DictFirstUnit.class);
				sqlQuery.setParameterList("PJNUMS", fittingNums);
				return sqlQuery.list();
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PJStaticInfo> forStaticInfo(final List<Long> firstUnitIds) {
		return getHibernateTemplate().executeFind(new HibernateCallback<List<PJStaticInfo>>() {

			@Override
			public List<PJStaticInfo> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select * from  PJ_STATICINFO pjs where pjs.FIRSTUNITID in (:FIRSTUNITIDS) order by pjs.FIRSTUNITID").addEntity(PJStaticInfo.class);
				sqlQuery.setParameterList("FIRSTUNITIDS", firstUnitIds);
				return sqlQuery.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixRecord> forFirstUnit(final long firstunitid,final List<String> fittingNums) {
		return getHibernateTemplate().executeFind(new HibernateCallback<List<PJFixRecord>>() {

			@Override
			public List<PJFixRecord> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select distinct pfc.*, psi.FIRSTUNITID from PJ_FIXRECORD pfc join PJ_DYNAMICINFO pdi on pfc.PJDID=pdi.PJDID join PJ_STATICINFO psi on pdi.PJSID=psi.PJSID where pdi.PJNUM in (:PJNUMS) and psi.FIRSTUNITID=:FIRSTUNITID and pfc.TYPE=1 order by pfc.pjname, psi.FIRSTUNITID").addEntity(PJFixRecord.class);
				sqlQuery.setParameter("FIRSTUNITID", firstunitid);
				sqlQuery.setParameterList("PJNUMS", fittingNums);
				return sqlQuery.list();
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixRecord> forPjStaticId(final long staticId,final List<String> fittingNums) {
		return getHibernateTemplate().executeFind(new HibernateCallback<List<PJFixRecord>>() {

			@Override
			public List<PJFixRecord> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select distinct pfc.*, psi.FIRSTUNITID from PJ_FIXRECORD pfc join PJ_DYNAMICINFO pdi on pfc.PJDID=pdi.PJDID join PJ_STATICINFO psi on pdi.PJSID=psi.PJSID where pdi.PJNUM in (:PJNUMS) and psi.PJSID=:PJSID and pfc.TYPE=1 order by pfc.pjname, psi.FIRSTUNITID").addEntity(PJFixRecord.class);
				sqlQuery.setParameter("PJSID", staticId);
				sqlQuery.setParameterList("PJNUMS", fittingNums);
				return sqlQuery.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixRecord> forFirstUnit(final String pjNum) {
		return getHibernateTemplate().executeFind(new HibernateCallback<List<PJFixRecord>>() {

			@Override
			public List<PJFixRecord> doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery sqlQuery = session.createSQLQuery("select distinct pfc.*,psi.FIRSTUNITID from PJ_FIXRECORD pfc join PJ_DYNAMICINFO pdi on pfc.PJDID=pdi.PJDID join PJ_STATICINFO psi on pdi.PJSID=psi.PJSID where pdi.PJNUM = :PJNUM and pfc.TYPE=1 order by pfc.pjname, psi.FIRSTUNITID").addEntity(PJFixRecord.class);
				sqlQuery.setParameter("PJNUM", pjNum);
				return sqlQuery.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public PJDynamicInfo findDynamicInfoByPjNum(String pjNum) {
		List<PJDynamicInfo> list = getHibernateTemplate().find("from PJDynamicInfo pdi where pdi.pjNum=? order by pdi.pjdid desc", pjNum);
		if (null != list && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<PJStaticInfo> findPJStaticInfoByFirstId(Long firstunitid) {
		String hql="from PJStaticInfo pjsi where pjsi.firstUnit.firstunitid=?";
		return getHibernateTemplate().find(hql,firstunitid);
	}

	@Override
	public PJStaticInfo findPJStaticInfoById(Long pjsid) {
		return getHibernateTemplate().get(PJStaticInfo.class, pjsid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixItem> findPjFixItemByStaticId(long staticId) {
		String hql="from PJFixItem t where t.pjStaticInfo.pjsid=?";
		return getHibernateTemplate().find(hql,staticId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixRecord> findPJFixRecordByDid(Long pjdid) {
		String hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and pjfr.type=1 order by pjfr.teams desc,pjfr.pjRecId";
		return getHibernateTemplate().find(hql,pjdid);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixRecord> findPJFixRecordByDid(Long pjdid,Long pjRecId,Long bzId) {
		String hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and pjfr.type=1 and pjfr.parentId=? ";
		List<Object> param = new ArrayList<Object>();
		param.add(pjdid);
		param.add(pjRecId);
		if(bzId!=null){
			hql += " and pjfr.teams=?";
			param.add(""+bzId);
		}
		hql += " order by pjfr.teams desc,pjfr.pjRecId";
		return getHibernateTemplate().find(hql,param.toArray());
	}

	@Override
	public int findDynamicInZxFixItem(Long pjsid, List<String> pjNums) {
		if(pjNums!=null&&pjNums.size()>0){
			SQLQuery sql=getSession().createSQLQuery("select count(t.pjdid) from pj_dynamicinfo t where t.pjsid=:pjsid and t.pjnum in (:pjNums)");
			sql.setParameter("pjsid", pjsid);
			sql.setParameterList("pjNums", pjNums);
			return Integer.parseInt(sql.uniqueResult()+"");
		}else{
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJDynamicInfo> findPJDynamicInfoByPjNums(Long pjsid, List<String> pjNums) {
		if(pjNums!=null&&pjNums.size()>0){
			SQLQuery sqlQuery=getSession().createSQLQuery("select t.* from pj_dynamicinfo t where t.pjsid=:pjsid and t.pjnum in (:pjNums)").addEntity(PJDynamicInfo.class);
			sqlQuery.setParameter("pjsid", pjsid);
			sqlQuery.setParameterList("pjNums", pjNums);
			return sqlQuery.list();
		}else{
			return new ArrayList<PJDynamicInfo>();
		}
	}

	@Override
	public PJFixRecord findPJFixRecordByRjhmId(Integer rjhmId,Long pjdid) {
		String hql="from PJFixRecord t where t.rjhmId=? and t.type != 1 and t.pjDynamicInfo.pjdid=? order by t.pjRecId desc";
		List list=getHibernateTemplate().find(hql,new Object[]{rjhmId,pjdid});
		if(list!=null&&list.size()>0){
			return (PJFixRecord)list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByDID(Long pjdid) {
		return getHibernateTemplate().get(PJDynamicInfo.class, pjdid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJStaticInfo> findPJStaticInfoByXXPJNums(List<String> pjNums) {
		String sql="select t1.* from pj_staticinfo t1 where t1.pjsid in(select distinct t2.pjsid from pj_dynamicinfo t2 where t2.pjnum in (:PJNUMS))";
		SQLQuery sqlQuery=getSession().createSQLQuery(sql).addEntity(PJStaticInfo.class);
		sqlQuery.setParameterList("PJNUMS", pjNums);
		return sqlQuery.list();
	}
}
