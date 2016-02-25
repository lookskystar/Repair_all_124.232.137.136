<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
</head>
<body>
	<form action="teach!fixInfoRecord.do" method="post" id="subForm">
	<input type="text" name="jcType" value="${jcType }"/>
	<input type="text" name="jcnum" value="${jcnum }"/>
	<div class="box1" roller="false">
		<table>
			<tr>
				<td>开始时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd" dateFmt="yyyy-MM-dd HH:mm:ss" name="dateEnd"/></td>
				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
			</tr>
		</table>
	</div>
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true">
			<tr>
		      <th width="10%" align="center"><span>机车型号</span></th>
		      <th width="10%" align="center"><span>机车编号</span></th>
		      <th width="10%" align="center"><span>修成修次</span></th>
		      <th width="15%" align="center"><span>扣车时间</span></th>
		      <th width="15%" align="center"><span>起机时间</span></th>
		      <th width="15%" align="center"><span>交车时间</span></th>
		      <th width="15%" align="center"><span>交车工长</span></th>
		      <th width="20%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty DatePlanPriPm}">
			   	<c:forEach items="${DatePlanPriPm.datas}" var="datePlanPri" >
			   		<tr>
						<td width="10%" align="center"><span>${datePlanPri.jcType}</span></td>
						<td width="10%" align="center"><span>${datePlanPri.jcnum}</span></td>
						<td width="10%" align="center"><span>${datePlanPri.fixFreque}</span></td>
						<td width="15%" align="center"><span>${datePlanPri.kcsj}</span></td>
						<td width="15%" align="center"><span>${datePlanPri.jhqjsj}</span></td>
						<td width="15%" align="center"><span>${datePlanPri.sjjcsj}</span></td>
						<td width="15%" align="center"><span>${datePlanPri.gongZhang.xm}</span></td>
						<td width="20%" align="center">
							<a href="query!getInfoByJC.do?rjhmId=${datePlanPri.rjhmId }&xcxc=${datePlanPri.fixFreque }" target="_blank">查看记录</a>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty DatePlanPriPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>							
		</table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${DatePlanPriPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="teach!fixInfoRecord.do" items="${DatePlanPriPm.count }" export="page1=pageNumber">
				<pg:param name="jcType" value="${jcType}" /> 
				<pg:param name="jcnum" value="${jcnum}" /> 
				<pg:param name="dateStart" value="${dateStart}" /> 
				<pg:param name="dateEnd" value="${dateEnd}" /> 
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
	function fixView(rjhmId, fixFreque){
		var diag = new top.Dialog();
		diag.Title = "记录查询窗口";
		diag.URL = "query!getInfoByJC.do?rjhmId="+rjhmId+"&xcxc="+fixFreque+"";
		diag.Width=1200;
		diag.Height=520;
		diag.show();
	}
	function sub(){
		$("#subForm").submit();
	}
</script>
</html>