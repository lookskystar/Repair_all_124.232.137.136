package com.repair.kq.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.KQWorkTimeItem;
import com.repair.common.pojo.SystemParameter;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.dao.ProteamEntryDao;
import com.repair.kq.service.ProteamEntryService;

public class ProteamEntryServiceImpl implements ProteamEntryService {

	@Resource(name = "proteamEntryDao")
	private ProteamEntryDao proteamEntryDao;

	@Override
	public List<UsersPrivs> findUsersById(Long bzid) {
		return proteamEntryDao.findUsersById(bzid);
	}

	@Override
	public void saveProteamEntry(List<KQWorkTimeCount> workTimeCounts) {
		for (KQWorkTimeCount workTimeCount : workTimeCounts) {
			proteamEntryDao.saveProteamEntry(workTimeCount);
		}
	}

	@Override
	public void saveProteamEntry(KQWorkTimeCount workTimeCount) {
		proteamEntryDao.saveProteamEntry(workTimeCount);
	}

	@Override
	public int findRecordCount(Long bzid, String time) {
		return proteamEntryDao.findRecordCount(bzid, time);
	}

	@Override
	public SystemParameter findSystemParameter() {
		return proteamEntryDao.findSystemParameter();
	}

	@Override
	public List<KQWorkTimeCount> findWorkRecords(Long bzid, String time) {
		return proteamEntryDao.findWorkRecords(bzid, time);
	}

	@Override
	public void updateStatus(Long bzid, String time) {
		proteamEntryDao.updateStatus(bzid, time);
	}

	@Override
	public void updateRecord(KQWorkTimeCount record) {
		proteamEntryDao.updateRecord(record);
	}

	@Override
	public KQWorkTimeCount findRecord(Long id) {
		return proteamEntryDao.findRecord(id);
	}

	@Override
	public Integer countWorkRecords(Long bzid, String time) {
		return proteamEntryDao.countWorkRecords(bzid, time);
	}

	@Override
	public List<KQWorkTimeItem> findProteamItem(Long bzid) {
		return proteamEntryDao.findProteamItem(bzid);
	}

	@Override
	public UsersPrivs findUser(Long userId) {
		return proteamEntryDao.findUser(userId);
	}

	@Override
	public KQWorkTimeItem findWorkTimeItem(Long itemId) {
		return proteamEntryDao.findWorkTimeItem(itemId);
	}

	@Override
	public void saveKQUserItem(KQUserItem userItem) {
		proteamEntryDao.saveKQUserItem(userItem);
	}

	@Override
	public List<KQUserItem> findKQUserItems(String shiJian, Long itemId) {
		return proteamEntryDao.findKQUserItems(shiJian, itemId);
	}

	@Override
	public void deleteItemCharge(String shiJian, Long itemId) {
		proteamEntryDao.deleteItemCharge(shiJian, itemId);
	}

	@Override
	public Integer findChargeCount(String shiJian, Long itemId) {
		return proteamEntryDao.findChargeCount(shiJian, itemId);
	}

}
