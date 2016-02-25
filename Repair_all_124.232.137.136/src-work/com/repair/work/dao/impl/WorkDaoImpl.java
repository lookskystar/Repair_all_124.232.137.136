package com.repair.work.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.work.dao.WorkDao;

public class WorkDaoImpl extends AbstractDao implements WorkDao{
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 根据pjdid得到PJDynamicInfo对象
	 * @param pjdid
	 * @return pJDynamicInfo
	 */
	public PJDynamicInfo getPJDynamicInfoByPjdid(Long pjdid){
		String hql ="from PJDynamicInfo p where p.pjdid=?";
		return (PJDynamicInfo) this.getSession().createQuery(hql).setLong(0, pjdid).uniqueResult();
	}
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 修改PJDynamicInfo对象的storePosition属性为2，把上车编码更新到getOnNum属性中（上车编号在action中通过日计划id获得）
	 * @param pJDynamicInfo
	 */
	public void updateStorePositionAndGetOnNumForPJDynamicInfoByPjdid(PJDynamicInfo pJDynamicInfo){
		try {
			this.getHibernateTemplate().saveOrUpdate(pJDynamicInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 修改JtPreDict对象的UpPjNum，通过PreDictId
	 * @param preDictId
	 * @return
	 */
	public void updateUpPjNumForJtPreDictByPreDictId(JtPreDict jtPreDict){
		this.getHibernateTemplate().saveOrUpdate(jtPreDict);
	}
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 通过preDictId得到JtPreDict对象
	 * @param preDictId
	 * @return
	 */
	public JtPreDict getJtPreDictBypreDictId(Integer preDictId){
		String hql ="from JtPreDict j where j.preDictId=?";
		return (JtPreDict) this.getSession().createQuery(hql).setInteger(0, preDictId).uniqueResult();
	}
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-25
	 * 通过pjdid（配件动态id）修改PJDynamicInfo表的storePosition字段值为2，把getOnNum更新为jcnum。
	 */
	public void updateStorePositionByPjdid(String pjdid,Integer storePosition,String jcnum){
		//1、根据preDictId查询出这个条数据
		PJDynamicInfo pJDynamicInfo=getHibernateTemplate().get(PJDynamicInfo.class, pjdid);
		pJDynamicInfo.setStorePosition(storePosition);
		pJDynamicInfo.setGetOnNum(jcnum);
		getHibernateTemplate().saveOrUpdate(pJDynamicInfo);
		
		System.out.println("updateStorePositionByPjdid-->"+"pjdid:"+pjdid+",storePosition:"+storePosition+",jcnum:"+jcnum);
	}
	
	@SuppressWarnings("unchecked")
	public List<DatePlanPri> findDyPlanJC(long bzId,int statue,Integer nodeId) {
		String hql = "select distinct r.datePlanPri from JCFlowRec r where r.proTeam.proteamid=? and r.finishStatus=? and r.datePlanPri.planStatue in(0,1) and r.fixflow.jcFlowId=? and r.datePlanPri.projectType=?";
		return getHibernateTemplate().find(hql,new Object[]{bzId,statue,nodeId,Contains.XX_PROJECT_TYPE});
	}
	
	@SuppressWarnings("unchecked")
	public List<JCDivision> listJCDivision(int rjhmId, int proSetId) {
		String hql = "from JCDivision jd where jd.dayPlan.rjhmId=? and jd.presetDivision.proSetId=?";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,proSetId});
	}
	
	@SuppressWarnings("unchecked")
	public List<JCDivision> listJCDivision(int rjhmId, Long bzId) {
		String hql = "from JCDivision jd where jd.dayPlan.rjhmId=? and jd.presetDivision.proTeam.proteamid=? order by jd.presetDivision";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,bzId});
	}
	
	public void addJCDivision(JCDivision division){
		getHibernateTemplate().save(division);
	}
	
	@SuppressWarnings("unchecked")
	public JCDivision getJCDivision(long userId, int presetId, int rjhmId) {
		String hql = "from JCDivision jd where jd.user.userid=? and jd.presetDivision.proSetId=? and jd.dayPlan.rjhmId=?";
		List list = getHibernateTemplate().find(hql, new Object[]{userId,presetId,rjhmId});
		if(list==null || list.size()==0){
			return null;
		}else{
			return (JCDivision) list.get(0);
		}
	}
	
	public JCDivision getJCDivisionById(int divisionId){
		return getHibernateTemplate().get(JCDivision.class, divisionId);
	}
	
	@Override
	public long countWorkedItems(int presetId,String userXM, int rjhmId) {
		String hql = "select count(jfr.jcRecId) from JCFixrec jfr where " +
			"jfr.fixitem.thirdUnitId in (select pr.fixitem.thirdUnitId from PresetRelateID pr where pr.presetId.proSetId=:presetId) " +
			"and jfr.fixEmp like '%'||:name||'%' and jfr.datePlanPri.rjhmId=:rjhmId";
		return (Long)getSession().createQuery(hql).setParameter("presetId", presetId)
											.setParameter("name", ","+userXM+",")
											.setParameter("rjhmId", rjhmId).uniqueResult();
	}
	
	public void deleteDivison(JCDivision division){
		getHibernateTemplate().delete(division);
	}
	
	@Override
	public void updateJcFixrecWorkersId(String workersId, int rjhmId,
			int presetId) {
		
		String hql = "update JCFixrec jfr set jfr.fixEmpId=:worksId where " +
			"jfr.fixitem.thirdUnitId in (select pr.fixitem.thirdUnitId from PresetRelateID pr where pr.presetId.proSetId=:presetId) " +
			"and jfr.datePlanPri.rjhmId=:rjhmId";
		getSession().createQuery(hql).setParameter("worksId", workersId).setParameter("rjhmId", rjhmId).setParameter("presetId", presetId).executeUpdate();
		
	}
	
	public void deleteJcFixRec(int rjhmId,int presetId){
		String hql = "delete from JCFixrec jfr where " +
			"jfr.fixitem.thirdUnitId in (select pr.fixitem.thirdUnitId from PresetRelateID pr where pr.presetId.proSetId=:presetId) " +
			"and jfr.datePlanPri.rjhmId=:rjhmId";
		getSession().createQuery(hql).setParameter("rjhmId", rjhmId).setParameter("presetId", presetId).executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public void saveOrUpdateJCFixrec(int rjhmId,int presetId, String workersId, long bzId,String jcnum, String jctype,String date) {
		//查询出所有的项目
		DatePlanPri datePlanPri = getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		String hql = "select pr.fixitem from PresetRelateID pr where pr.presetId.proSetId=? and pr.fixitem.xcxc like ',%"+datePlanPri.getFixFreque()+",%'";
		List<JCFixitem> itemIds = getHibernateTemplate().find(hql, presetId);
		//查询日计划 
		
		//插入项目记录
		JCFixrec jcFixrec = null;
		datePlanPri.setRjhmId(rjhmId);
		String temp = null;
		for (JCFixitem item : itemIds) {
			//通过日计划ID跟项目ID
			jcFixrec = getFixRec(rjhmId, item.getThirdUnitId());
			if(null == jcFixrec){
				jcFixrec = new JCFixrec();
			}
			jcFixrec.setJwdCode(item.getJwdCode());
			jcFixrec.setJcType(jctype);
			jcFixrec.setDatePlanPri(datePlanPri);
			jcFixrec.setJcNum(jcnum);
			jcFixrec.setFixitem(item);
			jcFixrec.setItemName(item.getItemName());
			jcFixrec.setFixEmpId(","+workersId);//变成“,7,107,8,” 用于查询时区分“%,7,%”
			jcFixrec.setBanzuId(bzId);
			jcFixrec.setUnit(item.getUnit());
			jcFixrec.setJhTime(date);
			temp = item.getFillDefaVal();
			if(temp == null || "".equals(temp)){
				jcFixrec.setItemType((short)1);
			}else{
				jcFixrec.setItemType((short)0);
			}
			jcFixrec.setRecStas((short)0);
			getHibernateTemplate().saveOrUpdate(jcFixrec);
		}
	}
	
	private JCFixrec getFixRec(Integer rjhmId, Integer thirdUnitId ){
		String hql = "from JCFixrec jc where jc.datePlanPri.rjhmId=? and jc.fixitem.thirdUnitId=?";
		try {
			JCFixrec jCFixrec = (JCFixrec) this.getSession().createQuery(hql).setInteger(0, rjhmId).setInteger(1, thirdUnitId).uniqueResult();
			return jCFixrec;
		} catch (Exception e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<JCFixrec>  listMyJCFixRec(int rjhmId,UsersPrivs user,short itemType,Integer signFlag,boolean flag){
		String hql = "from JCFixrec r where 1=1 and r.itemType=?";
		if(flag){
			hql += " and r.fixEmpId like '%,'||?||',%'";
		}else{
			//hql = "from JCFixrec r where r.fixEmpId not like '%,'||?||',%' and r.banzuId="+user.getBzid();
			hql += " and r.banzuId="+user.getBzid();
		}
		if(signFlag==0){
			hql += " and (r.fixEmp not like '%,"+user.getXm()+",%' or r.fixEmp is null)";
		}
		hql += "  and r.datePlanPri.rjhmId=? order by r.jcRecId asc";
		return getHibernateTemplate().find(hql, new Object[]{itemType,rjhmId});
	}
	
	@SuppressWarnings("unchecked")
	public List<JCZXFixRec> listMyJCZxFixRec(int rjhmId, UsersPrivs user, short itemType, Integer signFlag, boolean flag){
		DatePlanPri datePlan=getHibernateTemplate().get(DatePlanPri.class, rjhmId);
		String hql = null;
		if(flag){
			hql = "from JCZXFixRec r where r.fixEmpId like '%,'||?||',%'";
		}else{
			hql = "from JCZXFixRec r where r.fixEmpId not like '%,'||?||',%' and r.bzId="+user.getBzid();
		}
		if(signFlag==0){
			hql += " and (r.fixEmp not like '%,"+user.getXm()+",%' or r.fixEmp is null)";
		}
		hql += " and r.itemType=? and r.nodeId=? and r.dyPrecId.rjhmId=? order by r.id asc";
		return getHibernateTemplate().find(hql, new Object[]{user.getUserid(),itemType,datePlan.getNodeid().getJcFlowId(),rjhmId});
	}
	
	public List<JCZXFixRec> listJCZXFixRec(int rjhmId,Long bzId){
		String hql = "from JCZXFixRec r where r.dyPrecId.rjhmId=? and r.bzId=? order by r.unitName,r.id";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,bzId});
	}
	
	public void updateJCFixRec(String jhTime,int rjhmId,long userId){
		String hql = "update JCFixrec r set r.jhTime=? where r.fixEmpId like '%,'||?||',%' and r.jhTime is null and r.datePlanPri.rjhmId=? ";
		getSession().createQuery(hql).setString(0, jhTime).setLong(1, userId).setInteger(2, rjhmId).executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listJtPreDictByDivisionStatus(int rjhmId,Long bzId){
		String hql = "from JtPreDict jt where jt.fixEmpId is not null and jt.type=3 and jt.proTeamId.proteamid=? and jt.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql, new Object[]{bzId,rjhmId});
	}
	
	@SuppressWarnings("unchecked")
	public List<JCQZFixRec> listJCQZFixRec(int rjhmId,Long bzId){
		String hql = "from JCQZFixRec t where t.recStas=0 and t.jcRecmId.rjhmId=? and t.items.banzuId.proteamid=?";
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,bzId});
	}
	
	public void saveOrUpdateJCQZFixRec(JCQZFixRec jcqzFixRec) {
		getHibernateTemplate().saveOrUpdate(jcqzFixRec);
	}
	
	public JCQZItems getJCQZItemsById(int itemId){
		return getHibernateTemplate().get(JCQZItems.class, itemId);
	}
	
	public JCFixrec getJCFixrecById(long jcRecId){
		return getHibernateTemplate().get(JCFixrec.class,jcRecId);
	}
	
	public JCZXFixRec getJCZXFixRecById(long jcRecId){
		return getHibernateTemplate().get(JCZXFixRec.class,jcRecId);
	}
	
	public void updateJCFixRec(JCFixrec jcFixrec){
		getHibernateTemplate().saveOrUpdate(jcFixrec);
	}
	
	public void updateJCZXFixRec(JCZXFixRec jcFixrec){
		getHibernateTemplate().saveOrUpdate(jcFixrec);
	}
	/**
	 * 查询检修记录
	 * @param jcrecid
	 * @return
	 */
	public JCFixrec queryJCFixrecByID(long jcrecid){
		String hql = "from JCFixrec jf where jf.jcRecId=:jcRecId";
		return (JCFixrec) getSession().createQuery(hql).setParameter("jcRecId", jcrecid).uniqueResult();
		
	}
	
	/**
	 * 查询检修记录
	 * @param jcrecid
	 * @return
	 */
	public JCZXFixRec queryJCZxFixrecByID(long jcrecid){
		String hql = "from JCZXFixRec jf where jf.id=:id";
		return (JCZXFixRec) getSession().createQuery(hql).setParameter("id", jcrecid).uniqueResult();
		
	}
	
	/**
	 * 查询检修项目
	 * @param thirdunitid
	 * @return
	 */
	public JCFixitem queryJCFixitemByID(int thirdunitid){
		String hql = "from JCFixitem jfi where jfi.thirdUnitId=:thirdUnitId";
		return (JCFixitem) getSession().createQuery(hql).setParameter("thirdUnitId", thirdunitid).uniqueResult();
		
	}
	/**
	 * 查询检修项目
	 * @param thirdunitid
	 * @return
	 */
	public JCZXFixItem queryJCZxFixitemByID(int thirdunitid){
		String hql = "from JCZXFixItem jfi where jfi.id=:id";
		return (JCZXFixItem) getSession().createQuery(hql).setParameter("id", thirdunitid).uniqueResult();
		
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> queryJtPreDictByDivisionId(Integer divisionId){
		String hql="from JtPreDict jpd where jpd.divisionId=?";
		return getHibernateTemplate().find(hql,divisionId);
	}

	@Override
	public NrJcJyzb queryNrJcJyzb(Integer rjhmId) {
		String hql = "from NrJcJyzb t where t.dpId=?";
		NrJcJyzb nrJcJyzb = null;
		try {
			nrJcJyzb = (NrJcJyzb) this.getSession().createQuery(hql).setInteger(0, rjhmId).uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nrJcJyzb ;
	}

	@Override
	public DlJcJyZb queryDlJcJyZb(Integer rjhmId) {
		String hql = "from DlJcJyZb t where t.dpId=?";
		DlJcJyZb dlJcJyZb = null;
		try {
			dlJcJyZb = (DlJcJyZb) this.getSession().createQuery(hql).setInteger(0, rjhmId).uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dlJcJyZb ;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DlJcJyMxb> queryDlJcJyMxb(Integer jyzId) {
		String hql = "from DlJcJyMxb t where t.jyzId.jyzId=?";
		List<DlJcJyMxb> dlJcJyMxbList = null;
		try {
			dlJcJyMxbList = this.getHibernateTemplate().find(hql, jyzId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dlJcJyMxbList;
	}

	@Override
	public void saveOrUpdateNrJcJyzb(NrJcJyzb nrJcJyzb) {
		try {
			this.getHibernateTemplate().saveOrUpdate(nrJcJyzb);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String saveOrUpdateDlJcJyMxb(DlJcJyMxb dlJcJyMxb) {
		String result = "failure";
		try {
			this.getHibernateTemplate().saveOrUpdate(dlJcJyMxb);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String saveOrUpdateDlJcJyzb(DlJcJyZb dlJcJyZb) {
		String result = "failure";
		try {
			this.getHibernateTemplate().saveOrUpdate(dlJcJyZb);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public DlJcJyMxb queryDlJcJyMxbById(Integer jymxId) {
		String hql = "from DlJcJyMxb t where t.jymxId=?";
		return (DlJcJyMxb) this.getSession().createQuery(hql).setInteger(0, jymxId).uniqueResult();
	}
	
	@Override
	public Long countPjInfoByPjNum(String pjNum) {
		String hql="select count(t.pjdid) from PJDynamicInfo t where t.pjNum=?";
		return (Long)getHibernateTemplate().find(hql,pjNum).get(0);
	}

	@Override
	public void saveOrUpdateJCZXFixRec(JCZXFixRec jcZxFixRec) {
		getHibernateTemplate().saveOrUpdate(jcZxFixRec);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String type, String pjName,String pjNum,String jcType) {
		StringBuilder builder=new StringBuilder();
		List<Object> params=new ArrayList<Object>();
		builder.append("from PJDynamicInfo pjd where 1=1");
		if(pjName!=null&&!pjName.equals("")){
			if(null != type && !"".equals(type)){
				builder.append(" and pjd.pjName like ?");
				params.add("%"+pjName+"%");
			}else{
				builder.append(" and pjd.pjName like ?");
				params.add("%"+pjName+"%");
			}
		}
		if(pjNum!=null&&!pjNum.equals("")){
			builder.append(" and pjd.pjNum like ?");
			params.add("%"+pjNum+"%");
		}
		if(jcType != null && !"".equals(jcType)){
			builder.append(" and pjd.pjStaticInfo.jcType like ? ");
			params.add("%"+jcType+"%");
		}
		//根据合格配件和不在车上的配件查询
		builder.append(" and pjd.pjStatus=0 and pjd.storePosition<2 order by pjd.pjdid");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId) {
		return getHibernateTemplate().get(PJDynamicInfo.class, pjdId);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid) {
		String hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and (pjfr.type=0 or pjfr.type=2) order by pjfr.pjRecId desc";
		return getHibernateTemplate().find(hql,pjdid);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long planId) {
		//String hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=? and pjfr.datePlan.planId=? and pjfr.type=1 order by pjfr.pjRecId";
		String hql="from PJFixRecord pjfr where pjfr.pjDynamicInfo.pjdid=?  and pjfr.type=1 order by pjfr.teams desc,pjfr.pjRecId";
		return getHibernateTemplate().find(hql,pjdid);
	}

	@Override
	public JCZXFixRec findJCZXFixRec(Long id) {
		String hql = "from JCZXFixRec t where t.id=?";
		return (JCZXFixRec) this.getSession().createQuery(hql).setLong(0, id).uniqueResult();
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByNum(String pjNum) {
		String hql ="from PJDynamicInfo t where t.pjNum=?";
		return (PJDynamicInfo) this.getSession().createQuery(hql).setString(0, pjNum).uniqueResult();
	}

	@Override
	public PJFixRecord findPJFixRecordByPjDid(Long pjDid) {
		String hql = "from PJFixRecord t where t.type!=1 and t.pjDynamicInfo.pjdid=? order by empaffirmtime desc";
		return (PJFixRecord) this.getHibernateTemplate().find(hql,pjDid).get(0);
	}
	
	public PJFixRecord getPJFixRecordByPjRecId(Long recId){
		return getHibernateTemplate().get(PJFixRecord.class, recId);
	}

	@Override
	public void saveOrUpdatePJFixRecord(PJFixRecord pJFixRecord) {
		this.getHibernateTemplate().saveOrUpdate(pJFixRecord);
	}

	@Override
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pJDynamicInfo) {
		this.getHibernateTemplate().saveOrUpdate(pJDynamicInfo);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJFixItem> findPJFixItemByPjSid(Long pjSid) {
		String hql = "from PJFixItem t where t.pjSid=?";
		return this.getHibernateTemplate().find(hql, pjSid);
	}
	
	public void updateReptSign(List<Long> ids,UsersPrivs user,String time,int type){
		String hql = "update JCZXFixRec t set t.reptId=?,t.rept=?,t.reptAffirmTime=? where t.id in(:ids)";
		if(type==2){
			hql = "update PJFixRecord t set t.reptId=?,t.rept=?,t.reptAffirmTime=? where t.pjRecId in(:ids)";
		}
		getSession().createQuery(hql).setLong(0, user.getUserid()).setString(1, user.getXm()).setString(2, time).setParameterList("ids", ids).executeUpdate();
	}
}
