package com.repair.admin.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.repair.admin.dao.ReportTemplateDao;
import com.repair.admin.service.ReportTemplateService;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.ItemRelation;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.util.StringUtil;

public class ReportTemplateServiceImpl implements ReportTemplateService{
	@Resource(name="reportTemplateDao")
	private ReportTemplateDao reportTemplateDao;
	
	public List<ItemRelation> listItemRelation(String jcType) {
		return reportTemplateDao.listItemRelation(jcType);
	}

	public List<JCFixitem> listJCFixitem(String jcType,Integer firstUnitId) {
		return reportTemplateDao.listJCFixitem(jcType,firstUnitId);
	}
	
	public List<DictJcStype> listDictSTypes(){
		return reportTemplateDao.listDictSTypes();
	}

	public void updateItemRelation(int id, String itemsIds) {
		reportTemplateDao.updateItemRelation(id, itemsIds);
	}
	
	public List<DictFirstUnit> listDictFirstUnits(String jctype){
		return reportTemplateDao.listDictFirstUnits(jctype);
	}
	
	/**
	 * 判断项目是否关联模板项目
	 */
	public Long countItemRelation(String jctype){
		return reportTemplateDao.countItemRelation(jctype);
	}
	
	@Override
	public List<DictFirstUnit> listFirstUnitsOfTemplate(String jctype) {
		List<DictFirstUnit> units = new ArrayList<DictFirstUnit>();
		DictFirstUnit firstUnit = null;
		
		List list = reportTemplateDao.listFirstUnitsOfTemplate(jctype);
		for (int i = 0; i < list.size(); i++) {
			Object[] it = (Object[])list.get(i);
			firstUnit = new DictFirstUnit();
			firstUnit.setFirstunitid(Long.parseLong(it[0]+""));
			firstUnit.setFirstunitname(it[1]+"");
			units.add(firstUnit);
		}
		return units;
	}
	
	@Override
	public List<ItemRelation> listItemRelation(String jctype, String xcxc,Integer firstUnitId,
			Integer rjhmId) {
		List<ItemRelation> itemRelations = reportTemplateDao.listItemRelation(jctype, xcxc, firstUnitId);
		String ids = "";
		for (ItemRelation itr : itemRelations) {
			try{
				ids  = itr.getItemIds();
				if(ids!=null && !"".equals(ids) && ids.split(",").length>0){
					String[] result = dealString(reportTemplateDao.listJCFixrec(rjhmId,ids));
					itr.setFixSituation(result[0]);
					itr.setFixEmp(result[1]);
					itr.setLead(result[2]);
					itr.setQi(result[3]);
					itr.setTech(result[4]);
					itr.setCommitLead(result[5]);
					itr.setAccepter(result[6]);
				}
			}catch(Exception e){
				e.printStackTrace();
				continue;
			}
		}
		return itemRelations;
	}
	
	/**
	 * 处理字符串
	 */
	private String[] dealString(List<JCFixrec> fixrecs){
		String[] result = new String[7];
		String fixSituation ="",fixEmp ="",lead="",qi="",tech="",commitLead="",accepter=""; 
		for (JCFixrec rec : fixrecs) {
			fixSituation = StringUtil.addString(fixSituation, rec.getFixSituation());
			fixEmp = StringUtil.addString(fixEmp,rec.getFixEmp());
			lead = StringUtil.addString(lead, rec.getLead());
			qi = StringUtil.addString(qi,rec.getQi());
			tech = StringUtil.addString(tech,rec.getTech());
			commitLead = StringUtil.addString(commitLead,rec.getCommitLead());
			accepter = StringUtil.addString(accepter,rec.getAccepter());
		}
		result[0] = fixSituation;
		result[1] = fixEmp;
		result[2] = lead;
		result[3] = qi;
		result[4] = tech;
		result[5] = commitLead;
		result[6] = accepter;
		return result;
	}
}
