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
	$(function(){
		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	    </c:if>
	});
   //根据机车类型得到一级部件信息
   function getFirstUnit(){
	   var jcsType=$("#jcsType").val();
	   if(jcsType!=""){
		   $.post("<%=basePath%>fixItemAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
               var result=eval("("+data+")");
               var firstUnits=result.firstUnits;
               var str="<option value=''>请选择大部件</option>";
               for(var i=0;i<firstUnits.length;i++){
                   str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
               }
               $("#first").children().remove();
               $("#first").append(str);
           });
		   $("#second").children().remove();
           $("#second").append("<option value=''>请选择二级部件</option>");
	   }
   }

    //得到项目详情信息
    function getItemInfo(itemId){
    	top.Dialog.open({URL:"<%=basePath%>fixItemAction!zxitemInfo.do?itemId="+itemId,Width:600,Height:450,Title:"查看项目详情"});
    }

    //添加项目
    function addItem(){
    	var diag = new top.Dialog();
    	diag.Title = "项目添加";
    	diag.URL = "<%=basePath%>fixItemAction!addZxItemInput.do";
    	diag.Width=650;
    	diag.Height=600;
    	diag.show();
    }

    //进入项目修改页面
    function editItemInfo(itemId){
    	top.Dialog.open({URL:"<%=basePath%>fixItemAction!editzxItemInput.do?itemId="+itemId,Width:650,Height:600,Title:"项目修改"});
    }

    //删除项目
    function deleteItemInfo(itemId){
    	top.Dialog.confirm("确认删除吗？",function(){
    		$.post("fixItemAction!deleteZxItemInfo.do",{"zxitemId":itemId},function(result){
            	if(result=="success"){
        			top.Dialog.alert("项目删除成功！",function(){
    	    			window.location.href="<%=basePath%>fixItemAction!zxFixItemList.do";
        			});
        		}else{
        			top.Dialog.alert("项目删除失败！");
        		}
            });
        });
    }
    
    //判断是否选中信息
	function enSureDelete(){
		//判断是否一个未选
		var flag; 
		//遍历所有的name为document的 checkbox 
		$("input[name='item']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })
	    if (flag) {  
	    	top.Dialog.confirm("确认删除？",function(){
	    		deleteItem();
	    	});
	    }else {
	    	top.Dialog.alert("请至少选择一条项目信息！");
	    }
	
	}

    //删除
    function deleteItem(){
		//用于保存 选中的那一条数据的ID 
		var items = [];  
    	$("input[name='item']").each(function() { 
    		if ($(this).attr("checked")) { 
    			//将选中的值 添加到 array中
    			items.push($(this).val());
    		}
    	}) 
    	$.ajax({
			type:"post",
			async:false,
			url:"fixItemAction!deleteZxItemInfo.do",
			data:{"zxitemId":items.join(",")},
			success:function(result){
				if(result=="success"){
	    			top.Dialog.alert("项目删除成功！",function(){
	    				window.location.href="<%=basePath%>fixItemAction!zxFixItemList.do";
		    		});
	    		}else{
	    			top.Dialog.alert("项目删除失败！");
	    		}
			}
		})
     }
</script>
</head>
<body>
	<form id="form" action="fixItemAction!zxFixItemList.do" method="post">
	<div class="box2">
		<table>
			<tr>
				<td>
					机车型号：
	                <select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
	                    <option value="">请选择机车型号</option>
	                    <c:forEach var="jc" items="${jcsTypes}">
	                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
	                    </c:forEach>
	               	</select>
	            </td>
	            <td>
	            	大&nbsp;&nbsp;部&nbsp;&nbsp;件：
	                <select id="first" class="default" name="first">
	                    <option value="">请选择大部件</option>
	                </select>
	            </td>
	        </tr>
	        <tr>
	            <td>
	            	检修班组：
	                <select id="teamId" class="default" name="teamId">
	                    <option value="">请选择班组</option>
	                    <c:forEach var="team" items="${proTeams}">
	                        <option value="${team.proteamid}" <c:if test="${team.proteamid==teamId}">selected="selected"</c:if>>${team.proteamname }</option>
	                    </c:forEach>
	           		</select>&nbsp;&nbsp;
	            </td>
	            <td>
	            	项目类型：
	                <select class="default" name="itemType">
	                    <option value="0">请选择项目类型</option>
	                    <option value="1" >检查项目</option>
	                    <option value="2" >检测项目</option>
	           		</select>&nbsp;&nbsp;
	            </td>
	            <td>
	        		<input type="text" watermark="输入项目名称" name="itemName" value="${itemName }"/>&nbsp;&nbsp;&nbsp;<input type="submit" value="查询"/>
	        	</td>
	        </tr>
	        <tr>
	        	<td>
	        		<input type="button" value="添加" onclick="addItem();"/> &nbsp;&nbsp;&nbsp;
			        <input type="button" value="删除" onclick='enSureDelete();'/>
		       </td>
       		</tr>
       </table>
	</div>
	<div>
		<table width="100%" class="tableStyle" useCheckBox="true">
			<tr>
				<th width="2%" align="center"></th>
				<th width="8%" align="center"><span>车型</span></th>
		      	<th width="8%" align="center"><span>大部件</span></th>
		      	<th width="8%" align="center"><span>节点</span></th>
		      	<th width="10%" align="center"><span>部位名称</span></th> 
		      	<th width="30%" align="center"><span>项目名称</span></th>
		      	<th width="6%" align="center"><span>检修时长</span></th>
		      	<th width="8%" align="center"><span>班组</span></th>
		      	<th width="20%" align="center">操作</th>
			</tr>
			<c:if test="${!empty pm.datas}">
				<c:forEach items="${pm.datas}" var="item">
				   <tr>
				    <td width="2%" align="center"><input name="item" value="${item.id}" type="checkbox" id="${item.id}"/></td>
				    <td width="10%" align="center">${fn:substring(item.jcsType,0,fn:length(item.jcsType)-1)}</td>
				    <td width="10%" align="center">${item.unitName}</td>
				    <td width="8%" align="center">
                        <c:if test="${item.nodeId.jcFlowId==100}">机车分解</c:if>
				        <c:if test="${item.nodeId.jcFlowId==101}">车上组装</c:if>
				    </td>
				    <td width="10%" align="center">${item.posiName}</td>
					<td width="30%" align="left">
						<span title="${item.itemName}">
							${fn:substring(item.itemName,0,20)}...
						</span>
					</td>
					<td width="10%" align="center">${item.duration}&nbsp;&nbsp;分钟</td>
					<td width="10%" align="center">${item.bzId.proteamname}</td>
					<td width="20%" align="center">
					     <a href="javascript:;" style="color:blue;" onclick="getItemInfo(${item.id});">查看</a>&nbsp;&nbsp;
					     <a href="javascript:;" style="color:blue;" onclick="editItemInfo(${item.id});">修改</a>&nbsp;&nbsp;
					     <a href="javascript:;" style="color:blue;" onclick="deleteItemInfo(${item.id});">删除</a>
					</td>
				  </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
				<tr> <td class="ver01" align="center" colspan="10">没有相应的数据记录!</td></tr>
			</c:if>
		</table>
 	</div>
	<!-- 处理分页 -->
	<div style="height:35px;">
		<div class="float_right padding5 paging">
			<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="fixItemAction!zxFixItemList.do" items="${pm.count}" export="page1=pageNumber">
			  	<pg:param name="jcsType" value="${jcsType}"/>
			  	<pg:param name="first" value="${first}"/>
			  	<pg:param name="teamId" value="${teamId}"/>
			  	<pg:param name="itemName" value="${itemName}"/>
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
				<div class="clear"></div>
			</div>
		</div>
	</div>
	</form>
</body>
</html>
