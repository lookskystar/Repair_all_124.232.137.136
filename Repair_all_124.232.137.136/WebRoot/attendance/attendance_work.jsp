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
    <title>工人考勤</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
  </head>
  
 <body>
 	<form action="">
 		<input type="hidden" id="picData1" name="picData1"/>
		<input type="hidden" id="picExt1"  name="picExt1"/>
		<input type="hidden" id="picData2" name="picData2"/>
		<input type="hidden" id="picExt2"  name="picExt2"/>
	 	<div id="scrollContent">
		 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
		 	  	<tr>
		 			<td width="22%" class="ver01">
			 			<div class="box2"  panelTitle="工人考勤" panelHeight="465" overflow="auto" showStatus="false">
			 				<table>
								<tr>
									<td>
							 			第一步：<input type="button" value="启动摄像头" onclick="javascript:startCam();"  />
						 			</td>
					 			</tr>
					 			<tr>
									<td>
							 			第二步：<input type="button" value="拍摄照片" onclick="javascript:capPicture1();"  />
						 			</td>
					 			</tr>
					 			<tr>
									<td>
							 			第三步：<input type="button" value="考勤签认" onclick="javascript:submitToServer();"  />
						 			</td>
					 			</tr>
				 			</table>
			 			</div>
		 	    	</td>
		 			<td class="ver01">
			 			<div class="box2"  panelTitle="考勤拍照" panelHeight="465" overflow="auto" showStatus="false">
			 				<table>
			 					<tr>
			 						<td><input type="button" value="清除结果" onclick="javascript:document.getElementById('cap1').clear();"  /></td>
			 					</tr>
			 					<tr>
			 						<td>
				 						<object classid="clsid:34681DB3-58E6-4512-86F2-9477F1A9F3D8" id="cap1" width="600" height="400" codebase="ImageCapOnWeb.cab#version=2,0,0,0">
											<param name="Visible" value="0">
											<param name="AutoScroll" value="0">
											<param name="AutoSize" value="0">
											<param name="AxBorderStyle" value="1">
											<param name="Caption" value="scaner">
											<param name="Color" value="4278190095">
											<param name="Font" value="宋体">
											<param name="KeyPreview" value="0">
											<param name="PixelsPerInch" value="96">
											<param name="PrintScale" value="1">
											<param name="Scaled" value="-1">
											<param name="DropTarget" value="0">
											<param name="HelpFile" value>
											<param name="PopupMode" value="0">
											<param name="ScreenSnap" value="0">
											<param name="SnapBuffer" value="10">
											<param name="DockSite" value="0">
											<param name="DoubleBuffered" value="0">
											<param name="ParentDoubleBuffered" value="0">
											<param name="UseDockManager" value="0">
											<param name="Enabled" value="-1">
											<param name="AlignWithMargins" value="0">
											<param name="ParentCustomHint" value="-1">
											<param name="licenseMode" value="2">
											<param name="key1" value="">
											<param name="key2" value="">
										</object>
									</td>
			 					</tr>
			 				</table>
			 			</div>
		 			</td>
				</tr>
		 	</table>
		</div>	
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		document.all.cap1.SwitchWatchOnly();
	})
	function startCam(){
		var capActivexObject=document.getElementById('cap1');
		//启动摄像头
		capActivexObject.start();
	}

	function capPicture1(){
		var capActivexObject=document.getElementById('cap1');
		capActivexObject.cap(); //控制摄像头拍照
	}
	
	function ajax_post() { //ajax上传
		var base64_data = document.getElementById('cap1').getCurrentFrame(); //取当前帧图像数据
		var picExt = document.getElementById('picExt1').value;
		$.post("attendanceAction!check.action",{"picData":base64_data, "picExt":picExt}, function(datas){
			if("success" == datas) {
				alert("考勤签认成功！");
				document.getElementById('cap1').clear();
			}else{
				alert("考勤签认失败！");
				document.getElementById('cap1').clear();
			}
		})
		//alert('base64_data:'+base64_data +'----picExt:'+picExt);
	}
	function submitToServer(){
		//读取控件的拍照结果到hidden输入项中
		var base64_data1 = document.getElementById('cap1').jpegBase64Data;
		if (base64_data1.length==0) {
			alert("请先拍照！");
		}else{
			document.getElementById('picData1').value=base64_data1;
			document.getElementById('picExt1').value='.jpg';
			ajax_post();
		}
	}
</script>
</html>