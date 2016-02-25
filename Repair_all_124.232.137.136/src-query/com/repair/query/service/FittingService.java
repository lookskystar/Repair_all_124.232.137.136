package com.repair.query.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;

/**
 * 配件服务
 * @author Administrator
 *
 */
public interface FittingService {
	/**
	 * 根据日计划查找配件专业
	 * @param rjhmId 日计划
	 * @return
	 */
	List<DictFirstUnit> findDictFistUnitForDatePlan(int rjhmId);
	
	/**
	 * 根据日计划查询日计划机车下所有填写的配件编号
	 * @param rjhmId
	 * @return
	 */
	List<String> findPjNums(int rjhmId);
	
	/**
	 * 根据日计划查询小辅修日计划机车下所有填写的配件编号
	 * @param rjhmId
	 * @param type 0:小辅修  1：临修  2：春整
	 * @return
	 */
	List<String> findXXPJNums(int rjhmId,int type);
	
	/**
	 * 根据专业查找检修记录
	 * @param firstunitid 专业ID
	 * @return 检修记录
	 */
	List<PJFixRecord> forFirstUnit(long firstunitid,int rjhmId);
	
	/**
	 * 根据静态配件信息查找检修记录
	 * @param staticId
	 * @param rjhmId
	 * @return
	 */
    List<PJFixRecord> forPjStaticId(long staticId,int rjhmId);
    
    /**
     * 根据静态配件信息查找检修项目信息
     * @param staticId
     * @return
     */
    List<PJFixItem> findPjFixItemByStaticId(long staticId);
	
	/**
	 * 根据日计划与配件编码查找检修记录
	 * @param pjNum
	 * @return
	 */
	List<PJFixRecord> forNumAndDataPlan(String pjNum);
	
	/**
	 * 根据配件编号查找动态配件信息
	 * @param pjNum
	 * @return
	 */
	PJDynamicInfo findDynamicInfoByPjNum(String pjNum);
	
	/**
	 * 根据配件动态ID查询配件信息
	 * @param pjdid
	 * @return
	 */
	PJDynamicInfo findPJDynamicInfoByDID(Long pjdid);
	
	/**
	 * 根据一级部件信息封装配件静态信息
	 * @param rjhmId
	 * @return
	 */
	public Map<String,List<PJStaticInfo>> findPJStaticInfoByFirstId(int rjhmId);
	
	public List<PJStaticInfo> findPJStaticInfo(int rjhmId);
	
	/**
	 * 通过日计划ID和班组ID查询本机车下的配件信息
	 * @param rjhmId
	 * @param bzId
	 * @return
	 */
	public List<PJStaticInfo> findPJStaticInfo(int rjhmId,long bzId);
	
	/**
	 * 根据配件静态ID查询配件静态信息
	 * @param pjsid
	 * @return
	 */
	PJStaticInfo findPJStaticInfoById(Long pjsid);
	
	/**
	 * 根据配件动态ID查询配件检修记录信息
	 * 
	 * @param pjdid
	 * @return
	 */
	List<PJFixRecord> findPJFixRecordByDid(Long pjdid);
	
	/**
	 * 根据配件动态ID和配件记录ID查询配件检修记录信息
	 * @param pjdid
	 * @param pjRecId
	 * @param bzId  指定班组 如为null，表示全部
	 * @return
	 */
	List<PJFixRecord> findPJFixRecordByDid(Long pjdid,Long pjRecId,Long bzId);
	
	/**
	 * 查询动态配件在中修上车的数量
	 * @param pjsid
	 * @param pjNums
	 * @return
	 */
	public int findDynamicInZxFixItem(Long pjsid,List<String> pjNums);
	
	/**
	 * 根据配件编号查询所有的配件动态信息
	 * @param pjsid
	 * @param pjNums
	 * @return
	 */
	public List<PJDynamicInfo> findPJDynamicInfoByPjNums(Long pjsid,List<String> pjNums);
	
	/**
	 * 根据日计划ID查询配件记录
	 * @param rjhmId
	 * @return
	 */
	public PJFixRecord findPJFixRecordByRjhmId(Integer rjhmId,Long pjdid);
	
	/**
	 * 通过小辅修配件编号查询配件大类信息
	 * @param pjNums
	 * @return
	 */
	public List<PJStaticInfo> findPJStaticInfoByXXPJNums(List<String> pjNums);
	
}
