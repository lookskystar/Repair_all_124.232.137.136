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
		BACKGROUND:#328aa4;
		COLOR: #fff;
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
	                width:568,
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
		//jkmegamenu.definemenu("megaanchor1", "megamenu1", "mouseover");
		//jkmegamenu.definemenu("megaanchor2", "megamenu2", "mouseover");
		//jkmegamenu.definemenu("megaanchor3", "megamenu3", "mouseover");
		//jkmegamenu.definemenu("megaanchor4", "megamenu4", "mouseover");
		//jkmegamenu.definemenu("megaanchor5", "megamenu5", "mouseover");
		
		var wd = window.screen.width-36;
		$("#bs_left").css("width",wd); 
	});
	
	function clickGD(rjhmId){
		var url="<%=basePath %>report!getInfoDetail.do?rjhmId="+rjhmId;
		$(document).ready(function () {
           	dd =$.dialog({
                title:"机车信息",
                content:'url:'+url+'&temp='+new Date().getTime(),
                height:500,
                width:568,
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
								            	<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">序号</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 10%;font-weight: bolder;">机车号</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">修程</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">股道</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">台位</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">扣车时间</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">计划起机时间<br>实际起机时间</th>
									            <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">计划交车时间<br>实际交车时间</th>
									            <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">交车工长</th>
									            <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">状态</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bolder;">报活操作</th>
								                <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 20%;font-weight: bolder;">记录查看</th>
							         	   </tr>		
								            <c:forEach items="${allJC }" var="plan" varStatus="index">
									            <tr>
									            	<td align="center">${index.index+1 }</td>
									                <td align="center">
									                   <c:if test="${plan.projectType==0}">
									                       <a style="position:static;color: #0080e1;" href="<%=basePath%>query!getInfoByJC.do?rjhmId=${plan.rjhmId}&jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque}" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque}</a>
									                   </c:if>
									                   <c:if test="${plan.projectType==1}">
									                       <a style="position:static;color: #0080e1;" href="<%=basePath%>query!getZxInfoByJC.do?rjhmId=${plan.rjhmId}" target="_blakn">${plan.jcType }-${plan.jcnum }-${plan.fixFreque}</a>
									                   </c:if>
									                </td>
									                <td align="center">
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'N')}">年检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'BN')}">半年检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'F')}">辅修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'X')}">小修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'Z')&&!fn:endsWith(plan.fixFreque,'ZZ')}">中修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'L')}">临修</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'JG')}">加改</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'JJ')}">季检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'YJ')}">月检</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'ZQ')}">周期整治</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'ZZ')}">整治</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'CJ')}">春鉴</c:if>
									                  <c:if test="${fn:startsWith(plan.fixFreque, 'QZ')}">秋整</c:if>
									                </td>
									                <td align="center"><a style="position:static;color: #0080e1;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
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
										            	<a href="reportWorkManage!reportWork.action?id=${plan.rjhmId}" style="position:static;color: #0080e1;">我报的活</a>
										            </td>
										             <td align="center" style="width: 100px;">
										                <c:if test="${plan.projectType==0}">
										            		<a href="<%=basePath%>query!view.do?id=${plan.rjhmId}&jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque }&rjhmId=${plan.rjhmId }" target="_blank" style="position:static;color: #0080e1;">检修记录</a>&nbsp;
										            	</c:if>
										            	<c:if test="${plan.projectType==1}">
										            		<a href="<%=basePath%>query!zxView.do?id=${plan.rjhmId}" target="_blank" style="position:static;color: #0080e1;">检修记录</a>&nbsp;
										            	</c:if>
										            		<a href="<%=basePath %>query!getAllInfoPre.do?id=${plan.rjhmId}" target="_blank" style="position:static;color: #0080e1;">报活记录</a>&nbsp;
										            	<c:if test="${plan.projectType==0}">
															<a href="<%=basePath%>query!searchJcRec.do?rjhmId=${plan.rjhmId}&jcStype=${plan.jcType }" target="_blank" style="position:static;color: #0080e1;">交车记录</a>&nbsp;
														</c:if>
														<c:if test="${plan.projectType==1}">
															<a href="<%=basePath %>query!viewExperiment.do?id=${plan.rjhmId}&jceiId=5" target="_blank" style="position:static;color: #0080e1;">试验记录</a>&nbsp;
														</c:if>
														<c:if test="${plan.projectType==0}">
																<a href="<%=basePath %>oilAssay!searchOilAssayRecorderDaily.do?rjhmId=${plan.rjhmId }" target="_blank" style="position:static;color: #0080e1;">油水化验记录</a>
														</c:if>
														<c:if test="${plan.projectType==1}">
																<a href="<%=basePath %>query!findJCPJ.do?rjhmId=${plan.rjhmId }" target="_blank" style="position:static;color: #0080e1;">配件检修记录</a>
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
        <!--16-->
        <div group="16" class="box" style="left:125px;top:172px;">1 
        </div>
        <div group="16" class="box" style="left:165px;top:172px;">2 
        </div>
        <div group="16" class="box" style="left:205px;top:172px;">3 
        </div>
        <div group="16" class="box" style="left:245px;top:172px;">4 
        </div>
        <div group="16" class="box" style="left:285px;top:172px;">5 
        </div>
        <div group="16" class="box" style="left:325px;top:172px;">6 
        </div>
        <div group="16" class="box" style="left:365px;top:172px;">7 
        </div>
        <!--37-->
        <div group="37" class="box" style="left:525px;top:172px;">1 
        </div>
        <div group="37" class="box" style="left:565px;top:172px;">2 
        </div>
        <div group="37" class="box" style="left:605px;top:172px;">3 
        </div>
        <!--17-->
        <div group="17" class="box" style="left:145px;top:245px;">1 
        </div>
        <div group="17" class="box" style="left:185px;top:245px;">2 
        </div>
        <div group="17" class="box" style="left:225px;top:245px;">3 
        </div>
        <div group="17" class="box" style="left:265px;top:245px;">4 
        </div>
        <div group="17" class="box" style="left:305px;top:245px;">5 
        </div>
        <div group="17" class="box" style="left:345px;top:245px;">6 
        </div>
        <div group="17" class="box" style="left:385px;top:245px;">7 
        </div>
        <!--19-->
        <div group="19" class="box" style="left:555px;top:242px;">1 
        </div>
        <div group="19" class="box" style="left:595px;top:242px;">2 
        </div>
        <!--18-->
        <div group="18" class="box" style="left:175px;top:318px;">1 
        </div>
        <div group="18" class="box" style="left:215px;top:318px;">2 
        </div>
        <div group="18" class="box" style="left:255px;top:318px;">3 
        </div>
        <div group="18" class="box" style="left:295px;top:318px;">4 
        </div>
        <div group="18" class="box" style="left:335px;top:318px;">5
        </div>
        <div group="18" class="box" style="left:375px;top:318px;">6 
        </div>
        <div group="18" class="box" style="left:415px;top:318px;">7 
        </div>       
        <!--33-->
        <div group="33" class="box" style="left:295px;top:464px;">1 
        </div>
        <div group="33" class="box" style="left:335px;top:464px;">2 
        </div>
        <div group="33" class="box" style="left:375px;top:464px;">3 
        </div>
        <div group="33" class="box" style="left:415px;top:464px;">4 
        </div>
        <!--34-->
        <div group="34" class="box" style="left:295px;top:540px;">1 
        </div>
        <div group="34" class="box" style="left:335px;top:540px;">2 
        </div>
        <div group="34" class="box" style="left:375px;top:540px;">3 
        </div>
        <div group="34" class="box" style="left:415px;top:540px;">4 
        </div>
        <!--35-->
        <div group="35" class="box" style="left:295px;top:610px;">1 
        </div>
        <div group="35" class="box" style="left:335px;top:610px;">2 
        </div>
		<div group="35" class="box" style="left:375px;top:610px;">3 
        </div>
        <div group="35" class="box" style="left:415px;top:610px;">4 
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
