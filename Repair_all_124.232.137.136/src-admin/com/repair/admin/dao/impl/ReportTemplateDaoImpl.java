package com.repair.admin.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.repair.admin.dao.ReportTemplateDao;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.ItemRelation;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;

public class ReportTemplateDaoImpl extends HibernateDaoSupport implements ReportTemplateDao{

	@Override
	public List<ItemRelation> listItemRelation(String jcType) {
		String hql = "from ItemRelation t where t.jcType like ? order by t.id";
		return getHibernateTemplate().find(hql,jcType);
	}

	@Override
	public List<JCFixitem> listJCFixitem(String jcType,Integer firstUnitId) {
		List<Object> param = new ArrayList<Object>();
		String hql = "from JCFixitem t where t.jcsType like ?";
		param.add("%"+jcType+",%");
		if(firstUnitId!=null){
			hql += " and t.firstUnitId=?";
			param.add(firstUnitId);
		}
		return getHibernateTemplate().find(hql, param.toArray());
	}
	
	@Override
	public List<DictJcStype> listDictSTypes() {
		return getHibernateTemplate().find("from DictJcStype");
	}

	@Override
	public void updateItemRelation(int id, String itemsIds) {
		String hql = "update ItemRelation t set t.itemIds=? where t.id=?";
		getSession().createQuery(hql).setString(0, itemsIds).setInteger(1, id).executeUpdate();
	}
	
	@Override
	public List<DictFirstUnit> listDictFirstUnits(String jctype) {
		return getHibernateTemplate().find("from  DictFirstUnit t where t.jcstypevalue like ?","%"+jctype+",%");
	}
	
	/**下面的方法用于前台报表生成查询**/
	

	/**
	 * 判断项目是否关联模板项目
	 */
	public Long countItemRelation(String jctype){
		String hql = "select count(*) from ItemRelation t where t.jcType like ? and t.itemIds is not null";
		return (Long)getHibernateTemplate().find(hql,jctype).get(0);
	}
	
	/**
	 * 查询模板项目中的一级部件
	 */
	public List listFirstUnitsOfTemplate(String jctype){
		String sql = "select distinct t.FIRSTUNITID as firstUnitId,t.FIRSTUNITNAME as firstUnitName from item_relation t where t.JCTYPE like ?";
		return getSession().createSQLQuery(sql).setString(0, "%"+jctype+"%").list();
	}
	
	/**
	 * 查询报表
	 * @param jctype 机车类型
	 * @param xcxc 修程修次
	 * @param rjhmId 日计划ID
	 */
	public List<ItemRelation> listItemRelation(String jctype,String xcxc,Integer firstUnitId){
		String hql = "from ItemRelation t where t.jcType=? and t.firstUnitId=? and t.xcxc like ?";
		return getHibernateTemplate().find(hql, new Object[]{jctype,firstUnitId,"%"+xcxc+",%"});
	}
	
	public List<JCFixrec> listJCFixrec(Integer rjhmId,String itemIds){
		String hql = "from JCFixrec t where t.datePlanPri.rjhmId=? and t.fixitem.thirdUnitId in ("+itemIds+")";
		return getHibernateTemplate().find(hql,rjhmId);
	}

}
