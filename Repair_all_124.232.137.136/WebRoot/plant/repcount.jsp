<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<script type="text/javascript">
	function sub(){
		$("#subForm").submit();
	}
</script>
<body>
	<form action="timecount!repCount.do" method="post" id="subForm">
	<div class="box2" panelTitle="报活统计" roller="false">
		<table>
			<tr>
				<td>报活类型：</td>
				<td>
				<select name="type">
				<option value="">请选择报活类型</option>
				<option value="0" <c:if test="${type==0 }">selected="selected"</c:if>>JT28报活</option>
				<option value="1" <c:if test="${type==1 }">selected="selected"</c:if>>复检报活</option>
				<option value="2" <c:if test="${type==2 }">selected="selected"</c:if>>过程报活</option>
				<option value="6" <c:if test="${type==6 }">selected="selected"</c:if>>零公里报活</option>
				</select>
				</td>
				<!-- 
				<td align="right">角色： </td>
				<td>
					<select id="roleid" name="roleid" class="default">
					     <option value="">请选择角色</option>
					     <c:forEach items="${rolePrivsList}" var="entry">
					        <c:if test="${!fn:containsIgnoreCase(entry.py,'XTGL')}">
    	                      <option value="${entry.roleid}" <c:if test="${entry.roleid==roleid }">selected="selected"</c:if>>${entry.rolename}</option>
    	                    </c:if>
    	                 </c:forEach>
					</select>
				</td>
				 -->
				<td align="right">班组： </td>
				<td>
					<select id="bzId"  name="bzId" colNum="2">
					     <option value="">请选择班组</option>
					     <c:forEach items="${dictProTeamList}" var="entry">
    	                     <option value="${entry.proteamid}" <c:if test="${entry.proteamid==bzId }">selected="selected"</c:if>>${entry.proteamname}</option>
    	                 </c:forEach>
					</select>
				</td>
				<td>检修人：</td>
				<td><input type="text" id="dealFixEmp" name="dealFixEmp" value="${dealFixEmp }" /></td>
			</tr>
			<tr>
				<td>开始时间：</td>
				<td><input type="text" id="startDate" value="${startDate }" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="startDate"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" id="endDate" value="${endDate }" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="endDate"/></td>
				<td>机车编号：</td>
				<td><input type="text" id="jcnum" name="jcNum" value="${jcNum }" /></td>
				<td></td>
				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
			</tr>
		</table>
	</div>
		<table class="tableStyle"  useMultColor="true" >
			<tr>
				<%--
		      <th width="30px" align="center"></th>
		       --%>
		      <th width="30%" align="center"><span>检修人姓名</span></th>
		      <th width="30%" align="center"><span>检修修活统计</span></th>
		      <th width="40%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty jtpredict}">
			   	<c:forEach items="${jtpredict.datas}" var="jtpredict" >
			   		<tr>
			   			<%--
			   			<td width="25" align="center"><input id="" name="" type="checkbox" value=""/></td>
			   			 --%>
						<td width="30%" align="center"><span>${fn:substring(jtpredict[0],1,fn:length(jtpredict[0])-1)}</span></td>
						<td width="30%" align="center"><span>${jtpredict[1]} &nbsp;&nbsp;&nbsp;件</span></td>
						<td width="40%" align="center">
							<a onclick="view('${jtpredict[0]}');" style="color:blue;">查看记录</a>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty jtpredict.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="3">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>							
		</table>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${jtpredict.count}条,每页显示10条记录</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="timecount!repCount.do" items="${jtpredict.count }" export="page1=pageNumber">
				<pg:param name="startDate" value="${startDate}" /> 
				<pg:param name="endDate" value="${endDate}" /> 
				<pg:param name="jcNum" value="${jcNum}" />
				 <pg:param name="dealFixEmp" value="${urlEmp}" />
				 <pg:param name="type" value="${type}" />
				 <pg:param name="roleid" value="${roleid}" />
				 <pg:param name="bzId" value="${bzId}" />
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
<script type="text/javascript">
		//查看记录
		function view(dealFixEmp){
			var diag = new top.Dialog();
			diag.Title = "记录查询窗口";
			diag.URL = "timecount!repItem.do?dealFixEmp="+dealFixEmp;
			diag.Width=1200;
			diag.Height=520;
			diag.show();
		}
</script>
</html>