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
  </head>
  
  <body>
<div>
	<table>
		<tr>
			<td colspan="7">
				<button id="sign_inspection"><span class="icon_edit">项目签认</span></button>
				<button id="sign_detectItem"><span class="icon_edit">卡控全签</span></button>
				<span style="font-size:13px;font-weight:bold;">需要卡控签认项目：<font color="red">${pageModel.count }</font>条，还有<font color="red">${signed }</font>条项目未签认</span>
				<input id="role_flag" type="hidden" value="${roleFlag}" />
				<input id="pjDid" type="hidden" value="${pjdid }"/>
			</td>
		</tr>
	</table>
	<table class="tableStyle" headFixMode="true" useMultColor="true" useCheckBox="true">
		<tr align="center">
			<th width="20px"></th>
			<th width="10%">配件名</th>
			<th width="5%">部位</th>
			<th width="10%">检修项目</th>
			<th width="10%">检修/探伤员</th>
			<th width="10%">检修/探伤情况</th>
			<th width="10%">组装配件编号</th>
			<th width="10%">工长</th>
			<th width="10%">技术/质检员</th>
			<th width="10%">交车工长</th>
			<th width="10%">验收员</th>
			<th width="5%">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle"  useMultColor="true" useCheckBox="true">
		<c:forEach items="${pageModel.datas}" var="record">
			<tr align="center">
				<td width="20px">
					<c:choose>
						<c:when test="${record.preStatus==1}"></c:when>
						<c:otherwise>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,'))}">
								<c:if test="${empty record.fixemp}"><input type="checkbox" name="itemcheck" value="${record.pjRecId}"/></c:if>
							</c:if>
							<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,'))}">
								<c:choose>
									<c:when test="${empty record.pjFixItem.amount}">
										<c:choose>
											<c:when test="${record.pjFixItem.itemctrllead==1 && (empty record.fixemp|| empty record.lead)}">
												<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${not empty record.pjFixItem.amount}">
										<c:choose>
											<c:when test="${record.pjFixItem.itemctrllead==1 && (empty record.fixemp|| empty record.lead) && not empty record.pjNum }">
												<input type="checkbox" name="itemcheck" value="${record.pjRecId}"/>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:when>
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
				<td width="5%">${record.pjFixItem.posiName}</td>
				<td width="10%">${record.pjFixItem.fixItem}</td>
				<td width="10%">
					<c:choose>
						<c:when test="${tsbzid==record.teams}">
							<c:if test="${empty record.fixemp}"><font color="#ff0000">待签(主探)</font></c:if>
							<c:if test="${!empty record.fixemp}">
								<a href="javascript:void(0);" style="color:blue;" title="主探:${record.fixemp} <fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/>">
									${record.fixemp}(主探)
								</a>
							</c:if><br/>
							<c:if test="${empty record.rept && record.pjFixItem.itemctrlrept==1}"><font color="#ff0000">待签(复探)</font></c:if>
							<c:if test="${!empty record.rept}">
								<a href="javascript:void(0);" style="color:blue;" title="复探:${record.rept} ${record.reptAffirmTime}">
									${record.rept}(复探)
								</a>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty record.empaffirmtime}">
									<span style="color: red;">(待签)</span>
								</c:when>
								<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${tsbzid==record.teams}">
							<a href="javascript:void(0);" title="探伤结果：${record.fixsituation}<br/>裂损情况：${record.dealSituaton}" style="color: blue;">
								${record.fixsituation}<br/>${record.dealSituaton}
							</a>
						</c:when>
						<c:otherwise>${record.fixsituation}</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${empty record.pjFixItem.amount}">
							<span>/</span>
						</c:when>
						<c:when test="${empty record.pjNum}">
							<a href="javascript:void(0);" onclick="inputNumber(${record.pjRecId},1)" style="color: blue;">输入编码</a>
						</c:when>
						<c:otherwise>
							<!-- <font title="点击修改配件编码" id="update_pjnum"><a href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${record.pjFixItem.fixItem}','${record.pjRecId}','${record.pjFixItem.amount }',1,'${record.pjNum}');">${record.pjNum}</a></font> -->
							<font title="点击修改配件编码" id="update_pjnum"><a href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${record.pjRecId}',1,'${record.pjNum}');">${record.pjNum}</a></font>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<c:if test="${record.pjFixItem.itemctrllead==1}">
						<c:choose>
							<c:when test="${empty record.ldaffirmtime}">
								<span style="color: red;">(待签)</span>
							</c:when>
							<c:otherwise>${record.lead}<br/><fmt:formatDate value="${record.ldaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="10%">
					<c:if test="${record.pjFixItem.itemctrltech==1 || record.pjFixItem.itemctrlqi==1}">
						<c:choose>
							<c:when test="${empty record.qiaffitime}">
								<span style="color: red;">
									<c:if test="${record.pjFixItem.itemctrltech==1 && record.pjFixItem.itemctrlqi==1}">
									</c:if>
									<c:choose>
										<c:when test="${record.pjFixItem.itemctrltech==1 && record.pjFixItem.itemctrlqi==1}">
											技术/质检待签
										</c:when>
										<c:otherwise>
											<c:if test="${record.pjFixItem.itemctrltech==1}">技术待签</c:if>
											<c:if test="${record.pjFixItem.itemctrlqi==1}">质检待签</c:if>
										</c:otherwise>
									</c:choose>
								</span>
							</c:when>
							<c:otherwise>${record.qi}<br/><fmt:formatDate value="${record.qiaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="10%">
					<c:if test="${record.pjFixItem.itemctrlcomld==1}">
						<c:choose>
							<c:when test="${!empty record.commitlead}">${record.commitlead}<br/><fmt:formatDate value="${record.comldaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:when>
							<c:otherwise><span style="color: red;">待签</span></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="10%">
					<c:if test="${record.pjFixItem.itemctrlacce==1}">
						<c:choose>
							<c:when test="${!empty record.accepter}">${record.accepter}<br/><fmt:formatDate value="${record.acceaffitime}" pattern="yyyy-MM-dd HH:mm"/></c:when>
							<c:otherwise><span style="color: red;">待签</span></c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td width="5%">
					<c:choose>
						<c:when test="${record.preStatus==1}"><span style="color:red">已报活</span></c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="createPredict(${record.pjRecId})">报活</a>
						</c:otherwise>
					</c:choose>
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
<script type="text/javascript">
    $(document).ready(function(){
    	$("#sign_detectItem").bind('click',function(){
    		var pjDid = $("#pjDid").val();
    		$.post("partFixAction!signAllDetectItem.do",{"pjDid":pjDid,"flag":1},function(data){
    		    if("success" == data){
    		    	top.Dialog.alert("签认成功！");
    		    	window.location.reload();
    		    }else if("noItem" == data){
    		    	top.Dialog.alert("没有可签项目！");
    		    }else if("havefixemp" == data){
    		    	top.Dialog.alert("项目未完全签认！");
    		    }else{
    		    	top.Dialog.alert("签认失败！");
    		    }
    		})
    	})
    })
   <%-- 
    //修改配件编号 
	function pjNumUpdate(){
		var arg_length = arguments.length;
		var itemName = arguments[0];
		var pjRecId = arguments[1];
		var amount = arguments[2];
		var type = arguments[3];
		var pJNum = "";
		for(var i=4; i < arg_length;i++){
			if(i != arg_length -1){
				pJNum += arguments[i]+",";
			}else{
				pJNum += arguments[i];
			}
		}
		top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>partFixAction!pjNumUpdateInput.do?pjRecId="+pjRecId+"&pJNum="+pJNum+"&type="+type,Width:500,Height:400,ID:'frmDialog'});
	}
--%></script>
</html>
