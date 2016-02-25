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
		<base href="<%=basePath%>"/>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
		<script type="text/javascript" src="js/attention/floatPanel.js"></script>
		<script type="text/javascript" src="js/attention/messager.js"></script>
		<!--截取文字end-->
	    <script type="text/javascript">
		   $(function(){
		   	<c:if test="${!empty message}">
		   	top.Dialog.close();
				top.Dialog.alert('${message}');
		    </c:if>
		   });
		
		//添加项目
		function addItem(){
			top.Dialog.open({
				URL:"planManage!addJcItemInput.do",
				Width:950,
				Height:460,
				Title:"新增加改项目"
			});
		}
		//修改项目
			function editeItem(){
				var item = $("input[name='rad_jg']:checked").val();
				if(item != "" && item != undefined && item != null){
					var diag = new top.Dialog();
					diag.Title = "修改加改项目";
					diag.URL = 'planManage!editeJgItemInput.do?item='+item;
					diag.Width=600;
					diag.Height=320;
					diag.show();
				}else{
					top.Dialog.alert("请选择要编辑的加改项目！");
				}
			}
	
			//追加记录
		function addJC(item){
			var diag = new top.Dialog();
			diag.Title = "追加加改历史记录";
			diag.URL = "planManage!addJcInput.do?item="+item;
			diag.Width=700;
			diag.Height=420;
			diag.show();
		}
		
		//判断是否选中信息
		function enSureDelete(){
			//判断是否一个未选
			var flag; 
			//遍历所有的name为document的 checkbox 
			$("input[name='rad_jg']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认删除？",function(){
		    		toDelete();
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条机车信息！");
		    }
		
		}
	    
		//删除
		function toDelete() {
			//用于保存 选中的那一条数据的ID 
			var jgs = [];  
	    	$("input[name='rad_jg']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			jgs.push($(this).val());
	    		}
	    	}) 
	    	$.ajax({
				type:"post",
				async:false,
				url:"planManage!deleteJgItem.do",
				data:{"jgs":jgs.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("加改项目删除成功！",function(){
				    			top.window.frmright.location.href="planManage!jgEditeInput.do";
			    			});
		    		}else{
		    			top.Dialog.alert("加改项目删除失败！");
		    		}
				}
			})
		}
		//根据id修改加改项目
		function getval(jgid){
			var num =$("#"+jgid).val();
			$.post("planManage!editeJgItemById.do",{"jgid":jgid,"planNum":num},function(result){
				if(result=="success"){
					$.messager.lays(260, 200);
					$.messager.show('修改信息','<div style="overflow: auto;height:165px;"><ul>'+"修改成功"+'</ul></div>','stay');
				}else{
					$.messager.lays(260, 200);
					$.messager.show('修改信息','<div style="overflow: auto;height:165px;"><ul>'+"修改失败"+'</ul></div>','stay');
					}
				})
		}
	
		//查询详细列表
		function listJc(item,jctype){
			top.Dialog.open({
				URL:"planManage!listJc.do?itemName="+item+"&jctype="+jctype,
				Width:700,
				Height:420,
				Title:"加改机车列表"
			});
		}
	</script>
	</head>
	<body>
		<table class="tableStyle" headFixMode="true">
			<tr>
				<th align="left">
					<button onclick="addItem();"><span class="icon_page">新建项目</span></button>
					<button onclick="editeItem();"><span class="icon_edit">编辑项目</span></button>
				<!-- <button onclick="addJC();"><span class="icon_mark">追加记录</span></button>  -->	
					<button onclick="enSureDelete();"><span class="icon_delete">删除项目</span></button>
					<span style="color:red;font-size: 14px;">*要追加机车加改记录，请点击项目名。</span>	
				</th>
			</tr>
		</table>
		<table class="tableStyle" headFixMode="true">
			<tr>
				<th width="30%">加改项目/机车车型</th>
				<c:forEach items="${jcAcounts}" var="jc">
					<th width="5%">${jc[0] }</th>
			    </c:forEach>
				<th width="5%">合计</th>
			</tr>
			<tr>
				<th width="30%">配属台数</th>
				<c:set value="0" var="jcCount"/>
				<c:forEach items="${jcAcounts}" var="jc">
				    <c:set value="${jcCount+jc[1]}" var="jcCount"/>
					<th width="5%">${jc[1] }</th>
			    </c:forEach>
				<th width="5%">${jcCount }</th>
			</tr>
		</table>
		<table class="tableStyle"  useCheckBox="true" useColor="false" useHover="false" useClick="true" useCheckBox="true">
				<c:forEach items="${result}" var="map" varStatus="idx">
				<c:set var="count" value="0"/>
				<tr align="center">
					<td width="2%" rowspan="2">
					<input name="rad_jg" type="radio" value="${map.key}" id="rad_${idx.index }" style="display: none;"/>
					</td>
					<td rowspan="2" width="23%"><a href="javascript:addJC('${map.key}');"><span style="color:blue;">${map.key}</span></a></td>
					<td	width="5%">计划</td>
					<c:forEach items="${map.value}" var="plan">
						<c:set var="count" value="${count+plan.planNum}"/>
						<td	width="5%"><input type="text" value="${plan.planNum}" id="${plan.jgid }" onblur="getval(${plan.jgid })" style="width: 35px;" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
					</c:forEach>
					<td width="5%">${count}</td>
				</tr>
				<c:set var="count" value="0"/>
				<tr align="center">
					<td	width="5%">实际</td>
					<c:forEach items="${map.value}" var="plan">
						<c:set var="count" value="${count+plan.sjNum}"/>
						<c:choose>
							<c:when test="${plan.sjNum<plan.planNum}">
								<td	width="5%"><a href="javascript:listJc('${map.key }','${plan.jctype}');" style="color: #00f;font-weight: bold;">${plan.sjNum}</a></td>
							</c:when>
							<c:otherwise>
								<td	width="5%"><a href="javascript:listJc('${map.key }','${plan.jctype}');" style="color: #f00;font-weight: bold;">${plan.sjNum}</a></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<td width="5%"><a href="javascript:listJc('${map.key }','');" style="color: #00f;font-weight: bold;">${count}</a></td>
					<script type="text/javascript">
						<c:if test="${count==0}">
							$("#rad_${idx.index}").show();
						</c:if>
					</script>
				</tr>
			</c:forEach>
		</table>
		<div style="height: 40px;"></div>
	</body>
</html>
