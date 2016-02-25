<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%@include file="/checkLogin.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String area = request.getParameter("area");
String flag = request.getParameter("flag");
if(area != null && !"".equals(area) && flag != null && !"".equals(flag)){
	request.setAttribute("area", area);
	request.setAttribute("flag", flag);
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>机务检修管理系统</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/bsFormat.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!-- 头部样式 -->
	<link href="pro_dropdown_2/pro_dropdown_2.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="pro_dropdown_2/stuHover.js"></script>
	<!--修正IE6支持透明png图片start-->
	<!--[if IE 6]>
	<script src="js/iepngfx.js" language="javascript" type="text/javascript"></script>
	<![endif]-->
	<script type="text/javascript">
	$(document).ready(function(){
		jQuery.navlevel2 = function(level1,dytime) {
			
		  $(level1).mouseenter(function(){
			  varthis = $(this);
			  delytime=setTimeout(function(){
				varthis.find('ul').slideDown();
			},dytime);
			
		  });
		  $(level1).mouseleave(function(){
			 clearTimeout(delytime);
			 $(this).find('ul').slideUp();
		  });
		  
		};
	  $.navlevel2("li.mainlevel",200);
	});
	
	function goBack(){
		history.back();
	}
	</script> 
</head>
<body style="background: #fff;">
	<!--头部与导航start-->
	<div id="hbox">
		<div id="bs_bannercenter">
			<div id="bs_bannerleft">
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
						<a href="<%=basePath%>update_pwd.jsp" target="leadmain">
							<div class="nav_icon_h_item_img"><img src="icons/png/pwd.png"/></div>
							<div class="nav_icon_h_item_text">修改密码</div>
						</a>
						</div>
						<div class="nav_icon_h_item">
						<a href="javascript:;" onclick='top.Dialog.confirm("确定要退出系统吗",function(){window.location="<%=basePath%>loginAction!loginOut.do"});'>
							<div class="nav_icon_h_item_img"><img src="icons/png/out.png"/></div>
							<div class="nav_icon_h_item_text">退出系统</div>
						</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<ul id="nav">
			<li class="top"><span style="font-size: 14px;float:left; display:block; padding:8px 24px 0 12px; height:35px;color: red;">欢迎你:${session_user.xm}</span><img src="images/9.png"/></li>
			<li class="top"><a href="report/lead_main.jsp" class="top_link"><span>机车检修 </span></a><img src="images/9.png"/></li>
			<li class="top"><a href="pj_main.jsp" class="top_link"><span>配件检修</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="ts_main.jsp" class="top_link"><span>探伤检修</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="js_main.jsp" class="top_link"><span>技术管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="plant_main.jsp" class="top_link"><span>车间管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="bz_main.jsp" class="top_link"><span>标准管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="plan_main.jsp" class="top_link"><span>计划管理</span></a><img src="images/9.png"/></li>
			<c:if test="${parameterValue == 1}">
				<li class="top"><a href="kq_main.jsp" class="top_link"><span>考勤管理</span></a><img src="images/9.png"/></li>
			</c:if>
			<li class="top"><a href="<%=basePath%>report/lead_select.jsp" class="top_link" target="leadmain"><span class="down">检修记录</span></a><img src="images/9.png"/>
				<ul class="sub">
					<li><a href="<%=basePath%>report/lead_select.jsp" class="fly" target="leadmain">机车检修记录</a>
						<ul>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=Z" target="leadmain">中&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=X" target="leadmain">小&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=F" target="leadmain">辅&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=LX" target="leadmain">临&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=JG" target="leadmain">加&nbsp;&nbsp;改</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=QZ" target="leadmain">整&nbsp;&nbsp;治</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=CJ" target="leadmain">春&nbsp;&nbsp;鉴</a></li>
							<li><a href="<%=basePath%>report/lead_select.jsp" target="leadmain">其&nbsp;&nbsp;他</a></li>
						</ul>
					</li>
					<li><a href="<%=basePath%>pjManageAction!inputPartRecord.do?jcStype=DF4D" target="leadmain">配件检修记录</a></li>
				</ul>
			</li>
			<li class="top"><a href="javascript:;" id="products" class="top_link"><span class="down">操&nbsp;&nbsp;&nbsp;&nbsp;作</span></a>
			<ul class="sub">
			    <li class="mid"><a href="<%=basePath %>report/lead_main.jsp">返回主页面</a></li>
				<li class="mid"><a href="<%=basePath %>report!findAllJC.do?type=jcgz&flag=gdt" target="leadmain">切换到股道图</a></li>
				<!-- 
				<li class="mid"><a href="javascript:void(0);" onclick="goBack();">返回</a></li>
				 -->
			</ul>
		</li>
		</ul>
	</div>
	<!-- 头部导航end -->
	<iframe scrolling="auto" width="100%" height="500px" frameBorder=0 id="leadmain" name="leadmain" src="<%=basePath %>report!findAllJC.do?type=lead"  allowTransparency="true"></iframe>
</body>
</html>