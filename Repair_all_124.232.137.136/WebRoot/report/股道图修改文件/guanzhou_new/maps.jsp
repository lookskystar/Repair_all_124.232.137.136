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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/bsFormat.js"></script>
<!--框架必需end-->

<!--引入组件start-->
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<!--引入弹窗组件end-->

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

</script>
</head>

<body>
<br/>
 <center>
 		<table id="tab" style=" width:70%; height:30px;margin-top:0px; ">	
		    <tr>
			  <td style="font-size: 13px;margin-top: 10px;"><a href="<%=basePath %>report/select_main.jsp" id="megaanchor1">机车检修管理</a>
			    <div id="megamenu1" class="simplemenu" style="width:100px;">
					<ul>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=Z&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">中&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=X&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">小&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=F&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">辅&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=LX&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">临&nbsp;&nbsp;修</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=JG&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">加&nbsp;&nbsp;改</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=QZ&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">整&nbsp;&nbsp;治</a></li>
						<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=CJ&startTime=''&endTime=''&jcType=0&jcNum=0" target="_blank">春&nbsp;&nbsp;鉴</a></li>
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
				<div id="lbox_topcenter">
					<div id="lbox_topleft">
						<div id="lbox_topright">
							<div class="lbox_title">操作菜单</div>
						</div>
					</div>
				</div>
				
				<div id="lbox_middlecenter" >
					<div id="lbox_middleleft">
						<div id="lbox_middleright" >
							<div id="bs_left" style="width:500px; height:525px;">
									<div id="lists">
								    	<table id="listitems">
								        	<tr>
								            	<th>序号</th>
								                <th>机车号</th>
								                <th>修程</th>
								                <th>股道</th>
								                <th>扣车时间</th>
								                <th>计划起机时间<br/>实际起机时间</th>
									            <th>计划交车时间<br/>实际交车时间</th>
									            <th>状态</th>
								            	<th>备注</th>
							         	   </tr>	
								            <c:forEach items="${allJC }" var="plan" varStatus="index">
									            <tr>
									            	<td align="center">${index.index+1 }</td>
									                <td align="center"><a style="position:static;" href="<%=basePath%>query!getInfoByJC.do?jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque}" target="_blakn">${plan.jcType }-${plan.jcnum }</a></td>
									                <td align="center">${plan.fixFreque }</td>
									                <td align="center"><a style="position:static;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
									                <td align="center">${fn:substring(plan.kcsj,5,16) }</td>
									                <td align="center">${fn:substring(plan.jhqjsj,5,16) }<br/>${fn:substring(plan.sjqjsj,5,16) }</td>
									                <td align="center">${fn:substring(plan.jhjcsj,5,16) }<br/>${fn:substring(plan.sjjcsj,5,16) }</td>
									                <td>
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
										            <td align="center" style="width: 100px;">${plan.comments }</td>
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
        <div group="39" class="box" style="left:30px;top:65px;">1 
        </div>
        <div group="39" class="box" style="left:70px;top:65px;">2 
        </div>
        <div group="39" class="box" style="left:110px;top:65px;">3 
        </div>
        <div group="39" class="box" style="left:150px;top:65px;">4 
        </div>
        <div group="39" class="box" style="left:190px;top:65px;">5 
        </div>
        <!--37-->
        <div group="37" class="box" style="left:326px;top:65px;">1 
        </div>
        <div group="37" class="box" style="left:366px;top:65px;">2 
        </div>
        <div group="37" class="box" style="left:406px;top:65px;">3 
        </div>
        <div group="37" class="box" style="left:446px;top:65px;">4 
        </div>
        <div group="37" class="box" style="left:486px;top:65px;">5 
        </div>
        <div group="37" class="box" style="left:526px;top:65px;">6 
        </div>
        <div group="37" class="box" style="left:566px;top:65px;">7 
        </div>
        <div group="37" class="box" style="left:606px;top:65px;">8 
        </div>
        <div group="37" class="box" style="left:646px;top:65px;">9 
        </div>
        <div group="37" class="box" style="left:686px;top:65px;">10
        </div>
        <div group="37" class="box" style="left:726px;top:65px;">11 
        </div>
        <div group="37" class="box" style="left:766px;top:65px;">12 
        </div>
        <!--36-->
        <div group="36" class="box" style="left:200px;top:97px;">1
        </div>
        <div group="36" class="box" style="left:240px;top:97px;">2
        </div>
        <div group="36" class="box" style="left:280px;top:97px;">3
        </div>
        <div group="36" class="box" style="left:320px;top:97px;">4
        </div>
        <div group="36" class="box" style="left:360px;top:97px;">5
        </div>
        <div group="36" class="box" style="left:400px;top:97px;">6
        </div>
        <div group="36" class="box" style="left:440px;top:97px;">7
        </div>
        <div group="36" class="box" style="left:480px;top:97px;">8
        </div>
        <div group="36" class="box" style="left:520px;top:97px;">9
        </div>
        <div group="36" class="box" style="left:560px;top:97px;">10
        </div>
        <div group="36" class="box" style="left:600px;top:97px;">11
        </div>
        <div group="36" class="box" style="left:640px;top:97px;">12
        </div>
        <!--35-->
        <div group="35" class="box" style="left:200px;top:127px;">1
        </div>
        <div group="35" class="box" style="left:240px;top:127px;">2
        </div>
        <div group="35" class="box" style="left:280px;top:127px;">3
        </div>
        <div group="35" class="box" style="left:320px;top:127px;">4
        </div>
        <div group="35" class="box" style="left:360px;top:127px;">5
        </div>
        <div group="35" class="box" style="left:400px;top:127px;">6
        </div>
        <div group="35" class="box" style="left:440px;top:127px;">7
        </div>
        <div group="35" class="box" style="left:480px;top:127px;">8
        </div>
        <div group="35" class="box" style="left:520px;top:127px;">9
        </div>
        <div group="35" class="box" style="left:560px;top:127px;">10
        </div>
        <div group="35" class="box" style="left:600px;top:127px;">11
        </div>
        <div group="35" class="box" style="left:640px;top:127px;">12
        </div>
        <!--34-->
        <div group="34" class="box" style="left:95px;top:160px;">1
        </div>
        <div group="34" class="box" style="left:135px;top:160px;">2
        </div>
        <div group="34" class="box" style="left:175px;top:160px;">3
        </div>
        <div group="34" class="box" style="left:215px;top:160px;">4
        </div>
        <!--33-->
        <div group="33" class="box" style="left:320px;top:160px;">1
        </div>
        <div group="33" class="box" style="left:360px;top:160px;">2
        </div>
        <div group="33" class="box" style="left:400px;top:160px;">3
        </div>
        <div group="33" class="box" style="left:440px;top:160px;">4
        </div>
        <div group="33" class="box" style="left:480px;top:160px;">5
        </div>
        <div group="33" class="box" style="left:520px;top:160px;">6
        </div>
        <div group="33" class="box" style="left:560px;top:160px;">7
        </div>
        <!--32-->
        <div group="32" class="box" style="left:320px;top:195px;">1
        </div>
        <div group="32" class="box" style="left:360px;top:195px;">2
        </div>
        <div group="32" class="box" style="left:400px;top:195px;">3
        </div>
        <div group="32" class="box" style="left:440px;top:195px;">4
        </div>
        <div group="32" class="box" style="left:480px;top:195px;">5
        </div>
        <div group="32" class="box" style="left:520px;top:195px;">6
        </div>
        <div group="32" class="box" style="left:560px;top:195px;">7
        </div>
        <!--31-->
        <div group="31" class="box" style="left:320px;top:225px;">1
        </div>
        <div group="31" class="box" style="left:360px;top:225px;">2
        </div>    
        <div group="31" class="box" style="left:400px;top:225px;">3
        </div>    
        <div group="31" class="box" style="left:440px;top:225px;">4
        </div>    
        <div group="31" class="box" style="left:480px;top:225px;">5
        </div>    
        <div group="31" class="box" style="left:520px;top:225px;">6
        </div>    
        <div group="31" class="box" style="left:560px;top:225px;">7
        </div>
        <!--29-->
        <div group="29" class="box" style="left:360px;top:258px;">1
        </div>
        <div group="29" class="box" style="left:400px;top:258px;">2
        </div>
        <div group="29" class="box" style="left:440px;top:258px;">3
        </div>
        <div group="29" class="box" style="left:480px;top:258px;">4
        </div>
        <!--28-->
        <div group="28" class="box" style="left:300px;top:290px;">1
        </div>
        <div group="28" class="box" style="left:340px;top:290px;">2
        </div>
        <div group="28" class="box" style="left:380px;top:290px;">3
        </div>
        <div group="28" class="box" style="left:420px;top:290px;">4
        </div>
        <div group="28" class="box" style="left:460px;top:290px;">5
        </div>
        <div group="28" class="box" style="left:500px;top:290px;">6
        </div>
        <div group="28" class="box" style="left:540px;top:290px;">7
        </div>
        <div group="28" class="box" style="left:580px;top:290px;">8
        </div>
        <!--27-->
        <div group="27" class="box" style="left:342px;top:325px;">1
        </div>
        <div group="27" class="box" style="left:382px;top:325px;">2
        </div>
        <div group="27" class="box" style="left:422px;top:325px;">3
        </div>
        <!--26-->
        <div group="26" class="box" style="left:592px;top:325px;">1
        </div>
        <div group="26" class="box" style="left:632px;top:325px;">2
        </div>
        <div group="26" class="box" style="left:672px;top:325px;">3
        </div>
        <div group="26" class="box" style="left:712px;top:325px;">4
        </div>
        <div group="26" class="box" style="left:752px;top:325px;">5
        </div>
        <div group="26" class="box" style="left:792px;top:325px;">6
        </div>
        <!--25-->
        <div group="25" class="box" style="left:400px;top:360px;">1
        </div>
        <div group="25" class="box" style="left:440px;top:360px;">2
        </div>
        <div group="25" class="box" style="left:480px;top:360px;">3
        </div>
        <div group="25" class="box" style="left:520px;top:360px;">4
        </div>
        <div group="25" class="box" style="left:560px;top:360px;">5
        </div>
        <div group="25" class="box" style="left:600px;top:360px;">6
        </div>
        <div group="25" class="box" style="left:640px;top:360px;">7
        </div>
        <div group="25" class="box" style="left:680px;top:360px;">8
        </div>
        <div group="25" class="box" style="left:720px;top:360px;">9
        </div>
        <!--24-->
        <div group="24" class="box" style="left:390px;top:390px;">1
        </div>
        <div group="24" class="box" style="left:430px;top:390px;">2
        </div>
        <div group="24" class="box" style="left:470px;top:390px;">3
        </div>
        <div group="24" class="box" style="left:510px;top:390px;">4
        </div>
        <div group="24" class="box" style="left:550px;top:390px;">5
        </div>
        <div group="24" class="box" style="left:590px;top:390px;">6
        </div>
        <div group="24" class="box" style="left:630px;top:390px;">7
        </div>
        <!--23-->
        <div group="23" class="box" style="left:400px;top:422px;">1
        </div>
        <div group="23" class="box" style="left:440px;top:422px;">2
        </div>
        <div group="23" class="box" style="left:480px;top:422px;">3
        </div>
        <div group="23" class="box" style="left:520px;top:422px;">4
        </div>
        <div group="23" class="box" style="left:560px;top:422px;">5
        </div>
        <div group="23" class="box" style="left:600px;top:422px;">6
        </div>
        <div group="23" class="box" style="left:640px;top:422px;">7
        </div>
        <div group="23" class="box" style="left:680px;top:422px;">8
        </div>
        <!--15-->
        <div group="15" class="box" style="left:423px;top:455px;">1
        </div>
        <div group="15" class="box" style="left:463px;top:455px;">2
        </div>
        <div group="15" class="box" style="left:503px;top:455px;">3
        </div>
        <div group="15" class="box" style="left:543px;top:455px;">4
        </div>
        <div group="15" class="box" style="left:583px;top:455px;">5
        </div>
        <div group="15" class="box" style="left:623px;top:455px;">6
        </div>
        <div group="15" class="box" style="left:663px;top:455px;">7
        </div>
        <div group="15" class="box" style="left:703px;top:455px;">8
        </div>
        <div group="15" class="box" style="left:743px;top:455px;">9
        </div>
        <div group="15" class="box" style="left:783px;top:455px;">10
        </div>
        <!--12-->
        <div group="12" class="box" style="left:90px;top:490px;">1
        </div>
        <div group="12" class="box" style="left:130px;top:490px;">2
        </div>
        <div group="12" class="box" style="left:170px;top:490px;">3
        </div>
        <div group="12" class="box" style="left:210px;top:490px;">4
        </div>
        <div group="12" class="box" style="left:250px;top:490px;">5
        </div>
        <div group="12" class="box" style="left:290px;top:490px;">6
        </div>
        <!--14-->
        <div group="14" class="box" style="left:400px;top:490px;">1
        </div>
        <div group="14" class="box" style="left:440px;top:490px;">2
        </div>
        <div group="14" class="box" style="left:480px;top:490px;">3
        </div>
        <div group="14" class="box" style="left:520px;top:490px;">4
        </div>
        <div group="14" class="box" style="left:560px;top:490px;">5
        </div>
        <div group="14" class="box" style="left:600px;top:490px;">6
        </div>
        <div group="14" class="box" style="left:640px;top:490px;">7
        </div>
        <div group="14" class="box" style="left:680px;top:490px;">8
        </div>
        <div group="14" class="box" style="left:720px;top:490px;">9
        </div>
        <div group="14" class="box" style="left:760px;top:490px;">10
        </div>
        <div group="14" class="box" style="left:800px;top:490px;">11
        </div>
        <!--11-->
        <div group="11" class="box" style="left:90px;top:520px;">1
        </div>
        <div group="11" class="box" style="left:130px;top:520px;">2
        </div>
        <div group="11" class="box" style="left:170px;top:520px;">3
        </div>
        <div group="11" class="box" style="left:210px;top:520px;">4
        </div>
        <div group="11" class="box" style="left:250px;top:520px;">5
        </div>
        <!--13-->
        <div group="13" class="box" style="left:428px;top:522px;">1
        </div>
        <div group="13" class="box" style="left:468px;top:522px;">2
        </div>
        <div group="13" class="box" style="left:508px;top:522px;">3
        </div>
        <div group="13" class="box" style="left:548px;top:522px;">4
        </div>
        <!--10-->
        <div group="10" class="box" style="left:188px;top:560px;">1
        </div>
        <div group="10" class="box" style="left:228px;top:560px;">2
        </div>
        <div group="10" class="box" style="left:268px;top:560px;">3
        </div>
        <div group="10" class="box" style="left:308px;top:560px;">4
        </div>
        <div group="10" class="box" style="left:348px;top:560px;">5
        </div>
        <div group="10" class="box" style="left:388px;top:560px;">6
        </div>
        <div group="10" class="box" style="left:428px;top:560px;">7
        </div>
        <div group="10" class="box" style="left:468px;top:560px;">8
        </div>
        <div group="10" class="box" style="left:508px;top:560px;">9
        </div>
        <div group="10" class="box" style="left:548px;top:560px;">10
        </div>
        <!--9-->
        <div group="9" class="box" style="left:140px;top:595px;">1
        </div>
        <div group="9" class="box" style="left:180px;top:595px;">2
        </div>
        <div group="9" class="box" style="left:220px;top:595px;">3
        </div>
        <div group="9" class="box" style="left:260px;top:595px;">4
        </div>
        <div group="9" class="box" style="left:300px;top:595px;">5
        </div>
        <div group="9" class="box" style="left:340px;top:595px;">6
        </div>
        <div group="9" class="box" style="left:380px;top:595px;">7
        </div>
        <div group="9" class="box" style="left:420px;top:595px;">8
        </div>
        <div group="9" class="box" style="left:460px;top:595px;">9
        </div>
        <div group="9" class="box" style="left:500px;top:595px;">10
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
</body>
</html>
