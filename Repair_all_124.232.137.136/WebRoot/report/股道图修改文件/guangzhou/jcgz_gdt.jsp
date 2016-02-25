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
