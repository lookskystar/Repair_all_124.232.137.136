package com.repair.admin.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.repair.admin.dao.JcManageDao;
import com.repair.admin.service.JcManageService;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.PageModel;
import com.repair.common.util.ResultCode;
import com.repair.common.util.ResultMap;

public class JcManageServiceImpl implements JcManageService{
	private JcManageDao jcManageDao;
	public JcManageDao getJcManageDao() {
		return jcManageDao;
	}
	public void setJcManageDao(JcManageDao jcManageDao) {
		this.jcManageDao = jcManageDao;
	}

	
	
	/* (non-Javadoc)
	 * @see com.repair.admin.service.JcManageService#delete(long)
	 */
	@Override
	public ResultMap<ResultCode, JtRunKiloRec> delete(long runId) {
		ResultMap<ResultCode, JtRunKiloRec> result = new ResultMap<ResultCode, JtRunKiloRec>();
		result.setCode(ResultCode.FAIL);
		if(runId <= 0){
			result.setCode(ResultCode.MISSID);
		}else{
			JtRunKiloRec jt = new JtRunKiloRec();
			jt.setRunId(runId);
			jcManageDao.delete(jt);
			result.setCode(ResultCode.OK);
		}
		return result;
	}
	@Override
	public ResultMap<ResultCode, JtRunKiloRec> update(long runId,String jwdCode, String jcType, String jcNum,
			String dayRunKilo, String minorRunKilo, String smaRunKilo,
			String midRunKilo, String larRunKilo, String totalRunKilo,
			String registRant) {
		ResultMap<ResultCode, JtRunKiloRec> result = new ResultMap<ResultCode, JtRunKiloRec>();
		result.setCode(ResultCode.FAIL);
		if(runId <= 0){
			result.setCode(ResultCode.MISSID);
		}else if(jcType == null || "".equals(jcType)){
			result.setCode(ResultCode.MISSTYPE);
		} else if(jcNum == null || "".equals(jcNum)){
			result.setCode(ResultCode.MISSCODE);
		} else {
			JtRunKiloRec jt = new JtRunKiloRec();
			jt.setDayRunKilo(dayRunKilo);
			jt.setJcNum(jcNum);
			jt.setJwdCode(jwdCode);
			jt.setJcType(jcType);
			jt.setMinorRunKilo(minorRunKilo);
			jt.setSmaRunKilo(smaRunKilo);
			jt.setMidRunKilo(midRunKilo);
			jt.setLarRunKilo(larRunKilo);
			jt.setTotalRunKilo(totalRunKilo);
			jt.setRegistRant(registRant);
			try {
				jcManageDao.update(jt);
				result.setCode(ResultCode.OK);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	@Override
	public List<JtRunKiloRec> list() {
		return jcManageDao.list();
	}
	@Override
	public List<JtRunKiloRec> listByJcType(String jcType) {
		return jcManageDao.listByJcType(jcType);
	}
	@Override
	public void saveOrUpdateJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		jcManageDao.saveOrUpdateJtRunKiloRec(jtRunKiloRec);
		
	}
	@Override
	public List<DictJcStype> ListDictJcStype() {
		return jcManageDao.ListDictJcStype();
	}
	@Override
	public void delDictJcStype(int jcNumId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void saveOrUpdateDictJcStype(DictJcStype dictJcStype) {
		// TODO Auto-generated method stub
	}
	
	public PageModel<JtRunKiloRec> listJtRunKiloRec(String jcType, String jcNum) {
		return jcManageDao.listJtRunKiloRec(jcType, jcNum);
	}
	@Override
	public String deleteJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		return jcManageDao.deleteJtRunKiloRec(jtRunKiloRec);
	}
	@Override
	public JtRunKiloRec queryJtRunKiloRecById(long runId) {
		return jcManageDao.queryJtRunKiloRecById(runId);
	}
	@Override
	public JtRunKiloRec listJtRunKiloRecOnly(String jctype, String jcnum) {
		return jcManageDao.listJtRunKiloRecOnly(jctype, jcnum);
	}
	@Override
	public PageModel<DatePlanPri> listDatePlanPri(String jcType, String jcNum,
			String fixFreque) {
		return jcManageDao.listDatePlanPri(jcType, jcNum, fixFreque);
	}
	@Override
	public void deleteRepairjc(String[]  jcArray) {
		for (int i = 0; i < jcArray.length; i++) {
			jcManageDao.deleteRepairjc(Long.parseLong(jcArray[i]));
		}
		
	}
}

