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
    <title>机破管理</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="teach!trainFaultLists.do" method="post">
 	<div class="box1">
 		<table>
 			<tr>
 				<td>机车编号</td>
 				<td>
 					<input type="text" watermark="输入机车编号" style="line-height: 22px;vertical-align: top" name="jcnum"/>&nbsp;
 				</td>
 			</tr>
 			<tr>
				<td>开始时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd"/></td>
				<td>
					<button><span class="icon_find" style="height: 22px;">查询</span></button>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="新增" onclick="news();"/>&nbsp;&nbsp;
					<input type="button" value="删除" onclick='enSureDelete();'/>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true"  useCheckBox="true" >
		 	<tr>
		 		<th width="30px" align="center"></th>
		      	<th width="10%" align="center"><span>机车类型</span></th>
		      	<th width="10%" align="center"><span>机车编号</span></th> 
		      	<th width="10%" align="center"><span>机车段属</span></th>
		      	<th width="20%" align="center"><span>机破原因</span></th>
		      	<th width="25%" align="center"><span>机破日期</span></th>
		      	<th width="10%" align="center"><span>机破段属</span></th>
		      	<th width="35%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty TrainFaultPm}">
			   	<c:forEach items="${TrainFaultPm.datas}" var="trainFault" >
			   		<tr>
			   			<td width="30px" align="center"><input id="faultid" name="fault" type="checkbox" value="${trainFault.id}"/></td>
						<td width="10%" align="center"><span>${trainFault.jctype}</span></td>
						<td width="10%" align="center"><span>${trainFault.jcnum}</span></td>
						<td width="10%" align="center"><span>${trainFault.locomotive}</span></td>
						<td width="20%" align="center"><span>${trainFault.faultCause}</span></td>
						<td width="20%" align="center"><span>${trainFault.faultDate}</span></td>
						<td width="10%" align="center"><span>${trainFault.faultmotive}</span></td>
						<td width="40%" align="center">
							<span class="img_edit hand" title="编辑" onclick="edit(${trainFault.id});" style="margin-left: 10px;"></span>
							<span class="img_delete hand" title="删除" onclick='top.Dialog.confirm("确认删除该条信息？",deletes(${trainFault.id}));' style="margin-left: 5px;"></span>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty TrainFaultPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${TrainFaultPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="teach!trainFaultLists.do" items="${TrainFaultPm.count }" export="page1=pageNumber">
				<pg:param name="jcnum" value="${jcnum}"/>
				<pg:param name="dateStart" value="${dateStart}"/>
				<pg:param name="dateEnd" value="${dateEnd}"/>
		  		<pg:first>
					 <span><a href="${pageUrl }" id="first">首页</a></span>
		 		</pg:first>
		 		<pg:prev>
					  <span><a href="${pageUrl }">上一页</a></span>
		  		</pg:prev>
	  	  		<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber }">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
		  		</pg:pages>
		  		<pg:next>
				    <span><a href="${pageUrl }">下一页</a></span>
		  		</pg:next>
		  		<pg:last>
				  	<span><a href="${pageUrl }">末页</a></span>
		 		</pg:last>
		 	</pg:pager>
			&nbsp;每页
		</div>
		<div class="float_left"><select autoWidth="true"><option>15</option><option>20</option><option>25</option></select></div>
		<div class="float_left padding_top4">条记录</div>
		<div class="clear"></div>
	</div>
	</form>
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
	})
	
	function news(jctype, jcnum){
		var diag = new top.Dialog();
		diag.Title = "添加机破信息";
		diag.URL = "teach!newTrainFault.do";
		diag.Width=530;
		diag.Height=1000;
		diag.show();
	}
	
	function edit(id){
		var diag = new top.Dialog();
		diag.Title = "编辑信息";
		diag.URL = "teach!trainFaultInfo.do?id="+id;
		diag.Width=820;
		diag.Height=500;
		diag.show();
	}
	
	//删除
	function deletes(id) {
		var faults = [];  
		faults.push(id);
    	$.ajax({
			type:"post",
			async:false,
			url:"teach!deleteTrainFaultAjax.do",
			data:{"faults":faults.join(",")},
			success:function(result){
				if(result=="success"){
	    			top.Dialog.alert("机破信息删除成功！",function(){
			    			window.location.href="teach!trainFaultLists.do"
		    			});
	    		}else{
	    			top.Dialog.alert("机破信息删除失败！");
	    		}
			}
		})
	}
	
	//判断是否选中信息
	function enSureDelete(){
		//判断是否一个未选
		var flag; 
		//遍历所有的name为document的 checkbox 
		$("input[name='fault']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })
	    if (flag) {  
	    	top.Dialog.confirm("确认删除？",function(){
	    		toDelete();
	    	});
	    }else {
	    	top.Dialog.alert("请至少选择一条机破信息！");
	    }
	
	}
	
	//删除
	function toDelete() {
		//用于保存 选中的那一条数据的ID 
		var faults = [];  
    	$("input[name='fault']").each(function() { 
    		if ($(this).attr("checked")) { 
    			//将选中的值 添加到 array中
    			faults.push($(this).val());
    		}
    	}) 
    	$.ajax({
			type:"post",
			async:false,
			url:"teach!deleteTrainFaultAjax.do",
			data:{"faults":faults.join(",")},
			success:function(result){
				if(result=="success"){
	    			top.Dialog.alert("机破信息删除成功！",function(){
			    			window.location.href="teach!trainFaultLists.do"
		    			});
	    		}else{
	    			top.Dialog.alert("机破信息删除失败！");
	    		}
			}
		})
	}
	
	function sub(){
		$("#subForm").submit();
	}
</script>
</html>