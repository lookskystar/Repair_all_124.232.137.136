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
    <title>机车管理</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="teach!maintenIndexCount.do" method="post">
 	<div>
		<input type="text" watermark="输入机车编号" style="line-height: 22px;vertical-align: top" name="jcNum"/>&nbsp;
		<button><span class="icon_find">查询</span></button>
	</div>
   	<div id="scrollContent" >
		 <table class="tableStyle"  useMultColor="true"  id="jcTable">
		 	<tr>
		      	<th width="15%" align="center"><span>机车类型</span></th>
		      	<th width="20%" align="center"><span>机车编号</span></th> 
		      	<th width="20%" align="center"><span>当日走行公里</span></th>
		      	<th width="20%" align="center"><span>总走行公里</span></th>
		      	<th width="20%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty jtRunKiloRecPm}">
			   	<c:forEach items="${jtRunKiloRecPm.datas}" var="jtRunKiloRec" >
			   		<tr>
						<td width="15%" align="center"><span>${jtRunKiloRec.jcType}</span></td>
						<td width="20%" align="center"><span>${jtRunKiloRec.jcNum}</span></td>
						<td width="20%" align="center"><span>${jtRunKiloRec.dayRunKilo}</span></td>
						<td width="20%" align="center"><span>${jtRunKiloRec.totalRunKilo}</span></td>
						<td width="20%" align="center">
							<a onclick="fixView('${jtRunKiloRec.jcType }', '${jtRunKiloRec.jcNum }');">检修信息</a>
							<a onclick="preView('${jtRunKiloRec.jcType }', '${jtRunKiloRec.jcNum }');">报活信息</a>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty jtRunKiloRecPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${jtRunKiloRecPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="teach!maintenIndexCount.do" items="${jtRunKiloRecPm.count }" export="page1=pageNumber">
				<pg:param name="jcType" value="${jcType}"/>
				<pg:param name="jcNum" value="${jcNum}"/>
		  		<pg:first>
					 <span><a href="${pageUrl }" id="first">首页</a></span>
		 		</pg:first>
		 		<pg:prev>
					  <span><a href="${pageUrl }">上一页</a></span>
		  		</pg:prev>
	  	  		<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber }">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
		  		</pg:pages>
		  		<pg:next>
				    <span><a href="${pageUrl }">下一页</a></span>
		  		</pg:next>
		  		<pg:last>
				  	<span><a href="${pageUrl }">末页</a></span>
		 		</pg:last>
		 	</pg:pager>
		</div>
		<div class="clear"></div>
	</div>
	</form>
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
		function fixView(jctype, jcnum){
			var diag = new top.Dialog();
			diag.Title = "记录查询窗口";
			diag.URL = "teach!fixInfoRecord.do?jcType="+jctype+"&jcnum="+jcnum+"";
			diag.Width=1200;
			diag.Height=520;
			diag.show();
		}
		function preView(jctype, jcnum){
			var diag = new top.Dialog();
			diag.Title = "记录查询窗口";
			diag.URL = "teach!preInfoRecord.do?jcType="+jctype+"&jcnum="+jcnum+"";
			diag.Width=1200;
			diag.Height=520;
			diag.show();
		}
</script>
</html>