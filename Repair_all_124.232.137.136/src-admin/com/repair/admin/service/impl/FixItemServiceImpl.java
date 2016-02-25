package com.repair.admin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.admin.dao.FixItemDao;
import com.repair.admin.service.FixItemService;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.util.PageModel;

public class FixItemServiceImpl implements FixItemService {
	@Resource(name="fixItemDao")
	private FixItemDao fixItemDao;

	@Override
	public PageModel<JCFixitem> findJcFixItem(String jcsType,Integer first,Integer second,Long teamId,String itemName,int itemType) {
		return fixItemDao.findJcFixItem(jcsType,first,second,teamId,itemName,itemType);
	}

	@Override
	public List<DictFirstUnit> findDictFirstUnit(String jcsType) {
		return fixItemDao.findDictFirstUnit(jcsType);
	}

	@Override
	public List<DictSecunit> findDictSecunit(Long firstUnitId) {
		return fixItemDao.findDictSecunit(firstUnitId);
	}

	@Override
	public List<DictProTeam> findDictProTeam() {
		return fixItemDao.findDictProTeam();
	}

	@Override
	public List<DictJcStype> findDictJcStype() {
		return fixItemDao.findDictJcStype();
	}

	@Override
	public List<JCFixflow> findJCFixflow() {
		return fixItemDao.findJCFixflow();
	}
	
	@Override
	public JCFixitem findJCFixitemById(int thirdUnitId) {
		return fixItemDao.findJCFixitemById(thirdUnitId);
	}

	@Override
	public void saveOrUpdateFixItem(JCFixitem fixItem) {
		fixItemDao.saveOrUpdateFixItem(fixItem);
	}

	@Override
	public void deleteItemInfo(String[] itemArray) {
		for (int i = 0; i < itemArray.length; i++) {
			fixItemDao.deleteItemInfo(Integer.parseInt(itemArray[i]));
		}
	}

	@Override
	public PageModel<JCZXFixItem> findJcZxFixItem(String jcsType,
			Integer first, Long teamId,
			String itemName,int itemType) {
		return fixItemDao.findJcZxFixItem(jcsType, first, teamId, itemName,itemType);
	}

	@Override
	public void deleteZxItemInfo(String[] itemArray) {
		for (int i = 0; i < itemArray.length; i++) {
			fixItemDao.deleteZxItemInfo(Integer.parseInt(itemArray[i]));
		}
	}

	@Override
	public JCZXFixItem findJCZXFixItemById(int Id) {
		return fixItemDao.findJCZXFixItemById(Id);
	}

	@Override
	public List<PJStaticInfo> listPJStaticInfo() {
		return fixItemDao.listPJStaticInfo();
	}

	@Override
	public void updateZxFixItem(JCZXFixItem zxfixItem) {
		fixItemDao.updateZxFixItem(zxfixItem);
		
	}

	@Override
	public void saveZxFixItem(JCZXFixItem zxfixItem) {
		fixItemDao.saveZxFixItem(zxfixItem);
		
	}

	
}
