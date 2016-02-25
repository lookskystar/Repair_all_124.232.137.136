<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
</head>

<body>
	<div class="box2" panelTitle="故障管理" roller="false">
		<table>
			<tr>
				<td>专业:</td>
				<td>
					<select id="yjbj" name="yjbj" onchange="getSecUnit()" class="default">
						 <option value="">请选择专业</option>
					    <c:if test="${!empty dictFirstUnitList}">
					    	<c:forEach items="${dictFirstUnitList}" var="entry">
					    		<option value="${entry}">${entry}</option>
					    	</c:forEach>
					    </c:if>
					</select>
				</td>
				<td>部位:</td>
				<td>
					<select id="ejbj" name="ejbj" onchange="getThirdUnit()" class="default">
						<option value="">请选择部位</option>
					</select>
				</td>
				<td>处所:</td>
				<td>
					<select id="sjbj" name="sjbj" class="default">
						<option value="">请选择处所</option>
					</select>
				</td>
				<td>关键词：</td>
				<td><input type="text" id="keys" name="keys"/></td>
				<td><button id="queryCondition"><span class="icon_find">查询</span></button></td>
			</tr>
			<tr>
				<td colspan="7">
					<button id="add"><span class="icon_page">增加</span></button>&nbsp;
					<button id="edite"><span class="icon_edit">编辑</span></button>&nbsp;
					<button id="delete"><span class="icon_delete">删除</span></button>&nbsp;
				</td>
			</tr>
		</table>
	</div>
<div>
	<table class="tableStyle" useMultColor="true" useCheckBox="true">
		<tr>
			<th width="25" align="center"></th>
			<th width="50" align="center"><span>故障ID</span></th>
			<th width="50" align="center"><span>专业</span></th>
			<th width="70" align="center"><span>部位</span></th>
			<th width="100" align="center"><span>处所</span></th>
			<th width="250" align="center"><span>故障内容</span></th>
			<th width="50" align="center"><span>故障评分</span></th>
			<th width="40" align="center">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent">
	<table class="tableStyle"  useMultColor="true" useCheckBox="true" id="dictTable">
		<c:if test="${!empty dictFailureList}">
	    	<c:forEach items="${dictFailureList}" var="dictFailure">
	    		<tr>
					<td width="25" align="center"><input id="dictId" name="dict" type="checkbox" value="${dictFailure.id }"/></td>
					<td width="50" align="center"><span>${dictFailure.id }</span></td>
					<td width="50" align="center"><span>${dictFailure.firstUnitName }</span></td>
					<td width="70" align="center"><span>${dictFailure.secUnitName }</span></td>
					<td width="100" align="center"><span>${dictFailure.thirdUnitName }</span></td>
					<td width="250" align="center"><span>${dictFailure.content }</span></td>
					<td width="50" align="center"><span>${dictFailure.score }</span></td>
					<td width="40" align="center"><span class="img_edit hand" title="修改" onclick="edite(${dictFailure.id });"></span><span class="img_delete hand" title="删除" onclick="deletes(${dictFailure.id });"></span></td>
				</tr>
	    	</c:forEach>
	    </c:if>
	</table>
</div>


<div style="height:150px;">
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<span class="paging_current"><a id="pageAll">共${page.last}页</a></span>
			<span><a id="prePage">上一页</a></span>
			<span class="paging_current"><a id="pageNow">${page.num}</a></span>
			<span><a id="nextPage">下一页</a></span>
		</div>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
<input type="hidden" id="pageFirst" value="${page.first}"/>
<input type="hidden" id="pageLast" value="${page.last}"/>
<input type="hidden" id="pageNum" value="${page.num}"/>			
<script type="text/javascript">
$(document).ready(function(){
	var pageNum = $("#pageNum").val();
	var pageFirst = $("#pageFirst").val();
	var pageLast = $("#pageLast").val();
	if(parseInt(pageNum) <= parseInt(pageFirst) ){
		$("#prePage").parent().attr('class','paging_disabled');	
	}
	if(parseInt(pageNum) >= parseInt(pageLast) ){
		$("#nextPage").parent().attr('class','paging_disabled');	
	}
	
	//接受Dialog处理结果
	top.Dialog.close();
	<c:if test="${!empty message}">
		top.Dialog.alert('${message}');
	</c:if>
	
	//上一页
	$('#prePage').bind('click', function(){
		//获取条件
		var yjbj=$("#yjbj").val();
		var ejbj=$("#ejbj").val();
		var sjbj=$("#sjbj").val();
		var keys=$("#keys").val();
		//页面设置
		var numNow = $("#pageNum").val();
		var num = parseInt(numNow) - parseInt(1);
		$.post("<%=basePath%>reportWorkManage!ajaxDictFailureList.do",{"num":num,"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"keys":keys},
			function(data){
		        var result=eval("("+data+")");
		        var num = result.num;
		       	var pageLast = result.pageLast;
	       		var pageFirst = result.pageFirst;
		        if(parseInt(num) >= parseInt(pageFirst)){
			        $("#pageNum").val(num);
			        $("#pageNow").html(num);
			        if(parseInt(num) < parseInt(pageLast) ){
						$("#nextPage").parent().removeAttr('class');	
					}
					if(parseInt(num) <= parseInt(pageFirst) ){
						$("#prePage").parent().attr('class','paging_disabled');	
					}
			        var datas=result.datas;
			        var str="";
			        if(datas.length>0){
			            for(var i=0;i<datas.length;i++){
			            	str+="<tr>"
			            			+"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value='"+datas[i].dictId+"'/></td>"
									+"<td width='50' align='center'><span>"+datas[i].dictId+"</span></td>"
									+"<td width='50' align='center'><span>"+datas[i].dictYjbj+"</span></td>"
									+"<td width='70' align='center'><span>"+datas[i].dictEjbj+"</span></td>"
									+"<td width='100' align='center'><span>"+datas[i].dictSjbj+"</span></td>"
									+"<td width='250' align='center'><span>"+datas[i].dictContent+"</span></td>"
									+"<td width='50' align='center'><span>"+datas[i].score+"</span></td>"
									+"<td width='40' align='center'></span><span class='img_edit hand' title='修改' onclick='edite("+datas[i].dictId+");'></span><span class='img_delete hand' title='删除' onclick='deletes("+datas[i].dictId+");'></span></td>"
								+"</tr>"
			            }
			        }else{
			            str+="<tr><td>没有数据记录!</td></tr>";
			        }
			        $("#dictTable").html(str);
		        }else{
		        	return;
		        }
		    }
		);
	});
	
	//下一页
	$('#nextPage').bind('click', function(){
		//获取条件
		var yjbj=$("#yjbj").val();
		var ejbj=$("#ejbj").val();
		var sjbj=$("#sjbj").val();
		var keys=$("#keys").val();
		//页面设置
		var numNow = $("#pageNum").val();
		var num = parseInt(numNow)+ parseInt(1);
		$.post("<%=basePath%>reportWorkManage!ajaxDictFailureList.do",{"num":num,"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"keys":keys},
			function(data){
		        var result=eval("("+data+")");
		        var num = result.num;
		       	var pageLast = result.pageLast;
	       		var pageFirst = result.pageFirst;
		        if(parseInt(num) <= parseInt(pageLast) ){
		        	$("#pageNum").val(num);
		       		$("#pageNow").html(num);
		       		if(parseInt(num) > parseInt(pageFirst) ){
						$("#prePage").parent().removeAttr('class');	
					}
					if(parseInt(num) >= parseInt(pageLast) ){
						$("#nextPage").parent().attr('class','paging_disabled');	
					}
			        var datas=result.datas;
			        var str="";
			        if(datas.length>0){
			            for(var i=0;i<datas.length;i++){
			            	str+="<tr>"
			            			+"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value='"+datas[i].dictId+"'/></td>"
									+"<td width='50' align='center'><span>"+datas[i].dictId+"</span></td>"
									+"<td width='50' align='center'><span>"+datas[i].dictYjbj+"</span></td>"
									+"<td width='70' align='center'><span>"+datas[i].dictEjbj+"</span></td>"
									+"<td width='100' align='center'><span>"+datas[i].dictSjbj+"</span></td>"
									+"<td width='250' align='center'><span>"+datas[i].dictContent+"</span></td>"
									+"<td width='50' align='center'><span>"+datas[i].score+"</span></td>"
									+"<td width='40' align='center'></span><span class='img_edit hand' title='修改' onclick='edite("+datas[i].dictId+");'></span><span class='img_delete hand' title='删除' onclick='deletes("+datas[i].dictId+");'></span></td>"
								+"</tr>"
			            }
			        }else{
			            str+="<tr><td>没有数据记录!</td></tr>";
			        }
		        	$("#dictTable").html(str);
				}else{
					return;
				}
		    }
		);
	});
	
	//添加
	$('#add').bind('click', function(){
		var diag = new top.Dialog();
		diag.Title = "故障添加窗口";
		diag.URL = 'reportWorkManage!dictFailureAddInput.action';
		diag.Width=400;
		diag.Height=300;
		diag.show();
	});
	
	//删除
	$("#delete").bind('click',function () {
		var yjbj=$("#yjbj").val();
		var ejbj=$("#ejbj").val();
		var sjbj=$("#sjbj").val();
		var keys=$("#keys").val();
		//当前页码
		var num = $("#pageNum").val();
		//用于保存 选中的那一条数据的ID 
		var dicts = "";  
		//判断是否一个未选
		var flag; 
		//遍历所有的name为dict的 checkbox 
		$("input[name='dict']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })  
	    if (flag) {  
	    	$("input[name='dict']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			dicts = dicts + "," + $(this).val();
	    		 	//$(this).closest('tr').remove();
	    		}
	    	}) 
	    	$.ajax({
				type:"post",
				async:false,
				url:"reportWorkManage!dictFailureDelete.action",
				data:{"dicts":dicts},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("故障删除成功！");
		    			$.post("<%=basePath%>reportWorkManage!ajaxDictFailureList.do",{"num":num,"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"keys":keys},
							function(data){
						        var result=eval("("+data+")");
						        var datas=result.datas;
						        var str="";
						        if(datas.length>0){
						            for(var i=0;i<datas.length;i++){
						            	str+="<tr>"
						            			+"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value='"+datas[i].dictId+"'/></td>"
												+"<td width='50' align='center'><span>"+datas[i].dictId+"</span></td>"
												+"<td width='50' align='center'><span>"+datas[i].dictYjbj+"</span></td>"
												+"<td width='70' align='center'><span>"+datas[i].dictEjbj+"</span></td>"
												+"<td width='100' align='center'><span>"+datas[i].dictSjbj+"</span></td>"
												+"<td width='250' align='center'><span>"+datas[i].dictContent+"</span></td>"
												+"<td width='50' align='center'><span>"+datas[i].score+"</span></td>"
												+"<td width='40' align='center'></span><span class='img_edit hand' title='修改' onclick='edite("+datas[i].dictId+");'></span><span class='img_delete hand' title='删除' onclick='deletes("+datas[i].dictId+");'></span></td>"
											+"</tr>"
						            }
						        }else{
						            str+="<tr><td>没有数据记录!</td></tr>";
						        }
						        $("#dictTable").html(str);
						    }
						);
		    		}else{
		    			top.Dialog.alert("故障删除失败！");
		    		}
				}
			})
	    }else {
	    	top.Dialog.alert("请至少选择一个故障！");
	    }
	});
	
	//编辑
	$('#edite').bind('click', function(){
		//当前页码
		var num = $("#pageNum").val();
		var dictId = $("input[name='dict']:checked").val();
		if(dictId != "" && dictId != undefined && dictId != null){
			var diag = new top.Dialog();
			diag.Title = "故障编辑窗口";
			diag.URL = 'reportWorkManage!dictFailureEditeInput.action?dictId='+dictId+"&num="+num;
			diag.Width=400;
			diag.Height=350;
			diag.show();
		}else{
			top.Dialog.alert("请选择要编辑的故障！");
		}
		
	});
	
	//条件查询
	$('#queryCondition').bind('click', function(){
		var yjbj=$("#yjbj").val();
		var ejbj=$("#ejbj").val();
		var sjbj=$("#sjbj").val();
		var keys=$("#keys").val();
		$.post("<%=basePath%>reportWorkManage!ajaxDictFailureList.do",{"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"keys":keys},
			function(data){
		        var result=eval("("+data+")");
		        var num = result.num;
		        var pageLast = result.pageLast;
		        $("#pageNum").val(num);
		        $("#pageNow").html(num)
		        $("#pageAll").html("共"+pageLast+"页");
		        var datas=result.datas;
		        var str="";
		        if(datas.length>0){
		            for(var i=0;i<datas.length;i++){
		            	str+="<tr>"
		            			+"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value='"+datas[i].dictId+"'/></td>"
								+"<td width='50' align='center'><span>"+datas[i].dictId+"</span></td>"
								+"<td width='50' align='center'><span>"+datas[i].dictYjbj+"</span></td>"
								+"<td width='70' align='center'><span>"+datas[i].dictEjbj+"</span></td>"
								+"<td width='100' align='center'><span>"+datas[i].dictSjbj+"</span></td>"
								+"<td width='250' align='center'><span>"+datas[i].dictContent+"</span></td>"
								+"<td width='50' align='center'><span>"+datas[i].score+"</span></td>"
								+"<td width='40' align='center'></span><span class='img_edit hand' title='修改' onclick='edite("+datas[i].dictId+");'></span><span class='img_delete hand' title='删除' onclick='deletes("+datas[i].dictId+");'></span></td>"
							+"</tr>"
		            }
		        }else{
		            str+="<tr><td>没有数据记录!</td></tr>";
		        }
		        $("#dictTable").html(str);
		    }
		);
	});
})

function edite(dictId){
	//当前页码
	var num = $("#pageNum").val();
	if(dictId != "" && dictId != undefined && dictId != null){
		var diag = new top.Dialog();
		diag.Title = "故障编辑窗口";
		diag.URL = 'reportWorkManage!dictFailureEditeInput.action?dictId='+dictId+"&num="+num;
		diag.Width=400;
		diag.Height=350;
		diag.show();
	}else{
		top.Dialog.alert("请选择要编辑的故障！");
	}
}

function deletes(dictId){
	var yjbj=$("#yjbj").val();
	var ejbj=$("#ejbj").val();
	var sjbj=$("#sjbj").val();
	var keys=$("#keys").val();
	//当前页码
	var num = $("#pageNum").val();
	var dicts = "," + dictId ;
	$.ajax({
		type:"post",
		async:false,
		url:"reportWorkManage!dictFailureDelete.action",
		data:{"dicts":dicts},
		success:function(result){
			if(result=="success"){
    			top.Dialog.alert("故障删除成功！");
    			$.post("<%=basePath%>reportWorkManage!ajaxDictFailureList.do",{"num":num,"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"keys":keys},
					function(data){
				        var result=eval("("+data+")");
				        var datas=result.datas;
				        var str="";
				        if(datas.length>0){
				            for(var i=0;i<datas.length;i++){
				            	str+="<tr>"
				            			+"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value='"+datas[i].dictId+"'/></td>"
										+"<td width='50' align='center'><span>"+datas[i].dictId+"</span></td>"
										+"<td width='50' align='center'><span>"+datas[i].dictYjbj+"</span></td>"
										+"<td width='70' align='center'><span>"+datas[i].dictEjbj+"</span></td>"
										+"<td width='100' align='center'><span>"+datas[i].dictSjbj+"</span></td>"
										+"<td width='250' align='center'><span>"+datas[i].dictContent+"</span></td>"
										+"<td width='50' align='center'><span>"+datas[i].score+"</span></td>"
										+"<td width='40' align='center'></span><span class='img_edit hand' title='修改' onclick='edite("+datas[i].dictId+");'></span><span class='img_delete hand' title='删除' onclick='deletes("+datas[i].dictId+");'></span></td>"
									+"</tr>"
				            }
				        }else{
				            str+="<tr><td>没有数据记录!</td></tr>";
				        }
				        $("#dictTable").html(str);
				    }
				);
    		}else{
    			top.Dialog.alert("故障删除失败！");
    		}
		}
	})
}

//根据一级部件获取二级部件
function getSecUnit() {
	var firstunitid=$("#yjbj").val();
	var ejbj ;
	if(firstunitid!=''){
		$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":firstunitid,"type":0},function(data){
			var map=eval("("+data+")");
			var result=map['unit'];
			var ejbj = "<option value=''>请选择部位</option>";
			for(var i=0;i<result.length;i++){
				if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
					ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
				}
		    }
			$('#ejbj').html(ejbj);
		});
	}
}

//根据二级部件获取三级部件
function getThirdUnit(){
	var first=$("#yjbj").val();
	var second=$("#ejbj").val();
	if(first!='' && second!=''){
		$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":first,"second":second,"type":1},function(data){
			var map=eval("("+data+")");
			var result=map['unit'];
			var ejbj = "<option value=''>请选择处所</option>";
			for(var i=0;i<result.length;i++){
				if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
					ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
				}
		    }
			$('#sjbj').html(ejbj);
		});
	}
}

</script>			
</body> 
</html>
