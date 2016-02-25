<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>"/>
    <title>选择日计划的动态配件</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/part_plan.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#choice_pjdynamic").click(function() {
				var pjdid = $("input[name='pjRadio']:checked").val();
				var planId = $("#plan_id").val();
				var pjNum = $("input[name='pjRadio']:checked").attr("class");
				if(typeof(pjNum)=='undefined'){
					top.Dialog.alert("当前没有配件供选择！");
				}else{
					if(pjNum.length==0){
						top.Dialog.alert("您所选的配件还没有编码，请手动输入或点击自动生成！");
					}else{
						$.post("partFixAction!choicePJDynamic.do", {
							'pjdid' : pjdid,
							'planId' : planId
						}, function(data) {
							if (data == 'success') {
								top.Dialog.alert("操作成功", function() {
									window.location.href="partFixAction!datePlanList.do";
								})
							} else {
								top.Dialog.alert("操作失败");
							}
						}, 'text');
					}
				}
				
			})
			
		})
		
		//手动输入出厂编码
		function inputByHand(pjdid,py){
			var diag = new top.Dialog();
			diag.Title = "手动填写配件编码";
			diag.Width = "320px";
			diag.Height = 80;
			diag.URL = "fix/inputByHand.jsp?py="+py;
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定 ";
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var pjNum = $.trim(doc.getElementById("pjpjNum").value);
				if(pjNum.length==0){
					top.Dialog.alert("请填写配件编码");
				}else{
					$.post("partFixAction!createPJNum.do", {
						'pjdid' : pjdid,
						'pjNum' : pjNum
					}, function(data) {
						top.Dialog.alert(data, function() {
							window.location.reload()
						});
					}, 'text');
					diag.close();
				}
			}
			diag.show();
		}

		//自动产生出厂编码
		function createFacNumAuto(pjdid,py){
			top.Dialog.confirm("您确定要自动产生当前配件的编码吗？",function(){
				$.post("partFixAction!createPJNum.do", {
					'pjdid' : pjdid,'py':py
				}, function(data) {
					top.Dialog.alert(data, function() {
						window.location.reload()
					})
				}, 'text');
			});
			
		}
	</script>
  </head>
  
  <body>
   	<div class="box2" panelTitle="选择一个具体的配件供日计划检修" roller="false">
		<table>
			<tr>
				<td colspan="7">
					<button id="choice_pjdynamic"><span class="icon_edit">选择</span></button>
					<!-- 
					<span style="color: blue;">注：需要选择当前类型的配件<em style="color: red;">${amount}</em>&nbsp;个，没有选择框的表示已被其他日计划选择了。</span>
					 -->
					<input type="hidden" id="part_amount" value="${amount}" />
					<input type="hidden" id="plan_id" value="${planId}"/>
				</td>
			</tr>
		</table>
	</div>
<div>
	<table class="tableStyle" headFixMode="true" useMultColor="true">
		<tr align="center">
			<th width="8%">选择</th>
			<th width="10%"><span>配件标识</span></th>
			<th width="20%">配件名</th>
			<th width="22%"><span>出厂编号</span></th>
			<th width="10%"><span>配件条形码</span></th>
			<th width="10%"><span>存放位置</span></th>
			<th width="10%"><span>状态</span></th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle"  useMultColor="true" >
		
		<s:iterator value="#attr.pageModel.datas" var="pj">
			<tr align="center">
				<td width="8%">
					<s:if test="#pj.pjdid not in #attr.parts">
						<s:if test="#pj.pjStatus!=3"><!-- 该配件当前没有别其他的日计划选择 -->
							<input type="radio" name="pjRadio" value="${pj.pjdid}" class="${pj.pjNum}"/>
						</s:if>
					</s:if>
					<s:else>
						<a href="javascript:void(0);" style="color: red;">已选</a>
					</s:else>				
				
				
				</td>
				<td width="10%"><s:property value="#pj.pjdid"/></td>
				<td width="20%"><s:property value="#pj.pjName"/></td>
				<td width="22%">
					<s:if test="#pj.pjNum ==null">
						<input type="button" onclick="inputByHand(${pj.pjdid},'${pj.pjStaticInfo.py}')" value="手动输入"/>
						<input type="button" onclick="createFacNumAuto(${pj.pjdid},'${pj.pjStaticInfo.py}')" value="自动生成"/>
					</s:if>
					<s:else><s:property value="#pj.pjNum"/></s:else>
				</td>
				<td width="10%">
					<s:property value="#pj.pjBarCode"/>
				</td>
				<td width="10%">
					<s:if test="#pj.storePosition==0">中心库</s:if>
					<s:elseif test="#pj.storePosition==1">班组</s:elseif>
					<s:elseif test="#pj.storePosition==2">车上</s:elseif>
					<s:else>外地</s:else>
				</td>
				<td width="10%">
					<s:if test="#pj.pjStatus==0">合格</s:if>
					<s:elseif test="#pj.pjStatus==1">待修</s:elseif>
					<s:elseif test="#pj.pjStatus==2">报废</s:elseif>
					<s:else>检修中</s:else>
				</td>
			</tr>
		</s:iterator>
		
		
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
		<pg:pager items="${pageModel.count}" url="partPlanAction!toChoicePJDynamic.do" maxPageItems="10" export="currentPageNumber=pageNumber">
			<pg:prev><span><a href="${pageUrl }">上一页</a></span></pg:prev>
			<pg:pages>
				<c:choose>
					<c:when test="${currentPageNumber==pageNumber}">
						<span class="paging_current"><a href="javascript:;">${currentPageNumber }</a></span>
					</c:when>
					<c:otherwise>
						<span><a href="${pageUrl }">${pageNumber }</a></span>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next><span><a href="${pageUrl }">下一页</a></span></pg:next>
		</pg:pager>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
  </body>
</html>
