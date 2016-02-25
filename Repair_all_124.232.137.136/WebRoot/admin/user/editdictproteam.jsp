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
			    var flag=$("input[name='flag']").filter("[checked=true]").val();
			    if($("#proteamname").val()==''){
					alert("班组名称不能为空！");
					return false;
				}
				if($("#py").val()==''){
					alert("班组拼音不能为空！");
					return false;
				}
				if(flag==''||flag==undefined||flag==null){
					alert("班组类型不能为空！");
					return false;
				}
			}
		</script>
  </head>
<body>
  	<form action="userRolesAction!editDictProTeam.do" method="post" id="subForm" target="frmright" onsubmit="return checkform()"> 
  		<input type="hidden" value="${dictproteam.proteamid }" name="proteamId"/>
  	    <input type="hidden" id="jcsTypeString" name="dictproteam.jctype" value=""/>  
		<table class="tableStyle" transMode="true">
		    <tr>
				<td>班组名称: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="dictproteam.proteamname" value="${dictproteam.proteamname }"></input>
				</td>
			</tr>
			<tr>	
				<td>班组拼音: </td>
				<td>
					<input class="easyui-validatebox" type="text" name="dictproteam.py" value="${dictproteam.py }"></input>
				</td>
			</tr>
		  	<tr>	
				<td>适应车型: </td>
				<td>
					<div id="checkGroup" class="render">
	                  <c:forEach items="${dictJcStypeList}" var="entry">
	                      <input type="checkbox"  name="jctypes" value="${entry.jcStypeValue}" <c:if test="${fn:containsIgnoreCase(dictproteam.jctype,entry.jcStypeValue)}">checked="checked"</c:if>/>${entry.jcStypeValue}
	                  </c:forEach>
	                  
	                  <div class="clear"></div>
                    </div>
                </td>    
                    <td><input type="button" value="全选" onclick="checkSelAll()"/></td>
			</tr>	
			<tr>	
				<td>班组类型: </td>
				<td>
					<div class="render">	
	                     <input type="radio"  name="flag"  value="0" <c:if test="${dictproteam.workflag==1}">checked="checked"</c:if>/>小辅修班组
	                     <input type="radio"  name="flag"  value="1" <c:if test="${dictproteam.zxFlag==1}">checked="checked"</c:if>/>中修班组
	                     <input type="radio"  name="flag"  value="2" <c:if test="${dictproteam.workflag==1&&dictproteam.zxFlag==1}">checked="checked"</c:if>/>中修、小辅修班组
	                     <input type="radio"  name="flag"  value="3" <c:if test="${dictproteam.workflag==0||dictproteam.workflag==null}">checked="checked"</c:if>/>管理部门
                    </div>
                        
				</td>
			</tr>   

            <tr>
				<td colspan="2">
					<input type="button" id="enter"  value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="重 置 "/>
				</td>
			</tr>      
		</table>
  	</form>  
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('#enter').bind('click',function(){
			//参数列
			var jctypeString = ",";
			$("input[name='jctypes']:checked").each(function(){
				jctypeString += $(this).val()+",";
	
			})
			$("#jcsTypeString").val(jctypeString);
			if(jctypeString != ","){
				$("#subForm").submit();
			}else{
				top.Dialog.alert("请选择适用车型！");
			}
		})
		
	
	})
	//适用车型全选
	function checkSelAll(){
	   $("#checkGroup input:checkbox").attr("checked",true);
	   checkRefresh("checkGroup")
   }
    </script>
</html>