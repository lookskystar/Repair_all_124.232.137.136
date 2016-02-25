package com.repair.work.service.impl;

import static com.repair.common.util.WebUtil.isEmpty;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Page;
import com.repair.work.dao.DictUnitDao;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.UsersPrivsDao;
import com.repair.work.service.JtPreDictService;

public class JtPreDictServiceImpl implements JtPreDictService{
	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Resource(name="jtPreDictDao")
	private JtPreDictDao jtPreDictDao;
	@Resource(name="dictUnitDao")
	private DictUnitDao dictUnitDao;
	@Resource(name = "usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	
	/**
	 * 根据日计划和班组获取报活项目
	 * @return
	 */
	public List<JtPreDict> getJtPreDict(Integer rjhmId,Long bzId){
		return jtPreDictDao.getJtPreDict(rjhmId, bzId);
	}
	
	public List<JtPreDict> findMyReportJtPreDict(Integer rjhmId,String gonghao){
		return jtPreDictDao.findMyReportJtPreDict(rjhmId, gonghao);
	}

	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId) {
		return jtPreDictDao.findJtPreDictByDatePlan(rjhmId);
	}
	
	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId,
			Long proteamid, Short status) {
		return jtPreDictDao.findJtPreDictByDatePlan(rjhmId, proteamid, status);
	}
	
	@Override
	public List<JtPreDict> findJtPreDictSignItemByDatePlan(Integer rjhmId,
			Long proteamid) {
		return jtPreDictDao.findJtPreDictSignItemByDatePlan(rjhmId, proteamid);
	}
	
	public List<JtPreDict> findSmJtPreDicts(Integer preDictId){
		return jtPreDictDao.findSmJtPreDicts(preDictId);
	}

	@Override
	public List<DictFirstUnit> findDictFirstUnitAll(String jcType) {
		return dictUnitDao.findDictFirstUnitAll(jcType);
	}

	@Override
	public List<DictSecunit> findDictSecunitByFirstId(Long firstunitid) {
		return dictUnitDao.findDictSecunitByFirstId(firstunitid);
	}

	/**
	 * 查询我的派工
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 */
	public List<DatePlanPri> listMyJtPreDict(long userid,Short type){
		return jtPreDictDao.listMyJtPreDict(userid, type);
	}
	
	/**
	 * 查询我的分工
	 * @param rjhmId 日计划ID
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 * @param flag true 我的分工 false非我的分工
	 */
	public List<JtPreDict> listMyJtPreDict(int rjhmId,UsersPrivs user,Short type,boolean flag){
		return jtPreDictDao.listMyJtPreDict(rjhmId, user, type,1,flag);
	}
	
	/**
	 * 查询分工
	 * @param rjhmId 日计划ID
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 * @param flag true 我的分工 false非我的分工
	 */
	public List<JtPreDict> listMyJtPreDictNoPre(int rjhmId,UsersPrivs user,Short type){
		return jtPreDictDao.listMyJtPreDictNoPre(rjhmId, user, type,1);
	}

	@Override
	public JtPreDict findJtPreDictById(Integer preDictId) {
		return jtPreDictDao.findJtPreDictById(preDictId);
	}
	
	/**
	 * 工人签字
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户
	 * @return noprivilege_failure:不是指定的检修人  success:成功
	 */
	public String updateJtPreDictOfWorkerRatify(int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker,short type){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(qtype==1){
			List<JtPreDict> list = jtPreDictDao.listMyJtPreDict(rjhmId, worker, type,0,true);
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				for(JtPreDict rec : list){
					rec.setDealFixEmp(dealString(rec.getDealFixEmp(),worker.getXm()));
					rec.setFixEndTime(now);
					rec.setDealSituation(checkInfo);
					rec.setRecStas((short)3);
					jtPreDictDao.updateJtPreDict(rec);
				}
			}
		}else{
			JtPreDict jtPreDict = null;
			String[] idArr = ids.split("-");
			for (String id : idArr) {
				jtPreDict = jtPreDictDao.getJtPreDictById(Integer.parseInt(id));
				//if(jtPreDict.getFixEmpId().indexOf(","+worker.getUserid()+",")<0){
					//result = "noprivilege_failure";
				//}else{
					jtPreDict.setDealFixEmp(dealString(jtPreDict.getDealFixEmp(),worker.getXm()));
					jtPreDict.setFixEndTime(now);
					jtPreDict.setDealSituation(checkInfo);
					jtPreDict.setRecStas((short)3);
					jtPreDictDao.updateJtPreDict(jtPreDict);
				}
			//}
		}
		return result;
	}
	
	/**
	 * 去除重复字符串
	 */
	private String dealString(String oldStr,String subStr){
		String result = "";
		if(oldStr==null || "".equals(oldStr)){
			result = ","+subStr+",";
		}else{
			if(oldStr.indexOf(","+subStr+",")>=0){
				result = oldStr;
			}else{
				result = oldStr + subStr + ",";
			}
		}
		return result;
	}

	@Override
	public JtPreDict updateJtPreDictDistribution(Integer preDictId, Long[] userids) {
		JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictId);
		if (userids.length > 0) {
			List<UsersPrivs> usersPrivs = new ArrayList<UsersPrivs>();
			for (int i = 0; i < userids.length; i++) {
				usersPrivs.add(usersPrivsDao.getUsersPrivsById((userids[i])));
			}
			String fixEmpId = ",";
			String fixEmp = "";
			for (UsersPrivs user : usersPrivs) {
				fixEmpId += user.getUserid()+",";
				fixEmp += user.getXm()+",";
			}
			preDict.setFixEmpId(isEmpty(fixEmpId)?null:fixEmpId);
			preDict.setFixEmp(isEmpty(fixEmp)?null:fixEmp.substring(0, fixEmp.length()-1));
			preDict.setRecStas((short)2);
			jtPreDictDao.saveOrUpdate(preDict);
		}
		return preDict;
	}
	
	
	public void updateJtPreDict(String[] preDictIds,String[] userIds){
		for(String preDictId:preDictIds){
			Long[] userids = new Long[userIds.length];
			for (int i = 0; i < userIds.length; i++) {
				userids[i] = Long.parseLong(userIds[i]);
			}
			updateJtPreDictDistribution(Integer.parseInt(preDictId),userids);
		}
	}
	
	public void deleteJtPreDict(String[] preDictIds){
		for(String preDictId:preDictIds){
			JtPreDict preDict = jtPreDictDao.findJtPreDictById(Integer.parseInt(preDictId));
			preDict.setFixEmp(null);
			preDict.setFixEmpId(null);
			if (isEmpty(preDict.getVerifier())) {
				preDict.setRecStas((short)1);
			} else {
				preDict.setRecStas((short)0);
			}
			deleteJtPreDictDistribution(preDict);
		}
	}
	
	public void saveOrUpdateJtPreDict(JtPreDict preDict){
		this.jtPreDictDao.saveOrUpdate(preDict);
	}
	
	/**
	 * 取消派工
	 */
	public void delJtPreDictOfCancle(Integer preDictId){
		JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictId);
		preDict.setVerifier(null);
		preDict.setVerifyTime(null);
		preDict.setRecStas((short)0);
		preDict.setProTeamId(null);
		preDict.setItemCtrlTech(null);
		preDict.setItemCtrlQI(null);
		preDict.setItemCtrlComLd(null);
		preDict.setItemCtrlAcce(null);
		jtPreDictDao.saveOrUpdate(preDict);
		jtPreDictDao.deleteSmJtPreDict(preDictId);
	}
	
	/**
	 * 作废报活
	 */
	public void delJtPreDictOfAbolish(Integer preDictId){
		JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictId);
		preDict.setRecStas((short)-1);
		jtPreDictDao.saveOrUpdate(preDict);
		jtPreDictDao.deleteSmJtPreDict(preDictId);

	}
	
	public void deleteJtPreDictDistribution(JtPreDict preDict) {
		jtPreDictDao.updateJtPreDict(preDict);
	}
	
	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,long userid) {
		return jtPreDictDao.listJtPreDict(rjhmId, roleType,userid);
	}
	
	/**
	 * 查询故障表一级部件
	 */
	public List<String> listFirstUnitNameOfDictFailure(){
		return jtPreDictDao.listFirstUnitNameOfDictFailure();
	}
	
	/**
	 * 查询故障表二级部件
	 */
	public List<String> listSecUnitNameOfDictFailure(String firstUnitName){
		return jtPreDictDao.listSecUnitNameOfDictFailure(firstUnitName);
	}
	
	/**
	 * 查询故障表三级部件
	 */
	public List<String> listThirdUnitNameOfDictFailure(String firstUnitName,String secUnitName){
		return jtPreDictDao.listThirdUnitNameOfDictFailure(firstUnitName,secUnitName);
	}
	
	/**
	 * 查询故障内容
	 */
	public List<DictFailure> listDictFailure(String firstUnitName,String seccondUnitName,String thirdUnitName){
		return jtPreDictDao.listDictFailure(firstUnitName, seccondUnitName, thirdUnitName);
	}

	@Override
	public List<PresetDivision> listPresetDivision(long proTeamId, String jcType) {
		return jtPreDictDao.listPresetDivision(proTeamId, jcType);
	}

	@Override
	public List<JCDivision> listJCDivision(Integer divisionId, Integer planId) {
		return jtPreDictDao.listJCDivision(divisionId, planId);
	}
	
	@Override
	public boolean saveOrUpdateDictFailure(DictFailure dictFailure) {
		try {
			dictUnitDao.saveOrUpdateDictFailure(dictFailure);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<DictFailure> queryDictFailurePage(Page page, Map<String, String> conditionMap){
		return dictUnitDao.queryDictFailurePage(page, conditionMap);
	}

	@Override
	public Long queryAllDictFailure(Map<String, String> conditionMap) {
		return dictUnitDao.queryAllDictFailure(conditionMap);
	}

	@Override
	public String deleteDictFailure(DictFailure dictFailure) {
		try {
			dictUnitDao.deleteDictFailure(dictFailure);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "failure";
		}
	}

	@Override
	public DictFailure queryDictFailureById(int id) {
		return dictUnitDao.queryDictFailureById(id);
	}
	
	/**
	 * 查询班组未完成的报活
	 */
	@SuppressWarnings("unchecked")
	public List countUnfinishJtPreDict(Long bzId,String roles){
		List list = jtPreDictDao.countUnfinishJtPreDict(bzId,roles);
//		if(bzId != null){
//			list = jtPreDictDao.countUnfinishJtPreDict(bzId);
//		}else {
//			list = jtPreDictDao.countUnfinishJtPreDict(roles);
//		}
		List result = null;
		if(list!=null && list.size()>0){
			result = new ArrayList();
			Object[] obj;
			long count=0;
			for (int i = 0; i < list.size(); i++) {
				obj = (Object[]) list.get(i);
				count = Long.parseLong(obj[5]+"");
				if(count>0){
					result.add(obj);
				}
			}
			return result;
		}
		return null;
	}

	@Override
	public List countJCGZUnSigned() {
		List list =jtPreDictDao.countJCGZUnSigned();
		List result=null;
		if(list!=null&&list.size()>0){
			result=new ArrayList();
			Object[] obj;
			for (int i = 0; i < list.size(); i++) {
				obj = (Object[]) list.get(i);
				long unfinishReportCount = Long.parseLong(obj[5]+"");//为完成报活
				long unsignedJCRecCount=Long.parseLong(obj[6]+"");//交车工长未签认完的需要卡控的检修项目
				long unsignedJCZXRecCount=Long.parseLong(obj[7]+"");//交车工长未签认完的需要卡控的中修检修项目
				if(unfinishReportCount>0||unsignedJCRecCount>0||unsignedJCZXRecCount>0){
					result.add(obj);
				}
			}
			return result;
		}
		return null;
	}
}
