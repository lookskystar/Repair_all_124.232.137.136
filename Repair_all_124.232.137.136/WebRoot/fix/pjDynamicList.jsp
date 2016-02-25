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
    <title>动态配件列表</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   var firstUnitId=$("#unit").val()==undefined?"":$("#unit").val();
		   if(jcsType!=""){
			   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
	               var result=eval("("+data+")");
	               var firstUnits=result.firstUnits;
	               var str="<option value=''>请选择大部件</option>";
	               for(var i=0;i<firstUnits.length;i++){
	               		if(firstUnitId!=null && firstUnitId!="" && firstUnits[i].firstUnitId==firstUnitId){
	                   		str+="<option selected='selected' value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }else{
	                   		str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }
	               }
	               $("#first").children().remove();
	               $("#first").append(str);
	           });
		   }
	   }
	   
	   function inputByHand(pjdid,py){
		  	var diag = new top.Dialog();
			diag.Title = "输入配件编号信息";
			diag.Width = "400px";
			diag.Height = 150;
			diag.URL = "fix/inputByHand.jsp?py="+py;
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定 ";
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var pjNum = doc.getElementById("pjNum").value;
				if(pjNum==""){
					top.Dialog.alert("配件编号不能为空!");
				}else{
					$.post("partFixAction!createPJNum.do",{"pjdid":pjdid,"pjNum":pjNum},function(data){
						top.Dialog.alert(data, function() {
							windowHref();
						})
					});
					diag.close();
				}
			};
			diag.show();
		}

		function createFacNumAuto(pjdid,py){
			top.Dialog.confirm("确定要自动生成编号吗?",function(){
				$.post("partFixAction!createPJNum.do",{"pjdid":pjdid,"py":py},function(data){
						top.Dialog.alert(data, function() {
							windowHref();
						})
				  });
			});
		}
		
		//全部自动生成编码
		function createFacNumAutoAll(){
			var array=[];
			$("input[name='pjchk']").each(function(){
				if($(this).attr("checked")){
					array.push($(this)[0].id);
				}
			});
			if(array.length!=0){
				var pjIds=array.join(",");
				$.post("partFixAction!createMostPJNum.do",{"pjIds":pjIds},function(data){
					top.Dialog.alert(data, function() {
							windowHref();
					});
				});
				
			}else{
				top.Dialog.alert("请选择需要自动生成编码的配件!");
			}
		}
		
		//选择一个动态配件做检修
		function choicePJFix(pjdid,pjNum){
			if(pjNum.length==0){
				top.Dialog.alert("当前配件还没编码编码，请生成编码后再检修");
			}else{
				top.Dialog.confirm("您确定检修当前配件吗？",function(){
					$.post("partFixAction!choicePJFix.do", {"pjdid" : pjdid}, function(data) {
						if (data == "success") {
							top.Dialog.alert("操作成功", function() {
								windowHref();
							})
						} else {
							top.Dialog.alert("操作失败");
						}
					}, "text");
				});
			}
		}
		
		//选择多个动态配件做检修
		function choiceMulPJFix(){
			var arr = document.getElementsByName("pjchk");
			var obj = null;
			var pjdids = new Array();
			var flag = true;
			for(var i=0;i<arr.length;i++){   
				obj = arr[i];
				if(obj.checked){
					if(obj.value==0){
						top.Dialog.alert("选择的配件还没编码编码，请生成编码后再检修");
						flag = false;
						break;
					}else{
						pjdids.push(obj.id);
					}
				}        
			}
			if(flag){
				if(pjdids.length==0){
					top.Dialog.alert("请选择待修配件");
				}else{
					top.Dialog.confirm("您确定检修选中的配件吗？",function(){
						$.post("partFixAction!choicePJFix.do", {"pjdid" : pjdids.join(",")}, function(data) {
							if (data == "success") {
								top.Dialog.alert("操作成功", function() {
									//window.location.href="<%=basePath%>partFixAction!pjDynamicList.do";
									window.location.reload();
								})
							} else {
								top.Dialog.alert("操作失败");
							}
						}, "text");
					});
				}
			}
			
		}
		
		//委外检修
		function trustOutsideFix(pjdid,pjNum){
			if(pjNum.length==0){
				top.Dialog.alert("当前配件还没编码编码，请生成编码后再检修");
			}else{
				top.Dialog.open({URL:"<%=basePath%>partFixAction!trustOutsideFixInput.do?pjdid="+pjdid,Width:600,Height:280,Title:"委外检修信息输入"});
			}
		}
		
		function windowHref(){
			var jcsType=$("#jcsType").val()==undefined?"":$("#jcsType").val();
			var firstUnitId=$("#unit").val()==undefined?"":$("#unit").val();
			var pjName=$("#pjName").val()==undefined?"":$("#pjName").val();
			var num=$("#pjNum").val()==undefined?"":$("#pjNum").val();
			window.location.href="<%=basePath%>partFixAction!pjDynamicList.do?jcsType="+jcsType+"&firstUnitId="+firstUnitId+"&pjName="+pjName+"&pjNum"+num;
		}
		
		function selectAll(){
			if($("#all").attr("checked")){
				$("input[name='pjchk']").each(function(){
					$(this).attr("checked",true);
				});
			}else{
				$("input[name='pjchk']").each(function(){
					$(this).attr("checked",false);
				});
			}
		}
		
		//$(function(){
		  // getFirstUnit();
	  // });
	</script>
  </head>
  
 <body>
   	<div class="box2" panelTitle="选择一个具体的配件检修" roller="false" showStatus="false">
		<div>
		   	<form id="form" action="partFixAction!pjDynamicList.do" method="post">
		   	  <input type="hidden" id="unit" value="${firstUnitId}"/>
		          查询条件:车型:<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcsTypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
               </select>
      <!-- 
                     大部件：<select id="first" class="default" name="firstUnitId">
                     <option value="">请选择大部件</option>
               </select> -->
                状态：<select id="pjStatus" class="default" name="pjStatus">
                     <option value="">请选择状态</option>
                     <option value="1" <c:if test="${pjStatus==1}">selected="selected"</c:if>>待修</option>
                     <option value="3" <c:if test="${pjStatus==3}">selected="selected"</c:if>>检修中</option>
               </select>
              &nbsp;&nbsp;
        配件名称:<input type="text" style="width: 100px" name="pjName" value="${pjName }" id="pjName"/>&nbsp;&nbsp;&nbsp;
   配件编号:<input type="text" style="width: 100px" name="pjNum" value="${pjNum}" id="pjNum"/>&nbsp;&nbsp;&nbsp;
   <input type="submit" value="查询"/>&nbsp;&nbsp;&nbsp;<input type="button" value="选择检修" onclick="choiceMulPJFix();"/>&nbsp;&nbsp;&nbsp;
   <input type="button" value="自动生成编码" onclick="createFacNumAutoAll();"/>
			<table class="tableStyle" headFixMode="true" useMultColor="true">
				<tr align="center">
					<th width="5%"><input type="checkbox" name="all" id="all" onclick="selectAll();"/></th>
					<th width="5%"><span>配件标识</span></th>
					<th width="15%">配件名</th>
					<th width="15%"><span>配件编号</span></th>
					<th width="10%"><span>专业</span></th>
					<!-- 
					<th width="10%"><span>机车类型</span></th> -->
					<th width="10%"><span>存放位置</span></th>
					<th width="10%"><span>状态</span></th>
					<th width="8%"><span>备注</span></th>
					<th width="10%"><span>操作</span></th>
				</tr>
			</table></form>
		</div>
		<div id="scrollContent" >
			<table class="tableStyle"  useMultColor="true" >
				<c:forEach items="${pageModel.datas}" var="pj">
					<tr align="center">
						<td width="5%">
							<c:choose>
								<c:when test="${pj.pjStatus==1}"><input type="checkbox" name="pjchk" id="${pj.pjdid}" value="${pj.pjNum}"/></c:when>
								<c:otherwise>
									<span style="color: red;"></span>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="5%">${pj.pjdid}</td>
						<td width="15%">${pj.pjName}</td>
						<td width="15%">
							<c:if test="${empty pj.pjNum}">
								<input type="button" onclick="inputByHand(${pj.pjdid},'${pj.pjStaticInfo.py}')" value="手动输入"/>
								<input type="button" onclick="createFacNumAuto(${pj.pjdid},'${pj.pjStaticInfo.py}')" value="自动生成"/>
							</c:if>
							<c:if test="${!empty pj.pjNum}">${pj.pjNum}</c:if>
						</td>
						<td width="10%">
							${pj.pjStaticInfo.firstUnit.firstunitname}
						</td>
						<%--
						<td width="10%">
							${pj.pjStaticInfo.jcType}
						</td> --%>
						<td width="10%">
							<c:choose>
								<c:when test="${pj.storePosition==0}">中心库</c:when>
								<c:otherwise>班组</c:otherwise>
							</c:choose>
						</td>
						<td width="10%">
							<c:choose>
								<c:when test="${pj.pjStatus==1}">待修</c:when>
								<c:otherwise>
									<span style="color: red;">检修中</span>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="8%">${pj.comments}</td>
						<td width="10%">
						   <c:choose>
								<c:when test="${pj.pjStatus==1}">
								  <a href="javascript:void(0)" onclick="choicePJFix(${pj.pjdid},'${pj.pjNum}')" style="color:blue;">选择检修</a>&nbsp;&nbsp;
								  <a href="javascript:void(0)" onclick="trustOutsideFix(${pj.pjdid},'${pj.pjNum}')" style="color:blue;">委外检修</a>
								</c:when>
								<c:otherwise>
								   <a href="<%=basePath%>pjManageAction!findPJRecorder.do?pjId=${pj.pjdid}" target="_blank" style="color:blue;">查看记录</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
			
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
					<pg:pager items="${pageModel.count}" url="partFixAction!pjDynamicList.do" maxPageItems="10" export="currentPageNumber=pageNumber">
					   <pg:param name="jcsType" value="${jcsType}"/>
					  <pg:param name="firstUnitId" value="${firstUnitId}"/>
					  <pg:param name="pjName" value="${urlName}"/>
					  <pg:param name="pjNum" value="${pjNum}"/>
					   <pg:param name="pjStatus" value="${pjStatus}"/>
					    <pg:first><span><a href="${pageUrl  }" id="first">首页</a></span></pg:first>
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
					    <pg:last><span><a href="${pageUrl }">末页</a></span></pg:last>
					</pg:pager>
				</div>
				<div class="clear"></div>
		   </div>
		</div>
		
		
		
	</div>
  </body>
</html>