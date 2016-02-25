package com.repair.part.dao.impl;

import java.util.LinkedHashMap;
import java.util.List;

import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJPredict;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.DaoManageSupport;
import com.repair.common.util.PageModel;
import com.repair.part.dao.PJFixRecordDao;

public class PJFixRecordDaoImpl extends DaoManageSupport implements PJFixRecordDao {

	@Override
	public void savePJFixRecord(PJFixRecord pjFixRecord) {
		getHibernateTemplate().saveOrUpdate(pjFixRecord);
	}

	@Override
	public PageModel findPageModelPJFixItemByPjSid(long pjSid, long flowId, long bzId) {
		String wherehql = "pjStaticInfo.pjsid=? and pjFixFlow.nodeId=? and team.proteamid=?";
		return getScrollData(PJFixItem.class, wherehql, new Object[] { pjSid, flowId, bzId });
	}

	@Override
	public List findPJFixRecByPJFixFlowRecAndPJRecId(PJFixFlowRecord flowRecord, Long pjRecId) {
		String hql = "select rec.pjFixItem.pjItemId from PJFixRecord rec where rec.type=1 and rec.pjFixRecSid=? "
				+ "and rec.datePlan.planId=? and rec.pjDynamicInfo.pjdid=? and rec.pjFixFlowRecord.pjFixFlow.nodeId=?";
		return getHibernateTemplate().find(
				hql,
				new Object[] { pjRecId, flowRecord.getDatePlan().getPlanId(), flowRecord.getPjDynamicInfo().getPjdid(),
						flowRecord.getPjFixFlow().getNodeId() });
	}

	@Override
	public Long findPJRecIdByDatePlanAndPJDynamic(long planId, long pjDid) {
		String hql = "select rec.pjRecId from PJFixRecord rec where rec.type=0 and rec.datePlan.planId=? and rec.pjDynamicInfo.pjdid=?";
		List list = getHibernateTemplate().find(hql, new Object[] { planId, pjDid });
		return (Long) list.get(0);
	}

	@Override
	public PJFixItem getPJFixItemById(long itemId) {
		return getHibernateTemplate().get(PJFixItem.class, itemId);
	}

	@Override
	public PageModel findPageModelUnfinishedPJFixItem(String roleFlag, UsersPrivs user) {
		String wherehql = null;
		if ("2".equals(roleFlag.trim())) { // 工长
			wherehql = "recstas<7 and type=1 and pjFixItem.team.proteamid=?";
			return getScrollData(PJFixRecord.class, wherehql, new Object[] { user.getBzid() });
		} else {
			if ("3".equals(roleFlag.trim())) {// 技术员
				wherehql = "recstas>=2 and recstas<7 and type=1  and techId is null and pjFixItem.itemctrltech=1";
			} else if ("4".equals(roleFlag.trim())) {// 质检员
				wherehql = "recstas>=2 and recstas<7 and type=1 and qiid is null and pjFixItem.itemctrlqi=1";
			} else if ("5".equals(roleFlag.trim())) {// 交车工长
				wherehql = "recstas>=2 and recstas<7 and type=1 and commitleadid is null and pjFixItem.itemctrlcomld=1";
			} else {// 验收员
				wherehql = "recstas>=2 and recstas<7 and type=1 and accepterid is null and pjFixItem.itemctrlacce=1";
			}
			return getScrollData(PJFixRecord.class, wherehql, null);
		}
	}

	@Override
	public PageModel findPageModelUnfinishedInspectionItem(long pjdid, long teamId, Long pjRecId) {
		String wherehql = "pjDynamicInfo.pjdid=? and pjFixItem.team.proteamid=? and parentId=? and pjFixItem.itemFillDefault is not null order by pjFixItem.itemOrder,pjFixItem.posiName,pjRecId";
		return getScrollData(PJFixRecord.class, wherehql, new Object[] { pjdid, teamId, pjRecId });
	}

	public Long findSignedInspectionItem(long pjDid, long teamId, Long pjRecId, int role) {
		String hql = null;
		if (role == 0) {// 工人
			hql = "select count(t.pjRecId) from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and t.parentId=? and t.fixemp is null and t.pjFixItem.itemFillDefault is not null";
		} else {// 工长或其他
			hql = "select count(t.pjRecId) from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and t.parentId=? and t.lead is null and t.pjFixItem.itemFillDefault is not null";
		}
		List list = getHibernateTemplate().find(hql, new Object[] { pjDid, teamId, pjRecId });
		return Long.parseLong(list.get(0) + "");
	}

	@Override
	public PageModel findPageModelUnfinishedDetectItem(long pjdid, Long teamId, Long pjRecId) {
		String wherehql = "pjDynamicInfo.pjdid=? and pjFixItem.team.proteamid=? and parentId=? and pjFixItem.itemFillDefault is null order by pjFixItem.itemOrder,pjFixItem.posiName,pjRecId";
		return getScrollData(PJFixRecord.class, wherehql, new Object[] { pjdid, teamId, pjRecId });
	}

	public Long findSignedDetectItem(long pjDid, long teamId, Long pjRecId, int role) {
		String hql = null;
		if (role == 0) {// 工人
			hql = "select count(t.pjRecId) from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and t.parentId=? and t.fixemp is null and t.pjFixItem.itemFillDefault is null";
		} else {// 工长或其他
			hql = "select count(t.pjRecId) from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and t.parentId=? and t.lead is null and t.pjFixItem.itemFillDefault is null";
		}
		List list = getHibernateTemplate().find(hql, new Object[] { pjDid, teamId, pjRecId });
		return Long.parseLong(list.get(0) + "");
	}

	@Override
	public PJFixRecord getPJFixRecordById(long recId) {
		return getHibernateTemplate().get(PJFixRecord.class, recId);
	}

	@Override
	public void updatePJFixRecord(PJFixRecord pjFixRecord) {
		getHibernateTemplate().update(pjFixRecord);
	}

	@Override
	public List<Long> findPJFixItemIdsByPJFlowBZ(long pjsid, Long nodeId, long bzId) {
		String wherehql = "select item.pjItemId from PJFixItem item where item.pjStaticInfo.pjsid=? and item.pjFixFlow.nodeId=? "
				+ "and item.team.proteamid=?";
		return getHibernateTemplate().find(wherehql, new Object[] { pjsid, nodeId, bzId });
	}

	@Override
	public List<Long> findAssignedPJFixItemIdsByPJFlowRecordBZ(long fixFlowId, long bzId) {
		String hql = "select rec.pjFixItem.pjItemId from PJFixRecord rec where rec.type=1 and rec.recstas=7 and rec.pjFixItem.team.proteamid=? and rec.pjFixFlowRecord.recId=?";
		return getHibernateTemplate().find(hql, new Object[] { bzId, fixFlowId });
	}

	@Override
	public PageModel findPageModelUnitHasPart() {
		return getScrollData(PJFixRecord.class, "type=0 and recstas=1", null);
	}

	@Override
	public void savePJPredict(PJPredict predict) {
		getHibernateTemplate().save(predict);
	}

	@Override
	public PageModel findPageModelPJPredict(UsersPrivs user, int flag) {
		String sql = null;
		if (flag == 0) {
			sql = "bzId=? and needApprove<>1";
		} else if (flag == 1) {
			sql = "bzId=? and needApprove=1";
		} else {
			sql = "bzId=? and status>=1";
		}
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("status", "asc");
		orderby.put("makeDate", "desc");
		orderby.put("predictId", "asc");
		return getScrollData(PJPredict.class, sql, new Object[] { user.getBzid() }, orderby);
	}

	@Override
	public PJPredict getPJPredictById(long predictId) {
		return getHibernateTemplate().get(PJPredict.class, predictId);
	}

	@Override
	public void updatePJPredict(PJPredict predict) {
		getHibernateTemplate().update(predict);
	}

	@Override
	public List<PJFixItem> findPJFixItemListByPJAndFlowAndTeam(Long pjsid, Long nodeId, Long proteamid) {
		String hql = "from PJFixItem item where item.pjStaticInfo.pjsid=? and item.pjFixFlow.nodeId=? "
				+ "and item.team.proteamid=?";
		return getHibernateTemplate().find(hql, new Object[] { pjsid, nodeId, proteamid });
	}

	@Override
	public List<PJFixItem> findPJFixItemListByPJAndFlowAndTeam(Long pjsid) {
		String hql = "from PJFixItem item where item.pjStaticInfo.pjsid=?";
		return getHibernateTemplate().find(hql, new Object[] { pjsid });
	}

//	public List listUnfinishedPartCount(Long bzId, Integer type, String jcsType, Long firstUnitId, String pjName,
//			boolean isTs) {
//		StringBuilder sql = new StringBuilder();
//		sql.append("select t.pjname,t2.jctype,t4.firstunitname,count(t.pjdid) as zaixiu,");
//		switch (type) {
//		case 1:
//			if (isTs) {
//				sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.teams='"
//						+ bzId
//						+ "' and (t3.empaffirmtime is null or (t3.rept is null and t3.itemctrlrept=1)))>0 then 1 else 0 end) as daiqian");
//			} else {
//				sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.teams='"
//						+ bzId + "' and t3.empaffirmtime is null)>0 then 1 else 0 end) as daiqian");
//			}
//			break;
//		case 2:
//			sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.teams='"
//					+ bzId + "' and t3.ldaffirmtime is null and t3.itemctrllead=1)>0 then 1 else 0 end) as daiqian");
//			break;
//		case 3:
//			sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.techtime is null and t3.itemctrltech=1)>0 then 1 else 0 end) as daiqian");
//			break;
//		case 4:
//			sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.qiaffitime is null and t3.itemctrlqi=1)>0 then 1 else 0 end) as daiqian");
//			break;
//		case 5:
//			sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.comldaffitime is null and t3.itemctrlcomld=1)>0 then 1 else 0 end) as daiqian");
//			break;
//		case 6:
//			sql.append("sum(case when (select count(*) from pj_fixrecord t3 where t3.parentid=t.pjrecid and t3.type=1 and t3.acceaffitime is null and t3.itemctrlacce=1)>0 then 1 else 0 end) as daiqian");
//			break;
//		default:
//			sql.append("0,");
//			break;
//		}
//		sql.append(" from pj_fixrecord t,pj_dynamicinfo t1,pj_staticinfo t2,dict_firstunit t4");
//		sql.append(" where t.type=0 and t.recstas<>7  and t2.firstunitid=t4.firstunitid and t.pjdid=t1.pjdid and t1.pjsid=t2.pjsid");
//		if (type == 1 || type == 2) {
//			sql.append(" and t.teams like '%," + bzId + ",%'");
//		}
//		if (jcsType != null && !"".equals(jcsType)) {
//			sql.append(" and t2.jctype like '%," + jcsType + ",%'");
//		}
//		if (firstUnitId != null) {
//			sql.append(" and t2.firstunitid=" + firstUnitId);
//		}
//		if (pjName != null && !"".equals(pjName)) {
//			sql.append(" and t.pjname like '%" + pjName + "%'");
//		}
//		sql.append(" group by t.pjname,t2.jctype,t4.firstunitname,t2.pjsid order by t2.pjsid");
//		return getSession().createSQLQuery(sql.toString()).list();
//	}

	public List listUnfinishedPartCount(Long bzId,Integer type,String jcsType,Long firstUnitId,String pjName,boolean isTs){
		String sql= "select" +
				" zx.pjname, zx.jctype, zx.firstunitname, zx.zaixiu, decode(dq.daiqian, null, 0,dq.daiqian) daiqian" +
				" from " +
				" (select t.pjname," +
				" t2.jctype," +
				"  t4.firstunitname," +
				" sum(case when (t.type = 0 and t.recstas != 7 )then 1 else 0 end) zaixiu" +
				" from pj_fixrecord t, pj_dynamicinfo t1, pj_staticinfo t2, dict_firstunit t4 " +
				" where t2.firstunitid=t4.firstunitid and t.pjdid=t1.pjdid and t1.pjsid=t2.pjsid ";
		if (type <=2 ) {
			sql += "  and t.teams like '%"+ bzId +"%' ";
		}
		if(jcsType!=null && !"".equals(jcsType)){
			sql += " and t2.jctype like '%"+jcsType+"%'";
		}
		if(firstUnitId!=null){
			sql += " and t2.firstunitid="+firstUnitId;
		}
		if(pjName!=null && !"".equals(pjName)){
			sql += " and t.pjname like '%"+pjName+"%'";
		}		
		sql +=  " group by t.pjname,t2.jctype,t4.firstunitname) zx " +
				" left join" +
				" (select als.pjname," +
				" als.jctype," +
				" als.firstunitname," +
				" sum(case when als.daiqian > 0 then 1 else 0 end) daiqian" +
				" from" +
				" (select t.parentid," +
				" t.pjname," +
				" t2.jctype," +
				" t4.firstunitname," +
				" count(*) daiqian" +
				" from pj_fixrecord t, pj_dynamicinfo t1, pj_staticinfo t2, dict_firstunit t4 " +
				" where t2.firstunitid=t4.firstunitid and t.pjdid=t1.pjdid and t1.pjsid=t2.pjsid ";
		switch(type){
			case 1:
				if(isTs){
					sql +=	" and t.teams like '%"+ bzId +"%' and t.type = 1 and t.recstas !=7 and (t.empaffirmtime is null or (t.rept is null and t.itemctrlrept=1))";
				}else{
					sql +=	" and t.teams like '%"+ bzId +"%' and t.type = 1 and t.recstas !=7 and t.empaffirmtime is null ";
				}
				break;
			case 2:
				sql +=	" and t.teams like '%"+ bzId +"%' and t.type = 1 and t.recstas !=7 and t.ldaffirmtime is null and t.itemctrllead=1 ";
				break;
			case 3:
				sql +=	" and t.type = 1 and t.recstas !=7 and t.techtime is null and t.itemctrltech=1 ";
				break;
			case 4:
				sql +=	" and t.type = 1 and t.recstas !=7 and t.qiaffitime is null and t.itemctrlqi=1";
				break;
			case 5:
				sql +=	" and t.type = 1 and t.recstas !=7 and t.comldaffitime is null and t.itemctrlcomld=1";
				break;
			case 6:
				sql +=	" and t.type = 1 and t.recstas !=7 and t.acceaffitime is null and t.itemctrlacce=1";
				break;
		}
		if(jcsType!=null && !"".equals(jcsType)){
			sql += " and t2.jctype like '%"+jcsType+"%'";
		}
		if(firstUnitId!=null){
			sql += " and t2.firstunitid="+firstUnitId;
		}
		if(pjName!=null && !"".equals(pjName)){
			sql += " and t.pjname like '%"+pjName+"%'";
		}
		sql +=	" group by t.pjname, t.parentid, t2.jctype,t4.firstunitname) als" +
				" group by als.pjname, als.jctype, als.firstunitname) dq" +
				" on zx.pjname = dq.pjname and zx.jctype = dq.jctype and zx.firstunitname = dq.firstunitname" +
				" order by zx.jctype";
		return getSession().createSQLQuery(sql.toString()).list();
	}

	@Override
	public PageModel findPageModelPJPartFixRecordByBZUser(UsersPrivs user, String jcsType, Long firstUnitId,
			String pjName, String pjNum, Integer type) {
		String roles = user.getRoles();
		StringBuilder builder = new StringBuilder();
		builder.append("1=1");
		if (jcsType != null && !"".equals(jcsType)) {
			builder.append(" and pjDynamicInfo.pjStaticInfo.jcType like '%," + jcsType + ",%'");
		}
		if (firstUnitId != null && !"".equals(firstUnitId)) {
			builder.append(" and pjDynamicInfo.pjStaticInfo.firstUnit.firstunitid=" + firstUnitId);
		}
		if (pjNum != null && !"".equals(pjNum)) {
			builder.append(" and pjDynamicInfo.pjNum like '%" + pjNum + "%'");
		}
		if (pjName != null && !"".equals(pjName)) {
			builder.append(" and pjDynamicInfo.pjName like '%" + pjName + "%'");
		}
		if (roles.contains(",GR,")) { // 工人
			builder.append(" and type=0 and recstas<7 and teams like '%," + user.getBzid() + ",%'");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and (t.fixemp is null or (t.itemctrlrept=1 and t.rept is null)))");
			}
		} else if (roles.contains(",GZ,")) {// 工长
			builder.append(" and type=0 and recstas<7 and teams like '%," + user.getBzid() + ",%'");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and t.lead is null and t.itemctrllead=1)");
			}
		} else if (roles.contains(",JSY,")) {// 技术
			builder.append(" and type=0 and recstas<7");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and t.techName is null and t.itemctrltech=1)");
			}
		} else if (roles.contains(",ZJY,")) {// 质检
			builder.append(" and type=0 and recstas<7");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and t.qi is null and t.itemctrlqi=1)");
			}
		} else if (roles.contains(",JCGZ,")) {// 交车工长
			builder.append(" and type=0 and recstas<7");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and t.commitlead is null and t.itemctrlcomld=1)");
			}
		} else if (roles.contains(",YSY,")) {// 验收
			builder.append(" and type=0 and recstas<7");
			if (type == 1) {
				builder.append(" and pjRecId in (select t.parentId from PJFixRecord t where t.type=1 and t.accepter is null and t.itemctrlacce=1)");
			}
		} else {
			builder.append(" and type=0 and recstas<7");
		}
		return getScrollData(PJFixRecord.class, builder.toString(), null);
	}

	@Override
	public PageModel findPageModelPJFixRecordByPJDidAndBZId(Long pjdid, Long proteamid) {
		String wherehql = "pjDynamicInfo.pjdid=? and pjFixItem.team.proteamid=? and type=1";
		return getScrollData(PJFixRecord.class, wherehql, new Object[] { pjdid, proteamid });
	}

	@Override
	public PageModel findPageModelFixingPJDynamic(long pjdid, UsersPrivs user, Long pjRecId) {
		String roles = user.getRoles();
		String wherehql = null;
		if (roles.contains(",JSY,") || roles.contains(",DSJS,")) {// 技术员
			wherehql = "pjDynamicInfo.pjdid=? and recstas<7 and type=1 and parentId=? and techId is null and pjFixItem.itemctrltech=1";
		} else if (roles.contains(",ZJY,") || roles.contains(",DSZJ,")) {// 质检员
			wherehql = "pjDynamicInfo.pjdid=? and recstas<7 and type=1 and parentId=? and qiid is null and pjFixItem.itemctrlqi=1";
		} else if (roles.contains(",JCGZ,")) {// 交车工长
			wherehql = "pjDynamicInfo.pjdid=? and recstas<7 and type=1 and parentId=? and commitleadid is null and pjFixItem.itemctrlcomld=1";
		} else {// 验收员
			wherehql = "pjDynamicInfo.pjdid=? and recstas<7 and type=1 and parentId=? and accepterid is null and pjFixItem.itemctrlacce=1";
		}
		return getScrollData(PJFixRecord.class, wherehql, new Object[] { pjdid, pjRecId });
	}

	@Override
	public int findPJFixItemCount(long pjsid) {
		String hql = "select count(*) from PJFixItem pfi where pfi.pjStaticInfo.pjsid=?";
		Long count = (Long) getHibernateTemplate().find(hql, pjsid).listIterator().next();
		count = count == null ? 0 : count;
		return count.intValue();
	}

	@Override
	public int findPJFixRecordCount(long pjRecId) {
		String hql = "select count(*) from PJFixRecord pfr where type=1 and recstas=7 and pfr.pjFixRecSid=?";
		Long count = (Long) getHibernateTemplate().find(hql, pjRecId).listIterator().next();
		count = count == null ? 0 : count;
		return count.intValue();
	}

	@SuppressWarnings("unchecked")
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long bzid, String flag) {
		String hql = null;
		if ("1".equals(flag)) {
			hql = "from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and pjFixItem.itemFillDefault is not null and t.lead is null order by recstas";
		} else {
			hql = "from PJFixRecord t where t.pjDynamicInfo.pjdid=? and t.pjFixItem.team.proteamid=? and pjFixItem.itemFillDefault is null and t.lead is null order by recstas";
		}
		return this.getHibernateTemplate().find(hql, new Object[] { pjdid, bzid });
	}

	@Override
	public PJFixRecord findPJFixRecordById(Long recId) {
		return super.find(PJFixRecord.class, recId);
	}

	@SuppressWarnings("unchecked")
	public List<PJFixRecord> findPJFixRecordByPresetRelateID(Long presetId, Long pjRecId, int type) {
		String sql = null;
		if (type == 0) {// 检查项目
			sql = "select t1.* from pj_fixrecord t1,pj_preset_relateid t2,pj_fixitem t3 where t1.pjitemid=t2.pjfixitemid and t1.pjitemid=t3.pjitemid and t2.pjpresetid=? and t1.parentid=? and t3.itemfilldefa is not null order by t1.recstas";
		} else {// 检测项目
			sql = "select t1.* from pj_fixrecord t1,pj_preset_relateid t2,pj_fixitem t3 where t1.pjitemid=t2.pjfixitemid and t1.pjitemid=t3.pjitemid and t2.pjpresetid=? and t1.parentid=? and t3.itemfilldefa is null order by t1.recstas";
		}
		return getSession().createSQLQuery(sql).addEntity(PJFixRecord.class).setLong(0, presetId).setLong(1, pjRecId)
				.list();
	}

	public int countSignedPreset(Long presetId, Long pjRecId, int type) {
		String sql = null;
		if (type == 0) {// 检查项目
			sql = "select count(t1.pjrecid) from pj_fixrecord t1,pj_preset_relateid t2,pj_fixitem t3 where t1.pjitemid=t2.pjfixitemid and t1.pjitemid=t3.pjitemid and t2.pjpresetid=? and t1.parentid=? and t3.itemfilldefa is not null and t1.empaffirmtime is null";
		} else {// 检测项目
			sql = "select count(t1.pjrecid) from pj_fixrecord t1,pj_preset_relateid t2,pj_fixitem t3 where t1.pjitemid=t2.pjfixitemid and t1.pjitemid=t3.pjitemid and t2.pjpresetid=? and t1.parentid=? and t3.itemfilldefa is null and t1.empaffirmtime is null";
		}
		Object obj = getSession().createSQLQuery(sql).setLong(0, presetId).setLong(1, pjRecId).uniqueResult();
		if (obj != null && obj.toString().equals("0")) {
			return 0;
		}
		return Integer.parseInt(obj.toString());
	}

	public int countPJPresetItem(Long presetId, int type) {
		String sql = null;
		if (type == 0) {// 检查项目
			sql = "select count(t1.pjpresetid) from pj_preset_relateid t1,pj_fixitem t2 where t1.pjfixitemid=t2.pjitemid and t1.pjpresetid=? and t2.itemfilldefa is not null";
		} else {// 检测项目
			sql = "select count(t1.pjpresetid) from pj_preset_relateid t1,pj_fixitem t2 where t1.pjfixitemid=t2.pjitemid and t1.pjpresetid=? and t2.itemfilldefa is null";
		}
		Object obj = getSession().createSQLQuery(sql).setLong(0, presetId).uniqueResult();
		if (obj != null && obj.toString().equals("0")) {
			return 0;
		}
		return Integer.parseInt(obj.toString());
	}
}
