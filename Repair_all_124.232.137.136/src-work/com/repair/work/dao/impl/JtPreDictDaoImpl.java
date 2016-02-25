package com.repair.work.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.AbstractDao;
import com.repair.common.util.Contains;
import com.repair.work.dao.JtPreDictDao;

public class JtPreDictDaoImpl extends AbstractDao implements JtPreDictDao{
	
	/**
	 * 根据日计划和班组获取报活项目
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<JtPreDict> getJtPreDict(Integer rjhmId,Long bzId){
		String hql = "from JtPreDict t where t.recStas=1 and t.type=3 and t.proTeamId.proteamid=? and t.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql, new Object[]{bzId,rjhmId});
	}
	
	public List<JtPreDict> findMyReportJtPreDict(Integer rjhmId,String gonghao){
		String hql = "from JtPreDict t where t.type!=3 and t.repempNo=? and t.datePlanPri.rjhmId=?";
		return getHibernateTemplate().find(hql, new Object[]{gonghao,rjhmId});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId, Short type) {
		return getHibernateTemplate().find("from JtPreDict t where t.type=? and t.recStas between 0 and 1 and t.smpPreDictId is null and t.datePlanPri.rjhmId=?", type, rjhmId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId) {
		return getHibernateTemplate().find("from JtPreDict t where t.recStas != -1 and t.type != 3 and t.datePlanPri.rjhmId=? order by t.type asc, t.preDictId desc,t.recStas asc", rjhmId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId,
			Long proteamid, Short status) {
		if (null != proteamid) {
			return getHibernateTemplate().find("from JtPreDict jpd where jpd.recStas between 0 and ? and jpd.type!=3 and jpd.proTeamId.proteamid=? and jpd.datePlanPri.rjhmId=?", status, proteamid, rjhmId);
		} else {
			return getHibernateTemplate().find("from JtPreDict jpd where jpd.recStas between 0 and ? and jpd.type!=3 and jpd.smpPreDictId is null and jpd.datePlanPri.rjhmId=?", status, rjhmId);
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JtPreDict> findJtPreDictSignItemByDatePlan(Integer rjhmId,
			Long proteamid) {
		return getHibernateTemplate().find("from JtPreDict jpd where jpd.recStas between 1 and 9 and jpd.type!=3 and jpd.proTeamId.proteamid=? and jpd.datePlanPri.rjhmId=? order by jpd.recStas", proteamid, rjhmId);
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> findSmJtPreDicts(Integer preDictId){
		return getHibernateTemplate().find("from JtPreDict jpd where jpd.smpPreDictId=?",preDictId);
	}

	@Override
	public void saveOrUpdate(JtPreDict preDict) {
		getHibernateTemplate().saveOrUpdate(preDict);
	}

	@Override
	public void delete(final Integer[] preDictIds) {
		getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("delete from JtPreDict where preDictId in (:preDictIds)");
				query.setParameterList("preDictIds", preDictIds);
				return query.executeUpdate();
			}
		});
	}

	@Override
	public JtPreDict findJtPreDictById(Integer preDictId) {
		return getHibernateTemplate().get(JtPreDict.class, preDictId);
	}
	
	@Override
	public void deleteSmJtPreDict(Integer preDictId) {
		String hql = "delete from JtPreDict t where t.smpPreDictId=?";
		getSession().createQuery(hql).setInteger(0, preDictId).executeUpdate();
		
	}

	@Override
	public boolean isJtPreDictDispatchingByDatePlan(final DatePlanPri datePlanPri) {
		return getHibernateTemplate().execute(new HibernateCallback<Boolean>() {

			@Override
			public Boolean doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("select count(*) from JtPreDict as jpd where jpd.type=3 and jpd.datePlanPri=:datePlanPri");
				query.setEntity("datePlanPri", datePlanPri);
				Long result = (Long) query.uniqueResult();
				if (result == 0) {
					return false;
				}
				
				query = session.createQuery("select count(*) from JtPreDict as jpd where jpd.proTeamId is null and jpd.type=3 and jpd.datePlanPri=:datePlanPri");
				query.setEntity("datePlanPri", datePlanPri);
				result = (Long) query.uniqueResult();
				if (result > 0) {
					return false;
				}
				return true;
			}
		});
	}
	
	public JtPreDict getJtPreDictById(int recId){
		return getHibernateTemplate().get(JtPreDict.class, recId);
	}
	
	public void updateJtPreDictFixEmp(int recId, String workersId,String workersName){
		String hql = "update JtPreDict t set t.fixEmpId=:fixEmpId,t.fixEmp=:fixEmp,t.recStas=2 where t.preDictId=:preDictId";
		getSession().createQuery(hql).setString("fixEmpId", workersId).setString("fixEmp", workersName).setInteger("preDictId", recId).executeUpdate();
	}
	
	/**
	 * 查询我的派工
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 */
	@SuppressWarnings("unchecked")
	public List<DatePlanPri> listMyJtPreDict(long userid,Short type){
		String hql = "select distinct jpd.datePlanPri from JtPreDict jpd where jpd.datePlanPri.planStatue=0 and jpd.fixEmpId like '%,'||?||',%' ";
		if(type==Contains.LX_JG_TYPE){//临修加改
			hql += " and jpd.type=?";
		}else{//非临修加改---报活
			hql += " and jpd.type<>?";
		}
		return getHibernateTemplate().find(hql, new Object[]{userid,type});
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listMyJtPreDict(int rjhmId,UsersPrivs user,Short type,Integer signFlag,boolean flag){
		String hql = null;
		if(flag){
			hql = "from JtPreDict jpd where  jpd.fixEmpId like '%,'||?||',%' and jpd.datePlanPri.rjhmId=?";
		}else{
			hql = "from JtPreDict jpd where  jpd.fixEmpId not like '%,'||?||',%' and jpd.proTeamId.proteamid="+user.getBzid()+" and jpd.datePlanPri.rjhmId=?";
		}
		if(signFlag==0){
			hql += " and (jpd.dealFixEmp not like '%,"+user.getXm()+",%' or jpd.dealFixEmp is null)";
		}
		if(type== Contains.LX_JG_TYPE){//临修加改
			hql += " and jpd.type=?";
		}else{//非临修加改---报活
			hql += " and jpd.type<>?";
			type = Contains.LX_JG_TYPE;
		}
		return getHibernateTemplate().find(hql, new Object[]{user.getUserid(),rjhmId,type});
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listMyJtPreDictNoPre(int rjhmId,UsersPrivs user,Short type,Integer signFlag){
		String hql = null;
		hql = "from JtPreDict jpd where jpd.proTeamId.proteamid="+user.getBzid()+" and jpd.datePlanPri.rjhmId=?";
		if(signFlag==0){
			hql += " and (jpd.dealFixEmp not like '%,"+user.getXm()+",%' or jpd.dealFixEmp is null)";
		}
		if(type== Contains.LX_JG_TYPE){//临修加改
			hql += " and jpd.type=?";
		}else{//非临修加改---报活
			hql += " and jpd.type<>?";
			type = Contains.LX_JG_TYPE;
		}
		return getHibernateTemplate().find(hql, new Object[]{rjhmId,type});
	}
	
	public void updateJtPreDict(JtPreDict jtPreDict){
		getHibernateTemplate().update(jtPreDict);
	}
	
	@SuppressWarnings("unchecked")
	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,long userid){
		//if(roleType==2||roleType==3){//质检、技术查询自己所分班组下的报活信息
			//String sql="select predict.* from jt_predict predict where predict.recstas>=2 and predict.type<>3 and predict.dateplanpri=:rjhId and predict.proteamid in (select charge.proteamid from jc_charge charge where charge.userid=:userId group by charge.proteamid)";
			//Query query=getSession().createSQLQuery(sql).addEntity(JtPreDict.class).setParameter("rjhId", rjhmId).setParameter("userId", userid);
			//return query.list();
		//}else{//4、5交车工长、验收查询机车下所有的报活信息
			String hql="from JtPreDict t where t.recStas>=2 and t.type<>3 and t.datePlanPri.rjhmId=? order by t.recStas";
			return getHibernateTemplate().find(hql,rjhmId);
		//}
//		StringBuilder builder = new StringBuilder();
//		List<Object> params = new ArrayList<Object>();
//		builder.append("from JtPreDict t where 1=1");
//		if(roleType==2){
//			builder.append(" and t.itemCtrlTech=1 and t.recStas>=4");
//		}else if(roleType==3){
//			builder.append(" and t.itemCtrlQI=1 and t.recStas>=4");
//		}else if(roleType==4){
//			builder.append(" and t.itemCtrlComLd=1 and t.recStas>=4");
//		}else{
//			builder.append(" and t.itemCtrlAcce=1 and t.recStas>=4");
//		}
//		
//		builder.append(" and t.recStas>=2");
//		builder.append(" and t.type<>?");
//		params.add(Contains.LX_JG_TYPE);
//		builder.append(" and t.datePlanPri.rjhmId=? order by t.recStas");
//		params.add(rjhmId);
//		return getHibernateTemplate().find(builder.toString(), params.toArray());
	}
	
	/**
	 * 查询故障表一级部件
	 */
	public List<String> listFirstUnitNameOfDictFailure(){
		return getHibernateTemplate().find("select distinct t.firstUnitName from DictFailure t");
	}
	
	/**
	 * 查询故障表二级部件
	 */
	public List<String> listSecUnitNameOfDictFailure(String firstUnitName){
		if(firstUnitName==null){
			return getHibernateTemplate().find("select distinct t.secUnitName from DictFailure t");
		}else{
			return getHibernateTemplate().find("select distinct t.secUnitName from DictFailure t where t.firstUnitName=?",firstUnitName);
		}
	}
	
	/**
	 * 查询故障表三级部件
	 */
	public List<String> listThirdUnitNameOfDictFailure(String firstUnitName,String secUnitName){
		return getHibernateTemplate().find("select distinct t.thirdUnitName from DictFailure t where t.firstUnitName=? and t.secUnitName=?",new Object[]{firstUnitName,secUnitName});
	}
	
	/**
	 * 查询故障内容
	 */
	public List<DictFailure> listDictFailure(String firstUnitName,String seccondUnitName,String thirdUnitName){
		StringBuilder hql = new StringBuilder();
		List<String> params = new ArrayList<String>();
		hql.append("from DictFailure t where 1=1");
		if(firstUnitName!=null && !"".equals(firstUnitName)){
			hql.append(" and t.firstUnitName=?");
			params.add(firstUnitName);
		}else{
			hql.append(" and t.firstUnitName is null");
		}
		if(seccondUnitName!=null && !"".equals(seccondUnitName)){
			hql.append(" and t.secUnitName=?");
			params.add(seccondUnitName);
		}else{
			hql.append(" and t.secUnitName is null");
		}
		if(thirdUnitName!=null && !"".equals(thirdUnitName)){
			hql.append(" and t.thirdUnitName=?");
			params.add(thirdUnitName);
		}else{
			hql.append(" and t.thirdUnitName is null");
		}
		return getHibernateTemplate().find(hql.toString(),params.toArray());
	}

	@Override
	public void delete(Integer preDictIds) {
		String hql = "delete from JtPreDict as jpd  where jpd.preDictId=?";
		this.getSession().createQuery(hql).setInteger(0, preDictIds).executeUpdate();	
	}

	@Override
	public List<PresetDivision> listPresetDivision(long proTeamId,String jcType) {
		String hql="from PresetDivision pd where pd.proTeam.proteamid=? and pd.jcValue=?";
		return getHibernateTemplate().find(hql,new Object[]{proTeamId,jcType});
	}

	@Override
	public List<JCDivision> listJCDivision(Integer divisionId, Integer planId) {
		String hql="from JCDivision jcd where jcd.presetDivision.proSetId=? and jcd.dayPlan.rjhmId=?";
		return getHibernateTemplate().find(hql,new Object[]{divisionId,planId});
	}
	
	/**
	 * 统计班组未完成的报活
	 */
	@SuppressWarnings("unchecked")
	public List countUnfinishJtPreDict(Long bzId){
		String sql = "select t.jctype,t.jcnum,t.rjhmid,t.fixfreque,t.projecttype,(select count(jt.predictid) from jt_predict jt where jt.dateplanpri=t.rjhmid and jt.proteamid=? and jt.dealFixEmp is null) from dateplan_pri t where t.planstatue>=0 and t.planstatue<=2";
		return getSession().createSQLQuery(sql).setParameter(0, bzId).list();
	}

	@Override
	public List countUnfinishJtPreDict(Long bzId,String roles) {
		StringBuilder builder=new StringBuilder();
		builder.append("select t.jctype,t.jcnum,t.rjhmid,t.fixfreque,t.projecttype,(select count(jt.predictid) from jt_predict jt where jt.dateplanpri=t.rjhmid");
		if(roles!=null&&roles.contains(",GZ,")){
			builder.append(" and jt.proteamid=? and jt.recstas>2 and jt.lead is null");
		}else if(roles!=null&&roles.contains(",ZJY,")){
			builder.append(" and jt.itemctrqi=1 and jt.qi is null");
		}else if(roles!=null&&roles.contains(",JSY,")){
			builder.append(" and jt.itemctrltech=1 and jt.technician is null");
		}else if(roles!=null&&roles.contains(",YSY,")){
			builder.append(" and jt.itemctrlacce=1 and jt.accepter is null");
		}else if(roles!=null&&roles.contains(",JCGZ,")){
			builder.append(" and jt.itemctrlcomld=1 and jt.commitLd is null");
		}else if(roles!=null&&roles.contains(",GR,")){//工人
			builder.append(" and jt.proteamid=? and jt.dealFixEmp is null");
		}
		builder.append(") from dateplan_pri t where t.planstatue>=0 and t.planstatue<=2");
		if(roles.contains(",GZ,")||roles.contains(",GR,")){
			return getSession().createSQLQuery(builder.toString()).setParameter(0, bzId).list();
		}else{
			return getSession().createSQLQuery(builder.toString()).list();
		}
	}

	@Override
	public List countJCGZUnSigned() {
		String sql="select t.jctype,t.jcnum,t.rjhmid,t.fixfreque,t.projecttype," +
				"(select count(jt.predictid) from jt_predict jt where jt.dateplanpri=t.rjhmid and jt.recstas>=2 and jt.recstas<4) as unfinishReport," +
				"(select count(t1.jcrecid) from jc_fixrec t1 where t1.dyprecid=t.rjhmid and t1.itemctrlcomld=1 and t1.commitlead is null) as unsignedJCRec,"+
				"(select count(t2.id) from jc_zx_fixrec t2 where t2.dyprecid=t.rjhmid and t2.itemctrlcomld=1 and t2.commitlead is null) as unsignedJCZXRec"+
				" from dateplan_pri t where t.planstatue>=0 and t.planstatue<=2";
		return getSession().createSQLQuery(sql).list();
	}
}
