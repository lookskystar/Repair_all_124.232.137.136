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
		<div class="box1" panelWidth="590" panelHeight="350" panelTitle="添加节假日" showStatus="false" roller="true">
			<table class="tableStyle" >
			<tr align="center">	
				<td>
				春节放假时间:<input type="hidden" name="cause" value="春节假"/>&nbsp;&nbsp;<input  type="text" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
					
				</td>	
			</tr>
			<tr align="center">	
				<td>
					五一放假时间:<input type="hidden" name="cause" value="五一假"/>&nbsp;&nbsp;<input  type="text" class="Wdate" name="startTime" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
				</td>	
			</tr>
			<tr align="center">	
				<td>
					端午放假时间:<input type="hidden" name="cause" value="端午假"/>&nbsp;&nbsp; <input  type="text" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
				</td>	
			</tr>
			<tr align="center">	
				<td>
					中秋放假时间:<input type="hidden" name="cause" value="中秋假"/>&nbsp;&nbsp; <input  type="text" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
				</td>	
			</tr>
			<tr align="center">	
				<td>
					国庆放假时间:<input type="hidden" name="cause" value="国庆假"/>&nbsp;&nbsp;<input  type="text" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
				</td>	
			</tr>
			<tr align="center">	
				<td>
					元旦放假时间:<input type="hidden" name="cause" value="元旦假"/>&nbsp;&nbsp;<input  type="text" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"></input>&nbsp;&nbsp;至&nbsp;&nbsp;
					<input  type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
				</td>	
				
			</tr>
			</table>
			<center>
				<input type="button" value="添加" id="add"/>
				<input type="button" onclick="saveHoliday();" value=" 提 交 " />
				<input type="reset" value=" 重 置 "/>
			</center>
		</div>
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
<script type="text/javascript">
	    $(function(){
	    	$("#add").click(function(){
			    var obj=$("<tr >"	
								+"<td align='center'>"
									+"放假原因：&nbsp;&nbsp;<input type='text' name='cause' style='width:90px;'/>"
									+"&nbsp;&nbsp;时间:&nbsp;&nbsp;<input  type='text' name='startTime' class='Wdate' onclick='WdatePicker()' style='width: 110px;'></input>&nbsp;&nbsp;至&nbsp;&nbsp;"
									+"<input  type='text' name='endTime' class='Wdate' onclick='WdatePicker()' style='width: 110px;'/>"
									+"<input type='button' value='移除' onclick='delText(this);'/> "
								+"</td>	"
						+"</tr>");
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


	  //保存
		function saveHoliday(){
			if(existNull("cause")){
				top.Dialog.alert("节日名不能为空!");
			}else if(existNull("startTime")){
				top.Dialog.alert("放假起始时间不能为空!");
			}else if(existNull("endTime")){
				top.Dialog.alert("放假结束时间不能为空!");
			}else{
				var JSONObj=getJSONObject();
				$.ajax({
					type:"POST",
					url:"maintainAction!saveHoliday.do",
					data:JSONObj,
					dataType:"text",
					success:function(data){
						if(data!="failure"){
							top.Dialog.alert("节假日编辑成功!",function(){
								window.location.href="maintainAction!getHolidayInput.do";
							});
						}else{
							top.Dialog.alert("你所设定的日期已是放假日期！!");
						}
					}
				});
			}
		}
	
		//封装JSON数组对象
		function getJSONObject(){
			
			var causeArray=getArrayByName("cause");
			var startTimeArray=getArrayByName("startTime");
			var endTimeArray=getArrayByName("endTime");
			var objArray=[];
			var obj=null;
			var JSONObj=new Object();
			for(var i=0;i<causeArray.length;i++){
				obj=new Object();
				obj.holidayName=causeArray[i];
				obj.startTime=startTimeArray[i];
				obj.endTime=endTimeArray[i];
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

		function existNull(inputName){
			var array=[];
			var flag=false;
			$("input[name='"+inputName+"']").each(function(){
				if($(this).val()!=""){
					array.push($(this).val());
				}
			});
			var len=$("input[name='"+inputName+"']").length;
			if(len!=array.length){
				flag=true;
			}
			return flag;
		}
	</script>
</html>