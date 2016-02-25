package com.repair.query.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.TrainFault;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.PageModel;
import com.repair.common.util.PropertyUtil;
import com.repair.query.dao.TeachManageDao;

public class TeachManageDaoImpl extends AbstractDao implements TeachManageDao{
	
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<DatePlanPri> techManage(String type, String dateStart, String dateEnd, String jcNum) {
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.kcsj < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ dateEnd +"'");
		}
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcNum);
		}
		if(type != null && !type.equals("")){
			builder.append(" and t.fixFreque =?");
			params.add(type);
		}else{
			builder.append(" and t.fixFreque ='LX' or t.fixFreque ='JG'");
		}
		builder.append(" order by t.kcsj");
		return findPageModel(builder.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public PageModel<DatePlanPri> superFix(String dateStart, String dateEnd, String jcNum) {
		String proteamid = PropertyUtil.getResourceByKey("dispatch");
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.kcsj < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ dateEnd +"'");
		}
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcNum);
		}
		builder.append(" and t.rjhmId in(select jt.datePlanPri.rjhmId  from JtPreDict jt where jt.proTeamId.proteamid=?)");
		if(!"".equals(proteamid)){
			params.add(Long.parseLong(proteamid));
		}
		return findPageModel(builder.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<DatePlanPri> zoreAnalyse(String dateStart, String dateEnd, String jcNum) {
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where t.rjhmId in(select jt.datePlanPri.rjhmId from JtPreDict jt where jt.type=6)");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.kcsj < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ dateEnd +"'");
		}
		if(jcNum != null && !jcNum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcNum);
		}
		return findPageModel(builder.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public PageModel<JtPreDict> zoreRecord(String isTem, Integer id, String dateStart, String dateEnd){
		StringBuilder builder=new StringBuilder();
		if(isTem.equals("tem")){
			builder.append("from JtPreDict t where 1=1");
		}else{
			builder.append("from JtPreDict t where t.type=6");
		}
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.repTime > '"+ dateStart +"' and t.repTime < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.repTime < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.repTime > '"+ dateStart +"' and t.repTime < '"+ dateEnd +"'");
		}
		if(id != null && !id.equals("")){
			builder.append(" and t.datePlanPri.rjhmId=?");
			params.add(Integer.valueOf(id));
		}
		return findPageModel(builder.toString(),params.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageModel<DatePlanPri> fixIndexMainten(String jctype, String jcnum, String dateStart, String dateEnd) {
		StringBuilder builder=new StringBuilder();
		builder.append("from DatePlanPri t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.kcsj < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.kcsj > '"+ dateStart +"' and t.kcsj < '"+ dateEnd +"'");
		}
		if(jctype != null && !jctype.equals("")){
			builder.append(" and t.jcType=?");
			params.add(jctype);
		}
		if(jcnum != null && !jcnum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcnum);
		}
		return findPageModel(builder.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<JtPreDict> preInfoRecord(String type, String yjbj, String ejbj,String jctype, String jcnum, String dateStart, String dateEnd) {
		StringBuilder builder=new StringBuilder();
		builder.append("from JtPreDict t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.repTime > '"+ dateStart +"' and t.repTime < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.repTime < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.repTime > '"+ dateStart +"' and t.repTime < '"+ dateEnd +"'");
		}
		if(type != null && !type.equals("")){
			builder.append(" and t.type=?");
			params.add(Short.valueOf(type));
		}
		if(ejbj != null && !ejbj.equals("")){
			builder.append(" and t.repPosi like '%"+ ejbj +"%'");
		}
		if(jctype != null && !jctype.equals("")){
			builder.append(" and t.jcType=?");
			params.add(jctype);
		}
		if(jcnum != null && !jcnum.equals("")){
			builder.append(" and t.jcNum=?");
			params.add(jcnum);
		}
		return findPageModel(builder.toString(),params.toArray());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageModel<TrainFault> trainFaultList(String jcType , String jcnum, String dateStart, String dateEnd) {
		StringBuilder builder=new StringBuilder();
		builder.append("from TrainFault t where 1=1");
		List<Object> params=new ArrayList<Object>();
		if(dateStart != null && !dateStart.equals("") && dateEnd.equals("")){
			builder.append(" and t.faultDate > '"+ dateStart +"' and t.faultDate < '"+ YMDHMS_SDFORMAT.format(new Date()) +"'");
		}
		if(dateEnd != null && !dateEnd.equals("") && dateStart.equals("")){
			builder.append(" and t.faultDate < '"+ dateEnd +"'");
		}
		if(dateStart != null && !dateStart.equals("") && dateEnd != null && !dateEnd.equals("")){
			builder.append(" and t.faultDate > '"+ dateStart +"' and t.faultDate < '"+ dateEnd +"'");
		}
		if(jcType != null && !jcType.equals("")){
			builder.append(" and t.jctype=?");
			params.add(jcType);
		}
		if(jcnum != null && !jcnum.equals("")){
			builder.append(" and t.jcnum=?");
			params.add(jcnum);
		}
		return findPageModel(builder.toString(),params.toArray());
	}

	@Override
	public void saveTrainFault(TrainFault trainFault) {
		this.getHibernateTemplate().saveOrUpdate(trainFault);
	}
	
	public TrainFault queryTrainFaultById(Integer id){
		return this.getHibernateTemplate().get(TrainFault.class, id);
	}

	@Override
	public void deleteTrainFault(TrainFault trainFault) {
		this.getHibernateTemplate().delete(trainFault);
	}
}
