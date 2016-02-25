package com.repair.work.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.repair.common.pojo.UsersPrivs;

/**
 * 查询项目
 * @author Administrator
 *
 */
public class ListItem {
	
	/**
	 * itemType:项目类型  0：检修  1：临修、加改 2：秋整、春鉴 3:报活
	 * roleType：角色类型 0:工人 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * signFlag:签认标志 0：单签  1：全签
	 * itemIds:项目ID集合
	 * datePlanId:日计划ID
	 * usersPrivs:当前用户
	 * List:返回项目集合
	 * @return
	 */
	public List<?> listItem(int itemType,int roleType,int datePlanId,UsersPrivs usersPrivs){
		List<?> items=null;
		switch(itemType){
			case 1:break;
			default:items=listFixItem(roleType,datePlanId,usersPrivs);break;
		}
		return items;
	}
	
	/**
	 * 查询固定检修项目
	 * @param roleType
	 * @param datePlanId
	 * @param usersPrivs
	 * @return
	 */
	public List<?> listFixItem(int roleType,int datePlanId,UsersPrivs usersPrivs){
		List<?> items=null;
		String hql="";
		switch (roleType) {
		    case 1://工长
		    	hql="查询工长的固定检修项目";
				items=new ArrayList<String>();
			  break;
			default://工人
				hql="查询工人的固定检修项目";
				items=new ArrayList<String>();
			  break;
		}
		return null;
	}
	
	/**
	 * 由于需求不同,查询项目的方式不同
	 * @param version 版本号
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getGongRenHql(int version,int itemType){
		String hql="";
		if(itemType==0){//固定检修
			if(version==1){
				hql="第一个版本查询工人固定检修项目";
			}else if(version==2){
				hql="第二个版本查询工人固定检修项目";
			}
		}else if(itemType==1){//其它项目
			if(version==1){
				hql="第一个版本查询工长固定检修项目";
			}else if(version==2){
				hql="第二个版本查询工长固定检修项目";
			}
		}
		return hql;
	}

}
