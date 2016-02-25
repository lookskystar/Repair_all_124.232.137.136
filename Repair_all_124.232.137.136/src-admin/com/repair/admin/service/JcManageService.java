package com.repair.admin.service;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.PageModel;
import com.repair.common.util.ResultCode;
import com.repair.common.util.ResultMap;

public interface JcManageService {
	/**
	 * 查询机车型号
	 */
	public List<DictJcStype> ListDictJcStype();
	
	/**
	 * 新增机车型号
	 */
	public void saveOrUpdateDictJcStype(DictJcStype dictJcStype);
	
	/**
	 * 删除机车型号
	 */
	public void delDictJcStype(int jcNumId);
	
	/**
	 * 新增机车
	 *
	 * @return
	 */
	public void saveOrUpdateJtRunKiloRec(JtRunKiloRec jtRunKiloRec);
	/**
	 * 删除机车
	 * @param runId
	 * @return
	 */
	public ResultMap<ResultCode, JtRunKiloRec> delete (long runId);
	
	/**
	 * 修改机车
	 * @param runId
	 * @param jwdCode
	 * @param jcType
	 * @param jcNum
	 * @param dayRunKilo
	 * @param minorRunKilo
	 * @param smaRunKilo
	 * @param midRunKilo
	 * @param larRunKilo
	 * @param totalRunKilo
	 * @param registRant
	 * @return
	 */
	public ResultMap<ResultCode, JtRunKiloRec> update (long runId,String jwdCode, String jcType, String jcNum,
			String dayRunKilo, String minorRunKilo, String smaRunKilo,
			String midRunKilo, String larRunKilo, String totalRunKilo,
			String registRant);
	
	/**
	 * 查询机车
	 * @return
	 */
	public List<JtRunKiloRec> list();
	
	/**
	 * 根据机车型号查询
	 * @param jcType
	 * @return
	 */
	public List<JtRunKiloRec> listByJcType(String jcType);
	
	
	/**
	 * 查询所有机车
	 * 1.根据机车类型
	 * 2.根据机车编号
	 */
	public PageModel<JtRunKiloRec> listJtRunKiloRec(String jcType, String jcNum);
	
	/**
	 * 查询机车
	 * @param runId
	 * @return
	 */
	public JtRunKiloRec queryJtRunKiloRecById (long runId);
	
	/**
	 * 删除机车
	 * @param runId
	 * @return
	 */
	public String deleteJtRunKiloRec (JtRunKiloRec jtRunKiloRec);

	public JtRunKiloRec listJtRunKiloRecOnly(String jctype, String jcnum);
	
	/**
	 * 查询所有在修机车
	 * 1.根据机车类型
	 * 2.根据机车编号
	 * 3.根据修程修次
	 */
	public PageModel<DatePlanPri> listDatePlanPri(String jcType, String jcNum,String fixFreque);
	
	/**
	 * 删除在修机车记录
	 * @param id
	 * @return
	 */
	public void deleteRepairjc(String[]  jcArray);
}
