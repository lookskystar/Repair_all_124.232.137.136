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
		height:14px;
		line-height:15px;
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
	
	$(function(){
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
		
		
		//DSJS和JCGZ可以扣车 
		var roles = $("input[name='roles']").val().replace(/,/g, "");
		if(roles == 'DSJS' || roles=='JCGZ'){
			$("body").click(function(event){
				var obj=($(event.srcElement || event.target));
				var id = obj.parent().attr('id');
				if(obj.parent().attr('id')==""){
					id = obj.parent().parent().attr('id')
				}
				//获取股道号
				var gdh = obj.attr('group');
				if(gdh == undefined){
					gdh = obj.parent().attr('group');
				}
				//获取台位号
				var twh = obj.html();
				if(twh > 100){
					twh = "";
				}
				if(id == "maps" && twh != "" && !isNaN(twh)){
					var diag = new top.Dialog();
					diag.Title = "日计划制定窗口";
					if(gdh != undefined){
						diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action?gdh="+gdh+"&twh="+twh;
					}else{
						diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action";
					}
					diag.Width=450;
					diag.Height=430;
					diag.show();
				}
			})
		}
	});
	
//	$(function(){
//		jkmegamenu.definemenu("megaanchor1", "megamenu1", "mouseover");
//		jkmegamenu.definemenu("megaanchor2", "megamenu2", "mouseover");
//		jkmegamenu.definemenu("megaanchor3", "megamenu3", "mouseover");
//		jkmegamenu.definemenu("megaanchor4", "megamenu4", "mouseover");
//		jkmegamenu.definemenu("megaanchor5", "megamenu5", "mouseover");
//	});
	
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
<input type="hidden" name="roles" value="${sessionScope.session_user.roles }"/>
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
				
				<div id="lbox_middlecenter">
					<div id="lbox_middleleft" >
						<div id="lbox_middleright">
							<div id="bs_left" style="width:500px;height:468px;">
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
									            <td>状态</td>
								            <th>备注</th>
							         	   </tr>	
								            <c:forEach items="${allJC }" var="plan" varStatus="index">
									            <tr>
									            	<td align="center">${index.index+1 }&nbsp;</td>
									                <td align="center"><a style="position:static;" href="<%=basePath%>query!getInfoByJC.do?jcStype=${plan.jcType }&jcNum=${plan.jcnum }&xcxc=${plan.fixFreque}" target="_blakn">${plan.jcType }-${plan.jcnum }</a>&nbsp;</td>
									                <td align="center">${plan.fixFreque }&nbsp;</td>
									                <td align="center"><a style="position:static;" href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a>&nbsp;</td>
									                <td align="center">${fn:substring(plan.kcsj,5,16) }&nbsp;</td>
									                <td align="center">${fn:substring(plan.jhqjsj,5,16) }<br/>${fn:substring(plan.sjqjsj,5,16) }&nbsp;</td>
									                <td align="center">${fn:substring(plan.jhjcsj,5,16) }<br/>${fn:substring(plan.sjjcsj,5,16) }&nbsp;</td>
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
										                &nbsp;
									                </td>
										            <td align="center" style="width: 100px;">${plan.comments }&nbsp;</td>
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
								       <!--37-->
								    	<div group="37" class="box" style="left:190px;top:51px;">1</div>
								        <div group="37" class="box" style="left:230px;top:51px;">2</div>
								        <div group="37" class="box" style="left:270px;top:51px;">3</div>
								        <!--34-->
								        <div group="34" class="box" style="left:405px;top:65px;">1</div>
								        <div group="34" class="box" style="left:445px;top:65px;">2</div>
								        <div group="34" class="box" style="left:485px;top:65px;">3</div>
								        <div group="34" class="box" style="left:525px;top:65px;">4</div>
								        <!--6-->
								        <div group="6" class="box" style="left:180px;top:80px;">1</div>
								        <div group="6" class="box" style="left:220px;top:80px;">2</div>
								        <div group="6" class="box" style="left:260px;top:80px;">3</div>
								        <div group="6" class="box" style="left:300px;top:80px;">4</div>
								        <!--32-->
        								<div group="32" class="box" style="left:160px;top:99px;">1</div>
        								<div group="32" class="box" style="left:200px;top:99px;">2</div>
        								<div group="32" class="box" style="left:240px;top:99px;">3</div>
        								<div group="32" class="box" style="left:280px;top:99px;">4</div>
        								<div group="32" class="box" style="left:320px;top:99px;">5</div>
        								<div group="32" class="box" style="left:360px;top:99px;">6</div>
        								<div group="32" class="box" style="left:400px;top:99px;">7</div>
        								<div group="32" class="box" style="left:440px;top:99px;">8</div>
        								<div group="32" class="box" style="left:480px;top:99px;">9</div>
        								<div group="32" class="box" style="left:520px;top:99px;">10</div>
        								<div group="32" class="box" style="left:560px;top:99px;">11</div>
        								<div group="32" class="box" style="left:600px;top:99px;">12</div>
        								<!--33-->
        								<div group="33" class="box" style="left:160px;top:118px;">1</div>
        								<div group="33" class="box" style="left:200px;top:118px;">2</div>
        								<div group="33" class="box" style="left:240px;top:118px;">3</div>
        								<div group="33" class="box" style="left:280px;top:118px;">4</div>
        								<div group="33" class="box" style="left:320px;top:118px;">5</div>
        								<div group="33" class="box" style="left:360px;top:118px;">6</div>
        								<div group="33" class="box" style="left:400px;top:118px;">7</div>
        								<div group="33" class="box" style="left:440px;top:118px;">8</div>
        								<div group="33" class="box" style="left:480px;top:118px;">9</div>
        								<!--8-->
        								<div group="8" class="box" style="left:160px;top:138px;">1</div>
        								<div group="8" class="box" style="left:200px;top:138px;">2</div>
        								<div group="8" class="box" style="left:240px;top:138px;">3</div>
        								<div group="8" class="box" style="left:280px;top:138px;">4</div>
        								<div group="8" class="box" style="left:320px;top:138px;">5</div>
        								<div group="8" class="box" style="left:360px;top:138px;">6</div>
        								<div group="8" class="box" style="left:400px;top:138px;">7</div>
        								<div group="8" class="box" style="left:440px;top:138px;">8</div>
        								<!--9-->
        								<div group="9" class="box" style="left:110px;top:158px;">1</div>
        								<div group="9" class="box" style="left:150px;top:158px;">2</div>
        								<div group="9" class="box" style="left:190px;top:158px;">3</div>
        								<div group="9" class="box" style="left:230px;top:158px;">4</div>
        								<div group="9" class="box" style="left:270px;top:158px;">5</div>
        								<div group="9" class="box" style="left:310px;top:158px;">6</div>
        								<div group="9" class="box" style="left:350px;top:158px;">7</div>
        								<div group="9" class="box" style="left:390px;top:158px;">8</div>
        								<div group="9" class="box" style="left:430px;top:158px;">9</div>
        								<div group="9" class="box" style="left:470px;top:158px;">10</div>
        								<div group="9" class="box" style="left:510px;top:158px;">11</div>
        								<div group="9" class="box" style="left:550px;top:158px;">12</div>
        								<!--10 -->
        								<div group="10" class="box" style="left:90px;top:178px;">1</div>
        								<div group="10" class="box" style="left:130px;top:178px;">2</div>
        								<div group="10" class="box" style="left:170px;top:178px;">3</div>
        								<div group="10" class="box" style="left:210px;top:178px;">4</div>
        								<div group="10" class="box" style="left:250px;top:178px;">5</div>
        								<div group="10" class="box" style="left:290px;top:178px;">6</div>
        								<div group="10" class="box" style="left:330px;top:178px;">7</div>
        								<div group="10" class="box" style="left:370px;top:178px;">8</div>
        								<div group="10" class="box" style="left:410px;top:178px;">9</div>
        								<div group="10" class="box" style="left:450px;top:178px;">10</div>
        								<div group="10" class="box" style="left:490px;top:178px;">11</div>
        								<div group="10" class="box" style="left:530px;top:178px;">12</div>
        								<div group="10" class="box" style="left:570px;top:178px;">13</div>
        								<!--1-->
        								<div group="1" class="box" style="left:80px;top:199px;">1</div>
        								<div group="1" class="box" style="left:120px;top:199px;">2</div>
        								<div group="1" class="box" style="left:160px;top:199px;">3</div>
        								<div group="1" class="box" style="left:200px;top:199px;">4</div>
        								<div group="1" class="box" style="left:240px;top:199px;">5</div>
        								<div group="1" class="box" style="left:280px;top:199px;">6</div>
        								<div group="1" class="box" style="left:320px;top:199px;">7</div>
        								<div group="1" class="box" style="left:360px;top:199px;">8</div>
        								<!--2-->
        								<div group="2" class="box" style="left:110px;top:220px;">1</div>
        								<div group="2" class="box" style="left:150px;top:220px;">2</div>
        								<div group="2" class="box" style="left:190px;top:220px;">3</div>
        								<div group="2" class="box" style="left:230px;top:220px;">4</div>
        								<div group="2" class="box" style="left:270px;top:220px;">5</div>
        								<div group="2" class="box" style="left:310px;top:220px;">6</div>
        								<div group="2" class="box" style="left:350px;top:220px;">7</div>
        								<div group="2" class="box" style="left:390px;top:220px;">8</div>
        								<!--3-->
       									<div group="3" class="box" style="left:120px;top:240px;">1</div>
       									<div group="3" class="box" style="left:160px;top:240px;">2</div>
       									<div group="3" class="box" style="left:200px;top:240px;">3</div>
       									<div group="3" class="box" style="left:240px;top:240px;">4</div>
       									<div group="3" class="box" style="left:280px;top:240px;">5</div>
       									<div group="3" class="box" style="left:320px;top:240px;">6</div>
       									<div group="3" class="box" style="left:360px;top:240px;">7</div>
       									<!--12-->
        								<div group="12" class="box" style="left:350px;top:264px;">1</div>
        								<div group="12" class="box" style="left:390px;top:264px;">2</div>
        								<div group="12" class="box" style="left:430px;top:264px;">3</div>
        								<div group="12" class="box" style="left:470px;top:264px;">4</div>
        								<div group="12" class="box" style="left:510px;top:264px;">5</div>
        								<div group="12" class="box" style="left:550px;top:264px;">6</div>
        								<!--4-->
        								<div group="4" class="box" style="left:130px;top:286px;">1</div>
        								<div group="4" class="box" style="left:170px;top:286px;">2</div>
        								<div group="4" class="box" style="left:210px;top:286px;">3</div>
        								<div group="4" class="box" style="left:250px;top:286px;">4</div>
        								<!--13-->
        								<div group="13" class="box" style="left:340px;top:286px;">1</div>
        								<div group="13" class="box" style="left:380px;top:286px;">2</div>
        								<div group="13" class="box" style="left:420px;top:286px;">3</div>
        								<div group="13" class="box" style="left:460px;top:286px;">4</div>
        								<div group="13" class="box" style="left:500px;top:286px;">5</div>
        								<div group="13" class="box" style="left:540px;top:286px;">6</div>
        								<div group="13" class="box" style="left:580px;top:286px;">7</div>
        								<!--30-->
        								<div group="30" class="box" style="left:120px;top:305px;">1</div>
        								<div group="30" class="box" style="left:160px;top:305px;">2</div>
        								<div group="30" class="box" style="left:200px;top:305px;">3</div>
        								<div group="30" class="box" style="left:240px;top:305px;">4</div>
        								<div group="30" class="box" style="left:280px;top:305px;">5</div>
        								<div group="30" class="box" style="left:320px;top:305px;">6</div>
        								<div group="30" class="box" style="left:360px;top:305px;">7</div>
        								<!--14-->
        								<div group="14" class="box" style="left:502px;top:305px;">1</div>
        								<div group="14" class="box" style="left:542px;top:305px;">2</div>
        								<div group="14" class="box" style="left:582px;top:305px;">3</div>
        								<div group="14" class="box" style="left:622px;top:305px;">4</div>
        								<div group="14" class="box" style="left:662px;top:305px;">5</div>
        								<div group="14" class="box" style="left:702px;top:305px;">6</div>
        								<div group="14" class="box" style="left:742px;top:305px;">7</div>
        								<!--15-->
        								<div group="15" class="box" style="left:310px;top:324px;">1</div>
        								<div group="15" class="box" style="left:350px;top:324px;">2</div>
        								<div group="15" class="box" style="left:390px;top:324px;">3</div>
        								<div group="15" class="box" style="left:430px;top:324px;">4</div>
        								<div group="15" class="box" style="left:470px;top:324px;">5</div>
        								<div group="15" class="box" style="left:510px;top:324px;">6</div>
        								<!--16-->
        								<div group="16" class="box" style="left:172px;top:342px;">1</div>
        								<div group="16" class="box" style="left:212px;top:342px;">2</div>
        								<div group="16" class="box" style="left:252px;top:342px;">3</div>
        								<div group="16" class="box" style="left:292px;top:342px;">4</div>
        								<div group="16" class="box" style="left:332px;top:342px;">5</div>
        								<div group="16" class="box" style="left:372px;top:342px;">6</div>
        								<div group="16" class="box" style="left:412px;top:342px;">7</div>
        								<div group="16" class="box" style="left:452px;top:342px;">8</div>
        								<div group="16" class="box" style="left:492px;top:342px;">9</div>
        								<!--17-->
        								<div group="17" class="box" style="left:172px;top:359px;">1</div>
        								<div group="17" class="box" style="left:212px;top:359px;">2</div>
        								<div group="17" class="box" style="left:252px;top:359px;">3</div>
        								<div group="17" class="box" style="left:292px;top:359px;">4</div>
        								<div group="17" class="box" style="left:332px;top:359px;">5</div>
        								<div group="17" class="box" style="left:372px;top:359px;">6</div>
        								<div group="17" class="box" style="left:412px;top:359px;">7</div>
        								<div group="17" class="box" style="left:452px;top:359px;">8</div>
        								<div group="17" class="box" style="left:492px;top:359px;">9</div>
        								<!--18-->
        								<div group="18" class="box" style="left:172px;top:376px;">1</div>
        								<div group="18" class="box" style="left:212px;top:376px;">2</div>
        								<div group="18" class="box" style="left:252px;top:376px;">3</div>
        								<div group="18" class="box" style="left:292px;top:376px;">3</div>
        								<!--19-->
        								<div group="19" class="box" style="left:425px;top:375px;">1</div>
        								<div group="19" class="box" style="left:465px;top:375px;">2</div>
        								<div group="19" class="box" style="left:505px;top:375px;">3</div>
        								<div group="19" class="box" style="left:545px;top:375px;">4</div>
        								<div group="19" class="box" style="left:585px;top:375px;">5</div>
        								<!--50-->
        								<div group="50" class="box" style="left:198px;top:392px;">1</div>
        								<div group="50" class="box" style="left:238px;top:392px;">2</div>
        								<div group="50" class="box" style="left:278px;top:392px;">3</div>
        								<div group="50" class="box" style="left:318px;top:392px;">4</div>
        								<div group="50" class="box" style="left:398px;top:392px;">5</div>
        								<div group="50" class="box" style="left:438px;top:392px;">6</div>
        								<!--40-->
        								<div group="40" class="box" style="left:528px;top:391px;">1</div>
        								<div group="40" class="box" style="left:568px;top:391px;">2</div>
        								<div group="40" class="box" style="left:608px;top:391px;">3</div>
        								<div group="40" class="box" style="left:648px;top:391px;">4</div>
        								<div group="40" class="box" style="left:698px;top:391px;">5</div>
        								<div group="40" class="box" style="left:738px;top:391px;">6</div>
        								<!--51-->
        								<div group="51" class="box" style="left:198px;top:409px;">1</div>
        								<div group="51" class="box" style="left:238px;top:409px;">2</div>
        								<div group="51" class="box" style="left:278px;top:409px;">3</div>
        								<div group="51" class="box" style="left:318px;top:409px;">4</div>
        								<div group="51" class="box" style="left:398px;top:409px;">5</div>
        								<div group="51" class="box" style="left:438px;top:409px;">6</div>
        								<!-- 41 -->
        								<div group="41" class="box" style="left:538px;top:408px;">1</div>
        								<div group="41" class="box" style="left:578px;top:408px;">2</div>
        								<div group="41" class="box" style="left:618px;top:408px;">3</div>
        								<div group="41" class="box" style="left:658px;top:408px;">4</div>
        								<!--52-->
        								<div group="52" class="box" style="left:198px;top:426px;">1</div>
        								<div group="52" class="box" style="left:238px;top:426px;">2</div>
        								<div group="52" class="box" style="left:278px;top:426px;">3</div>
        								<div group="52" class="box" style="left:318px;top:426px;">4</div>
        								<div group="52" class="box" style="left:358px;top:426px;">5</div>
        								<div group="52" class="box" style="left:398px;top:426px;">6</div>
        								<div group="52" class="box" style="left:438px;top:426px;">7</div>
        								<!--42-->
        								<div group="42" class="box" style="left:538px;top:426px;">1</div>
        								<div group="42" class="box" style="left:578px;top:426px;">2</div>
        								<div group="42" class="box" style="left:618px;top:426px;">3</div>
        								<div group="42" class="box" style="left:658px;top:426px;">4</div>
        								<!--53-->
        								<div group="53" class="box" style="left:198px;top:442px;">1</div>
        								<div group="53" class="box" style="left:238px;top:442px;">2</div>
        								<div group="53" class="box" style="left:278px;top:442px;">3</div>
        								<div group="53" class="box" style="left:318px;top:442px;">4</div>
        								<div group="53" class="box" style="left:358px;top:442px;">5</div>
        								<div group="53" class="box" style="left:398px;top:442px;">6</div>
        								<div group="53" class="box" style="left:438px;top:442px;">7</div>
        								<!-- 43 -->
        								<div group="43" class="box" style="left:538px;top:442px;">1</div>
        								<div group="43" class="box" style="left:578px;top:442px;">2</div>
        								<div group="43" class="box" style="left:618px;top:442px;">3</div>
        								<div group="43" class="box" style="left:648px;top:442px;">4</div>
        								<!-- 22 -->
        								<div group="22" class="box" style="left:118px;top:458px;">1</div>
        								<div group="22" class="box" style="left:158px;top:458px;">2</div>
        								<div group="22" class="box" style="left:198px;top:458px;">3</div>
        								<!-- 44 -->
        								<div group="44" class="box" style="left:548px;top:458px;">1</div>
        								<div group="44" class="box" style="left:588px;top:458px;">2</div>
        								<div group="44" class="box" style="left:628px;top:458px;">3</div>
        								<div group="44" class="box" style="left:668px;top:458px;">4</div>
        								<!-- 23 -->
        								<div group="23" class="box" style="left:118px;top:475px;">1</div>
        								<!-- 24 -->
        								<div group="24" class="box" style="left:178px;top:484px;">1</div>
        								<div group="24" class="box" style="left:218px;top:484px;">2</div>
        								<div group="24" class="box" style="left:258px;top:484px;">3</div>
        								<div group="24" class="box" style="left:298px;top:484px;">4</div>
        								<div group="24" class="box" style="left:338px;top:484px;">5</div>
        								<div group="24" class="box" style="left:378px;top:484px;">6</div>
        								<div group="24" class="box" style="left:418px;top:484px;">7</div>
        								<div group="24" class="box" style="left:458px;top:484px;">8</div>
        								<div group="24" class="box" style="left:498px;top:484px;">9</div>
        								<!-- 25 -->
        								<div group="25" class="box" style="left:178px;top:502px;">1</div>
        								<div group="25" class="box" style="left:218px;top:502px;">2</div>
        								<div group="25" class="box" style="left:258px;top:502px;">3</div>
        								<div group="25" class="box" style="left:298px;top:502px;">4</div>
        								<div group="25" class="box" style="left:338px;top:502px;">5</div>
        								<div group="25" class="box" style="left:378px;top:502px;">6</div>
        								<div group="25" class="box" style="left:418px;top:502px;">7</div>
        								<div group="25" class="box" style="left:458px;top:502px;">8</div>
        								<div group="25" class="box" style="left:498px;top:502px;">9</div>
        								<!-- 26 -->
        								<div group="26" class="box" style="left:178px;top:519px;">1</div>
        								<div group="26" class="box" style="left:218px;top:519px;">2</div>
        								<div group="26" class="box" style="left:258px;top:519px;">3</div>
        								<div group="26" class="box" style="left:298px;top:519px;">4</div>
        								<div group="26" class="box" style="left:338px;top:519px;">5</div>
        								<div group="26" class="box" style="left:378px;top:519px;">6</div>
        								<div group="26" class="box" style="left:418px;top:519px;">7</div>
        								<div group="26" class="box" style="left:458px;top:519px;">8</div>
        								<div group="26" class="box" style="left:498px;top:519px;">9</div>
        								<!-- 27 -->
        								<div group="27" class="box" style="left:218px;top:536px;">1</div>
        								<div group="27" class="box" style="left:258px;top:536px;">2</div>
        								<div group="27" class="box" style="left:298px;top:536px;">3</div>
        								<div group="27" class="box" style="left:338px;top:536px;">4</div>
        								<div group="27" class="box" style="left:378px;top:536px;">5</div>
        								<div group="27" class="box" style="left:418px;top:536px;">6</div>
        								<!-- 28 -->
        								<div group="28" class="box" style="left:248px;top:553px;">1</div>
        								<div group="28" class="box" style="left:288px;top:553px;">2</div>
        								<div group="28" class="box" style="left:328px;top:553px;">3</div>
        								<div group="28" class="box" style="left:368px;top:553px;">4</div>
        								<div group="28" class="box" style="left:408px;top:553px;">5</div>
        								<div group="28" class="box" style="left:448px;top:553px;">6</div>
        								<!-- 28 -->
        								<div group="29" class="box" style="left:268px;top:570px;">1</div>
        								<div group="29" class="box" style="left:308px;top:570px;">2</div>
        								<div group="29" class="box" style="left:348px;top:570px;">3</div>
        								<div group="29" class="box" style="left:388px;top:570px;">4</div>
        								<div group="29" class="box" style="left:428px;top:570px;">5</div>
        								<div group="29" class="box" style="left:468px;top:570px;">6</div>
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
