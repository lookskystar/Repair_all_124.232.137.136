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
		<base href="<%=basePath%>"/>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
	<script type="text/javascript">
		$(function(){
			$("#copyBtn").live("click",function(){
				//克隆按钮所在的tr并添加到table的末尾
				$(this).parents("tr").clone(true).appendTo($(this).parents("table"))
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
			})
		})
		
		//提交表单
		function subForm(){
			var date = document.getElementsByName("date");
			var type = document.getElementsByName("type");
			var num  = document.getElementsByName("num");
			var note = document.getElementsByName("note"); 
			var result  = ""; 
			for(var i=0;i<date.length;i++){
				var r = date[i].value;
				var t = type[i].value;
				var n = num[i].value;
				var w = note[i].value;
				if(num[i].value ==""|| date[i].value==""){
					top.Dialog.alert("所填日期、车号不允许为空！");
					return false;
				}else{
					result += r +"$"+ t +"$"+ n +"$"+ w +"$"+"#";
				}
				
			}
			$("#result").val(result);
			return true;
		}

		$(function(){
		   	<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
		   		top.Dialog.close();
		    </c:if>
		});
	</script>
	</head>
<body>
<form action="planManage!saveJc.do" method="post" onsubmit="return subForm();" target="frmright">
	<input type="hidden" id="result" name="result"/>
	<input type="hidden" name="item" value="${item }"/>
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<th colspan="5" align="left" style="color:#00f;font-size: 14px;">
				加改项目：${item }
			</th>
		</tr>
		<tr align="center">
			<th width="90px">加改日期</th>
			<th width="90px">车型</th>
			<th width="90px">车号</th>
			<th>备注</th>
			<th width="60px"></th>
		</tr>
		<tr align="center">
			<td>
				<input name="date" type="text" class="Wdate" style="width: 90px;" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
			</td>
			<td>
			<select name="type" class="default" style="width: 90px;">
				<c:forEach items="${jcTypes}" var="type" >
					<option value="${type }">${type }</option>
				</c:forEach>
			</select>
			</td>
			<td><input type="text" style="width: 90px;" name="num" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
			<td><textarea style="width:300px;height:40px;word-wrap: break-word;word-break: break-all;" name="note"></textarea></td>
			<td width="60"><input type="button" value="增加" id="copyBtn"/></td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 "/>&nbsp;&nbsp;<input type="reset" value=" 取 消 "/></div>
</form>
</body>
	<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</html>
