package com.repair.admin.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;

import com.repair.admin.service.AttendanceService;
import com.repair.common.pojo.AttendanceDate;
import com.repair.common.pojo.AttendanceDetails;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.UsersPrivs;

public class AttendanceAction {
	@Resource(name="attendanceService")
	private AttendanceService attendanceService;
	private Long proteamId;
	private String userXm;
	private String dates;
	

	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat YMD_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	
	/**生成考勤记录 
     * @return  
	 * @throws Exception 
     */  
    public String check() throws Exception{
    	//参数
    	String picData = request.getParameter("picData");
    	String picExt = request.getParameter("picExt");
    	UsersPrivs sesson_user = (UsersPrivs)request.getSession().getAttribute("session_user");
    	SimpleDateFormat signTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	AttendanceDate attendance = null;
    	String imgPath = null;
    	Date now = new Date();
    	dates = YMD_SDFORMAT.format(now);
    	attendance = attendanceService.findAttendanceById(sesson_user.getUserid(),dates);
    	DictProTeam bz = attendanceService.findbz(sesson_user.getBzid());
		if(attendance != null){
			AttendanceDate attdate = attendanceService.findAttendanceDate(attendance.getId());
			imgPath = uploadImg(picData, picExt);
        	//保存考勤图片信息
        	AttendanceDetails imgUrl = new AttendanceDetails();
        	imgUrl.setDid(attdate);
        	imgUrl.setImgtime(signTime.format(new Date()));
        	imgUrl.setImgurl(imgPath);
        	attendanceService.saveImgUrl(imgUrl);
		}else{
			attendance = new AttendanceDate();
			attendance.setUsers(sesson_user);
			attendance.setBzid(bz);
			attendance.setDatetime(dates);
			attendance.setConfirm("0");
			//保存考勤日记录
			attendanceService.saveAttendance(attendance);
			AttendanceDate attdate = attendanceService.findAttendanceDate(attendance.getId());
			imgPath = uploadImg(picData, picExt);
        	//保存考勤图片信息
        	AttendanceDetails imgUrl = new AttendanceDetails();
        	imgUrl.setDid(attdate);
        	imgUrl.setImgtime(signTime.format(new Date()));
        	imgUrl.setImgurl(imgPath);
        	attendanceService.saveImgUrl(imgUrl);
		}
    	response.getWriter().print("success");
        return null;  
    } 
    /**
     * 保存照片
     * @param picData
     * @param picExt
     * @return
     * @throws Exception
     */
    public String uploadImg(String picData, String picExt) throws Exception{
    	String pic_base_64_data = picData;
    	String fileFormat = picExt;
    	//路径
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
    	String fileDateUrl = dateFormat.format(new Date());
    	String filePath = "attcheck" + "/" + fileDateUrl.trim();
    	String fileRealPath = ServletActionContext.getServletContext().getRealPath(filePath);
    	//流输出
    	sun.misc.BASE64Decoder decode = new sun.misc.BASE64Decoder();
    	byte[] datas = decode.decodeBuffer(pic_base_64_data);
    	File sysmfile = new File(fileRealPath);
    	String filename = UUID.randomUUID() + fileFormat;
    	if(!sysmfile.exists()){
    		sysmfile.mkdirs();
    	}
    	OutputStream fos = new FileOutputStream(sysmfile + "/" + filename);
    	fos.write(datas);
    	fos.close();
    	return filePath + "/" + filename;
    }
    
    //领导查询 --查询班组
    public String  findAttendanceByBz() throws Exception{
    	List<DictProTeam> bzList = attendanceService.findAllDictProteam();
    	request.setAttribute("bzList", bzList);
    	return "proteamUsers";
    }
    
    /**
     * 领导查询--根据班组查询考勤记录
     * @return
     * @throws Exception
     */
    public String findAttendanceByProteam() throws Exception{
    	if(dates==null || "".equals(dates)){
    		dates = YMD_SDFORMAT.format(new Date());
    	}
    	List<Map<String, Object>> dateList = attendanceService.findAttendaceDate(proteamId,dates);
    	request.setAttribute("dateList", dateList);
    	return "proteamAttendance";
    }
    
    //工长进入考勤审核
    public String findAttendaceDate()throws Exception{
    	UsersPrivs sesson_user = (UsersPrivs) request.getSession().getAttribute("session_user");
    	if(dates==null || "".equals(dates)){
    		dates = YMD_SDFORMAT.format(new Date());
    	}
    	List<Map<String, Object>> dateList = attendanceService.findAttendaceDate(sesson_user.getBzid(),dates);
    	request.setAttribute("dateList", dateList);
    	return "dateList";
    }
    
    /**
	 * 确认考勤信息
	 * @return
	 * @throws Exception
	 */
	public String attsConfirm() throws Exception{
		String result = "";
		String attIdArray[] = request.getParameter("atts").split(",");
		String commentsJsonStr = request.getParameter("commentsJsonStr");
		JSONObject commentsJsonObj = new JSONObject(commentsJsonStr);
		for (int i = 0; i < attIdArray.length; i++) {
			AttendanceDate attendanceDate = attendanceService.findAttendanceDate(Long.parseLong(attIdArray[i]));
			try {
				attendanceDate.setComments(commentsJsonObj.getString(attIdArray[i]));
				attendanceDate.setConfirm("1");
				attendanceService.saveAttendance(attendanceDate);
				result = "success";
			} catch (Exception e) {
				result = "failure";
				e.printStackTrace();
			}
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
	}

	public Long getProteamId() {
		return proteamId;
	}

	public void setProteamId(Long proteamId) {
		this.proteamId = proteamId;
	}

	public String getUserXm() {
		return userXm;
	}

	public void setUserXm(String userXm) {
		this.userXm = userXm;
	}

	public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}
}
