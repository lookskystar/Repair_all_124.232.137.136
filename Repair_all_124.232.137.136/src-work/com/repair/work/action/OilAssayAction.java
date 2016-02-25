package com.repair.work.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.pojo.UsersPrivs;
import com.repair.plan.service.PlanManageService;
import com.repair.work.service.OilAssayService;

/**
 * 油水化验Action
 * @author Administrator
 *
 */
public class OilAssayAction {
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	@Resource(name="oilAssayService")
	private OilAssayService oilAssayService;
	private OilAssayPriRecorder priRecorder;
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public OilAssayPriRecorder getPriRecorder() {
		return priRecorder;
	}

	public void setPriRecorder(OilAssayPriRecorder priRecorder) {
		this.priRecorder = priRecorder;
	}

	/**
	 * 进入油水化验页面
	 * @return
	 */
    public String oilAssayInput(){
    	List<OilAssayPriRecorder> recorders=oilAssayService.findOilAssayPriRecorderAll();
    	request.setAttribute("recorders", recorders);
    	return "oilAssayInput";
    }
    
    /**
     * 进入添加油样化验记录页面
     * @return
     */
    public String addOilRecorderDialog(){
    	//查找要进行油水化验的机车信息
    	List<DatePlanPri> assayJcs=oilAssayService.findAssayJcs();
    	request.setAttribute("assayJcs", assayJcs);
    	return "addOilRecorderDialog";
    }
    
    /**
     * 添加油样化验记录
     * @return
     */
    public String addOilRecorder(){
    	DatePlanPri datePlanPri=oilAssayService.findDatePlanPriById(priRecorder.getDpId().getRjhmId());
    	priRecorder.setDetecteStatus((short)0);
    	priRecorder.setJcsTypeVal(datePlanPri.getJcType());
    	priRecorder.setJcNum(datePlanPri.getJcnum());
    	oilAssayService.saveOilAssayPriRecorder(priRecorder);
    	return oilAssayInput();
    }
    
    /**
     * 进入更新油样化验记录页面
     * @return
     */
    public String updateOilRecorderDialog(){
    	long recId=Long.parseLong(request.getParameter("recId"));
    	OilAssayPriRecorder recorder=oilAssayService.findOilAssayPriRecorderById(recId);
    	request.setAttribute("recorder", recorder);
    	return "updateOilRecorderDialog";
    }
    
    /**
     * 更新油样化验记录
     * @return
     */
    public String updateOilRecorder(){
    	long recId=Long.parseLong(request.getParameter("recId"));
    	OilAssayPriRecorder recorder=oilAssayService.findOilAssayPriRecorderById(recId);
    	if(priRecorder.getQuasituation()==0){//如果合格，则将处理意见设置为空
    		priRecorder.setDealAdvice(null);
    	}
    	recorder.setRecesamTime(priRecorder.getRecesamTime());
    	recorder.setFinTime(priRecorder.getFinTime());
    	recorder.setSentsamPeo(priRecorder.getSentsamPeo());
    	recorder.setReceiptPeo(priRecorder.getReceiptPeo());
    	recorder.setDealAdvice(priRecorder.getDealAdvice());
    	recorder.setQuasituation(priRecorder.getQuasituation());
    	recorder.setDetecteStatus((short)1);
    	oilAssayService.updateOilAssayPriRecorder(recorder);
    	return oilAssayInput();
    }
    
    /**
     * 进入油样化验项目页面
     * @return
     */
    public String oilAssayitemInput(){
    	long recId=Long.parseLong(request.getParameter("recId"));
    	OilAssayPriRecorder recorder=oilAssayService.findOilAssayPriRecorderById(recId);
    	String jcType=recorder.getJcsTypeVal();
    	List<OilAssayItem> items=oilAssayService.findOilAssayItemByJcType(jcType);
    	request.setAttribute("recorder", recorder);
    	request.setAttribute("items", items);
    	return "oilAssayitemInput";
    }
    
    /**
     * 进入油水化验子项目信息页面
     * @return
     */
    public String oilSubItemInput(){
    	int itemId=Integer.parseInt(request.getParameter("itemId"));
    	long recId=Long.parseLong(request.getParameter("recId"));
    	OilAssayPriRecorder priRec=oilAssayService.findOilAssayPriRecorderById(recId);
    	//List<OilAssaySubItem> subItems=oilAssayService.findOilAssaySubItemByItemId(itemId);
    	List<Map<String,Object>> subItems=oilAssayService.findOilDetailRecorderByRecId(itemId, recId,priRec.getJcsTypeVal());
    	request.setAttribute("subItems",subItems);
    	request.setAttribute("itemId",itemId);
    	return "oilSubItemInput";
    }
    
    /**
     * 更新油水化验明细记录信息
     * @return
     */
    public String updateOilDetailRecorder(){
    	UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
    	long recDetailId=Long.parseLong(request.getParameter("recDetailId"));
    	OilAssayDetailRecorer detailRecorder=oilAssayService.findDetailRecorderById(recDetailId);
    	Object[] obj=oilAssayService.findMaxMinValue(recDetailId);
    	//值类型判断 1：fillValue为浮点值 2：fillValue为字符值
    	String valueType=request.getParameter("valueType");
    	if(valueType.equals("1")){
    		float fillValue=Float.parseFloat(request.getParameter("fillVlaue"));
    		float min=0;
        	float max=0;
        	if(obj[0]!=null&&!obj[0].equals("")&&obj[1]!=null&&!obj[1].equals("")){
    			min=Float.parseFloat(String.valueOf(obj[0]));
    			max=Float.parseFloat(String.valueOf(obj[1]));
    			if(fillValue>=min&&fillValue<=max){
    				detailRecorder.setQuaGrade("合格");//合格
    			}else{
    				detailRecorder.setQuaGrade("不合格");//不合格
    			}
        	}else{
        		detailRecorder.setQuaGrade("合格");//合格
        	}
        	detailRecorder.setRealdeteVal(fillValue);
    	}else{
    		detailRecorder.setQuaGrade(request.getParameter("fillVlaue"));
    	}
    	detailRecorder.setReceiptPeo(user.getXm());
    	detailRecorder.setFinTime(YMDHMS_SDFORMAT.format(new Date()));
    	String result="failure";
    	response.setContentType("text/plain");
		try {
			oilAssayService.updateOilAssayDetailRecorer(detailRecorder);
			result="success";
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
    	return null;
    }
    
    /**
     * 进入填值对话框页面
     * @return
     */
    public String fillValueInputDialog(){
    	long recDetailId=Long.parseLong(request.getParameter("recDetailId"));
    	OilAssayDetailRecorer detailRecorder=oilAssayService.findDetailRecorderById(recDetailId);
    	request.setAttribute("detailRecorder", detailRecorder);
    	request.setAttribute("recDetailId", recDetailId);
    	return "fillValueInputDialog";
    	
    }
    
    /**
     * 查询油水化验记录
     * @return
     */
    public String searchOilAssayRecorder(){
    	long recId=Long.parseLong(request.getParameter("recId"));
    	OilAssayPriRecorder recorder=oilAssayService.findOilAssayPriRecorderById(recId);
    	String jcType=recorder.getJcsTypeVal();
    	List<OilAssayItem> items=oilAssayService.findOilAssayItemByJcType(jcType);
    	Map<String,List<Map<String,Object>>> datas=new HashMap<String,List<Map<String,Object>>>();
    	List<Map<String,Object>> subItems=null;
    	
    	for(OilAssayItem item:items){
    		int itemId=item.getReportItemId();
    		String itemName=item.getReportItemDefin();
    		subItems=oilAssayService.findOilDetailRecorderByRecId(itemId, recId,recorder.getJcsTypeVal());
    		datas.put(itemName, subItems);
    	}
    	request.setAttribute("datas", datas);
    	request.setAttribute("recorder", recorder);
    	return "searchOilRecorder";
    }
    
    /**
     * 查询油水化验记录
     * @return
     */
    public String searchOilAssayRecorderDaily(){
    	Integer rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
    	DatePlanPri datePlanPri = planManageService.findDatePlanPriById(rjhmId);
    	OilAssayPriRecorder recorder=oilAssayService.findOilAssayRecByDailyId(rjhmId);
    	
    	Map<String,List<Map<String,Object>>> datas=new HashMap<String,List<Map<String,Object>>>();
    	List<Map<String,Object>> subItems=null;
    	String jcType=datePlanPri.getJcType();

		List<OilAssayItem> items=oilAssayService.findOilAssayItemByJcType(jcType);
		for(OilAssayItem item:items){
			int itemId=item.getReportItemId();
			String itemName=item.getReportItemDefin();
			if(recorder!=null){
				subItems=oilAssayService.findOilDetailRecorderByRecId(itemId, recorder.getRecPriId(),recorder.getJcsTypeVal());
			}
			datas.put(itemName, subItems);
		}
    	
    	request.setAttribute("datas", datas);
    	request.setAttribute("recorder", recorder);
    	request.setAttribute("datePlanPri", datePlanPri);
    	return "searchOilRecorder";
    }
    
}
