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
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
</head>
<body>
	<form action="teach!editTrainFault.do" method="post" target="userIframe">
	<input type="hidden" name="trainFault.id" value="${trainFault.id }" />
	<input type="hidden" name="trainFault.jctype" value="${trainFault.jctype }" />
	<input type="hidden" name="trainFault.jcnum" value="${trainFault.jcnum }" />
	<input type="hidden" name="trainFault.locomotive" value="${trainFault.locomotive }" />
	<div class="box1">
	<fieldset> 
		<legend>基本考勤信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="20%">考勤人：</td>
				<td width="40%"><input type="text" name="attendance.users.xm" value="${attendance.users.xm}" disabled="disabled"/></td>
				<td width="20%"></td>
				<td width="20%"></td>
			</tr>
			<tr>
				<td width="10%">备注：</td>
				<td>
					<span class="float_left">
						<textarea  name="attendance.comments">${attendance.comments } </textarea>
					</span>
				</td>
			</tr>	
		</table>
	</fieldset> 
	<fieldset> 
		<legend>第一次考勤信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="20%">考勤时间：</td>
				<td width="40%"><input type="text" name="attendance.firstCheckTime" value="${attendance.firstCheckTime}" disabled="disabled"/></td>
				<td width="20%">考勤确认：</td>
				<td width="20%">
					<c:choose>
						<c:when test="${attendance.firstConfirm == 0}">
							<input type="button" value="确认" onclick="confirms('1','${attendance.id}')" />
						</c:when>
						<c:otherwise>
							<span>已确认</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td width="10%">考勤图片：</td>
				<td>
					<c:choose>
						<c:when test="${!empty attendance.firstImgUrl.imgUrl }">
							<img src="${attendance.firstImgUrl.imgUrl}" style="border:1px solid #f0f0f0;width:170px;height:170px;"/> 
						</c:when>
						<c:otherwise>
							<span>未考勤</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</fieldset> 
	<fieldset> 
		<legend>第二次考勤信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="20%">考勤时间：</td>
				<td width="40%"><input type="text" name="attendance.secondCheckTime" value="${attendance.secondCheckTime}" disabled="disabled"/></td>
				<td width="20%">考勤确认：</td>
				<td width="20%">
					<c:choose>
						<c:when test="${attendance.secondConfirm == 0}">
							<input type="button" value="确认" onclick="confirms('2','${attendance.id}')" />
						</c:when>
						<c:otherwise>
							<span>已确认</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td width="10%">考勤图片：</td>
				<td>
					<c:choose>
						<c:when test="${!empty attendance.secondImgUrl.imgUrl }">
							<img src="${attendance.secondImgUrl.imgUrl}" style="border:1px solid #f0f0f0;width:170px;height:170px;"/> 
						</c:when>
						<c:otherwise>
							<span>未考勤</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</fieldset> 
	<fieldset> 
		<legend>第三次考勤信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="20%">考勤时间：</td>
				<td width="40%"><input type="text" name="attendance.thirdCheckTime" value="${attendance.thirdCheckTime }" disabled="disabled"/></td>
				<td width="20%">考勤确认：</td>
				<td width="20%">
					<c:choose>
						<c:when test="${attendance.thirdConfirm == 0}">
							<input type="button" value="确认" onclick="confirms('3','${attendance.id}')" />
						</c:when>
						<c:otherwise>
							<span>已确认</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td width="10%">考勤图片：</td>
				<td>
					<c:choose>
						<c:when test="${!empty attendance.thirdImgUrl.imgUrl }">
							<img src="${attendance.thirdImgUrl.imgUrl}" style="border:1px solid #f0f0f0;width:170px;height:170px;"/> 
						</c:when>
						<c:otherwise>
							<span>未考勤</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</fieldset> 
	<fieldset> 
		<legend>第四次考勤信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="20%">考勤时间：</td>
				<td width="40%"><input type="text" name="attendance.fourthCheckTime" value="${attendance.fourthCheckTime}" disabled="disabled"/></td>
				<td width="20%">考勤确认：</td>
				<td width="20%">
					<c:choose>
						<c:when test="${attendance.fourthConfirm == 0}">
							<input type="button" value="确认" onclick="confirms('4','${attendance.id}')" />
						</c:when>
						<c:otherwise>
							<span>已确认</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td width="10%">考勤图片：</td>
				<td>
					<c:choose>
						<c:when test="${!empty attendance.fourthImgUrl.imgUrl }">
							<img src="${attendance.fourthImgUrl.imgUrl}" style="border:1px solid #f0f0f0;width:170px;height:170px;"/> 
						</c:when>
						<c:otherwise>
							<span>未考勤</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</fieldset> 
	<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="submit" value=" 提 交 "/>
					<input type="reset" value=" 重 置 "/>
				</td>
			</tr>
		</table>
	</div> 
	</form>		
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function confirms(num,id){
		$.post("attendanceAction!ajaxAttenConfirm.do",{"attId":id, "attNum":num},function(datas){
			if("success" == datas){
				top.Dialog.alert("确认成功！");
			}else{
				top.Dialog.alert("确认失败！");
			}
		})
	
	}
</script>
</html>