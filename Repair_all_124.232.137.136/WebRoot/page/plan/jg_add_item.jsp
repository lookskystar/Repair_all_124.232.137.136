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
		<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
		<script src="js/form/validationEngine.js" type="text/javascript"></script>
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
		var num = ${fn:length(jcTypes)};
		var contents = document.getElementsByName("content");
		var types = new Array();
		for(var j=0;j<num;j++){
			types[j] = document.getElementsByName("num_"+j);
		}
		var result = "";
		for(var i=0;i<contents.length;i++){
			if(contents[i].value==null || contents[i].value==""){
				top.Dialog.alert("请输入加改项目内容!");
				return false;
			}else{
				result += contents[i].value;
			}
			for(var k=0;k<num;k++){
				if(types[k][i].value==null || types[k][i].value==""){
					top.Dialog.alert("计划加改机车数不能为空且只能为数字！");
					return false;
				}else{
					result += "," + types[k][i].alt+":"+types[k][i].value;
				}
			}
			result += "-";			
		}
		document.getElementById("result").value = result;
		return true;
	}

	//关闭
	function exit(){
		top.Dialog.close();
	}
	</script>

	</head>
<body>
<form action="planManage!saveJcItems.do" method="post" onsubmit="return subForm();" target="frmright">
	<input type="hidden" name="result" value="" id="result"/>
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<td width="60" align="center">加改项目内容</td>
			<td width="260">
				<textarea style="width:260px;height:100px;word-wrap: break-word;word-break: break-all;" name="content" class="validate[required]"></textarea>
			</td>
			<td width="60" align="center">计划加改机车数</td>
			<td>
				<ul>
				<c:forEach items="${jcTypes}" var="jcType" varStatus="idx">
					<li style="width: 140px;float: left;margin-left: 5px;">
					<span>${jcType }:
						<input type="text" style="width: 80px;float: right;margin-right: 5px;" value="0" name="num_${idx.index}" onkeyup="this.value=this.value.replace(/\D/g,'')" alt="${jcType}" class="validate[required,custom[onlyNumber]]"/>
					</span></li>
				</c:forEach>
				</ul>
			</td>
			<td width="60"><input type="button" value="增加" id="copyBtn"/></td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 "/>&nbsp;&nbsp;<input type="button" value=" 取 消 " onclick="exit();"/></div>
</form>
</body>
</html>
