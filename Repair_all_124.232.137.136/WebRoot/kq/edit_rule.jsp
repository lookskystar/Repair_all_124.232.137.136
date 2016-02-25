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
	<base href="<%=basePath%>" />
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<script type="text/javascript" src="js/form/multiselect.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript" src="js/form/validationEngine-cn.js"></script>
	<script type="text/javascript" src="js/form/validationEngine.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
	<script	type="text/javascript">
		
		function checkform(){
			var msg = $('#slect1').val();
			var lateNot = Number($('#lateNot').val());
			var lateValid = Number($('#lateValid').val());
			var leaveEarly = Number($('#leaveEarly').val());
			var afterValid = Number($('#afterValid').val());
			var firstStartTime = $('#firstStartTime').val();
			var firstEndTime = $('#firstEndTime').val();
			var secStartTime = $('#secStartTime').val();
			var secEndTime = $('#secEndTime').val();
			var workType = $('#workType').val();
		    if(msg == null || ""==msg){
			    top.Dialog.alert("适用班组不能为空！");
			    return false;	
			}
		    if(lateNot > lateValid){
		    	top.Dialog.alert("迟到算旷工时长必须大于允许迟到时长！");	
				return false;
			}
			if(leaveEarly > afterValid){
				top.Dialog.alert("早退算旷工时长必须大于允许早退时长！");	
				return false;
			}
			if(firstStartTime >= firstEndTime){
				top.Dialog.alert("第一班下班时间必须大于上班时间！");
				return false;	
			 }
			 if(workType !=2 && (secStartTime > secEndTime) ){
				 top.Dialog.alert("第二班下班时间必须大于上班时间！");
				return false;	
			 }
			 if(secStartTime  && firstStartTime >= secStartTime){
					top.Dialog.alert("第二班上班时间必须大于第一班上班时间！");
					return false;
			 }
			 if(secStartTime && firstEndTime >= secStartTime){
					top.Dialog.alert("第二班上班时间必须大于第一班下班时间！");
					return false;	
			 } 
			  	return true;
			}

		$(function(){
			var workType = ${rule.workType };
			if(workType=="1"){
				if(${rule.duration==1 }){
					$('#durations').show();
					}else if(${rule.duration==2 }){
						$('#durations').show();
						$('#sec').show();
						}
					
				}else if(workType=="2"){
					$('#durations').hide();
					$('#sec').hide();
    			}

			});
		
		function workTypeFunc(){
			if($('#workType').val()==1){
				if(${rule.duration==1 }){
					$('#durations').show();
					$('#sec').hide();
					}else if(${rule.duration==2 }){
						$('#durations').show();
						$('#sec').show();
						}
				}else if($('#workType').val()==2){
						$('#durations').hide();
						$('#sec').hide();
					}
			}

		function selFunc(){
			if($('#sel').val()==1){
				$('#sec').hide();
				}else if($('#sel').val()==2){
					$('#sec').show();
					}	
			}

		function findProteams() {
			var diag = new top.Dialog();
			diag.Title = "班组信息窗口";
			diag.URL = "<%=basePath%>maintainAction!findAllBz.action";
			diag.Width=500;
			diag.Height=350;
			diag.CancelEvent = function(){
				diag.innerFrame.contentWindow.location.reload();
				diag.close();
			};
			diag.OKEvent = function(){
				var doucmentWin = diag.innerFrame.contentWindow;
				var proteams = doucmentWin.document.getElementsByName("proteam");
				var proteamIds=[];
				var proteamNames=[];
				for(var i=0;i<proteams.length;i++){
					if(proteams[i].checked){
						proteamIds.push(proteams[i].id);
						proteamNames.push(proteams[i].value);
					}
				}
				if(proteamIds.length==0){
					top.Dialog.alert("请选择班组！");	
				}else{
					$("#bzid").val(proteamNames.join(","));
					$("#slect1").val(proteamIds.join(","));
					diag.close();
				}
			};
			diag.ShowButtonRow=true;
			diag.show();
		}
	</script>	
	<!--框架必需end-->
	<body>
		<form action="maintainAction!editRule.do" method="post" id="subForm" target="frmright" onsubmit="return checkform()">   
	  	    <input type="hidden" value="${rule.id }" name="ruleId"/>
			<table class="tableStyle" >
				<tr>
					<td width="22%">适用班组：</td>
					<td width="31%">
						<input type="text" id="bzid" name="bzid" value="${proteamName }" style="width:50%;"/>&nbsp;<input id="proteams" type="button" value="选择" onclick="findProteams()"/>
								<input type="hidden" name="rule.bzid" id="slect1" value="${bzids }"/>
					</td>
					<td  width="22%">上班类型：</td>
					<td  width="25%">
						<select name="rule.workType" id="workType" onchange="workTypeFunc()" autoWidth="true" style="width:100px;">
							<c:if test="${rule.workType==1 }">
								<option value="1">分段上班</option>
								<option value="2">轮流倒班</option>
							</c:if>
							<c:if test="${rule.workType==2 }">
								<option value="2">轮流倒班</option>
								<option value="1">分段上班</option>
							</c:if>
						</select>
					</td>
				</tr>		
				<tr>
					<td>迟到算旷工时长：</td><td><input style="width:120px;" value="${rule.lateValid }" type="text" id="lateValid" name="rule.lateValid"/></td>
					<td>早退算旷工时长：</td><td><input style="width:100px;" value="${rule.afterValid }" type="text" id="afterValid" name="rule.afterValid"/></td>
				</tr>
				<tr>	
					<td>允许迟到时长：</td><td><input style="width:120px;" value="${rule.lateNot }" type="text" id="lateNot" name="rule.lateNot"/></td>
					<td>允许早退时长：</td><td><input style="width:100px;" value="${rule.leaveEarly }" type="text" id="leaveEarly" name="rule.leaveEarly"/></td>
				</tr>
				<tr id="durations">
					<td>上班时间段数：</td>
					<td colspan="3">
						<select name="rule.duration" id="sel" value="${rule.duration }" onchange="selFunc()" autoWidth="true" style="width:100px;">
							<c:if test="${rule.duration==1 }">
								<option value="1">1</option>
								<option value="2">2</option>
							</c:if>
							<c:if test="${rule.duration==2 }">
								<option value="2">2</option>
								<option value="1">1</option>
							</c:if>
						</select>
					</td>
				</tr >
				<tr id>
					<td>第一时段上班：</td>
					<td>
						<input name="rule.firstStartTime" id="firstStartTime" type="text" value="${rule.firstStartTime }" class="inputs" style="width:120px;text-align:center!important;" 
						 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
					</td>
					<td>第一时段下班：</td>
					<td>
						<input name="rule.firstEndTime" id="firstEndTime" type="text" value="${rule.firstEndTime }" class="inputs"  style="width:100px;text-align:center!important;" 
						 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
					</td>
				</tr>
				<tr id="sec" style="display:none">
					<td>第二时段上班：</td>
					<td>
						<input name="rule.secStartTime" id="secStartTime" type="text" value="${rule.secStartTime }" class="inputs"  style="width:120px;text-align:center!important;" 
						 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
					</td>
					<td>第二时段下班：</td>
					<td>
						<input name="rule.secEndTime" id="secEndTime" type="text" value="${rule.secEndTime }" class="inputs"  style="width:100px;text-align:center!important;" 
						 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input type="submit" value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>	
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>