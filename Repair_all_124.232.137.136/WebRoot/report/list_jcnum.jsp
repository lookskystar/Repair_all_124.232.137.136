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
</head>

<body>
<!--头部与导航start-->
<div id="mainFrame">
<div id="hbox">
	<div id="bs_bannercenter">
	<div id="bs_bannerleft">
	<div id="bs_bannerright">
		<div class="bs_banner_logo"></div>
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
					var day=now.getDate();
				    var currentime = year+"年"+month+"月"+day+"日 "+weekDayLabels[now.getDay()];
					document.write(currentime)
				</script>
				</li>
				
				<a href="query!listJcNum.do?area=${area }"><span class="icon_poll hand" style="margin-left: 10px;">机车检修</span></a>
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
		  		<form action="query!listJcNum.do?area=${area }" method="post">
		  	  		日期：<input type="text" class="Wdate" onfocus="WdatePicker()" name="time" style="width:120px" 
		  	  			<c:choose>
		 					<c:when test="${not empty time}">value="${time }"</c:when>
		 					<c:otherwise>value='<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>'</c:otherwise>
		 				</c:choose>/>&nbsp;&nbsp;
		 			<input type="submit" value="查  询"/>
		 			
		 			<a href="http://${url }/xx/report/lead_main.jsp?type=1"><font size="4" color="blue">机车检修记录查询</font></a>
		  		</form>
		  		</center>
		  		<br/>
		  	   	<table width="100%" class="tableStyle" id="tab">
					<tr>
						<td class="ver01" width="10%" align="center" style="font-size: 20px;vertical-align: middle;" colspan="2">大修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">轻大修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">中修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">小修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">辅修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">年检</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">半年检</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">季度</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">月检</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">临修</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">加改</td>
						<td class="ver01" width="8%" align="center" style="font-size: 20px;vertical-align: middle;">其它</td>
					</tr>
					<c:forEach var="data" begin="0" end="${maxRow }" varStatus="s" >
					  	<tr>
					  		<td class="ver01" style="font-size: 15px;" align="center" colspan="2"></td>
						    <td class="ver01" style="font-size: 15px;" align="center"></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!zxView.do?id=${datas.zx[s.index].rjhmid }">${datas.zx[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.xx[s.index].rjhmid }&jcStype=${datas.xx[s.index].jcStype}&jcNum=${datas.xx[s.index].jcnum}&xcxc=${datas.xx[s.index].xcxc}&id=${datas.xx[s.index].rjhmid }">${datas.xx[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.fx[s.index].rjhmid }&jcStype=${datas.fx[s.index].jcStype}&jcNum=${datas.fx[s.index].jcnum}&xcxc=${datas.fx[s.index].xcxc}&id=${datas.fx[s.index].rjhmid }">${datas.fx[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.nj[s.index].rjhmid }&jcStype=${datas.nj[s.index].jcStype}&jcNum=${datas.nj[s.index].jcnum}&xcxc=${datas.nj[s.index].xcxc}&id=${datas.nj[s.index].rjhmid }">${datas.nj[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.bnj[s.index].rjhmid }&jcStype=${datas.bnj[s.index].jcStype}&jcNum=${datas.bnj[s.index].jcnum}&xcxc=${datas.bnj[s.index].xcxc}&id=${datas.bnj[s.index].rjhmid }">${datas.bnj[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.jd[s.index].rjhmid }&jcStype=${datas.jd[s.index].jcStype}&jcNum=${datas.jd[s.index].jcnum}&xcxc=${datas.jd[s.index].xcxc}&id=${datas.jd[s.index].rjhmid }">${datas.jd[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.yj[s.index].rjhmid }&jcStype=${datas.yj[s.index].jcStype}&jcNum=${datas.yj[s.index].jcnum}&xcxc=${datas.yj[s.index].xcxc}&id=${datas.yj[s.index].rjhmid }">${datas.yj[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.lx[s.index].rjhmid }&jcStype=${datas.lx[s.index].jcStype}&jcNum=${datas.lx[s.index].jcnum}&xcxc=${datas.lx[s.index].xcxc}&id=${datas.lx[s.index].rjhmid }">${datas.lx[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"><a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${datas.jg[s.index].rjhmid }&jcStype=${datas.jg[s.index].jcStype}&jcNum=${datas.jg[s.index].jcnum}&xcxc=${datas.jg[s.index].xcxc}&id=${datas.jg[s.index].rjhmid }">${datas.jg[s.index].jcnum}</a></td>
						    <td class="ver01" style="font-size: 15px;" align="center"></td>
					 	</tr>
					</c:forEach>
					<tr>
						<td class="ver01" style="font-size: 15px;" align="center" width="5">合计</td> 
						<td class="ver01" style="font-size: 15px;" align="center">0</td>
						<td class="ver01" style="font-size: 15px;" align="center">0</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.zx)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.xx)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.fx)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.nj)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.bnj)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.jd)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.yj)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.lx)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">${fn:length(datas.jg)}</td>
						<td class="ver01" style="font-size: 15px;" align="center">0</td>
					</tr>
				</table>
	    	  </div>
			</td>
	  	</tr>
	</table>
</div>			
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>	
</body>
</html>