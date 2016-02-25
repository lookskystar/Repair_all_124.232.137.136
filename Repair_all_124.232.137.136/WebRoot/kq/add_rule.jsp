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
	<script type="text/javascript" src="js/form/multiselect.js"></script>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
		function changeFunc(){
		 	var msg;
			msg=$("#slect1").val();
			if(msg=="点击进行多选"){
				msg="无选择"
			}
		 }

		function selFunc(){
			var workType = $("#sel").val();
			if(workType=="1"){
					$('#anti_shid_info').show();
					$('#anti_fast_info').hide();
				}else if(workType=="2"){
					$('#anti_shid_info').hide();
					$('#anti_fast_info').show();
    			}else{
    				$('#anti_shid_info').hide();
    				$('#anti_fast_info').hide();
        			}

			}
		
		function selDur(){	
			var duration = $("#duration").val();
			if(duration==1){first
					$('#first').show();
					$('#sec').hide();
				}else if(duration==2){
					$('#first').show();
					$('#sec').show();
				}else{
					$('#first').hide();
					$('#sec').hide();
					}
			}
	</script>
</head>
<body>
		<div class="box1"   panelTitle="" showStatus="false" roller="true">
				<div>
					<table class="tableStyle"  >
						<tr>
							<td width="22%">适用班组：</td>
							<td  width="31%">
								<input type="text" id="bzid" name="bzid" style="width:50%;"/>&nbsp;<input id="proteams" type="button" value="选择" onclick="findProteams()"/>
								<input type="hidden" name="proteam" id="proteam"/>
							</td>
							<td  width="22%">上班类型：</td>
							<td  width="25%">
								<select name="workType" id="sel" onchange="selFunc()" autoWidth="true" style="width:100px;">
									<option value="">请选择</option>
									<option value="1">分段上班</option>
									<option value="2">轮流倒班</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>迟到算旷工时长：</td><td><input style="width:90px;" type="text" id="lateValid" name="lateValid" watermark="请输入数字"
							onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>&nbsp;分钟</td>
							<td>早退算旷工时长：</td><td><input style="width:80px;" type="text" id="afterValid" name="afterValid" watermark="请输入数字"
							onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>&nbsp;分钟</td>
						</tr>
						<tr>	
							<td>允许迟到时长：</td><td><input style="width:90px;" type="text" id="lateNot" name="lateNot" watermark="请输入数字"
							onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>&nbsp;分钟</td>
							<td>允许早退时长：</td><td><input style="width:80px;" type="text" id="leaveEarly" name="leaveEarly" watermark="请输入数字"
							onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>&nbsp;分钟</td>
						</tr>
					</table>
				</div>
				
				<div id="anti_shid_info" style="display:none" >
					<table class="tableStyle"  >
						<tr>
							<td  width="25%">段数：</td>
							<td colspan="3">
								<select name="duration" id="duration" onchange="selDur()" autoWidth="true" style="width:100px;">
									<option value="">请选择</option>
									<option value="1">1</option>
									<option value="2">2</option>
								</select>
							</td>
						</tr>
						<tr id="first" style="display:none">
							<td  width="25%">第一时段上班：</td>
							<td  width="25%">
								<input name="firstStartTime_1" type="text" class="inputs" id="firstStartTime_1" style="width:120px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
							<td  width="25%">第一时段下班：</td>
							<td  width="25%">
								<input name="firstEndTime_1" type="text" class="inputs" id="firstEndTime_1" style="width:100px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
						</tr>
						<tr id="sec" style="display:none">
							<td>第二时段上班：</td>
							<td>
								<input id="secStartTime_1" name="secStartTime_1" type="text" class="inputs" id="secStartTime_1" style="width:120px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
							<td>第二时段下班：</td>
							<td>
								<input id="secEndTime_1" name="secEndTime_1" type="text" class="inputs" id="secEndTime_1" style="width:100px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
						</tr>
					</table>
				</div>
				<div id="anti_fast_info" style="display:none">
					<table class="tableStyle"  >
						<!-- 
						<tr>
							<td>倒班次数：</td>
							<td colspan="3">
								<select name="shiftCount" id="shiftCount" onchange="selFunc()" autoWidth="true" style="width:100px;">
									<option value="">请选择</option>
									<option vaule="2">2次</option>
									<option vaule="3">3次</option>
									<option vaule="4">4次</option>
								</select>
							</td>
						</tr> 
						-->
						<tr >
							<td  width="25%">上班时间：</td>
							<td  width="25%">
								<input name="firstStartTime_2" type="text" class="inputs" id="firstStartTime_2" style="width:120px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
							<td  width="25%">下班时间：</td>
							<td  width="25%">
								<input name="firstEndTime_2" type="text" class="inputs" id="firstEndTime_2" style="width:100px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
						</tr>
						<!-- <tr >
							<td>第二班上班：</td>
							<td>
								<input name="secStartTime_2" class="inputs" id="secStartTime_2" style="width:120px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td>
							<td>第二班下班：</td>
							<td>
								<input name="secEndTime_2" type="text" class="inputs" id="secEndTime_2" style="width:100px;text-align:center!important;" 
								 onclick="WdatePicker({dateFmt:'HH:mm'});" maxlength="5">
							</td> -->
						</tr>
					</table>
				</div> 
			<center>
				<!-- <input type="button" value="添加" id="add"/>-->
				<input type="button" onclick="saveRule();" value=" 提 交 " />
				<input type="reset" value=" 重 置 "/>
			</center>
		</div>	
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>	
</body>
<script type="text/javascript">
	    $(function(){
	    	$("#add").click(function(){
			    var obj=$(
			    		
			    			);
			    $("table").append(obj);
		    });
	    });
	    function delText(obj){
	    	var removeTime = $("#removeTime").val();
	    	$("#removeTime").val(parseInt(removeTime) + 1 );
	   	    $(obj).parent().parent().remove();
	    }
 
	    function toclose(){
			top.Dialog.close();
		}


	  //新增
		function saveRule(){
			if($("#bzid").val() == null || ""==$("#bzid").val()){
				top.Dialog.alert("适用班组不能为空!");
				}else
			if(existNull("workType")){
				top.Dialog.alert("上班类型不能为空!");
				}else	
			if($("#firstStartTime_2").val() > $("#secStartTime_2").val() ){
				top.Dialog.alert("第二班上班时间必须大于第一班上班时间！");	
				}else
			if($("#firstEndTime_2").val() > $("#secStartTime_2").val() ){
				top.Dialog.alert("第二班上班时间必须大于第一班下班时间！");	
				}else
			if($("#secStartTime_1").val() !="" && $("#firstStartTime_1").val() > $("#secStartTime_1").val() ){
				top.Dialog.alert("第二班上班时间必须大于第一班上班时间！");	
				}else
			if($("#secStartTime_1").val() !="" && $("#firstEndTime_1").val() > $("#secStartTime_1").val() ){
				top.Dialog.alert("第二班上班时间必须大于第一班下班时间！");	
				}else					
			if($("#firstStartTime_1").val() > $("#firstEndTime_1").val() ){
				top.Dialog.alert("下班时间必须大于上班时间！");	
				}else
			if($("#secStartTime_1").val() > $("#secEndTime_1").val() ){
				top.Dialog.alert("下班时间必须大于上班时间！");	
				}else
			if($("#firstStartTime_2").val() > $("#firstEndTime_2").val() ){
				top.Dialog.alert("下班时间必须大于上班时间！");	
				}else
			if($("#sel").val()!=2 && ($("#secStartTime_2").val() > $("#secEndTime_2").val()) ){
				top.Dialog.alert("下班时间必须大于上班时间！");	
				}else
			if(Number($("#lateNot").val()) > Number($("#lateValid").val()) ){
				top.Dialog.alert("迟到算旷工时长必须大于允许迟到时长！");	
				}else
			if(Number($("#leaveEarly").val()) > Number($("#afterValid").val()) ){
				top.Dialog.alert("早退算旷工时长必须大于允许早退时长！");	
				}else{
				var JSONObj=getJSONObject();
				$.ajax({
					type:"POST",
					url:"maintainAction!saveRule.do",
					data:JSONObj,
					dataType:"text",
					success:function(data){
						if(data!="failure"){
							top.Dialog.alert("考勤规则添加成功!",function(){
								top.frmright.window.location.href="maintainAction!getRuleInput.do";
							});
						}else{
							top.Dialog.alert("添加的班组已有对应规则!");
						}
					}
				});
			}
		}
	
		//封装JSON数组对象
		function getJSONObject(){
			var bzidArray=getArrayByName("proteam");
			//var bzArray = bzidArray.split("-");
			var durationArray=getSelectArrayByName("duration");
			var workTypeArray=getSelectArrayByName("workType");
			var firstStartTimeArray=getArrayByName("firstStartTime_1");
			var firstEndTimeArray=getArrayByName("firstEndTime_1");
			var secStartTimeArray=getArrayByName("secStartTime_1");
			var secEndTimeArray=getArrayByName("secEndTime_1");
			var firstStartTimesArray=getArrayByName("firstStartTime_2");
			var secStartTimesArray=getArrayByName("secStartTime_2");
			var firstEndTimesArray=getArrayByName("firstEndTime_2");
			var secEndTimesArray=getArrayByName("secEndTime_2");
			var lateValidArray=getArrayByName("lateValid");
			var afterValidArray=getArrayByName("afterValid");
			var lateNotArray=getArrayByName("lateNot");
			var leaveEarlyArray=getArrayByName("leaveEarly");
			var objArray=[];
			var obj=null;
			var JSONObj=new Object();
			for(var i=0;i<firstStartTimeArray.length;i++){
				obj=new Object();
				obj.bzid=bzidArray[i];
				obj.workType=workTypeArray[i];
				if(workTypeArray[i]==1){
					obj.duration=durationArray[i];
					obj.firstStartTime=firstStartTimeArray[i];
					obj.secStartTime=secStartTimeArray[i];
					obj.firstEndTime=firstEndTimeArray[i];
					obj.secEndTime=secEndTimeArray[i];
					}
				if(workTypeArray[i]==2){
					obj.duration=1;
					obj.firstStartTime=firstStartTimesArray[i];
					obj.secStartTime=secStartTimesArray[i];
					obj.firstEndTime=firstEndTimesArray[i];
					obj.secEndTime=secEndTimesArray[i];
					}
				obj.lateValid=lateValidArray[i];
				obj.afterValid=afterValidArray[i];
				obj.lateNot=lateNotArray[i];
				obj.leaveEarly=leaveEarlyArray[i];
				objArray.push(obj);
			}
			JSONObj.jsonStr=JSON.stringify(objArray);
			return JSONObj;
		}

		//根据相应的标签名称得到里面的值的集合数组
		function getArrayByName(inputName){
			var array=[];
			$("input[name='"+inputName+"']").each(function(){
				array.push($(this).val());
			});
			return array;
		}

		//根据相应的标签名称得到里面的值的集合数组
		function getSelectArrayByName(selectName){
			var array=[];
			$("select[name='"+selectName+"']").each(function(){
				array.push($(this).val());
			});
			return array.join("-");
		}

		function existNull(selectName){
			
			var array=[];
			var flag=false;
			$("select[name='"+selectName+"']").each(function(){
				if($(this).val()!="" && $(this).val()!=null){
					array.push($(this).val());
				}
			});
			var len=$("select[name='"+selectName+"']").length;
			if(len!=array.length){
				flag=true;
			}
			return flag;
		}

		function findProteams() {
			var diag = new top.Dialog();
			diag.Title = "班组信息窗口";
			diag.URL = "<%=basePath%>maintainAction!findAllBz.action";
			diag.Width=500;
			diag.Height=400;
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
					$("#proteam").val(proteamIds.join(","));
					diag.close();
				}
			};
			diag.ShowButtonRow=true;
			diag.show();
		}
	</script>
</html>