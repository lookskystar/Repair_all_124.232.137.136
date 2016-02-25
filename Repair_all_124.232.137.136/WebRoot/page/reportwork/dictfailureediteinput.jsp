<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
</head>
<body>
	<form action="reportWorkManage!dictFailureEdite.action" method="post" target="frmright">
		<table class="tableStyle" transMode="true">
			<tr>
				<td>专业：</td>
				<td><input type="text" name="dictFailure.firstUnitName" value="${dictFailure.firstUnitName }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<select id="yjbj" name="firstUnitName" onchange="getSecUnit()" class="default">
						 <option value="">请选择专业</option>
					    <c:if test="${!empty dictFirstUnitList}">
					    	<c:forEach items="${dictFirstUnitList}" var="entry">
					    		<option value="${entry}">${entry}</option>
					    	</c:forEach>
					    </c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>部位：</td>
				<td><input type="text" name="dictFailure.secUnitName" value="${dictFailure.secUnitName }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<select id="ejbj" name="secUnitName" onchange="getThirdUnit()" class="default">
						<option value="">请选择部位</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>处所：</td>
				<td><input type="text" name="dictFailure.thirdUnitName" value="${dictFailure.thirdUnitName }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<select id="sjbj" name="thirdUnitName" class="default">
						<option value="">请选择处所</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>故障内容：</td>
				<td>
					<input type="hidden" name="dictFailure.content" value="${dictFailure.content }"/>
					<span class="float_left">
						<textarea name="content">${dictFailure.content }</textarea>
					</span>
					<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
				</td>
			</tr>
			<tr>
				<td>故障分值：</td>
				<td><input type="text" name="score" value="${dictFailure.score }" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value=" 提 交 "/>
					<input type="reset" value=" 重 置 "/>
				</td>
			</tr>
		</table>
		<input type="hidden" name="dictId" value="${dictFailure.id }"/>
		<input type="hidden" name="num" value="${num }"/>
	</form>
</body> 
<script type="text/javascript">
//根据一级部件获取二级部件
function getSecUnit() {
	var firstunitid=$("#yjbj").val();
	var ejbj ;
	if(firstunitid!=''){
		$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":firstunitid,"type":0},function(data){
			var map=eval("("+data+")");
			var result=map['unit'];
			var ejbj = "<option value=''>请选择部位</option>";
			for(var i=0;i<result.length;i++){
				if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
					ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
				}
		    }
			$('#ejbj').html(ejbj);
		});
	}
}

//根据二级部件获取三级部件
function getThirdUnit(){
	var first=$("#yjbj").val();
	var second=$("#ejbj").val();
	if(first!='' && second!=''){
		$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":first,"second":second,"type":1},function(data){
			var map=eval("("+data+")");
			var result=map['unit'];
			var ejbj = "<option value=''>请选择处所</option>";
			for(var i=0;i<result.length;i++){
				if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
					ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
				}
		    }
			$('#sjbj').html(ejbj);
		});
	}
}


</script>
</html>
