package com.repair.work.dao.impl;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.pojo.OilAssaySubItem;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.work.dao.OilAssayDao;

/**
 * 油水化验实现类
 * @author Administrator
 *
 */
public class OilAssayDaoImpl extends AbstractDao implements OilAssayDao {

	//查询日计划表，根据计划状态值，和小辅修计划标识，查询
	@Override
	public List<DatePlanPri> findAssayJcs() {
		String hql="from DatePlanPri dpp where dpp.planStatue=0 and dpp.projectType=?";
		return getHibernateTemplate().find(hql,Contains.XX_PROJECT_TYPE);
	}

	//查询机车油水化记录主表，按时间降序查询
	@Override
	public List<OilAssayPriRecorder> findOilAssayPriRecorderAll() {
		return getHibernateTemplate().find("from OilAssayPriRecorder as recorder order by recorder.recesamTime desc");
	}

	//保存机车油水化记录
	@Override
	public void saveOilAssayPriRecorder(OilAssayPriRecorder recorder) {
		getHibernateTemplate().save(recorder);
	}
    //通过日计划id查找日计划
	@Override
	public DatePlanPri findDatePlanPriById(int dpId) {
		return getHibernateTemplate().get(DatePlanPri.class, dpId);
	}

	//通过ID查找油水化记录主表
	@Override
	public OilAssayPriRecorder findOilAssayPriRecorderById(long recId) {
		return getHibernateTemplate().get(OilAssayPriRecorder.class, recId);
	}
	//修改油水化主表
	@Override
	public void updateOilAssayPriRecorder(OilAssayPriRecorder recorder) {
		getHibernateTemplate().update(recorder);
	}
	//通过机车类型查找机车油水化项目表
	@Override
	public List<OilAssayItem> findOilAssayItemByJcType(String jcType) {
		return getHibernateTemplate().find("from OilAssayItem item where item.isused=1 and item.jcValue like ? order by item.series","%"+jcType+"、%");
	}

	//通过项目ID查找机车油水项目
	@Override
	public List<OilAssaySubItem> findOilAssaySubItemByItemId(int itemId) {
		String hql="from OilAssaySubItem subItem where subItem.reportItemId.reportItemId=? and subItem.isused=1 order by subItem.frequency";
		return getHibernateTemplate().find(hql,itemId);
	}
    //保存机车油水化记录明细表
	@Override
	public void saveOilDetailRecorder(int itemId,long recId,String jcType) {
		//String hql="insert into OilAssayDetailRecorer as detail(detail.recPriId.recPriId,detail.subItemId.subItemId,detail.subItemTitle) " +
				//"select ?,sub.subItemId,sub.subItemTitle from OilAssaySubItem sub where sub.reportItemId.reportItemId=?";
		String sql="insert into oil_assay_detailrecorer(recdetailid,recpriid,subitemid,subitemtitle) " +
				"select SEQ_OIL_DETAIL_RECORDER_ID.nextval,?,subitemid,subitemtitle from oil_assay_subitem where reportitemid=? and JCSTYPEVAL like ?";
		getSession().createSQLQuery(sql).setLong(0,recId).setInteger(1, itemId).setString(2, "%"+jcType+"、%").executeUpdate();
	}
	//通过项目ID和主表记录ID，查找机车油水化记录明细表，统计记录数
	@Override
	public int findOilDetailRecorderCount(int itemId, long recId) {
		String sql="select detail.* from oil_assay_detailrecorer detail,oil_assay_subitem sub where detail.subitemid=sub.subitemid and detail.recpriid=? and sub.reportitemid=?";
		List list=getSession().createSQLQuery(sql).setLong(0,recId).setInteger(1, itemId).list();
		if(list!=null&&list.size()>0){
			return list.size();
		}
		return 0;
	}
	//通过项目ID和主表记录ID，查找机车油水化记录明细表
	@Override
	public List<Object[]> findOilDetailRecorder(int itemId, long recId) {
		String sql="select detail.recdetailid,detail.subitemtitle,sub.minval,sub.maxval,detail.realdeteval,detail.quagrade,detail.receiptpeo,detail.fintime from oil_assay_detailrecorer detail,oil_assay_subitem sub where detail.subitemid=sub.subitemid and detail.recpriid=? and sub.reportitemid=?";
		List<Object[]> list=getSession().createSQLQuery(sql).setLong(0,recId).setInteger(1, itemId).list();
		return list;
	}

	@Override
	public OilAssayDetailRecorer findDetailRecorderById(long recDetailId) {
		return getHibernateTemplate().get(OilAssayDetailRecorer.class, recDetailId);
	}

	@Override
	public void updateOilAssayDetailRecorer(OilAssayDetailRecorer detailRecorder) {
		getHibernateTemplate().update(detailRecorder);
	}

	@Override
	public Object[] findMaxMinValue(long recDetailId) {
		String sql="select sub.minval,sub.maxval from oil_assay_detailrecorer detail,oil_assay_subitem sub where detail.subitemid=sub.subitemid and detail.recdetailid=?";
		List<Object[]> list=getSession().createSQLQuery(sql).setLong(0,recDetailId).list();
		if(list!=null&&list.size()>0){
			return (Object[])list.get(0);
		}
		return null;
	}

	@Override
	public OilAssayPriRecorder findOilAssayRecByDailyId(Integer rjhmId) {
		String hql = "from OilAssayPriRecorder as oapr where oapr.dpId=?";
		return (OilAssayPriRecorder) getSession().createQuery(hql).setInteger(0, rjhmId).uniqueResult();
	}
	
}
