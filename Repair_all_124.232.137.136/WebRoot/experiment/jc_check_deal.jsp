<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<!-- Ajax上传图片 -->
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	<!--框架必需end-->
	
	<!--文本截取start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--文本截取end-->
	<script type="text/javascript">
		$(document).ready(function(){
			var fixFreque = $("input[type='radio']").filter("[checked=true]").attr("class");
			if(fixFreque == "LX" || fixFreque == "JG"){
				document.getElementById("signTable").style.display='none';
				document.getElementById("signBtn").style.display='none';
			}
		})
	
	   //显示记录信息
	   function showMsg(id){
		   var d=new Date();
		   var now=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
		   var type=$("#tr_"+id+" td:eq(1)").text();
		   var num=$("#tr_"+id+" td:eq(2)").text();
		   var xcxc=$("#tr_"+id+" td:eq(3)").text();
		   var kcsj=$("#tr_"+id+" td:eq(5)").text();
		   $("#jctype").text(type);
		   $("#jcnum").text(num);
		   $("#xcxc").text(xcxc);
		   $("#kcsj").text(kcsj);
		   //$("#jcsj").text(now);
	   }
	   
	   //角色签到
	   function roleSign(){
		   var datePlanId=$("#rjhmId").val();
		   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
			 	top.Dialog.alert("请选择机车!");
		   }else{
			    top.Dialog.open({URL:"<%=basePath%>checkDealJc!roleSignInput.do?dpId="+datePlanId,Width:350,Height:150,Title:"用户签认"});
		   }
	   }
	   
	   //交车
	   function dealJc(type){
		   var datePlanId=$("#rjhmId").val();
		   var type_local = (type == null || type == "" || type == undefined)?"1":type;
		   var gzgh=$("#gzgh").val();
		   var gzxm=$("#gzxm").val();
		   var zrgh=$("#zrgh").val();
		   var zrxm=$("#zrxm").val();
		   var ysgh=$("#ysgh").val();
		   var ysxm=$("#ysxm").val();
		   var dzgh=$("#dzgh").val();
		   var dzxm=$("#dzxm").val();
		   var jcsj=$("#jcsj").val();
		   var reason=$("#reason").val();
		   var belongArea = $("#belongArea").val();
		   var fixArea = $("#fixArea").val();
		   var status=$("#status").val();
		   if(zrgh==""||dzgh==""){
			    top.Dialog.alert("请签认完全!");
			 	return;
		   }
		   if(belongArea=="" || fixArea==""){
		   		 top.Dialog.alert("段属信息不能为空!");
		   		 return;
		   }
		   
		   <c:if test='${datePlanPri.fixFreque == "QZ"}'>
		   if(type != 0){
		 	  var bool=false;
			   $.ajax({
				   "url":"<%=basePath%>qz!ajaxSelectZeroScore.do",
				   "data":{"rjhid":datePlanId},
				   "async":false,
				   "type":"post",
				   "success":function(data){
					   if(data != "非秋整机车"){
						   if(data == "评分未完成"){
							   top.Dialog.alert(data);
							   bool=true;
						   }else if(data == "机车质量评定未签认"){
							   top.Dialog.alert(data+"！请联系段领导或总工程师签认");
							   bool=true;
						   }
						   else{
							   var score=1000-parseFloat(data);
							   if(score < 850){
								   top.Dialog.alert("机车质量不合格，请重修！");
								   $("#jiaoche").unbind("click",dealJc);
								   $("#jiaoche .icon_save").text("强制交车");
								   $("#jiaoche").click(function(){
									   dealJc(0);
								   });
								   bool=true;
							   }
						   }
					   }else{
						   bool=true;
					   }
				   }
			   })
			   if(bool){
				   return;
			   }
		   }
		  </c:if>
		   $.post("<%=basePath%>checkDealJc!saveSignedForFinish.do",
		      {
		        "dpId":datePlanId,
		        "status":status,
		        //"gzgh":gzgh,
		        //"gzxm":gzxm,
		        //"zrgh":zrgh,
		        //"zrxm":zrxm,
		        "jcsj":jcsj,
		        "ysgh":ysgh,
		        "ysxm":ysxm,
		        "dzgh":dzgh,
		        "dzxm":dzxm,
		        "reason":reason,
		        "belongArea":belongArea,
		        "fixArea":fixArea,
		        "dealJcType":type_local
		      },function(data){
		    	  if(data=="success"){
		    		  top.Dialog.alert("交车成功!",function(){
		    			  top.document.location.href="<%=basePath%>report/jcgz_main.jsp";
		    		  });
		    	  }else if(data=="report_nowork"){
		    		  top.Dialog.alert("存在报活未派工，不能交车!");
		    	  }else if(data=="report_unfinish"){
		    		  top.Dialog.alert("报活未签认完成，不能交车!");
		    	  }else{
		    		   top.Dialog.alert("交车失败!");
		    	  }
		      });
	   }
	   
	   function isNotEmpty(files){
	   		return (files == "" || files == null)? false: true;
	   }

	   //报活补签
	   function reSign(id){
		   top.Dialog.open({URL:"<%=basePath%>checkDealJc!reSignInput.do?rjhmId="+id,Width:"100",Height:"100",Title:"报活签认"});
	   }
	</script>
</head>
<body>
<div id="scrollContent">
    <input type="hidden" id="rjhmId" value="${datePlanPri.rjhmId }"/>
    <input type="hidden" id="status" value="${datePlanPri.planStatue}"/>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	 <td  width="40%">
	    	<div class="box2"  panelTitle="机车信息" roller="true" showStatus="false" overflow="auto" panelHeight="550" >
				<table width="100%" class="tableStyle">
				    <tr><th colspan="2" align="center">当前机车信息</th></tr>
				    <tr>
				       <td align="center">机车</td>
				       <td align="center">${datePlanPri.jcType}-${datePlanPri.jcnum}-${datePlanPri.fixFreque}</td>
				    </tr>
				    <tr>
				       <td align="center">交车工长</td>
				       <td align="center">${datePlanPri.gongZhang.xm }</td>
				    </tr>
				    <tr>
				       <td align="center">扣车时间</td>
				       <td align="center">${datePlanPri.kcsj}</td>
				    </tr>
				    <tr>
				       <td align="center">计划起机时间</td>
				       <td align="center">${datePlanPri.jhqjsj}</td>
				    </tr>
				    <tr>
				       <td align="center">实际起机时间</td>
				       <td align="center">${datePlanPri.sjqjsj}</td>
				    </tr>
				    <tr>
				       <td align="center">计划交车时间</td>
				       <td align="center"><font color="red">${datePlanPri.jhjcsj}</font></td>
				    </tr>
				    <tr>
				       <td align="center">所处节点</td>
				       <td align="center">${datePlanPri.nodeid.nodeName}</td>
				    </tr>
				    <c:if test="${count!=0}">
					    <tr>
					       <td align="center">报活完成情况</td>
					       <td align="center">
					                                     有<font style="color:red;">${count}</font>条未完成的报活&nbsp;&nbsp;&nbsp;&nbsp;
					           <button onclick="reSign(${datePlanPri.rjhmId});">报活补签</button>
					       </td>
					    </tr>
				    </c:if>
				    <tr>
				       <td align="center">状态</td>
				       <td align="center" colspan="5">
				           <c:if test="${datePlanPri.planStatue==0}"><font style="color: blue">在修</font></c:if>
						   <c:if test="${datePlanPri.planStatue==1}">待验</c:if>
				       </td>
				    </tr>
				</table>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="机务段检修竣工交验单"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  	 <button  onclick="roleSign();" id="signBtn"><span class="icon_save">签认</span></button>&nbsp;&nbsp;&nbsp;&nbsp;
		  	 <c:if test="${datePlanPri.planStatue==0}">
		  	 	<button  id="jiaoche" onclick="dealJc('0');"><span class="icon_save">强制交车</span></button>
		  	 </c:if>
		  	 <c:if test="${datePlanPri.planStatue==1}">
		  	 	<button  id="jiaoche"  onclick="dealJc('1');"><span class="icon_save">正常交车</span></button>
		  	 </c:if>
	    	  <div id="jgjl">
	    	      <h3 align="center">机车竣工验收记录</h3>
	    	      &nbsp;&nbsp;&nbsp;<font size="3">配属&nbsp;广州&nbsp;局&nbsp;
	    	      <select id="belongArea">
	    	      	<c:forEach items="${jwds}" var="jwd">
	    	      		<option value="${jwd.jwdmc}" <c:if test="${jwd.isFirst==1}">selected="selected"</c:if>>${ jwd.jwdmc}</option>
	    	      	</c:forEach>
	    	      </select>
	    	      	段_<span id="jctype" style="color: blue">${datePlanPri.jcType}</span>_型号_<span id="jcnum" style="color: blue">${datePlanPri.jcnum}</span>_号机车，已于_<span id="kcsj" style="color: blue">${datePlanPri.kcsj}</span>_至
	    	      _<input type="text" class="Wdate" onfocus="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm',minDate:'${datePlanPri.kcsj}'}))" id="jcsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date())%>'/>_由
	    	      <select id="fixArea">
	    	      	<c:forEach items="${jwds}" var="jwd">
	    	      		<option value="${ jwd.jwdmc}" <c:if test="${jwd.isFirst==1}">selected="selected"</c:if>>${ jwd.jwdmc}</option>
	    	      	</c:forEach>
	    	      </select>按照有关技术规定经_<span id="xcxc" style="color: blue">${datePlanPri.fixFreque}</span>_修次竣工，经局驻段验收员检查验收，确认技术状态合格，准予交付运用。</font>
	    	  </div>
	    	  <hr width="100%" color="blue" size="3"></hr>
	    	  <div>
	    	    <table width="50%" class="tableStyle" id="signTable">
	    	      <tr><th colspan="3">签到信息列表:</th></tr>
	    	      <tr>
	    	          <th class="ver01">角色</th>
					  <th class="ver01">工号</th>
					  <th class="ver01">姓名</th>
	    	      </tr>
	    	      <!-- 
	    	      <tr>
	    	          <th class="ver01">交车工长</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="gzgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="gzxm"/></th>
	    	      </tr> 
	    	       <tr>
	    	          <th class="ver01">检修主任</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="zrgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="zrxm"/></th>
	    	      </tr>
	    	     -->
	    	     <tr>
	    	          <th class="ver01">驻段验收员</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="ysgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="ysxm"/></th>
	    	      </tr>
	    	      <tr>
	    	          <th class="ver01">段长</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="dzgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="dzxm"/></th>
	    	      </tr>
	    	    </table><br/>
	    	    <c:if test="${datePlanPri.planStatue==0}">
		    	    <table width="50%" class="tableStyle">
		    	       <tr><th>强制交车原因:</th></tr>
		    	       <tr>
		    	          <td align="center"><input type="text" style="width:250px;" id="reason"/><font color="red">*强制交车时选填</font></td>
		    	       </tr>
		    	    </table>
		    	</c:if>
		    	<c:if test="${delay==1}">
		    	    <table width="50%" class="tableStyle">
		    	       <tr><th>延迟交车原因:</th></tr>
		    	       <tr>
		    	          <td align="center"><input type="text" style="width:250px;" id="reason"/><font color="red">*延迟交车时选填</font></td>
		    	       </tr>
		    	    </table>
		    	</c:if>
	    	  </div>
	    	  <div>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>
<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>			
</body>
</html>