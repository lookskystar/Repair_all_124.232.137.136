package com.repair.work.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCQZItems;
import com.repair.common.pojo.UsersPrivs;
import com.repair.work.dao.JCQZFixDao;
import com.repair.work.service.JCQZFixService;

public class JCQZFixServiceImpl implements JCQZFixService{
	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Resource(name="jcqzFixDao")
	private JCQZFixDao jcqzFixDao;
	
	/**
	 * 根据ID获取
	 */
	public JCQZFixRec getJCQZFixRec(long recId){
		return jcqzFixDao.getJCQZFixRec(recId);
	}
	
	/**
	 * 保存或修改
	 */
	public void updateJCQZFixRec(JCQZFixRec jcqzFixRec){
		jcqzFixDao.updateJCQZFixRec(jcqzFixRec);
	}
	
	/**
	 * 根据修次修次与班组获取项目
	 */
	public List<JCQZItems> getJCQZFix(String jcfix,Long bzId,String jcstype){
		return jcqzFixDao.getJCQZFix(jcfix, bzId,jcstype);
	}
	
	/**
	 * 查询的分工记录
	 * @param userId 用户ID
	 */
	public List<DatePlanPri> listMyJCQZFix(long userId){
		return jcqzFixDao.listMyJCQZFix(userId);
	}
	
	/**
	 * 查询我的分工
	 */
	public List<JCQZFixRec> listMyJCQZFixRec(int rjhmId,UsersPrivs user,Short itemType,boolean flag){
		return jcqzFixDao.listMyJCQZFixRec(rjhmId, user,itemType,1,flag);
	}

	/**
	 * 秋整春鉴工人签字
	 * @param type 0：检查项目 1：检测项目
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户　 
	 * @return value_failure:检测项目值不对   noprivilege_failure:不是指定的检修人  success:成功
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public String updateJCQZFixRecOfWorkerRatify(short type, int qtype,
			int rjhmId, String checkInfo, String ids, UsersPrivs worker, JSONObject itemJsonObj) throws Exception {
		String result = "success";
		String now = YMDHMS_SDFORMAT.format(new Date());
		if(type==1){
			if(worker.getRoles().equals(",GZ,")){
				JCQZFixRec jcqzFixRec = jcqzFixDao.getJCQZFixRec(Long.parseLong(ids));
					double temp = Double.parseDouble(checkInfo);
					if(temp<jcqzFixRec.getItems().getMin() || temp>jcqzFixRec.getItems().getMax()){
						result = "value_failure";
					}else{
						jcqzFixRec.setFixEmp(dealString(jcqzFixRec.getFixEmp(),worker.getXm()));
						jcqzFixRec.setEmpAfformTime(now);
						jcqzFixRec.setFixSituation(checkInfo);
						jcqzFixRec.setRecStas((short)1);
						jcqzFixDao.updateJCQZFixRec(jcqzFixRec);
					}
			}else{
				JCQZFixRec jcqzFixRec = null;
				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					String id = itemIter.next();
					jcqzFixRec = jcqzFixDao.getJCQZFixRec(Long.parseLong(id));
					jcqzFixRec.setFixEmp(dealString(jcqzFixRec.getFixEmp(),worker.getXm()));
					jcqzFixRec.setEmpAfformTime(now);
					jcqzFixRec.setFixSituation((String)itemJsonObj.get(id));
					jcqzFixRec.setRecStas((short)1);
					jcqzFixDao.updateJCQZFixRec(jcqzFixRec);
				}
			}
		}else{
			if(qtype==1){
				List<JCQZFixRec> list = jcqzFixDao.listMyJCQZFixRec(rjhmId, worker, type,0,true);
				if(list==null || list.size()==0){
					result = "noprivilege_failure";
				}else{
					for(JCQZFixRec rec : list){
						rec.setFixEmp(dealString(rec.getFixEmp(),worker.getXm()));
						rec.setEmpAfformTime(now);
						rec.setFixSituation(rec.getItems().getFillDefaVal());
						rec.setRecStas((short)1);
						jcqzFixDao.updateJCQZFixRec(rec);
					}
				}
			}else{
				JCQZFixRec jcqzFixRec = null;
				String[] idArr = ids.split("-");
				for (String id : idArr) {
					jcqzFixRec = jcqzFixDao.getJCQZFixRec(Long.parseLong(id));
					//if(jcqzFixRec.getWorkerId().indexOf(","+worker.getUserid()+",")<0){
						//result = "noprivilege_failure";
					//}else{
						jcqzFixRec.setFixEmp(dealString(jcqzFixRec.getFixEmp(),worker.getXm()));
						jcqzFixRec.setEmpAfformTime(now);
						jcqzFixRec.setFixSituation(checkInfo);
						jcqzFixRec.setRecStas((short)1);
						jcqzFixDao.updateJCQZFixRec(jcqzFixRec);
					}
				//}
			}
		}
		return result;
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
}
