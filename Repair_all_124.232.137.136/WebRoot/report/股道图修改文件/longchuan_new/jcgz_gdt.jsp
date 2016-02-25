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
		width:100%;
		height:100%;
	}
	#maps{
		background:url(images/1.jpg) left top no-repeat;
		width:99%;
		height:550px;
		position:absolute;
		border-left:1px solid #a0a0a0;
		left:0px;
	}
	#content{
		position:relative;
		left:0px;
		width:100%;
		float:left;
		height:100%;
		background-color:#c0c0c0;
		text-align: center;
		overflow: auto;
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
				if((id == "maps" || id== "content") && twh != "" && !isNaN(twh)){
					var diag = new top.Dialog();
					diag.Title = "日计划制定窗口";
					if(gdh != undefined){
						diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action?gdh="+gdh+"&twh="+twh;
					}else{
						diag.URL = "<%=basePath%>planManage!addDailyPlanInput.action";
					}
					diag.Width=450;
					diag.Height=470;
					diag.show();
				}
			})
	});
</script>
</body>
</html>
