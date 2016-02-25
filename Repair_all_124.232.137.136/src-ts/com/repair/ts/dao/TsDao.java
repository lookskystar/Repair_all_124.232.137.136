package com.repair.ts.dao;

import java.util.List;

import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.TsAtRecord;
import com.repair.common.pojo.TsUnit;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface TsDao {

	public void tsDepot(TsAtRecord tsAtRecord);

	public List<TsAtRecord> listDepot();

	public TsAtRecord findDepot(int id);

	public List findAllXc();

	public List<DictJcStype> findAllJcTypes();

	public List<TsAtRecord> listDepotRecord();

	public PageModel<TsAtRecord> listRecord(String btime, String etime);

	public List<UsersPrivs> listTsWorker();

	public List<TsUnit> listUnit(int bzid);
}
