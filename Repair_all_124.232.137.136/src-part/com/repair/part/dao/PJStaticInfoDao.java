package com.repair.part.dao;

import java.util.List;

import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJStaticInfo;

public interface PJStaticInfoDao {

	/**
	 * 根据静态配件id获取静态配件
	 * @param pjsid 静态配件id
	 * @return
	 */
	PJStaticInfo getPJStaticInfo(Long pjsid);

	/**
	 * 根据配件检修项目中的配件id查询所有子配件
	 * @param pjsid 配件id
	 * @return
	 */
	List<PJStaticInfo> findChildPJByParentPJFromFixItem(Long pjsid);
	
	/**
	 * 查询配件是否存在预设分工
	 * @param pjsId
	 * @return
	 */
	List<PJPresetDivision> findPJStaticInfoPreset(Long pjsId);
}
