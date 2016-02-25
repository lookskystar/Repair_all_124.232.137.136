<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/bsFormat.js"></script>
<!--框架必需end-->

<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
<title>无标题文档</title>
<style>
	body,html{
		padding:0px;
		margin:0px;
		width:100%;
		height:100%;
		overflow: hidden;
	}
	#lists{
		float:left;
		width:100%;
		height:100%;
		overflow: auto;
	}

	#listitems{
		border:1px solid green;
		width:100%;
		height:100%;
		border-collapse: collapse;
		margin-left:5px;
		overflow: auto;
	}
	#listitems th{
		text-align:center;
		height:40px;
		line-height:40px;
		font-weight:bold;
		overflow: auto;
	}
	#listitems td,#listitems th{
		border:1px solid green;
		font:12px arial,宋体,sans-serif;
		overflow: auto;
	}
	#listitems td{
		padding-left:1px;
		padding-top:2px;
		padding-bottom:2px;
		overflow: auto;
	}
</style>
<link href="<%=basePath %>report/css/global.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/lhgdialog/skins/blue.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/lhgdialog/lhgdialog.js"></script>
</head>

<body>
	    	<table id="listitems" width="100%">
	        	<tr>
	            	<th width="5%">序号</th>
	                <th width="20%">机车号</th>
	                <th width="10%">股道</th>
	                <th width="15%">
	                	<a href="javascript:void(0);" onclick="kc();" style="font-weight: bolder;text-align: center;">扣车时间</a>
	                </th>
	            <!--
	            	<th>计划起机时间<br>实际起机时间</th>
		            <th>计划交车时间<br>实际交车时间</th>
		         -->
		         	<th width="13%">交车工长</th> 
		            <th width="7%">状态</th>
	            	<th width="30%">操作<a href="<%=basePath %>report!findAllJC.do?type=jcgz&flag=gdt" target="jcgz_gdt">股道图</a></th>
         	   </tr>	
	            <c:forEach items="${allJC }" var="plan" varStatus="index">
		            <tr>
		            	<td align="center">${index.index+1 }</td>
		                <td align="center"><a style="position:static;" href="<%=basePath%>query!getInfoByJC.do?jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque}" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque }</a></td>
		                <td align="center"><a style="position:static;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
		                <td align="center">${fn:substring(plan.kcsj,5,16) }</td>
		                <%--
		                <td align="center">${fn:substring(plan.jhqjsj,5,16) }<br>${fn:substring(plan.sjqjsj,5,16) }</td>
		                <td align="center">${fn:substring(plan.jhjcsj,5,16) }<br>${fn:substring(plan.sjjcsj,5,16) }</td>
		                 --%>
		                <td align="center">${plan.gongZhang.xm }</td>
		                <td align="center">
			                <c:if test="${plan.planStatue == -1}">
			                	新建
			                </c:if>
			                <c:if test="${plan.planStatue == 0}">
			                	在修
			                </c:if>
			                <c:if test="${plan.planStatue == 1}">
			                	待验
			                </c:if>
			                <c:if test="${plan.planStatue == 2}">
			                	已交
			                </c:if>
			                 <c:if test="${plan.planStatue == 3}">
			                	转出
			                </c:if>
		                </td>
			            <td align="center" style="padding-left: 3px;padding-right: 5px;">
			            	<a href="<%=basePath %>oilAssay!searchOilAssayRecorderDaily.do?rjhmId=${plan.rjhmId }" target="jcgz_gdt">油水试验</a>
			            	<c:if test="${plan.planStatue == -1}">
			                	<a href="javascript:void(0);" onclick="modifydailyplan('${plan.rjhmId }');">修改计划</a><br/>
			                	<a href="javascript:void(0);" onclick="deletedailyplan('${plan.rjhmId }');">删除</a>
			                	<c:if test="${plan.fixFreque=='LX' || plan.fixFreque=='JG'}">
				                	<a href="<%=basePath%>planManage!jcgzDailyPlanMake.action?id=${plan.rjhmId }" target="jcgz_gdt">检修内容</a><br/>
				                	<!-- <a href="">班组派工</a> -->
			                	</c:if>
			                	<a href="javascript:void(0);" onclick="jc('${plan.rjhmId }','${plan.fixFreque}');">接车</a>
			                </c:if>
			                <c:if test="${plan.planStatue == 0 and plan.nodeid.jcFlowId==106}">
			                	<a href="<%=basePath%>work/role/role_ratify.jsp?rjhmId=${plan.rjhmId}&jcstype=${plan.fixFreque}&rtype=4&role=comm" target="jcgz_gdt">卡控签字</a><br/>
			                	<a href="javascript:void(0);">超修派工</a>
			                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt">竣工交车</a>
			                </c:if>
			                <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==107}">
			                	<a href="<%=basePath%>checkSign!checkSignInput.do?nodeId=107&rjhmId=${plan.rjhmId}" target="jcgz_gdt">交车试验</a><br/>
			                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt">竣工交车</a>
			                </c:if>
			                <c:if test="${plan.planStatue == 1}">
			                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt">竣工交车</a>
			                </

>
			                <c:if test="${plan.planStatue == 2}">
			                	<a href="<%=basePath%>zeroCheck!zeroSignMsg.do?dpId=${plan.rjhmId}" target="jcgz_gdt">零公里</a><br/>
			                	<a href="<%=basePath%>zeroCheck!jcRollOutInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt">机车转出</a>
			                </c:if>
			            </td>
		            </tr>
	           </c:forEach>
           		 <c:if test="${fn:length(allJC )<16 }">
		            <c:forEach begin="0" end="${16-fn:length(allJC )}">
		            	<tr>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            		<td>&nbsp;</td>
		            	</tr>
		            </c:forEach>
            	</c:if>
      	  </table>

<!--引入组件start-->
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
</body>
</html>
