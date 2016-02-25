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
	<base href="<%=basePath%>" />
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
		
		<!--sign2:过程报活签认  -->
		<c:choose>
			<c:when test="${flag == 1}">
			   <!-- 
			    <c:if test="${role=='foreman'}">
			      <button id="receive" style="position: fixed; left:5px; top: 5px;"><span class="icon_ok">接活</span></button>
			    </c:if> -->
				<button id="sign1" style="position: fixed; left:5px; top: 5px;"><span class="icon_ok">签认</span></button>
				<!-- <button id="allsign1" style="position: fixed; left:75px; top: 5px;"><span class="icon_ok">全签</span></button>  -->
				<button id="print1" style="position: fixed; left:75px; top: 5px;" onclick="javascript:screenPrint();"><span class="icon_print">打印</span></button>
				<button id="newreport1" style="position: fixed; left:145px; top: 5px;" onclick="report();"><span class="icon_print">报活</span></button>
			</c:when>
			<c:otherwise>
				<button id="sign2" style="position: fixed; left:5px; top: 5px;"><span class="icon_ok">签认</span></button>
				<button id="print2" style="position: fixed; left:75px; top: 5px;" onclick="javascript:screenPrint();"><span class="icon_print">打印</span></button>
				<button id="newreport2" style="position: fixed; left:145px; top: 5px;" onclick="report();"><span class="icon_print">报活</span></button>
			</c:otherwise>
		</c:choose>
	
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
						   <c:if test="${role!='worker'}">
						     <c:choose>
						       <c:when test="${!empty entry.dealFixEmp}">
						          <input type="checkbox" value="${entry.preDictId}" name="report_item"/>
						       </c:when>
						     </c:choose>
						   </c:if>
						   <c:if test="${role=='worker'}">
						       <input type="checkbox" value="${entry.preDictId}" name="report_item"/>
						   </c:if>
						</td>
						<td class="ver01">
							${entry.repPosi}
						</td>
						<td class="ver01">
							<a href="javascript:;" style="color:blue" onclick="return jtPreDictDatils(${entry.preDictId})">${entry.repsituation}</a>
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
							<!-- 2015-05-29,宁佐锌，修改工长显示配件编号，开始-->
							<c:if test="${empty entry.upPjNum}">${entry.dealSituation}</c:if>
				 				<c:if test="${!empty entry.upPjNum}">${entry.dealSituation}<br/>
				    				<c:forTokens items="${entry.upPjNum }" delims="," var="num">
				      				<a href="query!findPjRecordByPjNum.do?rjhmId=${entry.datePlanPri.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num}</a>
				    			</c:forTokens>
				  			</c:if>
							<!-- 2015-05-29,宁佐锌，修改工长显示配件编号，结束-->
							<c:if test="${empty entry.dealSituation}">
								  <c:if test="${role=='foreman'}">
						           <a style="color:blue;" href="javascript:void(0);" onclick="receiveWork(${entry.preDictId})">接活</a>
						         </c:if>
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
							<a href="javascript:;" style="color:blue" onclick="return jtPreDictDatils(${entry.preDictId})">${entry.repsituation}</a>
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
						<!-- 2015-05-22,黄亮，修改，如果是"更换良好"，显示更换配件编码 -->
						<td class="ver01">
							<c:choose>
								<c:when test="${entry.dealSituation=='更换良好' && empty entry.upPjNum}">
									<input id="rjhmId"  type="hidden" value="${entry.datePlanPri.rjhmId}" />
									${entry.dealSituation} <br />
									<a href="javascript:pjNumInputWith('${entry.repsituation}','${entry.preDictId}');" style="color: blue;">更换配件编码</a>
								</c:when>
								<c:otherwise>
									${entry.dealSituation} <br />
									<a href="javascript:pjNumUpdate('${entry.repsituation}','${entry.preDictId}','${entry.upPjNum }');" style="color: blue;">${entry.upPjNum }</a>
								</c:otherwise>
							</c:choose>
						
							
							
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
			$(function() {
				$('#sign2').bind('click', function() {
					var works = [];
					$("input[name='report_item']:checked").each(function() {
						works.push($(this).val());
					})
					if (works.length>0) {
						var diag = new top.Dialog();
						diag.Title = "报活签认窗口";
						diag.URL = 'reportWorkManage!reportWorkItemSignInput.action?id=${id}&role=${role}&type=1&params='+works.join('-');
						diag.Width=350;
						diag.Height=200;
						diag.show();
					} else {
						top.Dialog.alert("请选择签认的报活项目！");
					}
				});
				
				$('#sign1').bind('click', function() {
					var works = [];
					$("input[name='report_item']:checked").each(function() {
						works.push($(this).val());
					})
					if (works.length>0) {
						$.post("reportWorkManage!reportWorkItemSignConfirm.action",
							{"id":"${id}","type":1,"role":"${role}","params":works.join('-')},
							function(text){
								if(text=="login_failure"){
									top.Dialog.alert("不存在该用户!");
								}else if(text=="noprivilege_failure"){
									top.Dialog.alert("没有可签项目或不是该用户的分工项目!");
								}else{
										top.Dialog.alert("签名成功!",function(){
							    	    top.Dialog.close();
									});
								}
							}
						);
						//var diag = new top.Dialog();
						//diag.Title = "报活签认窗口";
						//diag.URL = 'reportWorkManage!reportWorkItemSignInput.action?id=${id}&role=${role}&type=1&params='+works.join('-');
						//diag.Width=350;
						//diag.Height=200;
						//diag.show();
					}else {
						top.Dialog.alert("请选择签认的报活项目！");
					}
				});
				
				$('#allsign').bind('click', function() {
					$.post("reportWorkManage!reportWorkItemSignConfirm.action",
						{"id":"${id}","type":2,"role":"${role}"},
						function(text){
							if(text=="login_failure"){
								top.Dialog.alert("不存在该用户!");
							}else if(text=="noprivilege_failure"){
								//top.Dialog.alert("没有可签项目或不是该用户的分工项目!");
								top.Dialog.alert("项目未处理或未签认完全!");
							}else{
								top.Dialog.alert("签名成功!",function(){
									 top.frmright.frames[1].location.reload();
							    	 top.Dialog.close();
								});
							}
						}
				);
					//var diag = new top.Dialog();
					//diag.Title = "报活签认窗口";
					//diag.URL = 'reportWorkManage!reportWorkItemSignInput.action?id=${id}&type=2&role=${role}';
					//diag.Width=350;
					//diag.Height=200;
					//diag.show();
				});
				
				
				//报活
				$('#newreport').bind('click', function(){
					var planid = $('#dateplan').val();
					var jctype = $('#jctype').val();
					var diag = new top.Dialog();
					diag.Title = "报活操作窗口";
					diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type='+jctype+'&planid='+planid;
					diag.Width=1000;
					diag.Height=520;
					diag.show();				
				});
				
				$("#bz").zxxAnchor({
			    	anchorSmooth: false                       
			    });
			    
			    $("#nbz").zxxAnchor({
			    	anchorSmooth: false                       
			    });
			    
			    //工长报活接活
			    $('#receive').bind('click',function(){
			      	var works = [];
					$("input[name='report_item']:checked").each(function() {
						works.push($(this).val());
					});
					if(works.length>0){
					    var diag = new top.Dialog();
						diag.Title = "报活签认窗口";
						diag.URL = 'reportWorkManage!reportWorkItemSignInput.action?id=${id}&role=worker&type=1&params='+works.join('-');
						diag.Width=350;
						diag.Height=200;
						diag.show();
					}else{
						top.Dialog.alert("请选择签认的报活项目！");
					}
			    });
			});
			
			 //工长报活接活---角色当做工人处理
			function receiveWork(preDictId){
			      	var diag = new top.Dialog();
					diag.Title = "报活签认窗口";
					diag.URL = 'reportWorkManage!reportWorkItemSignInput.action?id=${id}&role=foreman_worker&type=1&params='+preDictId;
					diag.Width=350;
					diag.Height=200;
					diag.show();
			}

			//查看报活详细信息
			function jtPreDictDatils(id) {
				var diag = new top.Dialog();
				diag.Title = "报活信息详细窗口";
				diag.URL = 'reportWorkManage!reportWorkDetail.action?id='+id;
				diag.Width=1124;
				diag.Height=480;
				diag.show();
				return false;
			}
			
			//2015-05-22,黄亮，修改，如果是"更换良好"，显示更换配件编码 
			//更换配件编码-输入配件编号
			function pjNumInputWith(itemName,recId){
				var planId = $('#rjhmId').val();
				//type：检查项目和检测项目。xtype:修程
				top.Dialog.open({MessageTitle:"检修项目:"+itemName,Title:"添加配件编号信息",URL:"<%=basePath%>work/work/pjnum_report_dialog.jsp?xtype=0&type=2&recId="+recId+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
			}
			
			//2015-05-27,黄亮，修改，修改配件编号
			function pjNumUpdate(){
				var arg_length = arguments.length;
				var itemName = arguments[0];
				var recId = arguments[1];
				var planId = $('#dateplan').val();
				var upPJNum = "";
				for(var i=2; i < arg_length;i++){
					if(i != arg_length -1){
						upPJNum += arguments[i]+",";
					}else{
						upPJNum += arguments[i];
					}
				}
				top.Dialog.open({MessageTitle:"检修项目:"+itemName,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>work/work/pjnum_report_update_dialog.jsp?xtype=0&type=2&recId="+recId+"&upPJNum="+upPJNum+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
			}
		</script>
	</body>
</html>