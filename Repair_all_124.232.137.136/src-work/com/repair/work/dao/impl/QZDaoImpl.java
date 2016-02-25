package com.repair.work.dao.impl;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JcQzZlPd;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.util.AbstractDao;
import com.repair.work.dao.QZDao;


/**
 * 增加秋整时所增加的类
* @ClassName: QZDaoImpl
* @Description: TODO 增加秋整时所用到的dao层
* @author 周云韬
* @version V1.0  
* @date 2015-10-13 下午7:44:05
 */
public class QZDaoImpl extends AbstractDao implements QZDao{
	/**通过检修记录ID获得检修记录对象*/
	public JCFixrec findJCFixrecById(int id){
		return getHibernateTemplate().get(JCFixrec.class, id);
	}
	/**
	 * 获取检修工人未完成的检修项目个数
	 */
	public Long countUnFinish(int rjhid,long bzid){
		String hql="select count(*) from JCFixrec where fixEmp is null and datePlanPri.rjhmId=? and banzuId=?";
		return (Long)getHibernateTemplate().find(hql,rjhid,bzid).get(0);
	}
	
	public void updateJcFlowRec(JCFlowRec rec){
		getHibernateTemplate().update(rec);
	}
	
	public JCFlowRec findJCFlowRec(int rjhid,long bzid){
		String hql="from JCFlowRec where datePlanPri.rjhmId=? and proTeam.proteamid=?";
		List<JCFlowRec> list=getHibernateTemplate().find(hql,rjhid,bzid);
		return list.size() == 0 ? null :list.get(0);
	}
	
	public JCFixflow findJCFixflow(int nodeid){
		String hql="from JCFixflow where jcFlowId=?";
		List<JCFixflow> list=getHibernateTemplate().find(hql,nodeid);
		return list.size() == 0 ? null :list.get(0);
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
	@SuppressWarnings("unchecked")
	
	public OilAssayPriRecorder findOilAssayPriRecorderById(Integer rjhmId) {
		// TODO Auto-generated method stub
		String hql="from OilAssayPriRecorder pr where pr.dpId.rjhmId=? ";
		List<OilAssayPriRecorder> list=getHibernateTemplate().find(hql, new Object[]{rjhmId});
		
		OilAssayPriRecorder recorder=null;
		if(list.size()>0)
		{
			recorder=list.get(0);
		}
		return recorder;
	}
	
	/**通过OilAssayPriRecorder表Id，查询对应的记录数据
	* oaprId为OilAssayPriRecorder表的主键Id
	* return OilAssayDetailRecorer集合
	* **/
	@SuppressWarnings("unchecked")
	@Override
	public List<OilAssayDetailRecorer> findOilAssayDetailRecorerById(long oaprId) {
		// TODO Auto-generated method stub
		String hql="from OilAssayDetailRecorer dr where dr.recPriId.recPriId=?";
		List<OilAssayDetailRecorer> list=getHibernateTemplate().find(hql, new Object[]{oaprId}); 
		return list;
	}
	
	/**
	 * 查询油水化验记录主表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<OilAssayPriRecorder> findAllOilAssayPriRecorder() {
		// TODO Auto-generated method stub
		List<OilAssayPriRecorder> list=getHibernateTemplate().find("from OilAssayPriRecorder"); 
		return list;
	}
	
	
	
	/**
	 * 保存秋整机车质量评定对象
	 * @return void    
	 * @throws
	 */
	public void saveJcQzZlPd(JcQzZlPd zlpd){
		getHibernateTemplate().save(zlpd);
	}

}

