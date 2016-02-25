<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>"/>
    
    <title>创建日计划的选择配件页面</title>
    <!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript">
		function selectJCType(){
			var jcTypeVal = $("#jc_type_value").val();
			if(jcTypeVal=='0'){
				top.Dialog.alert("请选择机车类型");
				$("#first_unit_sel").empty();
				$("#first_unit_sel").append("<option value='0'>选择专业</option>");
			}else{
				$.post("partFixAction!findFirstUintByJcType.do",{jcType:jcTypeVal},function(data){
					var op;
					$("#first_unit_sel").empty();
					$.each(data,function(index,first){
						op = '<option value="'+first.id+'">'+first.name+'</option><br/>';
						$("#first_unit_sel").append(op);
					});
				},'json');
			}
		}
		
		function checkForm(){
			var jcVal = $("#jc_type_value").val();
			var firstVal = $("#first_unit_sel").val();
			if(jcVal=='0'){
				top.Dialog.alert("请选择机车类型");
				return false;
			}
			if(firstVal=='0'){
				top.Dialog.alert("请选择专业");
				return false;
			}
			return true;
		}

		$(function(){
			var firstUnitId = '${firstUnitId}';
			if(firstUnitId.length>0){
				var jcTypeVal = '${jcTypeVal}';
				$.post("partFixAction!findFirstUintByJcType.do",{jcType:jcTypeVal},function(data){
					var op;
					$("#first_unit_sel").empty();
					$.each(data,function(index,first){
						if(firstUnitId != first.id){
							op = '<option value="'+first.id+'">'+first.name+'</option><br/>';
						}else{
							op = '<option value="'+first.id+'" selected="selected">'+first.name+'</option><br/>';
						}
						$("#first_unit_sel").append(op);
					});
				},'json');
			}
		})
	</script>

  </head>
  
 <body>

<div class="box_tool_mid padding_right5">
	<div class="center">
	<div class="left">
	<div class="right">
		<div class="padding_top8 padding_left10">
		<form action="partFixAction!toChoicePJS.do" method="post" onsubmit="return checkForm();">
			<table>
				<tr>
					<td>机车类型：</td>
					<td>
						
						<select id="jc_type_value" name="jcTypeVal" onchange="selectJCType()">
							<option value="0">选择机车类型</option>
							<c:forEach items="${jcTypeValues}" var="jcType">
								<c:choose>
									<c:when test="${jcType !=jcTypeVal}">
										<option value="${jcType }">${jcType }</option>
									</c:when>
									<c:otherwise><option value="${jcType }" selected="selected">${jcType }</option></c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td>专业：</td>
					<td id="zytd">
						<select id="first_unit_sel" name="firstUnitId" class="default">
							<option value="0">选择专业</option>
						</select>
					</td>
					<td>关键词：</td>
					<td><input type="text" name="keyword" value="${keyword}" /></td>
					<td>
						<button onclick="javascript:document.forms[0].submit();"><span class="icon_find">查询</span></button>
						<input type="hidden" name="flag" value="${flag}"/>
					</td>
				</tr>
			</table>
		</form>
		
		</div>			
	</div>		
	</div>	
	</div>
</div>

<div>
	<table class="tableStyle"  headFixMode="true" useMultColor="true">
		<tr>
			<th width="25">选择</th>
			<th width="100"><span>配件名</span></th>
			<th width="100"><span>父级配件</span></th>
			<th><span>最小库存量</span></th>
			<th width="100"><span>最大库存量</span></th>
			<th width="200"><span>适用车型</span></th>
		</tr>
	</table>
</div>
<div id="scrollContent" style="height: 280px;">
	<table class="tableStyle"  useMultColor="true">
		<c:if test="${!empty pageModel}">
			<c:forEach items="${pageModel.datas}" var="pjs">
				<tr align="center">
					<td width="25">
						<input type="radio" id="${pjs.pjName}" name="pjRadio" value="${pjs.pjsid}" />
					</td>
					<td width="100">${pjs.pjName}</td>
					<td width="100">
						<c:if test="${!empty pjs.parent}">${pjs.parent.pjName}</c:if>
					</td>
					<td>
						<span class="float_left">${pjs.lowestStore}</span>
					</td>
					<td width="100">${pjs.mostStore}</td>
					<td width="200">
						${pjs.jcType}
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
		
	</table>
	
	<div style="height:35px;">
		<div class="float_left padding5">
			<c:if test="${empty pageModel}">
				共有信息0条,一页可显示${pageSize}条记录。
			</c:if>
			<c:if test="${!empty pageModel}">
				共有信息${pageModel.count }条,每页显示${pageSize}条记录。 
			</c:if>
		</div>
		<div class="float_right padding5 paging">
			<pg:pager items="${pageModel.count}" url="partFixAction!toChoicePJS.do" maxPageItems="10" export="currentPageNumber=pageNumber">
				<pg:param name="jcTypeVal" value="${jcTypeVal}"/>
				<pg:param name="firstUnitId" value="${firstUnitId}"/>
				<pg:param name="key" value="${key}"/>
				<pg:param name="flag" value="${flag}"/>
				<pg:prev><span><a href="${pageUrl }">上一页</a></span></pg:prev>
				<pg:pages>
					<c:choose>
						<c:when test="${currentPageNumber==pageNumber}">
							<span class="paging_current"><a href="javascript:;">${currentPageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
				</pg:pages>
				<pg:next><span><a href="${pageUrl }">下一页</a></span></pg:next>
			</pg:pager>
		</div>
		<div class="clear"></div>
	</div>

</div>



  </body>
</html>
