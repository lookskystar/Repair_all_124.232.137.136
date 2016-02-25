package com.repair.ts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.TsAtRecord;
import com.repair.common.pojo.TsUnit;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.ts.dao.TsDao;
import com.repair.ts.service.TsService;

public class TsServiceImpl implements TsService {

	@Resource(name = "tsDao")
	private TsDao tsDao;

	public void saveDepot(TsAtRecord tsAtRecord) {
		tsDao.tsDepot(tsAtRecord);
	}

	public List<TsAtRecord> findDepot() {
		return tsDao.listDepot();
	}

	public TsAtRecord findDepotById(int id) {
		return tsDao.findDepot(id);
	}

	@Override
	public List<DictJcStype> findAllJcTypes() {
		return tsDao.findAllJcTypes();
	}

	@Override
	public List findAllXc() {
		return tsDao.findAllXc();
	}

	@Override
	public List<TsAtRecord> findDepotRecord() {
		return tsDao.listDepotRecord();
	}

	@Override
	public PageModel<TsAtRecord> findRecord(String btime, String etime) {
		return tsDao.listRecord(btime, etime);
	}

	@Override
	public List<UsersPrivs> findAllTsWorker() {
		return tsDao.listTsWorker();
	}

	@Override
	public List<TsUnit> findAllUnit(int bzid) {
		return tsDao.listUnit(bzid);
	}

}
