<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<title>机车检修登记薄</title>
</head>

<body bgcolor="#f8f7f7">
<form id="form1" name="form1" method="post" action="">
<table width="800" border="0" align="center" cellspacing="0" vspace="0">
<tr>
<td colspan="5" align="center"><h2 align="center"><font style="font-family:'隶书'"><b>机车检修登记薄</b></font></h2></td>
</tr>
<tr>
<td  align="left" colspan="4">修程： LX</td>
<td  align="right"><h5>机统29</h5></td>
</tr>
<tr><td colspan="6">
<table width="800" border="0" align="center" cellspacing="0" vspace="0">
 <tr>
	<td align="center" colspan="3" class="tbCELL3">
  <table width="800" border="0" align="center" cellspacing="0" vspace="0">
    <tr>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">机车型号</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">交车司<br>机姓名</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">入段经过分<br>界点时分</td>
      <td class="tbCELL1" align="center" colspan="2" nowrap="nowrap">交出机车</td>
      <td class="tbCELL1" align="center" colspan="2" nowrap="nowrap">修理开始</td>
      <td class="tbCELL1" align="center" colspan="2" nowrap="nowrap">修理终了</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">转入<BR>非运用时间</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">修理项目</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">承修人</td>
      <td class="tbCELL1" align="center" rowspan="2" nowrap="nowrap">记事</td>
    </tr>
    <tr>
      <td class="tbCELL1" align="center">月日</td>
      <td class="tbCELL1" align="center">时分</td>
      <td class="tbCELL1" align="center">月日</td>
      <td class="tbCELL1" align="center">时分</td>
      <td class="tbCELL1" align="center">月日</td>
      <td class="tbCELL1" align="center">时分</td>
    </tr>
    <tr>
      <td class="tbCELL1" align="center">SS3B 0055A</td>
      <td class="tbCELL1" align="center">计伟</td>
      <td class="tbCELL1" align="center">2012-10-17<br>07:20:21</td>
      <td class="tbCELL1" align="center">2012-10-17</td>
      <td class="tbCELL1" align="center">08:10:12</td>
      <td class="tbCELL1" align="center">2012-10-17</td>
      <td class="tbCELL1" align="center">09:35:12</td>
      <td class="tbCELL1" align="center">2012-10-17</td>
      <td class="tbCELL1" align="center">15:40:38</td>
      <td class="tbCELL1" align="center">2012-10-17<br>15:41:01</td>
      <td class="tbCELL1" align="center">司机室小闸插头</td>
      <td class="tbCELL1" align="center">汤政伟</td>
      <td class="tbCELL1" align="center">更换</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
	<tr>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
      <td class="tbCELL1" align="center">&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
</form>
</body>
</html>