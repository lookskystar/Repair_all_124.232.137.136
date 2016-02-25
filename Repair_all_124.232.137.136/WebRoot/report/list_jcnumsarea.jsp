<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<title>广州铁路(集团)公司</title>
<!--框架必需start-->
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>

<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<script type="text/javascript" src="js/attention/messager.js"></script>
<!--文本截取end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
<style type="text/css">
TABLE.bluetable {
	FONT: 100% Arial, Helvetica, sans-serif
}
TD {
	FONT: 100% Arial, Helvetica, sans-serif
}
TABLE.bluetable {
	MARGIN: 0.1em 0px; BORDER-COLLAPSE: collapse
}
TABLE.bluetable TH {
	BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
}
TABLE.bluetable TD {
	BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
}
TABLE.bluetable TH {
	BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x; COLOR: #fff
}
TABLE.bluetable TD {
	BACKGROUND: #e5f1f4
}
TABLE.bluetable TR.even TD {
	BACKGROUND: #e5f1f4
}
TABLE.bluetable TR.odd TD {
	BACKGROUND: #f8fbfc
}
TABLE.bluetable TH.over {
	BACKGROUND: #4a98af
}
TABLE.bluetable TR.even TH.over {
	BACKGROUND: #4a98af
}
TABLE.bluetable TR.odd TH.over {
	BACKGROUND: #4a98af
}
TABLE.bluetable TH.down {
	BACKGROUND: #bce774
}
TABLE.bluetable TR.even TH.down {
	BACKGROUND: #bce774
}
TABLE.bluetable TR.odd TH.down {
	BACKGROUND: #bce774
}
TABLE.bluetable TH.selected {
	
}
TABLE.bluetable TR.even TH.selected {
	
}
TABLE.bluetable TR.odd TH.selected {
	
}
TABLE.bluetable TD.over {
	BACKGROUND: #ecfbd4
}
TABLE.bluetable TR.even TD.over {
	BACKGROUND: #ecfbd4
}
TABLE.bluetable TR.odd TD.over {
	BACKGROUND: #ecfbd4
}
TABLE.bluetable TD.down {
	BACKGROUND: #bce774; COLOR: #fff
}
TABLE.bluetable TR.even TD.down {
	BACKGROUND: #bce774; COLOR: #fff
}
TABLE.bluetable TR.odd TD.down {
	BACKGROUND: #bce774; COLOR: #fff
}
TABLE.bluetable TD.selected {
	BACKGROUND: #bce774; COLOR: #555
}
TABLE.bluetable TR.even TD.selected {
	BACKGROUND: #bce774; COLOR: #555
}
TABLE.bluetable TR.odd TD.selected {
	BACKGROUND: #bce774; COLOR: #555
}
TABLE.bluetable TD.empty {
	BACKGROUND: #fff
}
TABLE.bluetable TR.odd TD.empty {
	BACKGROUND: #fff
}
TABLE.bluetable TR.even TD.empty {
	BACKGROUND: #fff
}
</style>
</head>

<body>
<!--头部与导航start-->
<div id="mainFrame">
<div id="hbox">
	<div id="bs_bannercenter">
	<div id="bs_bannerleft">
	<div id="bs_bannerright">
	   <!-- 
		<div class="bs_banner_logo"></div> -->
		<div class="bs_banner_title"></div>
		<div class="bs_nav">
			<div class="bs_navleft">
				<li>
					欢迎您：${session_user.xm}，今天是
				<script>
					var weekDayLabels = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
					var now = new Date();
				    var year=now.getFullYear();
					var month=now.getMonth()+1;
					var day=now.getDate()
				    var currentime = year+"年"+month+"月"+day+"日 "+weekDayLabels[now.getDay()]
					document.write(currentime)
				</script>
				</li>
				<a href="query!listJcNumsByArea.do?login=${session_user.pwd }&area=${area }"><span class="icon_poll hand" style="margin-left: 10px;">机车检修</span></a>
				<a href="http://${url }/xx/lead_pj_main.jsp?area=${area }"><span class="icon_globe hand" style="margin-left: 10px;">配件检修</span></a>
				<div class="clear"></div>
			</div>
			<div class="bs_navright">
				<span class="icon_no hand" onclick='top.Dialog.confirm("确定要退出系统吗",function(){window.location="<%=basePath%>loginAction!loginOut.do"});'>退出系统</span>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	</div>
</div>
<!--头部与导航end-->

<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" align="center">
	  	<tr>
			<td>
		  		<div class="box2" panelHeight="450"  panelTitle="在修机车一览表"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  		<center>
		  		<form action="query!listJcNumsByArea.do?login=${session_user.pwd }&area=${area }" method="post">
		  	  		日期：<input type="text" class="Wdate" onfocus="WdatePicker()" name="time" style="width:120px" 
		  	  			<c:choose>
		 					<c:when test="${not empty time}">value="${time }"</c:when>
		 					<c:otherwise>value='<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>'</c:otherwise>
		 				</c:choose>/>&nbsp;&nbsp;
		 			<input type="submit" value="查  询"/>
		 			
		 			<a href="http://${url }/xx/report/lead_main.jsp?type=1"><font size="4" color="blue">当日在修机车</font></a>
		  		</form>
		  		</center>
		  		<br/>
		  		<center>
		  	   	<table width="80%" class="bluetable" id="tab">
					<tr>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">单位</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">型号</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">大修</th>
					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">中修</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">小辅修</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">临修</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">其它</th>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">合计</th>
					</tr>
					<c:set var="zxCount" value="0"/>
					<c:set var="xfxCount" value="0"/>
					<c:set var="lxCount" value="0"/>
					<c:set var="qtCount" value="0"/>
					<c:forEach var="map" items="${packageMap }" varStatus="s" >
					  	<tr>
						    <td style="text-align: center;">
						    	<c:if test="${fn:startsWith(area, 'c')}">长沙机务段</c:if>
			                    <c:if test="${fn:startsWith(area, 'z')}">株洲机务段</c:if>
			                    <c:if test="${fn:startsWith(area, 'h')}">怀化机务段</c:if>
			                    <c:if test="${fn:startsWith(area, 'g')}">广州机务段</c:if>
			                    <c:if test="${fn:startsWith(area, 'l')}">龙川机务段</c:if>
			                    <c:if test="${fn:startsWith(area, 's')}">三水机务段</c:if>
						    </td>
						    <td style="text-align: center;">${map.key }</td>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'dx', '${time }', '${map.key }');" style="color:blue;">0</a></td>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'zx', '${time }', '${map.key }');" style="color:blue;">${map.value.zx }</a></td>
						    <c:set var="zxCount" value="${zxCount+map.value.zx}"/>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'xfx', '${time }', '${map.key }');" style="color:blue;">${map.value.xfx }</a></td>
						    <c:set var="xfxCount" value="${xfxCount+map.value.xfx}"/>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'lx', '${time }', '${map.key }');" style="color:blue;">${map.value.lx }</a></td>
						    <c:set var="lxCount" value="${lxCount+map.value.lx}"/>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'qt', '${time }', '${map.key }');" style="color:blue;">${map.value.qt }</a></td>
						    <c:set var="qtCount" value="${qtCount+map.value.qt}"/>
						    <td style="text-align: center;"><a href="javascript:listJcNumType('${session_user.pwd}', '${area }', 'all', '${time }', '${map.key }');" style="color:blue;">${map.value.zx+map.value.xfx+map.value.lx+map.value.qt }</a></td>
					 	</tr>
					</c:forEach>
					<tr>
						<td style="text-align: center; background-color: #ffcc66;">
						 	<c:if test="${fn:startsWith(area, 'c')}">长沙机务段</c:if>
		                    <c:if test="${fn:startsWith(area, 'z')}">株洲机务段</c:if>
		                    <c:if test="${fn:startsWith(area, 'h')}">怀化机务段</c:if>
		                    <c:if test="${fn:startsWith(area, 'g')}">广州机务段</c:if>
		                    <c:if test="${fn:startsWith(area, 'l')}">龙川机务段</c:if>
		                    <c:if test="${fn:startsWith(area, 's')}">三水机务段</c:if>合计
						</td>
						<td style="text-align: center; background-color: #ffcc66;"></td>
						<td style="text-align: center; background-color: #ffcc66;">0</td>
						<td style="text-align: center; background-color: #ffcc66;">${zxCount }</td>
						<td style="text-align: center; background-color: #ffcc66;">${xfxCount }</td>
						<td style="text-align: center; background-color: #ffcc66;">${lxCount }</td>
						<td style="text-align: center; background-color: #ffcc66;">${qtCount }</td>
						<td style="text-align: center; background-color: #ffcc66;">${zxCount+xfxCount+lxCount+qtCount }</td>
					</tr>
				</table>
				</center>
	    	  </div>
			</td>
	  	</tr>
	</table>
</div>			
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>	
<script type="text/javascript">
	//各机务段在修机车列表	
	function listJcNumType(login, area, xcxc, time, jcType){
		var diag = new top.Dialog();
		diag.Title = "在修机车列表";
		diag.URL = 'query!listJcNumsType.do?area='+area+'&xcxc='+xcxc+'&time='+time+'&login='+login+'&jcType='+jcType;
		diag.Width=600;
		diag.Height=520;
		diag.show();
	}
</script>
</body>
</html>