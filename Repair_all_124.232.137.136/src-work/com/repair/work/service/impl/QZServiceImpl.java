package com.repair.work.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JcQzZlPd;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.work.dao.QZDao;
import com.repair.work.service.QZService;

/**
 * 增加秋整时所增加的类
* @ClassName: QZServiceImpl
* @Description: TODO 机车检修记录dao层
* @author 周云韬
* @version V1.0  
* @date 2015-10-13 下午7:44:05
 */
@Repository("qzService")
public class QZServiceImpl implements QZService{
	@Resource(name="qzDao")
	private QZDao qzDao;
	
	/**通过检修记录ID获得检修记录对象*/
	public JCFixrec findJCFixrecById(int id){
		return qzDao.findJCFixrecById( id);
	}
	
	public Long countUnFinish(int rjhid,long bzid){
		return qzDao.countUnFinish(rjhid, bzid);
	}
	
	public void updateJcFlowRec(JCFlowRec rec){
		qzDao.updateJcFlowRec(rec);
	}
	
	public JCFlowRec findJCFlowRec(int rjhid,long bzid){
		return qzDao.findJCFlowRec(rjhid, bzid);
	}
	
	public JCFixflow findJCFixflow(int nodeid){
		return qzDao.findJCFixflow(nodeid);
	}
	
	
	
	
	/**
	 * 通过日计划Id查询油化实验原始项目数据表数据
	 */
	@Override
	public OilAssayItem findOilAssayItemById(Integer rjhmId) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 通过日计划Id查询油化实验项目记录数据表数据，查询到属于该油下的对应的记录表数据
	 */
	@Override
	public OilAssayPriRecorder findOilAssayPriRecorderById(Integer rjhmId) {
		// TODO Auto-generated method stub
		return qzDao.findOilAssayPriRecorderById(rjhmId);
	}

	/**
	 * 通过OilAssayPriRecorder表Id，查询对应的记录数据 oaprId为OilAssayPriRecorder表的主键Id
	 *  return OilAssayDetailRecorer集合
	 */
	@Override
	public List<OilAssayDetailRecorer> findOilAssayDetailRecorerById(
			long oaprId) {
		// TODO Auto-generated method stub
		return qzDao.findOilAssayDetailRecorerById(oaprId);
	}
	
	/**
	 * 查询油水化验记录主表
	 */
	@Override
	public List<OilAssayPriRecorder> findAllOilAssayPriRecorder() {
		// TODO Auto-generated method stub
		return qzDao.findAllOilAssayPriRecorder();
	}
	
	/**
	 * 保存秋整机车质量评定对象
	 * @return void    
	 * @throws
	 */
	public void saveJcQzZlPd(JcQzZlPd zlpd){
		qzDao.saveJcQzZlPd(zlpd);
		
	}
}
