<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->
<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/ocscript_v.js" ></script>
<script type="text/javascript" src="<%=basePath %>js/lhgdialog/lhgdialog.js"></script>

<style>
	TABLE.bluetable {
		FONT: 100% Arial, Helvetica, sans-serif
	}
	TD {
		FONT: 100% Arial, Helvetica, sans-serif
	}
	TABLE.bluetable {
		MARGIN: 0.1em 0px; BORDER-COLLAPSE: collapse
	}
	TABLE.bluetable TH {
		BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
	}
	TABLE.bluetable TD {
		BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
	}
	TABLE.bluetable TH {
		BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x; COLOR: #fff
	}
	TABLE.bluetable TD {
		BACKGROUND: #FFFFFF
	}
	TABLE.bluetable TR.even TD {
		BACKGROUND: #e5f1f4
	}
	TABLE.bluetable TR.odd TD {
		BACKGROUND: #f8fbfc
	}
	TABLE.bluetable TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TR.even TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TR.odd TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TR.even TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TR.odd TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TH.selected {
		
	}
	TABLE.bluetable TR.even TH.selected {
		
	}
	TABLE.bluetable TR.odd TH.selected {
		
	}
	TABLE.bluetable TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TR.even TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TR.odd TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TR.even TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TR.odd TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TR.even TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TR.odd TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TD.empty {
		BACKGROUND: #fff
	}
	TABLE.bluetable TR.odd TD.empty {
		BACKGROUND: #fff
	}
	TABLE.bluetable TR.even TD.empty {
		BACKGROUND: #fff
	}
</style>
</head>

<body>
	<table style="width: 100%;" cellspacing="0" class="bluetable">
		<tr>
			<!--左侧区域start-->
			<td>
			    <div style="overflow: auto;height: 600px;">
			    	<table>
			        	<tr>
			            	<th width="5%">序号</th>
			                <th width="25%">车号</th>
			                <th width="10%">股道</th>
			                <th width="19%">扣车时间</th>
				         	<th width="12%">交车工长</th> 
				            <th width="10%">状态</th>
			            	<th width="19%">操作</th>
		         	   	</tr>
			           	<c:forEach items="${allJC }" var="plan" varStatus="index">
				            <tr>
				            	<td align="center">${index.index+1 }</td>
				                <td align="center">
				                  <c:if test="${plan.projectType==0}">
				                     <a style="position:static;color:blue;" href="<%=basePath%>query!getInfoByJC.do?rjhmId=${plan.rjhmId}&psize=100" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque }</a>
				                  </c:if>
				                  <c:if test="${plan.projectType==1}">
				                     <a style="position:static;color:blue;" href="<%=basePath%>query!getZxInfoByJC.do?rjhmId=${plan.rjhmId}&psize=100" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque }</a>
				                  </c:if>
				                  </td>
				                <td align="center"><a style="position:static;color:blue;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
				                <td align="center">${fn:substring(plan.kcsj,5,16) }</td>
				                <td align="center">${plan.gongZhang.xm }</td>
				                <td align="center">
					                <c:if test="${plan.planStatue == -1}">
					                	新建
					                </c:if>
					                <c:if test="${plan.planStatue == 0}">
					                	在修
					                </c:if>
					                <c:if test="${plan.planStatue == 1}">
					                	待验
					                </c:if>
					                <c:if test="${plan.planStatue == 2}">
					                	已交
					                </c:if>
					                 <c:if test="${plan.planStatue == 3}">
					                	转出
					                </c:if>
				                </td>
					            <td>
					            	<div class="simpleMenu" style="width:92px;">
										<div class="simpleMenu_link arrow border" style="z-index: -1;position: static;">
											<a href="javascript:;" style="position: static;">全部操作</a>
										</div>
										<div class="simpleMenu_con" style="width:90px;z-index: 1;position: static;">
											<a href="<%=basePath %>oilAssay!searchOilAssayRecorderDaily.do?rjhmId=${plan.rjhmId }" target="jcgz_gdt" style="position: static;"><span class="icon_lightOn">油水化验</span></a>
											<a href="javascript:void(0);" target="jcgz_gdt" onclick="report(${plan.rjhmId });" style="position: static;"><span class="icon_poll">报活</span></a>
											<c:if test="${plan.planStatue == -1}">
							                	<a href="javascript:void(0);" onclick="modifydailyplan('${plan.rjhmId }');" style="position: static;"><span class="icon_edit">修改计划</span></a>
							                	<a href="javascript:void(0);" onclick="deletedailyplan('${plan.rjhmId }');" style="position: static;"><span class="icon_remove">删除</span></a>
							                	<c:if test="${plan.fixFreque=='LX' || plan.fixFreque=='JG'|| plan.fixFreque=='ZZ'}">
								                	<a href="<%=basePath%>planManage!jcgzDailyPlanMake.action?id=${plan.rjhmId }" target="jcgz_gdt" style="position: static;"><span class="icon_view">检修内容</span></a>
							                	</c:if>
							                	<a href="javascript:void(0);" onclick="jc('${plan.rjhmId }','${plan.fixFreque}');" style="position: static;"><span class="icon_mark">接车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 0 and plan.nodeid.jcFlowId==106}">
							                	<a href="<%=basePath%>work/role/role_ratify.jsp?rjhmId=${plan.rjhmId}&jcstype=${plan.fixFreque}&rtype=4&role=comm" target="jcgz_gdt" style="position: static;"><span class="icon_pencil">卡控签字</span></a> 
							                	<a href="javascript:void(0);" onclick="distribution(${plan.rjhmId });" style="position: static;"><span class="icon_user">超修派工</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==107}">
							                    <c:if test="${plan.fixFreque=='LX' || plan.fixFreque=='JG'|| plan.fixFreque=='ZZ'}">
							                       <a href="<%=basePath%>work/role/role_ratify.jsp?rjhmId=${plan.rjhmId}&jcstype=${plan.fixFreque}&rtype=4&role=comm" target="jcgz_gdt" style="position: static;"><span class="icon_pencil">卡控签字</span></a> 
							                    </c:if>
							                	<a href="<%=basePath%>checkSign!checkSignInput.do?nodeId=107&rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_reload">交车试验</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                 <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==100}">
							                	<a href="javascript:void(0);" onclick="distribution(${plan.rjhmId });" style="position: static;"><span class="icon_user">超修派工</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==101}">
							                	<a href="javascript:void(0);"  onclick="distribution(${plan.rjhmId });" style="position: static;"><span class="icon_user">超修派工</span></a>
							                	<a href="<%=basePath%>work/role/zx_role_ratify.jsp?rjhmId=${plan.rjhmId}&jcstype=${plan.fixFreque}&rtype=4&role=comm" target="jcgz_gdt" style="position: static;"><span class="icon_pencil">卡控签字</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==102}">
							                    <a href="<%=basePath%>experiment!enterExperiment.do?rjhmId=${plan.rjhmId}&xx=${plan.fixFreque}" target="jcgz_gdt" style="position: static;"><span class="icon_star">中修试验</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 0  and plan.nodeid.jcFlowId==103}">
							                	<a href="<%=basePath%>experiment!enterExperiment.do?rjhmId=${plan.rjhmId}&xx=${plan.fixFreque}" target="jcgz_gdt" style="position: static;"><span class="icon_star">中修试验</span></a>
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 1}">
							                	<a href="<%=basePath%>checkDealJc!checkDealJcInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_ok">竣工交车</span></a>
							                </c:if>
							                <c:if test="${plan.planStatue == 2}">
							                	<a href="<%=basePath%>zeroCheck!zeroSignMsg.do?dpId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_about">零公里</span></a>
							                	<a href="<%=basePath%>zeroCheck!jcRollOutInput.do?rjhmId=${plan.rjhmId}" target="jcgz_gdt" style="position: static;"><span class="icon_key">机车转出</span></a>
							                </c:if>
										</div>
									</div>
					            </td>
				            </tr>
			           	</c:forEach>
		           		<c:if test="${fn:length(allJC )<16 }">
				            <c:forEach begin="0" end="${16-fn:length(allJC )}">
				            	<tr>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            		<td>&nbsp;</td>
				            	</tr>
				            </c:forEach>
		            	</c:if>
		      	  </table>
		      	</div>
			</td>
			<!--左侧区域end-->
			<!--右侧区域start-->
			<td width="65%">
				<iframe id="jcgz_gdt" name="jcgz_gdt" scrolling="auto" overflow="auto" width="100%" height="600px" frameBorder=0 src="<%=basePath %>report!findAllJC.do?type=jcgz&flag=gdt"  allowTransparency="true"></iframe>
			</td>
			<!--右侧区域end-->
		</tr>
	</table>
<!--引入组件start-->
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<!--引入弹窗组件end-->
<script type="text/javascript">
	
	//-1-新建 , 0-在修  1-待验  2-已交
	var dd;
	$(document).ready(function(){
		setInterval(function(){//定时刷新
			if(dd!=undefined && dd.closed==false){
				dd.close();
			}
			window.location.reload();
		},29*60*1000);
		
		if(top.Dialog==null){
			top.Dialog.close();
		}
		<c:if test="${!empty message}">
			top.Dialog.close();
			top.Dialog.alert('${message}');
		</c:if>
		
	});
	
	//查看机车
	function clickGD(rjhmId){
		var url="<%=basePath %>report!getInfoDetail.do?rjhmId="+rjhmId;
		$(document).ready(function () {
           	dd =$.dialog({
                title:"机车信息",
                content:'url:'+url+'&temp='+new Date().getTime(),
                height:500,
                width:580,
                max:false,
                min:false
                
            });
        })
	}
	//扣车
	function kc(){
		var diag = new top.Dialog();
		diag.Title = "日计划制定窗口";
		diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action";
		diag.Width=450;
		diag.Height=430;
		diag.show();
	}
	
	//修改日计划
	function modifydailyplan(planid){
		var diag = new top.Dialog();
		diag.Title = "日计划检修机车修改窗口";
		diag.URL = "<%=basePath%>planManage!modifyDailyPlanInput.action?id="+planid;
		diag.Width=450;
		diag.Height=470;
		diag.show();
	}
	//删除日计划			
	function deletedailyplan(planid) {
		top.Dialog.confirm('确认要删除该日计划？',function(){location.href='<%=basePath%>planManage!deleteDailyPlanConfirm.action?id='+planid});
	}
	//接车
	function jc(planid,fixFreque){
		if (fixFreque=="LX" || fixFreque=="JG"|| fixFreque=="ZZ") {
			top.Dialog.confirm('确认检修内容已经分工完成，进行日计划签认？',function(){location.href='pdiFroemanManage!datePlanSign.action?id='+planid});
		} else {
			top.Dialog.confirm('确认对该日计划签认？',function(){location.href='pdiFroemanManage!datePlanSign.action?id='+planid});
		}
	}
	//超修派工
	function distribution(id) {
		var diag = new top.Dialog();
		diag.Title = "报活信息派工窗口";
		diag.URL = 'reportWorkManage!distributionInput.action?id='+id+'&role=dispatcher';
		diag.Width="100";
		diag.Height="100";
		diag.show();
		return false;
	}
	//报活
	function report(planid){
    	var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type=1&roleType=lead';
		diag.Width=1000;
		diag.Height=520;
		diag.show();
	 }
</script>
</body>
</html>
