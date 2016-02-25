<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%@include file="/checkLogin.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String area = request.getParameter("area");
String flag = request.getParameter("flag");
if(area != null && !"".equals(area) && flag != null && !"".equals(flag)){
	request.setAttribute("area", area);
	request.setAttribute("flag", flag);
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>机务检修管理系统</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<!--框架必需end-->
<script type="text/javascript" src="js/bsFormat.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>

<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
<script type="text/javascript" src="js/table/treeTable.js"></script>
<!--框架必需end-->

<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
<script type="text/javascript" src="js/attention/floatPanel.js"></script>
<script type="text/javascript" src="<%=basePath %>js/lhgdialog/lhgdialog.js"></script>
<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<!-- 引入表格样式 -->
<link href="tablecloth/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="tablecloth/tablecloth.js"></script>
<!--修正IE6支持透明png图片start-->
<!--[if IE 6]>
<script src="js/iepngfx.js" language="javascript" type="text/javascript"></script>
<![endif]-->
<!--修正IE6支持透明png图片end-->
<script type="text/javascript">
	$(document).ready(function(){
		jQuery.navlevel2 = function(level1,dytime) {
			
		  $(level1).mouseenter(function(){
			  varthis = $(this);
			  delytime=setTimeout(function(){
				varthis.find('ul').slideDown();
			},dytime);
			
		  });
		  $(level1).mouseleave(function(){
			 clearTimeout(delytime);
			 $(this).find('ul').slideUp();
		  });
		  
		};
	  $.navlevel2("li.mainlevel",200);
	});
	
	function position(){
		var obj=top.leadmain.document.getElementById("bs_center");
		$(obj).click();
	}
	
	function goBack(){
		history.back();
	}
		//查看机车
	function clickGD(rjhmId){
		var url="<%=basePath %>report!getInfoDetail.do?rjhmId="+rjhmId;
		$(document).ready(function () {
           	dd =$.dialog({
                title:"机车信息",
                content:'url:'+url+'&temp='+new Date().getTime(),
                height:500,
                width:580,
                max:false,
                min:false
                
            });
        })
	}

	//报活
	function newReport(rjhmId, jcType){
		var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+rjhmId+'&type='+jcType;
		diag.Width=1000;
		diag.Height=520;
		diag.show();
	}

</script> 
<style type="text/css"> 
	html,body,ul,li{padding:0; margin:0;}
	body {font:12px/normal Verdana, Arial, Helvetica, sans-serif; padding:0px;}
	ul,li {list-style-type:none; text-transform:capitalize;}
	/*menu*/
	#nav { display:block;}
	#nav .jquery_out {float:left;line-height:32px;display:block; border-right:1px solid #fff; text-align:center; color:#fff;font:18px/32px "微软雅黑"; background:#062723 url(../images/slide-panel_03.png) 0 0 repeat-x;}
	#nav .jquery_out .smile {padding-left:1em;}
	#nav .jquery_inner {margin-left:16px;}
	#nav .jquery {margin-right:1px;padding:0 2em;}
	#nav .mainlevel {background:#E4E6EB; float:left; border-right:1px solid #fff; width:140px;/*IE6 only*/}
	#nav .mainlevel a {color:#0362BE; text-decoration:none; line-height:32px; display:block; padding:0 20px; width:100px;font-weight: bold;}
	#nav .mainlevel a:hover {color:#000; text-decoration:none;background:#E4E6EB; }
	#nav .mainlevel ul {display:none; position:absolute;}
	#nav .mainlevel li {border-top:1px solid #fff; background:#E4E6EB; width:140px;/*IE6 only*/}
</style> 

</head>
<body>
<div id="content">
    <table cellspacing="0" cellpadding="0">
       	<tr>
				<th width="5%">序号</th>
				<th width="10%">机车号</th>
				<th width="5%">修程</th>
				<th width="5%">股道</th>
				<th width="5%">台位</th>
				<th width="10%">扣车时间</th>
				<th width="10%">计划起机时间</th>
				<th width="10%">计划交车时间</th>
				<th width="10%">交车工长</th>
				<th width="5%">状态</th>
				<th width="15%">记录查看</th>
		</tr>
		<c:forEach items="${allJC }" var="plan" varStatus="index">
            <tr>
            	<td align="center">${index.index+1 }</td>
                <td align="center">
                   <c:if test="${plan.projectType==0}">
                       <a href="<%=basePath%>query!getInfoByJC.do?rjhmId=${plan.rjhmId}&psize=100" target="_blakn">${plan.jcType }-${plan.jcnum }</a>
                   </c:if>
                   <c:if test="${plan.projectType==1}">
                       <a href="<%=basePath%>query!getZxInfoByJC.do?rjhmId=${plan.rjhmId}&psize=100" target="_blakn">${plan.jcType }-${plan.jcnum }</a>
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
                <td align="center"><a href="javascript:void(0);" onclick="clickGD(${plan.rjhmId } )">${plan.gdh }道</a></td>
                <td align="center">${plan.twh }</td>
                <td align="center">${fn:substring(plan.kcsj,5,16) }</td>
                <td align="center">${fn:substring(plan.jhqjsj,5,16) }</td>
                <td align="center">${fn:substring(plan.jhjcsj,5,16) }</td>
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
	                <c:if test="${plan.projectType==0}">
	                   <a href="<%=basePath%>query!view.do?rjhmId=${plan.rjhmId }" target="_blank">检修记录</a>
	                </c:if>
	               	<c:if test="${plan.projectType==1}">
	               	   <a href="<%=basePath%>query!zxView.do?rjhmId=${plan.rjhmId}" target="_blank">检修记录</a>
	               	</c:if>
	               	<a href="<%=basePath%>reportWorkManage!reportWork.action?id=${plan.rjhmId}">我报的活</a>
	               	<a href="javascript:void;" onclick="newReport('${plan.rjhmId}', '${plan.jcType }');">报活</a>
	               	
	               	<c:if test='${fn:contains(session_user.roles,",DZ,") && plan.fixFreque == "QZ" }'>
	                   <a href="<%=basePath%>qz!listZeroPreDict.do?rjhmId=${plan.rjhmId }" target="_blank">机车质量评定</a>
	                </c:if>
	            </td>
            </tr>
		</c:forEach>
    </table>
</div>
</body>
</html>