package com.repair.query.dao;

import java.util.List;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;

/**
 * 配件
 * @author Administrator
 *
 */
public interface FittingDao {
	/**
	 * 根据检修组装记录查询配件编号
	 * @param rjhmId 日计划
	 * @return 日计划组装填入编号集合
	 */
	List<String> findFittingNumberForFixRec(int rjhmId);
	
	/**
	 * 根据日计划查询小辅修日计划机车下所有填写的配件编号
	 * @param rjhmId
	 * @param type 0:小辅修  1：临修  2：春整
	 * @return
	 */
	List<String> findXXPJNums(int rjhmId,int type);
	
	/**
	 * 根据检修组装记录查询配件编号
	 * @param rjhmId 日计划
	 * @return 日计划组装填入编号集合
	 */
	List<String> findFittingNumberForFixRec(int rjhmId,long bzId);
	
	/**
	 * 根据配件编号集合查找配件专业
	 * @param fittingNums 配件编号集合
	 * @return 配件动态信息集合
	 */
	List<DictFirstUnit> forFittingNumbers(List<String> fittingNums);
	
	
	/**
	 * 根据专业查找检修记录
	 * @param firstunitid 专业ID
	 * @return 检修记录
	 */
	List<PJFixRecord> forFirstUnit(long firstunitid,List<String> fittingNums);
	
	/**
	 * 根据静态配件信息查找检修记录
	 * @param staticId
	 * @param rjhmId
	 * @return
	 */
    List<PJFixRecord> forPjStaticId(long staticId,List<String> fittingNums);
	
	/**
	 * 根据专业查找检修记录
	 * @return 检修记录
	 */
	List<PJFixRecord> forFirstUnit(String pjNum);

	/**
	 * 根据配件编号查找动态配件信息
	 * @param pjNum
	 * @return
	 */
	PJDynamicInfo findDynamicInfoByPjNum(String pjNum);
	
	/**
	 * 根据一级部件查询静态配件信息
	 * @param firstunitid
	 * @return
	 */
	List<PJStaticInfo> findPJStaticInfoByFirstId(Long firstunitid);
	
	List<PJStaticInfo> forStaticInfo(List<Long> firstUnitIds);
	
	/**
	 * 根据配件静态ID查询配件静态信息
	 * @param pjsid
	 * @return
	 */
	PJStaticInfo findPJStaticInfoById(Long pjsid);
	
    /**
     * 根据静态配件信息查找检修项目信息
     * @param staticId
     * @return
     */
    List<PJFixItem> findPjFixItemByStaticId(long staticId);
    
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
	 * 根据配件动态ID查询配件信息
	 * @param pjdid
	 * @return
	 */
	PJDynamicInfo findPJDynamicInfoByDID(Long pjdid);
	
	/**
	 * 通过小辅修配件编号查询配件大类信息
	 * @param pjNums
	 * @return
	 */
	public List<PJStaticInfo> findPJStaticInfoByXXPJNums(List<String> pjNums);
}