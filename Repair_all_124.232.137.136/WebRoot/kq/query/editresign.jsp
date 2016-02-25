<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
    <script type="text/javascript">
		   function submitForm(){
			   var signId=$("#signId").val();
			   var signtimeA=$("#signtimeA").val();
			   var signtimeB=$("#signtimeB").val();
			   var signtimeC=$("#signtimeC").val();
			   var signtimeD=$("#signtimeD").val();
			   var signtimeA2=$("#signtimeA2").val();
			   var signtimeB2=$("#signtimeB2").val();
			   var resignReason=$("#resignReason").val();
			   
			   $.post("signAction!editResign.do",{"signId":signId,"signtimeA":signtimeA,"signtimeB":signtimeB,"signtimeC":signtimeC,"signtimeD":signtimeD,"signtimeA2":signtimeA2,"signtimeB2":signtimeB2,"resignReason":resignReason},function(data){
				   if(data=="success"){
		    			top.Dialog.alert("修改成功",function(){
				    			top.window.frmright.location.href="signAction!queryresign.do";
				    			top.Dialog.close();
			    			});
		    		}else if(data=="norule"){
						top.Dialog.alert("没有本班组对应的考勤规则，不能补签");
					}else{
		    			top.Dialog.alert("修改失败");
		    		}
			   });
		   }
		</script>

</head>
<body>
<div class="box1" whiteBg="true">
     <form method="post" action="">
     <input type="hidden" id="signId" value="${sign.signId }"/>
		<table class="tableStyle" formMode="true">
		   <tr>
		        <td>班&nbsp;组：</td>
				<td >
					 <c:forEach items="${dictProTeamList}" var="entry">
    	                 <c:if test="${entry.proteamid==sign.proteamId}">${entry.proteamname}</c:if>
    	             </c:forEach>
				</td>
				<td>日&nbsp;期：</td>
				<td >
    	             ${sign.day}
				</td>
			</tr>
			<tr>
				<td>姓&nbsp;名：</td>
				<td>${sign.xm}</td>
				<td>工&nbsp;号：</td>
				<td>${sign.gonghao}</td>
			</tr>
			<script type="text/javascript">
				<c:if test="${sign.signCount==1}">
					$("#signCount").hide();
					$("#signCount1").hide();
					$("#signCount2").show();
				</c:if>
			</script>
			<tr id="signCount" >
              <td >上班1：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeA" style="width: 130px;" value="${sign.signtimeA }" <c:if test="${sign.signtimeA!=null}">disabled="disabled"</c:if>/></td>
              <td >下班1：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeB" style="width: 130px;" value="${sign.signtimeB }" <c:if test="${sign.signtimeB!=null}">disabled="disabled"</c:if>/></td>
            </tr>
            <tr id="signCount1" >
              <td >上班2：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeC" style="width: 130px;"  value="${sign.signtimeC }" <c:if test="${sign.signtimeC!=null}">disabled="disabled"</c:if>/></td>
              <td >下班2：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeD" style="width: 130px;"  value="${sign.signtimeD }" <c:if test="${sign.signtimeD!=null}">disabled="disabled"</c:if>/></td>
            </tr>
			<tr id="signCount2" style="display: none">
              <td >上班：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeA2" style="width: 130px;"  value="${sign.signtimeA }" <c:if test="${sign.signtimeA!=null}">disabled="disabled"</c:if>/></td>
              <td >下班：</td>
              <td><input type="text" class="Wdate"  onclick="WdatePicker(({maxDate:'%y-%M-{%d-1} 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'}))"  id="signtimeB2" style="width: 130px;"  value="${sign.signtimeB }" <c:if test="${sign.signtimeB!=null}">disabled="disabled"</c:if>/></td>
            </tr>
			<tr>
				<td>补签原因：</td>
				<td colspan="3">
					<textarea style="width: 320px; height: 80px;" name="signrec.resignReason" id="resignReason">${sign.resignReason }</textarea>
				</td>
			</tr>
			<tr></tr>
		</table>
		<div align="center"><input type="button" value=" 提 交 " onclick="submitForm();"/>&nbsp;&nbsp;<input type="reset" value=" 取 消 "/></div>
	</form>
</div>

<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>


</html>