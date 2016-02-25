package com.repair.admin.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.admin.dao.FixItemDao;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;

/**
 * 检修项目实现类
 * @author Administrator
 *
 */
public class FixItemDaoImpl extends AbstractDao implements FixItemDao {

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<JCFixitem> findJcFixItem(String jcsType,Integer first,Integer second,Long teamId,String itemName,int itemType) {
		StringBuilder builder=new StringBuilder();
		builder.append("from JCFixitem t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(jcsType!=null&&!jcsType.equals("")){
			builder.append(" and t.jcsType like ?");
			params.add("%"+jcsType+",%");
		}
		if(first!=null&&!first.equals("")){
			builder.append(" and t.firstUnitId=?");
			params.add(first);
		}
		if(second!=null&&!second.equals("")){
			builder.append(" and t.secUnitId=?");
			params.add(second);
		}
		if(teamId!=null&&!teamId.equals("")){
			builder.append(" and t.banzuId.proteamid=?");
			params.add(teamId);
		}
		if(itemName!=null&&!itemName.equals("")){
			builder.append(" and t.itemName like ?");
			params.add("%"+itemName+"%");
		}
		if(itemType==1){
			builder.append(" and t.fillDefaVal is not null");
		}
		if(itemType==2){
			builder.append(" and t.fillDefaVal is null");
		}
		builder.append(" order by t.banzuId.proteamid, t.thirdUnitId");
		return findPageModel(builder.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictFirstUnit> findDictFirstUnit(String jcsType) {
		String hql="from DictFirstUnit where jcstypevalue like ?";
		return getHibernateTemplate().find(hql,"%"+jcsType+",%");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictSecunit> findDictSecunit(Long firstUnitId) {
		String hql="from DictSecunit t where t.dictFirstunit.firstunitid=?";
		return getHibernateTemplate().find(hql,firstUnitId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictProTeam> findDictProTeam() {
		return getHibernateTemplate().find("from DictProTeam where workflag=1 or zxFlag=1");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DictJcStype> findDictJcStype() {
		return getHibernateTemplate().find("from DictJcStype");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JCFixflow> findJCFixflow() {
		return getHibernateTemplate().find("from JCFixflow");
	}

	@Override
	public JCFixitem findJCFixitemById(int thirdUnitId) {
		return getHibernateTemplate().get(JCFixitem.class, thirdUnitId);
	}

	@Override
	public void saveOrUpdateFixItem(JCFixitem fixItem) {
		getHibernateTemplate().saveOrUpdate(fixItem);
	}

	@Override
	public void deleteItemInfo(int itemid) {
		String hql = "delete from JCFixitem j where j.thirdUnitId=?";
		getSession().createQuery(hql).setInteger(0, itemid).executeUpdate();
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PJStaticInfo> listPJStaticInfo() {
		return getHibernateTemplate().find("from  PJStaticInfo t");
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<JCZXFixItem> findJcZxFixItem(String jcsType,
			Integer first, Long teamId,
			String itemName,int itemType) {
		StringBuilder builder=new StringBuilder();
		builder.append("from JCZXFixItem t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(jcsType!=null&&!jcsType.equals("")){
			builder.append(" and t.jcsType like ?");
			params.add("%"+jcsType+",%");
		}
		if(first!=null&&!first.equals("")){
			builder.append(" and t.firstUnitId=?");
			params.add(first);
		}
		if(teamId!=null&&!teamId.equals("")){
			builder.append(" and t.bzId.proteamid=?");
			params.add(teamId);
		}
		if(itemName!=null&&!itemName.equals("")){
			builder.append(" and t.itemName like ?");
			params.add("%"+itemName+"%");
		}
		if(itemType==1){
			builder.append(" and t.fillDefaval is not null");
		}
		if(itemType==2){
			builder.append(" and t.fillDefaval is null");
		}
		builder.append(" order by t.bzId.proteamid, t.id");
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void deleteZxItemInfo(int itemid) {
		String hql = "delete from JCZXFixItem j where j.id=?";
		getSession().createQuery(hql).setInteger(0, itemid).executeUpdate();
		
	}

	@Override
	public JCZXFixItem findJCZXFixItemById(int Id) {
		return getHibernateTemplate().get(JCZXFixItem.class, Id);
	}

	@Override
	public void updateZxFixItem(JCZXFixItem zxfixItem) {
		getHibernateTemplate().update(zxfixItem);
		
	}

	@Override
	public void saveZxFixItem(JCZXFixItem zxfixItem) {
		getHibernateTemplate().save(zxfixItem);
		
	}

	

	

}
