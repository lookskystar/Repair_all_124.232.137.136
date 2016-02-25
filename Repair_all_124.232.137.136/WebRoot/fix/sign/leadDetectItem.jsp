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
    <title>检测项目列表</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/enterNext.js"></script>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/unfinished-item.js"></script>
  </head>
  <body>
<div>
	<table>
		<tr>
			<td colspan="11">
				<button id="sign_detectItem"><span class="icon_edit">卡控全签</span></button>
				<span style="font-size:13px;font-weight:bold;">需要卡控签认项目：<font color="red">${pageModel.count }</font>条，还有<font color="red">${signed }</font>条项目未签认</span>
				<input id="role_flag" type="hidden" value="${roleFlag}" />
				<input id="userName" type="hidden" value="${session_user.xm}" />
				<input id="pjDid" type="hidden" value="${pjdid }"/>
			</td>
		</tr>
	</table>
	<table class="tableStyle" headFixMode="true" useMultColor="true">
		<tr align="center">
			<th width="10%">配件名</th>
			<th width="5%">部位</th>
			<th width="15%">检修项目</th>
			<th width="10%">检修员</th>
			<th width="10%">检修情况</th>
			<th width="5%">单位</th>
			<th width="10%">是否启用</th>
			<th width="8%">工长</th>
			<th width="8%">技术/质检员</th>
			<th width="8%">交车工长</th>
			<th width="8%">验收员</th>
			<th width="10">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle" useMultColor="true">
		<c:forEach items="${pageModel.datas}" var="record">
			<tr align="center">
				<td width="10%">${record.pjname}</td>
				<td width="5%">${record.pjFixItem.posiName}</td>
				<td width="15%">${record.pjFixItem.fixItem}</td>
				<td width="10%">
					<c:choose>
						<c:when test="${empty record.empaffirmtime}">
							<span style="color: red;">(待签)</span>
						</c:when>
						<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<span id="${record.pjRecId}-fixsituation">
						<c:choose>
							<c:when test="${record.preStatus==1}"></c:when>
							<c:when test="${!empty record.fixemp && record.fixsituation == '未启用'}">
								<span>未启用</span>
							</c:when>
							<c:otherwise>
							    <c:if test="${empty record.lead}">
									<input type="text" name="fix_status" id="${record.pjRecId},${record.pjFixItem.minVal},${record.pjFixItem.maxVal}" value="${record.fixsituation}" />
								</c:if>
								<c:if test="${!empty record.lead}">${record.fixsituation}</c:if>
							</c:otherwise>
						</c:choose>
					</span>
				</td>
				<td width="5%">
					<span id="${record.pjRecId}-fixsituation">
						${record.pjFixItem.unit}
					</span>
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${record.fixsituation == '未启用'}">
							<input type="radio" id="${record.pjRecId}-select" name="${record.pjRecId}-select" value="1" onclick="selected(${record.pjRecId});"/>启用
						</c:when>
						<c:otherwise>
							<input type="radio" id="${record.pjRecId}-noSelect" name="${record.pjRecId}-select" value="0" onclick="noSelect(${record.pjRecId});"/>禁用
						</c:otherwise>
					</c:choose>
				</td>
				<td width="8%">
					<c:if test="${record.pjFixItem.itemctrllead==1 && record.preStatus!=1}">
						<c:choose>
							<c:when test="${empty record.ldaffirmtime}">
								<c:if test="${empty record.fixsituation}">
									<span style="color: red;">(待签)</span>
								</c:if>
								<c:if test="${!empty record.fixsituation}">
									<button onclick="leadSignDetectItem('${record.pjRecId}','${record.fixsituation}')"><span class="icon_edit">签认</span></button>
								</c:if>
							</c:when>
							<c:otherwise>${record.lead}<br/><fmt:formatDate value="${record.ldaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="8%">
					<c:if test="${record.pjFixItem.itemctrltech==1 || record.pjFixItem.itemctrlqi==1}">
						<c:choose>
							<c:when test="${empty record.qiaffitime}">
								<span style="color: red;">
									<c:if test="${record.pjFixItem.itemctrltech==1 && record.pjFixItem.itemctrlqi==1}">
									</c:if>
									<c:choose>
										<c:when test="${record.pjFixItem.itemctrltech==1 && record.pjFixItem.itemctrlqi==1}">
											技术/质检待签
										</c:when>
										<c:otherwise>
											<c:if test="${record.pjFixItem.itemctrltech==1}">技术待签</c:if>
											<c:if test="${record.pjFixItem.itemctrlqi==1}">质检待签</c:if>
										</c:otherwise>
									</c:choose>
								</span>
							</c:when>
							<c:otherwise>${record.qi}<br/><fmt:formatDate value="${record.qiaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="8%">
					<c:if test="${record.pjFixItem.itemctrlcomld==1}">
						<c:choose>
							<c:when test="${!empty record.commitlead}">${record.commitlead}<br/><fmt:formatDate value="${record.comldaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:when>
							<c:otherwise><span style="color: red;">待签</span></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="8%">
					<c:if test="${record.pjFixItem.itemctrlacce==1}">
						<c:choose>
							<c:when test="${!empty record.accepter}">${record.accepter}<br/><fmt:formatDate value="${record.acceaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:when>
							<c:otherwise><span style="color: red;">待签</span></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${record.preStatus==1}"><span style="color:red">已报活</span></c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="createPredict(${record.pjRecId})">报活</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>


<div style="height:35px;">
	<div class="float_left padding5">
		<c:if test="${empty pageModel}">
			共有信息0条,一页可显示${pageSize}条记录。
		</c:if>
		<c:if test="${!empty pageModel}">
			共有信息${pageModel.count }条,每页显示${pageSize}条记录。 
		</c:if>
	</div>
	<div class="float_right padding5 paging">
		<pg:pager items="${pageModel.count}" url="partFixAction!toDetectItem.do" maxPageItems="20" export="currentPageNumber=pageNumber">
			<pg:param name="pjdid" value="${pjdid}"/>
			<pg:param name="pjRecId" value="${pjRecId}"/>
			<pg:param name="psize" value="20"/>
			<span>
				<pg:prev><a href="${pageUrl}">上一页</a></pg:prev>
			</span>
			<pg:pages>
				<c:choose>
					<c:when test="${currentPageNumber==pageNumber}">
							<span class="paging_current"><a href="javascript:;">${currentPageNumber}</a></span>
					</c:when>
					<c:otherwise>
						<span><a href="${pageUrl}">${pageNumber}</a></span>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<span><a href="${pageUrl}">下一页</a></span>
			</pg:next>
		</pg:pager>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
    	$("#sign_detectItem").bind('click',function(){
    		var pjDid = $("#pjDid").val();
    		$.post("partFixAction!signAllDetectItem.do",{"pjDid":pjDid,"flag":2 },function(data){
    		    if("success" == data){
    		    	top.Dialog.alert("签认成功！");
    		    	window.location.reload();
    		    }else if("noItem" == data){
    		    	top.Dialog.alert("没有可签项目！");
    		    }else if("havefixemp" == data){
    		    	top.Dialog.alert("项目未完全签认！");
    		    }else{
    		    	top.Dialog.alert("签认失败！");
    		    }
    		})
    	})
    })
    
    //项目禁用
	function noSelect(recId){
		top.Dialog.confirm("确认禁用？",function(){
			$.post("partFixAction!ajaxEnablePartFixItem.do",{"recId":recId},function(data){
				if(data == "success"){
					top.Dialog.alert("项目禁用成功！");
					//window.location.reload();
				}
			})
    	});
	}
	
	//项目启用
	function selected(recId){
		top.Dialog.confirm("确认启用？",function(){
			$.post("partFixAction!ajaxAblePartFixItem.do",{"recId":recId},function(data){
				if(data == "success"){
					top.Dialog.alert("项目启用成功！");
					//window.location.reload();
				}
			})
    	});
	}
</script>
</body>
</html>
