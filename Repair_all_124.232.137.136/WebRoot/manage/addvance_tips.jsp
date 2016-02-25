<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>配件预领记录</title>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 表单验证 start -->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!-- 表单验证 end --> 
	<script type="text/javascript">
		//提交表单
		function sub(){
			var access = $('#manage_addvance_tips_form').validationEngine({returnIsValid:true})
			if(access){
				$.ajax({
				   	type: "POST",
				   	url: "pjManageAction!addvanceTipsAdd.do",
				   	data: $('#manage_addvance_tips_form').serialize(),
				   	success: function(msg){
						if(msg == "success"){
							top.window.frmright.location = 'pjManageAction!addvanceTipsList.do';
							top.Dialog.alert("添加成功！");	
						}else {
							top.Dialog.alert("添加失败！");
						}		   	
				   	}
				});
			}else {
				top.Dialog.alert("请将信息填写完整！");
			}
		};

		//手动输入配件编码
		function addPjnum(obj){
			var diag = new top.Dialog();
			diag.Title = "填写配件编码";
			diag.Width = "400px";
			diag.Height = 80;
			diag.URL = "manage/exchange_tipofgeton_addpjnum.jsp";
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定";
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var totalPjnum ;
				var parentPjnum ;
				var childPjnum = $.trim(doc.getElementById("pjnum").value);
				if(childPjnum.length==0){
					top.Dialog.alert("请填写配件编码");
				}else{
					parentPjnum = $(obj).parent().children("#pjnum").val();
					totalPjnum = isEmpty(parentPjnum)? childPjnum + ",": parentPjnum + childPjnum + ",";
					$(obj).parent().children("#pjnum").val(totalPjnum);
					diag.close();
				}
			}
			diag.show();
		}

		function isEmpty(fields){
			return (fields == null || fields == "" || fields == undefined)? true: false;
		}

	</script>	
</head>
<body>
	<div class="box1" whiteBg="true">
		<form id="manage_addvance_tips_form">
		<table class="tableStyle" transMode="true">
			<tr>
				<td>配件名称：</td>
				<td><input type="text" name="addvancetip.pjname" class="validate[required,custom[chinese]]" style="float: left;"/><button style="float: left;margin-left: 5px;"><span class="icon_find">选择</span></button></td>
			</tr>
			<tr>
				<td>装机车号：</td>
				<td><input type="text" name="addvancetip.getonnum" class="validate[required]"/><span class="star">*</span></td>
			</tr>
			<tr>
				<td>预领数量：</td>
				<td><input type="text" name="addvancetip.addvancenum" class="validate[required,custom[onlyNumber],length[0,20]]"/><span class="star">*</span></td>
			</tr>
			<tr>
				<td>预领日期：</td>
				<td><input type="text" name="addvancetip.addvancedate" class="Wdate validate[required,custom[date]]" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/><span class="star">*</span></td>
			</tr>
			<tr>
				<td>所属修程：</td>
				<td ><input type="text" name="addvancetip.xcxc" class="validate[required]"/><span class="star">*</span></td>
				
			</tr>
			<tr>
				<td>预领签章：</td>
				<td><input type="text" name="addvancetip.addvanceperson" readonly="readonly" value="${session_user.xm}"/></td>
			</tr>
			<tr>
				<td>配件编号：</td>
				<td>
					<textarea rows="" cols="" id="pjnum" name="addvancetip.pjnum" class="validate[required]" style="float: left;" readonly="readonly"></textarea>
					<input type="button" style="float: left;margin-left: 2px;" onclick="addPjnum(this);" value="添加" />
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td colspan="2" >
					<button style="float: left;margin-left: 150px;" onclick="sub();"><span>提 交</span> </button>
					<button style="float: left;margin-left: 50px;"><span>重置</span> </button>
				</td>
			</tr>
		</table>
		</form>
	</div>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>
