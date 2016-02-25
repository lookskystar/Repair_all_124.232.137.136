<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<base href="<%=basePath%>" />
	<title>机车检修日计划批量操作</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
	<!--框架必需end-->
</head>
	<body>
		<div style="margin-top: 5px;"><button onclick="addaily();">增加日计划</button></div>
		<div id="dailyBatchDiv">
			<fieldset> 
				<legend>日计划信息</legend> 
				<table width="100%" class="tableStyle">
					<input type="hidden" id="mainPlanDetailid-0" name="mainPlanDetailid" value=""/>
					<tr>
						<td>
							车型：<input type="text" name="jcType" id="jcType-0" />&nbsp;&nbsp;<input id="jccurriculum" type="button" name="choicetype" value="选择" onclick="findJcCurriculum(0)"/>&nbsp;<input id="jcweekplan" type="button" value="周计划" onclick="findWeekPlan(0)"/>
						</td>
						<td>
							车号：<input type="text" name="jcNum" id="jcNum-0"/>
						</td>
						<td>
							修程：<input type="text" name="fixFreque" id="fixFreque-0"/>
							<input id="jcfixFreque" type="button" value="选择" name="choicefreque" onclick="findFixFreque(0)"/>&nbsp;&nbsp;
						</td>
						<td>
							股道：<input type="text" name="gdh" />
						</td>
						<td>
							台位：<input type="text" name="twh" />
						</td>
					</tr>
					<tr>
						<td>
							计划扣车时间：
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="kcsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 07:00").format(new Date())%>'/>
						</td>
						<td>
							计划起机时间：
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="jhqjsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 13:30").format(new Date())%>'/>
						</td>
						<td>
							计划交车时间：
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="jhjcsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 16:30").format(new Date())%>'/>
						</td>
						<td>
							备注：<input type="text" name="comments" />
						</td>
						<td>
							交车工长：
							<select name="userId" class="default" style="width:120px">
								<option value="">请选择</option>
								<c:forEach var="entry" items="${users}">
									<option value="${entry.userid}">${entry.xm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		<div style="margin-top: 5px;text-align: center;"><button id="sub">提交</button>&nbsp;&nbsp;<button id="reset">重置</button></div>
		<script type="text/javascript">
			var row = 0;
			var rowAray = [0];
			
			$(document).ready(function(){
				$("#sub").bind('click',function(){
					var each = $("[name='jcType']").length;
					var jcTypes = $("[name='jcType']");
					var jcNums = $("[name='jcNum']");
					var fixFreques = $("[name='fixFreque']");
					var gdhs = $("[name='gdh']");
					var twhs = $("[name='twh']");
					var kcsjs = $("[name='kcsj']");
					var jhqjsjs = $("[name='jhqjsj']");
					var jhjcsjs = $("[name='jhjcsj']");
					var comments = $("[name='comments']");
					var jcgzs = $("[name='userId']");
					var mainPlanDetailid = $("[name='mainPlanDetailid']");
					var emptyFlag = true;
					emptyFlag = chargeFlag('jcType');
					emptyFlag = chargeFlag('jcNum');
					emptyFlag = chargeFlag('fixFreque');
					emptyFlag = chargeFlag('gdh');
					emptyFlag = chargeFlag('twh');
					if(emptyFlag){
						var dailyString = "{'dailys': [";
						for(var i = 0; i < each; i++){
							dailyString += "{";
							dailyString += "'jcType':'"+ jcTypes[i].value +"',";
							dailyString += "'jcNum':'"+ jcNums[i].value +"',";
							dailyString += "'fixFreque':'"+ fixFreques[i].value +"',"; 
							dailyString += "'gdh':'"+ gdhs[i].value +"',";
							dailyString += "'twh':'"+ twhs[i].value +"',";
							dailyString += "'kcsj':'"+ kcsjs[i].value +"',";
							dailyString += "'jhqjsj':'"+ jhqjsjs[i].value +"',";
							dailyString += "'jhjcsj':'"+ jhjcsjs[i].value +"',";
							dailyString += "'comment':'"+ comments[i].value +"',";
							dailyString += "'jcgz':'"+ jcgzs[i].value +"',";
							dailyString += "'mainPlanDetailid':'"+ mainPlanDetailid[i].value +"'";
							dailyString += (i == (each-1)? "}": "},");
						}
						dailyString += "]}";
						$.ajax({
							type:"post",
							async:false,
							url:"<%=basePath%>planManage!addDatePlanPriOfBatchConfirm.do",
							data:{"dailyString":dailyString},
							success:function(result){
								if(result=="success"){
					    			top.Dialog.alert("批量扣车成功！",function(){
					    				top.window.location.href="report/jcgz_main.jsp";
				    				}); 
					    		}else if(result == "nonodeid"){
					    			top.Dialog.alert("日计划扣车失败，无法找到该修程修次的流程节点！");
					    		}else if(result == "put"){
					    			top.Dialog.alert("日计划扣车成功，请填写计划检修内容！", function(){
					    				top.window.location.href="report/jcgz_main.jsp";
				    				}); 
					    		}else {
					    			top.Dialog.alert("批量扣车失败！");
					    		}
							}
						});
					}else{
						top.Dialog.alert("请输入正确的信息！");
					}
				})
				
				Array.prototype.remove = function(dx){ 
				    if(isNaN(dx)||dx>this.length){return false;} 
				    for(var i=0,n=0;i<this.length;i++){ 
				        if(this[i]!=this[dx]){ 
				            this[n++]=this[i] 
				        } 
				    } 
				    this.length-=1 
				} 
				
			})
			
			function findJcCurriculum(row) {
				var diag = new top.Dialog();
				diag.Title = "机车信息窗口";
				diag.URL = "<%=basePath%>planManage!findJcCurriculumByWeekPlan.action";
				diag.Width=420;
				diag.Height=320;
				diag.CancelEvent = function(){
					diag.innerFrame.contentWindow.location.reload();
					diag.close();
				};
				diag.OKEvent = function(obj){
					var doucmentWin = diag.innerFrame.contentWindow;
					doucmentWin.getRadioLine();
					var jcs = doucmentWin.document.getElementById("jcs").value;
					if (jcs!="") {
						var arrs = jcs.split("-");
						$("#jcType-"+ row +"").val(arrs[0]);
						$("#jcNum-"+ row +"").val(arrs[1]);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}
			
			function findFixFreque(row){
				var diag = new top.Dialog();
				diag.Title = "检修修程窗口";
				diag.Width=380;
				diag.Height=400;
				diag.URL = "<%=basePath%>page/plan/fixfreque.jsp";
				diag.CancelEvent = function(){
					diag.close();
				};
				diag.OKEvent = function(){
					var doucmentWin = diag.innerFrame.contentWindow;
					doucmentWin.getFixFrequeRadioLine();
					var fixfreque = doucmentWin.document.getElementById("selectfixfreque").value;
					if (fixfreque!="") {
						$("#fixFreque-"+ row +"").val(fixfreque);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}
			
			function addaily(){
				row = row + 1;
				rowAray.push(row);
				var obj = "<fieldset>" +
								"<legend>日计划信息<input type='button' onclick='deldaily(this, "+ row +");' value='移除'/></legend> "+
								"<table width='100%' class='tableStyle'> "+
									"<input type='hidden' id='mainPlanDetailid-"+ row +"' name='mainPlanDetailid' value=''/>"+
									"<tr> "+
										"<td> "+
											"车型：<input type='text' name='jcType' id='jcType-"+ row +"'/>&nbsp;&nbsp;<input id='jccurriculum' type='button' value='选择' onclick='findJcCurriculum("+ row +")'/>&nbsp;<input id='jcweekplan' type='button' value='周计划' onclick='findWeekPlan("+ row +")'/> "+
										"</td> "+
										"<td> "+
											"车号：<input type='text' name='jcNum' id='jcNum-"+ row+"'/> "+ 
										"</td> "+
										"<td> "+
											"修程：<input type='text' name='fixFreque' id='fixFreque-"+ row +"'/> "+
											"<input id='jcfixFreque' type='button' value='选择' onclick='findFixFreque("+ row +")'/>&nbsp;&nbsp; "+
										"</td> "+
										"<td> "+
											"股道：<input type='text' name='gdh' /> "+
										"</td> "+
										"<td> "+
											"台位：<input type='text' name='twh' /> "+
										"</td> "+
									"</tr> "+
									"<tr> "+
										"<td> "+
											"计划扣车时间： "+
											"<input type='text' class='Wdate' onfocus='WdatePicker()' name='kcsj' style='width:120px' value='<%=new SimpleDateFormat("yyyy-MM-dd 07:00").format(new Date())%>'/> "+
										"</td> "+
										"<td> "+
											"计划起机时间： "+
											"<input type='text' class='Wdate' onfocus='WdatePicker()' name='jhqjsj' style='width:120px' value='<%=new SimpleDateFormat("yyyy-MM-dd 13:30").format(new Date())%>'/> "+
										"</td> "+
										"<td> "+
											"计划交车时间： "+
											"<input type='text' class='Wdate' onfocus='WdatePicker()' name='jhjcsj' style='width:120px' value='<%=new SimpleDateFormat("yyyy-MM-dd 16:30").format(new Date())%>'/> "+
										"</td> "+
										"<td> "+
											"备注：<input type='text' name='comments' /> "+
										"</td> "+
										"<td> "+
											"交车工长： "+
											"<select name='userId' class='default' style='width:120px'> "+
												"<option value=''>请选择</option> "+
												"<c:forEach var='entry' items='${users}'> "+
													"<option value='${entry.userid}'>${entry.xm}</option> "+
												"</c:forEach> "+
											"</select> "+
										"</td> "+
									"</tr> "+
								"</table> "+
							" </fieldset> ";
				$("#dailyBatchDiv").append(obj);
			}
			
			
			function deldaily(obj, row){
				rowAray.remove(row);
				$(obj).parent().parent().remove();
			}
			
			function isNotEmpty(fileds){
				return (fileds == null || fileds == "" || fileds == undefined) ? false: true;
			}
			
			function chargeFlag(name){
				var flag = true;
				$("[name='"+ name +"']").each(function(){
					var itemVal = $(this).val();
					if(!isNotEmpty(itemVal)){
						$(this).css({border:"1px solid red"});
						flag = false;
						return false;
					}
				})
				return flag;
			}

			function findWeekPlan(row) {
				var diag = new top.Dialog();
				diag.Title = "机车信息窗口";
				diag.URL = "<%=basePath%>planManage!findJcCurriculumByMainPlan.action";
				diag.Width=420;
				diag.Height=320;
				diag.CancelEvent = function(){
					diag.innerFrame.contentWindow.location.reload();
					diag.close();
				};
				diag.OKEvent = function(){
					var doucmentWin = diag.innerFrame.contentWindow;
					doucmentWin.getRadioLine();
					var jcs = doucmentWin.document.getElementById("jcs").value;
					if (jcs!="") {
						var arrs = jcs.split("-");
						$("#jcType-"+ row +"").val(arrs[0]);
						$("#jcNum-"+ row +"").val(arrs[1]);
						$("#fixFreque-"+ row +"").val(arrs[2]);
						$("#mainPlanDetailid-"+ row +"").val(arrs[3]);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}			
		</script>
		<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>