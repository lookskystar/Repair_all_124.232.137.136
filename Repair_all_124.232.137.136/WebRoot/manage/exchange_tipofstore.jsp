<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>上下车班组互换配件</title>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!-- 表单验证 start -->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!-- 表单验证 end -->
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--框架必需end-->
	<script type="text/javascript">
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

		function choiceAddvance(pjname){
			var diag = new top.Dialog();
			diag.Title = "关联配件预领单";
			diag.Width = 1000;
			diag.Height = 800;
			diag.URL = "pjManageAction!choiceAddvanceTipsList.do?pjname="+pjname;
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定"; 
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document; 
				var flag = false; 
				var id;
				var idIndex = doc.getElementsByName("item");
				for(i=0; i<=idIndex.length; i++){
					if(idIndex[i].checked){
						id = idIndex[i].value;
						flag = true;
						break;
					}
				}
			    if (flag) {  
			    	top.Dialog.confirm("确认关联？",function(){
			    		$.ajax({
							type:"post",
							url:"pjManageAction!addvanceTipsDependence.do",
							data:{"id":id},
							success:function(result){
								var obj = $.parseJSON(result);
								$("#receivenum").val(obj.addvancenum);
								$("#receivedate").val(obj.addvancedate);
								$("#getonnum").val(obj.getonnum);
								$("#pjnum").val(obj.pjnum);
								diag.close();
							}
						});
			    	});
			    }else {
			    	top.Dialog.alert("请选择关联信息！");
			    }
			}
			diag.show();
		}
	</script>	
</head>
<body>
	<form id="manage_exchange_tipofstore_form">
	<input type="hidden" id="id" name="id" value="${pDeliverytip.id }"/>
	<div class="box1" whiteBg="true" >
	<fieldset> 
		<legend>各班组交接信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="10%">配件名称：</td>
				<td><input type="text" style="float: left;" name="pjname" readonly="readonly" value="${pDeliverytip.pjname }"/></td>
				<td width="10%">交旧签章：</td><td width="40%"><input type="text" name="deliveryperson" readonly="readonly" value="${pDeliverytip.deliveryperson }"/></td>
			</tr>
			<tr>
				<td width="10%">交旧数量：</td><td width="40%"><input type="text" name="deliverynum" readonly="readonly" value="${pDeliverytip.deliverynum }"/></td>
				<td width="10%">交旧日期：</td>
				<td><input type="text" name="deliverydate" readonly="readonly" value="${pDeliverytip.deliverydate }"/></td>
			</tr>
			<tr>
				<td width="10%">所属修程：</td><td width="40%"><input type="text" name="xcxc" readonly="readonly" value="${pDeliverytip.xcxc }"/></td>
				<td width="10%">拆下车号：</td><td width="40%"><input type="text" name="getoffnum" readonly="readonly" value="${pDeliverytip.getoffnum }"/></td>
			</tr>
			<tr>
				<td width="10%">承修班组：</td>
				<td width="40%"><input type="text" readonly="readonly" name="fixproteam" value="${pDeliverytip.fixproteam }"/></td>
				<td width="10%">承修签章：</td><td width="40%"><input type="text" name="fixperson" readonly="readonly" value="${pDeliverytip.fixperson }"/></td>
			</tr>
			<tr>
				<td width="10%">配件编号：</td>
				<td width="40%"><textarea rows="" cols="" name="oldpjnum" readonly="readonly">${pDeliverytip.oldpjnum }</textarea></td>
			</tr>
		</table>
	</fieldset> 
	<fieldset> 
		<legend>配件库人员交接信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="10%">领取数量：</td><td width="40%"><input type="text" class="validate[required,custom[onlyNumber],length[0,20]]" id="receivenum" name="receivenum" value="${pDeliverytip.deliverynum }"/><span class="star">*</span></td>
				<td width="10%">发件签章：</td><td width="40%"><input type="text"  name="receiveperson" readonly="readonly" value="${session_user.xm}"/></td>
			</tr>
			<tr>
				<td width="10%">领取日期：</td>
				<td><input type="text" class="Wdate validate[required,custom[date]]" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" id="receivedate" name="receivedate"/><span class="star">*</span></td>
				<td width="10%">预领关联：</td>
				<td><input type="button" value="选择" onclick="choiceAddvance('${pDeliverytip.pjname}');"/></td>
			</tr>
			<tr>
				<td width="10%">上机车号：</td>
				<td width="40%"><input type="text" class="validate[required]" id="getonnum" name="getonnum"/><span class="star">*</span></td>
			</tr>
			<tr>
				<td>配件编号：</td>
				<td>
					<textarea rows="" cols="" id="pjnum" name="receivepjnum" class="validate[required]" style="float: left;" readonly="readonly"></textarea>
					<input type="button" style="float: left;margin-left: 2px;" onclick="addPjnum(this);" value="添加" />
				</td>
			</tr>
		</table>
	</fieldset> 
	</div>
	</form>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>
