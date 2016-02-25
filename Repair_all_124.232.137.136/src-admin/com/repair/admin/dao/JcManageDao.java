package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.PageModel;

/**
 * 机车管理
 * @author txf
 *
 */
public interface JcManageDao {
	/**
	 * 新增机车
	 * @param jtRunKiloRec
	 * @return
	 */
	public void saveOrUpdateJtRunKiloRec(JtRunKiloRec jtRunKiloRec);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public void delete(JtRunKiloRec jtRunKiloRec);
	
	/**
	 * 修改
	 * @param jtRunKiloRec
	 * @return
	 */
	public void update(JtRunKiloRec jtRunKiloRec);
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	public JtRunKiloRec getById(int id);
	
	/**
	 * 查询所有
	 * @return
	 */
	public List<JtRunKiloRec> list();
	
	/**
	 * 根据机车型号查询
	 * @param jtRunKiloRec
	 * @return
	 */
	public List<JtRunKiloRec> listByJcType(String jcType);
	
	/**
	 * 根据机车编号查询
	 * @param jtRunKiloRec
	 * @return
	 */
	public List<JtRunKiloRec> listByJcTypeAndJcNum(JtRunKiloRec jtRunKiloRec);
	
	/**
	 * 查询机车型号
	 * @return
	 */
	public List<DictJcStype> ListDictJcStype();
	
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
	public void deleteRepairjc(Long rjhmId);
	
}
