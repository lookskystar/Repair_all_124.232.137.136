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
	<script type="text/javascript">
		//项目禁用
		function noSelect(recId){
			top.Dialog.confirm("确认禁用？",function(){
				$.post("partFixAction!ajaxEnablePartFixItem.do",{"recId":recId},function(data){
					if(data == "success"){
						top.Dialog.alert("项目禁用成功！");
						window.location.reload();
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
					window.location.reload();
				}
			})
    	});
	}
	//一键禁用或启用项目 ，唐倩 2016-6-25 
	function selectKey(flag){
		var selDetail;
		if(flag==1)
			selDetail = "启用";
		else
			selDetail = "禁用";
		var recIds = [];
		$("input:radio").each(function(){
        	var idValue = $(this).val();
        	recIds.push(idValue);
        })
		
		if(recIds.length==0){
			top.Dialog.alert("没有可"+selDetail+"的项目？");
			return;
		}else{
			top.Dialog.confirm("确定要一键"+selDetail+"所选项目？",function(){
				var ids = ""+recIds.join("-");
				$.post("partFixAction!ajaxEAblePartFixItems.do",{"recIds":ids,"flag":flag},function(data){
					if(data == "success"){
						top.Dialog.alert("一键"+selDetail+"项目成功！");
						window.location.reload();
					}
				})
			});
		}
	}
	//禁用或启用项目 ，唐倩 2016-6-25 
	function selectDo(flag){
		var selDetail;
		if(flag==1)
			selDetail = "启用";
		else
			selDetail = "禁用";
		var recIds = [];
		$("input:radio:checked").each(function(){
        	var idValue = $(this).val();
        	recIds.push(idValue);
        })
		
		if(recIds.length==0){
			top.Dialog.alert("请选择要"+selDetail+"的项目？");
			return;
		}else{
			top.Dialog.confirm("确定要"+selDetail+"所选项目？",function(){
				var ids = ""+recIds.join("-");
				$.post("partFixAction!ajaxEAblePartFixItems.do",{"recIds":ids,"flag":flag},function(data){
					if(data == "success"){
						top.Dialog.alert("项目"+selDetail+"成功！");
						window.location.reload();
					}
				})
			});
		}
	}
	//双击取消选择的单选按钮 ，唐倩 2016-6-26
	function dbNoSel(obj){
		$(obj).attr("checked",false);
	}
	function dbSel(obj){
		$(obj).attr("checked",true);
	}
	</script>
  </head>
  <body>
<div>
	<table>
		<tr>
			<td colspan="7">
				<!-- <span class="icon_page">注:</span> -->
				<span style="font-size:13px;font-weight:bold;">注：需要签认项目：<font color="red">${pageModel.count }</font>条，还有<font color="red">${signed}</font>条项目未签认</span>
				<button onclick="selectKey(1);"><span class="icon_ok">一键启用</span></button>
				<button onclick="selectKey(0);"><span class="icon_no">一键禁用</span></button>
				<button onclick="selectDo(1);"><span class="icon_ok">启用</span></button>
				<button onclick="selectDo(0);"><span class="icon_no">禁用</span></button>
				<input id="userName" type="hidden" value="${session_user.xm}" />
				<input id="fixString" type="hidden" value="" />
			</td>
		</tr>
	</table>
	<table class="tableStyle" headFixMode="true" useMultColor="true">
		<tr align="center">
			<th width="10%">配件名</th>
			<th width="10%">部位</th>
			<th width="20%">检修项目</th>
			<th width="10%">检测情况</th>
			<th width="10%">单位</th>
			<th width="10%">是否启用</th>
			<th width="10%">检修员</th>
			<th width="20%">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle" useMultColor="true">
		<c:forEach items="${pageModel.datas}" var="record">
			<tr align="center">
				<td width="10%">${record.pjname}</td>
				<td width="10%">${record.pjFixItem.posiName}</td>
				<td width="20%">${record.pjFixItem.fixItem}</td>
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
				<td width="10%">${record.pjFixItem.unit}</td>
				<td width="10%">
					<span id="${record.pjRecId}-enablebtn">
						<c:choose>
							<c:when test="${record.fixsituation == '未启用'}">
								<input type="radio" id="${record.pjRecId}-select" name="${record.pjRecId}-select" ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${record.pjRecId}" />
								<a href="javascript:void(0);" style="color:blue;" onclick="selected('${record.pjRecId}');">启用</a>
							</c:when>
							<c:when test="${not empty record.lead}">
								工长已确认项目状态
							</c:when>
							<c:otherwise>
								<input type="radio" id="${record.pjRecId}-noSelect" name="${record.pjRecId}-select" ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${record.pjRecId}" />
								<a href="javascript:void(0);" style="color:blue;" onclick="noSelect('${record.pjRecId}');">禁用</a>
							</c:otherwise>
						</c:choose>
					</span>
				</td>
				<td width="10%">
					<span>
						<c:choose>
							<c:when test="${empty record.empaffirmtime}">
								<span style="color: red;">(待签)</span>
							</c:when>
							<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
						</c:choose>
					</span>
				</td>
				<td width="20%">
					<c:choose>
						<c:when test="${record.preStatus==1}"><span style="color:red;">已报活</span></c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="createPredict(${record.pjRecId})"><span style="color:blue;">报活</span></a>
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
  </body>
</html>
