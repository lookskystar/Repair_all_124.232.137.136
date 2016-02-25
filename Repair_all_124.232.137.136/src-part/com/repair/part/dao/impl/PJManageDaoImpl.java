package com.repair.part.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.common.pojo.Addvancetip;
import com.repair.common.pojo.Deliverytip;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictWZNum;
import com.repair.common.pojo.PDeliverytip;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixFlowType;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJHandoverRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.Storetip;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;
import com.repair.part.dao.PJManageDao;

public class PJManageDaoImpl extends AbstractDao implements PJManageDao {

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJStaticInfo> findPJStaticInfo(String jcsType, Long firstUnitId, Integer flowTypeId, String pjName, String bzId) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from PJStaticInfo pjs where 1=1");
		if (jcsType != null && !jcsType.equals("")) {
			builder.append(" and pjs.jcType like ?");
			params.add("%" + jcsType + ",%");
		}
		if (firstUnitId != null && !firstUnitId.equals("")) {
			builder.append(" and pjs.firstUnit.firstunitid=?");
			params.add(firstUnitId);
		}
		if (flowTypeId != null && !flowTypeId.equals("")) {
			builder.append(" and pjs.pjFixFlowType.flowTypeId=?");
			params.add(flowTypeId);
		}
		if (pjName != null && !pjName.equals("")) {
			builder.append(" and pjs.pjName like ?");
			params.add("%" + pjName + "%");
		}
		if (bzId != null && !bzId.equals("")) {
			builder.append(" and pjs.bzIds like ?");
			params.add("%" + bzId + "%");
		}
		builder.append(" order by pjs.pjsid");
		return findPageModel(builder.toString(), params.toArray());
	}
	/**
	 * 唐倩2015-7-28修改 配件大类中大部件以名称查询
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJStaticInfo> findPJStaticInfo1(String jcsType, String firstUnitName, Integer flowTypeId, String pjName, String bzId) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from PJStaticInfo pjs,DictFirstUnit df where pjs.firstUnit.firstunitid=df.firstunitid");
		if (jcsType != null && !jcsType.equals("")) {
			builder.append(" and pjs.jcType like ?");
			params.add("%" + jcsType + ",%");
		}
		if (firstUnitName != null && !firstUnitName.equals("")) {
			builder.append(" and df.firstunitname = ?");
			params.add(firstUnitName);
		}
		
		if (pjName != null && !pjName.equals("")) {
			builder.append(" and pjs.pjName like ?");
			params.add("%" + pjName + "%");
		}
		if (bzId != null && !bzId.equals("")) {
			builder.append(" and pjs.bzIds like ?");
			params.add("%" + bzId + "%");
		}
		builder.append(" order by pjs.pjsid");
		return findPageModel(builder.toString(), params.toArray());
	}
	@Override
	public List<DictJcStype> findDictJcStype() {
		return getHibernateTemplate().find("from DictJcStype");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> findDictFirstUnit(String jcsType) {
		String hql = "from DictFirstUnit where jcstypevalue like ?";
		return getHibernateTemplate().find(hql, "%" + jcsType + ",%");
	}

	@Override
	public List<PJFixFlowType> findPJFixFlowType() {
		return getHibernateTemplate().find("from PJFixFlowType");
	}

	@Override
	public void saveOrUpdatePJStaticInfo(PJStaticInfo pjStaticInfo) {
		getHibernateTemplate().saveOrUpdate(pjStaticInfo);
	}

	@Override
	public PJStaticInfo findPJStaticInfoById(Long pjId) {
		return getHibernateTemplate().get(PJStaticInfo.class, pjId);
	}

	@Override
	public void delPJStaticInfo(PJStaticInfo pjStaticInfo) {
		getHibernateTemplate().delete(pjStaticInfo);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String jcsType, Long firstUnitId, String pjName, String pjNum, Integer pjStatus, Integer storePosition, String getOnNum, String bzId) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from PJDynamicInfo pjd where 1=1");
		if (jcsType != null && !jcsType.equals("")) {
			builder.append(" and pjd.pjStaticInfo.jcType like ?");
			params.add("%" + jcsType + ",%");
		}
		if (firstUnitId != null && !firstUnitId.equals("")) {
			builder.append(" and pjd.pjStaticInfo.firstUnit.firstunitid=?");
			params.add(firstUnitId);
		}
		if (pjName != null && !pjName.equals("")) {
			builder.append(" and pjd.pjName like ?");
			params.add("%" + pjName + "%");
		}
		if (pjNum != null && !pjNum.equals("")) {
			builder.append(" and pjd.pjNum like ?");
			params.add("%" + pjNum + "%");
		}
		if (pjStatus != null && !pjStatus.equals("")) {
			builder.append(" and pjd.pjStatus=?");
			params.add(pjStatus);
		}
		if (storePosition != null && !storePosition.equals("")) {
			builder.append(" and pjd.storePosition=?");
			params.add(storePosition);
		}
		if (getOnNum != null && !"".equals(getOnNum)) {
			builder.append(" and pjd.getOnNum like ?");
			params.add("%" + getOnNum + "%");
		}
		if (bzId != null && !"".equals(bzId)) {
			builder.append(" and pjd.pjStaticInfo.bzIds like ?");
			params.add("%" + bzId + "%");
		}
		builder.append(" order by pjd.pjStatus,pjd.storePosition asc,pjd.pjdid asc");
		return findPageModel(builder.toString(), params.toArray());
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId) {
		return getHibernateTemplate().get(PJDynamicInfo.class, pjdId);
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByPJNum(String pjNum) {
		List<PJDynamicInfo> list = getHibernateTemplate().find("from PJDynamicInfo pdi where pdi.pjNum=? order by pdi.pjdid desc", pjNum);
		if (null != list && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public long uniquePJNum(String pjnum, Long pjdid) {
		Object count = 0;
		if (pjdid != null) {
			count = getSession().createSQLQuery("select count(*) from pj_dynamicinfo where pjnum=? and pjdid!=?").setString(0, pjnum).setLong(1, pjdid).uniqueResult();
		} else {
			count = getSession().createSQLQuery("select count(*) from pj_dynamicinfo where pjnum=?").setString(0, pjnum).uniqueResult();
		}
		return Long.parseLong(count + "");
	}

	@Override
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pjDynamicInfo) {
		getHibernateTemplate().saveOrUpdate(pjDynamicInfo);
	}

	@Override
	public void delPJDyInfo(PJDynamicInfo pjDynamicInfo) {
		getHibernateTemplate().delete(pjDynamicInfo);
	}

	public void delPJFixRecord(Long pjDynamicId) {
		getSession().createQuery("delete from PJFixRecord t where t.pjDynamicInfo.pjdid=?").setLong(0, pjDynamicId).executeUpdate();
	}

	public void delPJPredict(Long pjDynamicId) {
		getSession().createQuery("delete from PJPredict t where t.pjDynamicInfo.pjdid=?").setLong(0, pjDynamicId).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJHandoverRecord> findPJHandoverRecord() {
		return findPageModel("from PJHandoverRecord order by id desc");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJDynamicInfo> findPJDynamicInfoByHandoverRecord(int hrId) {
		return getHibernateTemplate().find("from PJDynamicInfo pdi where pdi.handoverRecord.id=?", hrId);
	}

	@Override
	public void addHandoverRecord(PJHandoverRecord handoverRecord) {
		getHibernateTemplate().saveOrUpdate(handoverRecord);
	}

	@SuppressWarnings("unchecked")
	public List<PJDynamicInfo> findPJDynamicInfoHandover(Integer pjStatus, String pjName, String pjNum) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from PJDynamicInfo pjd where pjd.handoverRecord is null");
		if (pjName != null && !pjName.equals("")) {
			builder.append(" and pjd.pjName like ?");
			params.add("%" + pjName + "%");
		}
		if (pjNum != null && !pjNum.equals("")) {
			builder.append(" and pjd.pjNum like ?");
			params.add("%" + pjNum + "%");
		}
		if (null != pjStatus) {
			builder.append(" and pjd.pjStatus = ?");
			params.add(pjStatus);
		}
		builder.append(" order by pjd.pjdid");
		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}

	@Override
	public void updatePJDynamicInfo(final int hrId, final List<Long> pjdIds) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery("update PJDynamicInfo pdi set pdi.handoverRecord.id=:hrid where pdi.pjdid in (:pidids)");
				query.setParameter("hrid", hrId);
				query.setParameterList("pidids", pjdIds);
				return query.executeUpdate();
			}
		});
	}

	@Override
	public PJHandoverRecord findPJHandoverRecord(int id) {
		return getHibernateTemplate().get(PJHandoverRecord.class, id);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid) {
		String hql = "from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and (pjfr.type=0 or pjfr.type=2) order by pjfr.pjRecId";
		return getHibernateTemplate().find(hql, pjdid);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long recId) {
		// String
		// hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and pjfr.datePlan.planId=? and pjfr.type=1 order by pjfr.pjRecId";
		String hql = "from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and pjfr.type=1 and pjfr.parentId=? order by pjfr.teams desc,pjfr.pjRecId asc";
		return getHibernateTemplate().find(hql, new Object[] { pjdid, recId });
	}

	@Override
	public void updatePjStatus(Long pjId) {
		String hql = "update PJDynamicInfo pdi set pdi.pjStatus=1,pdi.getOnNum=null,pdi.storePosition=0 where pdi.pjdid=?";
		getSession().createQuery(hql).setLong(0, pjId).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<DictWZNum> findDictWzNum(String pjName) {
		String hql = "from DictWZNum dn where 1=1";
		if (pjName != null && !pjName.equals("")) {
			hql += " and dn.wzName like '%" + pjName + "%'";
		}
		return findPageModel(hql);
	}

	public List<?> findPartCount(String jcType) {
		String hql = "select t.pjStaticInfo.pjsid,t.pjName," + "(select s.firstUnit.firstunitid from PJStaticInfo s where s.pjsid=t.pjStaticInfo.pjsid) as fid," + "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid and p.pjStatus=0) as hg," + "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid and p.pjStatus=1) as dx," + "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid and p.pjStatus=3) as jx," + "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid ) as zj," + "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid and p.storePosition=2) as wz " + "from PJDynamicInfo t where t.pjStaticInfo.jcType like ? group by t.pjStaticInfo.pjsid,t.pjName order by t.pjStaticInfo.pjsid";
		List<?> list = getSession().createQuery(hql).setString(0, "%," + jcType + ",%").list();
		return list;
	}
	
	public List<?> findPartCountWith(String jcType) {
		String hql = "select t.pjStaticInfo.pjsid,t.pjName," 
			+ "(select s.firstUnit.firstunitid from PJStaticInfo s where s.pjsid=t.pjStaticInfo.pjsid) as fid," 
			+ "(select count(*) from PJDynamicInfo p where p.pjStaticInfo.pjsid=t.pjStaticInfo.pjsid and p.pjStatus=0 and p.storePosition= 0)" 
			+ "from PJDynamicInfo t where t.pjStaticInfo.jcType like ? group by t.pjStaticInfo.pjsid,t.pjName order by t.pjStaticInfo.pjsid";
		List<?> list = getSession().createQuery(hql).setString(0, "%," + jcType + ",%").list();
		return list;
	}

	@Override
	public int findCountParts(Long firstUnitId, Integer status, String jcType) {
		String hql = "select count(t.pjdid) from PJDynamicInfo t where t.pjStaticInfo.firstUnit.firstunitid=? and t.pjStatus=? and t.pjStaticInfo.jcType like ?";
		Long count = (Long) getSession().createQuery(hql).setLong(0, firstUnitId).setInteger(1, status).setString(2, "%," + jcType + ",%").uniqueResult();
		if (count != null && count != 0) {
			return Integer.parseInt(count + "");
		}
		return 0;
	}
	
	public Long findCountPart(Long firstUnitId, Integer status, String jcType, Integer position){
		String hql = "select count(t.pjdid) from PJDynamicInfo t where t.pjStaticInfo.firstUnit.firstunitid= :firstunitid and t.pjStatus= :pjStatus and t.storePosition= :storePosition and t.pjStaticInfo.jcType like :jcType ";
		return (Long)this.getSession().createQuery(hql).setParameter("firstunitid", firstUnitId).setParameter("pjStatus", status).setParameter("storePosition", position).setParameter("jcType", "%,"+ jcType +",%").uniqueResult();
	}

	@Override
	public int findCountPartsOnTrain(Long firstUnitId, Integer storePosition, String jcType) {
		String hql = "select count(t.pjdid) from PJDynamicInfo t where t.pjStaticInfo.firstUnit.firstunitid=? and t.storePosition=? and t.pjStaticInfo.jcType like ?";
		Long count = (Long) getSession().createQuery(hql).setLong(0, firstUnitId).setInteger(1, storePosition).setString(2, "%," + jcType + ",%").uniqueResult();
		if (count != null && count != 0) {
			return Integer.parseInt(count + "");
		}
		return 0;
	}

	@Override
	public void updatePjComments(Long pjdId, String comments) {
		String hql = "update PJDynamicInfo t set t.comments=? where t.pjdid=?";
		getSession().createQuery(hql).setString(0, comments).setLong(1, pjdId).executeUpdate();
	}

	@Override
	public void savePJFixRecord(PJFixRecord pjFixRecord) {
		getHibernateTemplate().saveOrUpdate(pjFixRecord);
	}

	@Override
	public PageModel<Deliverytip> findDeliverytip(PDeliverytip pDeliverytip) {
		StringBuilder hqlBuilder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		hqlBuilder.append(" from Deliverytip t where 1=1");
		if (StringUtils.isNotEmpty(pDeliverytip.getGetoffnum())) {
			hqlBuilder.append(" and t.getoffnum like '%" + pDeliverytip.getGetoffnum() + "%'");
		}
		if (StringUtils.isNotEmpty(pDeliverytip.getFixproteam())) {
			hqlBuilder.append(" and t.fixproteam = ?");
			params.add(pDeliverytip.getFixproteam());
		}
		if (StringUtils.isNotEmpty(pDeliverytip.getDeliverydate())) {
			hqlBuilder.append(" and t.deliverydate = ?");
			params.add(pDeliverytip.getDeliverydate());
		}
		if (StringUtils.isNotEmpty(pDeliverytip.getPjname())) {
			hqlBuilder.append(" and t.pjname = ?");
			params.add(pDeliverytip.getPjname());
		}
		hqlBuilder.append(" and t.isactive = 1");
		hqlBuilder.append(" order by t.status, t.deliverydate desc, t.id");
		return findPageModel(hqlBuilder.toString(), params.toArray());
	}

	@Override
	public void save(Deliverytip deliverytip) {
		this.getHibernateTemplate().saveOrUpdate(deliverytip);
	}

	@Override
	public Integer deleteDeliverytip(List<String> indexs) {
		Integer returnRows;
		String hql = "update Deliverytip t set t.isactive = 0 where t.id in (:ids)";
		returnRows = this.getSession().createQuery(hql).setParameterList("ids", indexs).executeUpdate();
		return returnRows;
	}

	@Override
	public void fixSignDeliverytip(List<String> indexs, String username, String status) {
		String hql = "update Deliverytip t set t.status = :status, t.fixperson= :fixperson where t.id in (:ids)";
		this.getSession().createQuery(hql).setParameter("status", status).setParameter("fixperson", username).setParameterList("ids", indexs).executeUpdate();
	}

	@Override
	public Deliverytip findexchangeTipsById(String id) {
		return this.getHibernateTemplate().get(Deliverytip.class, id);
	}

	@Override
	public PageModel<Addvancetip> addvanceTipsList(String getonnum, String pjname, String pjnum, String addvanceperson, String addvancedate, String type) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from Addvancetip t where 1=1");
		if (StringUtils.isNotEmpty(getonnum)) {
			builder.append(" and t.getonnum like ?");
			params.add("'%" + getonnum + "%'");
		}
		if (StringUtils.isNotEmpty(pjname)) {
			if(StringUtils.isNotEmpty(type)){
				builder.append(" and t.pjname = ?");
				params.add(pjname);
			}else {
				builder.append(" and t.pjname like ?");
				params.add("'%" + pjname + "%'");
			}
		}
		if (StringUtils.isNotEmpty(pjnum)) {
			builder.append(" and t.pjnum like ?");
			params.add("'%" + pjnum + "%'");
		}
		if (StringUtils.isNotEmpty(addvanceperson)) {
			builder.append(" and t.addvanceperson = ?");
			params.add(addvanceperson);
		}
		if (StringUtils.isNotEmpty(addvancedate)) {
			builder.append(" and t.addvancedate = ?");
			params.add(addvancedate);
		}
		builder.append(" and t.isactive = 1");
		if(StringUtils.isNotEmpty(type)){
			builder.append(" and t.status = '2'");
		}
		builder.append(" order by t.status, t.addvancedate desc, t.id");
		return findPageModel(builder.toString(), params.toArray());
	}

	@Override
	public void save(Addvancetip addvancetip) {
		this.getHibernateTemplate().saveOrUpdate(addvancetip);
	}

	@Override
	public Integer deleteAddvancetip(List<String> indexs) {
		Integer returnRows;
		String hql = "update Addvancetip t set t.isactive = 0 where t.id in (:ids)";
		returnRows = this.getSession().createQuery(hql).setParameterList("ids", indexs).executeUpdate();
		return returnRows;
		
	}

	@Override
	public void addvanceTipsStoreSign(List<String> indexs, String xm) {
		String hql = "update Addvancetip t set t.status = :status, t.deliveryperson= :deliveryperson where t.id in (:ids)";
		this.getSession().createQuery(hql).setParameter("status", "2").setParameter("deliveryperson", xm).setParameterList("ids", indexs).executeUpdate();
	}

	@Override
	public Addvancetip addvanceTipsDependence(String id) {
		return this.getHibernateTemplate().get(Addvancetip.class, id);
	}

	@Override
	public PageModel<Storetip> storeInputTipsList(String getofnum, String pjname, String pjnum, String handler, String inputdate, String type) {
		StringBuilder builder = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		builder.append("from Storetip t where 1=1");
		if (StringUtils.isNotEmpty(getofnum)) {
			builder.append(" and t.getofnum like ?");
			params.add("'%" + getofnum + "%'");
		}
		if (StringUtils.isNotEmpty(pjname)) {
			if(StringUtils.isNotEmpty(type)){
				builder.append(" and t.pjname =?");
				params.add(pjname);
			}else{
				builder.append(" and t.pjname like ?");
				params.add("'%" + pjname + "%'");
			}
			
		}
		if (StringUtils.isNotEmpty(pjnum)) {
			builder.append(" and t.pjnum like ?");
			params.add("'%" + pjnum + "%'");
		}
		if (StringUtils.isNotEmpty(handler)) {
			builder.append(" and t.handler = ?");
			params.add(handler);
		}
		if (StringUtils.isNotEmpty(inputdate)) {
			builder.append(" and t.inputdate = ?");
			params.add(inputdate);
		}
		builder.append(" and t.isactive = 1");
		builder.append(" order by t.inputdate desc, t.id");
		return findPageModel(builder.toString(), params.toArray());
	}

	@Override
	public void saveStoreInputTips(Storetip storetip) {
		this.getHibernateTemplate().saveOrUpdate(storetip);
	}

	@Override
	public Integer deleteStoretip(List<String> indexs) {
		Integer returnRows;
		String hql = "update Storetip t set t.isactive = 0 where t.id in (:ids)";
		returnRows = this.getSession().createQuery(hql).setParameterList("ids", indexs).executeUpdate();
		return returnRows;
	}
}
