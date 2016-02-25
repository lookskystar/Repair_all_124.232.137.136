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
	<script type="text/javascript">
		$(function(){
			cellMege('datatable','firstname');
			cellMege('datatable','secondname');
		});
		
		//合并表格的单元格
		function cellMege(table,col){
			var lines=$('#'+table+' tr').size();
			if(lines<=2) return ;
			var v,l=0,current='',index=1;
			for(var i=1;i<lines;i++){
				var tr=$('#'+table+' tr').eq(i);
				v = tr.find('td[name="'+col+'"]').html();
				l++;
				if(v != current || i == (lines-1)){//如果两个值不相同或者是最后一行
					if(i == (lines - 1)) l++;
					if(l > 1){//超过两行，合并 
						var td = $('#'+ table +' tr').eq(index).find('td[name="'+ col +'"]');
						td.attr('rowspan',l);
						for(var j=1;j<l;j++){
							var td = $('#'+table+' tr').eq(index+j).find('td[name="'+col+'"]').remove();
						}
					}
					l = 0;//从新计数
					current = v;
					index = i;
				}
			}
		}
		
	
	</script>
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
		<table width="100%"  border="0" cellspacing="0" cellpadding="0" align="center">
		  <tr>
			<td>
			  	<center>
			  	<form action="query!groupLeaderReportDetail.do" method="post">
					开始日期：<input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="startDate" value="${startDate}" />
					结束日期：<input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endDate" value="${endDate }" /> 
					<input type="submit" value="查  询" />
				</form>
			  	</center>
			  	<br/>
			  		<center>
				  	   	<table width="80%" class="bluetable" id="datatable">
				  	   		<tr> 
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">修程</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;" colspan="2">机车号</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">扣车时间</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">计划起机时间</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">实际起机时间</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">交车时间</th>
				  	   			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">备注</th>
				  	   		</tr>
				  	   		<c:forEach items="${list}" var="data">
					  	   		<tr>
									<td name="firstname" title="${data.xc }" class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;background: #328aa4;color: #fff;">
										<c:if test="${fn:contains(data.xc, 'dx') }">
											大修
										</c:if>
										<c:if test="${fn:contains(data.xc, 'zx') }">
											中修
										</c:if>
										<c:if test="${fn:contains(data.xc, 'fx') }">
											小辅修
										</c:if>
										<c:if test="${fn:contains(data.xc, 'lx') }">
											临修
										</c:if>
										<c:if test="${fn:contains(data.xc, 'qt') }">
											其他
										</c:if>
									</th>
									<td name="secondname" title="${data.plan }" class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;background: #328aa4;color: #fff;">
										<c:if test="${fn:contains(data.plan, 'sj')}">
											实际
										</c:if>
										<c:if test="${fn:contains(data.plan, 'no')}">
											未兑现
										</c:if>
									</td>
									<td style="text-align: center;">
										<c:choose>
											<c:when test="${fn:contains(data.plan, 'sj')}">
												<a href="query!getInfoByJC.do?rjhmId=${data.id }&psize=100" target="_blank" style="color: blue;">
													${data.jctype }-${data.jcnum }
												</a>
											</c:when>
											<c:otherwise>
												${data.jctype }-${data.jcnum }
											</c:otherwise>
										</c:choose>
									</td>
									<td style="text-align: center;">
										<c:if test="${fn:contains(data.plan, 'sj')}">
											${data.kcsj }
										</c:if>
									</td>
									<td style="text-align: center;">
										<c:if test="${fn:contains(data.plan, 'sj')}">
											${data.jhqjsj }
										</c:if>
									</td>
									<td style="text-align: center;">
										<c:if test="${fn:contains(data.plan, 'sj')}">
											${data.sjqjsj }
										</c:if>
									</td>
									<td style="text-align: center;">
										<c:if test="${fn:contains(data.plan, 'sj')}">
											${data.sjjcsj }
										</c:if>
									</td>
									<td style="text-align: center;">${data.comments }</td>
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
