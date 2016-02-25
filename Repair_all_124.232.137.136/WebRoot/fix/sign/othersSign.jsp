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
    <title>其他角色签认（除工人外）</title>
    
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
					<button id="sign_item"><span class="icon_edit">签认</span></button>
					<input id="role_flag" type="hidden" value="${roleFlag}" />
				</td>
			</tr>
	</table>
	<table class="tableStyle" headFixMode="true" useMultColor="true" useCheckBox="true">
		<tr align="center">
			<th width="8%"></th>
			<th width="10%">配件名</th>
			<th width="10%">检修项目</th>
			<th width="10%">检修员</th>
			<th width="12%"><span>检修情况</span></th>
			<th width="10%">工长</th>
			<th width="10%">技术/质检员</th>
			<th width="10%">交车工长</th>
			<th width="10%">验收员</th>
			<th width="10%">操作</th>
		</tr>
	</table>
</div>
<div id="scrollContent" >
	<table class="tableStyle"  useMultColor="true" useCheckBox="true">
		<c:if test="${empty pageModel.datas}">
			<tr>
				<td colspan="10" align="center" style="font-size: 14px;color: red;">当前没有您需要签认的项目！</td>
			</tr>
		</c:if>
		<c:if test="${!empty pageModel.datas}">
			<c:forEach items="${pageModel.datas}" var="record">
				<tr align="center">
					<td width="8%">
						<c:choose>
							<c:when test="${record.preStatus==1}"></c:when>
							<c:otherwise>
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
									${record.fixemp}<span style="color: red;">(待签)</span>
								</c:when>
								<c:otherwise>${record.fixemp}<br/><fmt:formatDate value="${record.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					</td>
					<td width="12%">
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
					<td width="10%">
						<c:choose>
							<c:when test="${record.preStatus==1}"><span style="color:red">已报活</span></c:when>
							<c:otherwise>
								<a href="javascript:void(0);" onclick="createPredict(${record.pjRecId})">报活</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>

<div style="height:35px;">
	<div class="float_left padding5">
		<c:if test="${!empty pageModel.datas}">
			共有信息${pageModel.count }条,每页显示${pageSize}条记录。 
		</c:if>
	</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager items="${pageModel.count}" url="partFixAction!toSignItem.do" maxPageItems="20" export="currentPageNumber=pageNumber">
				<pg:param name="flag" value="${roleFlag}"/>
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
		</div>
	</div>
</div>
	<div class="clear"></div>
  </body>
</html>
