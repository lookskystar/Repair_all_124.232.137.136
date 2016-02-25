<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>报活签认</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<!-- Ajax上传图片 -->
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->

	<!--文本截取start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--文本截取end-->
	<style type="text/css">
	*html{
	 background-image:url(about:blank);
	 background-attachment:fixed;
	 }
	 
	#sign1{
	 _position:absolute;
	 _bottom:auto;
	 _top:expression(eval(document.documentElement.scrollTop));
	 _margin-top:5px;
	 _margin-left:5px;
	 }
	 
	#allsign1{
	_position:absolute;
	_bottom:auto;
	_top:expression(eval(document.documentElement.scrollTop));
	_margin-top:5px;
	_margin-left:75px;
	}
	
	#print1{
	_position:absolute;
	_bottom:auto;
	_top:expression(eval(document.documentElement.scrollTop));
	_margin-top:5px;
	_margin-left:5px;
	}
	
	#newreport1{
	_position:absolute;
	_bottom:auto;
	_top:expression(eval(document.documentElement.scrollTop));
	_margin-top:5px;
	_margin-left:5px;
	}
	
	#sign2{
	 _position:absolute;
	 _bottom:auto;
	 _top:expression(eval(document.documentElement.scrollTop));
	 _margin-top:5px;
	 _margin-left:5px;
	 }
	
	#print2{
	_position:absolute;
	_bottom:auto;
	_top:expression(eval(document.documentElement.scrollTop));
	_margin-top:5px;
	_margin-left:5px;
	}
	
	#newreport2{
	_position:absolute;
	_bottom:auto;
	_top:expression(eval(document.documentElement.scrollTop));
	_margin-top:5px;
	_margin-left:5px;
	}
	</style>
	<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/print.js"></script>
	<script type="text/javascript">
		//报活
	function report(){
		var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id=${rjhmid }&type=${jctype }';
		diag.Width=1000;
		diag.Height=520;
		diag.show();
	}
	</script>
	<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/print.js"></script>
</head>
	<body>
		<input id="dateplan"  type="hidden" value="${rjhmid }" />
		<input id="jctype"  type="hidden" value="${jctype }" />
		<button id="sign1" style="position: fixed; left:5px; top: 5px;" onclick="leadReSign();"><span class="icon_ok">签认</span></button>
		<button id="print1" style="position: fixed; left:75px; top: 5px;" onclick="javascript:screenPrint();"><span class="icon_print">打印</span></button>
		<button id="newreport1" style="position: fixed; left:145px; top: 5px;" onclick="report();"><span class="icon_print">报活</span></button>
	
		<table width="100%" class="tableStyle" id="checkboxTable" useCheckBox="false" style="margin-top: 30px;">
		    <c:if test="${role=='worker'}">
		    <tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">我的报活项目<button anchor="nbz" id="bz">自选报活项目</button></td></tr>
		    </c:if>
			<tr align="center">
				<th class="ver01" width="25">
				
				</th>
				<th class="ver01">
					具体报活部位
				</th>
				<th class="ver01">
					故障情况
				</th>
				<th class="ver01">
					报活人
				</th>
				<th class="ver01">
					报活时间
				</th>
				<th class="ver01">
					类型
				</th>
				<th class="ver01">
					分工处理人
				</th>
				<th class="ver01">
					处理情况
				</th>
				<th class="ver01">
					检修人签字
				</th>
				<c:if test="${role!='worker'}">
					<th class="ver01">
						工长
					</th>
					<th class="ver01">
						技术员
					</th>
					<th class="ver01">
						质检员
					</th>
					<th class="ver01">
						交车工长
					</th>
					<th class="ver01">
						验收员
					</th>
				</c:if>
			</tr>
			<c:if test="${empty preDicts}">
				<c:choose>
					<c:when test="${role!='worker'}"><tr><td colspan="14" align="center">没有数据记录!</td></tr></c:when>
					<c:otherwise><tr><td colspan="9" align="center">没有数据记录!</td></tr></c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${!empty preDicts}">
				<c:forEach items="${preDicts}" var="entry">
					<tr align="center">
						<td class="ver01">
					    	<c:choose>
					        	<c:when test="${!empty entry.dealFixEmp}">
					            	<input type="checkbox" value="${entry.preDictId}" name="report_item"/>
					        	</c:when>
					    	</c:choose>
						</td>
						<td class="ver01">
							${entry.repPosi}
						</td>
						<td class="ver01">
							${entry.repsituation}
						</td>
						<td class="ver01">
							${entry.repemp}
						</td>
						<td class="ver01">
							${entry.repTime}
						</td>
						<td class="ver01">
							<c:if test="${entry.type==0}">
								JT28报活
							</c:if>
							<c:if test="${entry.type==1}">
								复检报活
							</c:if>
							<c:if test="${entry.type==2}">
								检修过程报活
							</c:if>
							<c:if test="${entry.type==6}">
								零公里报活
							</c:if>
						</td>
						<td class="ver01">
							${entry.fixEmp}
						</td>
						<td class="ver01">
							${entry.dealSituation}
							<c:if test="${empty entry.dealSituation}">
						    	<a style="color:blue;" href="javascript:void(0);" onclick="receiveWork(${entry.preDictId})">接活</a>
							</c:if>
						</td>
						<td class="ver01">
							<c:if test="${!empty entry.dealFixEmp}">
								${fn:substring(entry.dealFixEmp, 1, fn:length(entry.dealFixEmp)-1)}${entry.fixEndTime}
							</c:if>
						</td>
						<c:if test="${role!='worker'}">
							<td class="ver01">
							    <c:if test="${empty entry.lead}"><font color='red'>卡控待签</font></c:if>
								${entry.lead}${entry.ldAffirmTime}
							</td>
							<td class="ver01">
							    <c:if test="${entry.itemCtrlTech==1&&empty entry.technician}"><font color='red'>卡控待签</font></c:if>
								${entry.technician}${entry.techAffiTime}
							</td>
							<td class="ver01">
							    <c:if test="${entry.itemCtrlQI==1&&empty entry.qi}"><font color='red'>卡控待签</font></c:if>
								${entry.qi}${entry.qiAffiTime}
							</td>
							<td class="ver01">
							    <c:if test="${entry.itemCtrlComLd==1&&empty entry.commitLd}"><font color='red'>卡控待签</font></c:if>
								${entry.commitLd}${entry.comLdAffiTime}
							</td>
							<td class="ver01">
							    <c:if test="${entry.itemCtrlAcce==1&&empty entry.accepter}"><font color='red'>卡控待签</font></c:if>
								${entry.accepter}${entry.acceTime}
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</table>
			<%-- --%>
		 <c:if test="${role=='worker'}">
		    <table width="100%" class="tableStyle" id="checkboxTable" useCheckBox="false" style="margin-top: 30px;">
		    <%-- <tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">自选报活项目<button anchor="bz" id="nbz">我的报活项目</button></td></tr>--%>
		    	<tr align="center">
				<th class="ver01" width="25">
					
				</th>
				<th class="ver01">
					具体报活部位
				</th>
				<th class="ver01">
					故障情况
				</th>
				<th class="ver01">
					报活人
				</th>
				<th class="ver01">
					报活时间
				</th>
				<th class="ver01">
					类型
				</th>
				<th class="ver01">
					分工处理人
				</th>
				<th class="ver01">
					处理情况
				</th>
				<th class="ver01">
					检修人签字
				</th>
			</tr>
				<c:if test="${empty freePreDicts}">
					<tr><td colspan="9" align="center">没有报活记录!</td></tr>
				</c:if>
				<c:forEach items="${freePreDicts}" var="entry">
					<tr align="center">
						<td class="ver01">
						    <c:if test="${empty entry.lead}">
						   		 <input type="checkbox" value="${entry.preDictId}" name="report_item"/>
						    </c:if>
						</td>
						<td class="ver01">
							${entry.repPosi}
						</td>
						<td class="ver01">
							${entry.repsituation}
						</td>
						<td class="ver01">
							${entry.repemp}
						</td>
						<td class="ver01">
							${entry.repTime}
						</td>
						<td class="ver01">
							<c:if test="${entry.type==0}">
								JT28报活
							</c:if>
							<c:if test="${entry.type==1}">
								复检报活
							</c:if>
							<c:if test="${entry.type==2}">
								检修过程报活
							</c:if>
							<c:if test="${entry.type==6}">
								零公里报活
							</c:if>
						</td>
						<td class="ver01">
							${entry.fixEmp}
						</td>
						<td class="ver01">
							${entry.dealSituation}
						</td>
						<td class="ver01">
							<c:if test="${!empty entry.dealFixEmp}">
								${fn:substring(entry.dealFixEmp, 1, fn:length(entry.dealFixEmp)-1)}${entry.fixEndTime}
							</c:if>
						</td>
					</tr>
				</c:forEach>
		    </table>
		 </c:if>
		
		<script type="text/javascript">		
			 //工人接活
			function receiveWork(preDictId){
			      	var diag = new top.Dialog();
					diag.Title = "报活签认窗口";
					diag.URL = 'reportWorkManage!reportWorkItemReSignInput.action?params='+preDictId;
					diag.Width=350;
					diag.Height=200;
					diag.show();
			}

			//卡控签字
			function leadReSign(){
					var predictIds = "";
					var elements = document.getElementsByName("report_item");
					for(var i=0;i<elements.length;i++){
						if(elements[i].checked){
							predictIds += elements[i].value+",";
						}
					}
					if(predictIds == "" ){
						top.Dialog.alert("请勾选要签认的项目！");
					}else{
						top.Dialog.open({URL:"<%=basePath%>reportWorkManage!reportLeadItemReSignInput.action?params="+predictIds,Width:350,Height:200,Title:"报活签认窗口"});
					}
			}
		</script>
	</body>
</html>