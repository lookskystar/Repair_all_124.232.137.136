package com.repair.query.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.plan.service.PlanManageService;

public class Query {
	
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	
	/**
	 * 连接数据库
	 * @param IPAddress IP地址
	 * @param dataBase 数据库名称
	 * @param userName 用户名
	 * @param password 密码
	 * @return
	 */
	public static Connection getConnect(String conns[]){
		Connection conn=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url="jdbc:oracle:thin:@"+conns[1]+":1521:"+conns[2];
			conn=DriverManager.getConnection(url,conns[3],conns[4]);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	@SuppressWarnings("unchecked")
	public Map countDatePlans(String conns[],String timeStamp){
		Connection conn=Query.getConnect(conns);;
		PreparedStatement pstm=null;
		ResultSet rs=null;
		Long result=null;
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("area", conns[0]);
		try {
			//大修机车数量
			map.put("dx", 0);
			//查询中修机车数量
			String sql="select count(rjhmid) from dateplan_pri where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%Z%' and fixfreque!='ZQZZ' and fixfreque!='QZ' and fixfreque!='CCZZ'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			while(rs.next()){
				result=rs.getLong(1);
			}
			map.put("zx", result);
			//查询小辅修机车数量
			sql="select count(rjhmid) from dateplan_pri where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque like 'X%' or fixfreque like 'F%' or fixfreque = 'NJ' or fixfreque = 'BNJ' or fixfreque like '%JJ%' or fixfreque like '%YJ%')";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			while(rs.next()){
				result=rs.getLong(1);
			}
			map.put("xfx", result);
			//查询临修机车数量
			sql="select count(rjhmid) from dateplan_pri where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque = 'LX' or fixfreque = 'JG')";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			while(rs.next()){
				result=rs.getLong(1);
			}
			map.put("lx", result);
			//其他机车数量(周期整治、春鉴、秋整)
			sql="select count(rjhmid) from dateplan_pri where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque = 'ZQZZ' or fixfreque ='CCZZ' or fixfreque ='QZ' or fixfreque ='CJ')";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			while(rs.next()){
				result=rs.getLong(1);
			}
			map.put("qt", result);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally{
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstm!=null){
				   pstm.close();
				}
				if(conn!=null){
				   conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	public Map<String, List<Map<String, String>>> countJcnumFromDatePlans(String conns[],String timeStamp){
		Connection conn=Query.getConnect(conns);;
		PreparedStatement pstm=null;
		ResultSet rs=null;
		Map<String,List<Map<String, String>>> map=new HashMap<String,List<Map<String, String>>>();
		List<Map<String, String>> jcnumList = null;
		Map<String, String> idWithNumMap = null;
		try {
			//查询小修机车号
			String sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like 'X%'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("xx", jcnumList);
			//查询辅修机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like 'F%'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("fx", jcnumList);
			//查询中修机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%Z%' and fixfreque!='ZQZZ' and fixfreque!='QZ' and fixfreque != 'CCZZ' ";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("zx", jcnumList);
			//查询临修机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque = 'LX'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("lx", jcnumList);
			//查询加改机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque = 'JG'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("jg", jcnumList);
			//半年检机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%BNJ%'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("bnj", jcnumList);
			//年检机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%NJ%' and fixfreque != 'BNJ'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("nj", jcnumList);
			//月检机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%YJ%'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("yj", jcnumList);
			//季检机车号
			sql="select t.FIXFREQUE,t.jctype,t.rjhmid,t.jcnum from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%JJ%'";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			jcnumList = new ArrayList<Map<String, String>>();
			while(rs.next()){
				idWithNumMap = new HashMap<String, String>();
				idWithNumMap.put("rjhmid", rs.getString("rjhmid"));
				idWithNumMap.put("jcStype", rs.getString("jctype"));
				idWithNumMap.put("jcnum", rs.getString("jcnum"));
				idWithNumMap.put("xcxc", rs.getString("FIXFREQUE"));
				jcnumList.add(idWithNumMap);
			}
			map.put("jd", jcnumList);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally{
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstm!=null){
				   pstm.close();
				}
				if(conn!=null){
				   conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	public List<Map<String, String>> listJcNums(String[] connInfo, String xcxc, String timeStamp){
		Connection conn=Query.getConnect(connInfo);
		PreparedStatement pstm=null;
		ResultSet rs=null;
		List<Map<String, String>> dpList = new ArrayList<Map<String, String>>();
		Map<String, String> dpMap = null; 
		try {
			String sql = "";
			if("dx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where   planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%"+ xcxc +"%'";
			}else if("zx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where   planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and fixfreque like '%Z%' and fixfreque != 'ZQZZ' and fixfreque != 'QZ' and fixfreque != 'CCZZ'";
			}else if("xfx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t " +
						"where   planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque like 'X%' or fixfreque like 'F%' or fixfreque = 'NJ' or fixfreque = 'BNJ' or fixfreque like '%JJ%' or fixfreque like '%YJ%')";
			}else if("lx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque = 'LX' or fixfreque = 'JG')";
			}else if("qt".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and (fixfreque = 'ZQZZ' or fixfreque = 'CCZZ' or fixfreque = 'QZ' or fixfreque = 'CJ')";
			}else if("all".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null)";
			}
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
				rs=pstm.executeQuery();
			while(rs.next()){
				dpMap = new HashMap<String, String>();
				dpMap.put("time", timeStamp);
				dpMap.put("rjhmId", rs.getString("rjhmId"));
				dpMap.put("jcType", rs.getString("jctype"));
				dpMap.put("xcxc", rs.getString("fixFreque"));
				dpMap.put("jcnum", rs.getString("jcnum"));
				dpMap.put("kcsj", rs.getString("kcsj"));
				dpList.add(dpMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally{
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstm!=null){
				   pstm.close();
				}
				if(conn!=null){
				   conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dpList;
	}
	
	public List<Map<String, String>> listJcNumsType(String[] connInfo, String xcxc, String timeStamp, String jcType){
		Connection conn=Query.getConnect(connInfo);
		PreparedStatement pstm=null;
		ResultSet rs=null;
		List<Map<String, String>> dpList = new ArrayList<Map<String, String>>();
		Map<String, String> dpMap = null;
		try {
			String sql = "";
			if("dx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where   planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ? and fixfreque like '%"+ xcxc +"%'";
			}else if("zx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where   planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ? and fixfreque like '%Z%' and fixfreque != 'ZQZZ' and fixfreque != 'CCZZ' and fixfreque != 'QZ'";
			}else if("xfx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where " +
						" planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ? and (fixfreque like 'X%' or fixfreque like 'F%' or fixfreque = 'NJ' or fixfreque = 'BNJ' or fixfreque like '%JJ%' or fixfreque like '%YJ%')";
			}else if("lx".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ?  and (fixfreque = 'LX' or fixfreque = 'JG')";
			}else if("qt".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ?  and (fixfreque = 'ZQZZ' or fixfreque = 'CCZZ' or fixfreque = 'QZ' or fixfreque = 'CJ')";
			}else if("all".equals(xcxc)){
				sql += "select t.rjhmId, t.fixFreque, t.jcType, t.jcnum, t.kcsj from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType= ?";
			}
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			pstm.setString(3, jcType);
			rs=pstm.executeQuery();
			while(rs.next()){
				dpMap = new HashMap<String, String>();
				dpMap.put("time", timeStamp);
				dpMap.put("rjhmId", rs.getString("rjhmId"));
				dpMap.put("jcType", rs.getString("jctype"));
				dpMap.put("xcxc", rs.getString("fixFreque"));
				dpMap.put("jcnum", rs.getString("jcnum"));
				dpMap.put("kcsj", rs.getString("kcsj"));
				dpList.add(dpMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally{
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstm!=null){
				   pstm.close();
				}
				if(conn!=null){
				   conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dpList;
	}
	
	public Map<String, Map<String, Object>> listJcNumsByArea(String[] connInfo, String timeStamp){
		Connection conn=Query.getConnect(connInfo);
		PreparedStatement pstm=null;
		ResultSet rs=null;
		Map<String, Map<String, Object>> packageMap = new HashMap<String, Map<String, Object>>();
		Map<String, Object> subPackageMap = null;
		List<String> typeList = new ArrayList<String>();
		try {
			//Query Data
			String sql = "select distinct(t.jcType) from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null)";
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, timeStamp);
			pstm.setString(2, timeStamp);
			rs=pstm.executeQuery();
			while(rs.next()){
				typeList.add(rs.getString("jctype"));
			}
			Long resultCount = null;
			for (String string : typeList) {
				subPackageMap = new HashMap<String, Object>();
				String jcType = string;
				sql = "select count(rjhmid) from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType = ? and fixfreque like '%Z%' and fixfreque != 'ZQZZ' and fixfreque != 'CCZZ' and fixfreque != 'QZ'";
				pstm=conn.prepareStatement(sql);
				pstm.setString(1, timeStamp);
				pstm.setString(2, timeStamp);
				pstm.setString(3, jcType);
				rs=pstm.executeQuery();
				while(rs.next()){
					resultCount = rs.getLong(1);
				}
				subPackageMap.put("zx", resultCount);
				sql = "select count(rjhmid) from dateplan_pri t where " +
						" planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType = ? and (fixfreque like 'X%' or fixfreque like 'F%' or fixfreque = 'NJ' or fixfreque = 'BNJ' or fixfreque like '%JJ%' or fixfreque like '%YJ%')";
				pstm=conn.prepareStatement(sql);
				pstm.setString(1, timeStamp);
				pstm.setString(2, timeStamp);
				pstm.setString(3, jcType);
				rs=pstm.executeQuery();
				while(rs.next()){
					resultCount = rs.getLong(1);
				}
				subPackageMap.put("xfx", resultCount);
				sql = "select count(rjhmid) from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType = ? and (fixfreque = 'LX' or fixfreque = 'JG')";
				pstm=conn.prepareStatement(sql);
				pstm.setString(1, timeStamp);
				pstm.setString(2, timeStamp);
				pstm.setString(3, jcType);
				rs=pstm.executeQuery();
				while(rs.next()){
					resultCount = rs.getLong(1);
				}
				subPackageMap.put("lx", resultCount);
				sql = "select count(rjhmid) from dateplan_pri t where  planStatue > -1 and kcsj<? and (sjjcsj>=? or sjjcsj is null) and jcType = ? and (fixfreque = 'ZQZZ' or fixfreque = 'CCZZ' or fixfreque = 'QZ' or fixfreque = 'CJ')";
				pstm=conn.prepareStatement(sql);
				pstm.setString(1, timeStamp);
				pstm.setString(2, timeStamp);
				pstm.setString(3, jcType);
				rs=pstm.executeQuery();
				while(rs.next()){
					resultCount = rs.getLong(1);
				}
				subPackageMap.put("qt", resultCount);
				packageMap.put(jcType, subPackageMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null){
					rs.close();
				}
				if(pstm!=null){
				   pstm.close();
				}
				if(conn!=null){
				   conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return packageMap;
	}
	
	
	/**
	 * 领导报表首页
	 * @param connInfo
	 * @param startTimestamp
	 * @param endTimestamp
	 * @return
	 */
	public Map<String, Object> groupLeaderReportCounts(String[] connInfo, String startTimestamp, String endTimestamp){
		Connection conn = Query.getConnect(connInfo);
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Map<String, Object> countMap = new HashMap<String, Object>();
		countMap.put("area", connInfo[0]);
		Integer count = 0;
		try {
			//大修计划
			countMap.put("dxjh", new Integer(0));
			//大修实际
			countMap.put("dxsj", new Integer(0));
			//大修未兑现
			countMap.put("dxno", new Integer(0));
			
			//中修计划
			String sql = "select count(*) from mainplandetail t where t.planTime between ? and ? and  xcxc like '%Z%' and xcxc != 'ZQZZ' and xcxc != 'CCZZ' and xcxc != 'QZ'";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("zxjh", new Integer(count));
			//中修实际
			sql = "select count(*) from dateplan_pri t where t.kcsj between ? and ? and fixFreque like '%Z%' and fixFreque != 'ZQZZ' and fixFreque != 'CCZZ' and fixFreque != 'QZ'";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("zxsj", new Integer(count));
			//中修未兑现
			sql = "select count(*) from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and  xcxc like '%Z%' and xcxc != 'ZQZZ' and xcxc != 'CCZZ' and xcxc != 'QZ'";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("zxno", new Integer(count));
			//小辅修计划
			sql = "select count(*) from mainplandetail t where t.planTime between ? and ? and (xcxc like 'X%' or xcxc like 'F%' or xcxc = 'NJ' or xcxc = 'BNJ' or xcxc like '%JJ%' or xcxc like '%YJ%')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("fxjh", new Integer(count));
			//小辅修实际
			sql = "select count(*) from dateplan_pri t where t.kcsj between ? and ? and (fixFreque like 'X%' or fixFreque like 'F%' or fixFreque = 'NJ' or fixFreque = 'BNJ' or fixFreque like '%JJ%' or fixFreque like '%YJ%')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("fxsj", new Integer(count));
			//小辅修未兑现
			sql = "select count(*) from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc like 'X%' or xcxc like 'F%' or xcxc = 'NJ' or xcxc = 'BNJ' or xcxc like '%JJ%' or xcxc like '%YJ%')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("fxno", new Integer(count));
			//临修计划
			sql = "select count(*) from mainplandetail t where t.planTime between ? and ? and (xcxc = 'LX' or xcxc = 'JG')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("lxjh", new Integer(count));
			//临修实际
			sql = "select count(*) from dateplan_pri t where t.kcsj between ? and ? and (fixFreque = 'LX' or fixFreque = 'JG')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("lxsj", new Integer(count));
			//临修未兑现
			sql = "select count(*) from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc = 'LX' or xcxc = 'JG')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("lxno", new Integer(count));

			//其他计划
			sql = "select count(*) from mainplandetail t where t.planTime between ? and ? and (xcxc = 'ZQZZ' or xcxc = 'CCZZ' or xcxc = 'QZ' or xcxc = 'CJ')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("qtjh", new Integer(count));
			//其他实际
			sql = "select count(*) from dateplan_pri t where t.kcsj between ? and ? and (fixfreque = 'ZQZZ' or fixfreque = 'CCZZ' or fixfreque = 'QZ' or fixfreque = 'CJ')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("qtsj", new Integer(count));
			//其他未兑现
			sql = "select count(*) from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc = 'ZQZZ' or xcxc = 'CCZZ' or xcxc = 'QZ' or xcxc = 'CJ')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			countMap.put("qtno", new Integer(count));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}
	
	/**
	 * 领导报表详细页面
	 * @param connInfo
	 * @param startTimestamp
	 * @param endTimestamp
	 * @return
	 */
	public List<Map<String, Object>> groupLeaderReportCountsDetail(String[] connInfo, String startTimestamp, String endTimestamp){
		Connection conn = Query.getConnect(connInfo);
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		Map<String, Object> planObject = null;
		try {
			//中修实际
			String sql = "select * from dateplan_pri t where t.kcsj between ? and ? and fixFreque like '%Z%' and fixFreque != 'ZQZZ' and fixFreque != 'CCZZ' and fixFreque != 'QZ'";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);	
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "zx");
				planObject.put("plan", "zxsj");
				planObject.put("id", rs.getString("rjhmid"));
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("kcsj", rs.getString("kcsj"));
				planObject.put("jhqjsj", rs.getString("jhqjsj"));
				planObject.put("sjqjsj", rs.getString("sjqjsj"));
				planObject.put("jhjcsj", rs.getString("jhjcsj"));
				planObject.put("sjjcsj", rs.getString("sjjcsj"));
				planObject.put("comments", rs.getString("comments"));
				resultList.add(planObject);
			}
			//中修未兑现
			sql = "select * from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and  xcxc like '%Z%' and xcxc != 'ZQZZ' and xcxc != 'CCZZ' and xcxc != 'QZ'";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "zx");
				planObject.put("plan", "zxno");
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("comments", rs.getString("cashReason"));
				resultList.add(planObject);
			}
			//小辅修实际
			sql = "select * from dateplan_pri t where t.kcsj between ? and ? and (fixFreque like 'X%' or fixFreque like 'F%' or fixFreque = 'NJ' or fixFreque = 'BNJ' or fixFreque like '%JJ%' or fixFreque like '%YJ%')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "fx");
				planObject.put("plan", "fxsj");
				planObject.put("id", rs.getString("rjhmid"));
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("kcsj", rs.getString("kcsj"));
				planObject.put("jhqjsj", rs.getString("jhqjsj"));
				planObject.put("sjqjsj", rs.getString("sjqjsj"));
				planObject.put("jhjcsj", rs.getString("jhjcsj"));
				planObject.put("sjjcsj", rs.getString("sjjcsj"));
				planObject.put("comments", rs.getString("comments"));
				resultList.add(planObject);
			}
			//小辅修未兑现
			sql = "select * from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc like 'X%' or xcxc like 'F%' or xcxc = 'NJ' or xcxc = 'BNJ' or xcxc like '%JJ%' or xcxc like '%YJ%')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "fx");
				planObject.put("plan", "fxno");
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("comments", rs.getString("cashReason"));
				resultList.add(planObject);
			}
			//临修实际
			sql = "select * from dateplan_pri t where t.kcsj between ? and ? and (fixFreque = 'LX' or fixFreque = 'JG')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "lx");
				planObject.put("plan", "lxsj");
				planObject.put("id", rs.getString("rjhmid"));
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("kcsj", rs.getString("kcsj"));
				planObject.put("jhqjsj", rs.getString("jhqjsj"));
				planObject.put("sjqjsj", rs.getString("sjqjsj"));
				planObject.put("jhjcsj", rs.getString("jhjcsj"));
				planObject.put("sjjcsj", rs.getString("sjjcsj"));
				planObject.put("comments", rs.getString("comments"));
				resultList.add(planObject);
			}
			//临修未兑现
			sql = "select * from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc = 'LX' or xcxc = 'JG')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "lx");
				planObject.put("plan", "lxno");
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("comments", rs.getString("cashReason"));
				resultList.add(planObject);
			}
			//其他实际
			sql = "select * from dateplan_pri t where t.kcsj between ? and ? and (fixfreque = 'ZQZZ' or fixfreque = 'CCZZ' or fixfreque = 'QZ' or fixfreque = 'CJ')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "qt");
				planObject.put("plan", "qtsj");
				planObject.put("id", rs.getString("rjhmid"));
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("kcsj", rs.getString("kcsj"));
				planObject.put("jhqjsj", rs.getString("jhqjsj"));
				planObject.put("sjqjsj", rs.getString("sjqjsj"));
				planObject.put("jhjcsj", rs.getString("jhjcsj"));
				planObject.put("sjjcsj", rs.getString("sjjcsj"));
				planObject.put("comments", rs.getString("comments"));
				resultList.add(planObject);
			}
			//其他未兑现
			sql = "select * from mainplandetail t where t.isCash = 0 and t.planTime between ? and ? and (xcxc = 'ZQZZ' or xcxc = 'CCZZ' or xcxc = 'QZ' or xcxc = 'CJ')";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, startTimestamp);
			pstm.setString(2, endTimestamp);
			rs = pstm.executeQuery();
			while(rs.next()){
				planObject = new HashMap<String, Object>();
				planObject.put("xc", "qt");
				planObject.put("plan", "qtno");
				planObject.put("jctype", rs.getString("jctype"));
				planObject.put("jcnum", rs.getString("jcnum"));
				planObject.put("comments", rs.getString("cashReason"));
				resultList.add(planObject);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
	}

}
