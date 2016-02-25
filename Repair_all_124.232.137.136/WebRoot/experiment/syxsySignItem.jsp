<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
   <base href="<%=basePath%>"/>
    <title>签认内燃试运行试验项目</title>
    <script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript" src="experiment/js/experiment.js"></script>
	 <script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
	<!--截取文字end-->
	<style type="text/css">
		body{margin:0; padding:0; font-size:12px;}
		tr{text-algin:center;}
		td{height:20px; text-align:center; line-height: 20px;}
		input{width:50px;}
		a:LINK,a:VISITED {color: blue;width: 100%; text-align: center;}
	</style>
    <script type="text/javascript">
      function getUserName(){
		var user="${session_user.xm}";
		var username=$("#a2").val();
		if(username.length==0){
			$("#a2").val(user+",");
		}else{
			$("#a2").val(username+user+",");
		}
		$("#a2").change();
	  }
    </script>
  </head>
  
  <body>
   <table width="924" height="591" border="1" cellpadding="0" cellspacing="0">
  <col width="119" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="52" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="48" />
  <col width="26" />
  <col width="54" />
  <col width="49" />
  <tr>
    <td colspan="14" height="61" width="994">
    	<span style="font-size: 16px; font-weight: bold;">${datePlan.jcType}型机车中修试运记录</span>
    </td>
  </tr>
  
  <tr>
    <td height="19" width="994">车号</td>
    <td height="19" colspan="2" width="994">${datePlan.jcnum}</td>
    <td height="19" width="994">修次</td>
    <td height="19" colspan="2" width="994">${datePlan.fixFreque}</td>
    <td height="19" colspan="2" width="994">试运日期</td>
    <td colspan="2" height="19" width="994">
    	 <c:choose>
      	 	<c:when test="${empty experiment.empAffirmTime}">
      	 		<input type="text" id="sytime" class="Wdate" onfocus="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 85px;"/>
   		 		<input type="button" value="提交时间" onclick="changeExpTime()" style="width:60px;"/>
      	 	</c:when>
      	 	<c:otherwise>
      	 		<input type="text" id="sytime" class="Wdate" onfocus="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 85px;"/>
   		 		<input type="button" value="修改时间" onclick="changeExpTime()" style="width:60px;"/>
      	 	</c:otherwise>
      	 </c:choose>
    </td>
    <td height="19" colspan="2">吨位</td>
    <td height="19" colspan="2"><input name="a1" value="${itemRecs.a1}" recid="${itemRecs.a1id}" type="text"></td>
  </tr>
  <tr>
    <td height="38" width="994">试运人员</td>
    <td height="38" width="994" colspan="13"><input name="a2" value="${itemRecs.a2}" recid="${itemRecs.a2id}" type="text" style="width:460px;" id="a2">
      &nbsp;&nbsp;&nbsp;	<input type="button" value="签名" onclick="getUserName()" style="width:60px;"/>
    </td>
  </tr>
  <tr>
    <td colspan="14" height="19" width="994">功率情况</td>
  </tr>
  <tr>
    <td height="19" width="994">主发电流</td>
    <td colspan="2" height="19" width="994">主发电流</td>
    <td colspan="2" height="19" width="994">主发电压</td>
    <td colspan="2" height="19" width="994">供油刻线</td>
    <td colspan="2" height="19" width="994">油马达位置</td>
    <td colspan="5" height="19" width="994">燃油压力</td>
  </tr>
  <tr>
    <td height="19" width="994">8位（700转/分）</td>
    <td colspan="2" height="19" width="994"><input name="B1b1" value="${itemRecs.B1b1}" recid="${itemRecs.B1b1id}" type="text" style="width:80px;"/>A</td>
    <td colspan="2" height="19" width="994"><input name="B1b2" value="${itemRecs.B1b2}" recid="${itemRecs.B1b2id}" type="text" style="width:80px;"/>V</td>
    <td colspan="2" height="19" width="994"><input name="B1b3" value="${itemRecs.B1b3}" recid="${itemRecs.B1b3id}" type="text" style="width:80px;"/>刻</td>
    <td colspan="2" height="19" width="994"><input name="B1b4" value="${itemRecs.B1b4}" recid="${itemRecs.B1b4id}" type="text" style="width:80px;"/>格</td>
    <td colspan="5" height="19" width="994"><input name="B1b5" value="${itemRecs.B1b5}" recid="${itemRecs.B1b5id}" type="text" style="width:80px;"/>Kpa</td>
  </tr>
  <tr>
    <td height="19" width="994">12位（850转/分）</td>
    <td colspan="2" height="19" width="994"><input name="B2b1" value="${itemRecs.B2b1}" recid="${itemRecs.B2b1id}" type="text" style="width:80px;"/>A</td>
    <td colspan="2" height="19" width="994"><input name="B2b2" value="${itemRecs.B2b2}" recid="${itemRecs.B2b2id}" type="text" style="width:80px;"/>V</td>
    <td colspan="2" height="19" width="994"><input name="B2b3" value="${itemRecs.B2b3}" recid="${itemRecs.B2b3id}" type="text" style="width:80px;"/>刻</td>
    <td colspan="2" height="19" width="994"><input name="B2b4" value="${itemRecs.B2b4}" recid="${itemRecs.B2b4id}" type="text" style="width:80px;"/>格</td>
    <td colspan="5" height="19" width="994"><input name="B2b5" value="${itemRecs.B2b5}" recid="${itemRecs.B2b5id}" type="text" style="width:80px;"/>Kpa</td>
  </tr>
  <tr>
    <td height="19" width="994">16位（1000转/分）</td>
    <td colspan="2" height="19" width="994"><input name="B3b1" value="${itemRecs.B3b1}" recid="${itemRecs.B3b1id}" type="text" style="width:80px;"/>A</td>
    <td colspan="2" height="19" width="994"><input name="B3b2" value="${itemRecs.B3b2}" recid="${itemRecs.B3b2id}" type="text" style="width:80px;"/>V</td>
    <td colspan="2" height="19" width="994"><input name="B3b3" value="${itemRecs.B3b3}" recid="${itemRecs.B3b3id}" type="text" style="width:80px;"/>刻</td>
    <td colspan="2" height="19" width="994"><input name="B3b4" value="${itemRecs.B3b4}" recid="${itemRecs.B3b4id}" type="text" style="width:80px;"/>格</td>
    <td colspan="5" height="19" width="994"><input name="B3b5" value="${itemRecs.B3b5}" recid="${itemRecs.B3b5id}" type="text" style="width:80px;"/>Kpa</td>
  </tr>
  <tr>
    <td rowspan="2" height="40" width="994">过渡点</td>
    <td rowspan="2" height="40" width="994">一级</td>
    <td height="19" width="994">吸合</td>
    <td height="19" colspan="11" style="text-align: left;padding-left: 20px;"><input name="c1" value="${itemRecs.c1}" recid="${itemRecs.c1id}" type="text" style="width:100px;"/></td>
  </tr>
  <tr>
    <td height="19" width="994">释放</td>
    <td height="19" colspan="11" style="text-align: left;padding-left: 20px;"><input name="c2" value="${itemRecs.c2}" recid="${itemRecs.c2id}" type="text" style="width:100px;"/></td>
  </tr>
  
  <tr>
    <td colspan="7" height="19" width="994">分  流  情  况 </td>
    <td colspan="7" height="19" width="994">抱 轴 承 情 况（温度    ℃）</td>
  </tr>
  <tr>
    <td height="19" width="994"></td>
    <td height="19" width="994">1D</td>
    <td height="19" width="994">2D</td>
    <td height="19" width="994">3D</td>
    <td height="19" width="994">4D</td>
    <td height="19" width="994">5D</td>
    <td height="19" width="994">6D</td>
    <td height="19" width="994"></td>
    <td height="19" width="994">1D</td>
    <td height="19" width="994">2D</td>
    <td height="19" width="994">3D</td>
    <td height="19" width="994">4D</td>
    <td height="19" width="994">5D</td>
    <td height="19" width="994">6D</td>
  </tr>
  <tr>
    <td height="19" width="994">全磁场</td>
    <td height="19" width="994"><input name="D1d1" value="${itemRecs.D1d1}" recid="${itemRecs.D1d1id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D1d2" value="${itemRecs.D1d2}" recid="${itemRecs.D1d2id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D1d3" value="${itemRecs.D1d3}" recid="${itemRecs.D1d3id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D1d4" value="${itemRecs.D1d4}" recid="${itemRecs.D1d4id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D1d5" value="${itemRecs.D1d5}" recid="${itemRecs.D1d5id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D1d6" value="${itemRecs.D1d6}" recid="${itemRecs.D1d6id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994">左</td>
    <td height="19" width="994"><input name="E1e1" value="${itemRecs.E1e1}" recid="${itemRecs.E1e1id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E1e2" value="${itemRecs.E1e2}" recid="${itemRecs.E1e2id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E1e3" value="${itemRecs.E1e3}" recid="${itemRecs.E1e3id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E1e4" value="${itemRecs.E1e4}" recid="${itemRecs.E1e4id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E1e5" value="${itemRecs.E1e5}" recid="${itemRecs.E1e5id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E1e6" value="${itemRecs.E1e6}" recid="${itemRecs.E1e6id}" type="text" style="width:50px;"/></td>
  </tr>
  <tr>
    <td height="19" width="994">一  级</td>
    <td height="19" width="994"><input name="D2d1" value="${itemRecs.D2d1}" recid="${itemRecs.D2d1id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D2d2" value="${itemRecs.D2d2}" recid="${itemRecs.D2d2id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D2d3" value="${itemRecs.D2d3}" recid="${itemRecs.D2d3id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D2d4" value="${itemRecs.D2d4}" recid="${itemRecs.D2d4id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D2d5" value="${itemRecs.D2d5}" recid="${itemRecs.D2d5id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D2d6" value="${itemRecs.D2d6}" recid="${itemRecs.D2d6id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994">右</td>
    <td height="19" width="994"><input name="E2e1" value="${itemRecs.E2e1}" recid="${itemRecs.E2e1id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E2e2" value="${itemRecs.E2e2}" recid="${itemRecs.E2e2id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E2e3" value="${itemRecs.E2e3}" recid="${itemRecs.E2e3id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E2e4" value="${itemRecs.E2e4}" recid="${itemRecs.E2e4id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E2e5" value="${itemRecs.E2e5}" recid="${itemRecs.E2e5id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="E2e6" value="${itemRecs.E2e6}" recid="${itemRecs.E2e6id}" type="text" style="width:50px;"/></td>
  </tr>
  <tr>
    <td height="19" width="994">二  级</td>
    <td height="19" width="994"><input name="D3d1" value="${itemRecs.D3d1}" recid="${itemRecs.D3d1id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D3d2" value="${itemRecs.D3d2}" recid="${itemRecs.D3d2id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D3d3" value="${itemRecs.D3d3}" recid="${itemRecs.D3d3id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D3d4" value="${itemRecs.D3d4}" recid="${itemRecs.D3d4id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D3d5" value="${itemRecs.D3d5}" recid="${itemRecs.D3d5id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"><input name="D3d6" value="${itemRecs.D3d6}" recid="${itemRecs.D3d6id}" type="text" style="width:50px;"/></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
  </tr>
  <tr>
    <td height="50" width="994">试运中其他情况</td>
    <td colspan="13" align="left" style="text-align: left;padding-left: 20px;">
    	<input name="f1" value="${itemRecs.f1}" recid="${itemRecs.f1id}" type="text" style="width:300px;"/>
    </td>
  </tr>
</table>
  <input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
  <input type="hidden" id="expId" value="${expId}"/>
  <input type="hidden" id="roleFlag" value="${roleFlag}"/>
  <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>