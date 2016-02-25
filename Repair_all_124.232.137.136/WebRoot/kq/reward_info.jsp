<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript">
	   $(function(){
		   	top.Dialog.close();
	  		<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
			</c:if>

			$("#all").click(function(){
				if($(this).attr("checked")){
					$("input[name='check']").each(function(){
						$($(this).attr("checked",true));
					});
				}else{
					$("input[name='check']").each(function(){
						$($(this).attr("checked",false));
					});
				}
			});
	   });

	   //添加考核奖励信息
	   function addRewardInfo(){
	   		top.Dialog.open({
				URL:"rewardAction!addRewardInfoInput.do",
				Width:480,
				Height:390,
				Title:"奖核提报信息录入"
			});
	   }

	   //修改考核奖励信息
	   function updateRewardInfo(rewardId){
	   		top.Dialog.open({
				URL:"rewardAction!updateRewardInfoInput.do?rewardId="+rewardId,
				Width:480,
				Height:390,
				Title:"修改奖核提报信息"
			});
	   }

	   //完善确认考核奖励信息
	   function completeRewardInfo(rewardId){
	   		top.Dialog.open({
				URL:"rewardAction!completeRewardInfoInput.do?rewardId="+rewardId,
				Width:500,
				Height:390,
				Title:"完善确认奖核提报信息"
			});
	   }

	   //删除考核奖励信息 
	   function delRewardInfo(ids){
		   top.Dialog.confirm("确认要删除所选信息?",function(){
			   $.post("rewardAction!ajaxDelRewardInfo.do",{"ids":ids},function(data){
				   if(data=="success"){
					   top.Dialog.alert("信息删除成功!",function(){
						   window.location.reload();
					   });
				   }else{
					   top.Dialog.alert("信息删除失败!");
				   }
			   });
		   });
	   }

	   //根据选择删除考核奖励信息
	   function delChoiceRewardInfo(){
		   var array=[];
		   $("input[name='check']:checked").each(function(){
			   array.push($(this).val());
		   });
		   if(array.length==0){
			   top.Dialog.alert("请选择相应的信息!");
		   }else{
			   var ids=array.join(",");
			   delRewardInfo(ids);
		   }
	   }

	   //审核考核奖励信息
	   function checkRewardInfo(rewardId){
		   top.Dialog.confirm("确认审核通过?",function(){
			   $.post("rewardAction!checkRewardInfo.do",{"rewardId":rewardId},function(data){
				   if(data=="success"){
					   top.Dialog.alert("信息审核成功!",function(){
						   window.location.reload();
					   });
				   }else{
					   top.Dialog.alert("信审核失败!");
				   }
			   });
		   });
	   }

	   //Excel导入
	   function uploadExcel(){
			var diag = new top.Dialog();
			diag.Title = "Excel文件导入";
		    diag.URL = "<%=basePath%>rewardAction!uploadExcelInput.do";
		    diag.Width=400;
		    diag.Height=150;
		    diag.show();
	   }
	</script>
</head>
<body>
 	<div class="box2" panelTitle="考核奖励功能面板" roller="false">
 		<table>
 			<tr>
					<td><button  onclick="addRewardInfo();"><span class="icon_add">奖核提报</span></button>&nbsp;&nbsp;&nbsp;</td>
					<td><button  onclick="delChoiceRewardInfo();"><span class="icon_delete">信息删除</span></button>&nbsp;&nbsp;&nbsp;</td>
					<td><button  onclick="uploadExcel();"><span class="icon_xls">Excel导入</span></button>&nbsp;&nbsp;&nbsp;</td>
					<td><a href="<%=basePath%>kq/reward_temp.xls" style="color:blue;">Excel模板下载</a></td>
 			</tr>
		</table>
	</div>
	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" useCheckBox="false">
		 	<tr>
		      	<th width="5%" align="center"><input type="checkbox" id="all"/></th>
		      	<th width="7%" align="center"><span>班组</span></th>
		      	<th width="5%" align="center"><span>被奖核人</span></th>
		      	<th width="7%" align="center"><span>日期</span></th> 
				<th width="20%" align="center"><span>奖核原因</span></th>
				<th width="5%" align="center"><span>奖励</span></th>
				<th width="5%" align="center"><span>考核</span></th>
		      	<th width="5%" align="center">奖核类别</th>
		      	<th width="10%" align="center">备注</th>
		      	<th width="5%" align="center">提报人</th>
		      	<th width="7%" align="center">提报日期</th>
		      	<th width="10%" align="center">操作</th>
		    </tr>
		    <c:forEach var="reward" items="${rewards}">
			    <tr>
				   	<td align="center">
				   	  <c:if test="${reward.rewardStatus!=2}">
				   	  	<input type="checkbox" name="check" value="${reward.id }"/>
				   	  </c:if>
				   	</td>
			        <td align="center">${reward.proteamName }</td>
			        <td align="center">${reward.rewardPerson }</td>
			        <td align="center">${reward.rewardTime }</td>
			        <td align="center">${reward.rewardContent }</td>
			        <td align="center">
			           <c:if test="${!empty reward.rewardAdd }">${reward.rewardAdd }</c:if>
			        </td>
			        <td align="center">
			           <c:if test="${!empty reward.rewardSub }">-${reward.rewardSub }</c:if>
			        </td>
			        <td align="center">${reward.rewardStandard }</td>
			        <td align="center">${reward.rewardNote }</td>
			        <td align="center">${reward.reportPerson }</td>
			        <td align="center">${reward.reportTime }</td>
			        <td align="center">
			           <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,')}">
				            <c:if test="${reward.rewardStatus==0}">
					        	<a hre="javascript:void(0);" style="color:blue;" onclick="completeRewardInfo(${reward.id});">完善确认</a>&nbsp;&nbsp;&nbsp;
				            </c:if>
			           </c:if>
			           <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GSJJ,')}">
				            <c:if test="${reward.rewardStatus==1}">
					        	<a hre="javascript:void(0);" style="color:red;" onclick="checkRewardInfo(${reward.id});">审核</a>&nbsp;&nbsp;&nbsp;
				            </c:if>
			           </c:if>
			           <c:if test="${sessionScope.session_user.xm==reward.reportPerson }">
				           <c:if test="${reward.rewardStatus!=2}">
					        	<a hre="javascript:void(0);" style="color:blue;" onclick="updateRewardInfo(${reward.id});">修改</a>&nbsp;&nbsp;&nbsp;
					        	<a hre="javascript:void(0);" style="color:blue;" onclick="delRewardInfo(${reward.id});">删除</a>
				           </c:if>
			           </c:if>
			        </td>
			    </tr>	
		    </c:forEach>
         </table>
	</div>
</body>
</html>