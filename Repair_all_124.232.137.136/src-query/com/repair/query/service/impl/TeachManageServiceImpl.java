package com.repair.query.service.impl;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.TrainFault;
import com.repair.common.util.PageModel;
import com.repair.query.dao.TeachManageDao;
import com.repair.query.service.TeachManageService;

public class TeachManageServiceImpl implements TeachManageService{

	@Resource(name="teachManageDao")
	private TeachManageDao teachManageDao;
	
	public PageModel<DatePlanPri> techManage(String type, String dateStart, String dateEnd, String jcNum) {
		return teachManageDao.techManage(type, dateStart, dateEnd, jcNum);
	}
	
	public PageModel<DatePlanPri> superFix(String dateStart, String dateEnd, String jcNum) {
		return teachManageDao.superFix(dateStart, dateEnd, jcNum);
	}
	
	public PageModel<DatePlanPri> zoreAnalyse(String dateStart, String dateEnd, String jcNum){
		return teachManageDao.zoreAnalyse(dateStart, dateEnd, jcNum);
	}
	
	public PageModel<JtPreDict> zoreRecord(String isTem,Integer id,  String dateStart, String dateEnd){
		return teachManageDao.zoreRecord(isTem,id, dateStart, dateEnd);
	}

	@Override
	public PageModel<DatePlanPri> fixIndexMainten(String jctype, String jcnum,String dateStart, String dateEnd) {
		return teachManageDao.fixIndexMainten(jctype, jcnum, dateStart,dateEnd);
	}
	
	@Override
	public PageModel<JtPreDict> preInfoRecord(String type,String yjbj, String ejbj,String jctype, String jcnum,String dateStart, String dateEnd) {
		return teachManageDao.preInfoRecord(type, yjbj, ejbj, jctype, jcnum, dateStart,dateEnd);
	}
	
	public PageModel<TrainFault> trainFaultList(String jcType, String jcnum, String dateStart, String dateEnd){
		return teachManageDao.trainFaultList(jcType, jcnum, dateStart,dateEnd);
	}
	
	public void saveTrainFault(TrainFault trainFault){
		teachManageDao.saveTrainFault(trainFault);
	}

	@Override
	public TrainFault queryTrainFaultById(Integer id) {
		return teachManageDao.queryTrainFaultById(id);
	}
	
	public void deleteTrainFault(TrainFault trainFault){
		teachManageDao.deleteTrainFault(trainFault);
	}
}
