package com.repair.query.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import com.repair.common.util.PageModel;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.query.dao.DictQueryDao;
import com.repair.query.service.QueryService;

public class QueryServiceImpl implements QueryService{
	
	@Resource(name = "queryDao")
	private DictQueryDao queryDao;
	@Resource(name="dictProTeamDao")
	private DictProTeamDao dictProTeamDao;

	@Override
	public List<DictJcType> getAllJcType() {
		return queryDao.findAllDictJcType();
	}

	@Override
	public List<DictJcFixSeq> getAllFixSeq() {
		return queryDao.findAllDictJcFixSeqs();
	}

	@Override
	public List<DictGuDao> getAllGuDao() {
		return queryDao.findAllGuDao();
	}

	@Override
	public List<DictProTeam> getAllProTeam() {
		return queryDao.findAllProTeam();
	}
	
	

	@Override
	public List<DictFirstUnit> getAllFirstUnit() {
		return queryDao.findAllFirstUnit();
	}

	@Override
	public List<DatePlanPri> findGDJCInDailyPlan(String time) {
		return queryDao.findGDJCInDailyPlan(time);
	}

	@Override
	public List<JCFlowRec> findJCFlowRecByDatePlan(Integer rjhmId) {
		return queryDao.findJCFlowRecByDatePlan(rjhmId);
	}

	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return queryDao.findDatePlanPriById(rjhmId);
	}

	@Override
	public List<DictJcStype> findStypeByTypeId(Integer typeId) {
		return queryDao.findStypeByTypeId(typeId);
	}

	@Override
	public List<JtRunKiloRec> findJtRunKiloRec(String stypeId) {
		return queryDao.findJtRunKiloRec(stypeId);
	}

	@Override
	public List<DatePlanPri> findDatePlanPri(Map<String, String> map) {
		return queryDao.findDatePlanPri(map);
	}

	@Override
	public List<JCFixrec> findJCFixrec(Integer datePlanPri,String unit) {
		return queryDao.findJCFixrec(datePlanPri,unit);
	}
	
	public PageModel<JCFixrec> findJCFixrecLimited(Integer datePlanPri,String unit) {
		return queryDao.findJCFixrecLimited(datePlanPri,unit);
	}
	
	public Long countJCZXFixRec(Integer datePlanPri,Integer fristUnit){
		return queryDao.countJCZXFixRec(datePlanPri,fristUnit);
	}
	
	@Override
	public List<JCZXFixRec> findJCZXFixRec(Integer datePlanPri,Integer fristUnit) {
		return queryDao.findJCZXFixRec(datePlanPri,fristUnit);
	}

	@Override
	public DatePlanPri findDatePlanPriByJC(String xcxc, String jcStype,
			String jcNum) {
		return queryDao.findDatePlanPriByJC(xcxc, jcStype, jcNum);
	}

	@Override
	public List<JCQZFixRec> findJCQZFixRec(Integer datePlanPri) {
		return queryDao.findJCQZFixRec(datePlanPri);
	}

	@Override
	public List<JtPreDict> findJtPreDict(Integer datePlanPri) {
		return queryDao.findJtPreDict(datePlanPri);
	}
	
	@Override
	public List<JtPreDict> findJtPreDictPre(Integer datePlanPri){
		return queryDao.findJtPreDictPre(datePlanPri);
	}
	
	@Override
	public List<JtPreDict> findJtPreDictByFlag(Integer datePlanPri, Object flag) {
		return queryDao.findJtPreDictByFlag(datePlanPri, flag);
	}
	
	public List<JtPreDict> findJtPreDictByFlag(Integer datePlanPri, Object flag, int type){
		return queryDao.findJtPreDictByFlag(datePlanPri, flag,type); 
	}

	@Override
	public SignedForFinish findSignedForFinishByPlan(Integer datePlanPri) {
		return queryDao.findSignedForFinishByPlan(datePlanPri);
	}

	@Override
	public List<DictFirstUnit> findDictFirstUnitByType(String jcStype) {
		return queryDao.findDictFirstUnitByType(jcStype);
	}

	@Override
	public List<JtPreDict> findAllJtPreDict(Integer datePlanPri) {
		return queryDao.findAllJtPreDict(datePlanPri);
	}
	
	/**
	 * 获取竣工记录
	 */
	public SignedForFinish getJCjungong(int rjhmId){
		return queryDao.getJCjungong(rjhmId);
	}
	
	/**
	 * 获取电力签到记录
	 */
	public List<DlJcJyMxb> getDlJcJyMxb(int rjhmId){
		return queryDao.getDlJcJyMxb(rjhmId);
	}
	
	/**
	 * 交车内燃签到记录
	 */
	public List<NrJcJyzb> getNrJcJyzb(int rjhmId){
		return queryDao.getNrJcJyzb(rjhmId);
	}
	
	/**
	 * 获得签名记录
	 */
	public List<JCSignature> getJCSignature(int rjhmId){
		List<JCSignature> list = queryDao.getJCSignature(rjhmId);
		for (JCSignature jcSignature : list) {
			DictProTeam team = null;
			if(jcSignature.getUser().getBzid()!=null){
				team = dictProTeamDao.findDictProTeamById(jcSignature.getUser().getBzid());
				if(team!=null){
					jcSignature.setBzName(team.getProteamname());
				}
			}
		}
		return list;
	}

	@Override
	public List<JCFixrec> findJCFixrec(Integer datePlanPri) {
		return queryDao.findJCFixrec(datePlanPri);
	}
	
	@Override
	public List<JCZXFixRec> findJCZXFixRec(Integer datePlanPri) {
		return queryDao.findJCZXFixRec(datePlanPri);
	}
	
	public PageModel<JCZXFixRec> findJCZXFixRecLimited(Integer datePlanPri) {
		return queryDao.findJCZXFixRecLimited(datePlanPri);
	}
	
	@Override
	public List<DictProTeam> findAllProTeam() {
		return queryDao.findAllProTeam();
	}
	
	@Override
	public List<DictProTeam> findAllProTeam(String jctype, Integer workflag) {
		return queryDao.findAllProTeam(jctype, workflag);
	}
	
	@Override
	public List<DictProTeam> findAllZxProTeam(String jctype, Integer workflag) {
		return queryDao.findAllZxProTeam(jctype, workflag);
	}

	@Override
	public List<JCFixrec> findRecByProTeam(Integer rjhmId, Long teamId) {
		return queryDao.findRecByProTeam(rjhmId, teamId);
	}
	
	@Override
	public List<JCZXFixRec> findZxRecByProTeam(Integer rjhmId, Long teamId,Integer nodeId) {
		return queryDao.findZxRecByProTeam(rjhmId, teamId,nodeId);
	}

	@Override
	public List<JCQZFixRec> findJCQZFixrecByUnit(Integer rjhmId, String unit) {
		return  queryDao.findJCQZFixrecByUnit(rjhmId, unit);
	}

	@Override
	public List<JCQZFixRec> findJCQZFixrecByTeam(Integer rjhmId, Long teamId) {
		return queryDao.findJCQZFixrecByTeam(rjhmId, teamId);
	}

	@Override
	public List<DatePlanPri> findJCHistory(String jcNum) {
		return queryDao.findJCHistory(jcNum);
	}
	
	public void updateJCGDAndTW(int rjhmId,String gdh,String twh){
		queryDao.updateJCGDAndTW(rjhmId, gdh, twh);
	}

	@Override
	public String findXcxc(String xcxc) {
		return queryDao.findXcxc(xcxc);
	}

	@Override
	public List<JCZXFixItem> findZXItem(Integer nodeid, String xcxc, String jcsType, Long bzid, Integer firstUnitId){
		return queryDao.findZXItem(nodeid, xcxc, jcsType, bzid, firstUnitId);
	}

	@Override
	public List<PJStaticInfo> findPJStaticInfo(String jcType,Long bzId) {
		return queryDao.findPJStaticInfo(jcType,bzId);
	}

	@Override
	public List<PJDynamicInfo> findPJDynamicInfoBySID(Long pjsid) {
		return queryDao.findPJDynamicInfoBySID(pjsid);
	}

	@Override
	public Map<String,Object> findExpSituation(Integer rjhmId) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("item","机车试验");
		map.put("grFinished", queryDao.findExpSituation(rjhmId, 0));
		map.put("gzFinished", queryDao.findExpSituation(rjhmId, 1));
		map.put("zjFinished", queryDao.findExpSituation(rjhmId, 2));
		map.put("jsFinished", queryDao.findExpSituation(rjhmId, 3));
		map.put("jcgzFinished", queryDao.findExpSituation(rjhmId, 4));
		map.put("ysFinished", queryDao.findExpSituation(rjhmId, 5));
		return map;
	}

	@Override
	public Map<String, Long> findZXExpSituation(Integer rjhmId) {
		return null;
	}
	
}
