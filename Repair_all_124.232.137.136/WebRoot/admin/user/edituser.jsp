<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script>
		function checkform(){
			    if($("#roleid").val()==''){
			    	top.Dialog.alert("角色不能为空！");
				    return false;
			    }
			    if($("#proteamid").val()==''){
			    	top.Dialog.alert("班组不能为空！");
				    return false;
			    }
				if($("#xm").val()==''){
					top.Dialog.alert("用户姓名不能为空！");
					return false;
				}
				if($("#gonghao").val()==''){
					top.Dialog.alert("用户工号不能为空！");
					return false;
				}
				if($("#pwd").val()==''){
					top.Dialog.alert("登录密码不能为空！");
					return false;
				}
				
			}
		</script>
  </head>
<body>
  	<form action="userRolesAction!editUserPrivs.do" method="post" target="frmright" onsubmit="return checkform()">   
  	    <input type="hidden" value="${user.userid }" name="userId"/>
		<table class="tableStyle" transMode="true">
			<tr>
				<td>角&nbsp;&nbsp;&nbsp;&nbsp;色:</td>
				<td>
					<select id="roleid" name="roleid" class="default">
					     <option value="">请选择角色</option>
					     <c:forEach items="${user.rolePrivs}" var="userrole">
						      <c:forEach items="${rolePrivsList}" var="entry">
						       <c:if test="${!fn:containsIgnoreCase(entry.py,'XTGL')}">
	    	                     <option value="${entry.roleid}" <c:if test="${userrole.roleid==entry.roleid}">selected="selected"</c:if>>${entry.rolename}</option>
	    	                   </c:if>  
	    	                 </c:forEach>
					     </c:forEach>
					</select><font color="red">&nbsp;&nbsp;*</font>
				</td>
			
				<td>机务段: </td>
				<td>
				   <select id="jwdcode"  name="usersPrivs.jwdcode" class="default">
					     <c:forEach items="${dictJwdList}" var="entry"> 
    	                     <option value="${entry.jwdcode}" <c:if test="${user.jwdcode==entry.jwdcode}">selected="selected"</c:if>>${entry.jwdmc}</option>
    	                 </c:forEach>
					</select>
				</td>
			</tr>
	 		<tr>
				<td>地区: </td>
				<td>
				   <select id="areaid"  name="usersPrivs.areaid" class="default">
					     <c:forEach items="${dictAreaList}" var="entry"> 
    	                     <option value="${entry.areaid}" <c:if test="${user.areaid==entry.areaid}">selected="selected"</c:if>>${entry.name}</option>
    	                 </c:forEach>
					</select>
				</td>
			
				<td>是否启用: </td>
				<td>
				   <select  name="usersPrivs.isuse" class="default" style="width: 60px;">
    	               <option value="1" <c:if test="${user.isuse==1}">selected="selected"</c:if>>是</option>
    	               <option value="0" <c:if test="${user.isuse==0}">selected="selected"</c:if>>否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>班&nbsp;&nbsp;&nbsp;&nbsp;组: </td>
				<td>
					<select id="proteamid"  name="usersPrivs.bzid" colNum="2">
					     <option value="">请选择班组</option>
					     <c:forEach items="${dictProTeamList}" var="entry"> 
    	                     <option value="${entry.proteamid}" <c:if test="${user.bzid==entry.proteamid}">selected="selected"</c:if>>${entry.proteamname}</option>
    	                 </c:forEach>
					</select><font color="red">&nbsp;&nbsp;*</font>
				</td>
		<!-- 		<td>部门名称: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="usersPrivs.depatid"  value="${user.depatid }"></input>
				</td>
			
			</tr>
			<tr>
				<td>职务: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="usersPrivs.zwid"  value="${user.zwid }"></input>
				</td>         -->
			
				<td>用户姓名: </td>
				<td>
					<input class="easyui-validatebox" type="text" id="xm" name="usersPrivs.xm" value="${user.xm }"></input><font color="red">&nbsp;&nbsp;*</font>
				</td>
			</tr>
			<tr>
				<td>登陆名称: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.name" value="${user.name }"></input>
				</td>
			
				<td>用户工号: </td>
				<td>
					<input class="easyui-validatebox" type="text" id="gonghao" name="usersPrivs.gonghao" value="${user.gonghao }"></input><font color="red">&nbsp;&nbsp;*</font>
				</td>
			</tr>
			<tr>
				<td>IDK卡号: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.idkid" value="${user.idkid }"></input>
				</td>
			
				<td>登录密码: </td>
				<td>
					<input class="easyui-validatebox" type="text" id="pwd" name="usersPrivs.pwd" value="${user.pwd }"></input><font color="red">&nbsp;&nbsp;*</font>
				</td>
			</tr>
			
			<tr>
				<td>登录时间: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.logintime" value="${user.logintime }"></input>
				</td>
			
				<td>登记日期: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.uptime" value="${user.uptime }"></input>
				</td>
			</tr>
			
			<tr>
				<td>性别: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.sex" value="${user.sex }"></input>
				</td>
			
				<td>办公电话: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.tel" value="${user.tel }"></input>
				</td>
			</tr>
			<tr>
				<td>办公传真: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.fax" value="${user.fax }"></input>
				</td>
			
				<td>手&nbsp;&nbsp;&nbsp;&nbsp;机1: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.mobile" value="${user.mobile }"></input>
				</td>
			</tr>
			<tr>
				<td>手&nbsp;&nbsp;&nbsp;&nbsp;机2: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.mobile2" value="${user.mobile2 }"></input>
				</td>
			
				<td>家庭电话: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.homephone" value="${user.homephone }"></input>
				</td>
			</tr>
			<tr>
				<td>通讯地址: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.address" value="${user.address }"></input>
				</td>
			
				<td>IP地址: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.ip" value="${user.ip }"></input>
				</td>
			</tr>
		    <tr>
				<td>姓名拼音: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.py" value="${user.py }"></input>
				</td>
				
				<td>备&nbsp;&nbsp;&nbsp;&nbsp;注: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="usersPrivs.qita" value="${user.qita }"></input>
				</td>
			</tr>
			
			<tr>
				<td colspan="4">
					<input type="submit" value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value=" 重 置 "/>
				</td>
			</tr>      
		</table>
  	</form>  
</body>
</html>