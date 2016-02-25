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

	   //添加公告信息
	   function addNoticeInfo(){
	   		top.Dialog.open({
				URL:"rewardAction!addNoticeInfoInput.do",
				Width:450,
				Height:260,
				Title:"公告信息录入"
			});
	   }

	   //修改公告信息
	   function updateNoticeInfo(noticeId){
	   		top.Dialog.open({
				URL:"rewardAction!updateNoticeInfoInput.do?noticeId="+noticeId,
				Width:450,
				Height:260,
				Title:"修改公告信息"
			});
	   }

	   //删除公告信息 
	   function delNoticeInfo(ids){
		   top.Dialog.confirm("确认要删除所选信息?",function(){
			   $.post("rewardAction!ajaxDelNoticeInfo.do",{"ids":ids},function(data){
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

	   //根据选择删除公告信息
	   function delChoiceNoticeInfo(){
		   var array=[];
		   $("input[name='check']:checked").each(function(){
			   array.push($(this).val());
		   });
		   if(array.length==0){
			   top.Dialog.alert("请选择相应的信息!");
		   }else{
			   var ids=array.join(",");
			   delNoticeInfo(ids);
		   }
	   }

	   //删除公告信息 
	   function updateNoticeStatus(noticeId,status){
		   var message="";
	       if(status==0){
	       		message="确认公告该信息?";
	       }else if(status==1){
		        message="确认取消公告该信息?";
	       }
		   top.Dialog.confirm(message,function(){
			   $.post("rewardAction!ajaxUpdateNoticeStatus.do",{"noticeId":noticeId,"status":status},function(data){
				   if(data=="success"){
					   top.Dialog.alert("公告状态修改成功!",function(){
						   window.location.reload();
					   });
				   }else{
					   top.Dialog.alert("公告状态修改失败!");
				   }
			   });
		   });
	   }
	</script>
</head>
<body>
 	<div class="box2" panelTitle="考核奖励功能面板" roller="false">
 		<table>
 			<tr>
				<td><button  onclick="addNoticeInfo();"><span class="icon_add">新增公告</span></button>&nbsp;&nbsp;&nbsp;</td>
				<td><button  onclick="delChoiceNoticeInfo();"><span class="icon_delete">删除公告</span></button>&nbsp;&nbsp;&nbsp;</td>
 			</tr>
		</table>
	</div>
	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" useCheckBox="false">
		 	<tr>
		      	<th width="3%" align="center"><input type="checkbox" id="all"/></th>
		      	<th width="10%" align="center"><span>标题</span></th>
		      	<th width="25%" align="center"><span>内容</span></th> 
		      	<th width="7%" align="center"><span>公告时间</span></th>
		      	<th width="7%" align="center"><span>开始时间</span></th>
		      	<th width="7%" align="center"><span>结束时间</span></th>
				<th width="7%" align="center"><span>公告部门</span></th>
				<th width="5%" align="center"><span>公告人</span></th>
				<th width="5%" align="center"><span>状态</span></th>
		      	<th width="10%" align="center">操作</th>
		    </tr>
		    <c:forEach var="notice" items="${noticeInfos}">
		    	<tr>
		    		<td align="center"><input type="checkbox" name="check" value="${notice.id }"/></td>
			        <td align="center">${notice.noticeTitle }</td>
			        <td align="center">${notice.noticeContent }</td>
			        <td align="center">${notice.noticeTime }</td>
			        <td align="center">${notice.startTime }</td>
			        <td align="center">${notice.endTime }</td>
			        <td align="center">${notice.noticeDept }</td>
			        <td align="center">${notice.noticePerson }</td>
			        <td align="center">
			        	<c:if test="${notice.noticeStatus==0}"><font color="red">已公告</font></c:if>
			        	<c:if test="${notice.noticeStatus==1}">未公告</c:if>
			        	<c:if test="${notice.noticeStatus==2}"><font color="blue">已失效</font></c:if>
			        </td>
			        <td align="center">
			            <c:if test="${notice.noticeStatus==0}">
			            	<a href="javascript:void(0);" style="color:blue;" onclick="updateNoticeStatus(${notice.id },1);">不公告</a>&nbsp;&nbsp;&nbsp;
			            </c:if>
			            <c:if test="${notice.noticeStatus==1}">
			            	<a href="javascript:void(0);" style="color:blue;" onclick="updateNoticeStatus(${notice.id },0);">公告</a>&nbsp;&nbsp;&nbsp;
			            </c:if>
			            <c:if test="${notice.noticeStatus!=2}">
			        		<a href="javascript:void(0);" style="color:blue;" onclick="updateNoticeInfo(${notice.id });">修改</a>&nbsp;&nbsp;&nbsp;
			        	</c:if>
			        	<a href="javascript:void(0);" style="color:blue;" onclick="delNoticeInfo(${notice.id });">删除</a>
			        </td>
		    	</tr>
		    </c:forEach>
		    <c:if test="${empty noticeInfos}"><tr><td colspan="10" align="center">没有相应的数据信息!</td></tr></c:if>
         </table>
	</div>
	<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
</body>
</html>