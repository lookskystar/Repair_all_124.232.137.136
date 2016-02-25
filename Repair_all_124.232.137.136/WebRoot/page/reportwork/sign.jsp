<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	request.setAttribute("recId", request.getParameter("recId"));
	request.setAttribute("type", request.getParameter("type"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- 过程报活签认页面 -->
		<title>签字</title>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->
			<script src="js/menu/contextmenu.js" type="text/javascript"></script>
		<script type="text/javascript">
			//提交表单
			function submitForm() {
				var itemType = "${type}";
				//2015-6-2，黄亮，修改，获得select元素，输入框的值，不是选择的值
    			var checkInfo = $("#checkInfoInput").attr("editValue");//检查情况(获取select元素，输入框的值，不是选择的值)
				if (checkInfo == ""|| checkInfo==null || checkInfo==undefined) {
					top.Dialog.alert("检查情况不能为空!");
					return false;
				}	
				
				$.post("reportWorkManage!reportWorkItemSignConfirm.action",
						{"id":"${id}","type":"${type}","role":"${role}","params":"${params}","dealSituation":checkInfo},
						function(text){
							if(text=="login_failure"){
								top.Dialog.alert("不存在该用户!");
							}else if(text=="noprivilege_failure"){
								top.Dialog.alert("没有可签项目或不是该用户的分工项目!");
							}else{
								top.Dialog.alert("签名成功!",function(){
								   if("${role}"=='worker'){//工人签报活项目
								      top.frmright.frames[2].location.reload();
									  top.Dialog.close(); 
								   }else{//其它角色
								       top.frmright.frames[1].location.reload();
							    	   top.Dialog.close();
								   }
								    //交车工长判断
									//top.frames[2].location.reload();
									//top.Dialog.close();
								});
							}
						}
				);
				
			}
			
			$(function() {
   				 var option = { width: 150, items: [
                    { text: "良好", icon: "<%=basePath%>images/icons/ico4.gif", alias: "良好",  width: 180,action: menuAction},
                    { text: "检查良好", icon: "<%=basePath%>images/icons/ico4.gif", alias: "检查良好",  width: 180,action: menuAction},
                    { text: "更换良好", icon: "<%=basePath%>images/icons/ico4.gif", alias: "更换良好",  width: 180,action: menuAction},
                    { text: "清洗良好", icon: "<%=basePath%>images/icons/ico4.gif", alias: "清洗良好",  width: 180,action: menuAction}
                    ], onShow: applyrule,
        onContextMenu: BeforeContextMenu
    };
    function menuAction() {
    	var obj = $("#checkInfoInput").html();
        $("#checkInfoInput").html(obj+this.data.alias);
    }
    function BeforeContextMenu() {
        return this.id != "target3";
    }
    
    function applyrule(menu) {               
       menu.applyrule({ name: "all",
           disable: true,
           items: []
       });
    }
    $("#checkInfoInput").contextmenu(option);
});



		</script>
<script type="text/javascript" src="js/timer2.src.js"></script> 
<script type='text/javascript'>
</script>
	</head>
	<body>
		<input type="hidden" id="loginType" name="loginType" value="0" />
		<table class="tableStyle" transMode="true">
			
			<tr>
				
			</tr>
			
			<c:if test="${role=='worker'||role=='foreman_worker'}">
				<tr>
					<!--  
					<td>
						检修情况：
					</td>
					<td>
						<textarea id="checkInfoInput" style="width: 200px; height: 100px;"></textarea>
					</td>
					-->
					<td>
					检修情况：
				</td>
				<td>
					<!-- 2015-5-22，黄亮，添加，报活签认下拉框，解决报活更换配件问题 -->
					<select editable="true" id="checkInfoInput" style="width: 250px;" autoWidth="true">
					    <option value="良好">良好</option>
					    <option value="更换良好">更换良好</option>
					    <option value="已处理">已处理</option>
				 	</select>
				</td>
				</tr>
			</c:if>
			

			<tr>
				<td colspan="2">
					<input type="button" value="签 认" onclick="submitForm()"/>
				</td>
			</tr>
		</table>
	</body>
</html>