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
								       <!--4-->
        								<div group="4" class="box" style="left:115px;top:83px;">1</div>
        								<div group="4" class="box" style="left:155px;top:83px;">2</div>
        								<div group="4" class="box" style="left:195px;top:83px;">3</div>
        								<div group="4" class="box" style="left:235px;top:83px;">4</div>
        								<!--13-->
        								<div group="13" class="box" style="left:340px;top:83px;">1</div>
        								<div group="13" class="box" style="left:380px;top:83px;">2</div>
        								<div group="13" class="box" style="left:420px;top:83px;">3</div>
        								<div group="13" class="box" style="left:460px;top:83px;">4</div>
        								<div group="13" class="box" style="left:500px;top:83px;">5</div>
        								<div group="13" class="box" style="left:540px;top:83px;">6</div>
        								<div group="13" class="box" style="left:580px;top:83px;">7</div>
        								<!--30-->
        								<div group="30" class="box" style="left:70px;top:107px;">1</div>
        								<div group="30" class="box" style="left:110px;top:107px;">2</div>
        								<div group="30" class="box" style="left:150px;top:107px;">3</div>
        								<div group="30" class="box" style="left:190px;top:107px;">4</div>
        								<div group="30" class="box" style="left:230px;top:107px;">5</div>
        								<div group="30" class="box" style="left:270px;top:107px;">6</div>
        								<div group="30" class="box" style="left:310px;top:107px;">7</div>
        								<!--14-->
        								<div group="14" class="box" style="left:475px;top:110px;">1</div>
        								<div group="14" class="box" style="left:515px;top:110px;">2</div>
        								<div group="14" class="box" style="left:555px;top:110px;">3</div>
        								<div group="14" class="box" style="left:595px;top:110px;">4</div>
        								<div group="14" class="box" style="left:635px;top:110px;">5</div>
        								<div group="14" class="box" style="left:675px;top:110px;">6</div>
        								<div group="14" class="box" style="left:715px;top:110px;">7</div>
        								<!--15-->
        								<div group="15" class="box" style="left:343px;top:135px;">1</div>
        								<div group="15" class="box" style="left:383px;top:135px;">2</div>
        								<div group="15" class="box" style="left:423px;top:135px;">3</div>
        								<div group="15" class="box" style="left:463px;top:135px;">4</div>
        								<div group="15" class="box" style="left:503px;top:135px;">5</div>
        								<div group="15" class="box" style="left:543px;top:135px;">6</div>
        								<!--16-->
        								<div group="16" class="box" style="left:137px;top:160px;">1</div>
        								<div group="16" class="box" style="left:177px;top:160px;">2</div>
        								<div group="16" class="box" style="left:217px;top:160px;">3</div>
        								<div group="16" class="box" style="left:257px;top:160px;">4</div>
        								<div group="16" class="box" style="left:297px;top:160px;">5</div>
        								<div group="16" class="box" style="left:337px;top:160px;">6</div>
        								<div group="16" class="box" style="left:377px;top:160px;">7</div>
        								<div group="16" class="box" style="left:417px;top:160px;">8</div>
        								<div group="16" class="box" style="left:457px;top:160px;">9</div>
        								<!--17-->
        								<div group="17" class="box" style="left:170px;top:188px;">1</div>
        								<div group="17" class="box" style="left:210px;top:188px;">2</div>
        								<div group="17" class="box" style="left:250px;top:188px;">3</div>
        								<div group="17" class="box" style="left:290px;top:188px;">4</div>
        								<div group="17" class="box" style="left:330px;top:188px;">5</div>
        								<div group="17" class="box" style="left:370px;top:188px;">6</div>
        								<div group="17" class="box" style="left:410px;top:188px;">7</div>
        								<div group="17" class="box" style="left:450px;top:188px;">8</div>
        								<div group="17" class="box" style="left:490px;top:188px;">9</div>
        								<!--18-->
        								<div group="18" class="box" style="left:186px;top:216px;">1</div>
        								<div group="18" class="box" style="left:226px;top:216px;">2</div>
        								<div group="18" class="box" style="left:266px;top:216px;">3</div>
        								<div group="18" class="box" style="left:306px;top:216px;">3</div>
        								<!--19-->
        								<div group="19" class="box" style="left:410px;top:216px;">1</div>
        								<div group="19" class="box" style="left:450px;top:216px;">2</div>
        								<div group="19" class="box" style="left:490px;top:216px;">3</div>
        								<div group="19" class="box" style="left:530px;top:216px;">4</div>
        								<div group="19" class="box" style="left:570px;top:216px;">5</div>
        								<!--50-->
        								<div group="50" class="box" style="left:158px;top:240px;">1</div>
        								<div group="50" class="box" style="left:198px;top:240px;">2</div>
        								<div group="50" class="box" style="left:238px;top:240px;">3</div>
        								<div group="50" class="box" style="left:278px;top:240px;">4</div>
        								<div group="50" class="box" style="left:318px;top:240px;">5</div>
        								<div group="50" class="box" style="left:358px;top:240px;">6</div>
        								<!--40-->
        								<div group="40" class="box" style="left:498px;top:240px;">1</div>
        								<div group="40" class="box" style="left:538px;top:240px;">2</div>
        								<div group="40" class="box" style="left:578px;top:240px;">3</div>
        								<div group="40" class="box" style="left:618px;top:240px;">4</div>
        								<div group="40" class="box" style="left:658px;top:240px;">5</div>
        								<div group="40" class="box" style="left:698px;top:240px;">6</div>
        								<!--51-->
        								<div group="51" class="box" style="left:188px;top:268px;">1</div>
        								<div group="51" class="box" style="left:228px;top:268px;">2</div>
        								<div group="51" class="box" style="left:268px;top:268px;">3</div>
        								<div group="51" class="box" style="left:308px;top:268px;">4</div>
        								<div group="51" class="box" style="left:348px;top:268px;">5</div>
        								<div group="51" class="box" style="left:388px;top:268px;">6</div>
        								<!-- 41 -->
        								<div group="41" class="box" style="left:498px;top:268px;">1</div>
        								<div group="41" class="box" style="left:538px;top:268px;">2</div>
        								<div group="41" class="box" style="left:578px;top:268px;">3</div>
        								<div group="41" class="box" style="left:618px;top:268px;">4</div>
        								<!--52-->
        								<div group="52" class="box" style="left:215px;top:296px;">1</div>
        								<div group="52" class="box" style="left:255px;top:296px;">2</div>
        								<div group="52" class="box" style="left:295px;top:296px;">3</div>
        								<div group="52" class="box" style="left:335px;top:296px;">4</div>
        								<div group="52" class="box" style="left:375px;top:296px;">5</div>
        								<div group="52" class="box" style="left:415px;top:296px;">6</div>
        								<div group="52" class="box" style="left:455px;top:296px;">7</div>
        								<!--42-->
        								<div group="42" class="box" style="left:538px;top:298px;">1</div>
        								<div group="42" class="box" style="left:578px;top:298px;">2</div>
        								<div group="42" class="box" style="left:618px;top:298px;">3</div>
        								<div group="42" class="box" style="left:658px;top:298px;">4</div>
        								<!--53-->
        								<div group="53" class="box" style="left:238px;top:325px;">1</div>
        								<div group="53" class="box" style="left:278px;top:325px;">2</div>
        								<div group="53" class="box" style="left:318px;top:325px;">3</div>
        								<div group="53" class="box" style="left:358px;top:325px;">4</div>
        								<div group="53" class="box" style="left:398px;top:325px;">5</div>
        								<div group="53" class="box" style="left:438px;top:325px;">6</div>
        								<div group="53" class="box" style="left:478px;top:325px;">7</div>
        								<!-- 43 -->
        								<div group="43" class="box" style="left:578px;top:327px;">1</div>
        								<div group="43" class="box" style="left:618px;top:327px;">2</div>
        								<div group="43" class="box" style="left:658px;top:327px;">3</div>
        								<div group="43" class="box" style="left:698px;top:327px;">4</div>
        								<!-- 22 -->
        								<div group="22" class="box" style="left:118px;top:353px;">1</div>
        								<div group="22" class="box" style="left:158px;top:353px;">2</div>
        								<div group="22" class="box" style="left:198px;top:353px;">3</div>
        								<!-- 44 -->
        								<div group="44" class="box" style="left:548px;top:356px;">1</div>
        								<div group="44" class="box" style="left:588px;top:356px;">2</div>
        								<div group="44" class="box" style="left:628px;top:356px;">3</div>
        								<div group="44" class="box" style="left:668px;top:356px;">4</div>
        								<!-- 23 -->
        								<div group="23" class="box" style="left:118px;top:380px;">1</div>
        								<!-- 24 -->
        								<div group="24" class="box" style="left:178px;top:408px;">1</div>
        								<div group="24" class="box" style="left:218px;top:408px;">2</div>
        								<div group="24" class="box" style="left:258px;top:408px;">3</div>
        								<div group="24" class="box" style="left:298px;top:408px;">4</div>
        								<div group="24" class="box" style="left:338px;top:408px;">5</div>
        								<div group="24" class="box" style="left:378px;top:408px;">6</div>
        								<div group="24" class="box" style="left:418px;top:408px;">7</div>
        								<div group="24" class="box" style="left:458px;top:408px;">8</div>
        								<div group="24" class="box" style="left:498px;top:408px;">9</div>
        								<!-- 25 -->
        								<div group="25" class="box" style="left:178px;top:438px;">1</div>
        								<div group="25" class="box" style="left:218px;top:438px;">2</div>
        								<div group="25" class="box" style="left:258px;top:438px;">3</div>
        								<div group="25" class="box" style="left:298px;top:438px;">4</div>
        								<div group="25" class="box" style="left:338px;top:438px;">5</div>
        								<div group="25" class="box" style="left:378px;top:438px;">6</div>
        								<div group="25" class="box" style="left:418px;top:438px;">7</div>
        								<div group="25" class="box" style="left:458px;top:438px;">8</div>
        								<div group="25" class="box" style="left:498px;top:438px;">9</div>
        								<!-- 26 -->
        								<div group="26" class="box" style="left:200px;top:463px;">1</div>
        								<div group="26" class="box" style="left:240px;top:463px;">2</div>
        								<div group="26" class="box" style="left:280px;top:463px;">3</div>
        								<div group="26" class="box" style="left:320px;top:463px;">4</div>
        								<div group="26" class="box" style="left:360px;top:463px;">5</div>
        								<div group="26" class="box" style="left:400px;top:463px;">6</div>
        								<div group="26" class="box" style="left:440px;top:466px;">7</div>
        								<div group="26" class="box" style="left:480px;top:466px;">8</div>
        								<div group="26" class="box" style="left:520px;top:466px;">9</div>
        								<!-- 27 -->
        								<div group="27" class="box" style="left:228px;top:490px;">1</div>
        								<div group="27" class="box" style="left:268px;top:490px;">2</div>
        								<div group="27" class="box" style="left:308px;top:490px;">3</div>
        								<div group="27" class="box" style="left:348px;top:490px;">4</div>
        								<div group="27" class="box" style="left:388px;top:490px;">5</div>
        								<div group="27" class="box" style="left:428px;top:490px;">6</div>
        								<!-- 28 -->
        								<div group="28" class="box" style="left:265px;top:522px;">1</div>
        								<div group="28" class="box" style="left:305px;top:522px;">2</div>
        								<div group="28" class="box" style="left:345px;top:522px;">3</div>
        								<div group="28" class="box" style="left:385px;top:522px;">4</div>
        								<div group="28" class="box" style="left:425px;top:522px;">5</div>
        								<div group="28" class="box" style="left:465px;top:522px;">6</div>
        								<!-- 29 -->
        								<div group="29" class="box" style="left:290px;top:548px;">1</div>
        								<div group="29" class="box" style="left:330px;top:548px;">2</div>
        								<div group="29" class="box" style="left:370px;top:548px;">3</div>
        								<div group="29" class="box" style="left:410px;top:548px;">4</div>
        								<div group="29" class="box" style="left:450px;top:548px;">5</div>
        								<div group="29" class="box" style="left:490px;top:548px;">6</div>
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
