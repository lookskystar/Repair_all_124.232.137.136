<%@ page contentType="text/html; charset=UTF-8" language="java"
import="java.sql.*" errorPage=""%>
<%@include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<base href="<%=basePath%>report/">
		<!-- 制动 小辅修 流程 -->
		<title>${dpp.jcType }${dpp.jcnum }机车秋季整治检查评分表</title>
		<link href="<%=basePath%>css/test.css" type="text/css" rel="stylesheet" />
		<link href="<%=basePath%>css/linkcss.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/attention/messager.js"></script>
		
		
		<style type="text/css">
			#nav, #nav ul {
				margin: 0;
				padding: 0;
				list-style-type: none;
				list-style-position: outside;
				position: relative;
				line-height: 1.5em;
			}
			#nav a {
				display: block;
				padding: 0px 5px;
				border: 1px solid #333;
				color: #fff;
				font-weight: bold;
				text-decoration: none;
				background-color: #328aa4;
			}
			#nav a:link {
				background-color: #328aa4;
			}
			/*#nav a:visited{
            background-color:#fff;
            color:blue;
            }*/
			
			#nav a:hover {
				background-color: #fff;
				color: red;
			}
			#nav li {
				float: left;
				position: relative;
			}
			#nav ul {
				position: absolute;
				display: none;
				width: 12em;
				top: 1.5em;
			}
			#nav li ul a {
				width: 12em;
				height: auto;
				float: left;
			}
			#nav ul ul {
				top: auto;
			}
			#nav li ul ul {
				left: 12em;
				margin: 0px 0 0 10px;
			}
			#nav li:hover ul ul,
			#nav li:hover ul ul ul,
			#nav li:hover ul ul ul ul {
				display: none;
			}
			#nav li:hover ul,
			#nav li li:hover ul,
			#nav li li li:hover ul,
			#nav li li li li:hover ul {
				display: block;
			}
		</style>
		

		<script type="text/javascript">
			$(function() {
				$("input[name='score']").blur(function() {
					if (this.value == "") {
						return;
					}
					var value = this.value;
					var obj = this;
					var preDictId = $($(this).parent().prevAll()[3].innerHTML).val();
					$.post("qz!ajaxGradeZeroPreDict.do", {
							"preDictId": preDictId,
							"score": this.value
						},
						function(data) {
							$.messager.show(0, data);
							if (data == "操作成功") {
								var points = parseFloat($("#points").text()) + parseFloat(value);
								$("#points").text(points);
								$("#score").text(1000 - points);
								$(obj).parent().html(value);
								if (1000 - points < 850) {
									$("#result").html("<font color='red'>分数低于850，请按照机务处要求进行重修</font>");
								} else {
									$("#result").html("<font color='red'>机车质量合格</font>");
								}
							}
						}
					)
				})
				
				
			})
			function sign(){
				if(!confirm("确定要签认吗？")){
					return;
				}
				
				$.post("qz!signJcQzZlPd.do",{"rjhmId":$("#rjhmId").val()},function(data){
					$.messager.show(0, data);
					if(data == "操作成功"){
						window.location.reload();
					}else if(data == "请先登录"){
						window.location.href="<%=basePath%>";
					}
				});
			}
		</script>
	</head>

	<body bgcolor="#f8f7f7">
		<!-- 浮动导航菜单start -->

		<br>
		<br>
		<!-- 浮动导航菜单end -->
		<form id="form1" name="form1" method="post" action="">
			<div style="width:870px;margin-left:-425px;left:50%;position:absolute;" id="content2">
				<table width="864" border="0" align="center" cellspacing="0" vspace="0" style="padding-top:10px;">
					<tr>
						<td colspan="6" align="center" height="40">
							<h2 align="center"><font style="font-family:'隶书'"> <b>机车秋季整治检查评分表</b> </font></h2>
						</td>
						<td align="right"></td>
					</tr>
					<tr>
						<td>车型：${dpp.jcType }<input type="hidden" id="rjhmId" value="${dpp.rjhmId }"/></td>
						<td>车号：${dpp.jcnum }</td>
					</tr>
					<tr>
						<td colspan="6">
							<table width="900" border="0" align="center" cellspacing="0" vspace="0" id="content" id="content">
								<tr>
									<td align="center" colspan="3" class="tbCELL3">
										<!-- 2015-5-19    黄亮 添加行内样式style="font-size:10pt;"，设置导出Execl字体大小，Execl字体大小必须是行内样式 -->
										<table width="900" border="0" align="center" cellspacing="0" vspace="0" id="datatabel" style="font-size:10pt;">
											<tr style="line-height:40px;height:30px;background-color: #328aa4;font-weight: bolder;">
												<td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="5%">序号</td>
												<td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;; min-width" width="60%">零公里报活情况</td>
												<td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="20%">专业</td>
												<td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="15%">扣分</td>

											</tr>
											<c:forEach items="${zeroPreDictList}" var="zero" varStatus="zeroStatus">
											<tr style="line-height:30px;height:30px;">
												<input type="hidden" value="${zero.preDictId}">
												<td class="tbCELL1" align="center">${zeroStatus.index+1 } </td>
												<td class="tbCELL1" align="center">${zero.repsituation } </td>

												<td class="tbCELL1" align="center">
													${zero.repPosi }
												</td>

												<c:forEach items="${zero.zeroScoreSet }" var="zeroScore">
													<c:set var="score" value="${zeroScore.score }"></c:set>
												</c:forEach>
												<c:set var="totalScore" value="${totalScore+score }"></c:set>
												<td class="tbCELL1" align="center">
													
													<c:if test="${empty score}">
														<input type="text" name="score" value="${score }" />
													</c:if>
													<c:if test="${not empty score}">${score }</c:if>
												
													
												</td>
												<c:remove var="score"></c:remove>
											</tr>
											</c:forEach>
											<tr >
												<td class="tbCELL1" align="center" colspan="4" height="35px"></td>
											</tr>
											<tr style="line-height:30px;height:30px;">
												<td class="tbCELL1" align="center" colspan="4">总扣分：<font color="red"><span id="points">${totalScore}</span></font>分</td>
											</tr>
											<tr style="line-height:30px;height:30px;">
												<td class="tbCELL1" align="center" colspan="4">总得分：<font color="red"><span id=score>${1000-totalScore }</span></font>分</td>
											</tr>
											<tr style="line-height:30px;height:30px;">
												<td class="tbCELL1" align="center" colspan="4">评定：
													<span id="result">
														<font color="red">
														<c:if test="${1000-totalScore < 850 }">分数低于850，请按照机务处要求进行重修</c:if>
														<c:if test="${1000-totalScore >= 850 }">机车质量合格</c:if>
														</font>
													</span>
												</td>
											</tr>
											<tr style="line-height:30px;height:30px;">
												<td class="tbCELL1" align="center" colspan="4">
													签认人：
													<c:if test='${fn:length(dpp.jcQzZlPdSet) == 0 && dpp.fixFreque == "QZ"}'>
														<input type="button" onclick="sign()" value="点击签认"/>
													</c:if>
													<c:if test='${fn:length(dpp.jcQzZlPdSet) > 0 && dpp.fixFreque == "QZ"}'>
														<c:forEach items="${dpp.jcQzZlPdSet }" var="z">
															<font color="red">${z.signUsers.xm }</font>
														</c:forEach>
													</c:if>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>

</html>