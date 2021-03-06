<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
</head>
<body> 
	<form action="teach!zoreRecord.do" method="post" id="subForm">
	<input type="hidden" name="rjhmId" value="${rjhmId }"/>
	<div class="box1" roller="false">
		<table>
			<tr>
				<td>开始时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd"/></td>
				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
			</tr>
		</table>
	</div>
	<div id="scrollContent">
		<table class="tableStyle"  useMultColor="true">
			<tr>
				<th scope="col">报活类型</th>
		      	<th scope="col">报活部位</th>
		      	<th scope="col">报活情况</th>
		      	<th scope="col">报活人</th>
		      	<th scope="col">报活时间</th>
		      	<th scope="col">接收人</th>
		      	<th scope="col">检修人</th>
		      	<th scope="col">工长</th>
		      	<th scope="col">交车工长</th>
		      	<th scope="col">质检员</th>
		      	<th scope="col">技术员</th>
		      	<th scope="col">验收员</th>
		    </tr>
		    <c:if test="${!empty JtPreDictPm}">
			   	<c:forEach items="${JtPreDictPm.datas}" var="rec" >
			   		 <tr>
			   		 	<td class="row">
			   		 		<c:if test="${rec.type == 0}">
			   		 			JT28报活
			   		 		</c:if>
			   		 		<c:if test="${rec.type == 1}">
			   		 			复检报活
			   		 		</c:if>
			   		 		<c:if test="${rec.type == 2}">
			   		 			过程报活
			   		 		</c:if>
			   		 		<c:if test="${rec.type == 6}">
			   		 			零公里报活
			   		 		</c:if>
			   		 	</td>
			      		<td class="row">${rec.repPosi }&nbsp;</td>
			      		<td class="row">${rec.repsituation }&nbsp;</td>
			      		<td class="row">${rec.repemp }&nbsp;</td>
			      		<td class="row">${rec.repTime }&nbsp;</td>
			      		<td class="row">${rec.receiptPeo }&nbsp;</td>
			      		<td class="row">${rec.fixEmp }&nbsp;</td>
			      		<td class="row">${rec.lead }<br></br><c:if test="${!empty rec.ldAffirmTime}">${fn:substring(rec.ldAffirmTime, 5, 16) }</c:if></td>
				  		<td class="row">${rec.commitLd }<br></br><c:if test="${!empty rec.comLdAffiTime}">${fn:substring(rec.comLdAffiTime, 5, 16) }</c:if></td>
				  		<td class="row">${rec.qi }<br></br><c:if test="${!empty rec.qiAffiTime}">${fn:substring(rec.qiAffiTime, 5, 16) }</c:if></td>
				  		<td class="row">${rec.technician }<br></br><c:if test="${!empty rec.techAffiTime}">${fn:substring(rec.techAffiTime, 5, 16) }</c:if></td>
				  		<td class="row">${rec.accepter }<br></br><c:if test="${!empty rec.acceTime}">${fn:substring(rec.acceTime, 5, 16) }</c:if></td>
			    	</tr>
			   	</c:forEach>
			 </c:if>
		    <c:if test="${empty JtPreDictPm.datas}">
			 	<tr> 
			 		<td class="row" colspan="13" align="center">没有相应的数据记录!</td>
			 	</tr>
			</c:if>			
		</table> 
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${JtPreDictPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="teach!zoreRecord.do" items="${JtPreDictPm.count }" export="page1=pageNumber">
				<pg:param name="dateStart" value="${dateStart}" /> 
				<pg:param name="dateEnd" value="${dateEnd}" /> 
				<pg:param name="rjhmId" value="${rjhmId}" /> 
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
	function sub(){
		$("#subForm").submit();
	}
</script>
</html>