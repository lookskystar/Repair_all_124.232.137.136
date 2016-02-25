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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	<!--框架必需end-->
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 解决IE6、7不兼容JSON.stringify问题 -->
	<script type="text/javascript" src="js/json2.js"></script>

</head>
<body>
<div  class="box1" whiteBg="true">
     <c:if test="${!empty rule}">
     <form method="post" action="signAction!saveResign.do">
		<table class="tableStyle" formMode="true">
			<tr>
				<td>姓&nbsp;&nbsp;名：</td>
				<td><select name="xm" style="width: 80px;" class="default" id="xm" onchange="setUserGonghao(this);">
				        <option value=""></option>
				        <c:forEach items="${usersList}" var="entry">
				             <option value="${entry.xm}" id="${entry.gonghao }">${entry.xm}</option>
				        </c:forEach></select><span class="star">*</span></td>
				<td>工&nbsp;&nbsp;号：</td>
				<td><input type="text" style="width: 80px" name="signrec.gonghao" id="gonghao" readonly="readonly"/></td>
			</tr>
			<script type="text/javascript">
				<c:if test="${rule.duration==1}">
					$("#signCount").hide();
					$("#signCount1").hide();
					$("#signCount2").show();
				</c:if>
			</script>
			<tr id="signCount">
				<td>上班1：</td>
				<td><input type="text" id="signtimeA" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;" onblur="exist(this);"/><span class="star">*</span></td>
				<td>下班1：</td>
				<td><input type="text" name="signrec.signtimeB" id="signtimeB" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;"/></td>
			</tr>
			<tr id="signCount1">
				<td>上班2：</td>
				<td><input type="text" name="signrec.signtimeC" id="signtimeC" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;" /></td>
				<td>下班2：</td>
				<td><input type="text" name="signrec.signtimeD" id="signtimeD" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;"/></td>
			</tr>
			<tr id="signCount2" style="display: none">
				<td>上班：</td>
				<td><input type="text" id="signtimeA2" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;" onblur="exist(this);"/><span class="star">*</span></td>
				<td>下班：</td>
				<td><input type="text" id="signtimeB2" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" style="width: 130px;"/></td>
			</tr>
			<tr>
				<td>操作员：</td>
				<td><input type="text" name="signrec.operator" id="operator"  value="${session_user.xm}" disabled="disabled"/></td>
				<td>操作日期：</td>
				<td><input type="text" name="signrec.operatorTime" id="operatorTime"  class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" value="${ntime}" style="width: 130px;"/><span class="star">*</span></td>
			</tr>
			<tr>
				<td>补签原因：</td>
				<td colspan="3">
					<textarea style="width: 320px; height: 80px;" name="signrec.resignReason" id="resignReason"></textarea>
				</td>
			</tr>
			<tr></tr>
		</table>
		<div align="center"><input type="button" value=" 提 交 " onclick="submitForm();"/>&nbsp;&nbsp;<input type="reset" value=" 取 消 "/></div>
	</form>
	</c:if>
    <c:if test="${empty rule}"><div align="center"><span style="color:red">没有考勤规则，不能补签</span></div></c:if>
</div>

<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>

<script type="text/javascript">

	//判断签到记录是否存在
	function exist(obj) {
		var gonghao = $("#gonghao").val();
		var signtime = $(obj).val();
		if (signtime) {
			$.post("signAction!ajaxKQSignRecExist.do", {"gonghao" : gonghao,"signtime" : signtime}, function(data) {
				if (data == "success") {
					top.Dialog.alert("签到信息已经存在，请勿重复添加!", function() {
						$(obj).val("");
						$(obj).focus();
					});
				}
			});
		}
	}

	//由姓名获得工号
	function setUserGonghao(obj) {
		var t = $(obj).find("option:selected")[0].id;
		$("#gonghao").val(t);
	}

	function submitForm() {
		var xm = $("#xm").val();
		var gonghao = $("#gonghao").val();
		var signtimeA = $("#signtimeA").val();
		var signtimeB = $("#signtimeB").val();
		var signtimeC = $("#signtimeC").val();
		var signtimeD = $("#signtimeD").val();
		var signtimeA2 = $("#signtimeA2").val();
		var signtimeB2 = $("#signtimeB2").val();
		var operator = $("#operator").val();
		var operatorTime = $("#operatorTime").val();
		var resignReason = $("#resignReason").val();
		if (!xm) {
			top.Dialog.alert("姓名不能为空");
			return false;
		}
		if (!gonghao) {
			top.Dialog.alert("工号不能为空");
			return false;
		}
		if (!(signtimeA || signtimeA2)) {
			top.Dialog.alert("上班时间不能为空");
			return false;
		}
		if (!operatorTime) {
			top.Dialog.alert("操作时间不能为空");
			return false;
		}
		$.post("signAction!saveResign.do",{
							"xm" : xm,
							"gonghao" : gonghao,
							"signtimeA" : signtimeA,
							"signtimeB" : signtimeB,
							"signtimeC" : signtimeC,
							"signtimeD" : signtimeD,
							"signtimeA2" : signtimeA2,
							"signtimeB2" : signtimeB2,
							"operator" : operator,
							"operatorTime" : operatorTime,
							"resignReason" : resignReason
						},
						function(data) {
							if (data == "success") {
								top.Dialog.alert("补签成功",function() {
									top.window.frmright.location.href = "signAction!queryresign.do";
									top.Dialog.close();});
							} else {
								top.Dialog.alert("补签失败");
							}
						});
	}
</script>


</html>