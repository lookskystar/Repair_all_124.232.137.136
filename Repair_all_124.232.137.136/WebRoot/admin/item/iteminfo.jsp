<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript">
	   function closeDialog(){
			top.Dialog.close();
	   }
	</script>
  </head>
<body>
    <form action="fixItemAction!itemInfoInput.do" method="post" target="frmright"> 
		<table class="tableStyle" transMode="true">
		   	<tr>
				<td>所处节点: </td>
				<td>
				   机车检修
				</td>
			
				<td>机车类型: </td>
				<td>
				  ${jcFixitem.jcsType }
				</td>
			</tr>
			<tr>
				<td>大部件名称: </td>
				<td>
				   ${jcFixitem.unitName }
				</td>
			
				<td>二级部件名称: </td>
				<td>
				  ${jcFixitem.secUnitName }
				</td>
			</tr>
	 		<tr>
				<td>部位名称: </td>
				<td>
				     ${jcFixitem.posiName }
				</td>
			
				<td>所属班组: </td>
				<td>
				    ${jcFixitem.banzuId.proteamname }
				</td>
			</tr>
			<tr>
				<td>填报默认值: </td>
				<td>
				  ${jcFixitem.fillDefaVal }
				</td>
			
				<td>单位: </td>
				<td>
				 ${jcFixitem.unit}
				</td>
			</tr>
			<tr>
				<td>最小值: </td>
				<td>
				  ${jcFixitem.min}
				</td>
			
				<td>最大值: </td>
				<td>
				   ${jcFixitem.max}
				</td>
			</tr>
			<tr>
				<td>技术员卡控: </td>
				<td>
				  <c:if test="${jcFixitem.itemCtrlTech==0}">不卡控</c:if>
				  <c:if test="${jcFixitem.itemCtrlTech==1}">卡控</c:if>
				</td>
			
				<td>质检员卡控: </td>
				<td>
				    <c:if test="${jcFixitem.itemCtrlQI==0}">不卡控</c:if>
				    <c:if test="${jcFixitem.itemCtrlQI==1}">卡控</c:if>
				</td>
			</tr>
			
			<tr>
				<td>交车工长卡控: </td>
				<td>
				    <c:if test="${jcFixitem.itemCtrlComLd==0}">不卡控</c:if>
				    <c:if test="${jcFixitem.itemCtrlComLd==1}">卡控</c:if>
				</td>
			
				<td>验收员卡控: </td>
				<td>
				   <c:if test="${jcFixitem.itemCtrlAcce==0}">不卡控</c:if>
				   <c:if test="${jcFixitem.itemCtrlAcce==1}">卡控</c:if>
				</td>
			</tr>
			<tr>
				<td>项目名称: </td>
				<td colspan="3">
				   <textarea rows="5" cols="50" class="default" readonly="readonly">${jcFixitem.itemName }</textarea>
				</td>
			</tr>
			<tr>
				<td>修程修次: </td>
				<td colspan="3">
				   <textarea rows="5" cols="50" class="default" readonly="readonly">${jcFixitem.xcxc }</textarea>
				</td>
			</tr>
			<tr><td colspan="4" align="center"><input type="button" value="确定" onclick="closeDialog();"/></td></tr>      
		</table>
	</form>
</body>
</html>