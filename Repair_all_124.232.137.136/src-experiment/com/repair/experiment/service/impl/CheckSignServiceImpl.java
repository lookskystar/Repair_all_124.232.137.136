package com.repair.experiment.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCSignature;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.UsersPrivs;
import com.repair.experiment.dao.CheckSignDao;
import com.repair.experiment.service.CheckSignService;

public class CheckSignServiceImpl implements CheckSignService{
	
	@Resource(name="checkSignDao")
	private CheckSignDao checkSignDao;

	@Override
	public List<DatePlanPri> findCheckJc() {
		return checkSignDao.findCheckJc();
	}

	@Override
	public List<DatePlanPri> findCheckJc(int nodeId,Long userId) {
//		List<DatePlanPri> list = new ArrayList<DatePlanPri>();
//		List<DatePlanPri> temp = checkSignDao.findCheckJc(nodeId,userId);
//		for (DatePlanPri datePlanPri : temp) {
//			if(checkSignDao.countAccepterUnSignItem(datePlanPri)>0){
//				list.add(datePlanPri);
//			}
//		}
//		return list;
		return checkSignDao.findCheckJc(nodeId,userId);
	}

	@Override
	public void saveSignature(JCSignature signature) {
		checkSignDao.saveSignature(signature);
	}

	@Override
	public DatePlanPri findDatePlanPriById(int rjhmId) {
		return checkSignDao.findDatePlanPriById(rjhmId);
	}

	@Override
	public List<JCSignature> findJCSignatureByDatePlanId(int datePlanId) {
		return checkSignDao.findJCSignatureByDatePlanId(datePlanId);
	}
	
	public List<DictProTeam> listFixProTeam(int datePlanId){
		return checkSignDao.listFixProTeam(datePlanId);
	}

	@Override
	public void saveDlJcJyZbMxb(DlJcJyZb dljcjtzb) {
		checkSignDao.saveDlJcJyZbMxb(dljcjtzb);
	}

	@Override
	public List<DlJcJyMxb> findDlJcJyMxbByDpId(int datePlanId) {
		return checkSignDao.findDlJcJyMxbByDpId(datePlanId);
	}

	@Override
	public DlJcJyMxb findDlJcJyMxbById(int djmId) {
		return checkSignDao.findDlJcJyMxbById(djmId);
	}

	@Override
	public void saveDlJcJyMxb(DlJcJyMxb djm) {
		checkSignDao.saveDlJcJyMxb(djm);
	}

	@Override
	public NrJcJyzb findNrJcJyzbByDpId(int dpId) {
		return checkSignDao.findNrJcJyzbByDpId(dpId);
	}

	@Override
	public void saveNrJcJyzb(NrJcJyzb nrJcJyzb) {
		checkSignDao.saveNrJcJyzb(nrJcJyzb);
	}

	@Override
	public void updateNrJcJyzb(NrJcJyzb nrJcJyzb) {
		checkSignDao.updateNrJcJyzb(nrJcJyzb);
	}

	@Override
	public JCSignature findJCSignatureByUserDpId(UsersPrivs user,
			DatePlanPri datePlan) {
		return checkSignDao.findJCSignatureByUserDpId(user, datePlan);
	}

	@Override
	public List<DlJcJyMxb> findDlJcJyMxbByIdStatus(int jyzId, short status) {
		return checkSignDao.findDlJcJyMxbByIdStatus(jyzId, status);
	}

	@Override
	public DlJcJyZb findDlJcJyZbByDpId(DatePlanPri datePlan) {
		return checkSignDao.findDlJcJyZbByDpId(datePlan);
	}

	@Override
	public void updateDatePlanPri(DatePlanPri datePlan) {
		checkSignDao.updateDatePlanPri(datePlan);
	}

	@Override
	public void saveDlJcJyMxb(DlJcJyMxb djm, DlJcJyZb dz,
			DatePlanPri datePlanPri, int type,int djmId) {
		checkSignDao.saveDlJcJyMxb(djm);
		djm=checkSignDao.findDlJcJyMxbById(djmId);
		if(signAll(djm)){//角色全部签完，将状态改为1
			djm.setStatus((short)1);
			checkSignDao.saveDlJcJyMxb(djm);
			//根据检测项目ID和状态查询DlJcJyMxb是否都已经签认完
			List<DlJcJyMxb> list=checkSignDao.findDlJcJyMxbByIdStatus(dz.getJyzId(),(short)0);
			if(list==null||list.isEmpty()){//全部签认完
				datePlanPri.setPlanStatue(1);//将日计划状态修改为待验
				datePlanPri.setZhiJian(checkSignDao.getUsersPrivsByGonghao(djm.getZj()));//设置质检员信息
				datePlanPri.setYanShou(checkSignDao.getUsersPrivsByGonghao(djm.getYs()));//设置验收员信息
				checkSignDao.updateDatePlanPri(datePlanPri);
			}
		}
		
	}
	
	/**
	 * 交车工长、质检、验收是否都签完，都签完返回true
	 * @param djm
	 * @return
	 */
	@SuppressWarnings("unused")
	private boolean signAll(DlJcJyMxb djm){
		boolean flag=false;
		boolean gzFlag=djm.getJcgz()!=null&&!djm.getJcgz().equals("");
		boolean zjFlag=djm.getZj()!=null&&!djm.getZj().equals("");
		boolean ysFlag=djm.getYs()!=null&&!djm.getYs().equals("");
		if(gzFlag&&zjFlag&&ysFlag){
			flag=true;
		}
		return flag;
	}

	@Override
	public List<JtPreDict> findPredicts(Integer rjhmId) {
		return checkSignDao.findPredicts(rjhmId);
	}

	@Override
	public List<DictJwd> findDictJwds() {
		return checkSignDao.findDictJwds();
	}

}
