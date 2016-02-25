<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->


</head>
<body>
	<button  onclick="add();"><span class="icon_add">添加</span></button>&nbsp;&nbsp;&nbsp;
	<table class="tableStyle cusTreeTable" useColor="false" useHover="false" useClick="false" trClick="true">
		<tr>
			<th width="30">操作</th><th width="100">交件人</th><th width="100">接件人</th><th>交接时间</th><th>操作</th>
		</tr>
		<c:forEach items="${hrs.datas}" var="item">
			<c:forEach items="${item}" var="entry">
				<tr align="center">
					<td><span class="img_add2 hand"></span></td><td>${entry.key.comunitPeo }</td><td>${entry.key.receiptPeo }</td><td><fmt:formatDate value="${entry.key.handoverTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td><td><c:if test="${(empty entry.key.receiptPeo || empty entry.key.handoverTime) && session.session_user.xm==entry.key.comunitPeo}"><a href="javascrip:;" onclick="addHandover(${entry.key.id}); return false;">添加配件</a></c:if><c:if test="${(empty entry.key.receiptPeo || empty entry.key.handoverTime) && session.session_user.xm!=entry.key.comunitPeo}"><a href="javascrip:;" onclick="handover(${entry.key.id}); return false;">交接</a></c:if></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<table class="tableStyle">
							<tr>
								<th>
									配件名
								</th>
								<th>
									上车编号
								</th>
								<th>
									出厂编号
								</th>
								<th>
									配件条形码
								</th>
								<th>
									配件生产厂家
								</th>
								<th>
									出厂日期
								</th>
								<th>
									存储位置
								</th>
								<th>
									配件状态
								</th>
								<c:if test="${(empty entry.key.receiptPeo || empty entry.key.handoverTime) && session.session_user.xm==entry.key.comunitPeo}">
									<th>
										操作
									</th>
								</c:if>
							</tr>
							<c:forEach items="${entry.value}" var="entry2">
								<tr align="center">
									<td>
										${entry2.pjName }
									</td>
									<td>
										${entry2.getOnNum }
									</td>
									<td>
										${entry2.factoryNum }
									</td>
									<td>
										${entry2.pjBarCode }
									</td>
									<td>
										${entry2.factory }
									</td>
									<td>
										${entry2.outFacDate }
									</td>
									<td>
										<c:if test="${entry2.storePosition==0 }">中心库</c:if>
										<c:if test="${entry2.storePosition==1 }">班组</c:if>
										<c:if test="${entry2.storePosition==2 }">车上</c:if>
										<c:if test="${entry2.storePosition==3 }">外地</c:if>
									</td>
									<td>
										<c:if test="${entry2.pjStatus ==0 }">合格</c:if>
										<c:if test="${entry2.pjStatus ==1 }">待修</c:if>
										<c:if test="${entry2.pjStatus ==2 }">报废</c:if>
										<c:if test="${entry2.pjStatus ==3 }">检修中</c:if>
									</td>
									<c:if test="${(empty entry.key.receiptPeo || empty entry.key.handoverTime) && session.session_user.xm==entry.key.comunitPeo}">
										<td>
											<a href="javascript:;" onclick="shanchu(${entry2.pjdid});return false;" style="color: red;">删除</a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
 
	<!-- 处理分页 -->
	<div style="height:35px;">
		<div class="float_right padding5 paging">
			<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="pjManageAction!handoverRecord.do" items="${hrs.count}" export="page1=pageNumber">
			  <pg:first>
				 <span><a href="${pageUrl  }" id="first">首页</a></span>
			  </pg:first>
			  <pg:prev>
				  <span><a href="${pageUrl  }">上一页</a></span>
			  </pg:prev>
		  	  <pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber}">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl  }">${pageNumber }</a></span>
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
		<div class="clear"></div>
	</div>
   <!-- 处理分页end -->
   <script type="text/javascript">
    $(function(){
 		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
    });
   	function add() {
   		top.Dialog.confirm("确认添加交接单？",function(){
   			location.href="pjManageAction!addHandoverRecordInput.do";
   	   	});
   	}

   	function addHandover(id) {
   		var diag = new top.Dialog();
   		diag.Title = "配件选择窗口";
   		diag.URL = "pjManageAction!findDynamicHandover.do";
   		diag.Width = "80";
   		diag.Height = "100";
   		diag.ShowButtonRow=true;
   		diag.OKEvent = function(){
   			var checkedValue = diag.innerFrame.contentWindow.document.getElementById('ids').value;
   			if (checkedValue!='') {
   	   			checkedValue.substring(0,checkedValue.length-1);
   	   			location.href="pjManageAction!addDynamicPJToHandoverRecord.do?id="+id+"&ids="+checkedValue;
   			}
   			diag.close();
   		};
   		diag.show();
   	}

   	function handover(id) {
   		top.Dialog.confirm("确认该交接单？",function(){
   			location.href="pjManageAction!handover.do?id="+id;
   	   	});
   	}

   	function shanchu(id) {
   		top.Dialog.confirm("确认从该交接记录中删除该配件？",function(){
   			location.href="pjManageAction!deleteDynamicFromHandoverRecord.do?id="+id;
   	   	});
   	}
   </script>
</body>
</html>
