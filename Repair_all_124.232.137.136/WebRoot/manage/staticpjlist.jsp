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

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<!-- 引入分页JS -->
<script type="text/javascript" src="admin/js/page.js"></script>

<script type="text/javascript">
   //根据机车类型得到一级部件信息
   function getFirstUnit(){
	   var jcsType=$("#jcsType").val();
	   if(jcsType!=""){
		   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
               var result=eval("("+data+")");
               var firstUnits=result.firstUnits;
               var str="<option value=''>请选择大部件</option>";
               for(var i=0;i<firstUnits.length;i++){
                   str+="<option value="+firstUnits[i].firstUnitName+">"+firstUnits[i].firstUnitName+"</option>";
               }
               $("#first").children().remove();
               $("#first").append(str);
           });
	   }
   }
   function getFirstUnit1(){
	   var jcsType=$("#jcsType").val();
	   if(jcsType!=""){
		   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
               var result=eval("("+data+")");
               var firstUnits=result.firstUnits;
               var str="<option value=''>请选择大部件</option>";
               for(var i=0;i<firstUnits.length;i++){
                   str+="<option value="+firstUnits[i].firstUnitName+">"+firstUnits[i].firstUnitName+"</option>";
               }
              // $("#first").children().remove();
              // $("#first").append(str);
           });
	   }
   }
    //得到二级部件信息
    function getSecondUnit(){
        var firstId=$("#first").val();
        if(firstId!=""&&firstId!=0){
            $.post("<%=basePath%>fixItemAction!ajaxGetSecondUnit.do",{"firstUnitId":firstId},function(data){
                var result=eval("("+data+")");
                var secunits=result.secunits;
                var str="<option value=''>请选择二级部件</option>";
                for(var i=0;i<secunits.length;i++){
                	 str+="<option value="+secunits[i].secunitId+">"+secunits[i].secunitName+"</option>";
                }
                $("#second").children().remove();
                $("#second").append(str);
            });
        }
    }

    //得到项目详情信息
    function getItemInfo(itemId){
    	top.Dialog.open({URL:"<%=basePath%>fixItemAction!itemInfoInput.do?itemId="+itemId,Width:600,Height:450,Title:"查看项目详情"});
    }
    //添加项目
    function addPjStaticInfo(){
    	top.Dialog.open({URL:"<%=basePath%>pjManageAction!addPjStaticInfoInput.do",Width:650,Height:280,Title:"添加静态配件信息"});
    }
     //修改项目
    function updatePjStaticInfo(pjId){
    	top.Dialog.open({URL:"<%=basePath%>pjManageAction!updatePjStaticInfoInput.do?pjId="+pjId,Width:650,Height:280,Title:"修改静态配件信息"});
    }
     //删除静态配件信息
    function delPjStaticInfo(pjId){
    	var pjIdArry=[];
    	top.Dialog.confirm("确认要删除吗?",function(){
    		if(pjId!=0){//单个删除
    			pjIdArry.push(pjId);
    		}else{
    			$("input[name='pjIds']:checked").each(function(){
    				pjIdArry.push($(this).val());
    			});
    		}
    		if(pjIdArry.length==0){
    			top.Dialog.alert("请选择配件!");
    		}else{
    			var pjIds=pjIdArry.join(",");
    			window.location.href="<%=basePath%>pjManageAction!delPjStaticInfo.do?pjIds="+pjIds;
    		}
    	});
    }
     
    //添加检修配件
    function addPjDyInfo(pjsId){
    	top.Dialog.open({URL:"<%=basePath%>pjManageAction!addPjDyInfoInput.do?pjsId="+pjsId,Width:650,Height:280,Title:"添加待修配件信息"});
    }
     
    $(function(){
    	top.Dialog.close();
  		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
		getFirstUnit1();
		$("#all").click(function(){
	    	if($(this).attr("checked")){
	    		$("input[name='pjIds']").each(function(){
	    			$(this).attr("checked",true);
	    		});
	    	}else{
	    		$("input[name='pjIds']").each(function(){
	    			$(this).attr("checked",false);
	    		});
	    	}
    	});
    });
</script>
</head>
<body>
<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',ZR,')}">
	<button  onclick="addPjStaticInfo();"><span class="icon_add">添加</span></button>&nbsp;&nbsp;&nbsp;
	<button  onclick="delPjStaticInfo(0);"><span class="icon_delete">删除</span></button><br/>
</c:if>
<form id="form" action="pjManageAction!staticPJListInput.do" method="post">
	<div id="showImage">
                     查询条件:车型:<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcsTypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
               </select>
                     大部件：<select id="first" class="default" name="firstUnitName">
                     <option value="">请选择大部件</option>
                     <c:forEach var="ft" items="${firstunits}">
                         <option value="${ft.firstunitname }" <c:if test="${ft.firstunitname==firstUnitName}">selected="selected"</c:if>>${ft.firstunitname}</option>
                     </c:forEach>
               </select>
      <%-- 
                   所属流程：<select id="second" class="default" name="flowTypeId">
                     <option value="">请选择流程类型</option>
                     <c:forEach var="flowType" items="${flowTypes}">
                       <option value="${flowType.flowTypeId}" <c:if test="${flowType.flowTypeId==flowTypeId}">selected="selected"</c:if>>${flowType.flowTypeName}</option>
                     </c:forEach>
               </select>--%>
              &nbsp;&nbsp;
        配件名称:<input type="text" style="width: 200px" name="pjName" value="${pjName }"/>&nbsp;&nbsp;&nbsp;<input type="submit" value="查询"/>
	   <table width="100%" class="tableStyle" useCheckBox="false">
			<tr>
			    <th class="ver01" width="5%" align="center"><input type="checkbox" id="all"/>全选</th>
				<th class="ver01" width="20%" align="center">配件名称</th>
				<th class="ver01" width="5%" align="center">最小库存量</th>
				<th class="ver01" width="5%" align="center">最大库存量</th>
				<th class="ver01" width="10%" align="center">所属大部件</th>
				<th class="ver01" width="25%" align="center">机车类型</th>
				<!-- 
			    <th class="ver01" width="10%" align="center">所属流程</th>
			     -->
				<th class="ver01" width="20%" align="center">操作</th>
			</tr>
			<c:if test="${!empty pm.datas}">
				<c:forEach items="${pm.datas}" var="pjs">
				   <tr>
				    <td class="ver01" align="center"><input type="checkbox" id="${pjs[0].pjsid}" name="pjIds" value="${pjs[0].pjsid}"/></td>
				    <td class="ver01" align="center"><a href="<%=basePath%>pjManageAction!dyPJListInput.do?pjName=${pjs[0].pjName}" target="frmright" style="color:blue;">${pjs[0].pjName}</a></td>
					<td class="ver01" align="center">${pjs[0].lowestStore}</td>
					<td class="ver01" align="center">${pjs[0].mostStore}</td>
					<td class="ver01" align="center">${pjs[0].firstUnit.firstunitname}</td>
					<td class="ver01" align="center">${fn:substring(pjs[0].jcType,1,fn:length(pjs[0].jcType)-1)}</td>
					<td class="ver01" align="center">
				      <a href="javascript:;" style="color:blue;" onclick="addPjDyInfo('${pjs[0].pjsid}');">添加待修配件</a>&nbsp;&nbsp;
				      <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',ZR,')}">
				     	<a href="javascript:;" style="color:blue;" onclick="updatePjStaticInfo(${pjs[0].pjsid});">修改</a>&nbsp;&nbsp;
				     	<a href="javascript:;" style="color:blue;" onclick="delPjStaticInfo(${pjs[0].pjsid});">删除</a>
				     </c:if>
					</td>
				  </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 <tr> <td class="ver01" align="center" colspan="8">没有相应的数据记录!</td></tr>
			 </c:if>
	</table>
 </div></form>
 
	<!-- 处理分页 -->
	<div style="height:35px;">
	总共${pm.count}条记录,每页显示10条记录
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
		<pg:pager maxPageItems="${pageSize }" url="pjManageAction!staticPJListInput.do" items="${pm.count}" export="page1=pageNumber">
		  <pg:param name="jcsType" value="${jcsType}"/>
		  <pg:param name="firstUnitId" value="${firstUnitId}"/>
		  <pg:param name="firstUnitName" value="${firstUnitName}"/>
		  <pg:param name="flowTypeId" value="${flowTypeId}"/>
		  <pg:param name="pjName" value="${urlName}"/>
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
		 <!-- 
		&nbsp;每页
		</div>
		<div class="float_left"><select autoWidth="true"><option>15</option><option>20</option><option>25</option></select></div>
		<div class="float_left padding_top4">条记录</div> -->
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
   <!-- 处理分页end -->
</body>
</html>
