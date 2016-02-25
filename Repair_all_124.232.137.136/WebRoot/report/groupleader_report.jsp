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
	<title>集团领导报表首页</title>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--框架必需end-->
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--引入组件end-->
	<link href="pro_dropdown_2/pro_dropdown_2.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="pro_dropdown_2/stuHover.js"></script>
	<!--[if IE 6]>
	<script src="js/iepngfx.js" language="javascript" type="text/javascript"></script>
	<![endif]-->
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<style type="text/css">
		TABLE.bluetable {
			FONT: 100% Arial, Helvetica, sans-serif
		}
		
		TD {
			FONT: 100% Arial, Helvetica, sans-serif
		}
		
		TABLE.bluetable {
			MARGIN: 0.1em 0px;
			BORDER-COLLAPSE: collapse
		}
		
		TABLE.bluetable TH {
			BORDER-BOTTOM: #2b3b58 1px solid;
			TEXT-ALIGN: left;
			BORDER-LEFT: #2b3b58 1px solid;
			PADDING-BOTTOM: 0.5em;
			PADDING-LEFT: 0.5em;
			PADDING-RIGHT: 0.5em;
			BORDER-TOP: #2b3b58 1px solid;
			BORDER-RIGHT: #2b3b58 1px solid;
			PADDING-TOP: 0.5em
		}
		
		TABLE.bluetable TD {
			BORDER-BOTTOM: #2b3b58 1px solid;
			TEXT-ALIGN: left;
			BORDER-LEFT: #2b3b58 1px solid;
			PADDING-BOTTOM: 0.5em;
			PADDING-LEFT: 0.5em;
			PADDING-RIGHT: 0.5em;
			BORDER-TOP: #2b3b58 1px solid;
			BORDER-RIGHT: #2b3b58 1px solid;
			PADDING-TOP: 0.5em
		}
		
		TABLE.bluetable TH {
			BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x;
			COLOR: #fff
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
			BACKGROUND: #bce774;
			COLOR: #fff
		}
		
		TABLE.bluetable TR.even TD.down {
			BACKGROUND: #bce774;
			COLOR: #fff
		}
		
		TABLE.bluetable TR.odd TD.down {
			BACKGROUND: #bce774;
			COLOR: #fff
		}
		
		TABLE.bluetable TD.selected {
			BACKGROUND: #bce774;
			COLOR: #555
		}
		
		TABLE.bluetable TR.even TD.selected {
			BACKGROUND: #bce774;
			COLOR: #555
		}
		
		TABLE.bluetable TR.odd TD.selected {
			BACKGROUND: #bce774;
			COLOR: #555
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
	<div id="hbox">
		<div id="bs_bannercenter">
			<div id="bs_bannerleft">
				<div id="bs_bannerright2">
					<div class="bs_banner_title"></div>
					<div id="bs_bannerright2">
						<div class="bs_banner_title"></div>
						<div class="nav_icon_h">
							<div class="nav_icon_h_item">
							<a href="<%=basePath%>help.jsp" target="frmright">
								<div class="nav_icon_h_item_img"><img src="icons/png/64.png"/></div>
								<div class="nav_icon_h_item_text">帮助文档</div>
							</a>
							</div>
							<div class="nav_icon_h_item">
							<a href="<%=basePath%>update_pwd.jsp" target="frmright">
								<div class="nav_icon_h_item_img"><img src="icons/png/pwd.png"/></div>
								<div class="nav_icon_h_item_text">修改密码</div>
							</a>
							</div>
							<div class="nav_icon_h_item">
							<a onclick='Dialog.confirm("确定要退出系统吗",function(){window.location="<%=basePath%>loginAction!loginOut.do"});'>
								<div class="nav_icon_h_item_img"><img src="icons/png/out.png"/></div>
								<div class="nav_icon_h_item_text">退出系统</div>
							</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<ul id="nav">
				<li class="top"><span style="font-size: 14px;float:left; display:block; padding:8px 24px 0 12px; height:35px;color: red;">欢迎你:${session_user.xm}</span><img src="images/9.png"/></li>
				<li class="top"><a href="<%=basePath%>loginAction!login.action?userid=${sessionScope.session_user.userid}"" class="top_link"><span>机车检修 </span></a><img src="images/9.png"/></li>
				<li class="top"><a href="pj_main.jsp" class="top_link" target="_blank"><span>配件检修</span></a><img src="images/9.png"/></li>
				<li class="top"><a href="<%=basePath%>report/lead_select.jsp" class="top_link"><span class="down">检修记录</span></a><img src="images/9.png"/>
					<ul class="sub">
						<li><a href="<%=basePath%>report/lead_select.jsp" class="fly" >机车检修记录</a>
							<ul>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=Z" >中&nbsp;&nbsp;修</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=X" >小&nbsp;&nbsp;修</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=F" >辅&nbsp;&nbsp;修</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=LX" >临&nbsp;&nbsp;修</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=JG" >加&nbsp;&nbsp;改</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=QZ" >整&nbsp;&nbsp;治</a></li>
								<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=CJ" >春&nbsp;&nbsp;鉴</a></li>
								<li><a href="<%=basePath%>report/lead_select.jsp" >其&nbsp;&nbsp;他</a></li>
							</ul>
						</li>
						<li><a href="<%=basePath%>pjManageAction!inputPartRecord.do?jcStype=DF4D">配件检修记录</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!--头部与导航end-->
	<div id="scrollContent">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
					<center>
						<form action="query!groupLeaderReport.do" method="post">
							开始日期：<input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="startDate" value="${startDate}" />
							结束日期：<input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endDate" value="${endDate }" /> 
							<input type="submit" value="查  询" />
						</form>
					</center>
					<br/>
					<center>
						<table width="80%" class="bluetable" id="tab">
							<tr>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" rowspan="2">机务段</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">大修</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">中修</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">小辅修</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">临修</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">其它</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="3">合计</th>
							</tr>
							<tr>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际</th>
								<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">未兑现</th>
							</tr>
							<c:forEach items="${dataList }" var="data">
									<c:set var="dxjh" value="0"/>
									<c:set var="dxsj" value="0"/>
									<c:set var="dxno" value="0"/>
									
									<c:set var="zxjh" value="0"/>
									<c:set var="zxsj" value="0"/>
									<c:set var="zxno" value="0"/>
									
									<c:set var="fxjh" value="0"/>
									<c:set var="fxsj" value="0"/>
									<c:set var="fxno" value="0"/>
									
									<c:set var="lxjh" value="0"/>
									<c:set var="lxsj" value="0"/>
									<c:set var="lxno" value="0"/>
									
									<c:set var="qtjh" value="0"/>
									<c:set var="qtsj" value="0"/>
									<c:set var="qtno" value="0"/>
								<tr>
									<td style="text-align: center;">
										<a href="local_station_reports.html" style="color:blue;">
											<c:if test="${data.area == 'zz'}">
												<a href="http://10.183.217.5/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >株洲段</a>
											</c:if>
											<c:if test="${data.area == 'hh'}">
												<a href="http://10.165.25.115/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >怀化段</a>
											</c:if>
											<c:if test="${data.area == 'cs'}">
												<a href="http://10.183.214.3/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >长沙段</a>
											</c:if>
											<c:if test="${data.area == 'gz'}">
												<a href="http://10.167.61.71:8080/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >广州段</a>
											</c:if>
											<c:if test="${data.area == 'lc'}">
												<a href="http://10.175.167.237/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >龙川段</a>
											</c:if>
											<c:if test="${data.area == 'ss'}">
												<a href="http://10.171.33.159/xx/query!groupLeaderReportDetail.do?name=${session_user.gonghao }&login=${session_user.pwd }&area=${data.area }" style="color:blue;" >三水段</a>
												
											</c:if>
										</a>
									</td>
									<td style="text-align: center;">
										<font color="blue">${data.dxjh }</font>
									</td>
									<c:set var="dxjh" value="${dxjh + data.dxjh}"/>
									<td style="text-align: center;">
										<font color="blue">${data.dxsj }</font>
									</td>
									<c:set var="dxsj" value="${dxsj + data.dxsj}"/>
									<td style="text-align: center;">
										<font color="red">${data.dxno }</font>
									</td>
									<c:set var="dxno" value="${dxno + data.dxno}"/>
									<td style="text-align: center;">
										<font color="blue">${data.zxjh }</font>
									</td>
									<c:set var="zxjh" value="${zxjh + data.zxjh}"/>
									<td style="text-align: center;">
										<font color="blue">${data.zxsj }</font>
									</td>
									<c:set var="zxsj" value="${zxsj + data.zxsj}"/>
									<td style="text-align: center;">
										<font color="red">${data.zxno }</font>
									</td>
									<c:set var="zxno" value="${zxno + data.zxno}"/>
									<td style="text-align: center;">
										<font color="blue">${data.fxjh }</font>
									</td>
									<c:set var="fxjh" value="${fxjh + data.fxjh}"/>
									<td style="text-align: center;">
										<font color="blue">${data.fxsj }</font>
									</td>
									<c:set var="fxsj" value="${fxsj + data.fxsj}"/>
									<td style="text-align: center;">
										<font color="red">${data.fxno }</font>
									</td>
									<c:set var="fxno" value="${fxno + data.fxno}"/>
									<td style="text-align: center;">
										<font color="blue">${data.lxjh }</font>
									</td>
									<c:set var="lxjh" value="${lxjh + data.lxjh}"/>
									<td style="text-align: center;">
										<font color="blue">${data.lxsj }</font>
									</td>
									<c:set var="lxsj" value="${lxsj + data.lxsj}"/>
									<td style="text-align: center;">
										<font color="red">${data.lxno }</font>
									</td>
									<c:set var="lxno" value="${lxno + data.lxno}"/>
									<td style="text-align: center;">
										<font color="blue">${data.qtjh }</font>
									</td>
									<c:set var="qtjh" value="${qtjh + data.qtjh}"/>
									<td style="text-align: center;">
										<font color="blue">${data.qtsj }</font>
									</td>
									<c:set var="qtsj" value="${qtsj + data.qtsj}"/>
									<td style="text-align: center;">
										<font color="red">${data.qtno }</font>
									</td>
									<c:set var="qtno" value="${qtno + data.qtno}"/>
									<td style="text-align: center;">${dxjh + zxjh + fxjh + lxjh + qtjh }</td>
									<td style="text-align: center;">${dxsj + zxsj + fxsj + lxsj + qtsj }</td>
									<td style="text-align: center;">
										<font color="red">${dxno + zxno + fxno + lxno + qtno }</font>
									</td>
								</tr>
							</c:forEach>
						</table>
					</center>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
