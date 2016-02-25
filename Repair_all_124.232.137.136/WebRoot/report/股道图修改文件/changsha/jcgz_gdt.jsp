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
		width:900px;
		height:536px;
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
        <div group="1" class="box" style="left:215px;top:38px;">1 
        </div>
        <div group="1" class="box" style="left:255px;top:38px;">2
        </div>
        <div group="1" class="box" style="left:295px;top:38px;">3 
        </div>
        <div group="1" class="box" style="left:335px;top:38px;">4 
        </div>
        <div group="1" class="box" style="left:375px;top:38px;">5
        </div>
        <div group="1" class="box" style="left:415px;top:38px;">6
        </div>
        <div group="1" class="box" style="left:455px;top:38px;">7
        </div>
        <!--2-->
        <div group="2" class="box" style="left:215px;top:65px;">1	 
        </div>
        <div group="2" class="box" style="left:255px;top:65px;">2 
        </div>
        <div group="2" class="box" style="left:295px;top:65px;">3 
        </div>
        <div group="2" class="box" style="left:335px;top:65px;">4 
        </div>
        <div group="2" class="box" style="left:375px;top:65px;">5 
        </div>
        <div group="2" class="box" style="left:415px;top:65px;">6 
        </div>
        <div group="2" class="box" style="left:455px;top:65px;">7 
        </div>
        <!--4-->
        <div group="4" class="box" style="left:75px;top:108px;">1	 
        </div>
        <div group="4" class="box" style="left:115px;top:108px;">2	 
        </div>
        <div group="4" class="box" style="left:155px;top:108px;">3	 
        </div>
        <div group="4" class="box" style="left:195px;top:108px;">4 
        </div>
        <div group="4" class="box" style="left:235px;top:108px;">5	 
        </div>
        <div group="4" class="box" style="left:275px;top:108px;">6 
        </div>
        <div group="4" class="box" style="left:315px;top:108px;">7	 
        </div>
        <div group="4" class="box" style="left:355px;top:108px;">8	 
        </div>
        <div group="4" class="box" style="left:395px;top:108px;">9	 
        </div>
        <div group="4" class="box" style="left:435px;top:108px;">10	 
        </div>
        <div group="4" class="box" style="left:475px;top:108px;">11	 
        </div>
         <!--5-->
        <div group="5" class="box" style="left:65px;top:132px;">1	 
        </div>
        <div group="5" class="box" style="left:105px;top:132px;">2	 
        </div>
        <div group="5" class="box" style="left:145px;top:132px;">3	 
        </div>
        <div group="5" class="box" style="left:185px;top:132px;">4 
        </div>
        <div group="5" class="box" style="left:225px;top:132px;">5	 
        </div>
        <div group="5" class="box" style="left:265px;top:132px;">6 
        </div>
        <div group="5" class="box" style="left:305px;top:132px;">7	 
        </div>
        <div group="5" class="box" style="left:345px;top:132px;">8	 
        </div>
        <div group="5" class="box" style="left:385px;top:132px;">9	 
        </div>
        <div group="5" class="box" style="left:425px;top:132px;">10	 
        </div>
        <div group="5" class="box" style="left:465px;top:132px;">11	 
        </div>
         <!--6-->
        <div group="6" class="box" style="left:98px;top:154px;">1	 
        </div>
        <div group="6" class="box" style="left:138px;top:154px;">2 
        </div>
        <div group="6" class="box" style="left:178px;top:154px;">3 
        </div>
        <div group="6" class="box" style="left:218px;top:154px;">4 
        </div>
        <div group="6" class="box" style="left:258px;top:154px;">5 
        </div>
        <div group="6" class="box" style="left:298px;top:154px;">6 
        </div>
        <div group="6" class="box" style="left:338px;top:154px;">7 
        </div>
         <!--7-->
        <div group="7" class="box" style="left:133px;top:178px;">1	 
        </div>
        <div group="7" class="box" style="left:173px;top:178px;">2 
        </div>
        <div group="7" class="box" style="left:213px;top:178px;">3 
        </div>
        <div group="7" class="box" style="left:253px;top:178px;">4 
        </div>
        <div group="7" class="box" style="left:293px;top:178px;">5 
        </div>
        <div group="7" class="box" style="left:333px;top:178px;">6 
        </div>
        <div group="7" class="box" style="left:373px;top:178px;">7 
        </div>
         <!--8-->
        <div group="8" class="box" style="left:130px;top:200px;">1	 
        </div>
        <div group="8" class="box" style="left:170px;top:200px;">2 
        </div>
        <div group="8" class="box" style="left:210px;top:200px;">3 
        </div>
        <div group="8" class="box" style="left:250px;top:200px;">4 
        </div>
        <div group="8" class="box" style="left:290px;top:200px;">5 
        </div>
        <div group="8" class="box" style="left:330px;top:200px;">6 
        </div>
        <div group="8" class="box" style="left:370px;top:200px;">7 
        </div>
         <!--9-->
        <div group="9" class="box" style="left:130px;top:222px;">1	 
        </div>
        <div group="9" class="box" style="left:170px;top:222px;">2
        </div>
        <div group="9" class="box" style="left:210px;top:222px;">3 
        </div>
        <div group="9" class="box" style="left:250px;top:222px;">4 
        </div>
        <div group="9" class="box" style="left:290px;top:222px;">5 
        </div>
        <div group="9" class="box" style="left:330px;top:222px;">6 
        </div>
        <div group="9" class="box" style="left:370px;top:222px;">7 
        </div>
        <!--10-->
        <div group="10" class="box" style="left:75px;top:246px;">1	 
        </div>
        <div group="10" class="box" style="left:115px;top:246px;">2	 
        </div>
        <div group="10" class="box" style="left:155px;top:246px;">3	 
        </div>
        <div group="10" class="box" style="left:195px;top:246px;">4	 
        </div>
        <div group="10" class="box" style="left:235px;top:246px;">5	 
        </div>
        <div group="10" class="box" style="left:275px;top:246px;">6	 
        </div>
        <div group="10" class="box" style="left:315px;top:246px;">7	 
        </div>
        <div group="10" class="box" style="left:355px;top:246px;">8	 
        </div>
        <div group="10" class="box" style="left:395px;top:246px;">9	 
        </div>
        <div group="10" class="box" style="left:435px;top:246px;">10	 
        </div>
        <!--13-->
        <div group="13" class="box" style="left:530px;top:132px;">1	 
        </div>
        <div group="13" class="box" style="left:570px;top:132px;">2	 
        </div>
        <div group="13" class="box" style="left:610px;top:132px;">3	 
        </div>
        <!--14-->
        <div group="14" class="box" style="left:520px;top:154px;">1	 
        </div>
        <div group="14" class="box" style="left:560px;top:154px;">2	 
        </div>
        <div group="14" class="box" style="left:600px;top:154px;">3	 
        </div>
        <!--15-->
        <div group="15" class="box" style="left:485px;top:178px;">1	 
        </div>
        <div group="15" class="box" style="left:525px;top:178px;">2	 
        </div>
        <div group="15" class="box" style="left:565px;top:178px;">3	 
        </div>
        <!--17-->
        <div group="17" class="box" style="left:485px;top:208px;">1	 
        </div>
        <div group="17" class="box" style="left:525px;top:208px;">2	 
        </div>
        <div group="17" class="box" style="left:565px;top:208px;">3	 
        </div>
        <!--16-->
        <div group="16" class="box" style="left:385px;top:268px;">1	 
        </div>
        <div group="16" class="box" style="left:425px;top:268px;">2	 
        </div>
        <div group="16" class="box" style="left:465px;top:268px;">3	 
        </div>
        <div group="16" class="box" style="left:505px;top:268px;">4	 
        </div>
        <div group="16" class="box" style="left:545px;top:268px;">5	 
        </div>
        <div group="16" class="box" style="left:585px;top:268px;">6	 
        </div>
        <div group="16" class="box" style="left:625px;top:268px;">7	 
        </div>
        <!--28-->
        <div group="28" class="box" style="left:310px;top:305px;">1	 
        </div>
        <div group="28" class="box" style="left:350px;top:305px;">2	 
        </div>
        <div group="28" class="box" style="left:390px;top:305px;">3	 
        </div>
        <div group="28" class="box" style="left:430px;top:305px;">4	 
        </div>
        <div group="28" class="box" style="left:470px;top:305px;">5	 
        </div>
        <div group="28" class="box" style="left:510px;top:305px;">6	 
        </div>
        <!--20-->
        <div group="20" class="box" style="left:88px;top:332px;">1	 
        </div>
        <div group="20" class="box" style="left:128px;top:332px;">2	 
        </div>
        <div group="20" class="box" style="left:168px;top:332px;">3	 
        </div>
        <div group="20" class="box" style="left:208px;top:332px;">4	 
        </div>
        <div group="20" class="box" style="left:248px;top:332px;">5	 
        </div>
        <div group="20" class="box" style="left:288px;top:332px;">6	 
        </div>
        <div group="20" class="box" style="left:328px;top:332px;">7	 
        </div>
        <!--21-->
        <div group="21" class="box" style="left:118px;top:356px;">1	 
        </div>
        <div group="21" class="box" style="left:158px;top:356px;">2	 
        </div>
        <div group="21" class="box" style="left:198px;top:356px;">3	 
        </div>
        <div group="21" class="box" style="left:238px;top:356px;">4	 
        </div>
        <div group="21" class="box" style="left:278px;top:356px;">5	 
        </div>
        <div group="21" class="box" style="left:318px;top:356px;">6	 
        </div>
        <div group="21" class="box" style="left:358px;top:356px;">7	 
        </div>
        <div group="21" class="box" style="left:398px;top:356px;">8	 
        </div>
        <div group="21" class="box" style="left:438px;top:356px;">9	 
        </div>
        <!--22-->
        <div group="22" class="box" style="left:93px;top:378px;">1	 
        </div>
        <div group="22" class="box" style="left:133px;top:378px;">2	 
        </div>
        <div group="22" class="box" style="left:173px;top:378px;">3	 
        </div>
        <div group="22" class="box" style="left:213px;top:378px;">4	 
        </div>
        <div group="22" class="box" style="left:253px;top:378px;">5	 
        </div>
        <div group="22" class="box" style="left:293px;top:378px;">6	 
        </div>
        <div group="22" class="box" style="left:333px;top:378px;">7	 
        </div>
        <div group="22" class="box" style="left:373px;top:378px;">8	 
        </div>
        <div group="22" class="box" style="left:413px;top:378px;">9	 
        </div>
        <!--23-->
        <div group="23" class="box" style="left:133px;top:402px;">1	 
        </div>
        <div group="23" class="box" style="left:173px;top:402px;">2	 
        </div>
        <div group="23" class="box" style="left:213px;top:402px;">3	 
        </div>
        <div group="23" class="box" style="left:253px;top:402px;">4	 
        </div>
        <div group="23" class="box" style="left:293px;top:402px;">5	 
        </div>
        <div group="23" class="box" style="left:333px;top:402px;">6	 
        </div>
        <!--26-->
        <div group="26" class="box" style="left:293px;top:422px;">1	 
        </div>
        <div group="26" class="box" style="left:333px;top:422px;">2	 
        </div>
        <div group="26" class="box" style="left:373px;top:422px;">3	 
        </div>
        <div group="26" class="box" style="left:413px;top:422px;">4	 
        </div>
        <!--25-->
        <div group="25" class="box" style="left:293px;top:448px;">1	 
        </div>
        <div group="25" class="box" style="left:333px;top:448px;">2	 
        </div>
        <div group="25" class="box" style="left:373px;top:448px;">3	 
        </div>
        <div group="25" class="box" style="left:413px;top:448px;">4	 
        </div>
        <!--19-->
        <div group="19" class="box" style="left:158px;top:468px;">1	 
        </div>
        <div group="19" class="box" style="left:198px;top:468px;">2	 
        </div>
        <div group="19" class="box" style="left:238px;top:468px;">3	 
        </div>
        <div group="19" class="box" style="left:278px;top:468px;">4	 
        </div>
        <div group="19" class="box" style="left:318px;top:468px;">5	 
        </div>
        <!--18-->
        <div group="18" class="box" style="left:158px;top:490px;">1	 
        </div>
        <div group="18" class="box" style="left:198px;top:490px;">2	 
        </div>
        <div group="18" class="box" style="left:238px;top:490px;">3	 
        </div>
        <!--27-->
        <div group="27" class="box" style="left:400px;top:332px;">1	 
        </div>
        <div group="27" class="box" style="left:440px;top:332px;">2	 
        </div>
        <div group="27" class="box" style="left:480px;top:332px;">3 
        </div>
        <div group="27" class="box" style="left:520px;top:332px;">4	 
        </div>
        <div group="27" class="box" style="left:560px;top:332px;">5	 
        </div>
        <div group="27" class="box" style="left:600px;top:332px;">6	 
        </div>
        <!--29-->
        <div group="29" class="box" style="left:483px;top:448px;">1	 
        </div>
        <div group="29" class="box" style="left:523px;top:448px;">2	 
        </div>
        <div group="29" class="box" style="left:563px;top:448px;">3	 
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
