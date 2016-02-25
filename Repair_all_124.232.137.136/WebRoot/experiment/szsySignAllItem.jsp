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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>水阻试验交车工长和验收员全签</title>
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
	<!--修正IE6支持透明PNG图end-->
	<!--截取文字end-->
	<style type="text/css">
		body{margin:0; padding:0; font-size:12px;}
		tr{text-algin:center;}
		td{height:20px; text-align:center; line-height: 20px; border:1px solid #ccc;}
		a:LINK,a:VISITED {color: blue;width: 100%;text-align: center; text-decoration: none;}
	</style>
	<script type="text/javascript">
		function signItem(itemFlag,num){
			var rjhmId = $("#rjhmId").val();
			var expId = $("#expId").val();
			var roleFlag = $("#roleFlag").val();
			var len = $("a[name="+itemFlag+"]").length;
			if(len==0){
				top.Dialog.alert("还有检修员未签认的项目，您暂时不能签认");
				return false;
			}else{
				var flag = true;
				$("a[name="+itemFlag+"]").each(function(){
					var val = $(this).text();
					if(val.length==0){
						top.Dialog.alert("还有检修员未签认的项目，您暂时不能签认");
						flag = false;
						return false;
					}
				});
				if(flag){
					$.post("experiment!leadSignExpItem.do",{rjhmId:rjhmId,expId:expId,itemName:itemFlag,roleFlag:roleFlag},function(data){
						top.Dialog.alert(data,function(){
							window.location.reload();
						});
					},"text");
				}
			}
		}

		function signAllItem(){
			var rjhmId = $("#rjhmId").val();
			var expId = $("#expId").val();
			var roleFlag = $("#roleFlag").val();
			$.post("experiment!leadSignExpItem.do",{rjhmId:rjhmId,expId:expId,itemName:"all",roleFlag:roleFlag},function(data){
				top.Dialog.alert(data,function(){
					window.location.reload();
				});
			},"text");
		}
	</script>
  </head>
  
  <body>
  	
  	<div id="scrollContent" class="border_gray" style="padding: 2px;">
  		<form>
  			
  			<table width="98%" border="1" cellpadding="0" cellspacing="0" align="center">
			  <col width="81" />
			  <col width="39" />
			  <col width="40" />
			  <col width="42" />
			  <col width="41" />
			  <col width="42" />
			  <col width="35" />
			  <col width="40" />
			  <col width="41" />
			  <col width="42" />
			  <col width="40" span="2" />
			  <col width="41" span="2" />
			  <col width="47" />
			  <col width="41" />
			  <col width="49" />
			  <col width="72" />
			  <col width="36" />
			  <tr>
			    <td colspan="20" align="center"><span style="font-size: 16px; font-weight: bold;">${datePlan.jcType}-${datePlan.jcnum}内燃机车水阻试验记录</span></td>
			  </tr>
			  <tr>
			    <td width="32" colspan="2">机车号</td>
			    <td colspan="2">${datePlan.jcnum}　</td>
			    <td colspan="2" width="37" >修程</td>
			    <td colspan="2">${datePlan.fixFreque}</td>
			    <td colspan="2" width="37" >试验时间</td>
			    <td colspan="6" >
			    	<c:choose>
			      	 	<c:when test="${empty experiment.empAffirmTime}">
			      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width:120px;"/>
			   		 		<input type="button" value="提交时间" onclick="changeExpTime()" style="width:70px;background-color:#9cc5f8";/>
			      	 	</c:when>
			      	 	<c:otherwise>
			      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 120px;"/>
			   		 		<input type="button" value="修改时间" onclick="changeExpTime()" style="width:70px;background-color:#9cc5f8"/>
			      	 	</c:otherwise>
			      	 </c:choose>
			    </td>
			    <td colspan="4" >
			    	<c:if test="${roleFlag==5}">
			      		<c:choose>
			      			<c:when test="${!empty experiment.commitLead}"><span style="font-size: 14px;font-weight: bold;color: blue;">交车工长：${experiment.commitLead}</span></c:when>
			    			<c:otherwise><input type="button" onclick="signAllItem()" value="交车工长全签"/></c:otherwise>
			      		</c:choose>
			      	</c:if>
			      	<c:if test="${roleFlag==6}">
			      		<c:choose>
			      			<c:when test="${!empty experiment.accepter}"><span style="font-size: 14px;font-weight: bold;color: blue;">验收员：${experiment.accepter}</span></c:when>
			    			<c:otherwise><input type="button" onclick="signAllItem()" value="验收员全签"/></c:otherwise>
			      		</c:choose>
			      	</c:if>
			    </td>
			  </tr>
			  <tr>
			    <td colspan="4">磨 合 试 验</td>
			    <td colspan="5" >空          载       磨       合</td>
			    <td colspan="5" >第一次负载磨合</td>
			    <td colspan="3" >第二次负载磨合</td>
			    <td colspan="3" >第三次负载磨合</td>
			  </tr>
			  <tr>
			    <td colspan="4">手柄位</td>
			    <td width="37">0</td>
			    <td width="37">2</td>
			    <td >4</td>
			    <td >6</td>
			    <td width="37" >8</td>
			    <td width="37" >1</td>
			    <td >2</td>
			    <td width="37" >4</td>
			    <td width="37" >6</td>
			    <td width="37" >8</td>
			    <td width="37" >10</td>
			    <td width="37" >11</td>
			    <td width="37" >13</td>
			    <td width="43" >14</td>
			    <td width="37" >15</td>
			    <td width="43" >16</td>
			  </tr>
			  <tr>
			    <td colspan="4">转速（A型）</td>
			    <td >500±10</td>
			    <td >±10</td>
			    <td >620±10</td>
			    <td >700±10</td>
			    <td >780±10</td>
			    <td >500±10</td>
			    <td >±10</td>
			    <td >620±10</td>
			    <td >700±10</td>
			    <td >780±10</td>
			    <td >860±10</td>
			    <td >±10</td>
			    <td >980±10</td>
			    <td >1020±10</td>
			    <td >±10</td>
			    <td >1100±10</td>
			  </tr>
			  <tr>
			    <td colspan="4">rpm（B型）</td>
			    <td >430±10</td>
			    <td >470±10</td>
			    <td >545±10</td>
			    <td >620±10</td>
			    <td >695±10</td>
			    <td >430±10</td>
			    <td >470±10</td>
			    <td >545±10</td>
			    <td >620±10</td>
			    <td >695±10</td>
			    <td >775±10</td>
			    <td >810±10</td>
			    <td >890±10</td>
			    <td >925±10</td>
			    <td >960±10</td>
			    <td >1000±10</td>
			  </tr>
			  <tr>
			    <td colspan="4">时间（min）</td>
			    <td >20</td>
			    <td >15</td>
			    <td >15</td>
			    <td >20</td>
			    <td >20</td>
			    <td >15</td>
			    <td >15</td>
			    <td >20</td>
			    <td >20</td>
			    <td >20</td>
			    <td >15</td>
			    <td >15</td>
			    <td >15</td>
			    <td >15</td>
			    <td >15</td>
			    <td >60</td>
			  </tr>
			  <tr>
			    <td colspan="4">起止时分</td>
			    <td><a href="javascript:void(0)" name="${itemRecs.A1a1id}" class="vala" title="${itemRecs.A1a1info}${recMap.A1ainfo}">${itemRecs.A1a1}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a2info}${recMap.A1ainfo}">${itemRecs.A1a2}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a3info}${recMap.A1ainfo}">${itemRecs.A1a3}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a4info}${recMap.A1ainfo}">${itemRecs.A1a4}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a5info}${recMap.A1ainfo}">${itemRecs.A1a5}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a6info}${recMap.A1ainfo}">${itemRecs.A1a6}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a7info}${recMap.A1ainfo}">${itemRecs.A1a7}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a8info}${recMap.A1ainfo}">${itemRecs.A1a8}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a9info}${recMap.A1ainfo}">${itemRecs.A1a9}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a10info}${recMap.A1ainfo}">${itemRecs.A1a10}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a11info}${recMap.A1ainfo}">${itemRecs.A1a11}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a12info}${recMap.A1ainfo}">${itemRecs.A1a12}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a13info}${recMap.A1ainfo}">${itemRecs.A1a13}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a14info}${recMap.A1ainfo}">${itemRecs.A1a14}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a15info}${recMap.A1ainfo}">${itemRecs.A1a15}</a></td>
			    <td><a href="javascript:void(0)" name="A1a" class="vala" title="${itemRecs.A1a16info}${recMap.A1ainfo}">${itemRecs.A1a16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">电流（A）</td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a1info}${recMap.A2ainfo}">${itemRecs.A2a1}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a26info}${recMap.A2ainfo}">${itemRecs.A2a2}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a3info}${recMap.A2ainfo}">${itemRecs.A2a3}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a4info}${recMap.A2ainfo}">${itemRecs.A2a4}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a56info}${recMap.A2ainfo}">${itemRecs.A2a5}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a6info}${recMap.A2ainfo}">${itemRecs.A2a6}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a7info}${recMap.A2ainfo}">${itemRecs.A2a7}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a8info}${recMap.A2ainfo}">${itemRecs.A2a8}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a9info}${recMap.A2ainfo}">${itemRecs.A2a9}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a10info}${recMap.A2ainfo}">${itemRecs.A2a10}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a11info}${recMap.A2ainfo}">${itemRecs.A2a11}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a12info}${recMap.A2ainfo}">${itemRecs.A2a12}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a13info}${recMap.A2ainfo}">${itemRecs.A2a13}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a14info}${recMap.A2ainfo}">${itemRecs.A2a14}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a15info}${recMap.A2ainfo}">${itemRecs.A2a15}</a></td>
			    <td><a href="javascript:void(0)" name="A2a" class="vala" title="${itemRecs.A2a16info}${recMap.A2ainfo}">${itemRecs.A2a16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">电压（V）</td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a1info}${recMap.A3ainfo}">${itemRecs.A3a1}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a2info}${recMap.A3ainfo}">${itemRecs.A3a2}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a3info}${recMap.A3ainfo}">${itemRecs.A3a3}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a4info}${recMap.A3ainfo}">${itemRecs.A3a4}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a5info}${recMap.A3ainfo}">${itemRecs.A3a5}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a6info}${recMap.A3ainfo}">${itemRecs.A3a6}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a7info}${recMap.A3ainfo}">${itemRecs.A3a7}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a8info}${recMap.A3ainfo}">${itemRecs.A3a8}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a9info}${recMap.A3ainfo}">${itemRecs.A3a9}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a10info}${recMap.A3ainfo}">${itemRecs.A3a10}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a11info}${recMap.A3ainfo}">${itemRecs.A3a11}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a12info}${recMap.A3ainfo}">${itemRecs.A3a12}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a13info}${recMap.A3ainfo}">${itemRecs.A3a13}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a14info}${recMap.A3ainfo}">${itemRecs.A3a14}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a15info}${recMap.A3ainfo}">${itemRecs.A3a15}</a></td>
			    <td><a href="javascript:void(0)" name="A3a" class="vala" title="${itemRecs.A3a16info}${recMap.A3ainfo}">${itemRecs.A3a16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">缸号</td>
			    <td >1</td>
			    <td >2</td>
			    <td >3</td>
			    <td >4</td>
			    <td >5</td>
			    <td >6</td>
			    <td >7</td>
			    <td >8</td>
			    <td >9</td>
			    <td >10</td>
			    <td >11</td>
			    <td >12</td>
			    <td >13</td>
			    <td >14</td>
			    <td >15</td>
			    <td >16</td>
			  </tr>
			  <tr>
			    <td colspan="4">压缩压力(MPa)</td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b1info}${recMap.B1binfo}">${itemRecs.B1b1}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b2info}${recMap.B1binfo}">${itemRecs.B1b2}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b3info}${recMap.B1binfo}">${itemRecs.B1b3}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b4info}${recMap.B1binfo}">${itemRecs.B1b4}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b5info}${recMap.B1binfo}">${itemRecs.B1b5}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b6info}${recMap.B1binfo}">${itemRecs.B1b6}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b7info}${recMap.B1binfo}">${itemRecs.B1b7}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b8info}${recMap.B1binfo}">${itemRecs.B1b8}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b9info}${recMap.B1binfo}">${itemRecs.B1b9}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b10info}${recMap.B1binfo}">${itemRecs.B1b10}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b11info}${recMap.B1binfo}">${itemRecs.B1b11}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b12info}${recMap.B1binfo}">${itemRecs.B1b12}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b13info}${recMap.B1binfo}">${itemRecs.B1b13}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b14info}${recMap.B1binfo}">${itemRecs.B1b14}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b15info}${recMap.B1binfo}">${itemRecs.B1b15}</a></td>
			    <td><a href="javascript:void(0)" name="B1b" class="vala" title="${itemRecs.B1b16info}${recMap.B1binfo}">${itemRecs.B1b16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">爆发压力(MPa)</td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b1info}${recMap.B2binfo}">${itemRecs.B2b1}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b2info}${recMap.B2binfo}">${itemRecs.B2b2}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b3info}${recMap.B2binfo}">${itemRecs.B2b3}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b4info}${recMap.B2binfo}">${itemRecs.B2b4}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b5info}${recMap.B2binfo}">${itemRecs.B2b5}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b6info}${recMap.B2binfo}">${itemRecs.B2b6}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b7info}${recMap.B2binfo}">${itemRecs.B2b7}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b8info}${recMap.B2binfo}">${itemRecs.B2b8}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b9info}${recMap.B2binfo}">${itemRecs.B2b9}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b10info}${recMap.B2binfo}">${itemRecs.B2b10}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b11info}${recMap.B2binfo}">${itemRecs.B2b11}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b12info}${recMap.B2binfo}">${itemRecs.B2b12}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b13info}${recMap.B2binfo}">${itemRecs.B2b13}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b14info}${recMap.B2binfo}">${itemRecs.B2b14}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b15info}${recMap.B2binfo}">${itemRecs.B2b15}</a></td>
			    <td><a href="javascript:void(0)" name="B2b" class="vala" title="${itemRecs.B2b16info}${recMap.B2binfo}">${itemRecs.B2b16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">支管温度(℃)</td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b1info}${recMap.B3binfo}">${itemRecs.B3b1}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b2info}${recMap.B3binfo}">${itemRecs.B3b2}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b3info}${recMap.B3binfo}">${itemRecs.B3b3}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b4info}${recMap.B3binfo}">${itemRecs.B3b4}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b5info}${recMap.B3binfo}">${itemRecs.B3b5}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b6info}${recMap.B3binfo}">${itemRecs.B3b6}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b7info}${recMap.B3binfo}">${itemRecs.B3b7}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b8info}${recMap.B3binfo}">${itemRecs.B3b8}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b9info}${recMap.B3binfo}">${itemRecs.B3b9}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b10info}${recMap.B3binfo}">${itemRecs.B3b10}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b11info}${recMap.B3binfo}">${itemRecs.B3b11}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b12info}${recMap.B3binfo}">${itemRecs.B3b12}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b13info}${recMap.B3binfo}">${itemRecs.B3b13}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b14info}${recMap.B3binfo}">${itemRecs.B3b14}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b15info}${recMap.B3binfo}">${itemRecs.B3b15}</a></td>
			    <td><a href="javascript:void(0)" name="B3b" class="vala" title="${itemRecs.B3b16info}${recMap.B3binfo}">${itemRecs.B3b16}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">总管温度(℃)</td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b1info}${recMap.B4binfo}">${itemRecs.B4b1}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b2info}${recMap.B4binfo}">${itemRecs.B4b2}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b3info}${recMap.B4binfo}">${itemRecs.B4b3}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b4info}${recMap.B4binfo}">${itemRecs.B4b4}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b5info}${recMap.B4binfo}">${itemRecs.B4b5}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b6info}${recMap.B4binfo}">${itemRecs.B4b6}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b7info}${recMap.B4binfo}">${itemRecs.B4b7}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b8info}${recMap.B4binfo}">${itemRecs.B4b8}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b9info}${recMap.B4binfo}">${itemRecs.B4b9}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b10info}${recMap.B4binfo}">${itemRecs.B4b10}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b11info}${recMap.B4binfo}">${itemRecs.B4b11}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b12info}${recMap.B4binfo}">${itemRecs.B4b12}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b13info}${recMap.B4binfo}">${itemRecs.B4b13}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b14info}${recMap.B4binfo}">${itemRecs.B4b14}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b15info}${recMap.B4binfo}">${itemRecs.B4b15}</a></td>
			    <td><a href="javascript:void(0)" name="B4b" class="vala" title="${itemRecs.B4b16info}${recMap.B4binfo}">${itemRecs.B4b16}</a></td>
			  </tr>
			  <tr>
			    <td rowspan="20" colspan="2">各部状态及参数</td>
			    <td colspan="10">1SJ 延时</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c1" class="vala" title="${itemRecs.c1info}${recMap.c1info}">${itemRecs.c1}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">联调波动次数</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c2" class="vala" title="${itemRecs.c2info}${recMap.c2info}">${itemRecs.c2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">柴油机升速时间</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c3" class="vala" title="${itemRecs.c3info}${recMap.c3info}">${itemRecs.c3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">差示停机</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c4" class="vala" title="${itemRecs.c4info}${recMap.c4info}">${itemRecs.c4}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">紧急停机</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c5" class="vala" title="${itemRecs.c5info}${recMap.c5info}">${itemRecs.c5}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">极限停机</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c6" class="vala" title="${itemRecs.c6info}${recMap.c6info}">${itemRecs.c6}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">油压继电器（停机）</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c7" class="vala" title="${itemRecs.c7info}${recMap.c7info}">${itemRecs.c7}</a></td>
			  </tr>
			  <tr>
			    <td colspan="10">油压继电器（卸载）</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c8" class="vala" title="${itemRecs.c8info}${recMap.c8info}">${itemRecs.c8}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">曲轴箱压力</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c9" class="vala" title="${itemRecs.c9info}${recMap.c9info}">${itemRecs.c9}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">供油齿条刻线</td>
			    <td colspan="8"><a href="javascript:void(0)" name="c10" class="vala" title="${itemRecs.c10info}${recMap.c10info}">${itemRecs.c10}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">双风泵打风时间</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d1" class="vala" title="${itemRecs.d1info}${recMap.d1info}">${itemRecs.d1}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">稳定时间（s）</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d2" class="vala" title="${itemRecs.d2info}${recMap.d2info}">${itemRecs.d2}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">柴油机降速时间</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d3" class="vala" title="${itemRecs.d3info}${recMap.d3info}">${itemRecs.d3}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">过流继电器</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d4" class="vala" title="${itemRecs.d4info}${recMap.d4info}">${itemRecs.d4}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">接地继电器</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d5" class="vala" title="${itemRecs.d5info}${recMap.d5info}">${itemRecs.d5}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">水温继电器</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d6" class="vala" title="${itemRecs.d6info}${recMap.d6info}">${itemRecs.d6}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">空转减载</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d7" class="vala" title="${itemRecs.d7info}${recMap.d7info}">${itemRecs.d7}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">过压动作值（V）</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d8" class="vala" title="${itemRecs.d8info}${recMap.d8info}">${itemRecs.d8}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">故障发电值（V）</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d9" class="vala" title="${itemRecs.d9info}${recMap.d9info}">${itemRecs.d9}</a></td> 
			  </tr>
			  <tr>
			    <td colspan="10">油马达位置</td>
			    <td colspan="8"><a href="javascript:void(0)" name="d10" class="vala" title="${itemRecs.d10info}${recMap.d10info}">${itemRecs.d10}</a></td> 
			  </tr>
			
			  <tr>
			    <td rowspan="11" colspan="2">恒<br />
			      功<br />
			      率<br />
			      特<br />
			      性<br />
			      调<br />
			      整<br /></td>
			    <td colspan="3" rowspan="2" >柴油机转速（rpm）</td>
			    <td colspan="15" align="center">主整流柜输出　</td>
			  </tr>
			  <tr>
			    <td colspan="5" >电流（A）</td>
			    <td colspan="5" >电压（V）</td>
			    <td colspan="5" >功率（KW）</td>
			  </tr>
			  <tr>
			    <td colspan="3" >430±10</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E1e" class="vala" title="${itemRecs.E1e1info}${recMap.E1einfo}">${itemRecs.E1e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E1e" class="vala" title="${itemRecs.E1e2info}${recMap.E1einfo}">${itemRecs.E1e2}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E1e" class="vala" title="${itemRecs.E1e3info}${recMap.E1einfo}">${itemRecs.E1e3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="3" >700±10</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E2e" class="vala" title="${itemRecs.E2e1info}${recMap.E2einfo}">${itemRecs.E2e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E2e" class="vala" title="${itemRecs.E2e2info}${recMap.E2einfo}">${itemRecs.E2e2}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E2e" class="vala" title="${itemRecs.E2e3info}${recMap.E2einfo}">${itemRecs.E2e3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="3" >850±10</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E3e" class="vala" title="${itemRecs.E3e1info}${recMap.E3einfo}">${itemRecs.E3e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E3e" class="vala" title="${itemRecs.E3e2info}${recMap.E3einfo}">${itemRecs.E3e2}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E3e" class="vala" title="${itemRecs.E3e3info}${recMap.E3einfo}">${itemRecs.E3e3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="3" rowspan="6" >1000±10</td>
			    <td colspan="5" >3000</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E4e" class="vala" title="${itemRecs.E4e1info}${recMap.E4einfo}">${itemRecs.E4e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E4e" class="vala" title="${itemRecs.E4e2info}${recMap.E4einfo}">${itemRecs.E4e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="5" >3200</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E5e" class="vala" title="${itemRecs.E5e1info}${recMap.E5einfo}">${itemRecs.E5e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E5e" class="vala" title="${itemRecs.E5e2info}${recMap.E5einfo}">${itemRecs.E5e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="5">3600</td>
			    <td colspan="5"><a href="javascript:void(0)" name="E6e" class="vala" title="${itemRecs.E6e1info}${recMap.E6einfo}">${itemRecs.E6e1}</a></td>
			    <td colspan="5"><a href="javascript:void(0)" name="E6e" class="vala" title="${itemRecs.E6e2info}${recMap.E6einfo}">${itemRecs.E6e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="5" >4000</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E7e" class="vala" title="${itemRecs.E7e1info}${recMap.E7einfo}">${itemRecs.E7e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E7e" class="vala" title="${itemRecs.E7e2info}${recMap.E7einfo}">${itemRecs.E7e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="5" >4400</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E8e" class="vala" title="${itemRecs.E8e1info}${recMap.E5einfo}">${itemRecs.E8e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E8e" class="vala" title="${itemRecs.E8e2info}${recMap.E8einfo}">${itemRecs.E8e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="5" >4800</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E9e" class="vala" title="${itemRecs.E9e1info}${recMap.E9einfo}">${itemRecs.E9e1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="E9e" class="vala" title="${itemRecs.E9e2info}${recMap.E9einfo}">${itemRecs.E9e2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="2">故障功率调整</td>
			    <td colspan="3">1000±10</td>
			    <td colspan="5">4800</td>
			    <td colspan="5"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g1info}${recMap.ginfo}">${itemRecs.g1}</a></td>
			    <td colspan="5"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g2info}${recMap.ginfo}">${itemRecs.g2}</a></td>
			  </tr>
			  <tr>
			  	<td rowspan="11" colspan="2">
			    <br />
			      功<br />
			      率<br />
			      特<br />
			      性<br />
			      调<br />
			      整<br /></td>
			    <td colspan="2" rowspan="2" >柴油机转速（rpm）</td>
			    <td colspan="16" align="center">励磁参数</td>
			  </tr>
			  <tr>
			    <td colspan="4" >励磁电流（A）</td>
			    <td colspan="4" >励磁电压（V））</td>
			    <td colspan="4" >励磁机励磁电流（A））</td>
			    <td colspan="4" >测发电机励磁电  流（A）</td>
			  </tr>
			  <tr>
			    <td colspan="2" >430±10</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F1f" class="vala" title="${itemRecs.F1f1info}${recMap.F1finfo}">${itemRecs.F1f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F1f" class="vala" title="${itemRecs.F1f2info}${recMap.F1finfo}">${itemRecs.F1f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F1f" class="vala" title="${itemRecs.F1f3info}${recMap.F1finfo}">${itemRecs.F1f3}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F1f" class="vala" title="${itemRecs.F1f4info}${recMap.F1finfo}">${itemRecs.F1f4}</a></td>
			  </tr>
			  <tr>
			    <td colspan="2" >700±10</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F2f" class="vala" title="${itemRecs.F2f1info}${recMap.F2finfo}">${itemRecs.F2f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F2f" class="vala" title="${itemRecs.F2f2info}${recMap.F2finfo}">${itemRecs.F2f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F2f" class="vala" title="${itemRecs.F2f3info}${recMap.F2finfo}">${itemRecs.F2f3}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F2f" class="vala" title="${itemRecs.F2f4info}${recMap.F2finfo}">${itemRecs.F2f4}</a></td>
			  </tr>
			  <tr>
			    <td colspan="2" >850±10</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F3f" class="vala" title="${itemRecs.F3f1info}${recMap.F3finfo}">${itemRecs.F3f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F3f" class="vala" title="${itemRecs.F3f2info}${recMap.F3finfo}">${itemRecs.F3f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F3f" class="vala" title="${itemRecs.F3f3info}${recMap.F3finfo}">${itemRecs.F3f3}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F3f" class="vala" title="${itemRecs.F3f4info}${recMap.F3finfo}">${itemRecs.F3f4}</a></td>
			  </tr>
			  <tr>
			    <td colspan="2" rowspan="6" >1000±10</td>
			    <td colspan="4" >3000</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F4f" class="vala" title="${itemRecs.F4f1info}${recMap.F4finfo}">${itemRecs.F4f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F4f" class="vala" title="${itemRecs.F4f2info}${recMap.F4finfo}">${itemRecs.F4f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F4f" class="vala" title="${itemRecs.F4f3info}${recMap.F4finfo}">${itemRecs.F4f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4" >3200</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F5f" class="vala" title="${itemRecs.F5f1info}${recMap.F5finfo}">${itemRecs.F5f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F5f" class="vala" title="${itemRecs.F5f2info}${recMap.F5finfo}">${itemRecs.F5f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F5f" class="vala" title="${itemRecs.F5f3info}${recMap.F5finfo}">${itemRecs.F5f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4" >3600</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F6f" class="vala" title="${itemRecs.F6f1info}${recMap.F6finfo}">${itemRecs.F6f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F6f" class="vala" title="${itemRecs.F6f2info}${recMap.F6finfo}">${itemRecs.F6f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F6f" class="vala" title="${itemRecs.F6f3info}${recMap.F6finfo}">${itemRecs.F6f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4" >4000</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F7f" class="vala" title="${itemRecs.F7f1info}${recMap.F7finfo}">${itemRecs.F7f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F7f" class="vala" title="${itemRecs.F7f2info}${recMap.F7finfo}">${itemRecs.F7f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F7f" class="vala" title="${itemRecs.F7f3info}${recMap.F7finfo}">${itemRecs.F7f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4" >4400</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F8f" class="vala" title="${itemRecs.F8f1info}${recMap.F8finfo}">${itemRecs.F8f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F8f" class="vala" title="${itemRecs.F8f2info}${recMap.F8finfo}">${itemRecs.F8f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F8f" class="vala" title="${itemRecs.F8f3info}${recMap.F8finfo}">${itemRecs.F8f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4" >4800</td>
			    <td colspan="4"><a href="javascript:void(0)" name="F9f" class="vala" title="${itemRecs.F9f1info}${recMap.F9finfo}">${itemRecs.F9f1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F9f" class="vala" title="${itemRecs.F9f2info}${recMap.F9finfo}">${itemRecs.F9f2}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="F9f" class="vala" title="${itemRecs.F9f3info}${recMap.F9finfo}">${itemRecs.F9f3}</a></td>
			  </tr>
			  <tr>
			    <td colspan="2">故障功率调整</td>
			    <td colspan="2">1000±10</td>
			    <td colspan="4"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g3info}${recMap.ginfo}">${itemRecs.g3}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g4info}${recMap.ginfo}">${itemRecs.g4}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g5info}${recMap.ginfo}">${itemRecs.g5}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="g" class="vala" title="${itemRecs.g6info}${recMap.ginfo}">${itemRecs.g6}</a></td>
			  </tr>
			  <tr>
			    <td rowspan="11" colspan="4">
			    <br />
			      功<br />
			      率<br />
			      特<br />
			      性<br />
			      调<br />
			      整<br /></td>
			   
			    <td colspan="6" >增压空气压力（KPa）</td>
			    <td colspan="2">前</td>
			    <td colspan="3"><a href="javascript:void(0)" name="H1h" class="vala" title="${itemRecs.H1h1info}${recMap.H1hinfo}">${itemRecs.H1h1}</a></td>
			    <td colspan="2">后</td>
			    <td colspan="3"><a href="javascript:void(0)" name="H1h" class="vala" title="${itemRecs.H1h2info}${recMap.H1hinfo}">${itemRecs.H1h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >柴油机转速(rpm)</td>
			    <td colspan="5" >430±10</td>
			    <td colspan="5" >1000±10</td>
			  </tr>
			  <tr>
			    <td colspan="6" >主机油泵出口压力（KPa）</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H2h" class="vala" title="${itemRecs.H2h1info}${recMap.H2hinfo}">${itemRecs.H1h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H2h" class="vala" title="${itemRecs.H2h2info}${recMap.H2hinfo}">${itemRecs.H2h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >滤清器前机油压力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H3h" class="vala" title="${itemRecs.H3h1info}${recMap.H3hinfo}">${itemRecs.H3h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H3h" class="vala" title="${itemRecs.H3h2info}${recMap.H3hinfo}">${itemRecs.H3h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >滤清器后机油压力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H4h" class="vala" title="${itemRecs.H4h1info}${recMap.H4hinfo}">${itemRecs.H4h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H4h" class="vala" title="${itemRecs.H4h2info}${recMap.H4hinfo}">${itemRecs.H4h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >机 油 末    端 压 力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H5h" class="vala" title="${itemRecs.H5h1info}${recMap.H5hinfo}">${itemRecs.H5h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H5h" class="vala" title="${itemRecs.H5h2info}${recMap.H5hinfo}">${itemRecs.H5h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >前增压器机油压力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H6h" class="vala" title="${itemRecs.H6h1info}${recMap.H6hinfo}">${itemRecs.H6h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H6h" class="vala" title="${itemRecs.H6h2info}${recMap.H6hinfo}">${itemRecs.H6h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >后增压器机油压力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H7h" class="vala" title="${itemRecs.H7h1info}${recMap.H7hinfo}">${itemRecs.H7h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H7h" class="vala" title="${itemRecs.H7h2info}${recMap.H7hinfo}">${itemRecs.H7h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >燃油压力(KPa)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H8h" class="vala" title="${itemRecs.H8h1info}${recMap.H8hinfo}">${itemRecs.H8h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H8h" class="vala" title="${itemRecs.H8h2info}${recMap.H8hinfo}">${itemRecs.H8h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >机油温度(℃)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H9h" class="vala" title="${itemRecs.H9h1info}${recMap.H9hinfo}">${itemRecs.H9h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H9h" class="vala" title="${itemRecs.H9h2info}${recMap.H9hinfo}">${itemRecs.H9h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="6" >冷却水温度(℃)</td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H10h" class="vala" title="${itemRecs.H10h1info}${recMap.H10hinfo}">${itemRecs.H10h1}</a></td>
			    <td colspan="5" ><a href="javascript:void(0)" name="H10h" class="vala" title="${itemRecs.H10h2info}${recMap.H10hinfo}">${itemRecs.H10h2}</a></td>
			  </tr>
			  <tr>
			    <td colspan="4">平稳启动调整</td>
			    <td colspan="16" ><a href="javascript:void(0)" name="i1" class="vala" title="${itemRecs.i1info}${recMap.iinfo}">${itemRecs.i1}</a></td>
			  </tr>
			  <tr>
			    <td rowspan="2" colspan="4">拆检情况</td>
			    <td colspan="4" >空磨拆检情况</td>
			    <td colspan="4" >第一次负磨拆检情况</td>
			    <td colspan="4" >第二次负磨拆检情况</td>
			    <td colspan="4" >第三次负磨拆检情况</td>
			  </tr>
			  <tr>
			    <td colspan="4" ><a href="javascript:void(0)" name="k" class="vala" title="${itemRecs.k1info}${recMap.kinfo}">${itemRecs.k1}</a></td>
			    <td colspan="4" ><a href="javascript:void(0)" name="k" class="vala" title="${itemRecs.k2info}${recMap.kinfo}">${itemRecs.k2}</a></td>
			    <td colspan="4" ><a href="javascript:void(0)" name="k" class="vala" title="${itemRecs.k3info}${recMap.kinfo}">${itemRecs.k3}</a></td>
			    <td colspan="4" ><a href="javascript:void(0)" name="k" class="vala" title="${itemRecs.k4info}${recMap.kinfo}">${itemRecs.k4}</a></td>
			  </tr>
			  <tr>
			    <td rowspan="2" colspan="4">绝缘电阻测定</td>
			    <td colspan="4">测定日期</td>
			    <td colspan="4">主电路/地</td>
			    <td colspan="4">控制电路/地</td>
			    <td colspan="4">主/控制电路</td>
			  </tr>
			  <tr>
			    <td colspan="4"><a href="javascript:void(0)" name="j" class="vala" title="${itemRecs.j1info}${recMap.jinfo}">${itemRecs.j1}</a></td>
			    <td colspan="4"><a href="javascript:void(0)" name="j" class="vala" title="${itemRecs.j2info}${recMap.jinfo}">${itemRecs.j2}</a>MΩ</td>
			    <td colspan="4"><a href="javascript:void(0)" name="j" class="vala" title="${itemRecs.j3info}${recMap.jinfo}">${itemRecs.j3}</a>MΩ</td>
			    <td colspan="4"><a href="javascript:void(0)" name="j" class="vala" title="${itemRecs.j4info}${recMap.jinfo}">${itemRecs.j4}</a>MΩ</td>
			  </tr>
			  <tr>
			  	<td colspan="4">试验记事况</td>
			    <td colspan="16"><a href="javascript:void(0)" name="o1" class="vala" title="${itemRecs.o1info}${recMap.o1info}">${itemRecs.o1}</a></td>
			  </tr>
			  
			</table>
			<input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
			<input type="hidden" id="expId" value="${expId}"/>
			<input type="hidden" id="roleFlag" value="${roleFlag}"/>
  		</form>
  		
  	</div>
  	<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
  </body>
</html>
