<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/bsFormat.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<!--框架必需end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
<title>无标题文档</title>
<style>
	body,html{
		padding:0px;
		margin:0px;
		width:100%;
		height:100%;
		overflow: hidden;
	}
	#lists{
		float:left;
		width:100%;
		height:100%;
		overflow: auto;
	}

	#listitems{
		border:1px solid green;
		width:100%;
		height:100%;
		border-collapse: collapse;
		margin-left:5px;
		overflow: auto;
	}
	#listitems th{
		text-align:center;
		height:40px;
		line-height:40px;
		font-weight:bold;
		overflow: auto;
	}
	#listitems td,#listitems th{
		border:1px solid green;
		font:12px arial,宋体,sans-serif;
		overflow: auto;
	}
	#listitems td{
		padding-left:1px;
		padding-top:2px;
		padding-bottom:2px;
		overflow: auto;
	}
	#maps{
		background:url(images/1.jpg) left top no-repeat;
		width:1000px;
		height:1000px;
		position:absolute;
		border-left:1px solid #a0a0a0;
		left:0px;
		overflow: auto;
	}
	#content{
		position:relative;
		left:0px;
		width:100%;
		float:left;
		height:100%;
		background-color:#c0c0c0;
		text-align: center;
		overflow: scroll;
	}
	.box{
		width:35px;
		height:16px;
		line-height:16px;
		border:1px solid #999;
		text-align:center;
		position:absolute;
		background-color:#fff;	
	}
	div.k2{
		border:3px dashed yellow;
		position: absolute;
		left:335px;
		top:273px;
		width:139px;
		height:63px;
	}
	div.k3{
		border:3px dashed #C0F;
		position: absolute;
		left:365px;
		top:648px;
		width:92px;
		height:30px;
	}
	div.k4{
		border:3px dashed red;
		position: absolute;
		left:435px;
		top:373px;
		width:92px;
		height:126px;
	}
	div.k5{
		border:3px dashed #000;
		position: absolute;
		left:440px;
		top:556px;
		width:182px;
		height:90px;
	}
	.box a{
		display:block;
		text-decoration:none;
		font-size:12px;
		font-weight:bold;
	}
	div.blue{
		background:blue;
	}
	div.green{
		background:#067d06;
	}
	div.red{
		background-color:red;
	}
	div.black{
		background-color:black;
	}
	div.yellow{
		background-color: #ff9600
	}
	div.blue a,div.red a,div.black a,div.yellow a{
		color:#FFF;
	}
	div.green a{
		color:#FFF;
	}
</style>
<link href="<%=basePath %>report/css/global.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/lhgdialog/skins/blue.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/lhgdialog/lhgdialog.js"></script>
<script type="text/javascript">
	//-1-新建 , 0-在修  1-待验  2-已交
	var data=${jcJSON};
	var dd;
	
	$(document).ready(function(){
		//var gtimes={};
		for(var i=0;i<data.length;i++){
			var gdh=data[i].gdh;
			var tar=$('div[group="'+gdh+'"]').eq(data[i].tw-1);
			if(data[i].statue==2){//已交
				tar.addClass('green');
			}else if(data[i].statue==1){//待验
				tar.addClass('yellow');
			}else if(data[i].statue==0){
				tar.addClass('blue');
			}else{//新建
				tar.addClass('red');
			}
			tar.html('<a href="javascript:void(0);"id="'+data[i].jcnum+'" class="jTip" name="<%=basePath %>report!getInfoDetail.do?rjhmId='+data[i].rjhmId+'">'+data[i].jcnum+'</a>');
		}

		$('.jTip').bind('click',function(event){
			var url=$(event.target).attr('name');
			 $(document).ready(function () {
            	dd =$.dialog({
	                title:"机车信息",
	                content:'url:'+url+'&temp='+new Date().getTime(),
	                height:500,
	                max:false,
	                min:false
	            });
        	})
		});
		
		setInterval(function(){//定时刷新
			if(dd!=undefined && dd.closed==false){
				dd.close();
			}
			window.location.reload();
		},29*60*1000);
		
	});
	
	$(function(){
		jkmegamenu.definemenu("megaanchor1", "megamenu1", "mouseover");
		//jkmegamenu.definemenu("megaanchor2", "megamenu2", "mouseover");
		//jkmegamenu.definemenu("megaanchor3", "megamenu3", "mouseover");
		//jkmegamenu.definemenu("megaanchor4", "megamenu4", "mouseover");
		//jkmegamenu.definemenu("megaanchor5", "megamenu5", "mouseover");
	});
	
	function clickGD(rjhmId){
		var url="<%=basePath %>report!getInfoDetail.do?rjhmId="+rjhmId;
		$(document).ready(function () {
           	dd =$.dialog({
                title:"机车信息",
                content:'url:'+url+'&temp='+new Date().getTime(),
                height:500,
                max:false,
                min:false
            });
        })
	}

    function report(planid){
    	var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type=1&roleType=lead';
		diag.Width=1000;
		diag.Height=520;
		diag.show();
 	}

</script>
</head>

<body>
<input type="hidden" name="roles" value="${sessionScope.session_user.roles }"/>
<br/>
 <center>
 		<table id="tab" style=" width:70%; height:30px;margin-top:0px; ">	
		    <tr>
			  <td style="font-size: 13px;"><a href="<%=basePath %>report/select_main.jsp" id="megaanchor1">机车检修管理</a>
			    <div id="megamenu1" class="simplemenu" style="width:100px;">
					<ul>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=Z&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">中&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=X&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">小&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=F&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">辅&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=LX&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">临&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=JG&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">加&nbsp;&nbsp;改</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=QZ&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">整&nbsp;&nbsp;治</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=CJ&startTime=''&endTime=''&jcType=0&jcNum=" target="_blank">春&nbsp;&nbsp;鉴</a></li>
						<li><a href="<%=basePath %>report/select_main.jsp" target="_blank">其&nbsp;&nbsp;他</a></li>
					</ul>
				</div>
			  </td>
			  <!-- 
			  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor2">配件检修管理</a>
			  	<div id="megamenu2" class="simplemenu" style="width:110px;">
					<ul>
						<li><a href="javascript:void(0)" target="_blank">配件配送管理</a></li>
						<li><a href="javascript:void(0)" target="_blank">大部件检修</a></li>
						<li><a href="javascript:void(0)" target="_blank">其它备件管理</a></li>
					</ul>
				</div>
			  </td> 
			  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor3">配件周转管理</a>
			  	<div id="megamenu3" class="simplemenu" style="width:110px;">
					<ul>
						<li><a href="javascript:void(0)" target="_blank">配件身份</a></li>
						<li><a href="javascript:void(0)" target="_blank">中心配件库</a></li>
						<li><a href="javascript:void(0)" target="_blank">配件交接</a></li>
						<li><a href="javascript:void(0)" target="_blank">配件周期</a></li>
					</ul>
				</div>
			  </td>
			  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor4">技术标准管理</a>
			  	<div id="megamenu4" class="simplemenu" style="width:110px;">
					<ul>
						<li><a href="javascript:void(0)" target="_blank">大中修标准</a></li>
						<li><a href="javascript:void(0)" target="_blank">小辅修标准</a></li>
						<li><a href="javascript:void(0)" target="_blank">验收规程</a></li>
						<li><a href="javascript:void(0)" target="_blank">作业指导书</a></li>
						<li><a href="javascript:void(0)" target="_blank">配件检修标准</a></li>
						<li><a href="javascript:void(0)" target="_blank">其它标准</a></li>
					</ul>
				</div>
			  </td>
			  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor5">检修车间管理</a>
			  	<div id="megamenu5" class="simplemenu" style="width:110px;">
					<ul>
						<li><a href="javascript:void(0)" target="_blank">考勤</a></li>
						<li><a href="javascript:void(0)" target="_blank">班组</a></li>
						<li><a href="javascript:void(0)" target="_blank">规章</a></li>
						<li><a href="javascript:void(0)" target="_blank">问题库</a></li>
					</ul>
				</div>
			  </td>
			   -->
			  <%--
			  <td valign="bottom">
			  <form method="post" action="<%=basePath%>query!query.do" target="_blank">
			  	时间：<input class="cusDate" type="text" id="time" onfocus="javascript:WdatePicker({dateFmt:'MM-dd H:mm'})" name="startTime"/>
			  	<input type="submit" value="查&nbsp;&nbsp;询" style="width:70px;height:20px;"/>
			  	</form>
			  </td>
			   --%>
			</tr>
  		</table>
  </center>

<table style="width: 100%;height:100%;" cellspacing="0" class="table_border0">
	<tr >
		<!--左侧区域start-->
		<td id="hideCon" class="ver01 ali01">
			<div>
				<div id="lbox_middlecenter">
					<div id="lbox_middleleft">
						<div id="lbox_middleright" >
							<div id="bs_left" style="width:1330px;height:560px;">
									<div id="lists">
								    	<table id="listitems">
								        <tr>
								            	<th>序号</th>
								                <th width="10%">机车号</th>
								                <th>修程</th>
								                <th>股道</th>
								                <th>台位</th>
								                <th>扣车时间</th>
								                <th>计划起机时间<br>实际起机时间</th>
									            <th>计划交车时间<br>实际交车时间</th>
									            <th>交车工长</th>
									            <th>状态</th>
								                <th>报活操作</th>
								                <th width="20%">记录查看</th>
							         	   </tr>	
								            <c:forEach items="${allJC }" var="plan" varStatus="index">
									            <tr>
									            	<td align="center">${index.index+1 }</td>
									                <td align="center">
									                   <c:if test="${plan.projectType==0}">
									                       <a style="position:static;" href="<%=basePath%>query!getInfoByJC.do?rjhmId=${plan.rjhmId}&jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque}" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque}</a>
									                   </c:if>
									                   <c:if test="${plan.projectType==1}">
									                       <a style="position:static;" href="<%=basePath%>query!getZxInfoByJC.do?rjhmId=${plan.rjhmId}" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque}</a>
									                   </c:if>
									                </td>
									                <td align="center">
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'N')}">年检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'BN')}">半年检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'F')}">辅修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'X')}">小修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'Z')&&!fn:endsWith(plan.fixFreque,'ZZ')}">中修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'L')}">临修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'J')}">加改</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'ZQ')}">周期整治</c:if>
									                </td>
									                <td align="center"><a style="position:static;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
									                <td align="center">${plan.twh }</td>
									                <td align="center">${fn:substring(plan.kcsj,5,16) }</td>
									                <td align="center">${fn:substring(plan.jhqjsj,5,16) }<br>${fn:substring(plan.sjqjsj,5,16) }</td>
									                <td align="center">${fn:substring(plan.jhjcsj,5,16) }<br>${fn:substring(plan.sjjcsj,5,16) }</td>
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
										            <td align="center" style="width: 100px;">
										            	<a href="javascript:void(0)" style="position:static;" onclick="report(${plan.rjhmId });">报活</a>&nbsp;
										            	<a href="reportWorkManage!reportWork.action?id=${plan.rjhmId}" style="position:static;">我报的活</a>
										            </td>
										             <td align="center" style="width: 100px;">
										                <c:if test="${plan.projectType==0}">
										            		<a href="<%=basePath%>query!view.do?id=${plan.rjhmId}&jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque }&rjhmId=${plan.rjhmId }" target="_blank" style="position:static;">检修记录</a>&nbsp;
										            	</c:if>
										            	<c:if test="${plan.projectType==1}">
										            		<a href="<%=basePath%>query!zxView.do?id=${plan.rjhmId}" target="_blank" style="position:static;">检修记录</a>&nbsp;
										            	</c:if>
										            		<a href="<%=basePath %>query!getAllInfoPre.do?id=${plan.rjhmId}" target="_blank" style="position:static;">报活记录</a>&nbsp;
										            	<c:if test="${plan.projectType==0}">
															<a href="<%=basePath%>query!searchJcRec.do?rjhmId=${plan.rjhmId}&jcStype=${plan.jcType }" target="_blank" style="position:static;">交车记录</a>&nbsp;
														</c:if>
														<c:if test="${plan.projectType==1}">
															<a href="<%=basePath %>query!viewExperiment.do?id=${plan.rjhmId}&jceiId=2" target="_blank" style="position:static;">试验记录</a>&nbsp;
														</c:if>
														<c:if test="${plan.projectType==0}">
																<a href="<%=basePath %>oilAssay!searchOilAssayRecorderDaily.do?rjhmId=${plan.rjhmId }" target="_blank" style="position:static;">油水化验记录</a>
														</c:if>
														<c:if test="${plan.projectType==1}">
																<a href="<%=basePath %>query!viewPj.do?rjhmId=${plan.rjhmId }" target="_blank" style="position:static;">配件检修记录</a>
														</c:if>
										            </td>
									            </tr>
								            </c:forEach>
							           		 <c:if test="${fn:length(allJC )<15 }">
									            <c:forEach begin="0" end="${15-fn:length(allJC )}">
									            	<tr>
									            		<td>&nbsp;</td>
									            		<td>&nbsp;</td>
									            		<td>&nbsp;</td>
									            		<td>&nbsp;</td>
									            		<td>&nbsp;</td>
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
								</div>
							<!--更改左侧栏的宽度需要修改id="bs_left"的样式-->
							</div>
						</div>
					</div>
				<div id="lbox_bottomcenter">
					<div id="lbox_bottomleft">
						<div id="lbox_bottomright">
							<div class="lbox_foot"></div>
						</div>
					</div>
				</div>
			</div>
		</td>
		<!--左侧区域end-->
		
		<!--中间栏区域start-->
		<td class="main_shutiao">
			<div class="bs_leftArr" id="bs_center" title="收缩面板"></div>
		</td>
		<!--中间栏区域end-->
		
		<!--右侧区域start-->
		<td class="ali01 ver01"  width="100%">
			<div id="rbox">
				<div id="rbox_middlecenter">
					<div id="rbox_middleleft">
						<div id="rbox_middleright">
							<div id="bs_right">
			  					<div id="content">
	    							<div id="maps">
                                    <!--
	    								<div class="k2"></div>
	    								<div class="k5"></div>
	    								<div class="k3"></div>
	    								<div class="k4"></div>
                                      -->
								       <!--39-->
        <div group="39" class="box" style="left:26px;top:3px;">1 
        </div>
        <div group="39" class="box" style="left:66px;top:3px;">2 
        </div>
        <div group="39" class="box" style="left:106px;top:3px;">3 
        </div>
        <div group="39" class="box" style="left:146px;top:3px;">4 
        </div>
        <div group="39" class="box" style="left:186px;top:3px;">5 
        </div>
        <!--37-->
        <div group="37" class="box" style="left:266px;top:3px;">1 
        </div>
        <div group="37" class="box" style="left:306px;top:3px;">2 
        </div>
        <div group="37" class="box" style="left:346px;top:3px;">3 
        </div>
        <div group="37" class="box" style="left:386px;top:3px;">4 
        </div>
        <div group="37" class="box" style="left:426px;top:3px;">5 
        </div>
        <div group="37" class="box" style="left:466px;top:3px;">6 
        </div>
        <div group="37" class="box" style="left:506px;top:3px;">7 
        </div>
        <div group="37" class="box" style="left:546px;top:3px;">8 
        </div>
        <div group="37" class="box" style="left:586px;top:3px;">9 
        </div>
        <div group="37" class="box" style="left:626px;top:3px;">10
        </div>
        <div group="37" class="box" style="left:666px;top:3px;">11 
        </div>
        <div group="37" class="box" style="left:706px;top:3px;">12 
        </div>
        <!--36-->
        <div group="36" class="box" style="left:156px;top:23px;">1
        </div>
        <div group="36" class="box" style="left:196px;top:23px;">2
        </div>
        <div group="36" class="box" style="left:236px;top:23px;">3
        </div>
        <div group="36" class="box" style="left:276px;top:23px;">4
        </div>
        <div group="36" class="box" style="left:316px;top:23px;">5
        </div>
        <div group="36" class="box" style="left:356px;top:23px;">6
        </div>
        <div group="36" class="box" style="left:396px;top:23px;">7
        </div>
        <div group="36" class="box" style="left:436px;top:23px;">8
        </div>
        <div group="36" class="box" style="left:476px;top:23px;">9
        </div>
        <div group="36" class="box" style="left:516px;top:23px;">10
        </div>
        <div group="36" class="box" style="left:556px;top:23px;">11
        </div>
        <div group="36" class="box" style="left:596px;top:23px;">12
        </div>
        <!--35-->
        <div group="35" class="box" style="left:156px;top:45px;">1
        </div>
        <div group="35" class="box" style="left:196px;top:45px;">2
        </div>
        <div group="35" class="box" style="left:236px;top:45px;">3
        </div>
        <div group="35" class="box" style="left:276px;top:45px;">4
        </div>
        <div group="35" class="box" style="left:316px;top:45px;">5
        </div>
        <div group="35" class="box" style="left:356px;top:45px;">6
        </div>
        <div group="35" class="box" style="left:396px;top:45px;">7
        </div>
        <div group="35" class="box" style="left:436px;top:45px;">8
        </div>
        <div group="35" class="box" style="left:476px;top:45px;">9
        </div>
        <div group="35" class="box" style="left:516px;top:45px;">10
        </div>
        <div group="35" class="box" style="left:556px;top:45px;">11
        </div>
        <div group="35" class="box" style="left:596px;top:45px;">12
        </div>
        <!--34-->
        <div group="34" class="box" style="left:26px;top:66px;">1
        </div>
        <div group="34" class="box" style="left:66px;top:66px;">2
        </div>
        <div group="34" class="box" style="left:106px;top:66px;">3
        </div>
        <div group="34" class="box" style="left:146px;top:66px;">4
        </div>
        <!--33-->
        <div group="33" class="box" style="left:240px;top:65px;">1
        </div>
        <div group="33" class="box" style="left:280px;top:65px;">2
        </div>
        <div group="33" class="box" style="left:320px;top:65px;">3
        </div>
        <div group="33" class="box" style="left:360px;top:65px;">4
        </div>
        <div group="33" class="box" style="left:400px;top:65px;">5
        </div>
        <div group="33" class="box" style="left:440px;top:65px;">6
        </div>
        <div group="33" class="box" style="left:480px;top:65px;">7
        </div>
        <!--32-->
        <div group="32" class="box" style="left:240px;top:86px;">1
        </div>
        <div group="32" class="box" style="left:280px;top:86px;">2
        </div>
        <div group="32" class="box" style="left:320px;top:86px;">3
        </div>
        <div group="32" class="box" style="left:360px;top:86px;">4
        </div>
        <div group="32" class="box" style="left:400px;top:86px;">5
        </div>
        <div group="32" class="box" style="left:440px;top:86px;">6
        </div>
        <div group="32" class="box" style="left:480px;top:86px;">7
        </div>
        <!--31-->
        <div group="31" class="box" style="left:240px;top:107px;">1
        </div>
        <div group="31" class="box" style="left:280px;top:107px;">2
        </div>    
        <div group="31" class="box" style="left:320px;top:107px;">3
        </div>    
        <div group="31" class="box" style="left:360px;top:107px;">4
        </div>    
        <div group="31" class="box" style="left:400px;top:107px;">5
        </div>    
        <div group="31" class="box" style="left:440px;top:107px;">6
        </div>    
        <div group="31" class="box" style="left:480px;top:107px;">7
        </div>
        <!--29-->
        <div group="29" class="box" style="left:205px;top:126px;">1
        </div>
        <div group="29" class="box" style="left:245px;top:126px;">2
        </div>
        <div group="29" class="box" style="left:285px;top:126px;">3
        </div>
        <div group="29" class="box" style="left:325px;top:126px;">4
        </div>
        <!--28-->
        <div group="28" class="box" style="left:200px;top:146px;">1
        </div>
        <div group="28" class="box" style="left:240px;top:146px;">2
        </div>
        <div group="28" class="box" style="left:280px;top:146px;">3
        </div>
        <div group="28" class="box" style="left:320px;top:146px;">4
        </div>
        <div group="28" class="box" style="left:360px;top:146px;">5
        </div>
        <div group="28" class="box" style="left:400px;top:146px;">6
        </div>
        <div group="28" class="box" style="left:440px;top:146px;">7
        </div>
        <div group="28" class="box" style="left:480px;top:146px;">8
        </div>
        <!--27-->
        <div group="27" class="box" style="left:322px;top:166px;">1
        </div>
        <div group="27" class="box" style="left:362px;top:166px;">2
        </div>
        <div group="27" class="box" style="left:402px;top:166px;">3
        </div>
        <!--26-->
        <div group="26" class="box" style="left:472px;top:166px;">1
        </div>
        <div group="26" class="box" style="left:512px;top:166px;">2
        </div>
        <div group="26" class="box" style="left:552px;top:166px;">3
        </div>
        <div group="26" class="box" style="left:592px;top:166px;">4
        </div>
        <div group="26" class="box" style="left:632px;top:166px;">5
        </div>
        <div group="26" class="box" style="left:672px;top:166px;">6
        </div>
        <!--25-->
        <div group="25" class="box" style="left:252px;top:188px;">1
        </div>
        <div group="25" class="box" style="left:292px;top:188px;">2
        </div>
        <div group="25" class="box" style="left:332px;top:188px;">3
        </div>
        <div group="25" class="box" style="left:372px;top:188px;">4
        </div>
        <div group="25" class="box" style="left:412px;top:188px;">5
        </div>
        <div group="25" class="box" style="left:452px;top:188px;">6
        </div>
        <div group="25" class="box" style="left:492px;top:188px;">7
        </div>
        <div group="25" class="box" style="left:532px;top:188px;">8
        </div>
        <div group="25" class="box" style="left:572px;top:188px;">9
        </div>
        <!--24-->
        <div group="24" class="box" style="left:252px;top:210px;">1
        </div>
        <div group="24" class="box" style="left:292px;top:210px;">2
        </div>
        <div group="24" class="box" style="left:332px;top:210px;">3
        </div>
        <div group="24" class="box" style="left:372px;top:210px;">4
        </div>
        <div group="24" class="box" style="left:412px;top:210px;">5
        </div>
        <div group="24" class="box" style="left:452px;top:210px;">6
        </div>
        <div group="24" class="box" style="left:492px;top:210px;">7
        </div>
        <!--23-->
        <div group="23" class="box" style="left:290px;top:232px;">1
        </div>
        <div group="23" class="box" style="left:330px;top:232px;">2
        </div>
        <div group="23" class="box" style="left:370px;top:232px;">3
        </div>
        <div group="23" class="box" style="left:410px;top:232px;">4
        </div>
        <div group="23" class="box" style="left:450px;top:232px;">5
        </div>
        <div group="23" class="box" style="left:490px;top:232px;">6
        </div>
        <div group="23" class="box" style="left:530px;top:232px;">7
        </div>
        <div group="23" class="box" style="left:570px;top:232px;">8
        </div>
        <!--15-->
        <div group="15" class="box" style="left:323px;top:254px;">1
        </div>
        <div group="15" class="box" style="left:363px;top:254px;">2
        </div>
        <div group="15" class="box" style="left:403px;top:254px;">3
        </div>
        <div group="15" class="box" style="left:443px;top:254px;">4
        </div>
        <div group="15" class="box" style="left:483px;top:254px;">5
        </div>
        <div group="15" class="box" style="left:523px;top:254px;">6
        </div>
        <div group="15" class="box" style="left:563px;top:254px;">7
        </div>
        <div group="15" class="box" style="left:603px;top:254px;">8
        </div>
        <div group="15" class="box" style="left:643px;top:254px;">9
        </div>
        <div group="15" class="box" style="left:683px;top:254px;">10
        </div>
        <!--12-->
        <div group="12" class="box" style="left:60px;top:274px;">1
        </div>
        <div group="12" class="box" style="left:100px;top:274px;">2
        </div>
        <div group="12" class="box" style="left:140px;top:274px;">3
        </div>
        <div group="12" class="box" style="left:180px;top:274px;">4
        </div>
        <div group="12" class="box" style="left:220px;top:274px;">5
        </div>
        <div group="12" class="box" style="left:260px;top:274px;">6
        </div>
        <!--14-->
        <div group="14" class="box" style="left:340px;top:275px;">1
        </div>
        <div group="14" class="box" style="left:380px;top:275px;">2
        </div>
        <div group="14" class="box" style="left:420px;top:275px;">3
        </div>
        <div group="14" class="box" style="left:460px;top:275px;">4
        </div>
        <div group="14" class="box" style="left:500px;top:275px;">5
        </div>
        <div group="14" class="box" style="left:540px;top:275px;">6
        </div>
        <div group="14" class="box" style="left:580px;top:275px;">7
        </div>
        <div group="14" class="box" style="left:620px;top:275px;">8
        </div>
        <div group="14" class="box" style="left:660px;top:275px;">9
        </div>
        <div group="14" class="box" style="left:700px;top:275px;">10
        </div>
        <div group="14" class="box" style="left:740px;top:275px;">11
        </div>
        <!--11-->
        <div group="11" class="box" style="left:60px;top:297px;">1
        </div>
        <div group="11" class="box" style="left:100px;top:297px;">2
        </div>
        <div group="11" class="box" style="left:140px;top:297px;">3
        </div>
        <div group="11" class="box" style="left:180px;top:297px;">4
        </div>
        <div group="11" class="box" style="left:220px;top:297px;">5
        </div>
        <!--13-->
        <div group="13" class="box" style="left:368px;top:298px;">1
        </div>
        <div group="13" class="box" style="left:408px;top:298px;">2
        </div>
        <div group="13" class="box" style="left:448px;top:298px;">3
        </div>
        <div group="13" class="box" style="left:488px;top:298px;">4
        </div>
        <!--10-->
        <div group="10" class="box" style="left:108px;top:321px;">1
        </div>
        <div group="10" class="box" style="left:148px;top:321px;">2
        </div>
        <div group="10" class="box" style="left:188px;top:321px;">3
        </div>
        <div group="10" class="box" style="left:228px;top:321px;">4
        </div>
        <div group="10" class="box" style="left:268px;top:321px;">5
        </div>
        <div group="10" class="box" style="left:308px;top:321px;">6
        </div>
        <div group="10" class="box" style="left:348px;top:321px;">7
        </div>
        <div group="10" class="box" style="left:388px;top:321px;">8
        </div>
        <div group="10" class="box" style="left:428px;top:321px;">9
        </div>
        <div group="10" class="box" style="left:468px;top:321px;">10
        </div>
        <!--9-->
        <div group="9" class="box" style="left:108px;top:343px;">1
        </div>
        <div group="9" class="box" style="left:148px;top:343px;">2
        </div>
        <div group="9" class="box" style="left:188px;top:343px;">3
        </div>
        <div group="9" class="box" style="left:228px;top:343px;">4
        </div>
        <div group="9" class="box" style="left:268px;top:343px;">5
        </div>
        <div group="9" class="box" style="left:308px;top:343px;">6
        </div>
        <div group="9" class="box" style="left:348px;top:343px;">7
        </div>
        <div group="9" class="box" style="left:388px;top:343px;">8
        </div>
        <div group="9" class="box" style="left:428px;top:343px;">9
        </div>
        <div group="9" class="box" style="left:468px;top:343px;">10
        </div>
        <!--8-->
        <div group="8" class="box" style="left:108px;top:365px;">1
        </div>
        <div group="8" class="box" style="left:148px;top:365px;">2
        </div>
        <div group="8" class="box" style="left:188px;top:365px;">3
        </div>
        <div group="8" class="box" style="left:228px;top:365px;">4
        </div>
        <div group="8" class="box" style="left:268px;top:365px;">5
        </div>
        <div group="8" class="box" style="left:308px;top:365px;">6
        </div>
        <div group="8" class="box" style="left:348px;top:365px;">7
        </div>
        <div group="8" class="box" style="left:388px;top:365px;">8
        </div>
        <div group="8" class="box" style="left:428px;top:365px;">9
        </div>
        <div group="8" class="box" style="left:468px;top:365px;">10
        </div>
        <!--7-->
        <div group="7" class="box" style="left:130px;top:386px;">1
        </div>
        <div group="7" class="box" style="left:170px;top:386px;">2
        </div>
        <div group="7" class="box" style="left:210px;top:386px;">3
        </div>
        <div group="7" class="box" style="left:250px;top:386px;">4
        </div>
        <div group="7" class="box" style="left:290px;top:386px;">5
        </div>
        <div group="7" class="box" style="left:330px;top:386px;">6
        </div>
        <div group="7" class="box" style="left:370px;top:386px;">7
        </div>
        <div group="7" class="box" style="left:410px;top:386px;">8
        </div>
        <div group="7" class="box" style="left:450px;top:386px;">9
        </div>
        <div group="7" class="box" style="left:490px;top:386px;">10
        </div>
        <div group="7" class="box" style="left:530px;top:386px;">11
        </div>
        <!--6-->
        <div group="6" class="box" style="left:103px;top:408px;">1
        </div>
        <div group="6" class="box" style="left:143px;top:408px;">2
        </div>
        <div group="6" class="box" style="left:183px;top:408px;">3
        </div>
        <div group="6" class="box" style="left:223px;top:408px;">4
        </div>
        <div group="6" class="box" style="left:263px;top:408px;">5
        </div>
        <div group="6" class="box" style="left:303px;top:408px;">6
        </div>
        <div group="6" class="box" style="left:343px;top:408px;">7
        </div>
        <div group="6" class="box" style="left:383px;top:408px;">8
        </div>
        <div group="6" class="box" style="left:423px;top:408px;">9
        </div>
        <div group="6" class="box" style="left:463px;top:408px;">10
        </div>
        <div group="6" class="box" style="left:503px;top:408px;">11
        </div>
        <div group="6" class="box" style="left:543px;top:408px;">12
        </div>
        <!--5-->
        <div group="5" class="box" style="left:103px;top:430px;">1
        </div>
        <div group="5" class="box" style="left:143px;top:430px;">2
        </div>
        <div group="5" class="box" style="left:183px;top:430px;">3
        </div>
        <div group="5" class="box" style="left:223px;top:430px;">4
        </div>
        <div group="5" class="box" style="left:263px;top:430px;">5
        </div>
        <div group="5" class="box" style="left:303px;top:430px;">6
        </div>
        <div group="5" class="box" style="left:343px;top:430px;">7
        </div>
        <div group="5" class="box" style="left:383px;top:430px;">8
        </div>
        <div group="5" class="box" style="left:423px;top:430px;">9
        </div>
        <div group="5" class="box" style="left:463px;top:430px;">10
        </div>
        <div group="5" class="box" style="left:503px;top:430px;">11
        </div>
        <div group="5" class="box" style="left:543px;top:430px;">12
        </div>
        <!--4-->
        <div group="4" class="box" style="left:103px;top:453px;">1
        </div>
        <div group="4" class="box" style="left:143px;top:453px;">2
        </div>
        <div group="4" class="box" style="left:183px;top:453px;">3
        </div>
        <div group="4" class="box" style="left:223px;top:453px;">4
        </div>
        <div group="4" class="box" style="left:263px;top:453px;">5
        </div>
        <div group="4" class="box" style="left:303px;top:453px;">6
        </div>
        <div group="4" class="box" style="left:343px;top:453px;">7
        </div>
        <div group="4" class="box" style="left:383px;top:453px;">8
        </div>
        <div group="4" class="box" style="left:423px;top:453px;">9
        </div>
        <div group="4" class="box" style="left:463px;top:453px;">10
        </div>
        <!--3-->
        <div group="3" class="box" style="left:103px;top:475px;">1
        </div>
        <div group="3" class="box" style="left:143px;top:475px;">2
        </div>
        <div group="3" class="box" style="left:183px;top:475px;">3
        </div>
        <div group="3" class="box" style="left:223px;top:475px;">4
        </div>
        <div group="3" class="box" style="left:263px;top:475px;">5
        </div>
        <div group="3" class="box" style="left:303px;top:475px;">6
        </div>
        <div group="3" class="box" style="left:343px;top:475px;">7
        </div>
        <div group="3" class="box" style="left:383px;top:475px;">8
        </div>
        <div group="3" class="box" style="left:423px;top:475px;">9
        </div>
        <div group="3" class="box" style="left:463px;top:475px;">10
        </div>
        <div group="3" class="box" style="left:503px;top:475px;">11
        </div>
        <!--2-->
        <div group="2" class="box" style="left:125px;top:500px;">1
        </div>
        <div group="2" class="box" style="left:165px;top:500px;">2
        </div>
        <div group="2" class="box" style="left:205px;top:500px;">3
        </div>
        <div group="2" class="box" style="left:245px;top:500px;">4
        </div>
        <div group="2" class="box" style="left:285px;top:500px;">5
        </div>
        <div group="2" class="box" style="left:325px;top:500px;">6
        </div>
        <div group="2" class="box" style="left:365px;top:500px;">7
        </div>
        <div group="2" class="box" style="left:405px;top:500px;">8
        </div>
        <div group="2" class="box" style="left:445px;top:500px;">9
        </div>
        <div group="2" class="box" style="left:485px;top:500px;">10
        </div>
        <!--22-->
        <div group="22" class="box" style="left:330px;top:542px;">1
        </div>
        <div group="22" class="box" style="left:370px;top:542px;">2
        </div>
        <div group="22" class="box" style="left:410px;top:542px;">3
        </div>
        <div group="22" class="box" style="left:450px;top:542px;">4
        </div>
        <div group="22" class="box" style="left:490px;top:542px;">5
        </div>
        <!--21-->
        <div group="21" class="box" style="left:310px;top:564px;">1
        </div>
        <div group="21" class="box" style="left:350px;top:564px;">2
        </div>
        <div group="21" class="box" style="left:390px;top:564px;">3
        </div>
        <div group="21" class="box" style="left:430px;top:564px;">4
        </div>
        <div group="21" class="box" style="left:470px;top:564px;">5
        </div>
        <div group="21" class="box" style="left:510px;top:564px;">6
        </div>
        <!--20-->
        <div group="20" class="box" style="left:250px;top:588px;">1
        </div>
        <div group="20" class="box" style="left:290px;top:588px;">2
        </div>
        <div group="20" class="box" style="left:330px;top:588px;">3
        </div>
        <div group="20" class="box" style="left:370px;top:588px;">4
        </div>
        <div group="20" class="box" style="left:410px;top:588px;">5
        </div>
        <div group="20" class="box" style="left:450px;top:588px;">6
        </div>
        <!--19-->
        <div group="19" class="box" style="left:250px;top:610px;">1
        </div>
        <div group="19" class="box" style="left:290px;top:610px;">2
        </div>
        <div group="19" class="box" style="left:330px;top:610px;">3
        </div>
	    							</div>
	    						</div>
							</div>
						</div>
					</div>
				</div>
			<div id="rbox_bottomcenter" >
				<div id="rbox_bottomleft">
					<div id="rbox_bottomright"></div>
				</div>
			</div>
			</div>
		</td>
		<!--右侧区域end-->
	</tr>
</table>
<!--引入组件start-->
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<!--引入弹窗组件end-->
</body>
</html>
