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
    <title>签认顶轮试验项目</title>
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
		td{height:20px; line-height: 20px;}
		input{width:100px;}
		a:LINK,a:VISITED {color: blue;width: 100%; text-align: center;}
	</style>
  </head>
  
  <body>
  	
  	<div align="center">
  <table border="1" cellspacing="0" cellpadding="0" width="621">
    <tr>
      <td colspan="8"><br />
      <p align="center"><strong>${datePlan.jcType}型机车中修轴检记名检修记录</strong></p>
	  </td>
    </tr>
	<tr>
      <td colspan="2">
      	机车号
      </td>
      <td>${datePlan.jcnum}</td>
      <td width="35"><p align="center">修程</p></td>
      <td width="66">${datePlan.fixFreque}</td>
      <td width="77"><p align="center">试验时间</p></td>
      <td width="186">
      	<c:choose>
      	 	<c:when test="${empty experiment.empAffirmTime}">
      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 85px;"/>
   		 		<input type="button" value="提交时间" onclick="changeExpTime()" style="width:60px;"/>
      	 	</c:when>
      	 	<c:otherwise>
      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 85px;"/>
   		 		<input type="button" value="修改时间" onclick="changeExpTime()" style="width:60px;"/>
      	 	</c:otherwise>
      	 </c:choose>
      </td>
      <td width="100">
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
      <td colspan="4"><br />
          <strong>工作内容 </strong> </td>
      <td colspan="2"><p align="center"><strong>检  </strong><strong>次 </strong></p></td>
      <td colspan="2"><p align="center"><strong>工作者 </strong></p></td>
    </tr>
    <tr>
      <td colspan="4" rowspan="2"><p align="center">用JL—601A或JL-201型机车轴承检测仪对轴箱轴承和抱轴承进行振动检测</p></td>
      <td colspan="2" rowspan="2"><p align="center">中修试运前</p></td>
      <td width="77"><p align="center">轴箱轴承</p></td>
      <td width="186"><p align="center">${itemRecs.a1}</p></td>
    </tr>
    <tr>
      <td width="77"><p align="center">抱轴承</p></td>
      <td width="186"><p align="center">${itemRecs.a2}</p></td>
    </tr>
    <tr>
      <td colspan="2"><p align="center"><strong>轮  </strong><strong>位 </strong></p></td>
      <td width="78"><p align="center"><strong>轴 </strong><strong>箱 </strong><br />
              <strong>轴 </strong><strong>承 </strong></p></td>
      <td width="65"><p align="center"><strong>抱轴承 </strong></p></td>
      <td colspan="4"><p align="center"><strong>主 </strong><strong>要 </strong><strong>技 </strong><strong>术 </strong><strong>要 </strong><strong>求 </strong></p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>1</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b1}</p></td>
      <td width="65"><p align="center">${itemRecs.c1}</p></td>
      <td colspan="4" rowspan="12"><ol>
        <li>轮对转速500r/min(110Km/h)</li>
        <li>故障判断标准</li>
      </ol>
          <table border="1" cellspacing="0" cellpadding="0">
            <tr>
              <td width="41" valign="top"><p align="center">名称</p></td>
              <td width="144" valign="top"><p>注意域<br />
                （任一种情况）</p></td>
              <td width="158" valign="top"><p>故障域<br />
                （任一种情况）</p></td>
            </tr>
            <tr>
              <td width="41"><p align="center">轴箱轴承</p></td>
              <td width="144" valign="top"><ol>
                <li>KV≥15</li>
                <li>20g≤Gmax＜30g</li>
                <li>3g≤Grms＜6g</li>
              </ol></td>
              <td width="158" valign="top"><p>1、Gmax≥30g<br />
                2、Grms≥6g <br />
                3、解调谱对应故障频率纵标度≥10-1 级 </p></td>
            </tr>
            <tr>
              <td width="41"><p align="center">抱轴承</p></td>
              <td width="144" valign="top"><p>1、KV≥4.6<br />
                2、25g≤Gmax＜40g<br />
                3、5g≤Grms＜10g <br />
                （1、3、4、6位）<br />
                4g≤Grms＜8g（2、5位）</p></td>
              <td width="158" valign="top"><p>1、Gmax≥40g<br />
                2、Grms≥10g <br />
                （1、3、4、6位）<br />
                Grms≥5g（2、5位） <br />
                3、解调谱对应故障频率纵标度≥10-1 级 </p></td>
            </tr>
          </table>
        <ol>
          <li>轴承计算故障频率（单位：HZ）</li>
        </ol>
        <table border="1" cellspacing="0" cellpadding="0">
            <tr>
              <td width="98" rowspan="2"><p align="center">名 称</p></td>
              <td width="99" rowspan="2"><p align="center">轴箱轴承</p></td>
              <td width="144" colspan="2" valign="top"><p align="center">抱轴承</p></td>
            </tr>
            <tr>
              <td width="72" valign="top"><p align="center">齿侧</p></td>
              <td width="72" valign="top"><p align="center">非齿侧</p></td>
            </tr>
            <tr>
              <td width="98" valign="top"><p align="center">内圈故障</p></td>
              <td width="99" valign="top"><p align="center">89.7</p></td>
              <td width="72" valign="top"><p align="center">209</p></td>
              <td width="72" valign="top"><p align="center">232</p></td>
            </tr>
            <tr>
              <td width="98" valign="top"><p align="center">外圈故障</p></td>
              <td width="99" valign="top"><p align="center">66.0</p></td>
              <td width="72" valign="top"><p align="center">185</p></td>
              <td width="72" valign="top"><p align="center">208</p></td>
            </tr>
            <tr>
              <td width="98" valign="top"><p align="center">滚子故障</p></td>
              <td width="99" valign="top"><p align="center">29.6</p></td>
              <td width="72" valign="top"><p align="center">76</p></td>
              <td width="72" valign="top"><p align="center">88</p></td>
            </tr>
            <tr>
              <td width="98" valign="top"><p align="center">保持架故障</p></td>
              <td width="99" valign="top"><p align="center">3.9</p></td>
              <td width="72" valign="top"><p align="center">4.3</p></td>
              <td width="72" valign="top"><p align="center">4.3</p></td>
            </tr>
        </table></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b2}</p></td>
      <td width="65"><p align="center">${itemRecs.c2}</p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>2</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b3}</p></td>
      <td width="65"><p align="center">${itemRecs.c3}</p></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b4}</p></td>
      <td width="65"><p align="center">${itemRecs.c4}</p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>3</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b5}</p></td>
      <td width="65"><p align="center">${itemRecs.c5}</p></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b6}</p></td>
      <td width="65"><p align="center">${itemRecs.c6}</p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>4</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b7}</p></td>
      <td width="65"><p align="center">${itemRecs.c7}</p></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b8}</p></td>
      <td width="65"><p align="center">${itemRecs.c8}</p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>5</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b9}</p></td>
      <td width="65"><p align="center">${itemRecs.c9}</p></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b10}</p></td>
      <td width="65"><p align="center">${itemRecs.c10}</p></td>
    </tr>
    <tr>
      <td width="45" rowspan="2"><p align="center"><strong>6</strong></p></td>
      <td width="51"><p align="center"><strong>L</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b11}</p></td>
      <td width="65"><p align="center">${itemRecs.c11}</p></td>
    </tr>
    <tr>
      <td width="51"><p align="center"><strong>R</strong></p></td>
      <td width="78"><p align="center">${itemRecs.b12}</p></td>
      <td width="65"><p align="center">${itemRecs.c12}</p></td>
    </tr>
    <tr>
      <td width="45"><p align="center"><strong>备注 </strong></p></td>
      <td colspan="7">${itemRecs.d1}</td>
    </tr>
  </table>
  <input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
  <input type="hidden" id="expId" value="${expId}"/>
  <input type="hidden" id="roleFlag" value="${roleFlag}"/>
</div>
   <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>