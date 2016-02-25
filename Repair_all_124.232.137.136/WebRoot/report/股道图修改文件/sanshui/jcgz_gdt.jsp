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
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/bsFormat.js"></script>
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
		width:900px;
		height:536px;
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
</head>

<body>
		
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
								       <!--1-->
        <div group="1" class="box" style="left:450px;top:198px;">1 
        </div>
        <div group="1" class="box" style="left:490px;top:198px;">2 
        </div>
        <div group="1" class="box" style="left:530px;top:198px;">3 
        </div>
        <div group="1" class="box" style="left:570px;top:198px;">4 
        </div>
        <div group="1" class="box" style="left:610px;top:198px;">5 
        </div>
        <!--2-->
        <div group="2" class="box" style="left:450px;top:233px;">1 
        </div>
        <div group="2" class="box" style="left:490px;top:233px;">2 
        </div>
        <div group="2" class="box" style="left:530px;top:233px;">3 
        </div>
        <div group="2" class="box" style="left:570px;top:233px;">4 
        </div>
        <div group="2" class="box" style="left:610px;top:233px;">5 
        </div>
        <!--3-->
        <div group="3" class="box" style="left:450px;top:275px;">1 
        </div>
        <div group="3" class="box" style="left:490px;top:275px;">2 
        </div>
        <div group="3" class="box" style="left:530px;top:275px;">3 
        </div>
        <div group="3" class="box" style="left:570px;top:275px;">4 
        </div>
        <div group="3" class="box" style="left:610px;top:275px;">5 
        </div>
        <!--15-->
        <div group="15" class="box" style="left:75px;top:279px;">1 
        </div>
        <div group="15" class="box" style="left:115px;top:279px;">2 
        </div>
        <div group="15" class="box" style="left:155px;top:279px;">3 
        </div>
        <div group="15" class="box" style="left:195px;top:279px;">4 
        </div>
        <div group="15" class="box" style="left:235px;top:279px;">5 
        </div>
        <!--11-->
        <div group="11" class="box" style="left:310px;top:279px;">1 
        </div>
        <div group="11" class="box" style="left:350px;top:279px;">2 
        </div>
        <!--12-->
        <div group="12" class="box" style="left:115px;top:315px;">1 
        </div>
        <div group="12" class="box" style="left:155px;top:315px;">2 
        </div>
        <div group="12" class="box" style="left:195px;top:315px;">3 
        </div>
        <div group="12" class="box" style="left:235px;top:315px;">4 
        </div>
        <div group="12" class="box" style="left:275px;top:315px;">5 
        </div>
        <!--13-->
        <div group="13" class="box" style="left:147px;top:355px;">1 
        </div>
        <div group="13" class="box" style="left:187px;top:355px;">2 
        </div>
        <div group="13" class="box" style="left:227px;top:355px;">3 
        </div>
        <div group="13" class="box" style="left:267px;top:355px;">4 
        </div>
        <!--6-->
        <div group="6" class="box" style="left:468px;top:350px;">1 
        </div>
        <div group="6" class="box" style="left:508px;top:350px;">2 
        </div>
        <div group="6" class="box" style="left:548px;top:350px;">3 
        </div>
        <!--14-->
        <div group="14" class="box" style="left:178px;top:395px;">1 
        </div>
        <div group="14" class="box" style="left:218px;top:395px;">2 
        </div>
        <div group="14" class="box" style="left:258px;top:395px;">3 
        </div>
        <div group="14" class="box" style="left:298px;top:395px;">4 
        </div>
        <!--7-->
        <div group="7" class="box" style="left:468px;top:389px;">1 
        </div>
        <div group="7" class="box" style="left:508px;top:389px;">2 
        </div>
        <div group="7" class="box" style="left:548px;top:389px;">3 
        </div>
        <div group="7" class="box" style="left:588px;top:389px;">4 
        </div>
        <!--18-->
        <div group="18" class="box" style="left:28px;top:435px;">1 
        </div>
        <div group="18" class="box" style="left:68px;top:435px;">2 
        </div>
        <!--17-->
        <div group="17" class="box" style="left:148px;top:436px;">1 
        </div>
        <div group="17" class="box" style="left:188px;top:436px;">2 
        </div>
        <div group="17" class="box" style="left:228px;top:436px;">3 
        </div>
        <!--8-->
        <div group="8" class="box" style="left:468px;top:426px;">1 
        </div>
        <div group="8" class="box" style="left:508px;top:426px;">2 
        </div>
        <div group="8" class="box" style="left:548px;top:426px;">3 
        </div>
        <div group="8" class="box" style="left:588px;top:426px;">4 
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
				if(twh >= 100){
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
	});
</script>
</body>
</html>
