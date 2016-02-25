<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	
    <script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 解决IE6、7不兼容JSON.stringify问题 -->
	<script type="text/javascript" src="js/json2.js"></script>
	<!--框架必需end-->
	<script type="text/javascript">
		$(function(){
			$("input[name='copyBtn']").live("click",function(){
				//克隆按钮所在的tr并添加到table的末尾
				$(this).parents("table").find("tr").last().clone(true).appendTo($(this).parents("table"));
				//$(this).parents("tr").clone(true).appendTo($(this).parents("table"))
				
				//改变序号
				var $ltd = $(this).parents("table").find("tr").last().children('td');
				var num = parseInt($ltd.eq(0).html())+1;
				$ltd.eq(0).html(num);

				//找到table最后一个tr的最后一个td中的button按钮
				var $lastBtn=$(this).parents("table").find("tr").last().find("td").last().find("input[type='button']");
				//更改按钮的显示文字
				$lastBtn.val("删除");
				//修正按钮在复制时产生的样式错误
				$lastBtn.removeClass("button_hover");
				$lastBtn.addClass("button")
				//对该按钮重新监听点击事件
				$lastBtn.click(function(e){
					//阻止默认行为，即复制行为
					e.stopPropagation();
					//将所在的行删除
					$(this).parents("tr").remove()
				})
			});
		});


		//保存
		function savePlan(){
			var startTime=$("#vac_startTime").val();
			var endTime=$("#vac_endTime").val();
			if(existNull("vac_startTime")){
				top.Dialog.alert("开始时间不能为空!");
			}else if(existNull("vac_endTime")){
				top.Dialog.alert("结束时间不能为空!");
			}
			else if(!compareDate(startTime,endTime)){
				top.Dialog.alert("结束日期不能小于开始日期!");
			}else if(existSelectNull("xm")){
				top.Dialog.alert("姓名不能为空!");
			}else if(existNull("gonghao")){
				top.Dialog.alert("工号不能为空!");
			}else if(existSelectNull("reSignTypeId")){
				top.Dialog.alert("休假类型不能为空!");
			}else{
				var JSONObj=getJSONObject();
				$.ajax({
					type:"POST",
					url:"signAction!saveNoWork.do",
					data:JSONObj,
					dataType:"text",
					success:function(data){
						if(data=="success"){
							top.Dialog.alert("休假录入成功!");
						}else{
							top.Dialog.alert("休假录入失败!");
						}
					}
				});
			}
		}

		//封装JSON数组对象
		function getJSONObject(){
            var vac_startTimeArray=getArrayByName("vac_startTime");
            var vac_endTimeArray=getArrayByName("vac_endTime");
			var gonghaoArray=getArrayByName("gonghao");
			var xmArray=getSelectArrayByName("xm");
			var reSignTypeIdArray=getSelectArrayByName("reSignTypeId");
			var resignReasonArray=getArrayByName("resignReason");
			var objArray=[];
			var obj=null;
			var JSONObj=new Object();
			for(var i=0;i<vac_startTimeArray.length;i++){
				obj=new Object();
                obj.startTime=vac_startTimeArray[i];
                obj.endTime=vac_endTimeArray[i];
				obj.gonghao=gonghaoArray[i];
				obj.xm=xmArray[i];
				obj.reSignTypeId=reSignTypeIdArray[i];
				obj.resignReason=resignReasonArray[i];
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

		function getSelectArrayByName(selectName){
			var array=[];
			$("select[name='"+selectName+"']").each(function(){
				array.push($(this).val());
			});
			return array;
		}

		//验证是否为空
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

		function existSelectNull(selectName){
			var array=[];
			var flag=false;
			$("select[name='"+selectName+"']").each(function(){
				if($(this).val()!=""){
					array.push($(this).val());
				}
			});
			var len=$("select[name='"+selectName+"']").length;
			if(len!=array.length){
				flag=true;
			}
			return flag;
		}

		function compareDate(start, end) {
			 var checkStartDate = start;//开始日期
			 var checkEndDate = end;//结束日期
			 var arys = new Array();
			 var arys1=new Array();
			 var arys2=new Array();
			 if (checkStartDate != null && checkEndDate != null) {
			  arys = checkStartDate.split('-');
			  arys1=arys[2].split(' ');
			  arys2=arys1[1].replace(/(^\s*)|(\s*$)/g, "").split(":");//时间部分去空格并且按照':'分割
			  var startdate = new Date(arys[0], parseInt(arys[1] - 1), arys1[0],arys2[0],arys2[1]);//重新new 一个Date
			  arys = checkEndDate.split('-');
			  arys1=arys[2].split(' ');
			  arys2=arys1[1].replace(/(^\s*)|(\s*$)/g, "").split(":");
			  var checkEndDate = new Date(arys[0], parseInt(arys[1] - 1), arys1[0],arys2[0],arys2[1]);
			  if (startdate < checkEndDate) {
			    return true;
			  } else {
			    return false;
			  }
			 }
			}

		//由姓名获得工号
		function setUserGonghao(obj){
			var t=$(obj).find("option:selected");
			var tag=$(obj).parent().parent().find("td").eq(4).find("input").val($(t)[0].id);
		}
					

		
	</script>
</head>
<body>

<div >
	<div>
		<table class="tableStyle" headFixMode="true" useMultColor="true">
			<tr>
				<td colspan="9">
					<button onclick="savePlan();"><span class="icon_save">保存</span></button>&nbsp;
				</td>
			</tr>
			<tr>
				
				<th width="5%">序号</th>
				<th width="13%">开始时间</th>
				<th width="13%">结束时间</th>
				<th width="15%">姓名</th>
				<th width="10%">工号</th>
				<th width="10%">休假类型</th>
				<th width="24%">休假原因</th>
				<th width="10%">操作</th>
			</tr>
			<tr>
				
				<td align="center">1</td>
				<td align="center"><input type="text" id="vac_startTime" name="vac_startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm'}))" style="width: 120px" /></td>
				<td align="center"><input type="text" id="vac_endTime" name="vac_endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm'}))" style="width: 120px" /></td>
				<td align="center"><select name="xm" style="width: 80px;" class="default" id="xm" onchange="setUserGonghao(this);">
				        <option value=""></option>
				        <c:forEach items="${usersList}" var="entry">
				             <option value="${entry.xm}" id="${entry.gonghao }">${entry.xm}</option>
				        </c:forEach></select></td>
				<td align="center"><input type="text" style="width: 80px" name="gonghao" id="gonghao" readonly="readonly"/></td>
				<td align="center"><select class="default" name="reSignTypeId"  id="reSignTypeId" style="width: 65px;">
				   <option value=""></option>
				   <c:forEach items="${resignTypeList}" var="entry">
				      <c:if test="${entry.typeId!=1}">
				        <option value="${entry.typeId}" <c:if test="${entry.typeId==reSignTypeId}">selected="selected"</c:if>>${entry.typeName}</option>
				      </c:if>
				   </c:forEach>
				</select></td>
				<td align="center"><input type="text"  style="width: 240px" name="resignReason"  /></td>
				<td align="center"><input type="button" value="增加" id="copyBtn" name="copyBtn"/></td>
			</tr>
		</table>
	</div>
	<div style="height:40px;"></div>
</div>
<link href="<%=basePath %>js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>