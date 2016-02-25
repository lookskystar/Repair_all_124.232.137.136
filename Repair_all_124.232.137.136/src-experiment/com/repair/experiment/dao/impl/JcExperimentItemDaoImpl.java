package com.repair.experiment.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.common.pojo.JcExperimentItem;
import com.repair.experiment.dao.JcExperimentItemDao;

public class JcExperimentItemDaoImpl extends HibernateDaoSupport implements
		JcExperimentItemDao {

	@Override
	public List<JcExperimentItem> findExperimentItemListByItemName(
			int parentId, String itemname) {
		String hql = "from JcExperimentItem as jei where jei.parentId=? and jei.itemName like '%"+itemname+"%'";
		return getHibernateTemplate().find(hql, new Object[]{parentId});
	}
	
	@SuppressWarnings("unchecked")
	public JcExperimentItem findExperimentItemByItemName(int parentId, String itemname) {
		String hql = "from JcExperimentItem as jei where jei.parentId=? and jei.itemName=?";
		List<JcExperimentItem> list = getHibernateTemplate().find(hql, new Object[]{parentId,itemname});
//		return list.get(0);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
	@Override
	public List<JcExperimentItem> findJcExperimentsByFlowIdAndJcType(
			int flowId, String jcType) {
		String hql = "from JcExperimentItem as jei where jei.nodeId.jcFlowId=? and jei.parentId=0 and jei.jcsType like '%"+jcType+"%'";
		return getHibernateTemplate().find(hql, flowId);
	}
	
	@Override
	public JcExperimentItem findExperimentItemById(long itemId) {
		return getHibernateTemplate().get(JcExperimentItem.class, itemId);
	}
	
	@Override
	public int findExperimentAllItemCount(int expId) {
		String hql = "from JcExperimentItem as jei where jei.parentId=?";
		List list = getHibernateTemplate().find(hql, expId);
		if(list != null && list.size()>0){
			return list.size();
		}
		return 0;
	}
}
