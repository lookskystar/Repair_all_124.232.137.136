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

		//签认
		function saveSign(){
			var checks=[];
			$("input[name='check']:checked").each(function(){
				checks.push($(this).val());
			});
			if(checks.length==0){
				top.Dialog.alert("请选择要签认的项目");
			}else{ 
				$.ajax({
					type:"POST",
					async:false,
					url:"signAction!saveSign.do",
					data:{"checks":checks.join("-")},
					success:function(data){
						if(data=="success"){
							top.Dialog.alert("签认成功!");
							window.location.href="<%=basePath%>signAction!signInput.do";
						}else{
							top.Dialog.alert("签认失败!");
						}
					}
				});
			}	
		}

		//签认
	    function sign(Id){
	    	    var workNote=$("#workNote_"+Id).val();
		    	$.post("signAction!confirmSign.do",{"Id":Id,"workNote":workNote},function(data){
						if(data=="success"){
			    			top.Dialog.alert("签认成功",function(){
			    				window.location.href="<%=basePath%>signAction!signInput.do";
			    			});
			    		}else{
			    			top.Dialog.alert("签认失败");
			    		}
				});
	    }

		
		function commitNote(Id,obj){
			$.post("signAction!commitNote.do",{"Id":Id,"workNote":obj.value},function(data){
				if(data=="success"&&obj.value!=""){
					$.messager.show(0,'修改成功',2000);
				}				
			});
		}
	</script>
</head>
<body>
<div class="box2" panelTitle="工人签认" roller="false">
	<table>
	    <form action="signAction!querySign.do" method="post">
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
				<td colspan="8">
					<button onclick="saveSign();"><span class="icon_save">签认</span></button>&nbsp;
				</td>
			</tr>
		 	<tr>
		      	<th width="3%" align="center"><input type="checkbox"  id="all"/></th>
		      	<th width="8%" align="center"><span>派工时间</span></th>
		      	<th width="33%" align="center"><span>工作内容</span></th>
		      	<th width="6%" align="center"><span>工时得分</span></th>
		      	<th width="25%" align="center"><span>备注</span></th>
				<th width="8%" align="center"><span>状态</span></th>
				<th width="10%" align="center"><span>签认时间</span></th>
				<th width="7%" align="center"><span>操作</span></th>
		    </tr>
		    <c:if test="${!empty userItemList}">
		    <c:forEach var="userItemList" items="${userItemList}">
		    	<tr>
		    		<td align="center">
			            <c:if test="${userItemList.status==0}">
		    		       <input type="checkbox" name="check" value="${userItemList.id }"/>
		    		    </c:if>
		    		</td>
			        <td align="center">${userItemList.workTime }</td>
			        <td align="center">${userItemList.item.itemName }</td>
			        <td align="center">${userItemList.workScore }</td>
			        <td align="center">
			            <c:choose>
			               <c:when test="${userItemList.status==0 }">
			                 <input type="text" style="width: 160px" name="workNote" id="workNote_${userItemList.id }" value="${userItemList.workNote }"  onblur="commitNote(${userItemList.id},this);"/></td>
			               </c:when>
			               <c:otherwise>${userItemList.workNote }</c:otherwise>
			            </c:choose>
			        <td align="center">
			        	<c:if test="${userItemList.status==0}"><font color="red">待签</font></c:if>
			        	<c:if test="${userItemList.status==1}">已签</c:if>
			        	<c:if test="${userItemList.status==2}"><font color="blue">已结转</font></c:if>
			        </td>
			        <td align="center">${userItemList.signTime }</td>
			        <td align="center">
			          <c:if test="${userItemList.status==0}">
			             <button onclick="sign(${userItemList.id });">签认</button>
			          </c:if>
			        </td>
		    	</tr>
		    </c:forEach>
		    <tr><td colspan="8"></td></tr>
		    </c:if>
		    <c:if test="${empty userItemList}"><tr><td colspan="8" align="center">没有相应的数据信息!</td></tr></c:if>
         </table>
</div>
	 <link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	 <script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>
</html>