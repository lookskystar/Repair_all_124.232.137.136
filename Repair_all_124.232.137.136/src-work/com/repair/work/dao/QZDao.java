package com.repair.work.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JcQzZlPd;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;

/**
 * 增加秋整时所增加的类
* @ClassName: JCFixRecDao
* @Description: TODO 机车检修记录dao层
* @author 周云韬
* @version V1.0  
* @date 2015-10-13 下午7:44:05
 */
public interface QZDao {
	/**通过日计划ID和班组ID查询此班组 工人未检修完成数量*/
	public Long countUnFinish(int rjhid,long bzid);
	
	/**更新节点记录*/
	public void updateJcFlowRec(JCFlowRec rec);
	
	/**通过日计划ID和班组ID获得检修流程记录*/
	public JCFlowRec findJCFlowRec(int rjhid,long bzid);
	
	/**通过节点ID获得节点信息*/
	public JCFixflow findJCFixflow(int nodeid);
	
	/**通过检修记录ID获得检修记录对象*/
	public JCFixrec findJCFixrecById(int id);
	
	/**通过日计划Id查询油化实验原始项目数据表数据**/
	public OilAssayItem findOilAssayItemById(Integer rjhmId);
	
	/**通过日计划Id查询油化实验项目记录数据表数据，查询到属于该油下的对应的记录表数据**/
	public OilAssayPriRecorder findOilAssayPriRecorderById(Integer rjhmId);
	
	/**通过OilAssayPriRecorder表Id，查询对应的记录数据
	* oaprId为OilAssayPriRecorder表的主键Id
	* return OilAssayDetailRecorer集合
	* **/
	public List<OilAssayDetailRecorer> findOilAssayDetailRecorerById(long oaprId);
	
	/**
	 *  查询油水化验记录主表
	 *  retunr	OilAssayPriRecorder集合 
	 */
	public List<OilAssayPriRecorder> findAllOilAssayPriRecorder();
	
	/**
	 * 保存秋整机车质量评定对象
	 * @return void    
	 * @throws
	 */
	public void saveJcQzZlPd(JcQzZlPd zlpd);
}
