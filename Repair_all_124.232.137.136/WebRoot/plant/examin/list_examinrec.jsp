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
    <title>考试记录查询</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script type="text/javascript" src="js/jquery.imgPreview.js"></script>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="examin!listExaminRec.do" method="post" id="subfrom">
 	<div>
 		<table>
 			<tr>
 				<td>
					开始时间：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart" value="${dateStart }"/>
				</td>
				<td>
					结束时间：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd" value="${dateEnd }"/>
				</td>
			</tr>
			<tr>
				<td>
					考&nbsp;&nbsp;试&nbsp;&nbsp;人：<input type="text" watermark="输入考试人姓名" style="line-height: 22px;vertical-align: top" name="eaxminer" value="${eaxminer }"/>
				</td>
				<td>
					<button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button>
				</td>
 			</tr>
 		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" id="questionTable">
		 	<tr>
		 		<th width="25%" align="center"><span>考试专业</span></th>
		 		<%--
		      	<th width="20%" align="center"><span>考试类型</span></th>
		      	 --%>
		      	<th width="25%" align="center"><span>考试人</span></th>
		      	<th width="25%" align="center"><span>正确率</span></th> 
		      	<th width="25%" align="center"><span>考试时间</span></th>
		    </tr>
			<c:if test="${!empty examinRecPm}">
			   	<c:forEach items="${examinRecPm.datas}" var="rec" >
			   		<tr>
						<td width="25%" align="center">
							<span>
								${rec.type.proteamname}
							</span>
						</td>
						<td width="25%" align="center">
							<span >
								${rec.examiner.xm}
							</span>
						</td>
						<td width="25%" align="center"><span>${rec.currectPoints}</span></td>
						<td width="25%" align="center"><span>${rec.examinDate}</span></td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty examinRecPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${examinRecPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="examin!listExaminRec.do" items="${examinRecPm.count }" export="page1=pageNumber">
				<pg:param name="major" value="${major}"/>
				<pg:param name="examinType" value="${examinType}"/>
				<pg:param name="dateStart" value="${dateStart}"/>
				<pg:param name="dateEnd" value="${dateEnd}"/>
				<pg:param name="eaxminer" value="${eaxminer}"/>
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
		//表单提交
		function sub(){
			$("#subform").submit();
		}
</script>
</html>