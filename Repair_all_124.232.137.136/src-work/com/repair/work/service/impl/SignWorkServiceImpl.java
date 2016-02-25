package com.repair.work.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.poi.hssf.record.PageBreakRecord.Break;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UserRolePrivs;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.plan.dao.JcFlowRecDao;
import com.repair.plan.service.PlanManageService;
import com.repair.work.dao.JCQZFixDao;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.SignWorkDao;
import com.repair.work.dao.UsersPrivsDao;
import com.repair.work.dao.WorkDao;
import com.repair.work.service.SignWorkService;

public class SignWorkServiceImpl implements SignWorkService{
	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Resource(name="signWorkDao")
	private SignWorkDao signWorkDao;
	@Resource(name="usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	@Resource(name="workDao")
	private WorkDao workDao;
	@Resource(name="jcFlowRecDao")
	private JcFlowRecDao jcFlowRecDao;
	@Resource(name="datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	@Resource(name="jcqzFixDao")
	private JCQZFixDao jcqzFixDao;
	@Resource(name="jtPreDictDao")
	private JtPreDictDao jtPreDictDao;
	// 计划管理服务
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	
	public List<DatePlanPri> findDyPlanJC(Long bzId, int nodeId){
		return signWorkDao.findDyPlanJC(bzId, nodeId);
	}
	
	public List<DatePlanPri> findDyPlanJCByStatus(int rtype,Long userId){
		return signWorkDao.findDyPlanJCByStatus(rtype,userId);
	}

	public List<JCFixrec> listSignJCFixrec(int rjhmId, UsersPrivs user, int roleType) {
		List<JCFixrec> list = null;
		if(roleType==1){//工长
			list = signWorkDao.listJCFixrec(rjhmId, user.getBzid(),null);
		}else if(roleType==2 || roleType==3){//2：技术 3:质检 
			list = signWorkDao.listJCFixrec(rjhmId, roleType, user.getUserid(),1);
		}else if(roleType==4){//4：交车工长 
			list = signWorkDao.listJCFixrec(rjhmId, roleType, user.getUserid(),1);
		}else{//5:验收
			list = signWorkDao.listJCFixrec(rjhmId, roleType, null,1);
		}
		return list;
	}
	
	public List<JCZXFixRec> listSignJCZxFixrec(int rjhmId, UsersPrivs user, int roleType) {
		List<JCZXFixRec> list = null;
		if(roleType==1){//工长
			list = signWorkDao.listJCZXFixRec(rjhmId, user.getBzid(),null);
		}else if(roleType==2 || roleType==3){//2：技术 3:质检 
			list = signWorkDao.listJCZXFixRec(rjhmId, roleType, user.getUserid(),1);
		}else if(roleType==4){//4：交车工长 
			list = signWorkDao.listJCZXFixRec(rjhmId, roleType, user.getUserid(),1);
		}else{//5:验收
			list = signWorkDao.listJCZXFixRec(rjhmId, roleType, null,1);
		}
		return list;
	}

	public List<JCQZFixRec> listSignJCQZFixRec(int rjhmId, UsersPrivs user, int roleType) {
		List<JCQZFixRec> list = null;
		if(roleType==1){//工长
			list = signWorkDao.listJCQZFixRec(rjhmId, user.getBzid(),null);
		}else{//2：技术 3:质检4:交车工长 5：验收
			list = signWorkDao.listJCQZFixRec(rjhmId, roleType, 1,user);
		}
		return list;
	}

	public List<JtPreDict> listSignJtPreDict(int rjhmId, UsersPrivs user, int roleType,Short itemType) {
		List<JtPreDict> list = null;
		if(roleType==1){//工长
			list = signWorkDao.listJtPreDict(rjhmId, user.getBzid(),null,itemType);
		}else{//2：技术 3:质检 4:交车工长 5：验收
			list = signWorkDao.listJtPreDict(rjhmId, roleType, 1, itemType, user);
			//list = signWorkDao.listJtPreDictNoPre(rjhmId, roleType, 1, itemType, user);
		}
		return list;
	}

	@Override
	public String updateJCFixRecOfSign(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs) {
		String result = "success";//failure:签名失败   noprivilege_failure:没有权限或没有可签项目!   success:成功     working:用户没签认完
		switch (rtype) {//工长机修 2：技术 3:质检4:交车工长 5：验收
		case 1:
			result = gzSignJCfixrecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			break;
		case 2:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
				result = signJCFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}		
			break;
		case 3:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_ZJY)){
				result = signJCFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		case 4:
//			Long gzId = datePlanPriDao.findDatePlanPriById(rjhmId).getGongZhang().getUserid();
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JCGZ)){//&&gzId.equals(usersPrivs.getUserid())判断是否是同一工长
				result = signJCFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		case 5:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_YSY)){
				result = signJCFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		default:
			result = "failure";
			break;
		}
		return result;
	}
	
	@Override
	public String updateJCZxFixRecOfSign(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs) {
		String result = "success";//failure:签名失败   noprivilege_failure:没有权限或没有可签项目!   success:成功     working:用户没签认完
		switch (rtype) {//工长机修 2：技术 3:质检4:交车工长 5：验收
		case 1:
			result = gzSignJCZXfixrecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			break;
		case 2:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
				result = signJCZxFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}		
			break;
		case 3:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_ZJY)){
				result = signJCZxFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		case 4:
//			Long gzId = datePlanPriDao.findDatePlanPriById(rjhmId).getGongZhang().getUserid();
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JCGZ)){//&&gzId.equals(usersPrivs.getUserid())判断是否是同一工长
				result = signJCZxFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		case 5:
			if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_YSY)){
				result = signJCZxFixRecNew(rtype, qtype, rjhmId, ids, usersPrivs);
			}else{
				result = "noprivilege_failure";
			}
			break;
		default:
			result = "failure";
			break;
		}
		return result;
	}
	
	@Override
	public String updateJCQZFixRecOfSign(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs) {
		String result = "failure";//failure:签名失败   noprivilege_failure:没有权限或没有可签项目!   success:成功  working:用户没签认完
		switch (rtype) {//工长机修 2：技术 3:质检4:交车工长 5：验收
			case 1:
				result = gzSignJCQZFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
				break;
			case 2:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
					result = signJCQZFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 3:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_ZJY)){
					result = signJCQZFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 4:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JCGZ)){
					result = signJCQZFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 5:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_YSY)){
					result = signJCQZFixRec(rtype, qtype, rjhmId, ids, usersPrivs);
				}else{
					result = "noprivilege_failure";
				}
				break;
			default:
				break;
		}
		return result;
	}

	@Override
	public String updateJtPreDictOfSign(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs, Short itemType) {
		String result = "success";
		switch (rtype) {//工长机修 2：技术 3:质检 4:交车工长 5：验收
			case 1:
				result = gzSignJtPreDict(rtype, qtype, rjhmId, ids, usersPrivs,itemType);
				break;
			case 2:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
					result = signJtPreDict(rtype, qtype, rjhmId, ids, usersPrivs,itemType);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 3:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_ZJY)){
					result = signJtPreDict(rtype, qtype, rjhmId, ids, usersPrivs,itemType);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 4:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JCGZ)){
					result = signJtPreDict(rtype, qtype, rjhmId, ids, usersPrivs,itemType);
				}else{
					result = "noprivilege_failure";
				}
				break;
			case 5:
				if(usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_YSY)){
					result = signJtPreDict(rtype, qtype, rjhmId, ids, usersPrivs,itemType);
				}else{
					result = "noprivilege_failure";
				}
				break;
			default:
				result = "failure";
				break;
		}
		return result;
	}
	
	/**
	 * 工长签字（机修）  version old
	 * 1、判断该班组是否全部完成--修改节点记录表状态 2、判断当前节点下的所有班组是否全部完成--进入下一个流程
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String gzSignJCfixrec(int rtype, int qtype, int rjhmId,String ids, UsersPrivs usersPrivs){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		boolean flag = false;
		List<JCFixrec> list = null;
		boolean roleFlag = usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_GZ);
		if(roleFlag){
			if(qtype==1){
				list = signWorkDao.listJCFixrec(rjhmId,usersPrivs.getBzid(),(short)1);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JCFixrec fixrec : list){
						fixrec.setLead(usersPrivs.getXm());
						fixrec.setLdAffirmTime(now);
						fixrec.setRecStas((short)2);
						workDao.updateJCFixRec(fixrec);
					}
					flag = true;
				}
			}else{
				String[] recIds = ids.split("-");
				JCFixrec fixrec = null;
				for(String id : recIds){
					fixrec = workDao.getJCFixrecById(Long.parseLong(id));
					fixrec.setLead(usersPrivs.getXm());
					fixrec.setLdAffirmTime(now);
					fixrec.setRecStas((short)2);
					workDao.updateJCFixRec(fixrec);
				}
				flag = true;
			}
			if(flag){
				Long count = signWorkDao.countUnfinishJCFixRec(rjhmId,usersPrivs.getBzid(),(short)2);
				if(count==0){//判断是否全部完成
					JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, usersPrivs.getBzid(), Contains.XX_JX_NODEID);
					flowRec.setFinishStatus((short)1);
					flowRec.setFinishTime(new Date());
					jcFlowRecDao.saveOrUpdate(flowRec);
					count = jcFlowRecDao.countUnfinishRec(rjhmId, Contains.XX_JX_NODEID);
					if(count==0){
						DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
						JCFixflow fixflow = new JCFixflow();
						fixflow.setJcFlowId(Contains.XX_SY_NODEID);
						datePlanPri.setNodeid(fixflow);
						datePlanPriDao.saveOrUpdate(datePlanPri);
					}
				}
			}
		}else{
			result = "noprivilege_failure";
		}
		return result;
	}
	
	/**
	 * 工长签字（机修） version new
	 * 1、判断该班组是否全部完成--修改节点记录表状态 
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String gzSignJCfixrecNew(int rtype, int qtype, int rjhmId,String ids, UsersPrivs usersPrivs){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		List<JCFixrec> list = null;
		boolean roleFlag = usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_GZ);
		if(roleFlag){
			if(qtype==1){//全签
				list = signWorkDao.listJCFixrec(rjhmId,usersPrivs.getBzid(),(short)1);
				if(list==null || list.size()==0){//不是本班组用户，不能签认
					result = "noprivilege_failure";
				}else{
					Long count=signWorkDao.countUnfinishJcFixrec(rtype, rjhmId,usersPrivs);
					if(count!=null&&count==0){//工人全部签认完成
						for(JCFixrec fixrec : list){
							fixrec.setLead(usersPrivs.getXm());
							fixrec.setLdAffirmTime(now);
							fixrec.setRecStas((short)2);
							workDao.updateJCFixRec(fixrec);
						}
						count = signWorkDao.countUnfinishJCFixRec(rjhmId,usersPrivs.getBzid(),(short)2);
						if(count==0){//判断是否全部完成
							JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, usersPrivs.getBzid(), Contains.XX_JX_NODEID);
							flowRec.setFinishStatus((short)1);
							flowRec.setFinishTime(new Date());
							jcFlowRecDao.saveOrUpdate(flowRec);
						}
					}else{
						result="working";
					}
				}
			}else{
				//没有单签
			}
		}else{
			result = "noprivilege_failure";
		}
		return result;
	}
	
	/**
	 * 工长签字（机修） version new
	 * 1、判断该班组是否全部完成--修改节点记录表状态 
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String gzSignJCZXfixrecNew(int rtype, int qtype, int rjhmId,String ids, UsersPrivs usersPrivs){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		List<JCZXFixRec> list = null;
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
		boolean roleFlag = usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_GZ);
		if(roleFlag){
			if(qtype==1){//全签
				list = signWorkDao.listJCZXFixRec(rjhmId,usersPrivs.getBzid(),(short)1);
				if(list==null || list.size()==0){//不是本班组用户，不能签认
					result = "noprivilege_failure";
				}else{
					Long count=signWorkDao.countUnfinishJcZxFixrec(rtype, rjhmId,usersPrivs);
					if(count!=null&&count==0){//工人全部签认完成
						for(JCZXFixRec fixrec : list){
							fixrec.setLead(usersPrivs.getXm());
							fixrec.setLdAffirmTime(now);
							fixrec.setRecStas((short)2);
							workDao.updateJCZXFixRec(fixrec);
						}
						//分解节点，工长签认完成，班组完成
//						if(datePlanPri.getNodeid().getJcFlowId()==Contains.ZX_FG_NODEID){
//							finishWorkByBz(rjhmId, usersPrivs.getBzid());
//						}
						Long zjCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_ZJ,rjhmId,usersPrivs.getBzid());
						Long ysCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_YS,rjhmId,usersPrivs.getBzid());
						if(zjCount==0&&ysCount==0){//质检或验收要卡控的项目都签认完成，班组完成
							finishWorkByBz(rjhmId,usersPrivs.getBzid());
						}
//						int nextRoleKc=signWorkDao.findZXFixRecNextRoleKc(1,rjhmId,usersPrivs.getBzid());
//						Long roleJcFixrec=signWorkDao.countUnfinishRoleJcFixrec(1,rjhmId,usersPrivs.getBzid());
//						if(nextRoleKc==0&&roleJcFixrec==0){//班组下项目没有后续卡控项目并且班组下本角色卡控项目都签认完成，班组完成
//							JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, usersPrivs.getBzid(),datePlanPri.getNodeid().getJcFlowId());
//							flowRec.setFinishStatus((short)1);
//							flowRec.setFinishTime(new Date());
//							jcFlowRecDao.saveOrUpdate(flowRec);
//						}
					}else{
						result="working";
					}
				}
			}else{
				//没有单签
			}
		}else{
			result = "noprivilege_failure";
		}
		return result;
	}
	
	/**
	 * 质检、技术、验收、交车工长签字（机修）  version old
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String signJCFixRec(int rtype, int qtype, int rjhmId,
		String ids, UsersPrivs usersPrivs){
		String result = "success";
		List<JCFixrec> list = null;
		if(qtype==1){//全签
			if(rtype==2 || rtype==3){
				list = signWorkDao.listJCFixrec(rjhmId, rtype, usersPrivs.getUserid(),0);
			}else{
				list = signWorkDao.listJCFixrec(rjhmId, rtype, usersPrivs.getUserid(),0);
			}
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				for(JCFixrec fixrec : list){
					workDao.updateJCFixRec(updateSignJCFixrec(fixrec,usersPrivs,rtype));
				}
			}
		}else{
			String[] recIds = ids.split("-");
			JCFixrec fixrec = null;
			for(String id : recIds){
				fixrec = workDao.getJCFixrecById(Long.parseLong(id));
				workDao.updateJCFixRec(updateSignJCFixrec(fixrec,usersPrivs,rtype));
			}
		}
		return result;
	}
	
	/**
	 * 质检、技术、验收、交车工长签字（机修）  version new
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String signJCFixRecNew(int rtype, int qtype, int rjhmId,
		String ids, UsersPrivs usersPrivs){
		String result = "success";
		List<JCFixrec> list = null;
		Long count=null;
		if(qtype==1){//全签
			list = signWorkDao.listJCFixrec(rjhmId, rtype, usersPrivs.getUserid(),0);
			if(rtype!=4){//交车工长不考虑
				count=signWorkDao.countUnfinishJcFixrec(rtype, rjhmId,usersPrivs);
				if(count!=null&&count>0){
					return "working";
				}
			}
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				if(signWorkDao.countNoSignItemOfRole(rjhmId,2)>0 && rtype==5|| signWorkDao.countNoSignItemOfRole(rjhmId,3)>0 && rtype==5){
					return "working";
				}
				for(JCFixrec fixrec : list){
					workDao.updateJCFixRec(updateSignJCFixrec(fixrec,usersPrivs,rtype));
				}
				if(rtype==5){//验收签完后，进入到下一个流程
					count = jcFlowRecDao.countUnfinishRec(rjhmId, Contains.XX_JX_NODEID);
					if(count==0){
						DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
						JCFixflow fixflow = new JCFixflow();
						fixflow.setJcFlowId(Contains.XX_SY_NODEID);
						datePlanPri.setNodeid(fixflow);
						datePlanPriDao.saveOrUpdate(datePlanPri);
					}
				}
			}
		}else{
			//单签业务逻辑(质检或技术)
			String[] recIds = ids.split("-");
			JCFixrec fixrec =null;
			for(String id : recIds){
				fixrec = workDao.getJCFixrecById(Long.parseLong(id));
				workDao.updateJCFixRec(updateSignJCFixrec(fixrec,usersPrivs,rtype));
			}
		}
		return result;
	}
	
	/**
	 * 中修质检、技术、验收、交车工长签字（机修）  version new
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String signJCZxFixRecNew(int rtype, int qtype, int rjhmId,
		String ids, UsersPrivs usersPrivs){
		String result = "success";
		List<JCZXFixRec> list = null;
		Long count=null;
		if(qtype==1){//全签
			list = signWorkDao.listJCZXFixRec(rjhmId, rtype, usersPrivs.getUserid(),0);
			if(rtype!=4){//交车工长不考虑
				count=signWorkDao.countUnfinishJcZxFixrec(rtype, rjhmId,usersPrivs);
				if(count!=null&&count>0){
					return "working";
				}
			}
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				Map<Long,Long> map=new HashMap<Long,Long>();
				for(JCZXFixRec fixrec : list){
					workDao.updateJCZXFixRec(updateSignJCZxFixrec(fixrec,usersPrivs,rtype));
					Long bzId=fixrec.getBzId();
					if(map.get(bzId)==null){
						map.put(bzId, bzId);
					}
				}
				Set<Long> bzIds=map.keySet();
				for(Long bzId:bzIds){
					Long zjCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_ZJ,rjhmId,bzId);
					Long ysCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_YS,rjhmId,bzId);
					if(zjCount==0&&ysCount==0){//质检或验收要卡控的项目都签认完成，班组完成
						finishWorkByBz(rjhmId,bzId);
					}
				}
			}
		}else{
			//单签业务逻辑(质检或技术)
			String[] recIds = ids.split("-");
			JCZXFixRec fixrec =null;
			Map<Long,Long> map=new HashMap<Long,Long>();
			for(String id : recIds){
				fixrec = workDao.getJCZXFixRecById(Long.parseLong(id));
				workDao.updateJCZXFixRec(updateSignJCZxFixrec(fixrec,usersPrivs,rtype));
				Long bzId=fixrec.getBzId();
				if(map.get(bzId)==null){
					map.put(bzId, bzId);
				}
			}
			Set<Long> bzIds=map.keySet();
			for(Long bzId:bzIds){
				Long zjCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_ZJ,rjhmId,bzId);
				Long ysCount=signWorkDao.countUnfinishRoleJcFixrec(Contains.ROLE_YS,rjhmId,bzId);
				if(zjCount==0&&ysCount==0){//质检或验收要卡控的项目都签认完成，班组完成
					finishWorkByBz(rjhmId,bzId);
				}
			}
		}
		return result;
	}
	
	/**
	 * 根据角色修改签名（机修）2：技术 3:质检 4:交车工长 5：验收
	 */
	private JCFixrec updateSignJCFixrec(JCFixrec fixrec,UsersPrivs usersPrivs,int rtype){
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(rtype==2){
			fixrec.setTech(usersPrivs.getXm());
			fixrec.setTechAffiTime(now);
		}else if(rtype==3){
			fixrec.setQi(usersPrivs.getXm());
			fixrec.setQiAffiTime(now);
		}else if(rtype==4){
			fixrec.setCommitLead(usersPrivs.getXm());
			fixrec.setComLdAffiTime(now);
		}else{
			fixrec.setAccepter(usersPrivs.getXm());
			fixrec.setAcceAffiTime(now);
		}
		return fixrec;
	}
	
	/**
	 * 根据角色修改签名（机修）2：技术 3:质检 4:交车工长 5：验收
	 */
	private JCZXFixRec updateSignJCZxFixrec(JCZXFixRec fixrec,UsersPrivs usersPrivs,int rtype){
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(rtype==2){
			fixrec.setTeachName(usersPrivs.getXm());
			fixrec.setTeachAffiTime(now);
		}else if(rtype==3){
			fixrec.setQi(usersPrivs.getXm());
			fixrec.setQiAffiTime(now);
		}else if(rtype==4){
			fixrec.setCommitLead(usersPrivs.getXm());
			fixrec.setComLdAffiTime(now);
		}else{
			fixrec.setAcceptEr(usersPrivs.getXm());
			fixrec.setAcceAffiTime(now);
		}
		return fixrec;
	}
	
	/**
	 * 工长签字（秋整春鉴）
	 * 判断是否全部完成--进入交车状态
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String gzSignJCQZFixRec(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		boolean flag = false;
		List<JCQZFixRec> list = null;
		boolean roleFlag = usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_GZ);
		if(roleFlag){
			if(qtype==1){
				list = signWorkDao.listJCQZFixRec(rjhmId, usersPrivs.getBzid(),(short)1);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JCQZFixRec fixrec : list){
						fixrec.setLead(usersPrivs.getUserid()+"");
						fixrec.setLeadName(usersPrivs.getXm());
						fixrec.setLdAffirmTime(now);
						fixrec.setRecStas((short)2);
						jcqzFixDao.updateJCQZFixRec(fixrec);
					}
					flag = true;
				}
			}else{
				String[] recIds = ids.split("-");
				JCQZFixRec fixrec =null;
				for(String id : recIds){
					fixrec = jcqzFixDao.getJCQZFixRec(Long.parseLong(id));
					fixrec.setLead(usersPrivs.getUserid()+"");
					fixrec.setLeadName(usersPrivs.getXm());
					fixrec.setLdAffirmTime(now);
					fixrec.setRecStas((short)2);
					jcqzFixDao.updateJCQZFixRec(fixrec);
				}
				flag = true;
			}
			if(flag){
				Long count = signWorkDao.countUnfinishJCQZFixRec(rjhmId, usersPrivs.getBzid(), (short)2);
				if(count==0){//判断是否全部完成
					JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, usersPrivs.getBzid(), Contains.XX_JX_NODEID);
					flowRec.setFinishStatus((short)1);
					flowRec.setFinishTime(new Date());
					jcFlowRecDao.saveOrUpdate(flowRec);
					count = jcFlowRecDao.countUnfinishRec(rjhmId, Contains.XX_JX_NODEID);
					if(count==0){
						DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
						JCFixflow fixflow = new JCFixflow();
						fixflow.setJcFlowId(Contains.XX_SY_NODEID);
						//datePlanPri.setPlanStatue(0);
						datePlanPri.setNodeid(fixflow);
						datePlanPriDao.saveOrUpdate(datePlanPri);
					}
				}
			}
		}else{
			result = "noprivilege_failure";
		}
		return result;
	}
	
	/**
	 * 质检、技术、验收、交车工长签字（秋整春鉴）
	 * 判断是否全部完成--进入待验状态
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String signJCQZFixRec(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs){
		String result = "success";
		List<JCQZFixRec> list = null;
		if(qtype==1){
			list = signWorkDao.listJCQZFixRec(rjhmId,rtype,0,usersPrivs);
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				for(JCQZFixRec fixrec : list){
					jcqzFixDao.updateJCQZFixRec(updateSignJCQZFixRec(fixrec,usersPrivs,rtype));
				}
			}
		}else{
			String[] recIds = ids.split("-");
			JCQZFixRec fixrec = null;
			for(String id : recIds){
				fixrec = jcqzFixDao.getJCQZFixRec(Long.parseLong(id));
				jcqzFixDao.updateJCQZFixRec(updateSignJCQZFixRec(fixrec,usersPrivs,rtype));
			}
		}
		return result;
	}
	
	/**
	 * 根据角色修改签名（机修）2：技术 3:质检 4:交车工长 5：验收
	 */
	private JCQZFixRec updateSignJCQZFixRec(JCQZFixRec fixrec,UsersPrivs usersPrivs,int rtype){
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(rtype==2){
			fixrec.setTech(usersPrivs.getXm());
			fixrec.setTechAffiTime(now);
		}else if(rtype==3){
			fixrec.setQi(usersPrivs.getXm());
			fixrec.setQiAffiTime(now);
		}else if(rtype==4){
			fixrec.setCommitLead(usersPrivs.getXm());
			fixrec.setComLdAffiTime(now);
		}else{
			fixrec.setAccepter(usersPrivs.getXm());
			fixrec.setAcceAffiTime(now);
		}
		return fixrec;
	}
	
	/**
	 * 工长签字（临修加改）
	 * 判断是否全部完成--进入交车状态
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String gzSignJtPreDict(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs,Short itemType){
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		boolean flag = false;
		List<JtPreDict> list = null;
		boolean roleFlag = usersPrivsDao.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_GZ);
		if(roleFlag){
			if(qtype==1){
				list = signWorkDao.listJtPreDict(rjhmId, usersPrivs.getBzid(),(short)3,itemType);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JtPreDict fixrec : list){
						fixrec.setLead(usersPrivs.getXm());
						fixrec.setLdAffirmTime(now);
						fixrec.setRecStas((short)4);
						jtPreDictDao.updateJtPreDict(fixrec);
					}
					flag = true;
				}
			}else{
				String[] recIds = ids.split("-");
				JtPreDict fixrec =null;
				for(String id : recIds){
					fixrec = jtPreDictDao.getJtPreDictById(Integer.parseInt(id));
					fixrec.setLead(usersPrivs.getXm());
					fixrec.setLdAffirmTime(now);
					fixrec.setRecStas((short)4);
					jtPreDictDao.updateJtPreDict(fixrec);
				}
				flag = true;
			}
			if(flag && itemType==Contains.LX_JG_TYPE){
				Long count = signWorkDao.countUnfinishJtPreDict(rjhmId, usersPrivs.getBzid(), (short)4,itemType);//注意状态应该是大于1小于4
				if(count==0){//判断是否全部完成
					JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(rjhmId, usersPrivs.getBzid(), Contains.XX_JX_NODEID);
					flowRec.setFinishStatus((short)1);
					flowRec.setFinishTime(new Date());
					jcFlowRecDao.saveOrUpdate(flowRec);
					count = jcFlowRecDao.countUnfinishRec(rjhmId, Contains.XX_JX_NODEID);
					if(count==0){
						DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
						JCFixflow fixflow = new JCFixflow();
						fixflow.setJcFlowId(Contains.XX_SY_NODEID);
						//datePlanPri.setPlanStatue(0);
						datePlanPri.setNodeid(fixflow);
						datePlanPriDao.saveOrUpdate(datePlanPri);
					}
					
				}
			}
		}else{
			result = "noprivilege_failure";
		}
		return result;
	}
	
	/**
	 * 质检、技术、验收、交车工长签字（临修加改）
	 * 判断是否全部完成--进入待验状态
	 * @param rtype
	 * @param qtype
	 * @param rjhmId
	 * @param ids
	 * @param usersPrivs
	 * @return
	 */
	private String signJtPreDict(int rtype, int qtype, int rjhmId,
			String ids, UsersPrivs usersPrivs,Short itemType){
		String result = "success";
		List<JtPreDict> list = null;
		if(qtype==1){
			list = signWorkDao.listJtPreDict(rjhmId, rtype,0,itemType,usersPrivs);
			if(list==null || list.size()==0){
				result = "noprivilege_failure";
			}else{
				for(JtPreDict fixrec : list){
					jtPreDictDao.updateJtPreDict(updateSignJtPreDict(fixrec,usersPrivs,rtype));
				}
			}
		}else{
			String[] recIds = ids.split("-");
			JtPreDict fixrec = null;
			for(String id : recIds){
				fixrec = jtPreDictDao.getJtPreDictById(Integer.parseInt(id));
				jtPreDictDao.updateJtPreDict(updateSignJtPreDict(fixrec,usersPrivs,rtype));
			}
		}
		return result;
	}
	
	/**
	 * 根据角色修改签名（临修加改）2：技术 3:质检 4:交车工长 5：验收
	 */
	private JtPreDict updateSignJtPreDict(JtPreDict fixrec,UsersPrivs usersPrivs,int rtype){
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(rtype==2){
			fixrec.setTechnician(usersPrivs.getXm());
			fixrec.setTechAffiTime(now);
		}else if(rtype==3){
			fixrec.setQi(usersPrivs.getXm());
			fixrec.setQiAffiTime(now);
		}else if(rtype==4){
			fixrec.setCommitLd(usersPrivs.getXm());
			fixrec.setComLdAffiTime(now);
		}else{
			fixrec.setAccepter(usersPrivs.getXm());
			fixrec.setAcceTime(now);
		}
		return fixrec;
	}
	
	/**
	 * 班组完成，修改流程记录信息，并判断节点下班组是否都完成，节点跳转
	 * @param datePlanId
	 * @param bzId
	 */
	private void finishWorkByBz(Integer datePlanId,long bzId){
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(datePlanId);
		JCFlowRec flowRec = jcFlowRecDao.getJCFlowRec(datePlanId, bzId,datePlanPri.getNodeid().getJcFlowId());
		flowRec.setFinishStatus((short)1);
		flowRec.setFinishTime(new Date());
		jcFlowRecDao.saveOrUpdate(flowRec);
		//节点下所有班组完成，进入下一流程节点
		Long count=signWorkDao.countUnfinishBzFixFlow(datePlanId, datePlanPri.getNodeid().getJcFlowId());
		if(count!=null&&count==0){//日计划下节点下班组都完成，进入下一流程
			//流程节点跳转
			if(datePlanPri.getNodeid().getJcFlowId()==Contains.ZX_FG_NODEID){
				//分解节点进入车上组装节点
				planManageService.nodeToReverse(datePlanId, null, Contains.ZX_CSZZ_NODEID);
			}else{
				//车上组装进入实验节点
				JCFixflow fixFlow=new JCFixflow();
				fixFlow.setJcFlowId(Contains.ZX_SY_NODEID);
				datePlanPri.setNodeid(fixFlow);
				datePlanPriDao.saveOrUpdate(datePlanPri);
			}
		}
	}

	@Override
	public List<DictProTeam> listNotChargeProTeam(Integer rjhmId) {
		return signWorkDao.listNotChargeProTeam(rjhmId);
	}
	
	@Override
	public List<DictProTeam> listZxNotChargeProTeam(Integer rjhmId) {
		return signWorkDao.listZxNotChargeProTeam(rjhmId);
	}

	@Override
	public List<JCFixrec> listNotChargeJCFixrec(int rjhmId, long bzId,UsersPrivs usersPrivs,int flag) {
		return signWorkDao.listNotChargeJCFixrec(rjhmId, bzId,usersPrivs,flag);
	}
	
	@Override
	public List<JCZXFixRec> listNotChargeJCZxFixrec(int rjhmId, long bzId,UsersPrivs usersPrivs,int flag) {
		return signWorkDao.listNotChargeJCZxFixrec(rjhmId, bzId,usersPrivs,flag);
	}
	
	@Override
	public List<JCQZFixRec> listNotChargeJCQZFixRec(int rjhmId, long bzId) {
		return signWorkDao.listNotChargeJCQZFixRec(rjhmId, bzId);
	}

	@Override
	public List<JtPreDict> listNotChargeJtPreDict(int rjhmId, long bzId) {
		return signWorkDao.listNotChargeJtPreDict(rjhmId, bzId);
	}

	@Override
	public int countSignedByBz(int rjhmId, long bzId, int roleType) {
		return signWorkDao.countSignedByBz(rjhmId, bzId, roleType);
	}
	
	@Override
	public int countZxSignedByBz(int rjhmId, long bzId, int roleType) {
		return signWorkDao.countZxSignedByBz(rjhmId, bzId, roleType);
	}
	
	public List<DatePlanPri> findDyPlanJCBy(String jcNum, String projectType){
		return signWorkDao.findDyPlanJCBy(jcNum, projectType);
	}

	@Override
	public List<Map<String, Object>> findUnfinishedBz(int rjhmId, int roleType,int jcType) {
		List<Map<String, Object>> UnfinishedBzs=null;
		Map<String,Object> map=null;
		List<Object[]> list=null;
		if(jcType==0){
			list=signWorkDao.findUnfinishedBz(rjhmId, roleType);
		}else{
			list=signWorkDao.findUnfinishedZXBz(rjhmId, roleType);
		}
		if(list!=null&&list.size()>0){
			UnfinishedBzs=new ArrayList<Map<String,Object>>();
			for(Object[] obj:list){
				map=new HashMap<String,Object>();
				map.put("proteamId", obj[0]);
				map.put("proteamName", obj[1]);
				map.put("count", obj[2]);
				UnfinishedBzs.add(map);
			}
		}
		return UnfinishedBzs;
	}

	@Override
	public String updateReSignReport(UsersPrivs usersPrivs,String dealSituation, Integer preDictId) {
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		
		JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictId);
		preDict.setDealSituation(dealSituation);
		preDict.setDealFixEmp(","+usersPrivs.getXm()+",");
		preDict.setFixEndTime(now);
		preDict.setRecStas((short)3);
		jtPreDictDao.saveOrUpdate(preDict);
		return result;
	}

	@Override
	public String updateLeadReSignReport(UsersPrivs usersPrivs,Integer preDictId) {
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		
		JtPreDict preDict = jtPreDictDao.findJtPreDictById(preDictId);
		Integer role = signWorkDao.findRoleId(usersPrivs.getUserid());
		//3---工长；6---质检员；7---技术员；8---验收员；9---交车工长
		
		if(role == 3){
			preDict.setLead(usersPrivs.getXm());
			preDict.setLdAffirmTime(now);
			preDict.setRecStas((short)4);
		}
		if(role == 6){
			preDict.setQi(usersPrivs.getXm());
			preDict.setQiAffiTime(now);
			preDict.setRecStas((short)5);
		}
		if(role == 7){
			preDict.setTechnician(usersPrivs.getXm());
			preDict.setTechAffiTime(now);
			preDict.setRecStas((short)5);
		}
		if(role == 8){
			preDict.setAccepter(usersPrivs.getXm());
			preDict.setAcceTime(now);
			preDict.setRecStas((short)5);
		}
		if(role == 9){
			preDict.setCommitLd(usersPrivs.getXm());
			preDict.setComLdAffiTime(now);
			preDict.setRecStas((short)5);
		}
		jtPreDictDao.saveOrUpdate(preDict);
		return result;
	}

	@Override
	public int checkRoleSign(int rihmId) {
		int count = 0;
		int qiCounts = signWorkDao.findRoleSign(1, rihmId);
		int techCounts = signWorkDao.findRoleSign(2, rihmId);
		int comCounts = signWorkDao.findRoleSign(3, rihmId);
		int acceCounts = signWorkDao.findRoleSign(4, rihmId);

		if (qiCounts != 0) {
			count = qiCounts;
			return count;
		}
		if (techCounts != 0) {
			count = techCounts;
			return count;
		}
		if (comCounts != 0) {
			count = comCounts;
			return count;
		}
		if (acceCounts != 0) {
			count = acceCounts;
			return count;
		}
		return count;
	}
	
}
