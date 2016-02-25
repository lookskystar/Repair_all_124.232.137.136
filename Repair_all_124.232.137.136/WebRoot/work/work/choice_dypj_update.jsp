<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
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
<!-- 引入分页JS -->
<script type="text/javascript" src="admin/js/page.js"></script>

<!-- 20150601 配件验证编号是否为空  宁佐锌-->
<script>
function checkform(){
		if($("#pjNum").val()==''){
			top.Dialog.alert("请输入配件编号！");
			return false;
		}
	}
</script>
</head>
<body>
<form id="form" action="workAction!choiceDyPjInfo.do?stdpjid=${stdpjid }&planId=${planId }" method="post" onsubmit="return checkform()">
	<input type="hidden" name="type" value="${type}"/>
	<div id="showImage">
  配件编号:<input type="text"  id="pjNum" style="width: 200px" name="pjNum" value="${pjNum }"/>&nbsp;&nbsp;&nbsp;
  <!-- 2015-5-21，黄亮，改， 去掉只读属性readonly="readonly"-->
        配件名称:<input type="text" style="width: 200px" name="pjName" value="${pjName }" />&nbsp;&nbsp;&nbsp;
        <input type="submit" value="查询"/>
	   <table width="100%" class="tableStyle" >
			<tr>
			    <th class="ver01" width="5%" align="center"></th>
				<th class="ver01" width="15%" align="center">配件名称</th>
				<th class="ver01" width="15%" align="center">所属静态配件</th>
				<th class="ver01" width="10%" align="center">配件编号</th>
				<th class="ver01" width="5%" align="center">存储位置</th>
			    <th class="ver01" width="5%" align="center">配件状态</th>
			    <th class="ver01" width="8%" align="center">备注</th>
			    <th class="ver01" width="5%" align="center">操作</th>
			</tr>
			<c:if test="${!empty pm.datas}">
				<c:forEach items="${pm.datas}" var="pjd">
				   <tr>
				   <td class="ver01" align="center"><input type="radio" id="${pjd.pjdid}" name="pjIds" value="${pjd.pjNum}"/></td>
				    <td class="ver01" align="center">${pjd.pjName}</td>
					<td class="ver01" align="center"></td>
					<td class="ver01" align="center">${pjd.pjNum}</td>
					<td class="ver01" align="center">
					  <c:if test="${pjd.storePosition==0}">中心库</c:if>
					  <c:if test="${pjd.storePosition==1}">班组</c:if>
					  <c:if test="${pjd.storePosition==2}">车上</c:if>
					  <c:if test="${pjd.storePosition==3}">外地</c:if>
					</td>
					<td class="ver01" align="center">
					  <c:if test="${pjd.pjStatus==0}">合格</c:if>
					  <c:if test="${pjd.pjStatus==1}">待修</c:if>
					  <c:if test="${pjd.pjStatus==2}">报废</c:if>
					  <c:if test="${pjd.pjStatus==3}">检修中</c:if>
					</td>
					<td class="ver01" align="center">${pjd.comments}</td>
					<td class="ver01" align="center"><a href="workAction!findPJRecorder.do?pjId=${pjd.pjdid}" style="color:blue;" target="_blank">检修记录</a></td>
				  </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 <tr> <td class="ver01" align="center" colspan="7">没有相应的数据记录!</td></tr>
			 </c:if>
	</table>
 </div></form>
 
	<!-- 处理分页 -->
	<div style="height:35px;">
	总共${pm.count}条记录,每页显示10条记录--
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
		<pg:pager maxPageItems="${pageSize }" url="workAction!choiceDyPjInfo.do" items="${pm.count}" export="page1=pageNumber">
		  <pg:param name="pjName" value="${urlName}"/>
		  <pg:param name="pjNum" value="${pjNum}"/>
		  <pg:param name="stdpjid" value="${stdpjid}"/>
		  <pg:param name="planId" value="${planId}"/>
		  <pg:param name="type" value="${type}"/>
		  <pg:first>
			 <span><a href="${pageUrl  }" id="first">首页</a></span>
		  </pg:first>
		  <pg:prev>
			  <span><a href="${pageUrl  }">上一页</a></span>
		  </pg:prev>
	  	  <pg:pages>
				<c:choose>
					<c:when test="${page1==pageNumber}">
						<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
					</c:when>
					<c:otherwise>
						<span><a href="${pageUrl  }">${pageNumber }</a></span>
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
		 <!-- 
		&nbsp;每页
		</div>
		<div class="float_left"><select autoWidth="true"><option>15</option><option>20</option><option>25</option></select></div>
		<div class="float_left padding_top4">条记录</div> -->
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
   <!-- 处理分页end -->
</body>
</html>

