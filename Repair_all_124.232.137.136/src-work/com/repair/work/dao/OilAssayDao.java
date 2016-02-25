package com.repair.work.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.pojo.OilAssaySubItem;

/**
 * 油水化验Dao
 * @author Administrator
 *
 */
public interface OilAssayDao {
	
	/**
	 * 查找要化验的机车信息
	 * @return
	 */
	public List<DatePlanPri> findAssayJcs();
	
	/**
	 * 查询所有的油样化验记录信息
	 * @return
	 */
	public List<OilAssayPriRecorder> findOilAssayPriRecorderAll();
	
	/**
	 * 保存油样化验记录信息
	 * @param recorder
	 */
	public void saveOilAssayPriRecorder(OilAssayPriRecorder recorder);

	/**
	 * 根据日计划ID得到日计划信息
	 * @param dpId
	 * @return
	 */
    public DatePlanPri findDatePlanPriById(int dpId);
    
    /**
     * 根据记录信息ID得到相应的记录信息
     * @param recId
     * @return
     */
    public OilAssayPriRecorder findOilAssayPriRecorderById(long recId);
    
    /**
     * 更新油样化验记录信息
     * @param recorder
     */
    public void updateOilAssayPriRecorder(OilAssayPriRecorder recorder);
    
    /**
     * 根据机车类型查询机车油水化验项目
     * @param jcType
     * @return
     */
    public List<OilAssayItem> findOilAssayItemByJcType(String jcType);
    
    /**
     * 根据化验项目ID查询化验项目下的子项目
     * @param itemId
     * @return
     */
    public List<OilAssaySubItem> findOilAssaySubItemByItemId(int itemId);
    
    /**
    * 保存油水化验记录明细信息
    * @param itemId
    * @param recId
    */
    public void saveOilDetailRecorder(int itemId,long recId,String jcType);
    
    /**
     * 查询是否存在记录
     * @param itemId
     * @param recId
     * @return
     */
    public int findOilDetailRecorderCount(int itemId,long recId);
    
    /**
     * 查询化验记录明细信息
     * @param itemId
     * @param recId
     * @return
     */
    public List<Object[]> findOilDetailRecorder(int itemId, long recId);
    
    /**
     * 根据ID查询记录明细信息
     * @param recDetailId
     * @return
     */
    public OilAssayDetailRecorer findDetailRecorderById(long recDetailId);
    
    /**
     * 更新查询记录明细信息
     * @param detailRecorder
     */
    public void updateOilAssayDetailRecorer(OilAssayDetailRecorer detailRecorder);
    
    /**
     * 根据记录明细信息ID查询项目的最大和最小值
     * @param recDetailId
     * @return
     */
    public Object[] findMaxMinValue(long recDetailId);
    
    /**
     * 根据日计划ID查找油水化验记录
     * @param rjhmId
     * @return
     */
    public OilAssayPriRecorder findOilAssayRecByDailyId(Integer rjhmId);
     
}
