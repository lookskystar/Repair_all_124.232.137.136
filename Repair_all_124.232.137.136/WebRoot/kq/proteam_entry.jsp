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
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
	<script type="text/javascript" src="js/json2.js"></script> 
	<script type="text/javascript">
	$(function(){
	   	top.Dialog.close();
	 		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
	});
	
	//保存计划
	function savePlan(){
		if(existNull("score")){
			top.Dialog.alert("工时得分不能为空!");
		}else{
			var JSONObj = getJSONObject();
			$.ajax({
				type:"POST",
				url:"proteamEntryAction!saveProteamEntry.do",
				data:JSONObj,
				dataType:"text",
				success:function(data){
					if(data=="success"){
						top.Dialog.alert("工时录入成功!");
					}else{
						top.Dialog.alert("工时录入失败!");
					}
				}
			});
		}
	}
 
	//封装JSON数组对象
	function getJSONObject(){
		var riqi = $("#riqi").val();
		var xmArray = getArrayByName("xm");
		var gonghaoArray = getArrayByName("gonghao");
		var contentArray = getArrayByName("content");
		var scoreArray = getArrayByName("score");
		var noteArray = getArrayByName("note");
		
		var objArray = [];
		var obj = null;
		var JSONObj = new Object();
		for(var i=0;i<xmArray.length;i++){
			obj = new Object();
            obj.xm = xmArray[i];
            obj.time = riqi;
            obj.gonghao = gonghaoArray[i];
            obj.content = contentArray[i];
            obj.score = scoreArray[i];
            obj.note = noteArray[i];
			objArray.push(obj);
		}
		JSONObj.jsonStr=JSON.stringify(objArray);
		return JSONObj;
	}

	//根据相应的标签名称得到里面的值的集合数组
	function getArrayByName(inputName){
		var array=[];
		$("input[name='"+inputName+"']").each(function(){
			array.push($(this).val());
		});
		return array;
	}

	//判断不能为空
	function existNull(inputName){
		var array=[];
		var flag=false;
		$("input[name='"+inputName+"']").each(function(){
			if($(this).val()!=""){
				array.push($(this).val());
			}
		});
		var len=$("input[name='"+inputName+"']").length;
		if(len!=array.length){
			flag=true;
		}
		return flag;
	}
	
	//Excel导入
    function uploadExcel(){
		var diag = new top.Dialog();
		diag.Title = "Excel文件导入";
	    diag.URL = "<%=basePath%>proteamEntryAction!uploadExcelInput.do";
	    diag.Width=400;
	    diag.Height=150;
	    diag.show();
    }
    
    //判断所选日期是否有记录
    function checkRecord(){
    	var riqi = $("#riqi").val();
    	$.ajax({
			type:"POST",
			url:"proteamEntryAction!checkRecord.do",
			data:"riqi="+riqi,
			success:function(data){
				if(data=="success"){
					savePlan();
				}else{
					top.Dialog.alert("所选日期已经存在记录!");
				}
			}
		});
    }

    //查询记录
    function searchRecord(){
    	var ri = $("#riqi").val();
    	window.location.href = "proteamEntryAction!proteamEntryInput.do?riqi="+ri;
    }

    //工时结转
    function transfer(){
    	var ri = $("#riqi").val();
    	$.ajax({
			type:"POST",
			url:"proteamEntryAction!checkRecord.do",
			data:"riqi="+ri,
			success:function(data){
				if(data=="failure"){
					window.location.href = "proteamEntryAction!transfer.do?riqi="+ri;
				}else{
					top.Dialog.alert("对不起，当天不存在记录信息!");
				}
			}
		});
    }

    //工时结转询问
    function checkTrans(){
    	top.Dialog.confirm("工时结转后无法回退，确认继续结转吗？",function(){transfer();});
    }
    
  	//修改
  	function updateRecord(id,rowId){
		var content = $("#"+rowId+"content").val();
		var score = $("#"+rowId+"score").val();
		alert(score);
		var note = $("#"+rowId+"note").val();
		$.ajax({
			type:"POST",
			url:"proteamEntryAction!updateRecord.do",
			data:"id="+id+"&content="+content+"&score="+score+"&note="+note,
			success:function(data){
				if(data=="success"){
					$.messager.show(0, '修改成功!', 2000);
				}else{
					top.Dialog.alert("已结转，无法修改!");
				}
			}
		});
  	}
	</script>
</head>
<body>
<div class="box2" panelTitle="工时管理" roller="false">
		<table>
			<tr>
				<td>日期：</td>
				<td><input type="text" id="riqi" value="${riqi}" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/></td>
				<td><button onclick="searchRecord();"><span class="icon_find">查询</span></button></td>
				<td><button onclick="uploadExcel();"><span class="icon_xls">Excel导入</span></button></td>
				<td><a href="<%=basePath%>kq/workTimeCount_temp.xls" style="color:blue;">Excel模板下载</a></td>
			</tr>
		</table>
	</div>
<div id="editTable">
	<div>
		<table class="tableStyle">
			<tr>
				<td colspan="10">
				    <c:if test="${empty workRecords}">
						<button onclick="checkRecord();"><span class="icon_save">保存</span></button>&nbsp;
				    </c:if>
				    <c:if test="${!empty workRecords}">
						<c:if test="${count==0}">
							<font color="red">已结转</font>
						</c:if>
						<c:if test="${count!=0}">
							<button onclick="checkTrans();"><span class="icon_edit">工时结转</span></button>&nbsp;
						</c:if>
				    </c:if>
				    <c:if test="${!empty users}">
				    	<button onclick="transfer();"><span class="icon_edit">工时结转</span></button>&nbsp;
				    </c:if>
				</td>
			</tr>
			<tr>
				<th width="25" align="center">序号</th>
				<th width="80" align="center">姓名</th>
				<th width="80" align="center">工号</th>
				<th width="300" align="center">工作内容</th>
				<th width="100" align="center">工时得分</th>
				<th>备注</th>
			</tr>
		</table>
	</div>
	<div>
		<table class="tableStyle">
		<c:if test="${!empty users}">
		<c:forEach items="${users}" var="user" varStatus="num">
			<tr>
				<td width="25" align="center">${num.count}</td>
				<td width="80" align="center">${user.xm}<input type="hidden" value="${user.xm}" name="xm"/></td>
				<td width="80" align="center">${user.gonghao}<input type="hidden" value="${user.gonghao}" name="gonghao"/></td>
				<td width="300" align="center"><input type="text" style="width:90%" name="content" /></td>
				<td width="100" align="center"><input type="text" style="width:90%" name="score" value="0"  onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
				<td><input type="text" name="note" style="width:90%;"/></td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${!empty workRecords}">
		<c:forEach items="${workRecords}" var="record" varStatus="num">
			<tr>
				<td width="25" align="center">${num.count}<input type="hidden" value="${record.id}"/></td>
				<td width="80" align="center">${record.name}<input type="hidden" value="${record.name}" name="xm"/></td>
				<td width="80" align="center">${record.gonghao}<input type="hidden" value="${record.gonghao}" name="gonghao"/></td>
				<td width="300" align="center">
					<c:if test="${record.status==0}">
						<input type="text" style="width:90%" value="${record.workContent}" name="content" id="${num.count}content" onchange="updateRecord(${record.id},${num.count});"/>
					</c:if>
					<c:if test="${record.status==1}">${record.workContent}</c:if>
				</td>
				<td width="100" align="center">
					<c:if test="${record.status==0}">
						<input type="text" style="width:90%" value="${record.workScore}" onblur="updateRecord(${record.id},${num.count});" name="score" id="${num.count}score" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</c:if>
					<c:if test="${record.status==1}">${record.workScore}</c:if>
				</td>
				<td align="center">
					<c:if test="${record.status==0}">
						<input type="text" value="${record.workNote}" name="note" style="width:90%;" onchange="updateRecord(${record.id},${num.count});" id="${num.count}note"/>
					</c:if>
					<c:if test="${record.status==1}">${record.workNote}</c:if>
				</td>
			</tr>
		</c:forEach>
		</c:if>
		</table>
	</div>
	<div style="height:40px;"></div>
</div>
</body>
<link href="<%=basePath %>js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</html>