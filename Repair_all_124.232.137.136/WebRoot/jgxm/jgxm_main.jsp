<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>加装改造首页</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/bsFormat.js"></script>
	
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->

	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	
	<!--修正IE6支持透明PNG图start-->
	<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
	<!--修正IE6支持透明PNG图end-->
  </head>
  
  <body>
    <div id="mainFrame">
		<table width="100%" cellpadding="0" cellspacing="0" class="table_border0">
			<tr>
				<!--左侧区域start-->
				<td id="hideCon" class="ver01 ali01">
					<div id="lbox">
						<div id="lbox_topcenter">
						<div id="lbox_topleft">
						<div id="lbox_topright">
							<div class="lbox_title">操作菜单</div>
						</div>
						</div>
						</div>
						<div id="lbox_middlecenter">
						<div id="lbox_middleleft">
						<div id="lbox_middleright">
						      <div id="bs_left">
						         <iframe scrolling="no" width="100%"  frameBorder=0 id=frmleft name=frmleft src="jgxm/jgxm_left.jsp"  allowTransparency="true"></iframe>
						      </div>
						</div>
						</div>
						</div>
						<div id="lbox_bottomcenter">
						<div id="lbox_bottomleft">
						<div id="lbox_bottomright">
							<div class="lbox_foot"></div>
						</div>
						</div>
						</div>
					</div>
				</td>
				<!--左侧区域end-->
				
				<!--中间栏区域start-->
				<td class="main_shutiao">&nbsp;
					<div class="bs_leftArr" id="bs_center" title="收缩面板"></div>
				</td>
				<!--中间栏区域end-->
				
				<!--右侧区域start-->
				<td class="ali01 ver01"  width="100%">
					<div id="rbox">
						<div id="rbox_topcenter">
						<div id="rbox_topleft">
						<div id="rbox_topright">
							<div class="rbox_title">
								操作内容
							</div>
						</div>
						</div>
						</div>
						<div id="rbox_middlecenter">
						<div id="rbox_middleleft">
						<div id="rbox_middleright">
							<div id="bs_right">
							    <iframe scrolling="auto" overflow="auto" width="100%" frameBorder="0" id="frmright" name="frmright" src="jgxm/statistical.jsp"  allowTransparency="true"></iframe>
							</div>
						</div>
						</div>
						</div>
						<div id="rbox_bottomcenter" >
						<div id="rbox_bottomleft">
						<div id="rbox_bottomright">
						</div>
						</div>
						</div>
					</div>
				</td>
				<!--右侧区域end-->
			</tr>
		</table>
	</div>
  </body>
</html>
