package com.repair.query.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.repair.admin.service.ReportTemplateService;
import com.repair.admin.service.SystemService;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.ItemRelation;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.YSJCRec;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.common.util.WebUtil;
import com.repair.experiment.service.ExperimentService;
import com.repair.experiment.service.JcExpRecService;
import com.repair.query.dao.impl.Query;
import com.repair.query.service.FittingService;
import com.repair.query.service.JcFixRecService;
import com.repair.query.service.QueryService;
import com.repair.work.service.UsersPrivsService;
import com.repair.work.service.WorkService;
import com.repair.work.service.YSJCRecService;

public class QueryAction {
	
	@Resource(name="queryService")
	private QueryService queryService;
	@Resource
	private JcExpRecService jcExpRecService;
	@Autowired
	private ExperimentService experimentService;
	@Resource(name="reportTemplateService")
	private ReportTemplateService reportTemplateService;
	@Resource(name="systemService")
	private SystemService systemService;
	@Resource(name="fittingService")
	private FittingService fittingService; // 配件服务
	@Resource(name="ysjcRecService")
	private YSJCRecService ysjcRecService;
	@Resource(name="workService")
	private WorkService workService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="aaa")
	private JcFixRecService jcFixRecService;
	
	private  Integer lastOne;
	private String startTime;
	private String endTime;
	private String jcType;
	private String jcStype;
	private Integer workFlag;
	private String jcNum;
	private String xcxc;
	private Integer fristUnit;
	private Long teams;
	private List<DatePlanPri> list;
	private String gonghao;
	private String flowval;
	private Integer rjhmId;//日计划ID
	private String id;
	private String jceiId;
	private String pjNum;
	
	private List<JCFixrec> fixRecs;
	private List<JCZXFixRec> zxFixRecs;
	private List<JCZXFixRec> jczxFixRecs;
	private List<JCQZFixRec> qzFixRecs;
	private List<JtPreDict> preDictRecs;
	private List<DictFirstUnit> units;
	private DatePlanPri  datePlan;
	private SignedForFinish signed;
	private String unitType;
	
	/**
	 * 所有的班组信息
	 */
	private List<DictProTeam> bzs;
	
	private Long teamId;
	
	private DictProTeam currentTeam;
	
	private String time;

	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat YMDH_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH");
	public static final String TIMESTAMPBEGIN = " 00:00:00";
	public static final String TIMESTAMPEND = " 23:59:59";
	
	/**
	 * 2015-05-11 黄亮，修改
	 * 根据条件查询日计划
	 * @return
	 */
	public String query(){
		Map<String,String> map=new HashMap<String,String>();
		String sTime=null;
		String eTime=null;
		if(endTime==null||"".equals(endTime)){
			endTime=YMDHMS_SDFORMAT.format(new Date());
			
		}
		eTime=endTime+" 23:59";
		if(startTime==null||"".equals(startTime)){
			//startTime=getPreDate();
			//2015-05-11 黄亮，修改 ,查询前一个月，该为查询该车所有记录
			startTime="2010-01-01";
		}
		sTime=startTime+" 00:00";
		map.put("startTime", sTime);
		map.put("endTime", eTime);
//		if(startTime!=null){
//			map.put("startTime", WebUtil.dateConvertString(startTime));
//		}
//		if(endTime!=null){
//			map.put("endTime", WebUtil.dateConvertString(endTime));
//		}
		if(jcType!=null&&!jcType.equals("0")){
			map.put("jcType", jcStype);
		}
		if(jcNum!=null&&!jcNum.equals("")&&!"".equals(jcNum.trim())){
			map.put("jcnum", jcNum.trim());
		}
		if(xcxc!=null&&!xcxc.equals("0")){
			map.put("fixFreque", xcxc.toUpperCase());
		}
		String items[];
//		if(!gudao.equals("0")){
//			items=gudao.split("-");
//			map.put("gdh", items[0]);
//			map.put("twh", items[0]);
//		}
		list=this.queryService.findDatePlanPri(map);
		return "success";
	}
	
	public String queryByXcxc(){
		Map<String,String> map=new HashMap<String,String>();
		if(xcxc!=null&&!xcxc.equals("0")){
			map.put("fixFreque", xcxc.toUpperCase());
		}
		list=this.queryService.findDatePlanPri(map);
		return "success";
	}
	
	/**
	 * 得到当前日期的上一个月时间
	 * @param date
	 * @return
	 */
	private String getPreDate(){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, -1);
		return YMDHMS_SDFORMAT.format(c.getTime());
	}


	/**
	 * 查看检修记录
	 * @return
	 */
	public String view(){
		HttpServletRequest request = ServletActionContext.getRequest();
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		xcxc=datePlan.getFixFreque();
		jcStype=datePlan.getJcType();
		//查询修成修次
		flowval = this.queryService.findXcxc(xcxc); 
		//报活检修
		this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());
		if(xcxc.startsWith("LX") || xcxc.startsWith("JG")|| xcxc.startsWith("ZZ")){//临修加改整治
			bzs=this.queryService.findAllProTeam(jcStype, 1);
			this.preDictRecs=queryService.findJtPreDict(datePlan.getRjhmId());
			return "lx";
		}else if(xcxc.startsWith("QZ") || xcxc.startsWith("CJ")){//秋整
//			signed=this.queryService.findSignedForFinishByPlan(datePlan.getRjhmId());
//			this.qzFixRecs=this.queryService.findJCQZFixRec(datePlan.getRjhmId());
//			return "qz";
			/**下列代码 2015-10-15编写 周云韬*/
			bzs=this.queryService.findAllProTeam(jcStype, 1);
			
			String flag = systemService.getParameterValueById(Contains.IS_USE_REPORT_TEMPLATE);
			//表示使用报表模板
			//  1、启用了报表模板 2、存在当前车型关联模板项目
			if(flag.equals("1") && reportTemplateService.countItemRelation(jcStype)>0){
				units = reportTemplateService.listFirstUnitsOfTemplate(jcStype);
				if(fristUnit!=null&&fristUnit!=0){//包含部件
					for(int i=0;i<units.size();i++){
						if(units.get(i).getFirstunitid().intValue()==fristUnit){
							this.unitType=units.get(i).getFirstunitname();
							break;
						}
					}
				}else{
					if(units.size()>0){
						fristUnit=units.get(0).getFirstunitid().intValue();
						this.unitType=units.get(0).getFirstunitname();
					}
				}
				List<ItemRelation> relations = reportTemplateService.listItemRelation(jcStype, xcxc, fristUnit,rjhmId);
				request.setAttribute("itemRelation", relations);
				return "xf_tpl";
			}else{
				units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
				if(fristUnit!=null&&fristUnit!=0){//包含部件
					for(int i=0;i<units.size();i++){
						if(units.get(i).getFirstunitid().intValue()==fristUnit){
							this.unitType=units.get(i).getFirstunitname();
							break;
						}
					}
				}else{
					if(units.size()>0){
						fristUnit=units.get(0).getFirstunitid().intValue();
						this.unitType=units.get(0).getFirstunitname();
					}
				}
				this.fixRecs=this.queryService.findJCFixrec(datePlan.getRjhmId(),unitType);
				return "xf";
			}
			
		}else {//小辅修
			
			bzs=this.queryService.findAllProTeam(jcStype, 1);
			
			String flag = systemService.getParameterValueById(Contains.IS_USE_REPORT_TEMPLATE);
			//表示使用报表模板
			//  1、启用了报表模板 2、存在当前车型关联模板项目
			if(flag.equals("1") && reportTemplateService.countItemRelation(jcStype)>0){
				units = reportTemplateService.listFirstUnitsOfTemplate(jcStype);
				if(fristUnit!=null&&fristUnit!=0){//包含部件
					for(int i=0;i<units.size();i++){
						if(units.get(i).getFirstunitid().intValue()==fristUnit){
							this.unitType=units.get(i).getFirstunitname();
							break;
						}
					}
				}else{
					if(units.size()>0){
						fristUnit=units.get(0).getFirstunitid().intValue();
						this.unitType=units.get(0).getFirstunitname();
					}
				}
				List<ItemRelation> relations = reportTemplateService.listItemRelation(jcStype, xcxc, fristUnit,rjhmId);
				request.setAttribute("itemRelation", relations);
				return "xf_tpl";
			}else{
				units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
				if(fristUnit!=null&&fristUnit!=0){//包含部件
					for(int i=0;i<units.size();i++){
						if(units.get(i).getFirstunitid().intValue()==fristUnit){
							this.unitType=units.get(i).getFirstunitname();
							break;
						}
					}
				}else{
					if(units.size()>0){
						fristUnit=units.get(0).getFirstunitid().intValue();
						this.unitType=units.get(0).getFirstunitname();
					}
				}
				this.fixRecs=this.queryService.findJCFixrec(datePlan.getRjhmId(),unitType);
				return "xf";
			}
		}
	}
	
	/**
	 * 中修记录展现
	 * @return
	 */
	public String zxView() {
		List<JCZXFixItem> zxItemList = null;
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Integer nodeId = datePlan.getNodeid().getJcFlowId();
		List<DictFirstUnit> temp =this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
		units = new ArrayList<DictFirstUnit>();
		for (int i = 0; i < temp.size(); i++) {
			if(queryService.countJCZXFixRec(datePlan.getRjhmId(), Integer.valueOf(temp.get(i).getFirstunitid()+""))>0){
				units.add(temp.get(i));
			}
		}
		
		if(fristUnit!=null&&fristUnit!=0){//包含部件
			for(int i=0;i<units.size();i++){
				if(units.get(i).getFirstunitid().intValue()==fristUnit){
					this.unitType=units.get(i).getFirstunitname();
					break;
				}
			}
		}else{
			if(units.size()>0){
				fristUnit=units.get(0).getFirstunitid().intValue();
				this.unitType=units.get(0).getFirstunitname();
			}
		}
		if(nodeId == Contains.ZX_FG_NODEID){
			zxItemList = queryService.findZXItem(Contains.ZX_CSZZ_NODEID, datePlan.getFixFreque(), datePlan.getJcType(), null, fristUnit);
		}
		this.jczxFixRecs=this.queryService.findJCZXFixRec(datePlan.getRjhmId(),fristUnit);
		ServletActionContext.getRequest().setAttribute("zxItemList", zxItemList);
		ServletActionContext.getRequest().setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		ServletActionContext.getRequest().setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		return "zx";
	}
	
	public String zxFittingView() {
		datePlan=this.queryService.findDatePlanPriById(Integer.parseInt(id));
		units=jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(id),1);
		if(fristUnit!=null&&fristUnit!=0){//包含部件
			for(int i=0;i<units.size();i++){
				if(units.get(i).getFirstunitid().intValue()==fristUnit){
					this.unitType=units.get(i).getFirstunitname();
					break;
				}
			}
		}else{
			if(units.size()>0){
				fristUnit=units.get(0).getFirstunitid().intValue();
				this.unitType=units.get(0).getFirstunitname();
			}
		}
		ServletActionContext.getRequest().setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		List<PJFixRecord> pjfixRecs = null;
		if (null != pjNum && !"".equals(pjNum)) {
			PJDynamicInfo dynamicInfo = fittingService.findDynamicInfoByPjNum(pjNum);
			unitType = dynamicInfo.getPjStaticInfo().getFirstUnit().getFirstunitname();
			pjfixRecs = fittingService.forNumAndDataPlan(pjNum);
//			pjfixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid());
		} else {
			pjfixRecs = fittingService.forFirstUnit(fristUnit,datePlan.getRjhmId());
		}
		ServletActionContext.getRequest().setAttribute("pjFixRecs", pjfixRecs);
		return "zxpj";
	}
	
	//显示单条数据记录
	public String zxFittingDetailView(){
		datePlan=this.queryService.findDatePlanPriById(Integer.parseInt(id));
		HttpServletRequest request=ServletActionContext.getRequest();
		Long staticId=Long.parseLong(request.getParameter("staticId"));
		List<PJDynamicInfo> dynamicInfos=queryService.findPJDynamicInfoBySID(staticId);
		List<String> jcPjNums=fittingService.findPjNums(Integer.parseInt(id));//查询机车所有填写的编号
		List<PJFixRecord> pjFixRecs=null;
		if(dynamicInfos!=null&&dynamicInfos.size()>0){
			for(PJDynamicInfo dynamicInfo:dynamicInfos){
				String pjNum=dynamicInfo.getPjNum();
				if(jcPjNums!=null&&jcPjNums.contains(pjNum)){
					pjFixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid());
					break;
				}
			}
		}
		if(dynamicInfos.size()==0||pjFixRecs==null){
			List<PJFixItem> pjFixItems=fittingService.findPjFixItemByStaticId(staticId);
			request.setAttribute("pjFixItems", pjFixItems);
		}
		request.setAttribute("pjStatic", fittingService.findPJStaticInfoById(staticId));
		request.setAttribute("pjFixRecs", pjFixRecs);
		request.setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
//		List<PJFixRecord> pjFixRecs=fittingService.forPjStaticId(staticId, datePlan.getRjhmId());
		return "zxpjdetail";
	}
	
	//显示多条数据记录
	public String zxFittingDetailViewNew(){
		datePlan=this.queryService.findDatePlanPriById(Integer.parseInt(id));
		HttpServletRequest request=ServletActionContext.getRequest();
		Long staticId=Long.parseLong(request.getParameter("staticId"));
		PJStaticInfo pjStatic=fittingService.findPJStaticInfoById(staticId);
		List<String> jcPjNums=fittingService.findPjNums(Integer.parseInt(id));//查询机车所有填写的编号
		//查询所有的上车动态配件信息
		List<PJDynamicInfo> dynamicInfos=fittingService.findPJDynamicInfoByPjNums(staticId, jcPjNums);
		int amount=pjStatic.getAmount()==null?0:pjStatic.getAmount().intValue();
		Map<PJDynamicInfo,List<PJFixRecord>> map=new HashMap<PJDynamicInfo,List<PJFixRecord>>();
		if(dynamicInfos!=null&&dynamicInfos.size()>0){
			for(PJDynamicInfo dynamicInfo:dynamicInfos){
				PJFixRecord record=fittingService.findPJFixRecordByRjhmId(Integer.parseInt(id),dynamicInfo.getPjdid());
				List<PJFixRecord> pjFixRecs=null;
				if(record==null){
					pjFixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid());
				}else{
					pjFixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid(),record.getPjRecId(),null);
				}
//				List<PJFixRecord> pjFixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid());
//				List<PJFixRecord> pjFixRecs=fittingService.findPJFixRecordByDid(dynamicInfo.getPjdid(),record.getPjRecId());
				map.put(dynamicInfo, pjFixRecs);
			}
		}
		
		Map<String,List<PJFixItem>> map1=new HashMap<String,List<PJFixItem>>();
		if(dynamicInfos.size()<amount){
			int value=amount-dynamicInfos.size();
			for(int i=0;i<value;i++){
				List<PJFixItem> pjFixItems=fittingService.findPjFixItemByStaticId(staticId);
				map1.put(i+"", pjFixItems);
			}
		}
		request.setAttribute("pjStatic", pjStatic);
		request.setAttribute("map", map);
		request.setAttribute("map1", map1);
		request.setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		return "zxpjdetail_new";
	}
	
	public String viewExperiment() {
		if (!WebUtil.isEmpty(id) && !WebUtil.isEmpty(jceiId)) {
			datePlan=this.queryService.findDatePlanPriById(Integer.parseInt(id));
			xcxc = datePlan.getFixFreque();
			flowval = this.queryService.findXcxc(xcxc); 
			units=jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(id),1);
			bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
			List<JcExpRec> jcExpRecs = jcExpRecService.findJcExpRecs(Integer.parseInt(id), Integer.parseInt(jceiId));
			Map<String, Object> maps = new HashMap<String, Object>();
			for (JcExpRec jcExpRec : jcExpRecs) {
				maps.put(jcExpRec.getItemName(), jcExpRec.getExpStatus());
			}
			
			ServletActionContext.getRequest().setAttribute("jceis", maps);
			ServletActionContext.getRequest().setAttribute("experiment", experimentService.findJcExperimentByDatePlanAndExpId(Integer.parseInt(id), jceiId));
			
			ServletActionContext.getRequest().setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
			if (null != fristUnit && fristUnit > 0) {
				ServletActionContext.getRequest().setAttribute("pjFixRecs", fittingService.forFirstUnit(fristUnit,datePlan.getRjhmId()));
			}
			if ("2".equals(jceiId)) {
				return "shuizu";
			} if ("3".equals(jceiId)) {
				if(datePlan.getJcType().contains("DF")){
					return "dfshiyunxing";
				}else{
					return "ssshiyunxing";
				}
			} if ("4".equals(jceiId)) {
				return "gaodiya";
			} if ("5".equals(jceiId)) {
				return "dinglun";
			}
		}
		return null;
	}
	
	public String viewJtPre(){
		datePlan=this.queryService.findDatePlanPriByJC(xcxc, jcStype, jcNum);
		this.preDictRecs=queryService.findAllJtPreDict(datePlan.getRjhmId());
		return "jtView";
	}
	
	/**
	 * 交车记录查询
	 * @return
	 */
	public String searchJcRec(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		List<YSJCRec> itemList = ysjcRecService.listYSJCRec(rjhmId);
		
		Map<String,List<YSJCRec>> itemListMap = new LinkedHashMap<String,List<YSJCRec>>();
		String classify = null;
		for (int i = 0; i < itemList.size(); i++) {
			classify = itemList.get(i).getClassify();
			if(itemListMap.get(classify) == null){
				itemListMap.put(classify, new ArrayList<YSJCRec>());
			}
			itemListMap.get(classify).add(itemList.get(i));
		}
		ServletActionContext.getRequest().setAttribute("itemListMap", itemListMap);
		request.setAttribute("rjhmId", rjhmId);
		return "ysjc";
	}
	
	/**
	 * 交车记录EXCEL导出
	 */
	public void excelExport() {
		String result = "success";
		String fielPath = null;
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String path = ServletActionContext.getServletContext().getRealPath("/");
		PrintWriter out = null;
		try {
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
			DatePlanPri datePlan = this.queryService.findDatePlanPriById(Integer.valueOf(rjhmId));
			List<YSJCRec> itemList = ysjcRecService.listYSJCRec(rjhmId);
			//数据封装
			Map<String,List<YSJCRec>> itemListMap = new LinkedHashMap<String,List<YSJCRec>>();
			String classify = null;
			for (int i = 0; i < itemList.size(); i++) {
				classify = itemList.get(i).getClassify();
				if(itemListMap.get(classify) == null){
					itemListMap.put(classify, new ArrayList<YSJCRec>());
				}
				itemListMap.get(classify).add(itemList.get(i));
			}
			out = response.getWriter();
			if(itemListMap.size() > 0){
				fielPath = excelExportUtil(itemListMap, classify, datePlan, path);
			}else {
				result = "nodata,"+fielPath;
			}
			result +=  ","+fielPath;
		} catch (Exception e) {
			result = "failure,"+ fielPath;
			e.printStackTrace();
		} finally {
			out.write(result);
		}
	}
	
	
	private String excelExportUtil(Map<String,List<YSJCRec>> itemListMap, String classify, DatePlanPri datePlan, String path) {
		String filePath = null;
		String downLoadPath = null;
		File file = null;
		FileOutputStream fos = null;
		// 生成一个工作簿
		HSSFWorkbook hwb = new HSSFWorkbook();
		//生成EXCEL
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		List<YSJCRec> dataList = null;
		String kcsj = datePlan.getKcsj();
		String preTime = kcsj.substring(0, 4) + kcsj.substring(5, 7) + kcsj.substring(8, 10);
		String jcType = datePlan.getJcType();
		String jcNum = datePlan.getJcnum();
		String frequence = datePlan.getFixFreque();
		try {
			for (Iterator<String> iterator = itemListMap.keySet().iterator(); iterator.hasNext();) {
				classify = iterator.next();
				dataList = itemListMap.get(classify);
				// 生成一个工作表(classify名为标识)
				sheet = hwb.createSheet(classify);
				// 为当前工作表生成表头行
				row = sheet.createRow(0);
				cell = row.createCell(0);
				cell.setCellValue("项目");
				cell = row.createCell(1);
				cell.setCellValue("情况");
				cell = row.createCell(2);
				cell.setCellValue("检修人");
				cell = row.createCell(3);
				cell.setCellValue("质检/技术");
				cell = row.createCell(4);
				cell.setCellValue("验收");
				cell = row.createCell(5);
				cell.setCellValue("交车工长");
				// 循环生成数据行
				for(int i = 0; i < dataList.size(); i++){
					YSJCRec nextRec =  dataList.get(i);
					row = sheet.createRow(i+1);
					cell = row.createCell(0);
					cell.setCellValue(dataList.get(i).getItemName());
					cell = row.createCell(1);
					if(nextRec.getUnit() != null){
						cell.setCellValue(nextRec.getFixSituation() + nextRec.getUnit());
					}else {
						cell.setCellValue(nextRec.getFixSituation());
					}
					cell = row.createCell(2);
					cell.setCellValue(nextRec.getFixemp());
					cell = row.createCell(3);
					cell.setCellValue(nextRec.getTech());
					cell = row.createCell(4);
					cell.setCellValue(nextRec.getAccept());
					cell = row.createCell(5);
					cell.setCellValue(nextRec.getCommitLead());
				}
			}
			File saveFile = new File(path+"excel");
			if(!saveFile.exists()){
				saveFile.mkdir();
			}
			filePath = saveFile.getAbsolutePath()+"\\"+ preTime + jcType + jcNum + frequence +".xls";
			downLoadPath = "excel\\"+ preTime + jcType + jcNum + frequence +".xls";
			file = new File(filePath);
			fos = new FileOutputStream(file);
			hwb.write(fos);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(fos != null){
					fos.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return downLoadPath;
	}
	
	
	
	/**
	 * 交车竣工查询
	 * @return
	 */
	public String searchJCjungong(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		if(datePlan.getProjectType()==0){//小辅修
			bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
		}else{
			bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);
		}
		ServletActionContext.getRequest().setAttribute("rec", queryService.getJCjungong(rjhmId));
		ServletActionContext.getRequest().setAttribute("nowtime", YMDH_SDFORMAT.format(new Date()));
		
		
		
		return "jungong";
	}
	
	/**
	 * 根据机车型号判断机车内型
	 */
	private int getJcsType(String jctype){
		String temp = jctype.trim().toUpperCase().substring(0, 2);
		if("SS".equals(temp)){
			return 1;
		}else if("DF".equals(temp)){
			return 2;
		}else{
			return 3;
		}
	}
	
	/**
	 * 查询机车的检修信息
	 * @return
	 */
	public String getInfoByJC(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		xcxc=datePlan.getFixFreque();
		//查询修成修次
		flowval = this.queryService.findXcxc(xcxc);
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),0);
		if(xcxc.startsWith("LX")||xcxc.startsWith("JG")||xcxc.startsWith("ZZ")){//临修加改	
			this.preDictRecs=queryService.findJtPreDict(datePlan.getRjhmId());
			return "info_jc_lx";
		}else if(xcxc.startsWith("QZ")||xcxc.startsWith("CJ")){
//			this.qzFixRecs=this.queryService.findJCQZFixRec(datePlan.getRjhmId());
//			return "info_jc_qz";
			/** 秋整整车记录查询        2015-10-15 修改  周云韬*/
			this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());//报活检修
			
			PageModel<JCFixrec> fixRecs=this.queryService.findJCFixrecLimited(datePlan.getRjhmId(),unitType);
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("fixRecs", fixRecs);
			return "info_jc";
		}else{
			this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());//报活检修
			
			PageModel<JCFixrec> fixRecs=this.queryService.findJCFixrecLimited(datePlan.getRjhmId(),unitType);
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("fixRecs", fixRecs);
			return "info_jc";
		}
		
	}
	
	/**
	 * 查询机车的检修信息
	 * @return
	 */
	public String getZxInfoByJC(){
		List<JCZXFixItem> zxItemList = null;
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Integer nodeid = datePlan.getNodeid().getJcFlowId();
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),1);
		this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());//报活检修
		PageModel<JCZXFixRec> zxFixRecs=this.queryService.findJCZXFixRecLimited(rjhmId);
		if(nodeid == Contains.ZX_FG_NODEID){
			zxItemList = queryService.findZXItem(Contains.ZX_CSZZ_NODEID, datePlan.getFixFreque(), datePlan.getJcType(), null, null);
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("zxFixRecs", zxFixRecs);
		request.setAttribute("zxItemList", zxItemList);
		return "zx_info_jc";
	}
	
	/**
	 * 查询机车所有的报活检修信息
	 * @return
	 */
	public String getAllInfoPre(){
		int JTNnum = 0, FJNnum = 0, JGNnum = 0, LGNnum = 0;
		String type = ServletActionContext.getRequest().getParameter("type");
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		if(datePlan.getProjectType()==0){//小辅修
			bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
		}else{
			bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);
		}
		//查询修成修次
		flowval = this.queryService.findXcxc(datePlan.getFixFreque());
		//报活检修
		if("work".equalsIgnoreCase(type)){
			this.preDictRecs=queryService.findJtPreDictByFlag(datePlan.getRjhmId(),teamId);
		}else{
			this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());
		}
		for (JtPreDict jtPreDict : preDictRecs) {
			if(jtPreDict.getType() == 0){
				JTNnum++;
			}else if(jtPreDict.getType() == 1){
				FJNnum++;
			}else if(jtPreDict.getType() == 2){
				JGNnum++;
			}else if(jtPreDict.getType() == 6){
				LGNnum++;
			}
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("JTNum", JTNnum);
		request.setAttribute("FJNum", FJNnum);
		request.setAttribute("JGNum", JGNnum);
		request.setAttribute("LGNum", LGNnum);
		return "info_pre_all";
	}
	
	/**
	 * 通过专业来查询检修信息
	 * @return
	 */
	public String getInfoByUnit(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
		//查询修成修次
		flowval = this.queryService.findXcxc(xcxc);
		if(fristUnit!=null&&fristUnit!=0){//包含部件
			for(int i=0;i<units.size();i++){
				if(units.get(i).getFirstunitid().intValue()==fristUnit){
					this.unitType=units.get(i).getFirstunitname();
					break;
				}
			}
		}else{
			if(units.size()>0){
				fristUnit=units.get(0).getFirstunitid().intValue();
				this.unitType=units.get(0).getFirstunitname();
			}
		}
		if(xcxc.equals("QZ")||xcxc.equals("CJ")){//秋整
			this.qzFixRecs=this.queryService.findJCQZFixrecByUnit(datePlan.getRjhmId(), unitType);
			return "info_unit_qz";
		}else{//小辅修
			this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());
			this.fixRecs=this.queryService.findJCFixrec(datePlan.getRjhmId(),unitType);
			return "info_unit";	
		}
		
	}
	
	/**
	 * 通过专业来查询检修信息
	 * @return
	 */
	public String getZxInfoByUnit(){
		List<JCZXFixItem> zxItemList = null;
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Integer nodeId = datePlan.getNodeid().getJcFlowId();
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);
		//查询修成修次
		if(fristUnit!=null&&fristUnit!=0){//包含部件
			for(int i=0;i<units.size();i++){
				if(units.get(i).getFirstunitid().intValue()==fristUnit){
					this.unitType=units.get(i).getFirstunitname();
					break;
				}
			}
		}else{
			if(units.size()>0){
				fristUnit=units.get(0).getFirstunitid().intValue();
				this.unitType=units.get(0).getFirstunitname();
			}
		}
		if(nodeId == Contains.ZX_FG_NODEID){
			zxItemList = queryService.findZXItem(Contains.ZX_CSZZ_NODEID, datePlan.getFixFreque(), datePlan.getJcType(), null, fristUnit);
		}
		this.preDictRecs=queryService.findJtPreDictPre(datePlan.getRjhmId());
		this.zxFixRecs=this.queryService.findJCZXFixRec(datePlan.getRjhmId(),fristUnit);
		ServletActionContext.getRequest().setAttribute("zxItemList", zxItemList);
		return "zx_info_unit";	
	}
	
	/**
	 * 通过班组来查询检修信息
	 * @return
	 */
	public String getInfoByBZ(){
		ServletActionContext.getRequest().setAttribute("type", ServletActionContext.getRequest().getParameter("type"));//标识work--工人查看无树形菜单
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		xcxc=datePlan.getFixFreque();
		jcStype=datePlan.getJcType();
		bzs=this.queryService.findAllProTeam(jcStype, 1);
		//查询修成修次
		flowval = this.queryService.findXcxc(xcxc);
		if(teamId==null){
			if(bzs.size()>0){//默认选择第一个班组
				currentTeam=bzs.get(0);
				teamId=currentTeam.getProteamid();
			}
		}else{
			for(int i=0;i<bzs.size();i++){
				if(bzs.get(i).getProteamid().equals(teamId)){
					currentTeam=bzs.get(i);
					break;
				}
			}
		}
		if("QZ".equalsIgnoreCase(xcxc)||"CJ".equalsIgnoreCase(xcxc)){
//			this.qzFixRecs=this.queryService.findJCQZFixrecByTeam(datePlan.getRjhmId(), teamId);
//			return "info_bz_qz";
			/**  下列代码在2015-10-15更改  周云韬*/
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),0);
			this.preDictRecs =queryService.findJtPreDictByFlag(datePlan.getRjhmId(), currentTeam.getProteamid());
			this.fixRecs=this.queryService.findRecByProTeam(datePlan.getRjhmId(), teamId);
			return "info_bz";
		}else if("LX".equalsIgnoreCase(xcxc)||"JG".equalsIgnoreCase(xcxc)||"ZZ".equalsIgnoreCase(xcxc)){
			this.preDictRecs=queryService.findJtPreDictByFlag(datePlan.getRjhmId(),teamId,3);
			return "info_bz_lx";
		}else{
			units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),0);
			this.preDictRecs =queryService.findJtPreDictByFlag(datePlan.getRjhmId(), currentTeam.getProteamid());
			this.fixRecs=this.queryService.findRecByProTeam(datePlan.getRjhmId(), teamId);
			return "info_bz";
		}
	}
	
	/**
	 * 通过班组来查询检修信息
	 * @return
	 */
	public String getZxInfoByBZ(){
		List<JCZXFixItem> zxItemList = null;
		ServletActionContext.getRequest().setAttribute("type", ServletActionContext.getRequest().getParameter("type"));//标识work--工人查看无树形菜单
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Integer nodeId = datePlan.getNodeid().getJcFlowId();
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), workFlag);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),1);
		if(teamId==null){
			if(bzs.size()>0){//默认选择第一个班组
				currentTeam=bzs.get(0);
				teamId=currentTeam.getProteamid();
			}
		}else{
			for(int i=0;i<bzs.size();i++){
				if(bzs.get(i).getProteamid().equals(teamId)){
					currentTeam=bzs.get(i);
					break;
				}
			}
		}
		if(nodeId == Contains.ZX_FG_NODEID){
			zxItemList = queryService.findZXItem(Contains.ZX_CSZZ_NODEID, datePlan.getFixFreque(), datePlan.getJcType(), teamId, null);
		}
		this.preDictRecs =queryService.findJtPreDictByFlag(datePlan.getRjhmId(), currentTeam.getProteamid());
		this.zxFixRecs=this.queryService.findZxRecByProTeam(rjhmId, teamId, null);
		ServletActionContext.getRequest().setAttribute("zxItemList", zxItemList);
		ServletActionContext.getRequest().setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		return "zx_info_bz";
	}
	
	/**
	 * 机车检修记录
	 * @return
	 */
	public String showHistory(){
		this.list=this.queryService.findJCHistory(jcNum);
		return "history";
	}
	
	/**
	 * 配件检修记录
	 * @return
	 */
	public String viewPj(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		ServletActionContext.getRequest().setAttribute("staticInfos", fittingService.findPJStaticInfo(rjhmId));
		return "pj";
	}
	
	/**
	 * 转移台位、股道
	 * @return
	 */
	public String moveJC(){
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			String gdh = ServletActionContext.getRequest().getParameter("gdh");
			String twh = ServletActionContext.getRequest().getParameter("twh");
			int rjhmId = Integer.parseInt(ServletActionContext.getRequest().getParameter("rjhmId"));
			queryService.updateJCGDAndTW(rjhmId, gdh, twh);
			response.getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 整车目录查询
	 * @return
	 * 
	 */
	public String findJCAll(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		bzs=this.queryService.findAllZxProTeam(jcStype, 1);
		Map<DictProTeam,List<PJStaticInfo>> map=new HashMap<DictProTeam,List<PJStaticInfo>>();
		for(DictProTeam team:bzs){
			List<PJStaticInfo> staticInfos=fittingService.findPJStaticInfo(rjhmId,team.getProteamid());
			map.put(team, staticInfos);
		}
		ServletActionContext.getRequest().setAttribute("map", map);
		units=this.queryService.findDictFirstUnitByType(datePlan.getJcType());
		ServletActionContext.getRequest().setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		return "jc_all";
	}
	
	/**
	 * 查询中修整车配件信息
	 * @return
	 */
	public String findJCPJ(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		List<PJStaticInfo> staticInfos=queryService.findPJStaticInfo(datePlan.getJcType(),null);
		Map<String,List<Map<String,Object>>> map=new HashMap<String,List<Map<String,Object>>>();
		List<String> jcPjNums=fittingService.findPjNums(rjhmId);//查询机车所有填写的编号
		Map<String,Object> staticMap=null;
		
		for(PJStaticInfo staticInfo:staticInfos){
			staticMap=new HashMap<String,Object>();
			staticMap.put("pjsid", staticInfo.getPjsid());
			staticMap.put("pjName", staticInfo.getPjName());
			//需要上车的总动态配件数
			staticMap.put("amount", staticInfo.getAmount());
			//中修上车的动态配件
			staticMap.put("zxAmount", fittingService.findDynamicInZxFixItem(staticInfo.getPjsid(), jcPjNums));
			staticMap.put("dynamicInfos", fittingService.findPJDynamicInfoByPjNums(staticInfo.getPjsid(), jcPjNums));
			String firstUnitName=staticInfo.getFirstUnit().getFirstunitname();
			
			if(map.get(firstUnitName)==null){
				map.put(firstUnitName, new ArrayList<Map<String,Object>>());
			}
			map.get(firstUnitName).add(staticMap);
		}
		ServletActionContext.getRequest().setAttribute("map",map);
		
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);
		ServletActionContext.getRequest().setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		return "jc_pj";
	}
	
	/**
	 * 查询小辅修机车配件信息
	 * @return
	 */
	public String findXXJCPJ(){
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		String fixFreque=datePlan.getFixFreque();
		List<String> xxPJNums=null;
		if(fixFreque.startsWith("LX") || fixFreque.startsWith("JG")|| fixFreque.startsWith("ZZ")){
			xxPJNums=fittingService.findXXPJNums(rjhmId, 1);
		}else if(fixFreque.startsWith("QZ") || fixFreque.startsWith("CJ")){
			xxPJNums=fittingService.findXXPJNums(rjhmId, 2);
		}else{
			xxPJNums=fittingService.findXXPJNums(rjhmId, 0);
		}
		
		Map<String,List<Map<String,Object>>> map=null;
		Map<String,Object> staticMap=null;
		if(xxPJNums!=null&&xxPJNums.size()>0){
			map=new HashMap<String,List<Map<String,Object>>>();
			List<PJStaticInfo> staticInfos=fittingService.findPJStaticInfoByXXPJNums(xxPJNums);
			for(PJStaticInfo staticInfo:staticInfos){
				staticMap=new HashMap<String,Object>();
				staticMap.put("pjsid", staticInfo.getPjsid());
				staticMap.put("pjName", staticInfo.getPjName());
				staticMap.put("dynamicInfos", fittingService.findPJDynamicInfoByPjNums(staticInfo.getPjsid(), xxPJNums));
				String firstUnitName=staticInfo.getFirstUnit().getFirstunitname();
				if(map.get(firstUnitName)==null){
					map.put(firstUnitName, new ArrayList<Map<String,Object>>());
				}
				map.get(firstUnitName).add(staticMap);
			}
		}
		ServletActionContext.getRequest().setAttribute("map",map);
		
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,0);
		if(fixFreque.startsWith("LX") || fixFreque.startsWith("JG")||fixFreque.startsWith("QZ") || fixFreque.startsWith("CJ")|| fixFreque.startsWith("ZZ")){
			return "other_jc_pj";
		}
		return "xx_jc_pj";
	}
	
	/**
	 * 查询整车探伤信息
	 */
	public String findJCTS() throws Exception {
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(rjhmId,1);;
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
		Long tsBzId = workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid();
		//车体  探伤项目
		List<JCZXFixRec> jcZXFixRecs = workService.listJCZXFixRec(rjhmId, tsBzId);
		//探伤配件
		List<PJStaticInfo> staticInfos=queryService.findPJStaticInfo(datePlan.getJcType(),tsBzId);
		Map<String,List<Map<String,Object>>> map=new HashMap<String,List<Map<String,Object>>>();
		List<String> jcPjNums=fittingService.findPjNums(rjhmId);//查询机车所有填写的编号
		Map<String,Object> staticMap=null;
		for(PJStaticInfo staticInfo:staticInfos){
			staticMap=new HashMap<String,Object>();
			staticMap.put("pjsid", staticInfo.getPjsid());
			staticMap.put("pjName", staticInfo.getPjName());
			//需要上车的总动态配件数
			staticMap.put("amount", staticInfo.getAmount());
			//中修上车的动态配件
			staticMap.put("zxAmount", fittingService.findDynamicInZxFixItem(staticInfo.getPjsid(), jcPjNums));
			staticMap.put("dynamicInfos", fittingService.findPJDynamicInfoByPjNums(staticInfo.getPjsid(), jcPjNums));
			
			String firstUnitName=staticInfo.getFirstUnit().getFirstunitname();
			if(map.get(firstUnitName)==null){
				map.put(firstUnitName, new ArrayList<Map<String,Object>>());
			}
			map.get(firstUnitName).add(staticMap);
		}
		ServletActionContext.getRequest().setAttribute("map",map);
		
		ServletActionContext.getRequest().setAttribute("jcZXFixRecs", jcZXFixRecs);
		return "jc_ts";
	}
	
	/**
	 * 根据配件编号查询配件信息
	 * @return
	 */
	public String findPjRecordByPjNum(){
		HttpServletRequest request = ServletActionContext.getRequest();
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Long pjdid=request.getParameter("pjdid")==null?null:Long.parseLong(request.getParameter("pjdid"));
		String pjNum=request.getParameter("pjNum");
		PJDynamicInfo pjDynamic=null;
		if(pjNum!=null&&!"".equals(pjNum)){
			pjDynamic=fittingService.findDynamicInfoByPjNum(pjNum);
		}else{
			pjDynamic= fittingService.findPJDynamicInfoByDID(pjdid);
		}
		if(pjDynamic!=null){
			PJFixRecord record=fittingService.findPJFixRecordByRjhmId(rjhmId,pjDynamic.getPjdid());
			List<PJFixRecord> pjFixRecs=fittingService.findPJFixRecordByDid(pjDynamic.getPjdid(),record.getPjRecId(),null);
			request.setAttribute("pjFixRecs", pjFixRecs);
		}
		
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.queryService.findDictFirstUnitByType(datePlan.getJcType());
		request.setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		request.setAttribute("pjDynamic",pjDynamic);
		request.setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		return "pjnum";
	}
	
	/**
	 * 查询配件的探伤项目
	 */
	public String findPjTS(){
		HttpServletRequest request = ServletActionContext.getRequest();
		datePlan=this.queryService.findDatePlanPriById(rjhmId);
		Long pjdid=request.getParameter("pjdid")==null?null:Long.parseLong(request.getParameter("pjdid"));
		PJDynamicInfo pjDynamic= fittingService.findPJDynamicInfoByDID(pjdid);
		
		Long tsBzId = workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid();
		
		PJFixRecord record=fittingService.findPJFixRecordByRjhmId(rjhmId,pjDynamic.getPjdid());
		List<PJFixRecord> pjFixRecs=fittingService.findPJFixRecordByDid(pjDynamic.getPjdid(),record.getPjRecId(),tsBzId);
		
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.queryService.findDictFirstUnitByType(datePlan.getJcType());
		//request.setAttribute("pjzy", fittingService.findDictFistUnitForDatePlan(datePlan.getRjhmId()));
		request.setAttribute("pjFixRecs", pjFixRecs);
		request.setAttribute("pjDynamic",pjDynamic);
		return "pjnum_ts";
	}
	
	/**
	 * 统计查询各地的在修机车
	 * @return
	 */
	public String count(){
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		if(user==null){
			return "loginOut";
		}else{
			time = (StringUtils.isNotEmpty(time)? (time += TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
			//各地数据库信息
			String zhuzhou[]={"zz","10.183.217.5","zhuzhou","admin", "admin"};
			String huaihua[]={"hh","10.165.25.115","fixdb","admin", "admin"};
			String changsha[]={"cs","10.183.214.3","fixdb","admin", "admin"};
			String guangzhou[]={"gz","10.167.61.71","orcl","admin", "admin"};
			String longchuan[]={"lc","10.175.167.237","fixdb","admin", "admin"};
			String sanshui[]={"ss","10.171.33.159","fixdb","admin", "admin"};
			
			List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
			list.add(queryConvert(zhuzhou,time));
			list.add(queryConvert(huaihua,time));
			list.add(queryConvert(changsha,time));
			list.add(queryConvert(guangzhou,time));
			list.add(queryConvert(longchuan,time));
			list.add(queryConvert(sanshui,time));
			request.setAttribute("datas", list);
			request.setAttribute("time", time.substring(0, 10));
			return "count";
		}
	}
	
	public String listJcNum(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String username = request.getParameter("pwd");
		String password = request.getParameter("pwd");
		String area = request.getParameter("area");
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		if(user == null){
			user = usersPrivsService.login(username,password);
			request.getSession().setAttribute("session_user", user);
		}
		if(user==null){
			return "loginOut";
		}else{
			time = (StringUtils.isNotEmpty(time)? (time += TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
			String[] connInfo = null;
			//各地数据库信息
			if(area.equals("zz")){
				connInfo = new String[]{"zz","10.183.217.5","zhuzhou","admin", "admin"};
				request.setAttribute("url", "10.183.217.5");
			}else if(area.equals("hh")){
				connInfo = new String[]{"hh","10.165.25.115","fixdb","admin", "admin"};
				request.setAttribute("url", "10.165.25.115");
			}else if(area.equals("cs")){
				connInfo = new String[]{"cs","10.183.214.3","fixdb","admin", "admin"};
				request.setAttribute("url", "10.183.214.3");
			}else if(area.equals("gz")){
				connInfo = new String[]{"gz","10.167.61.71","orcl","admin", "admin"};
				request.setAttribute("url", "10.167.61.71:8080");
			}else if(area.equals("lc")){
				connInfo = new String[]{"lc","10.175.167.237","fixdb","admin", "admin"};
				request.setAttribute("url", "10.175.167.237");
			}else{
				connInfo = new String[]{"ss","10.171.33.159","fixdb","admin", "admin"};
				request.setAttribute("url", "10.171.33.159");
			}
			Map<String, List<Map<String, String>>> map= queryJcnumConvert(connInfo, time);
			List<Map<String, String>> tempList = null;
			int maxRow = 0;
			for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
				String frequens = (String) iterator.next();
				tempList = map.get(frequens);
				if(tempList.size() > maxRow){
					maxRow = tempList.size();
				}
			}
			request.setAttribute("datas", map);
			request.setAttribute("area", area);
			request.setAttribute("time", time.substring(0, 10));
			request.setAttribute("maxRow", maxRow);
			return "listjcnum";
		}
	}
	
	public String listJcNums() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String area  = request.getParameter("area");
		String xcxc = request.getParameter("xcxc");
		String login = request.getParameter("login");
		if(user == null){
			user = usersPrivsService.login(login,login);
			request.getSession().setAttribute("session_user", user);
		}
		time = (StringUtils.isNotEmpty(time)? (time += TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
		String[] connInfo = this.macthAreaInfo(area);  
		Query query=new Query();
		List<Map<String, String>> dpList = query.listJcNums(connInfo, xcxc, time);
		request.setAttribute("dpList", dpList);
		request.setAttribute("time", time.substring(0, 10));
		request.setAttribute("area", area);
		if(connInfo[0].equals("gz")){
			request.setAttribute("url", connInfo[1]+ ":8080");
		}else{
			request.setAttribute("url", connInfo[1]);
		}
		return "listjcnums";
	}
	
	public String sessionReset(){
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String login = request.getParameter("login");
		if(user == null){
			user = usersPrivsService.login(login,login);
			request.getSession().setAttribute("session_user", user);
		}
		return "lead_main";
	}
	
	public String listJcNumsByArea() throws Exception{
		//Session Reset
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String login = request.getParameter("login");
		String area = request.getParameter("area");
		if(user == null){
			user = usersPrivsService.login(login,login);
			request.getSession().setAttribute("session_user", user);
		}
		time = (StringUtils.isNotEmpty(time)? (time += TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND));
		String[] connInfo = macthAreaInfo(area);
		Query query=new Query();
			
		Map<String, Map<String, Object>> packageMap = query.listJcNumsByArea(connInfo, time);
		request.setAttribute("packageMap", packageMap);
		request.setAttribute("time", time.substring(0, 10));
		request.setAttribute("area", area);
		if(connInfo[0].equals("gz")){
			request.setAttribute("url", connInfo[1]+ ":8080");
		}else{
			request.setAttribute("url", connInfo[1]);
		}
		return "listjcnumsbyarea";
	}
	
	
	@SuppressWarnings("unchecked")
	private Map<String,Object> queryConvert(String[] str,String timeStamp){
		Map<String,Object> map=null;
		Query query=new Query();
		try {
			map=query.countDatePlans(str, timeStamp);
		} catch (Exception e) {
			map=new HashMap<String,Object>();
			map.put("area", str[0]);
			System.out.println(str[0]+"地段数据连接异常!");
		}
		return map;
	}
	
	private Map<String, List<Map<String, String>>> queryJcnumConvert(String[] str,String timeStamp){
		Map<String, List<Map<String, String>>> map=null;
		Query query=new Query();
		try {
			map=query.countJcnumFromDatePlans(str, timeStamp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	private String[] macthAreaInfo(String area){
		String[] connInfo = null;
		//各地数据库信息
		if(area.equals("zz")){
			connInfo = new String[]{"zz","10.183.217.5","zhuzhou","admin", "admin"};
		}else if(area.equals("hh")){
			connInfo = new String[]{"hh","10.165.25.115","fixdb","admin", "admin"};
		}else if(area.equals("cs")){
			connInfo = new String[]{"cs","10.183.214.3","fixdb","admin", "admin"};
		}else if(area.equals("gz")){
			connInfo = new String[]{"gz","10.167.61.71","orcl","admin", "admin"};
		}else if(area.equals("lc")){
			connInfo = new String[]{"lc","10.175.167.237","fixdb","admin", "admin"};
		}else{
			connInfo = new String[]{"ss","10.171.33.159","fixdb","admin", "admin"};
		}
		return connInfo;
	}
	
	public String listJcNumsType() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String area  = request.getParameter("area");
		String xcxc = request.getParameter("xcxc");
		String login = request.getParameter("login");
		String jcType = request.getParameter("jcType");
		if(user == null){
			user = usersPrivsService.login(login,login);
			request.getSession().setAttribute("session_user", user);
		}
		time = (StringUtils.isNotEmpty(time)? (time += TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
		String[] connInfo = this.macthAreaInfo(area); 
		Query query=new Query();
		List<Map<String, String>> dpList = query.listJcNumsType(connInfo, xcxc, time, jcType);
		request.setAttribute("dpList", dpList);
		request.setAttribute("time", time.substring(0, 10));
		request.setAttribute("area", area);
		if(connInfo[0].equals("gz")){
			request.setAttribute("url", connInfo[1]+ ":8080");
		}else{
			request.setAttribute("url", connInfo[1]);
		}
		return "listjcnumstype";
	}
	
	/**
	 * 小辅修各班组未完成记录单
	 * @return
	 */
	public String listLeftWorkRecord() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String rjhmId = request.getParameter("rjhmId");
		datePlan = this.queryService.findDatePlanPriById(Integer.valueOf(rjhmId));
		Map<String, List<JCFixrec>> leftWorkRecordMap = jcFixRecService.listLeftWorkRecord(Integer.valueOf(rjhmId));
		bzs=this.queryService.findAllProTeam(datePlan.getJcType(), 1);
		units=this.jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),0);
		request.setAttribute("leftWorkRecordMap", leftWorkRecordMap);
		request.setAttribute("datePlan", datePlan);
		return "leftWorkRecord";
	}
	
	/**
	 * 中修各班组未完成记录单
	 * @return
	 */
	public String listZXLeftWorkRecord() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String rjhmId = request.getParameter("rjhmId");
		DatePlanPri datePlan = this.queryService.findDatePlanPriById(Integer.valueOf(rjhmId));
		Map<String, List<JCZXFixRec>> leftWorkRecordMap = jcFixRecService.listZXLeftWorkRecord(Integer.valueOf(rjhmId));
		units=jcFixRecService.listFirstUnitsOfJCFixRec(Integer.valueOf(rjhmId),1);
		bzs=this.queryService.findAllZxProTeam(datePlan.getJcType(), 1);
		request.setAttribute("leftWorkRecordMap", leftWorkRecordMap);
		request.setAttribute("datePlan", datePlan);
		return "leftZxWorkRecord";
	}
	
	
	/***
	 * 集团领导报表首页面
	 * @return
	 */
	public String groupLeaderReport(){
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		Calendar today = Calendar.getInstance();
		today.set(Calendar.MONTH, today.get(Calendar.MONTH)-1);
		Date beforeMonth = today.getTime();
		if(user==null){
			return "loginOut";
		}else{
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String startTimestamp = (StringUtils.isNotEmpty(startDate)? (startDate + TIMESTAMPEND):(YMDHMS_SDFORMAT.format(beforeMonth) + TIMESTAMPEND ));
			String endTimestamp = (StringUtils.isNotEmpty(endDate)? (endDate + TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
			//各地数据库信息
			String zhuzhou[] = {"zz","10.183.217.5","zhuzhou","admin", "admin"};
			String huaihua[] = {"hh","10.165.25.115","fixdb","admin", "admin"};
			String changsha[] = {"cs","10.183.214.3","fixdb","admin", "admin"};
			String guangzhou[] = {"gz","10.167.61.71","orcl","admin", "admin"};
			String longchuan[] = {"lc","10.175.167.237","fixdb","admin", "admin"};
			String sanshui[] = {"ss","10.171.33.159","fixdb","admin", "admin"};
			Query query = new Query();
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			dataList.add(query.groupLeaderReportCounts(huaihua, startTimestamp, endTimestamp));
			dataList.add(query.groupLeaderReportCounts(zhuzhou, startTimestamp, endTimestamp));
			dataList.add(query.groupLeaderReportCounts(changsha, startTimestamp, endTimestamp));
			dataList.add(query.groupLeaderReportCounts(guangzhou, startTimestamp, endTimestamp));
			dataList.add(query.groupLeaderReportCounts(longchuan, startTimestamp, endTimestamp));
			dataList.add(query.groupLeaderReportCounts(sanshui, startTimestamp, endTimestamp));
			request.setAttribute("dataList", dataList);
			request.setAttribute("startDate", StringUtils.isNotEmpty(startDate)? startDate: YMDHMS_SDFORMAT.format(beforeMonth));
			request.setAttribute("endDate", StringUtils.isNotEmpty(endDate)? endDate :YMDHMS_SDFORMAT.format(new Date()));
			return "groupLeaderReport";
		}
	}
	
	/**
	 * 集团领导报表详细页面
	 * @return
	 */
	
	public String groupLeaderReportDetail(){
		//Session Reset
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs user = (UsersPrivs)request.getSession().getAttribute("session_user");
		if(user == null){
			String login = request.getParameter("login");
			String name = request.getParameter("name");
			user = usersPrivsService.login(name,login);
			request.getSession().setAttribute("session_user", user);
		}
		String area = request.getParameter("area");
		Calendar today = Calendar.getInstance();
		today.set(Calendar.MONTH, today.get(Calendar.MONTH)-1);
		Date beforeMonth = today.getTime();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String startTimestamp = (StringUtils.isNotEmpty(startDate)? (startDate + TIMESTAMPEND):(YMDHMS_SDFORMAT.format(beforeMonth) + TIMESTAMPEND ));
		String endTimestamp = (StringUtils.isNotEmpty(endDate)? (endDate + TIMESTAMPEND):(YMDHMS_SDFORMAT.format(new Date()) + TIMESTAMPEND ));
		String[] connInfo = macthAreaInfo(area);
		Query query = new Query(); 
		request.setAttribute("area", area);
		request.setAttribute("list", query.groupLeaderReportCountsDetail(connInfo, startTimestamp, endTimestamp));
		request.setAttribute("startDate", StringUtils.isNotEmpty(startDate)? startDate: YMDHMS_SDFORMAT.format(beforeMonth));
		request.setAttribute("endDate", StringUtils.isNotEmpty(endDate)? endDate :YMDHMS_SDFORMAT.format(new Date()));
		return "groupLeaderReportDetail";
	}
	
	public DictProTeam getCurrentTeam() {
		return currentTeam;
	}

	public void setCurrentTeam(DictProTeam currentTeam) {
		this.currentTeam = currentTeam;
	}

	public Long getTeamId() {
		return teamId;
	}

	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}

	public List<DictProTeam> getBzs() {
		return bzs;
	}

	public void setBzs(List<DictProTeam> bzs) {
		this.bzs = bzs;
	}

	public String getUnitType() {
		return unitType;
	}

	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}

	public List<DictFirstUnit> getUnits() {
		return units;
	}

	public void setUnits(List<DictFirstUnit> units) {
		this.units = units;
	}

	public SignedForFinish getSigned() {
		return signed;
	}

	public void setSigned(SignedForFinish signed) {
		this.signed = signed;
	}

	public List<JCFixrec> getFixRecs() {
		return fixRecs;
	}

	public void setFixRecs(List<JCFixrec> fixRecs) {
		this.fixRecs = fixRecs;
	}

	public List<JCQZFixRec> getQzFixRecs() {
		return qzFixRecs;
	}

	public void setQzFixRecs(List<JCQZFixRec> qzFixRecs) {
		this.qzFixRecs = qzFixRecs;
	}

	public List<JtPreDict> getPreDictRecs() {
		return preDictRecs;
	}

	public void setPreDictRecs(List<JtPreDict> preDictRecs) {
		this.preDictRecs = preDictRecs;
	}

	public DatePlanPri getDatePlan() {
		return datePlan;
	}

	public void setDatePlan(DatePlanPri datePlan) {
		this.datePlan = datePlan;
	}
	
	public Integer getLastOne() {
		return lastOne;
	}

	public void setLastOne(Integer lastOne) {
		this.lastOne = lastOne;
	}
    

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getJcType() {
		return jcType;
	}

	public void setJcType(String jcType) {
		this.jcType = jcType;
	}

	public String getJcStype() {
		return jcStype;
	}

	public void setJcStype(String jcStype) {
		this.jcStype = jcStype;
	}

	public String getJcNum() {
		return jcNum;
	}

	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}

	public String getXcxc() {
		return xcxc;
	}

	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public Integer getFristUnit() {
		return fristUnit;
	}

	public void setFristUnit(Integer fristUnit) {
		this.fristUnit = fristUnit;
	}

	public Long getTeams() {
		return teams;
	}

	public void setTeams(Long teams) {
		this.teams = teams;
	}

	public List<DatePlanPri> getList() {
		return list;
	}

	public void setList(List<DatePlanPri> list) {
		this.list = list;
	}

	public Integer getWorkFlag() {
		return workFlag;
	}

	public void setWorkFlag(Integer workFlag) {
		this.workFlag = workFlag;
	}

	public String getGonghao() {
		return gonghao;
	}

	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}

	public String getFlowval() {
		return flowval;
	}

	public void setFlowval(String flowval) {
		this.flowval = flowval;
	}

	public List<JCZXFixRec> getZxFixRecs() {
		return zxFixRecs;
	}

	public void setZxFixRecs(List<JCZXFixRec> zxFixRecs) {
		this.zxFixRecs = zxFixRecs;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getJceiId() {
		return jceiId;
	}

	public void setJceiId(String jceiId) {
		this.jceiId = jceiId;
	}

	public Integer getRjhmId() {
		return rjhmId;
	}

	public void setRjhmId(Integer rjhmId) {
		this.rjhmId = rjhmId;
	}

	public List<JCZXFixRec> getJczxFixRecs() {
		return jczxFixRecs;
	}

	public void setJczxFixRecs(List<JCZXFixRec> jczxFixRecs) {
		this.jczxFixRecs = jczxFixRecs;
	}

	public String getPjNum() {
		return pjNum;
	}

	public void setPjNum(String pjNum) {
		this.pjNum = pjNum;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	

}