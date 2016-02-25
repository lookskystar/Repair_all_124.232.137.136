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
    <title>签认电力试运行试验项目</title>
    <script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript" src="experiment/js/experiment.js"></script>
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
    	<span style="font-size: 16px; font-weight: bold;">${datePlan.jcType }型机车中修试运记录</span>
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
    <td height="19" colspan="1">吨位</td>
    <td height="19" colspan="2">
      <a href="javascript:void(0)" class="vala" title="${itemRecs.a1info}${recMap.others}">${itemRecs.a1}</a>
    </td>
       <td colspan="2" height="19" width="994">
    	<c:if test="${roleFlag==2}">
    		<c:choose>
    			<c:when test="${!empty experiment.leader}"><span style="font-size: 14px;font-weight: bold;color: blue;">工长：${experiment.leader}</span></c:when>
    			<c:otherwise><input type="button" onclick="signAll()" value="工长全签"/></c:otherwise>
    		</c:choose>
    	</c:if>
      	<c:if test="${roleFlag==3}">
	      	<c:choose>
	      		<c:when test="${!empty experiment.qi}"><span style="font-size: 14px;font-weight: bold;color: blue;">质检员：${experiment.qi}</span></c:when>
	    		<c:otherwise><input type="button" onclick="signAll()" value="质检员全签"/></c:otherwise>
	    	</c:choose>
      	</c:if>
      	<c:if test="${roleFlag==4}">
      		<c:choose>
      			<c:when test="${!empty experiment.teachName}"><span style="font-size: 14px;font-weight: bold;color: blue;">技术员：${experiment.teachName}</span></c:when>
    			<c:otherwise><input type="button" onclick="signAll()" value="技术员全签"/></c:otherwise>
      		</c:choose>
      	</c:if>
      	<c:if test="${roleFlag==5}">
      		<c:choose>
      			<c:when test="${!empty experiment.commitLead}"><span style="font-size: 14px;font-weight: bold;color: blue;">交车工长：${experiment.commitLead}</span></c:when>
    			<c:otherwise><input type="button" onclick="signAll()" value="交车工长全签"/></c:otherwise>
      		</c:choose>
      	</c:if>
      	<c:if test="${roleFlag==6}">
      		<c:choose>
      			<c:when test="${!empty experiment.accepter}"><span style="font-size: 14px;font-weight: bold;color: blue;">验收员：${experiment.accepter}</span></c:when>
    			<c:otherwise><input type="button" onclick="signAll()" value="验收员全签"/></c:otherwise>
      		</c:choose>
      	</c:if>
    </td>
  </tr>
  <tr>
    <td height="38" width="994">试运人员</td>
    <td height="38" width="994" colspan="13">
    <a href="javascript:void(0)" class="vala" title="${itemRecs.a2info}${recMap.others}">${itemRecs.a2}</a>
    </td>
  </tr>
  <tr>
    <td colspan="14" height="19" width="994">试运情况</td>
  </tr>
  <tr>
    <td colspan="7" height="19" width="994">分  流  情  况 </td>
    <td colspan="7" height="19" width="994">抱 轴 承 情 况（温度℃）</td>
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
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d1info}${recMap.others}">${itemRecs.D1d1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d2info}${recMap.others}">${itemRecs.D1d2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d3info}${recMap.others}">${itemRecs.D1d3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d4info}${recMap.others}">${itemRecs.D1d4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d5info}${recMap.others}">${itemRecs.D1d5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D1d6info}${recMap.others}">${itemRecs.D1d6}</a></td>
    <td height="19" width="994">左</td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e1info}${recMap.others}">${itemRecs.E1e1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e2info}${recMap.others}">${itemRecs.E1e2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e3info}${recMap.others}">${itemRecs.E1e3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e4info}${recMap.others}">${itemRecs.E1e4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e5info}${recMap.others}">${itemRecs.E1e5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E1e6info}${recMap.others}">${itemRecs.E1e6}</a></td>
  </tr>
  <tr>
    <td height="19" width="994">一  级</td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d1info}${recMap.others}">${itemRecs.D2d1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d2info}${recMap.others}">${itemRecs.D2d2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d3info}${recMap.others}">${itemRecs.D2d3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d4info}${recMap.others}">${itemRecs.D2d4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d5info}${recMap.others}">${itemRecs.D2d5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D2d6info}${recMap.others}">${itemRecs.D2d6}</a></td>
    <td height="19" width="994">右</td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e1info}${recMap.others}">${itemRecs.E2e1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e2info}${recMap.others}">${itemRecs.E2e2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e3info}${recMap.others}">${itemRecs.E2e3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e4info}${recMap.others}">${itemRecs.E2e4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e5info}${recMap.others}">${itemRecs.E2e5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.E2e6info}${recMap.others}">${itemRecs.E2e6}</a></td>
  </tr>
  <tr>
    <td height="19" width="994">二  级</td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d1info}${recMap.others}">${itemRecs.D3d1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d2info}${recMap.others}">${itemRecs.D3d2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d3info}${recMap.others}">${itemRecs.D3d3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d4info}${recMap.others}">${itemRecs.D3d4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d5info}${recMap.others}">${itemRecs.D3d5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.D3d6info}${recMap.others}">${itemRecs.D3d6}</a></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
  </tr>
  <tr>
    <td height="19" width="994">三  级</td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B1b1info}${recMap.others}">${itemRecs.B1b1}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B1b2info}${recMap.others}">${itemRecs.B1b2}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B1b3info}${recMap.others}">${itemRecs.B1b3}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B1b4info}${recMap.others}">${itemRecs.B1b4}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B1b5info}${recMap.others}">${itemRecs.B1b5}</a></td>
    <td height="19" width="994"><a href="javascript:void(0)" class="vala" title="${itemRecs.B2b1info}${recMap.others}">${itemRecs.B2b1}</a></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
  </tr>
  <tr>
    <td width="994" rowspan="12">其 <br />
      他 <br />
      情 <br />
      况</td>
    <td width="1988">电器</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B2b2info}${recMap.others}">${itemRecs.B2b2}</a></td>
  </tr>
  <tr>
    <td width="1988">电子</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B2b3info}${recMap.others}">${itemRecs.B2b3}</a></td>
  </tr>
  <tr>
    <td width="1988">电机</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B2b4info}${recMap.others}">${itemRecs.B2b4}</a></td>
  </tr>
  <tr>
    <td width="1988">制动</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B2b5info}${recMap.others}">${itemRecs.B2b5}</a></td>
  </tr>
  <tr>
    <td width="1988">台车</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B3b1info}${recMap.others}">${itemRecs.B3b1}</a></td>
  </tr>
  <tr>
    <td width="1988">受电弓</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B3b2info}${recMap.others}">${itemRecs.B3b2}</a></td>
  </tr>
  <tr>
    <td width="1988">主断</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B3b3info}${recMap.others}">${itemRecs.B3b3}</a></td>
  </tr>
  <tr>
    <td width="1988">仪表</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B3b4info}${recMap.others}">${itemRecs.B3b4}</a></td>
  </tr>
  <tr>
    <td width="1988">充电</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.B3b5info}${recMap.others}">${itemRecs.B3b5}</a></td>
  </tr>
  <tr>
    <td width="1988">柴备</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.c1info}${recMap.others}">${itemRecs.c1}</a></td>
  </tr>
  <tr>
    <td width="1988">自停</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.c2info}${recMap.others}">${itemRecs.c2}</a></td>
  </tr>
  <tr>
    <td width="1988">其他</td>
    <td colspan="17" valign="top"><a href="javascript:void(0)" class="vala" title="${itemRecs.f1info}${recMap.others}">${itemRecs.f1}</a></td>
  </tr>
</table>
  <input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
  <input type="hidden" id="expId" value="${expId}"/>
  <input type="hidden" id="roleFlag" value="${roleFlag}"/>
  <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>