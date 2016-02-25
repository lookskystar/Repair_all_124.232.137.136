<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>配件预领记录</title>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 表单验证 start -->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!-- 表单验证 end --> 
	<script type="text/javascript">
		//添加配件预领单
		function add(){
			var diag = new top.Dialog();
			diag.Title = "配件预领单";
			diag.URL = "pjManageAction!addvanceTipsAddInput.do";
			diag.Height=380;
			diag.MessageTitle="表单标题";
			diag.Message="配件预领单";
			diag.show();
		};

		function enSureDelete(){
			//判断是否一个未选
			var flag = false; 
			var items = [];
			$("input[name='item']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
					//将选中的值 添加到 array中
	    			items.push($(this).val());
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认删除？",function(){
		    		$.ajax({
						type:"post",
						url:"pjManageAction!addvanceTipsDelete.do",
						data:{"items":items.join(",")},
						success:function(result){
							if(result=="success"){
				    			top.Dialog.alert("信息删除成功！",function(){
						    			top.window.frmright.location.href="pjManageAction!addvanceTipsList.do";
					    			});
				    		}else{
				    			top.Dialog.alert("信息删除失败！");
				    		}
						}
					});
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条信息！");
		    }
		
		}

		function storeSign(id){
			//判断是否一个未选
			var flag = false; 
			var items = [];
			items.push(id);
			$("input[name='item']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
					//将选中的值 添加到 array中
	    			items.push($(this).val());
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认签章？",function(){
		    		$.ajax({
						type:"post",
						url:"pjManageAction!addvanceTipsStoreSign.do",
						data:{"items":items.join(",")},
						success:function(result){
							if(result=="success"){
				    			top.Dialog.alert("签章成功！",function(){
						    			top.window.frmright.location.href="pjManageAction!addvanceTipsList.do";
					    			});
				    		}else{
				    			top.Dialog.alert("签章失败！");
				    		}
						}
					});
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条信息！");
		    }
		}
	</script>	
</head>
<body>
	<div class="box2" panelTitle="配件预领单记录" roller="false">
		<form action="pjManageAction!addvanceTipsList.do" method="post">
		<table>
			<tr>
				<td>机车型号：
					<select name="getonnum">
						<option value="">请选择</option>
	                    <c:forEach var="jc" items="${jcsTypes}">
	                    	<option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==getonnum}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
	                    </c:forEach>
					</select>
				</td>
				<td>预领姓名：<input type="text" name="addvanceperson" value="${addvanceperson }"/></td>
			</tr>
			<tr>	
				<td>配件编号：<input type="text" name="pjnum" value="${pjnum }"/></td>
				<td>配件名称：<input type="text" name="pjname" value="${pjname }"/></td>
				<td>日期：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" name="addvancedate" value="${addvancedate }"/></td>
				<td><input type="submit" class="icon_find" value="查询" /></td>
			</tr>
			<c:if test="${session_user_proteam.py != 'PJKGL'}">
			<tr>
				<td colspan="7">
					<input type="button" onclick="add();" value="新建"/>
					<input type="button" onclick="add();" value="编辑"/>
					<input type="button" onclick="enSureDelete();" value="删除"/>
				</td>
			</tr>
			</c:if>
		</table>
		</form>
	</div>
	<div>
		<table class="tableStyle"  headFixMode="true" useMultColor="true" useCheckBox="true">
			<tr>
				<th width="5%"></th>
				<th width="15%"><span>配件名称</span></th>
				<th width="10%"><span>配件编号</span></th>
				<th width="10%"><span>装机车号</span></th>
				<th width="10%"><span>修程</span></th>
				<th width="10%"><span>预领数量</span></th>
				<th width="10%"><span>预领日期</span></th>
				<th width="10%"><span>预领签章</span></th>
				<th width="10%"><span>发件签章</span></th>
				<th width="10%"><span>状态</span></th>
			</tr>
		</table>
	</div>
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true" useCheckBox="true">
			<c:if test="${!empty pm}">
				<c:forEach items="${pm.datas}" var="item">
					<tr align="center">
						<td width="5%">
							<c:choose>
								<c:when test="${item.status < 2 && item.addvanceperson == session_user.xm}">
									<input type="checkbox"  name="item" value="${item.id }"/>
								</c:when>
							</c:choose>
						</td>
						<td width="15%">${item.pjname }</td>
						<td width="10%" title="${item.pjnum }">${fn:substring(item.pjnum,0,7)}</td>
						<td width="10%">${item.getonnum }</td>
						<td width="10%">${item.xcxc }</td>
						<td width="10%">${item.addvancenum }</td>
						<td width="10%">${item.addvancedate }</td>
						<td width="10%">${item.addvanceperson }</td>
						<td width="10%">
							<c:choose>
								<c:when test="${item.status == '1'}">
									<c:choose>
										<c:when test="${session_user_proteam.py == 'PJKGL'}">
											<span><input type="button" onclick="storeSign('${item.id}');" value="签章"/></span>
										</c:when>
										<c:otherwise>
											${item.deliveryperson }
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${item.deliveryperson }
								</c:otherwise>
							</c:choose>
						</td>
						<td width="10%">
							<c:choose>
								<c:when test="${item.status == '1'}">
									<font color="blue">预领</font>
								</c:when>
								<c:otherwise>
									<font style="color: #B14685">发件</font>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		</table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${pm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="pjManageAction!addvanceTipsList.do" items="${pm.count }" export="page1=pageNumber">
				<pg:param name="getonnum" value="${getonnum}"/>
				<pg:param name="pjname" value="${pjname}"/>
				<pg:param name="pjnum" value="${pjnum}"/>
				<pg:param name="addvanceperson" value="${addvanceperson}"/>
				<pg:param name="addvancedate" value="${addvancedate}"/>
		  		<pg:first>
					 <span><a href="${pageUrl }" id="first">首页</a></span>
		 		</pg:first>
		 		<pg:prev>
					  <span><a href="${pageUrl }">上一页</a></span>
		  		</pg:prev>
	  	  		<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber }">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
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
		</div>
		<div class="clear"></div>
	</div>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>
