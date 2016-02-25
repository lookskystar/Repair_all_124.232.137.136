<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@include file="/common/common.jsp" %>
<%@include file="/checkLogin.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>机务检修系统</title>
	<!--框架必需start--> 
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--引入弹窗组件end-->
	<!--框架必需end-->
	<link href="pro_dropdown_2/pro_dropdown_2.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="pro_dropdown_2/stuHover.js"></script>
	<!--[if IE 6]>
	<script src="js/iepngfx.js" language="javascript" type="text/javascript"></script>
	<![endif]-->
	<script type="text/javascript"> 
	//批量扣车
	function kcs(){
		var diag = new top.Dialog();
		diag.Title = "日计划批量制定窗口";
		diag.URL = "<%=basePath%>planManage!addDailyPlanOfBatchInput.action";
		diag.Width="100";
		diag.Height="100";
		diag.show();
	}
	
	//扣车
	function kc(){
		var diag = new top.Dialog();
		diag.Title = "日计划制定窗口";
		diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action";
		diag.Width=450;
		diag.Height=430;
		diag.show();
	}
	$(function(){
		//查询报活
		$.post("workAction!countBZJtPreDict.do",null,function(text){
			var array = eval("("+text+")");
			var str = "";
			var obj;
			for ( var i=0; i<array.length;i++) {
				obj = array[i];
				<c:choose>
			  		<c:when test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,')}">
			  		   if(obj.projecttype==1){
							str +='<li><a href="workAction!listZxRatifyItemsInput.do?rjhmId='+obj.rjhmId+'&xx='+obj.xx+'" target="frmright"><span class="icon_lightOn">'+obj.jctype+"-"+obj.jcnum+"-"+obj.xx+'存在<font style="color:#f00;font-size:16px;font-weight:blod">'+obj.count+'</font>个未完成报活</span></a></li><div class="clear"></div>';
						}else{
							str +='<li><a href="workAction!listRatifyItemsInput.do?rjhmId='+obj.rjhmId+'&xx='+obj.xx+'" target="frmright"><span class="icon_lightOn">'+obj.jctype+"-"+obj.jcnum+"-"+obj.xx+'存在<font style="color:#f00;font-size:16px;font-weight:blod">'+obj.count+'</font>个未完成报活</span></a></li><div class="clear"></div>';
						}
			  		</c:when>
			  		<c:otherwise>
			  		     if(obj.projecttype==1){
							str +='<li><span class="icon_lightOn">'+obj.jctype+"-"+obj.jcnum+"-"+obj.xx+'存在<font style="color:#f00;font-size:16px;font-weight:blod">'+obj.count+'</font>个未完成报活</span></li><div class="clear"></div>';
						}else{
							str +='<li><span class="icon_lightOn">'+obj.jctype+"-"+obj.jcnum+"-"+obj.xx+'存在<font style="color:#f00;font-size:16px;font-weight:blod">'+obj.count+'</font>个未完成报活</span></li><div class="clear"></div>';
						}
			  		</c:otherwise>
				</c:choose>
			}
			if(str!=""){
				$.messager.lays(300, 200);
				$.messager.show('未完成报活','<div style="overflow: auto;height:165px;"><ul>'+str+'</ul></div>','stay');
			}
		});
	});
	</script>
</head>
<body style="background: #fff;">
	<div id="mainFrame">
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
								<a href="<%=basePath%>update_pwd.jsp" target="jcmain">
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
			</div>
		</div>
		<ul id="nav">
			<li class="top"><span style="font-size: 14px;float:left; display:block; padding:8px 24px 0 12px; height:35px;color: red;">欢迎你:${session_user.xm}</span><img src="images/9.png"/></li>
			<li class="top"><a href="<%=basePath%>loginAction!login.action?userid=${sessionScope.session_user.userid}"" class="top_link"><span>机车检修 </span></a><img src="images/9.png"/></li>
			<li class="top"><a href="pj_main.jsp" class="top_link"><span>配件检修</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="ts_main.jsp" class="top_link"><span>探伤检修</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="js_main.jsp" class="top_link"><span>技术管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="plant_main.jsp" class="top_link"><span>车间管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="bz_main.jsp" class="top_link"><span>标准管理</span></a><img src="images/9.png"/></li>
			<li class="top"><a href="plan_main.jsp" class="top_link"><span>计划管理</span></a><img src="images/9.png"/></li>
			<c:if test="${parameterValue == 1}">
				<li class="top"><a href="kq_main.jsp" class="top_link"><span>考勤管理</span></a><img src="images/9.png"/></li>
			</c:if>
			<li class="top"><a href="<%=basePath%>report/lead_select.jsp" class="top_link" target="jcmain"><span class="down">检修记录</span></a><img src="images/9.png"/>
				<ul class="sub">
					<li><a href="<%=basePath%>report/lead_select.jsp" class="fly" target="jcmain">机车检修记录</a>
						<ul>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=Z" target="jcmain">中&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=X" target="jcmain">小&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=F" target="jcmain">辅&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=LX" target="jcmain">临&nbsp;&nbsp;修</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=JG" target="jcmain">加&nbsp;&nbsp;改</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=QZ" target="jcmain">整&nbsp;&nbsp;治</a></li>
							<li><a href="<%=basePath%>query!queryByXcxc.do?xcxc=CJ" target="jcmain">春&nbsp;&nbsp;鉴</a></li>
							<li><a href="<%=basePath%>report/lead_select.jsp" target="jcmain">其&nbsp;&nbsp;他</a></li>
						</ul>
					</li>
					<li><a href="<%=basePath%>pjManageAction!inputPartRecord.do?jcStype=DF4D" target="jcmain">配件检修记录</a></li>
				</ul>
			</li>
			<li class="top"><a href="javascript:;" id="products" class="top_link"><span class="down">操&nbsp;&nbsp;&nbsp;&nbsp;作</span></a>
				<ul class="sub">
					<li class="mid"><a href="javascript:;" class="fly">计划扣车</a>
						<ul>
							<li><a href="javascript:;" onclick="kc();">新增日计划</a></li> 
							<li><a href="javascript:;" onclick="kcs();">批量新增日计划</a></li> 
						</ul>
					</li>
					<li class="mid"><a href="<%=basePath%>report/jcgz_main.jsp" >返回主界面</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<!--头部与导航end-->
	<iframe scrolling="no" width="100%" frameBorder=0 id="jcmain" name="jcmain"  onload="iframeHeight('jcmain')" src="<%=basePath %>report!findAllJC.do?type=jcgz"  allowTransparency="true"></iframe>
</body>
</html>
	
	