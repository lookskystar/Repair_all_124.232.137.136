package com.repair.ts.service;

import java.util.List;

import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.TsAtRecord;
import com.repair.common.pojo.TsUnit;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface TsService {
	/**
	 * 新报活
	 * */
	public void saveDepot(TsAtRecord tsAtRecord);

	/**
	 * 查询所有报活
	 * */
	public List<TsAtRecord> findDepot();

	/**
	 * 根据id查询报活
	 * */
	public TsAtRecord findDepotById(int id);

	/**
	 * 查询修程
	 * */
	public List findAllXc();

	/**
	 * 查询所有车型
	 * */
	public List<DictJcStype> findAllJcTypes();

	/**
	 * 查询已派工报活
	 * */
	public List<TsAtRecord> findDepotRecord();

	/**
	 * 查询报活记录
	 * */
	public PageModel<TsAtRecord> findRecord(String btime, String etime);

	/**
	 * 查询探伤组成员
	 * */
	public List<UsersPrivs> findAllTsWorker();

	/**
	 * 查询登陆者所在班组关联部件
	 * */
	public List<TsUnit> findAllUnit(int bzid);
}
