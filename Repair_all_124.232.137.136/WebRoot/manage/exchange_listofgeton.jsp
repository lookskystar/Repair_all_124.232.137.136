<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>上下车班组互换配件</title>
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
		//添加互换配件交接单
		function add(){
			var diag = new top.Dialog();
			diag.Title = "互换配件交接单";
			diag.URL = "pjManageAction!exchangeTipsAddInput.do";
			diag.Height=380;
			diag.MessageTitle="表单标题";
			diag.Message="互换配件交接单";
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
						url:"pjManageAction!exchangeTipsDelete.do",
						data:{"items":items.join(",")},
						success:function(result){
							if(result=="success"){
				    			top.Dialog.alert("信息删除成功！",function(){
						    			top.window.frmright.location.href="pjManageAction!exchangeTipsList.do";
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

		function fixSign(id){
			//判断是否一个未选
			var flag = false; 
			var items = [];
			items.push(id);
	    	top.Dialog.confirm("确认签章？",function(){
	    		$.ajax({
					type:"post",
					url:"pjManageAction!exchangeTipsFixSign.do",
					data:{"items":items.join(",")},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("签章成功！",function(){
					    			top.window.frmright.location.href="pjManageAction!exchangeTipsList.do";
				    			});
			    		}else{
			    			top.Dialog.alert("签章失败！");
			    		}
					}
				});
	    	});
		}

		function storeSign(obj, id){
			var diag = new top.Dialog();
			diag.Title = "互换配件交接单";
			diag.URL = "pjManageAction!exchangeTipsOfStore.do?id="+id;
			diag.Width=900;
			diag.Height=480;
			diag.MessageTitle="表单标题";
			diag.Message="互换配件交接单";
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定";
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var formElements = doc.getElementById("manage_exchange_tipofstore_form");
				var access = $(formElements).validationEngine({returnIsValid:true});
				if(access){
					$.ajax({
					   	type: "POST",
					   	url: "pjManageAction!exchangeTipsAdd.do",
					   	data: $(formElements).serialize(),
					   	success: function(msg){
							if(msg == "success"){
								top.Dialog.alert("签章成功！");
								top.window.frmright.location = 'pjManageAction!exchangeTipsList.do';	
								diag.close();											
							}else {
								top.Dialog.alert("签章失败！");
								diag.close();
							}		   	
					   	}
					});
				}else {
					top.Dialog.alert("请将信息填写完整！");
				}
			}
			diag.show();
		}
	</script>	
</head>
<body>
	<div class="box2" panelTitle="互换配件交接单记录" roller="false">
		<form id="manage_exchange_listofgeton_form" action="pjManageAction!exchangeTipsList.do" method="post">
			<table>
				<tr>
					<td>承修班组：
						<select colNum="3" id="fixproteam" name="fixproteam">
						    <option value="">请选择</option>
							<c:if test="${!empty dictProTeams}">
			    	        	<c:forEach var="entry" items="${dictProTeams}">
				    	           <option value="${entry.proteamname}" <c:if test="${entry.proteamname == fixproteam}">selected="selected"</c:if>>${entry.proteamname}</option>
				    	        </c:forEach>
				    	        <option value="0">交车组</option>
			    	        </c:if>
						</select>
					</td>
					<td>车型：
						<select id="getoffnum" name="getoffnum">
							<option value="">请选择</option>
		                    <c:forEach var="jc" items="${jcsTypes}">
		                    	<option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==getoffnum}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
		                    </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>配件名称：
					<input type="text" id="pjname" name="pjname" value="${pjname }"/></td>
					<td>日期：
					<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" id="deliverydate" name="deliverydate"/></td>
					<td><input type="submit" class="icon_find" value="查询"/></td>
				</tr>
				<c:if test="${session_user_proteam.py != 'PJKGL'}">
				<tr>
					<td colspan="7">
						<input type="button" onclick="add();" value="新建"/>
						<input type="button" onclick="" value="编辑"/>
						<input type="button" onclick="enSureDelete();" value="删除"/>
					</td>
				</tr>
				</c:if>
			</table>
		</form>
	</div>
	<div>
		<table class="tableStyle"  headFixMode="true" useMultColor="true">
			<tr>
				<th colspan="8">交旧信息</th>
				<th colspan="2">承修信息</th>
				<th colspan="8">发件信息</th>
			</tr>
			<tr>
				<th width="4%"></th>
				<th width="6%"><span>配件名称</span></th>
				
				<th width="6%"><span>配件编号</span></th>
				<th width="6%"><span>拆下车号</span></th>
				<th width="5%"><span>修程</span></th>
				<th width="5%"><span>交旧数量</span></th>
				<th width="6%"><span>交旧日期</span></th>
				<th width="6%"><span>交旧签章</span></th>
				
				<th width="6%"><span>承修班组</span></th>
				<th width="6%"><span>承修签章</span></th>
				
				<th width="6%"><span>配件编号</span></th>
				<th width="6%"><span>上机车号</span></th>
				<th width="5%"><span>领取数量</span></th>
				<th width="6%"><span>领取日期</span></th>
				<th width="6%"><span>发件签章</span></th>
				<th width="6%"><span>状态</span></th>
				<th><span>备注</span></th>
			</tr>
		</table>
	</div>
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true" useCheckBox="true">
			<c:if test="${!empty pm}">
				<c:forEach items="${pm.datas}" var="item">
					<tr align="center">
						<td width="4%">
							<c:choose>
								<c:when test="${item.status < 2 && item.deliveryperson == session_user.xm}">
									<input type="checkbox"  name="item" value="${item.id }"/>
								</c:when>
							</c:choose>
						</td>
						<td width="6%">${item.pjname }</td>
						<td width="6%" title="${item.oldpjnum }">${fn:substring(item.oldpjnum,0,7)}</td>
						<td width="6%">${item.getoffnum }</td>
						<td width="5%">${item.xcxc }</td>
						<td width="5%">${item.deliverynum }</td>
						<td width="6%">${item.deliverydate }</td>
						<td width="6%">${item.deliveryperson }</td>
						
						<td width="6%">${item.fixproteam }</td>
						<td width="6%">
							<c:choose>
								<c:when test="${item.status == 1}">
									<c:choose>
										<c:when test="${session_user_proteam.proteamname == item.fixproteam}">
											<span><input type="button" onclick="fixSign('${item.id}');" value="签章"/></span>
										</c:when>
										<c:otherwise>
											${item.fixperson }
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${item.fixperson }
								</c:otherwise>
							</c:choose>
						</td>
						<td width="6%" title="${item.receivepjnum }">${fn:substring(item.receivepjnum,0,7)}</td>
						<td width="6%">${item.getonnum }</td>
						<td width="5%">${item.receivenum }</td>
						<td width="6%">${item.receivedate }</td>
						<td width="6%">
							<c:choose>
								<c:when test="${item.status == 2}">
									<c:choose>
										<c:when test="${session_user_proteam.py == 'PJKGL'}">
											<span><input type="button" onclick="storeSign(this,'${item.id}');" value="签章"/></span>
										</c:when>
										<c:otherwise>
											${item.receiveperson }
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${item.receiveperson }
								</c:otherwise>
							</c:choose>
						</td>
						<td width="6%">
							<c:choose>
								<c:when test="${item.status == 1 }">
									<font style="color: blue;">交旧</font>
								</c:when>
								<c:when test="${item.status == 2 }">
									<font style="color: #CD4900">承修</font>
								</c:when>
								<c:when test="${item.status == 3 }">
									<font style="color: #B14685">发件</font>
								</c:when>
							</c:choose>
						</td>	
						<td></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="17">没有相应的数据记录!</td>
			 	</tr>
			</c:if>
		</table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${pm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="pjManageAction!exchangeTipsList.do" items="${pm.count}" export="page1=pageNumber">
				<pg:param name="getoffnum" value="${getoffnum}"/>
				<pg:param name="fixproteam" value="${fixproteam}"/>
				<pg:param name="deliverydate" value="${deliverydate}"/>
				<pg:param name="pjname" value="${pjname}"/>
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
