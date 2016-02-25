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
    <title>检查项目</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/unfinished-item.js"></script>
	<style type="text/css">
		a{color: blue;}
	</style>
	<script type="text/javascript">
		//输入裂损情况
		function dealSituation(id){
			top.Dialog.open({URL:"<%=basePath%>fix/sign/pjts_ratify_dialog.jsp?role=worker&type=0&id="+id,Width:425,Height:300,Title:"裂损情况"});
		}
		
		//复探签字
		function reptSign(){
			var fixRecIds=[];
			var id;
			var flag = true;
			$("input[name='itemcheck']:checked").each(function(){
			   id = $(this)[0].value;
			   fixRecIds.push(id);
			   if($("#"+id+"_fixemp").val()==null || $("#"+id+"_fixemp").val()==""){
			   		flag = false;
			   		return false;
			   }
		   });
		   if(fixRecIds.length==0){
				top.Dialog.alert("请选择签认的项目!");
		   }else if(flag==false){
		   		top.Dialog.alert("项目主探还未签认!");
		   }else{
				var ids = ""+fixRecIds.join("-");
				$.post("<%=basePath%>partFixAction!reptPJFixRecSign.do",{"ids":ids},function(text){
					top.Dialog.alert("操作成功!",function(){
						window.location.reload();
					})
				});
			}
		}
	</script>
  </head>
  
  <body>
<div>
	<table>
		<tr>
			<td colspan="7">
				<c:choose>
					<c:when test="${tsflag==1}">
						<button id="sign_inspection"><span class="icon_edit">主探签名</span></button>
						<button id="allsign" onclick="reptSign();" ><span class="icon_edit">复探签名</span></button>
					</c:when>
					<c:otherwise><button id="sign_inspection"><span class="icon_edit">签认</span></button></c:otherwise>
				</c:choose>
				<span style="font-size:13px;font-weight:bold;">需要签认项目：<font color="red">${pageModel.count }</font>条，还有<font color="red">${signed}</font>条项目未签认</span>
				<input id="role_flag" type="hidden" value="${roleFlag}" />
			</td>
		</tr>
	</table>
	<table class="tableStyle" headFixMode="true" useMultColor="true" useCheckBox="true">
		<tr align="center">
			<th width="30px"></th>
			<th width="10%">配件名</th>
			<th width="10%">部位</th>
			<th width="25%">检修项目</th>
			<c:choose>
			<c:when test="${tsflag==1}">
				<th width="11%">探伤结果</th>
				<th width="12%">裂损情况</th>
				<th width="11%">主探</th>
				<th width="11%">复探</th>
			</c:when>
			<c:otherwise>
				<th width="10%">检修员</th>
				<th width="20%">组装配件编码</th>
				<th width="15%">检修情况</th>
			</c:otherwise>
		</c:choose>
			<th width="10%">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle"  useMultColor="true" useCheckBox="true">
		<c:forEach items="${pageModel.datas}" var="record">
			<tr align="center">
				<td width="30px">
					<c:choose>
						<c:when test="${record.preStatus==1}"></c:when>
						<c:otherwise>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,'))}">
								<c:choose>
									<c:when test="${empty record.pjFixItem.amount}">
										<c:choose>
											<c:when test="${empty record.lead }">
												<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${not empty record.pjFixItem.amount}">
										<c:choose>
											<c:when test="${empty record.lead && not empty record.pjNum}">
												<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>
							</c:if>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,'))}">
								<c:choose>
									<c:when test="${record.recstas!=2}"></c:when>
									<c:otherwise>
										<c:if test="${record.pjFixItem.itemctrllead==1 && empty record.lead}"> <!-- 工长需要检修，而还未签认 -->
											<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
									    </c:if>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',ZJY,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJY,'))}">
								<c:if test="${(record.pjFixItem.itemctrllead==1 && !empty record.lead)||(empty record.pjFixItem.itemctrllead || record.pjFixItem.itemctrllead==0)}">
									<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
								</c:if>
							</c:if>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',JSY,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,'))}">
								<c:if test="${(record.pjFixItem.itemctrllead==1 && !empty record.lead)||(empty record.pjFixItem.itemctrllead || record.pjFixItem.itemctrllead==0)}">
									<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
								</c:if>
							</c:if>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',JCGZ,'))}"><!-- 交车工长(1、工长需要签，且已经签认了，2、工长不需要签) -->
								<c:if test="${(record.pjFixItem.itemctrllead==1 && !empty record.lead)||(empty record.pjFixItem.itemctrllead || record.pjFixItem.itemctrllead==0)}">
									<c:choose>
										<c:when test="${record.pjFixItem.itemctrltech==1 && record.pjFixItem.itemctrlqi==1}"><!--技术质检都需要签 -->
											<c:if test="${!empty record.qiaffitime}">
												<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${record.pjFixItem.itemctrltech==1 || record.pjFixItem.itemctrlqi==1}">
													<c:if test="${!empty record.qiaffitime}">
															<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
													</c:if>
												</c:when>
												<c:otherwise><!-- 技术质检都不需要签 -->
														<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:if>
							
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',YSY,'))}"><!--验收员(工长、技术质检，交车工长签认)-->
								<c:if test="${(record.pjFixItem.itemctrllead==1 && !empty record.lead)||(empty record.pjFixItem.itemctrllead || record.pjFixItem.itemctrllead==0)}">
									<!--1、技术或质检要签，且签认了；2不要签-->
									<c:if test="${((record.pjFixItem.itemctrltech==1 || record.pjFixItem.itemctrlqi==1) && !empty record.qiaffitime) || ((empty record.pjFixItem.itemctrltech || record.pjFixItem.itemctrltech==0)&&(empty record.pjFixItem.itemctrlqi || record.pjFixItem.itemctrlqi==0))}">
										<!--1交工要签且签，2不要签 -->
										<c:if test="${(record.pjFixItem.itemctrlcomld==1 && !empty record.commitlead)||(empty record.pjFixItem.itemctrlcomld || record.pjFixItem.itemctrlcomld==0)}">
											<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
							
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">${record.pjname}</td>
				<td width="10%">${record.pjFixItem.posiName}</td>
				<td width="25%" style="white-space:normal;word-break:break-all;word-wrap:break-word;">${record.pjFixItem.fixItem}</td>
				<c:choose>
					<c:when test="${tsflag==1}">
							<td width="11%">${record.fixsituation}</td>
							<td width="12%">
								<c:if test="${empty record.dealSituaton}">
									<a href="javascript:void(0);" style="color:blue;" onclick="dealSituation('${record.pjRecId}')">输入裂损情况</a>
								</c:if>
								<c:if test="${!empty record.dealSituaton}">
									<a href="javascript:void(0);" style="color:blue;" onclick="dealSituation('${record.pjRecId}')">${record.dealSituaton}</a>
								</c:if>
							</td>
							<td width="11%">
								<input type="hidden" id="${record.pjRecId}_fixemp" value="${record.empaffirmtime}"/>
								<c:choose>
									<c:when test="${empty record.empaffirmtime}">
										<span style="color: red;">(待签)</span>
									</c:when>
									<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
								</c:choose>
							</td>
							<td width="11%">
								<c:choose>
									<c:when test="${empty record.reptAffirmTime && record.pjFixItem.itemctrlrept==1}">
										<span style="color: red;">(待签)</span>
									</c:when>
									<c:otherwise>${record.rept}<br/>${record.reptAffirmTime}</c:otherwise>
								</c:choose>
							</td>
					</c:when>
					<c:otherwise>
						<td width="10%">
							<c:choose>
								<c:when test="${empty record.empaffirmtime}">
									<span style="color: red;">(待签)</span>
								</c:when>
								<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
							</c:choose>
						</td>
						<td width="20%" name="pjNums" style="white-space:normal;word-break:break-all;word-wrap:break-word;">
							<c:choose>
								<c:when test="${empty record.pjFixItem.amount}">
									<span>/</span>
								</c:when>
								<c:when test="${empty record.pjNum}">
									<a href="javascript:void(0);" onclick="inputNumber(${record.pjRecId}, 1)">输入编码</a>
								</c:when>
								<c:otherwise>
									<!-- <font title="点击修改配件编码"><a href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${record.pjFixItem.fixItem}','${record.pjRecId}','${record.pjFixItem.amount }','${record.pjNum}');">${record.pjNum}</a></font> -->
								
								<font title="点击修改配件编码" id="update_pjnum"><a href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${record.pjRecId}',1,'${record.pjNum}');">${record.pjNum}</a></font>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="15%">${record.fixsituation}</td>
					</c:otherwise>
				</c:choose>
				<td width="10%">
					<c:choose>
						<c:when test="${record.preStatus==1}"><span style="color:red">已报活</span></c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="createPredict(${record.pjRecId})">报活</a>
						</c:otherwise>
					</c:choose>
					<!-- 
					<span class="img_edit hand" title="修改"></span>
					<span class="img_delete hand" title="删除"></span>
					 -->
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
		<pg:pager items="${pageModel.count}" url="partFixAction!toInspectionItem.do" maxPageItems="20" export="currentPageNumber=pageNumber">
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
<script type="text/javascript"><%--
    //修改配件编号 
	function pjNumUpdate(){
		
		var arg_length = arguments.length;
		var itemName = arguments[0];
		var pjRecId = arguments[1];
		var amount = arguments[2];
		var pJNum = "";
		for(var i=3; i < arg_length;i++){
			if(i != arg_length -1){
				pJNum += arguments[i]+",";
			}else{
				pJNum += arguments[i];
			}
		}
		top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>partFixAction!pjNumUpdateInput.do?pjRecId="+pjRecId+"&pJNum="+pJNum,Width:500,Height:400,ID:'frmDialog'});
	}
--%></script>
</html>
