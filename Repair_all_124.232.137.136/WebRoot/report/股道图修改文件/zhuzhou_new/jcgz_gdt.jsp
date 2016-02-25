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
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
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
		border:3px dashed #000;
		position: absolute;
		left:280px;
		top:76px;
		width:117px;
		height:113px;
	}
	div.k3{
		border:3px dashed #C0F;
		position: absolute;
		left:342px;
		top:312px;
		width:117px;
		height:112px;
	}
	div.k4{
		border:3px dashed red;
		position: absolute;
		left:440px;
		top:76px;
		width:117px;
		height:113px;
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
	    						    <div class="k2"></div>
	    						<!-- 	<div class="k5"></div>   -->
	    								<div class="k3"></div>
	    								<div class="k4"></div>    
								       <!--32-->
        <div group="32" class="box" style="left:163px;top:80px;">1 
        </div>
        <div group="32" class="box" style="left:203px;top:80px;">2 
        </div>
        <div group="32" class="box" style="left:243px;top:80px;">3 
        </div>
        <div group="32" class="box" style="left:283px;top:80px;">4 
        </div>
        <div group="32" class="box" style="left:323px;top:80px;">5 
        </div>
        <div group="32" class="box" style="left:363px;top:80px;">6 
        </div>
        <div group="32" class="box" style="left:403px;top:80px;">7 
        </div>
        <div group="32" class="box" style="left:443px;top:80px;">8 
        </div>
        <div group="32" class="box" style="left:483px;top:80px;">9
        </div>
        <div group="32" class="box" style="left:523px;top:80px;">10 
        </div>
        <div group="32" class="box" style="left:563px;top:80px;">11 
        </div>
        <div group="32" class="box" style="left:603px;top:80px;">12 
        </div>
        <!--31-->
        <div group="31" class="box" style="left:163px;top:128px;">1 
        </div>
        <div group="31" class="box" style="left:203px;top:128px;">2 
        </div>
        <div group="31" class="box" style="left:243px;top:128px;">3 
        </div>
        <div group="31" class="box" style="left:283px;top:128px;">4 
        </div>
        <div group="31" class="box" style="left:323px;top:128px;">5 
        </div>
        <div group="31" class="box" style="left:363px;top:128px;">6 
        </div>
        <div group="31" class="box" style="left:403px;top:128px;">7 
        </div>
        <div group="31" class="box" style="left:443px;top:128px;">8 
        </div>
        <div group="31" class="box" style="left:483px;top:128px;">9
        </div>
        <div group="31" class="box" style="left:523px;top:128px;">10 
        </div>
        <div group="31" class="box" style="left:563px;top:128px;">11 
        </div>
        <div group="31" class="box" style="left:603px;top:128px;">12 
        </div>
        <!--30-->
        <div group="30" class="box" style="left:163px;top:174px;">1 
        </div>
        <div group="30" class="box" style="left:203px;top:174px;">2 
        </div>
        <div group="30" class="box" style="left:243px;top:174px;">3 
        </div>
        <div group="30" class="box" style="left:283px;top:174px;">4 
        </div>
        <div group="30" class="box" style="left:323px;top:174px;">5 
        </div>
        <div group="30" class="box" style="left:363px;top:174px;">6 
        </div>
        <div group="30" class="box" style="left:403px;top:174px;">7 
        </div>
        <div group="30" class="box" style="left:443px;top:174px;">8 
        </div>
        <div group="30" class="box" style="left:483px;top:174px;">9 
        </div>
        <div group="30" class="box" style="left:523px;top:174px;">10 
        </div>
        <div group="30" class="box" style="left:563px;top:174px;">11 
        </div>
        <div group="30" class="box" style="left:603px;top:174px;">12 
        </div>
        <div group="30" class="box" style="left:643px;top:174px;">13 
        </div>
        <!--35-->
        <div group="35" class="box" style="left:363px;top:220px;">1
        </div>
        <div group="35" class="box" style="left:403px;top:220px;">2 
        </div>
        <div group="35" class="box" style="left:443px;top:220px;">3 
        </div>
        <!--36-->
        <div group="36" class="box" style="left:368px;top:263px;">1
        </div>
        <div group="36" class="box" style="left:408px;top:263px;">2 
        </div>
        <div group="36" class="box" style="left:448px;top:263px;">3 
        </div>
        <!--29-->
        <div group="29" class="box" style="left:225px;top:315px;">1
        </div>
        <div group="29" class="box" style="left:265px;top:315px;">2
        </div>
        <div group="29" class="box" style="left:305px;top:315px;">3
        </div>
        <div group="29" class="box" style="left:345px;top:315px;">4
        </div>
        <div group="29" class="box" style="left:385px;top:315px;">5
        </div>
        <div group="29" class="box" style="left:425px;top:315px;">6
        </div>
        <div group="29" class="box" style="left:465px;top:315px;">7
        </div>
        <div group="29" class="box" style="left:505px;top:315px;">8
        </div>
        <div group="29" class="box" style="left:545px;top:315px;">9
        </div>
        <div group="29" class="box" style="left:585px;top:315px;">10
        </div>
        <div group="29" class="box" style="left:625px;top:315px;">11
        </div>
        <div group="29" class="box" style="left:665px;top:315px;">12
        </div>
        <div group="29" class="box" style="left:705px;top:315px;">13
        </div>
        <div group="29" class="box" style="left:745px;top:315px;">14
        </div>
        <!--28-->
        <div group="28" class="box" style="left:225px;top:358px;">1
        </div>
        <div group="28" class="box" style="left:265px;top:358px;">2
        </div>
        <div group="28" class="box" style="left:305px;top:358px;">3
        </div>
        <div group="28" class="box" style="left:345px;top:358px;">4
        </div>
        <div group="28" class="box" style="left:385px;top:358px;">5
        </div>
        <div group="28" class="box" style="left:425px;top:358px;">6
        </div>
        <div group="28" class="box" style="left:465px;top:358px;">7
        </div>
        <div group="28" class="box" style="left:505px;top:358px;">8
        </div>
        <div group="28" class="box" style="left:545px;top:358px;">9
        </div>
        <div group="28" class="box" style="left:585px;top:358px;">10
        </div>
        <div group="28" class="box" style="left:625px;top:358px;">11
        </div>
        <!--27-->
        <div group="27" class="box" style="left:225px;top:408px;">1
        </div>
        <div group="27" class="box" style="left:265px;top:408px;">2
        </div>
        <div group="27" class="box" style="left:305px;top:408px;">3
        </div>
        <div group="27" class="box" style="left:345px;top:408px;">4
        </div>
        <div group="27" class="box" style="left:385px;top:408px;">5
        </div>
        <div group="27" class="box" style="left:425px;top:408px;">6
        </div>
        <div group="27" class="box" style="left:465px;top:408px;">7
        </div>
        <div group="27" class="box" style="left:505px;top:408px;">8
        </div>
        <div group="27" class="box" style="left:545px;top:408px;">9
        </div>
        <div group="27" class="box" style="left:585px;top:408px;">10
        </div>
        <!--25-->
        <div group="25" class="box" style="left:453px;top:508px;">1
        </div>
        <div group="25" class="box" style="left:493px;top:508px;">2
        </div>
        <div group="25" class="box" style="left:533px;top:508px;">3
        </div>
        <div group="25" class="box" style="left:573px;top:508px;">4
        </div>
        <div group="25" class="box" style="left:613px;top:508px;">5
        </div>
        <div group="25" class="box" style="left:653px;top:508px;">6
        </div>
        <!--24-->
        <div group="24" class="box" style="left:483px;top:551px;">1
        </div>
        <div group="24" class="box" style="left:523px;top:551px;">2
        </div>
        <div group="24" class="box" style="left:563px;top:551px;">3
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
				if(id == "maps" && twh != "" && !isNaN(twh)){
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
