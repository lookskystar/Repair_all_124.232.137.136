package com.repair.query.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictGuDao;
import com.repair.common.pojo.DictJcFixSeq;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJcType;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCSignature;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.query.dao.DictQueryDao;

public class DictQueryDaoImpl extends AbstractDao implements DictQueryDao{
	

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcType> findAllDictJcType(){
		return getHibernateTemplate().find("from DictJcType as jcType");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcFixSeq> findAllDictJcFixSeqs() {
		return getHibernateTemplate().find("from DictJcFixSeq as djfs");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictGuDao> findAllGuDao() {
		return getHibernateTemplate().find("from DictGuDao as gudao");
	}
	
	@SuppressWarnings("unchecked")
	public List<DictProTeam> findAllProTeam() {
		return getHibernateTemplate().find("from DictProTeam as proTeam ");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findAllProTeam(String jctype, Integer workflag) {
		String jctypes = jctype.substring(0,2);
		String hql = "from DictProTeam as proTeam where proTeam.jctype like '%"+ jctypes +"%' and proTeam.workflag="+ workflag +"";
		return getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findAllZxProTeam(String jctype, Integer workflag) {
		String jctypes = jctype.substring(0,2);
		String hql = "from DictProTeam as proTeam where proTeam.jctype like '%"+ jctypes +"%' and proTeam.zxFlag="+ workflag +"";
		return getHibernateTemplate().find(hql);
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> findAllFirstUnit() {
		return getHibernateTemplate().find("from DictFirstUnit as unit");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findGDJCInDailyPlan(String time){
		if(time!=null&&!time.equals("")){
			String hql="from DatePlanPri as dpp where dpp.planStatue!=3 and dpp.kcsj>=? and dpp.kcsj<=? order by dpp.projectType,dpp.nodeid.jcFlowId,dpp.planStatue asc,dpp.kcsj desc";
			return getHibernateTemplate().find(hql,new Object[]{time,getSpecifiedDayAfter(time)});
		}else{
			return getHibernateTemplate().find("from DatePlanPri as dpp where dpp.planStatue!=3 order by dpp.projectType,dpp.nodeid.jcFlowId,dpp.planStatue asc,dpp.kcsj desc");
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCFlowRec> findJCFlowRecByDatePlan(Integer rjhmId){
		return getHibernateTemplate().find("from JCFlowRec as rec where rec.datePlanPri.rjhmId=? order by rec.fixflow.jcFlowId",rjhmId);
	}
	
	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return getHibernateTemplate().get(DatePlanPri.class, rjhmId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcStype> findStypeByTypeId(Integer typeId) {
		return getHibernateTemplate().find("from DictJcStype as dt where dt.jcTypeId.jcTypeId=?",typeId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JtRunKiloRec> findJtRunKiloRec(String stypeId) {
		return getHibernateTemplate().find("from JtRunKiloRec as rc where rc.jcType=?",stypeId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findDatePlanPri(Map<String, String> map) {
		String hql="from DatePlanPri as dp where dp.planStatue>1";
		Set<String> set=map.keySet();
		Iterator<String> ite=set.iterator();
		String key,value;
		while(ite.hasNext()){
			key=ite.next();
			value=map.get(key);
			if(key.equals("startTime")){
				hql+=" and dp.jhjcsj>='"+value+"'";
			}else if(key.endsWith("endTime")){
				hql+=" and dp.jhjcsj<='"+value+"'";
			}else if(key.equals("fixFreque")){
				if("X".equals(value)||"F".equals(value)){
					hql+=" and dp.fixFreque like '"+value+"%'";
				}else if("Z".equals(value)){
					hql+=" and dp.fixFreque like '"+value+"%' and dp.fixFreque!='ZQZZ' and dp.fixFreque!='ZZ' and dp.fixFreque!='ZDZZ'";
				}else{
					hql+=" and dp.fixFreque like '%"+value+"%'";
				}
			}else if(key.equals("jcnum")){
				hql+=" and dp.jcnum like '%"+value+"%'";
			}else{
				hql+=" and dp."+key+"='"+value+"'";
			}
		}
		hql+= " order by dp.jhjcsj desc, dp.jcnum asc";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixrec> findJCFixrec(Integer datePlanPri,String unit) {
		return this.getHibernateTemplate().find("from JCFixrec jf where  jf.datePlanPri.rjhmId=? and jf.unitName=? order by jf.secUnitName,jf.jcRecId",new Object[]{datePlanPri,unit});
	}
	
	public PageModel<JCFixrec> findJCFixrecLimited(Integer datePlanPri,String unit) {
		return findPageModel("from JCFixrec jf where jf.datePlanPri.rjhmId=? order by jf.secUnitName,jf.jcRecId",new Object[]{datePlanPri});
	}
	
	public Long countJCZXFixRec(Integer datePlanPri,Integer fristUnit){
		try{
			return (Long) this.getHibernateTemplate().find("select count(*) from JCZXFixRec jfr where jfr.dyPrecId.rjhmId=? and jfr.firstUnitId=?",new Object[]{datePlanPri,fristUnit}).get(0);
		}catch (Exception e) {
			return new Long(0);
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCZXFixRec> findJCZXFixRec(Integer datePlanPri,Integer fristUnit) {
		return getHibernateTemplate().find("from JCZXFixRec jfr where jfr.dyPrecId.rjhmId=? and jfr.firstUnitId=? order by jfr.nodeId,jfr.bzId,jfr.unitName", new Object[]{datePlanPri,fristUnit});
	}

	@SuppressWarnings("unchecked")
	@Override
	public DatePlanPri findDatePlanPriByJC(String xcxc, String jcStype,
			String jcNum) {
		String hql = "from DatePlanPri dp where dp.fixFreque=? and dp.jcType=? and dp.jcnum=?";
		List<DatePlanPri> list= getHibernateTemplate().find(hql,new Object[]{xcxc,jcStype,jcNum});
		if(list!=null&&list.size()>0) return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCQZFixRec> findJCQZFixRec(Integer datePlanPri) {
		return this.getHibernateTemplate().find("from JCQZFixRec jf where jf.jcRecmId.rjhmId=?",datePlanPri);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDict(Integer datePlanPri) {
		String hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type=3";
		return this.getHibernateTemplate().find(hql,datePlanPri);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictPre(Integer datePlanPri) {
		String hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.recStas>=2 order by jf.type,jf.proTeamId.proteamid";
		return this.getHibernateTemplate().find(hql,datePlanPri);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictByFlag(Integer datePlanPri, Object flag){
		String hql = "";
		List<JtPreDict> JtPreDictList = null;
		//String 类型为专业
		if(flag instanceof String){
			hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.recStas>=2 order by jf.type,jf.proTeamId.proteamid";
			JtPreDictList = this.getHibernateTemplate().find(hql, datePlanPri);
		}else if(flag instanceof Long){
			hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.recStas>=2 and jf.proTeamId.proteamid=? order by jf.type,jf.proTeamId.proteamid";
			JtPreDictList = this.getHibernateTemplate().find(hql, datePlanPri, flag);
		}
		return JtPreDictList;
	}
	
	/**
	 * 根据班组、专业查询报活记录
	 * @param datePlanPri
	 * @param type
	 * @return
	 */
	public List<JtPreDict> findJtPreDictByFlag(Integer datePlanPri, Object flag, int type){
		String hql = "";
		List<JtPreDict> JtPreDictList = null;
		//String 类型为专业
		if(flag instanceof String){
			if(type==3){
				hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type=3 and jf.recStas>=2";
			}else{
				hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.recStas>=2";
			}
			JtPreDictList = this.getHibernateTemplate().find(hql, datePlanPri);
		}else if(flag instanceof Long){
			if(type==3){
				hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type=3 and jf.proTeamId.proteamid=? and jf.recStas>=2";
			}else{
				hql = "from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.proTeamId.proteamid=? and jf.recStas>=2";
			}
			JtPreDictList = this.getHibernateTemplate().find(hql, datePlanPri, flag);
		}
		return JtPreDictList; 
	}

	@SuppressWarnings("unchecked")
	@Override
	public SignedForFinish findSignedForFinishByPlan(Integer datePlanPri) {
		String hql="from SignedForFinish jf where jf.dpId=?";
		List<SignedForFinish> list= getHibernateTemplate().find(hql,new Object[]{datePlanPri});
		if(list!=null&&list.size()>0) return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> findDictFirstUnitByType(String jcStype) {
		//String jcStypes = jcStype.substring(0,2);
		String hql="from DictFirstUnit jf where jf.jcstypevalue like '%"+ jcStype +"%'";
		return this.getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findAllJtPreDict(Integer datePlanPri) {
		return this.getHibernateTemplate().find("from JtPreDict jf where jf.datePlanPri.rjhmId=? and jf.type!=3 and jf.recStas>=2 order by jf.type",datePlanPri);
	}
	
	public SignedForFinish getJCjungong(int rjhmId){
		try{
			String hql = "from SignedForFinish t where t.dpId=?";
			return (SignedForFinish) getHibernateTemplate().find(hql,rjhmId).get(0);
		}catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 获取交车项目记录
	 */
	@SuppressWarnings("unchecked")
	public List<DlJcJyMxb> getDlJcJyMxb(int rjhmId){
		return getHibernateTemplate().find("from DlJcJyMxb t where t.jyzId.dpId=?",rjhmId);
	}
	
	/**
	 * 交车签到记录
	 */
	@SuppressWarnings("unchecked")
	public List<NrJcJyzb> getNrJcJyzb(int rjhmId){
		return getHibernateTemplate().find("from NrJcJyzb t where t.dpId=?",rjhmId);
	}
	
	/**
	 * 获得签名记录
	 */
	@SuppressWarnings("unchecked")
	public List<JCSignature> getJCSignature(int rjhmId){
		return getHibernateTemplate().find("from JCSignature t where t.datePlanId.rjhmId=?",rjhmId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixrec> findJCFixrec(Integer datePlanPri) {
		return this.getHibernateTemplate().find("from JCFixrec jf where jf.datePlanPri.rjhmId=? order by jf.unitName, jf.secUnitName,jf.jcRecId",datePlanPri);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCZXFixRec> findJCZXFixRec(Integer datePlanPri) {
		return getHibernateTemplate().find("from JCZXFixRec jfr where jfr.dyPrecId.rjhmId=? order by jfr.nodeId,jfr.unitName,jfr.id", datePlanPri);
	}

	public PageModel<JCZXFixRec> findJCZXFixRecLimited(Integer datePlanPri) {
		return findPageModel("from JCZXFixRec jfr where jfr.dyPrecId.rjhmId=? order by jfr.nodeId,jfr.unitName,jfr.id", datePlanPri);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixrec> findRecByProTeam(Integer rjhmId, Long teamId) {
		return this.getHibernateTemplate().find("from JCFixrec jf where jf.datePlanPri.rjhmId=? and jf.banzuId=? order by jf.unitName, jf.secUnitName,jf.jcRecId",new Object[]{rjhmId,teamId});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCZXFixRec> findZxRecByProTeam(Integer rjhmId, Long teamId,Integer nodeId) {
		if(nodeId==null){
			return this.getHibernateTemplate().find("from JCZXFixRec jf where jf.dyPrecId.rjhmId=? and jf.bzId=? order by jf.nodeId,jf.unitName",new Object[]{rjhmId,teamId});
		}else{
			return this.getHibernateTemplate().find("from JCZXFixRec jf where jf.dyPrecId.rjhmId=? and jf.bzId=? and jf.nodeId=? order by jf.unitName",new Object[]{rjhmId,teamId,nodeId});
		}
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCQZFixRec> findJCQZFixrecByUnit(Integer rjhmId, String unit) {
		return this.getHibernateTemplate().find("from JCQZFixRec jf where jf.jcRecmId.rjhmId=? and jf.items.unitName=? order by jf.items.unitName,jf.items.xh",new Object[]{rjhmId,unit});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JCQZFixRec> findJCQZFixrecByTeam(Integer rjhmId, Long teamId) {
		return this.getHibernateTemplate().find("from JCQZFixRec jf where jf.jcRecmId.rjhmId=? and jf.bzId=? order by jf.items.unitName, jf.items.xh",new Object[]{rjhmId,teamId});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DatePlanPri> findJCHistory(String jcNum) {
		return getHibernateTemplate().find("from DatePlanPri as dpp where dpp.jcnum=? and dpp.projectType=? order by dpp.kcsj desc",new Object[]{jcNum,Contains.XX_PROJECT_TYPE});
	}
	
	public void updateJCGDAndTW(int rjhmId,String gdh,String twh){
		String hql = "update DatePlanPri dp set dp.gdh=?,dp.twh=? where dp.rjhmId=?";
		getSession().createQuery(hql).setString(0, gdh).setString(1, twh).setInteger(2, rjhmId).executeUpdate();
	}

	@Override
	public String findXcxc(String xcxc) {
		String sql = "select  dj.flowval from dict_jcfixseq dj where dj.fixvalue=?";
		return (String) this.getSession().createSQLQuery(sql).setString(0, xcxc).uniqueResult();
	}
	
	//获取后一天的日期
	private String getSpecifiedDayAfter(String specifiedDay) {
	        Calendar c = Calendar.getInstance();
	        Date date = null;
	        try {
	            date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	        c.setTime(date);
	        int day = c.get(Calendar.DATE);
	        c.set(Calendar.DATE, day + 1);

	        String dayAfter = new SimpleDateFormat("yyyy-MM-dd")
	                .format(c.getTime());
	        return dayAfter;
	 }

	@SuppressWarnings("unchecked")
	@Override
	public List<JCZXFixItem> findZXItem(Integer nodeid, String xcxc, String jcsType, Long bzid, Integer firstUnitId) {
		StringBuilder buffer = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		buffer.append("from JCZXFixItem t where 1=1");
		if(nodeid != null){
			buffer.append(" and t.nodeId.jcFlowId=?");
			params.add(nodeid);
		}
		if(!"".equals(xcxc) && null != xcxc){
			buffer.append(" and t.xcxc like '%"+ xcxc +"%'");
		}
		if(!"".equals(jcsType) && null != jcsType){
			buffer.append(" and t.jcsType like '%"+ jcsType +"%'");
		}
		if(bzid != null){
			buffer.append(" and t.bzId.proteamid = ?");
			params.add(bzid);
		}
		if(firstUnitId != null){
			buffer.append(" and t.firstUnitId = ?");
			params.add(firstUnitId);
		}
		buffer.append(" order by t.firstUnitId");
		return this.getHibernateTemplate().find(buffer.toString(), params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override//查找组装到车上的配件
	public List<PJStaticInfo> findPJStaticInfo(String jcType,Long bzId) {
		String hql="from PJStaticInfo t where t.jcType like ? and t.type=0";
		List<Object> params = new ArrayList<Object>();
		params.add("%,"+jcType+",%");
		if(bzId!=null){
			hql += " and t.bzIds like ?";
			params.add("%,"+bzId+",%");
		}
		return getHibernateTemplate().find(hql,params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PJDynamicInfo> findPJDynamicInfoBySID(Long pjsid) {
		String hql="from PJDynamicInfo t where t.pjStaticInfo.pjsid=?";
		return getHibernateTemplate().find(hql,pjsid);
	}

	@Override
	public Long findExpSituation(Integer rjhmId,int type) {
		String hql="select count(t.recId) from YSJCRec t where t.datePlanPri.rjhmId=?";
		if(type==0){
			hql+=" and t.fixemp is null";
		}else if(type==1){
			hql+=" and t.fixemp is null";
		}else if(type==2){
			hql+=" and t.tech is null";
		}else if(type==3){
			hql+=" and t.tech is null";
		}else if(type==4){
			hql+=" and t.commitLead is null";
		}else{
			hql+=" and t.accept is null";
		}
		try{
			return (Long)getHibernateTemplate().find(hql,rjhmId).get(0);
		}catch(Exception e){
			return (long)1;
		}
	}
}
