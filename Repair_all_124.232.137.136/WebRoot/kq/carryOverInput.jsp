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
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<script type="text/javascript">
		$(function(){

			$("#all").click(function(){
				if($(this).attr("checked")){
					$("input[name='check']").each(function(){
						$(this).attr("checked",true);
					});
				}else{
					$("input[name='check']").each(function(){
						$(this).attr("checked",false);
					});
				}
			});
	   });

		//结转
		function saveCarryOver(){
			var checks=[];
			$("input[name='check']:checked").each(function(){
				checks.push($(this).val());
			});
			if(checks.length==0){
				top.Dialog.alert("请选择要结转的项目");
			}else{ 
				$.ajax({
					type:"POST",
					async:false,
					url:"signAction!saveCarryOver.do",
					data:{"checks":checks.join("-")},
					success:function(data){
						if(data=="success"){
							top.Dialog.alert("结转成功!");
							window.location.href="<%=basePath%>signAction!carryOverInput.do";
						}else{
							top.Dialog.alert("结转失败!");
						}
					}
				});
			}	
		}
		

		//结转
	    function carryOver(Id){
	    	    var workScore=$("#workScore_"+Id).val();
		    	$.post("signAction!confirmOver.do",{"Id":Id,"workScore":workScore},function(data){
						if(data=="success"){
			    			top.Dialog.alert("结转成功",function(){
			    				window.location.href="<%=basePath%>signAction!carryOverInput.do";
			    			});
			    		}else{
			    			top.Dialog.alert("结转失败");
			    		}
				});
	    }

	    function commitScore(Id,obj){
			$.post("signAction!commitScore.do",{"Id":Id,"workScore":obj.value},function(data){
				if(data=="success"&&obj.value!=""){
					$.messager.show(0,'修改成功',2000);
				}		
			});
		}
	</script>
</head>
<body>
<div class="box2" panelTitle="工长结转" roller="false">
	<table>
	    <form action="signAction!queryCarryOver.do" method="post">
		     <tr>
		       <td>状态:<select name="status"  class="default" style="width:68px;">
		                <option value="">全部</option>
		                <option value="0" <c:if test="${0==status}">selected="selected"</c:if>>待签</option>
		                <option value="1" <c:if test="${1==status}">selected="selected"</c:if>>已签</option>
		                <option value="2" <c:if test="${2==status}">selected="selected"</c:if>>已结转</option>
					  </select></td>
	           <td>派工开始时间:<input type="text" name="beginTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${beginTime}" style="width: 100px;"/></td>
	           <td>结束时间:<input type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${endTime}" style="width: 100px;"/></td>
               <td><button type="submit"><span class="icon_find">查询</span></button></td>
			  </tr >
		</form> 
	 </table>
</div >
<div id="scrollContent">
	    <table class="tableStyle"  useMultColor="true" useCheckBox="false">
	        <tr>
				<td colspan="10">
					<button onclick="saveCarryOver();"><span class="icon_save">结转</span></button>&nbsp;
				</td>
			</tr>
		 	<tr>
		      	<th width="3%" align="center"><input type="checkbox"  id="all"/></th>
		      	<th width="7%" align="center"><span>派工时间</span></th>
		      	<th width="27%" align="center"><span>工作内容</span></th>
		      	<th width="7%" align="center"><span>工时得分</span></th>
		      	<th width="18%" align="center"><span>备注</span></th>
				<th width="5%" align="center"><span>状态</span></th>
				<th width="6%" align="center"><span>签认人</span></th>
				<th width="10%" align="center"><span>签认时间</span></th>
				<th width="10%" align="center"><span>结转时间</span></th>
				<th width="7%" align="center"><span>操作</span></th>
		    </tr>
		    <c:if test="${!empty userItemList}">
		    <c:forEach var="userItemList" items="${userItemList}">
		    	<tr>
		    		<td align="center">
			            <c:if test="${userItemList.status==1}">
		    		       <input type="checkbox" name="check" value="${userItemList.id }"/>
		    		    </c:if>
		    		</td>
			        <td align="center">${userItemList.workTime }</td>
			        <td align="center">${userItemList.item.itemName }</td>
			        <td align="center">
			           <c:choose>
			               <c:when test="${userItemList.status!=2 }">
			                 <input type="text" style="width: 45px" name="workScore" id="workScore_${userItemList.id }" value="${userItemList.workScore }" onblur="commitScore(${userItemList.id},this);"/></td>
			               </c:when>
			               <c:otherwise>${userItemList.workScore }</c:otherwise>
			            </c:choose>
			        <td align="center">${userItemList.workNote }</td>
			        <td align="center">
			        	<c:if test="${userItemList.status==0}"><font color="red">待签</font></c:if>
			        	<c:if test="${userItemList.status==1}">已签</c:if>
			        	<c:if test="${userItemList.status==2}"><font color="blue">已结转</font></c:if>
			        </td>
			        <td align="center">
			          <c:forEach items="${usersList}" var="entry">
    	                 <c:if test="${entry.userid == userItemList.user.userid}">${entry.xm}</c:if>
    	              </c:forEach>
			        </td>
			        <td align="center">${userItemList.signTime }</td>
			        <td align="center">${userItemList.overTime }</td>
			        <td align="center">
			          <c:if test="${userItemList.status==1}">
			             <button onclick="carryOver(${userItemList.id });">结转</button>
			          </c:if>
			        </td>
		    	</tr>
		    </c:forEach>
		    <tr><td colspan="10"></td></tr>
		    </c:if>
		    <c:if test="${empty userItemList}"><tr><td colspan="10" align="center">没有相应的数据信息!</td></tr></c:if>
         </table>
</div>
	 <link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	 <script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>
</html>