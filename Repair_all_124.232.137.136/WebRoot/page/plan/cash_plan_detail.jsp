<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	
    <script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--框架必需end-->
	<!-- 打印插件 -->
	<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
	<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
	       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed> 
	</object> 
	<!-- 打印end -->
	<script type="text/javascript">
		//合并表格的单元格
		function cellMege(table,col){
			var lines=$('#'+table+' tr').size();
			if(lines<=2) return ;
			var v,l=0,current='',index=1;
			for(var i=1;i<lines;i++){
				var tr=$('#'+table+' tr').eq(i);
				v=tr.find('td[name="'+col+'"]').html();
				//alert(tr.find('td[name="secondname"]').size());
				l++;
				//alert(v);
				if(v!=current||i==(lines-1)){//如果两个值不相同或者是最后一行
					if(i==(lines-1)) l++;
					if(l>1){//草果两行，合并
						var td=$('#'+table+' tr').eq(index).find('td[name="'+col+'"]');
						td.attr('rowspan',l);
						for(var j=1;j<l;j++){
							var td=$('#'+table+' tr').eq(index+j).find('td[name="'+col+'"]').remove();
						}
					}
					l=0;//从新计数
					current=v;
					index=i;
				}
			}
		}

		$(function(){
			cellMege('datatabel','planTime');
			cellMege('datatabel','planWeek');
		});

		function getCashReason(obj,id){
			var reason=obj.value;
			if($.trim(reason).length>0){
				$.post("planManage!ajaxGetReason.do",{"id":id,"reason":reason},function(data){
					if(data=="success"){
						$.messager.show(0, '未兑现原因保存成功', 2000);
					}
				});
			}
		}
	</script>
</head>
<body>
<table class="tableStyle"  useMultColor="true" id="datatabel">
       <tr>
          <th colspan="10" align="center"><font style="font-weight:bold;font-size:15px;">${mainPlan.title }</font></th>
       </tr>
       <tr>
          <th colspan="10" align="center">制表日期:${mainPlan.makeTime }&nbsp;&nbsp;&nbsp;&nbsp;制表人:${mainPlan.makePeople }</th>
       </tr>
</table>
<div id="content">
	<table class="tableStyle"  useMultColor="true" id="datatabel">
	       	<tr>
				<th width="8%">日期</th>
				<th width="5%">星期</th>
				<th width="5%">序号</th>
				<th width="5%">机型</th>
				<th width="5%">机号</th>
				<th width="5%">修程</th>
				<th width="8%">公里</th>
				<th width="10%">扣修点</th>
				<th width="15%">备注</th>
				<th width="5%">状态</th>
				<th>原因</th>
			</tr>
		   <c:forEach var="detail" items="${mainPlanDetails }">
					<tr>
						<td align="center" name="planTime">${detail.planTime }</td>
						<td align="center" name="planWeek">${detail.planWeek }</td>
						<td align="center">${detail.num }</td>
						<td align="center">${detail.jcType }</td>
						<td align="center">${detail.jcNum }</td>
						<td align="center">${detail.xcxc }</td>
						<td align="center">${detail.kilometre }</td>
						<td align="center">${detail.kcArea }</td>
						<td align="center">${detail.comments }</td>
						<td align="center">
						  <c:if test="${detail.isCash==0}"><font color="red">未兑现</font></c:if>
						  <c:if test="${detail.isCash==1}">日兑现</c:if>
						  <c:if test="${detail.isCash==2}">周兑现</c:if>
						</td>
						<td align="center">
						   <c:if test="${detail.isCash==0}"><input type="text" style="width:200px;" onblur="getCashReason(this,${detail.id});" value="${detail.cashReason }"/></c:if>
						</td>
					</tr>
		   </c:forEach>
		   <tr></tr>
	</table>
</div>
</body>
</html>