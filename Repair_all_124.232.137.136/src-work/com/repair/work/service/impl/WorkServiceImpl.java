package com.repair.work.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.annotation.Resource;
import org.json.JSONObject;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;
import com.repair.part.dao.PJStaticInfoDao;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.work.dao.JCQZFixDao;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.UsersPrivsDao;
import com.repair.work.dao.WorkDao;
import com.repair.work.service.WorkService;
/**
 * 检修作业
 * @author Administrator
 *
 */
public class WorkServiceImpl implements WorkService{
	
	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Resource(name="workDao")
	private WorkDao workDao;
	@Resource(name="usersPrivsDao")
	private UsersPrivsDao usersPrivsDao;
	@Resource(name="jtPreDictDao")
	private JtPreDictDao jtPreDictDao;
	@Resource(name="jcqzFixDao")
	private JCQZFixDao jcqzFixDao;
	@Resource(name="pjStaticInfoDao")
	private PJStaticInfoDao pjStaticInfoDao;
	@Resource(name="dictProTeamDao")
	private DictProTeamDao dictProTeamDao;
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 内容：
	 * 根据pjdid(配件id)修改PJ_DynamicInfo表中StorePosition字段值为2(存储位置：0-中心库，1-班组，2-车上，3-外地，4-配件上)，GetOnNum字段为jcnum(机车编号)。
	 * 并把pjNums(配件编号)，以字符串类型的格式，如：001，002...存储在变量，pjNum中，然后根据preDictId（报活主键id），查找jt_PreDict（报活记录表），
	 * 找出报活记录，修改其UpPjNum字段（配件编号），把pjNum的值更新其中。
	 * 通过pjnum（配件编号）更新pJFixRecord（配件检修记录表）的planId（rjmid）[日计划id]字段。
	 * @param pjNumArray（更新配件编号数组),pjNumOldArray(原配件编号数组),jcnum(机车编号),preDictId（报活记录id）
	 * @return void
	 */
	public void updatePJDynamicInfosByPjNumAndJtPreDict(String[] pjNumArray,String [] pjNumOldArray,String jcnum,Integer preDictId,Integer planId){
		String pjNums=null;//配件编码字符串的表现形式，格式：0001，0002，....
		
		//修改原配件状态
		if(pjNumOldArray!=null){
			for (int i = 0; i < pjNumOldArray.length; i++) {
				PJDynamicInfo pJDynamicInfo=new PJDynamicInfo();
				PJFixRecord pJFixRecord =new PJFixRecord();
				
				//通过pjNum(配件编号)，得到pjdid(配件id)
				pJDynamicInfo=workDao.findPJDynamicInfoByNum(pjNumOldArray[i]);
				//通过pjdid得到pJFixRecord，修改该表的planId（rjmid）日计划id
				pJFixRecord=workDao.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
				if (pJFixRecord!=null) {
					pJFixRecord.setRjhmId(planId);
					workDao.saveOrUpdatePJFixRecord(pJFixRecord);
				}
				pJDynamicInfo.setStorePosition(0);
				pJDynamicInfo.setGetOnNum("");
				//通过pjdid修改以上两个属性	
				workDao.updateStorePositionAndGetOnNumForPJDynamicInfoByPjdid(pJDynamicInfo);
			}
		}
		
		//添加更新新配件状态
		if(pjNumArray!=null){
			
			for (int i = 0; i < pjNumArray.length; i++) {
				pjNums+=pjNumArray[i]+",";
				PJDynamicInfo pJDynamicInfo=new PJDynamicInfo();
				PJFixRecord pJFixRecord =new PJFixRecord();
				//通过pjNum(配件编号)，得到pjdid(配件id)
				pJDynamicInfo=workDao.findPJDynamicInfoByNum(pjNumArray[i]);
				
				//通过pjdid得到pJFixRecord，修改该表的planId（rjmid）日计划id
				pJFixRecord=workDao.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
				if (pJFixRecord!=null) {
					pJFixRecord.setRjhmId(planId);
					workDao.saveOrUpdatePJFixRecord(pJFixRecord);
				}
				
				pJDynamicInfo.setStorePosition(2);
				pJDynamicInfo.setGetOnNum(jcnum);
				//通过pjdid修改以上两个属性	
				workDao.updateStorePositionAndGetOnNumForPJDynamicInfoByPjdid(pJDynamicInfo);
			}
			//pjNum去末尾逗号，去null
			pjNums=pjNums.substring(0, pjNums.length()-1);
			pjNums=pjNums.replace("null", "");
			JtPreDict jtPreDict=new JtPreDict();
			//根据preDictId得到所有的JtPreDict对象
			jtPreDict=workDao.getJtPreDictBypreDictId(preDictId);
			jtPreDict.setUpPjNum(pjNums);//修改oracle数据库jt_PreDict对应字段UpPjNum，原来为30，现改为200
			
			//根据jtPreDictId，修改该对象
			workDao.updateUpPjNumForJtPreDictByPreDictId(jtPreDict);
		}
	}
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 内容：
	 * 根据pjdid(配件id)修改PJ_DynamicInfo表中StorePosition字段值为2(存储位置：0-中心库，1-班组，2-车上，3-外地，4-配件上)，GetOnNum字段为jcnum(机车编号)。
	 * 并把pjNum(配件编号)，以字符串类型的格式，如：001，002...存储在变量，pjNum中，然后根据preDictId（报活主键id），查找jt_PreDict（报活记录表），
	 * 找出报活记录，修改其UpPjNum字段（配件编号），把pjNum的值更新其中。
	 * @param pjNumArray{字符串数组，存储元素格式[(pjdid配件动态id，唯一的）：pjNum配件编码，有可能重复)]},jcnum(机车编号),preDictId（报活记录id）
	 * @return void
	 */
	public void updateStorePositionsAndGetOnNumsByPjdidForPJDynamicInfos_updateUpPjNumByPreDictIdForJtPreDict(String[] pjNumArray,String jcnum,Integer preDictId){
		String pjNum=null;//配件编码字符串的表现形式，格式：0001，0002，....
		String pjdidStr=null;
		Long pjdidLong=null; //pjdid
		
		//2、只要有pjdidStr就合并所有的pjNum成一个字符串，格式为001,002,003,...
		for (int i = 0; i < pjNumArray.length; i++) {
			pjdidStr=pjNumArray[i].substring(0, pjNumArray[i].indexOf(":"));
			if(pjdidStr!=null){
				pjNum+=pjNumArray[i].substring(pjNumArray[i].indexOf(":")+1, pjNumArray[i].length())+",";
				pjdidLong=Long.parseLong(pjdidStr);
				PJDynamicInfo pJDynamicInfo=new PJDynamicInfo();
				pJDynamicInfo=workDao.getPJDynamicInfoByPjdid(pjdidLong);
				pJDynamicInfo.setStorePosition(2);
				pJDynamicInfo.setGetOnNum(jcnum);
				
				workDao.updateStorePositionAndGetOnNumForPJDynamicInfoByPjdid(pJDynamicInfo);
			}	
		}
		//pjNum去末尾逗号，去null
		pjNum=pjNum.substring(0, pjNum.length()-1);
		pjNum=pjNum.replace("null", "");
		JtPreDict jtPreDict=new JtPreDict();
		//3、根据preDictId得到所有的JtPreDict对象
		jtPreDict=workDao.getJtPreDictBypreDictId(preDictId);
		jtPreDict.setUpPjNum(pjNum);
		
		//4、根据jtPreDictId，修改该对象
		workDao.updateUpPjNumForJtPreDictByPreDictId(jtPreDict);
	}

	/**
	 * 作者：黄亮
	 * 时间：2015-5-26
	 * 通过preDictId得到JtPreDict对象
	 * @param preDictId
	 * @return
	 */
	public JtPreDict getJtPreDictBypreDictId(Integer preDictId){
		return workDao.getJtPreDictBypreDictId(preDictId);
	}
	
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-25
	 * 通过pjdid（配件动态id）修改PJDynamicInfo表的storePosition字段值为2,把getOnNum更新为jcnum。
	 */
	public void updateStorePositionByPjdid(String pjdid,Integer storePosition,String jcnum){
		workDao.updateStorePositionByPjdid(pjdid,storePosition,jcnum);
	}
	
	
	
	
	/**
	 * 查询日计划机车列表(状态)
	 * @param bzId 班组ID
	 * @param planStatue 计划状态
	 */
	public List<DatePlanPri> findDyPlanJC(long bzId,int statue,Integer nodeId){
		return workDao.findDyPlanJC(bzId, statue, nodeId);
	}
	
	/**
	 * 查询作业分工(机修)
	 */
	public List<JCDivision> listJCDivision(int rjhmId, Long bzId){
		return workDao.listJCDivision(rjhmId, bzId);
	}
	
	/**
	 * 添加作业分工(机修)
	 */
	public void saveJCDivision(int rjhmId, String presetId,UsersPrivs leader,String workersId,String jcnum,String jctype){
		JCDivision division = null;
		Long userId = null;
		
		PresetDivision presetDivision = null;
		DatePlanPri datePlanPri = new DatePlanPri();
		datePlanPri.setRjhmId(rjhmId);
		UsersPrivs usersPrivs = new UsersPrivs();
		String[] ids = workersId.split(",");
		String[] pids = presetId.split(",");
		int preId = 0;
		String date = YMDHMS_SDFORMAT.format(new Date());
		for(int j=0;j<pids.length;j++){
			preId = Integer.parseInt(pids[j]);
			presetDivision = new PresetDivision();
			presetDivision.setProSetId(preId);
			
			for (int i = 0; i < ids.length; i++) {
				userId = Long.parseLong(ids[i]);
				if(workDao.getJCDivision(userId, preId,rjhmId)==null){//判断是否该项目分给该用户了，若是直接跳过，否则新增
					division = new JCDivision();
					division.setDayPlan(datePlanPri);
					division.setFgDate(date);
					division.setLeader(leader);
					division.setPresetDivision(presetDivision);
					usersPrivs.setUserid(userId);
					division.setUser(usersPrivs);
					workDao.addJCDivision(division);
				}
			}
			//保存分工项目记录
			workDao.saveOrUpdateJCFixrec(rjhmId, preId, workersId, leader.getBzid(), jcnum, jctype,date);
			
			//如果报活记录中存在预设分工，更新检修人和检修人ID
			String fixEmpId=",";
			String fixEmp=",";
			List<JCDivision> jcDivisions=jtPreDictDao.listJCDivision(preId, rjhmId);
			if(jcDivisions!=null&&jcDivisions.size()>0){
				for(JCDivision jcd:jcDivisions){
					fixEmpId+=jcd.getUser().getUserid()+",";
					fixEmp+=jcd.getUser().getXm()+",";
				}
			}
			//根据预设ID查询相应的报活项目
			List<JtPreDict> jtPreDicts=workDao.queryJtPreDictByDivisionId(preId);
			if(jtPreDicts!=null&&jtPreDicts.size()>0){
				for(JtPreDict jtPreDict:jtPreDicts){
					//JtPreDict jtPreDict=jtPreDictDao.findJtPreDictById(jpd.getPreDictId());
					jtPreDict.setFixEmp(fixEmp);
					jtPreDict.setFixEmpId(fixEmpId);
					jtPreDictDao.updateJtPreDict(jtPreDict);
				}
			}
		}
	}
	
	/**
	 * 删除作业分工(机修)
	 * @param presetId 分工记录ID
	 */
	public long deleteJCDivision(int presetId){
		JCDivision division = workDao.getJCDivisionById(presetId);
		int rjhmId = division.getDayPlan().getRjhmId();
		int prosetId = division.getPresetDivision().getProSetId();//预设大类ID
		UsersPrivs u = division.getUser();
		
		//统计用户已签项目数
		long result = workDao.countWorkedItems(prosetId,u.getXm(),rjhmId);
		
		if(result==0){//表示工人还未签认项目
			List<JCDivision> divisionList = workDao.listJCDivision(rjhmId, prosetId);
			if(divisionList.size()>1){//同一大类分给多个用户,修改项目记录表中的分配用户
				String worksId = ",";
				Long tempId ; 
				for (int i = 0; i < divisionList.size(); i++) {
					tempId = divisionList.get(i).getUser().getUserid();
					if(u.getUserid()!=tempId){
						worksId += tempId+",";
					}
				}
				workDao.updateJcFixrecWorkersId(worksId,rjhmId,prosetId);
			}else{//只分配了当前用户
				workDao.deleteJcFixRec(rjhmId,prosetId);
			}
			//删除分工记录
			workDao.deleteDivison(division);
		}
		return result;
	}
	
	/**
	 * 工人查询派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 */
	public List<JCFixrec>  listMyJCFixRec(int rjhmId,UsersPrivs user,short itemType,boolean flag){
		return workDao.listMyJCFixRec(rjhmId,user,itemType,1,flag);
	}
	
	public void updateJCFixRec(JCFixrec jcFixrec){
		workDao.updateJCFixRec(jcFixrec);
	}
	
	/**
	 * 工人查询派工项目(机修)
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param itemType 0:检查项目 1：检测项目
	 */
	public List<JCZXFixRec>  listMyJCZxFixRec(int rjhmId,UsersPrivs user,short itemType,boolean flag){
		return workDao.listMyJCZxFixRec(rjhmId,user,itemType,1,flag);
	}
	
	public List<JCZXFixRec> listJCZXFixRec(int rjhmId,Long bzId){
		return workDao.listJCZXFixRec(rjhmId,bzId);
	}
	
	/**
	 * 查询已分工的项目记录(临修、加改)
	 */
	public List<JtPreDict> listJtPreDictByDivisionStatus(int rjhmId,Long bzId){
		return workDao.listJtPreDictByDivisionStatus(rjhmId,bzId);
	}
	
	/**
	 * 修改项目记录(报活、临修、加改)
	 */
	public void updateJtPreDict(int recId, String workersId) {
		String[] users = getUsers(workersId);
		jtPreDictDao.updateJtPreDictFixEmp(recId,users[0],users[1]);
	}
	
	/**
	 * 取消分工(报活、临修、加改)
	 */
	public long deleteJtPreDictDivision(int recId){
		long result = 0;
		JtPreDict jtPreDict = jtPreDictDao.getJtPreDictById(recId);
		if((jtPreDict.getDealFixEmp()!=null && !"".equals(jtPreDict.getDealFixEmp())) || jtPreDict.getRecStas()>2){
			result = 1;
		}else{
			jtPreDictDao.updateJtPreDictFixEmp(recId, "", "");
		}
		return result;
	}
	
	/**
	 * 查询已分工的项目记录(春鉴、秋整)
	 */
	public List<JCQZFixRec> listJCQZFixRec(int rjhmId,Long bzId){
		return workDao.listJCQZFixRec(rjhmId, bzId);
	}
	
	/**
	 * 添加项目记录(春鉴、秋整)
	 */
	public void saveJCQZFixRec(int rjhmId,int itemId,String workersId,long bzId){
		JCQZFixRec jcqzFixRec = new JCQZFixRec();
		JCQZItems items = workDao.getJCQZItemsById(itemId);
		jcqzFixRec.setJwdCode(items.getJwdCode());
		jcqzFixRec.setItems(items);
		jcqzFixRec.setItemName(items.getItemName());
		jcqzFixRec.setMoren(items.getFillDefaVal());
		if(items.getFillDefaVal() == null || "".equals(items.getFillDefaVal())){
			jcqzFixRec.setItemType((short)1);
		}else{
			jcqzFixRec.setItemType((short)0);
		}
		
		String[] users = getUsers(workersId);
		jcqzFixRec.setWorkerId(users[0]);
		jcqzFixRec.setWorkerName(users[1]);
		
		jcqzFixRec.setRecStas((short)0);
		DatePlanPri datePlanPri = new DatePlanPri();
		datePlanPri.setRjhmId(rjhmId);
		jcqzFixRec.setJcRecmId(datePlanPri);
		jcqzFixRec.setBzId(bzId);
		
		workDao.saveOrUpdateJCQZFixRec(jcqzFixRec);
	}
	
	/**
	 * 删除项目记录(春鉴、秋整)
	 */
	public long deleteJCQZFixRec(long recId){
		JCQZFixRec fixRec = jcqzFixDao.getJCQZFixRec(recId);
		if((fixRec.getFixEmp()==null || "".equals(fixRec.getFixEmp())) && fixRec.getRecStas()==0){//工人未签字检修
			jcqzFixDao.deleteJCQZFixRec(fixRec);
			return new Long(0);
		}else{
			return new Long(1);
		}
	}
	
	/**
	 * 工人签字(机修)
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 * @throws JSONException 
	 * @throws NumberFormatException 
	 */
	@SuppressWarnings("unchecked")
	public String updateJCFixRecOfWokerRatify(short type,int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker, JSONObject itemJsonObj) throws Exception{
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(type==1){
			if(worker.getRoles().equals(",GZ,")){
				JCFixrec jcFixrec = workDao.getJCFixrecById(Long.parseLong(ids));
					double temp = Double.parseDouble(checkInfo);
					if(temp<jcFixrec.getFixitem().getMin() || temp>jcFixrec.getFixitem().getMax()){
						result = "value_failure";
					}else{
						jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
						jcFixrec.setEmpAfformTime(now);
						jcFixrec.setFixSituation(checkInfo);
						jcFixrec.setRecStas((short)1);
						workDao.updateJCFixRec(jcFixrec);
					}
			}else{
				JCFixrec jcFixrec = null;
				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					String id = itemIter.next();
					jcFixrec = workDao.getJCFixrecById(Long.parseLong(id));
					jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
					jcFixrec.setEmpAfformTime(now);
					jcFixrec.setFixSituation((String) itemJsonObj.get(id));
					jcFixrec.setRecStas((short)1);
					workDao.updateJCFixRec(jcFixrec);
				}
			}
		}else{
			if(qtype==1){
				List<JCFixrec> list = workDao.listMyJCFixRec(rjhmId, worker, type,0,true);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JCFixrec rec : list){
						rec.setFixEmp(dealString(rec.getFixEmp(),worker.getXm()));
						rec.setEmpAfformTime(now);
						rec.setFixSituation(rec.getFixitem().getFillDefaVal());
						rec.setRecStas((short)1);
						workDao.updateJCFixRec(rec);
					}
				}
			}else{
				JCFixrec jcFixrec = null;
				String[] idArr = ids.split("-");
				for (String id : idArr) {
					jcFixrec = workDao.getJCFixrecById(Long.parseLong(id));
					//if(jcFixrec.getFixEmpId().indexOf(","+worker.getUserid()+",")<0){
						//result = "noprivilege_failure";
					//}else{
						jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
						jcFixrec.setEmpAfformTime(now);
						jcFixrec.setFixSituation(checkInfo);
						jcFixrec.setRecStas((short)1);
						workDao.updateJCFixRec(jcFixrec);
					//}
				}
			}
		}
		return result;
	}
	
	/**
	 * 中修工人签字(机修)
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 * @throws JSONException 
	 * @throws NumberFormatException 
	 */
	@SuppressWarnings("unchecked")
	public String updateJCZxFixRecOfWokerRatify(short type,int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker, JSONObject itemJsonObj) throws Exception{
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(type==1){
			if(worker.getRoles().equals(",GZ,")){
				JCZXFixRec jcFixrec = workDao.getJCZXFixRecById(Long.parseLong(ids));
					double temp = Double.parseDouble(checkInfo);
					if(temp<jcFixrec.getItemId().getMin() || temp>jcFixrec.getItemId().getMax()){
						result = "value_failure";
					}else{
						jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
						jcFixrec.setFixEmpTime(now);
						jcFixrec.setFixSituation(checkInfo);
						jcFixrec.setRecStas((short)1);
						workDao.updateJCZXFixRec(jcFixrec);
					}
			}else{
				JCZXFixRec jcFixrec = null;
				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					String id = itemIter.next();
					jcFixrec = workDao.getJCZXFixRecById(Long.parseLong(id));
					jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
					jcFixrec.setFixEmpTime(now);
					jcFixrec.setFixSituation((String) itemJsonObj.get(id));
					jcFixrec.setRecStas((short)1);
					workDao.updateJCZXFixRec(jcFixrec);
				}
			}
		}else{
			if(qtype==1){
				List<JCZXFixRec> list = workDao.listMyJCZxFixRec(rjhmId, worker, type,0,true);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JCZXFixRec rec : list){
						rec.setFixEmp(dealString(rec.getFixEmp(),worker.getXm()));
						rec.setFixEmpTime(now);
						rec.setFixSituation(rec.getItemId().getFillDefaval());
						rec.setRecStas((short)1);
						workDao.updateJCZXFixRec(rec);
					}
				}
			}else{
				if(null == itemJsonObj) {
					JCZXFixRec jcFixrec = null;
					String[] idArr = ids.split("-");
					for (String id : idArr) {
						jcFixrec = workDao.getJCZXFixRecById(Long.parseLong(id));
						jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
						jcFixrec.setFixEmpTime(now);
						jcFixrec.setFixSituation(checkInfo);
						jcFixrec.setRecStas((short)1);
						workDao.updateJCZXFixRec(jcFixrec);
					}
				} else {
					JSONObject jsonObject = new JSONObject();
					JCZXFixRec jcFixrec = null;
					for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
						String id = itemIter.next();
						jcFixrec = workDao.getJCZXFixRecById(Long.parseLong(id));
						jcFixrec.setFixEmp(dealString(jcFixrec.getFixEmp(),worker.getXm()));
						jcFixrec.setFixEmpTime(now);
						jcFixrec.setFixSituation((String) itemJsonObj.get(id));
						jcFixrec.setRecStas((short)1);
						workDao.updateJCZXFixRec(jcFixrec);
					}
					jsonObject.put("time", new SimpleDateFormat("yyyy-MM-dd HH:ss").format(new Date()));
					jsonObject.put("fixEmp", dealString(jcFixrec.getFixEmp(),worker.getXm()));
					jsonObject.put("success", true);
					result = jsonObject.toString();
				} 
			}
		}
		return result;
	}
	
	/**
	 * 查询检测记录
	 */
	public JCFixrec queryJCFixrecByID(long jcrecid){
		return workDao.queryJCFixrecByID(jcrecid);
	}
	
	/**
	 * 查询检测记录
	 */
	public JCZXFixRec queryJCZxFixrecByID(long jcrecid){
		return workDao.queryJCZxFixrecByID(jcrecid);
	}
	/**
	 * 查询检测项目
	 */
	public JCFixitem queryJCFixitemByID(int thirdunitid){
		return workDao.queryJCFixitemByID(thirdunitid);
	}
	
	/**
	 * 查询中修检修项目
	 * @param thirdunitid
	 * @return
	 */
	public JCZXFixItem queryJCZxFixitemByID(int thirdunitid){
		return workDao.queryJCZxFixitemByID(thirdunitid);
	}
	
	/**
	 * 传入1,2,3 用户ID 获取用户ID和名字 ,1,2,3, ,张三,李四,王五,
	 */
	private String[] getUsers(String workersId){
		String workerId = "";
		String workerName = "";
		String[] ids = workersId.split(",");
		UsersPrivs usersPrivs = null;
		if(ids!=null && ids.length>0){
			workerId = ",";
			workerName = ",";
			for (int i = 0; i < ids.length; i++) {
				usersPrivs = usersPrivsDao.getUsersPrivsById(Long.parseLong(ids[i]));
				workerId += usersPrivs.getUserid()+",";
				workerName += usersPrivs.getXm()+",";
			}
		}
		return new String[]{workerId,workerName};
	}
	
	/**
	 * 去除重复字符串
	 */
	private String dealString(String oldStr,String subStr){
		String result = "";
		if(oldStr==null || "".equals(oldStr)){
			result = ","+subStr+",";
		}else{
			if(oldStr.indexOf(","+subStr+",")>=0){
				result = oldStr;
			}else{
				result = oldStr + subStr + ",";
			}
		}
		return result;
	}

	@Override
	public NrJcJyzb queryNrJcJyzb(Integer rjhmId) {
		return workDao.queryNrJcJyzb(rjhmId);
	}
	
	@Override
	public DlJcJyZb queryDlJcJyZb(Integer rjhmId) {
		return workDao.queryDlJcJyZb(rjhmId);
	}

	@Override
	public List<DlJcJyMxb> queryDlJcJyMxb(Integer jyzId) {
		return workDao.queryDlJcJyMxb(jyzId);
	}

	@Override
	public void saveOrUpdateNrFinishItem(NrJcJyzb nrJcJyzb) {
		workDao.saveOrUpdateNrJcJyzb(nrJcJyzb);
	}

	@Override
	public String saveOrUpdateDlJcJyMxb(DlJcJyMxb dlJcJyMxb) {
		 return workDao.saveOrUpdateDlJcJyMxb(dlJcJyMxb);
	}

	@Override
	public String saveOrUpdateDlJcJyzb(DlJcJyZb dlJcJyZb) {
		return workDao.saveOrUpdateDlJcJyzb(dlJcJyZb);
	}

	@Override
	public DlJcJyMxb queryDlJcJyMxbById(Integer jymxId) {
		return workDao.queryDlJcJyMxbById(jymxId);
	}
	
	@Override
	public Long countPjInfoByPjNum(String pjNum) {
		return workDao.countPjInfoByPjNum(pjNum);
	}

	@Override
	public void saveOrUpdateJCZXFixRec(JCZXFixRec jcZxFixRec) {
		workDao.saveOrUpdateJCZXFixRec(jcZxFixRec);
	}

	@Override
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String type, String pjName, String pjNum,String jcType) {
		return workDao.findPJDynamicInfo(type, pjName, pjNum,jcType);
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoById(Long pjdId) {
		return workDao.findPJDynamicInfoById(pjdId);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid) {
		return workDao.findPJFixRecord(pjdid);
	}

	@Override
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long planId) {
		return workDao.findPJFixRecord(pjdid, planId);
	}

	@Override
	public JCZXFixRec findJCZXFixRec(Long id) {
		return workDao.findJCZXFixRec(id);
	}

	@Override
	public PJDynamicInfo findPJDynamicInfoByNum(String pjNum) {
		return workDao.findPJDynamicInfoByNum(pjNum);
	}
	
	@Override
	public PJStaticInfo findPJStaticInfoById(Long stdId) {
		return pjStaticInfoDao.getPJStaticInfo(stdId);
	}
	
	@Override
	public PJFixRecord findPJFixRecordByPjDid(Long pjDid) {
		return workDao.findPJFixRecordByPjDid(pjDid);
	}

	@Override
	public void saveOrUpdatePJFixRecord(PJFixRecord pJFixRecord) {
		workDao.saveOrUpdatePJFixRecord(pJFixRecord);
	}

	@Override
	public void saveOrUpdatePJDynamicInfo(PJDynamicInfo pJDynamicInfo) {
		workDao.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
	}

	@Override
	public List<PJFixItem> findPJFixItemByPjSid(Long pjSid) {
		return workDao.findPJFixItemByPjSid(pjSid);
	}

	public DictProTeam findDictProTeamByPY(String py){
		return dictProTeamDao.findDictProTeamByPY(py);
	}
	
	public void updateJCFixRecOfDealSituation(Long id,String dealSituation){
		JCZXFixRec jczxFixRec = workDao.getJCZXFixRecById(id);
		jczxFixRec.setDealSituation(dealSituation);
		workDao.updateJCZXFixRec(jczxFixRec);
	}
	
	public void updateReptSign(List<Long> ids,UsersPrivs user,String time,int type){
		workDao.updateReptSign(ids,user,time,type);
	}
	
	public void updatePJFixRecOfDealSituation(Long id,String dealSituation){
		PJFixRecord pjFixRecord = workDao.getPJFixRecordByPjRecId(id);
		pjFixRecord.setDealSituaton(dealSituation);
		workDao.saveOrUpdatePJFixRecord(pjFixRecord);
	}

	@Override
	public JCZXFixRec findZxFixRecordById(Long recId) {
		return workDao.getJCZXFixRecById(recId);
	}

	/**
	 * 根据ID获取记录JCFixrec
	 */
	public JCFixrec getJCFixrecById(long jcRecId){
		return workDao.getJCFixrecById(jcRecId);
	}
}
