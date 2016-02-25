package com.repair.work.action;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCQZRange;
import com.repair.common.pojo.JcQzZlPd;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.ZeroScore;
import com.repair.experiment.action.BaseAction;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.query.service.QueryService;
import com.repair.work.dao.JCQZRangeDao;
import com.repair.work.dao.JtPreDictDao;
import com.repair.work.dao.ZeroScoreDao;
import com.repair.work.service.JtPreDictService;
import com.repair.work.service.OilAssayService;
import com.repair.work.service.QZService;
import com.repair.work.service.ZeroScoreService;

/**
 *
* @ClassName: QZAction
* @Description: TODO  秋整相关
* @author 周云韬
* @version V1.0  
* @date 2015-10-12 下午2:22:33
 */

public class QZAction extends BaseAction{
	
	@Resource(name="jcQZRangeDao")
	private JCQZRangeDao jcQZRangeDao;
	
	@Resource(name="jtPreDictService")
	private JtPreDictService jtPreDictService;
	
	@Resource(name="zeroScoreService")
	private ZeroScoreService zeroScoreService;
	
	@Resource(name="datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	/**
	 * 秋整统计
	 * @return String    
	 * @throws
	 */
	public String statistics(){
		List<JCQZRange> list=jcQZRangeDao.listPlanJCQZRange();
		
		//key：机车类型	value：计划完成个数
		Map<String, Long> planMap=new HashMap<String, Long>();
		for (JCQZRange jcqzRange : list) {
			Long count=planMap.get(jcqzRange.getJctype());
			
			if(count == null){
				planMap.put(jcqzRange.getJctype(), 1L);
			}else{
				planMap.put(jcqzRange.getJctype(), ++count);
				
			}
		}
		
		Map<String, Long> realMap=new HashMap<String, Long>();
		Iterator<Entry<String, Long>>  it=planMap.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, Long> r=it.next();
			realMap.put(r.getKey(), jcQZRangeDao.getJcTypeRealTotalCount(r.getKey()));
		}
		
		request.setAttribute("planMap", planMap);
		request.setAttribute("realMap", realMap);
		return "statistics";
	}
	
	/**
	 * 列出零公里报活
	 * @return String    
	 * @throws
	 */
	public String listZeroPreDict(){
		
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		DatePlanPri dpp=datePlanPriDao.findDatePlanPriById(rjhmId);
		//如果非秋整机车，不列出
		if("QZ".equals(dpp.getFixFreque())){
			List<JtPreDict> zeroPreDictList=getZeroPreDictList(rjhmId);
			request.setAttribute("dpp", dpp);
			request.setAttribute("zeroPreDictList", zeroPreDictList);
		}
		return "listZeroPreDict";
	}
	
	/**
	 * 获取零公里报活
	 * @return List<JtPreDict>    
	 * @throws
	 */
	private List<JtPreDict> getZeroPreDictList(int rjhid){
		List<JtPreDict> jtPreDictlist=jtPreDictService.findJtPreDictByDatePlan(rjhid);
		List<JtPreDict> zeroPreDictList=new ArrayList<JtPreDict>();
		for (JtPreDict jtPreDict : jtPreDictlist) {
			if(jtPreDict.getType() == 6){
				zeroPreDictList.add(jtPreDict);
			}
		}
		return zeroPreDictList;
	}
	
	/**
	 * 零公里报活评分
	 * @return String    
	 * @throws
	 */
	public String ajaxGradeZeroPreDict() throws IOException{
		try{
			int preDictId = Integer.parseInt(request.getParameter("preDictId"));
			Double score=Double.parseDouble(request.getParameter("score"));
			
			ZeroScore zeroScore=zeroScoreService.findByJtPreDictId(preDictId);
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			
			if(zeroScore == null){
				JtPreDict jtPreDict=jtPreDictService.findJtPreDictById(preDictId);
				zeroScore=new ZeroScore(jtPreDict, score,user);
				zeroScoreService.addZeroScore(zeroScore);
			}else{
				zeroScore.setScore(score);
				zeroScore.setSignUsers(user);
				zeroScoreService.updateZeroScore(zeroScore);
			}
			response.getWriter().write("操作成功");
		}catch (Exception e) {
			response.getWriter().write("操作失败");
		}
		return null;
	}
	
	/**
	 * ajax查询机车质量评定分数及是否可以交车
	 * @return String    
	 * @throws
	 */
	public String ajaxSelectZeroScore() throws IOException{
		int rjhid = Integer.parseInt(request.getParameter("rjhid"));
		DatePlanPri dpp=datePlanPriDao.findDatePlanPriById(rjhid);
		if(!"QZ".equals(dpp.getFixFreque())){
			response.getWriter().write("非秋整机车");
			return null;
		}
		
		
		List<JtPreDict> zeroPreDictList=getZeroPreDictList(rjhid);
		response.setCharacterEncoding("UTF-8");
		
		double score=0;
		for (JtPreDict jtPreDict : zeroPreDictList) {
			
			Iterator<ZeroScore> it= jtPreDict.getZeroScoreSet().iterator();
			if(!it.hasNext()){
				response.getWriter().write("评分未完成");
				return null;
			}else{
				score += it.next().getScore();
			}
		}
		if(dpp.getJcQzZlPdSet().isEmpty()){
			response.getWriter().write("机车质量评定未签认");
			return null;
		}
		response.getWriter().write(""+score);
		return null;
	}
	
	
	
	
	/**  油水化验action层代码 */
	
	private String xcxc;
	
	private List<DatePlanPri> list;
	
	@Resource(name="queryService")
	private QueryService queryService;
	
	@Resource(name="oilAssayService")
	private OilAssayService oilAssayService;
	
	@Resource(name="qzService")
	private QZService qzService;
	
	 
	/**
	 * 导航栏检修记录二级菜单点击油水进入，油水试验查询结果页面
	 * 从新书写的QzAction
	 * 唐鹏  2015/10/13
	 */
	public String queryOil(){
		Map<String,String> map=new HashMap<String,String>();
		if(xcxc!=null&&!xcxc.equals("0")){
			map.put("fixFreque", xcxc.toUpperCase());
		}
		list=this.queryService.findDatePlanPri(map);
		return "queryOil";
	}
	
	/**
	 * 油水化验记录主表
	 * @return
	 */
	public String findOilAssayPriRecorder()
	{
		List<OilAssayPriRecorder> oilAPRecorderList=qzService.findAllOilAssayPriRecorder();
		request.setAttribute("oilAPRecorderList", oilAPRecorderList);
		return "findOilAssayPriRecorder";
	}

	 /**
     * 导航栏中的油水试验入口，进入检修记录页面，点击记录查看进入油水试验记录页面
     * 油水试验 通过日计划Id查询对应的油水插入记录主表，在通过油水插入记录主表Id
     * 查询对应的记录表数据
     * 
     * @return OIL_ASSAY_DETAILRECORER表集合
     * 唐鹏  2015/10/13
     */
    public String findOilAssayByRjhId(){
    	Integer rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
    	/**通过日计划Id查询油化实验记录主表**/
    	OilAssayPriRecorder oilAPRecorder=qzService.findOilAssayPriRecorderById(rjhmId);

    	if(oilAPRecorder == null){
    		return "findOilAssayByRjhId" ;
    	}
    	/**通过油化实验记录主表Id,查询对应的油化实验记录IAO数据**/
    	List<OilAssayDetailRecorer> reocrdList=qzService.findOilAssayDetailRecorerById(oilAPRecorder.getRecPriId());
    	
    	Map<OilAssayItem, List<OilAssayDetailRecorer>> map=new HashMap<OilAssayItem, List<OilAssayDetailRecorer>>();
    	for (OilAssayDetailRecorer o : reocrdList) {
    		List<OilAssayDetailRecorer> tempList=map.get(o.getSubItemId().getReportItemId());
    		
    		if(tempList==null){
    			tempList=new ArrayList<OilAssayDetailRecorer>();
    		}
    		tempList.add(o);
    		map.put(o.getSubItemId().getReportItemId(), tempList);
		}
    	request.setAttribute("map", map);
    	return "findOilAssayByRjhId" ;
    }
    
	/**
	 * 秋整机车质量评定签认
	 * @return String    
	 * @throws IOException 
	 */
    public String signJcQzZlPd() throws IOException{
    	response.setCharacterEncoding("UTF-8");
    	try{
	    	Integer rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
	    	DatePlanPri dpp=datePlanPriDao.findDatePlanPriById(rjhmId);
	    	UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
	    	if(user ==null){
	    		response.getWriter().write("请先登录");
	    		return null;
	    	}
	    	JcQzZlPd zlpd=new JcQzZlPd(dpp,user,new Timestamp(System.currentTimeMillis()));
	    	qzService.saveJcQzZlPd(zlpd);
	    	response.getWriter().write("操作成功");
    	}catch (Exception e) {
    		e.printStackTrace();
    		response.getWriter().write("操作失败");
    	}
    	return null;
    }
    
    
	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public void setList(List<DatePlanPri> list) {
		this.list = list;
	}

	public List<DatePlanPri> getList() {
		return list;
	}
	
}
