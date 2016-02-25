package com.repair.query.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.util.PageModel;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.plan.dao.impl.DictProTeamDaoImpl;
import com.repair.query.dao.JcFixRecDao;
import com.repair.query.service.JcFixRecService;

public class JcFixRecServiceImpl implements JcFixRecService {
	@Resource(name = "jcFixRecDao")
	private JcFixRecDao jcFixRecDao;
	@Resource(name = "dictProTeamDao")
	private DictProTeamDao dictProTeamDao;

	@Override
	public Map<Integer, PageModel<Object[]>> getTotalDuration(String startDate,
			String endDate, String jcNum, String fixEmp) {
		return jcFixRecDao.getTotalDuration(startDate, endDate, jcNum, fixEmp);
	}

	@Override
	public Map<Integer, PageModel<Object[]>> getZxDuration(String startDate,
			String endDate, String jcNum, String fixEmp) {
		return jcFixRecDao.getZxDuration(startDate, endDate, jcNum, fixEmp);
	}

	@Override
	public PageModel<JCFixrec> itemTime(String startDate, String endDate,
			String jcNum, String fixEmp) {

		return jcFixRecDao.itemTime(startDate, endDate, jcNum, fixEmp);
	}

	@Override
	public Map<Object, PageModel<Object[]>> repCount(String startDate, String endDate,
			String jcNum, String dealFixEmp,Long type,Long roleid,Long bzid) {
		return jcFixRecDao.repCount(startDate, endDate, jcNum, dealFixEmp,type,roleid,bzid);
	}
	
	@Override
	public Map<Object, PageModel<Object[]>> reportCount(String startDate, String endDate,
			String jcNum, String dealFixEmp,Long type,Long roleid,Long bzid) {
		return jcFixRecDao.reportCount(startDate, endDate, jcNum, dealFixEmp,type,roleid,bzid);
	}

	@Override
	public PageModel<JtPreDict> repItem(String startDate, String endDate,
			String jcNum, String dealFixEmp,Long type) {
		return jcFixRecDao.repItem(startDate, endDate, jcNum, dealFixEmp,type);
	}
	
	@Override
	public PageModel<JtPreDict> reportItem(String startDate, String endDate,
			String jcNum, String dealFixEmp,Long type) {
		return jcFixRecDao.reportItem(startDate, endDate, jcNum, dealFixEmp,type);
	}
	@Override
	public PageModel<JCZXFixRec> zxItemTime(String startDate, String endDate,
			String jcNum, String fixEmp) {
		return jcFixRecDao.zxItemTime(startDate, endDate, jcNum, fixEmp);
	}

	@Override
	public List<DictFirstUnit> listFirstUnitsOfJCFixRec(Integer rjhmId,int type) {
		List<DictFirstUnit> units = new ArrayList<DictFirstUnit>();
		DictFirstUnit firstUnit = null;

		List list = jcFixRecDao.listFirstUnitsOfJCFixRec(rjhmId,type);
		for (int i = 0; i < list.size(); i++) {
			Object[] it = (Object[]) list.get(i);
			firstUnit = new DictFirstUnit();
			firstUnit.setFirstunitid(Long.parseLong(it[0] + ""));
			firstUnit.setFirstunitname(it[1] + "");
			units.add(firstUnit);
		}
		return units;
	}

	@Override
	public Map<String, List<JCFixrec>> listLeftWorkRecord(Integer rjhmId) {
		Map<String, List<JCFixrec>> leftWorkRecordMap = new HashMap<String, List<JCFixrec>>();
		List<JCFixrec> leftWorkRecordList = jcFixRecDao.listLeftWorkRecord(rjhmId);
		List<JCFixrec> leftWorkRecordListOfPro = null;
		for (JCFixrec jcFixrec : leftWorkRecordList) {
			Long bzId = jcFixrec.getBanzuId();
			DictProTeam	dicProTeam = dictProTeamDao.findDictProTeamById(bzId);
			String proTeamName = dicProTeam.getProteamname();
			if (jcFixrec.getFixEmp() == null || jcFixrec.getLead() == null
					|| (jcFixrec.getItemCtrlQI() == 1 && jcFixrec.getQi() == null)
					|| (jcFixrec.getItemCtrlTech() == 1 && jcFixrec.getTech() == null)
					|| (jcFixrec.getItemCtrlComLd() == 1 && jcFixrec.getCommitLead() == null)
					|| (jcFixrec.getItemCtrlAcce() == 1 && jcFixrec.getAccepter() == null)) {
				if (leftWorkRecordMap.get(proTeamName) == null) {
					leftWorkRecordListOfPro = new ArrayList<JCFixrec>();
					leftWorkRecordMap.put(proTeamName, leftWorkRecordListOfPro);
				} else {
					leftWorkRecordListOfPro = leftWorkRecordMap.get(proTeamName);
				}
				leftWorkRecordListOfPro.add(jcFixrec);
			}
		}
		return leftWorkRecordMap;
	}
	
	public Map<String, List<JCZXFixRec>> listZXLeftWorkRecord(Integer rjhmId) {
		Map<String, List<JCZXFixRec>> leftWorkRecordMap = new HashMap<String, List<JCZXFixRec>>();
		List<JCZXFixRec> leftWorkRecordList = jcFixRecDao.listZXLeftWorkRecord(rjhmId);
		List<JCZXFixRec> leftWorkRecordListOfPro = null;
		for (JCZXFixRec jCZXFixRec : leftWorkRecordList) {
			Long bzId = jCZXFixRec.getBzId();
			DictProTeam	dicProTeam = dictProTeamDao.findDictProTeamById(bzId);
			String proTeamName = dicProTeam.getProteamname();
			if (jCZXFixRec.getFixEmp() == null || jCZXFixRec.getLead() == null
					|| (jCZXFixRec.getItemCtrlQi() == 1 && jCZXFixRec.getQi() == null)
					|| (jCZXFixRec.getItemCtrlTech() == 1 && jCZXFixRec.getTeachName() == null)
					|| (jCZXFixRec.getItemCtrlComld() == 1 && jCZXFixRec.getCommitLead() == null)
					|| (jCZXFixRec.getItemCtrlAcce() == 1 && jCZXFixRec.getAcceptEr() == null)) {
				if (leftWorkRecordMap.get(proTeamName) == null) {
					leftWorkRecordListOfPro = new ArrayList<JCZXFixRec>();
					leftWorkRecordMap.put(proTeamName, leftWorkRecordListOfPro);
				} else {
					leftWorkRecordListOfPro = leftWorkRecordMap.get(proTeamName);
				}
				leftWorkRecordListOfPro.add(jCZXFixRec);
			}
		}
		return leftWorkRecordMap;
	}

	@Override
	public List<DatePlanPri> findFixDatePlanPri() {
		return jcFixRecDao.findFixDatePlanPri();
	}

	@Override
	public List<JtPreDict> findJtPreDictByRjhmId(Integer rjhmId) {
		return jcFixRecDao.findJtPreDictByRjhmId(rjhmId);
	}

	@Override
	public void updateJtPreDictScore(Integer preDictId, Integer score) {
		jcFixRecDao.updateJtPreDictScore(preDictId, score);
	}

	@Override
	public DatePlanPri findDatePlanPriById(Integer rjhmId) {
		return jcFixRecDao.findDatePlanPriById(rjhmId);
	}

}
