<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <title>工人考勤信息</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
<body>
 	<form action="attendanceAction!findAttendaceDate.do" method="post" id="subfrom">
 	<div>
 		<table>
 			<tr>
 				<td>查询日期：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" id="dates"  name="dates" value="${dates}"/></td>
 				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
 				<td><button onclick="enSureConfirm();"><span style="height: 22px;">考勤确认</span></button></td>
 			</tr>
		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  id="attendanceTable" useCheckBox="true" useMultColor="true">
		 	<tr>
		 		<th width="30px" align="center"></th>
		      	<th width="100px" align="center"><span>考勤人姓名</span></th>
		      	<th width="18%" align="center"><span>第一次考勤</span></th>
		      	<th width="18%" align="center"><span>第二次考勤</span></th> 
		      	<th width="18%" align="center"><span>第三次考勤</span></th>
		      	<th width="18%" align="center"><span>第四次考勤</span></th>
		      	<th width="20%" align="center">备注</th>
		      	<th width="8%" align="center">审核</th>
		    </tr>
		   	<c:forEach items="${dateList}" var="map" varStatus="idx">
		   		<tr>
		   			<td width="center" align="center"><input id="attendid" name="attendance" type="checkbox" value="${map.id}"/></td>	
					<td align="center">${map.xm}</td>
					<td align="center">
						<c:choose>
							<c:when test="${empty map.imgurl_0}">
								<font color="#ff0000">未考勤</font>
							</c:when>
							<c:otherwise>
								<img src="${map.imgurl_0}" style="border:1px solid #f0f0f0;width:100px;height:60px;"/>
								<br/>${map.time_0}
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${empty map.imgurl_1}">
								<font color="#ff0000">未考勤</font>
							</c:when>
							<c:otherwise>
								<img src="${map.imgurl_1}" style="border:1px solid #f0f0f0;width:100px;height:60px;"/>
								<br/>${map.time_1}
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${empty map.imgurl_2}">
								<font color="#ff0000">未考勤</font>
							</c:when>
							<c:otherwise>
								<img src="${map.imgurl_2}" style="border:1px solid #f0f0f0;width:100px;height:60px;"/>
								<br/>${map.time_2}
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${empty map.imgurl_3}">
								<font color="#ff0000">未考勤</font>
							</c:when>
							<c:otherwise>
								<img src="${map.imgurl_3}" style="border:1px solid #f0f0f0;width:100px;height:60px;"/>
								<br/>${map.time_3}
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center"><textarea id="${map.id}_comments">${map.comments}</textarea> </td>
					<td align="center">
						<c:choose>
							<c:when test="${map.confirm == 1}">
								<span>已审核</span>
							</c:when>
							<c:otherwise>
								<font color="#ff0000">未审核</font>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
		   	</c:forEach>
		 </table>
	</div>
	</form>
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	//编辑
	function editAtten(id){
		var diag = new top.Dialog();
		diag.Title = "考勤记录管理";
		diag.URL = "attendanceAction!editAttendanceInput.do?id="+id;
		diag.Width=700;
		diag.Height=600;
		diag.show();
	}
	
	//判断是否选中信息
	function enSureConfirm(){
		//判断是否一个未选
		var flag; 
		//用于保存 选中的那一条数据的ID 
		var atts = [];  
		//JSON备注字符串
		var commentsJsonStr = "{";
		//遍历所有的name为attendance的 checkbox 
		$("input[name='attendance']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })
	    if (flag) {  
	    	$("input[name='attendance']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			var key = $(this).val();
	    			var value = $("#"+key+"_comments").val();
	    			//将选中的值 添加到 array中
	    			atts.push($(this).val());
	    			commentsJsonStr += key +":"+ value + ","; 
	    		}
	    	})
	    	commentsJsonStr += "}";
	    	$.ajax({
				type:"post",
				async:false,
				url:"attendanceAction!attsConfirm.do",
				data:{"atts":atts.join(","),"commentsJsonStr":commentsJsonStr},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("考勤信息确认成功！",function(){
				    			top.window.frmright.location.href="attendanceAction!findAttendaceDate.do";
			    			});
		    		}else{
		    			top.Dialog.alert("考勤信息确认失败！");
		    		}
				}
			});
	    }else {
	    	top.Dialog.alert("请至少选择一条考勤信息！");
	    }
	
	}
</script>
</html>