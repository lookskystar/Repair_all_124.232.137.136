package com.repair.work.service.impl;

import com.repair.common.pojo.UsersPrivs;

/**
 * 签认
 * @author Administrator
 *
 */
public class SignWork {
	/**
	 * itemType:项目类型  0：检修  1：临修、加改 2：秋整、春鉴 3:报活
	 * roleType：角色类型 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * signFlag:签认标志 0：单签  1：全签
	 * itemIds:项目ID集合
	 * datePlanId:日计划ID
	 * usersPrivs:当前用户
	 * result:返回值  success签认成功
	 * @return
	 */
	public String sign(int itemType,int roleType,int signFlag,String itemIds,int datePlanId,UsersPrivs usersPrivs){
		String result="success";
		switch (itemType) {
			//case 1:lxjgSign(roleType,signFlag,itemIds,datePlanId,usersPrivs);break;
			default:result=fixSign(roleType,signFlag,itemIds,datePlanId,usersPrivs);break;
		}
		return result;
	}
	
	/**
	 * 固定检修项目签认
	 * @param roleType
	 * @param signFlag
	 * @param itemIds
	 * @param datePlanId
	 * @param usersPrivs
	 * @return
	 */
	public String fixSign(int roleType,int signFlag,String itemIds,int datePlanId,UsersPrivs usersPrivs){
		String result="success";
        
		return result;
	}

}
