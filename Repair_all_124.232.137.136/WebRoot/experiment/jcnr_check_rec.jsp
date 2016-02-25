<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<Script type="text/javascript" src="js/jquery.form.js"></Script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--文本截取end-->
<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript" src="js/nav/tab.js"></script>

<script type="text/javascript">
   $( function() {
	 var tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab',
		position :"top"
	});
	tab.add( {
		id :'tab_index0',
		title :"压缩压力",
		url :"checkSign!nrYsylCheckInput.do?dpId=${dpId}",
		isClosed :false
	});
	tab.add( {
		id :'tab_index1',
		title :"滑油压力",
		url :"checkSign!nrHyylCheckInput.do?dpId=${dpId}",
		isClosed :false
	});
	tab.add( {
		id :'tab_index2',
		title :"燃油压力",
		url :"checkSign!nrRyylCheckInput.do?dpId=${dpId}",
		isClosed :false
	});
	tab.add( {
		id :'tab_index3',
		title :"绝缘检测",
		url :"checkSign!nrDdjyCheckInput.do?dpId=${dpId}",
		isClosed :false
	});
		tab.add( {
		id :'tab_index4',
		title :"保护装置",
		url :"checkSign!nrBhzzCheckInput.do?dpId=${dpId}",
		isClosed :false
	});
	tab.activate("tab_index0")
	});
   
   //签认 type:1交车工长签认 2：质检员签认  3：验收签认
   function sign(djmId,type){
	   top.Dialog.open({URL:"<%=basePath%>checkSign!signDialogInput.do?djmId="+djmId+"&type="+type,Width:400,Height:200,Title:"签认"});
   }
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td  width="65%">
	    	<div class="box2"  panelTitle="交车检测项目" roller="true" showStatus="false" overflow="auto" panelHeight="450" >
	    	   <div id="tab_menu"></div>
			   <div id="page" style="width:100%;height:350px;"></div>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="交车签认列表"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
	    	  <div id="showImage">
	    	    <table width="100%" class="tableStyle">
					<tr>
					    <th  class="ver01" width="10%">标识</th>
						<th class="ver01">工号</th>
						<th class="ver01">签到人</th>
						<th class="ver01">签到时间</th>
					</tr>
					<c:forEach items="${signatures}" var="entity">
					   <tr>
					   <td class="ver01" align="center">${entity.signatireId}</td>
					    <td class="ver01" align="center">${entity.user.gonghao}</td>
						<td class="ver01" align="center">${entity.user.xm}</td>
						<td class="ver01" align="center">${entity.signTime}</td>
					  </tr>
					</c:forEach>
				</table>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>