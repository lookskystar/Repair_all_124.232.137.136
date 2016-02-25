package com.repair.kq.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQEquip;
import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.kq.dao.MaintainDao;
import com.repair.kq.service.MaintainService;

public class MaintainServiceImpl implements MaintainService{
	
	@Resource(name="maintainDao")
	private MaintainDao maintainDao;

	@Override
	public List<KQEquip> getEquip() {
		return maintainDao.findAllEquip();
	}

	@Override
	public void saveKQEquip(KQEquip equip) {
		maintainDao.saveKQEquip(equip);
	}

	@Override
	public KQEquip queryEquipById(Long id) {
		return maintainDao.queryEquipById(id);
	}
	
	@Override
	public void saveOrUpdateEquip(KQEquip equip) {
		maintainDao.saveOrUpdateEquip(equip);
	}

	@Override
	public void deleteEquip(KQEquip equip) {
		maintainDao.deleteEquip(equip);
	}

	@Override
	public List<KQRule> getRuleInput() {
		return maintainDao.queryRule();
	}

	@Override
	public List<DictProTeam> findDictProTeam() {
		return maintainDao.findDictProTeam();
	}

	@Override
	public List<KQHoliday> getHolidayInput() {
		return maintainDao.queryHoliday();
	}

	@Override
	public void saveHoliday(List<KQHoliday> list) {
		for(KQHoliday holiday:list){
			maintainDao.saveOrUpdateKQHoliday(holiday);
		}
	}
	
	@Override
	public void saveSinHoliday(KQHoliday holiday){
		maintainDao.saveOrUpdateKQHoliday(holiday);
	}

	@Override
	public void deleteHoliday(KQHoliday holiday) {
		maintainDao.deleteHoliday(holiday);
	}

	@Override
	public KQHoliday queryHolidayById(Long id) {
		return maintainDao.queryHolidayById(id);
	}

	@Override
	public void saveOrUpdateHoliday(KQHoliday holiday) {
		maintainDao.saveOrUpdateHoliday(holiday);
	}

	@Override
	public void deleteRule(KQRule rule) {
		maintainDao.deleteRule(rule);
	}

	@Override
	public KQRule queryRuleById(Long id) {
		return maintainDao.queryRuleById(id);
	}

	public String saveRule(List<KQRule> list) {
		String result = "failure";
		for(KQRule rule:list){
			String bzid=rule.getBzid().substring(1);
			String[] bz = bzid.split(",");
			boolean flag=true;
			for(int i =0;i<bz.length;i++){
				List<KQRule> rules = maintainDao.isexist(bz[i]);
				if(rules!=null && rules.size()>0){
					flag= false;
					break;
				}
			}
			if(flag){
				maintainDao.saveOrUpdateKQRule(rule);
				result= "success";
			}else{
				result = "failure";
			}
		}
		return result;
	}
	
	

	@Override
	public String saveOrUpdateRule(KQRule rule,Long ruleId) {
		String bzid=rule.getBzid().substring(1);
		String[] bz = bzid.split(",");
		boolean flag=true;
		for(int i =0;i<bz.length;i++){
			String bzids = bz[i];
			List<KQRule> list = maintainDao.existence(ruleId, bzids);
			if(list!=null && list.size()>0){
				flag= false;
				break;
			}
		}
		String result = "failure";
		if(flag){
			maintainDao.saveOrUpdateRule(rule);
			result= "success";
		}else{
			result = "failure";
		}
		return result;
	}

	@Override
	public DictProTeam queryBzById(Long bzid) {
		return maintainDao.queryBzById(bzid);
	}
	
	@Override
	public List<KQWorkTimeItem> getworkTimeItems(Long proteamId,String itemName) {
		return maintainDao.findWorkTimeItems(proteamId,itemName);
	}
	
	@Override
	public List<DictProTeam> findWorkProTeam() {
		return maintainDao.findWorkProTeam();
	}

	@Override
	public void saveWorkTimeItem(KQWorkTimeItem workTimeItem) {
		maintainDao.saveWorkTimeItem(workTimeItem);
	}
	
	@Override
	public KQWorkTimeItem queryWorkTimeItemById(Long id) {
		return maintainDao.queryWorkTimeItemById(id);
	}
	
	@Override
	public void saveOrUpdateWorkTimeItem(KQWorkTimeItem workTimeItem) {
		maintainDao.saveOrUpdateWorkTimeItem(workTimeItem);
	}

	@Override
	public void delWorkTimeItem(KQWorkTimeItem workTimeItem) {
		maintainDao.delWorkTimeItem(workTimeItem);
	}

}
