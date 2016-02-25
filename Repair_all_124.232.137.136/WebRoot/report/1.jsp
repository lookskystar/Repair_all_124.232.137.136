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
<title>
${flowval }
检修记录
</title>
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
<script type="text/javascript">
//合并表格的单元格
	function cellMege(table,col){
		var lines=$('#'+table+' tr').size();
		if(lines<=2) return ;
		var v,l=0,current='',index=1;
		for(var i=1;i<lines;i++){
			var tr=$('#'+table+' tr').eq(i);
			v=tr.find('td[name="'+col+'"]').html();
			//alert(tr.find('td[name="secondname"]').size());
			l++;
			//alert(v);
			if(v!=current||i==(lines-1)){//如果两个值不相同或者是最后一行
				if(i==(lines-1)) l++;
				if(l>1){//草果两行，合并
					var td=$('#'+table+' tr').eq(index).find('td[name="'+col+'"]');
					td.attr('rowspan',l);
					for(var j=1;j<l;j++){
						var td=$('#'+table+' tr').eq(index+j).find('td[name="'+col+'"]').remove();
					}
				}
				l=0;//从新计数
				current=v;
				index=i;
			}
		}
	}
	$(function(){
		cellMege('infotTable',"unit");
	});
</script>
<!--修正IE6支持透明PNG图end-->
</head>
<body>
<center>
<div class="box2" style="width: 80%;text-align: center;" showStatus="false">
<div style="font-size: 24px;font-weight: bold">
${flowval }&nbsp;&nbsp;
检修记录
</div>
<div>                              
	<span>机车型号:${jcStype }&nbsp;&nbsp;${datePlan.jcnum }&nbsp;&nbsp;</span>
	<span>修程：${datePlan.fixFreque }&nbsp;&nbsp;</span>
	<span>扣车时间：  ${datePlan.kcsj}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	<span>交车时间： ${datePlan.jhjcsj}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	<span><a href="query!findXXJCPJ.do?rjhmId=${datePlan.rjhmId }" style="color:blue;" target="_blank">查看配件检修记录</a></span>
</div>
<table width="1093" class="tableStyle" id="infotTable" style="font-size:10pt;">
 <tr height="36">
    <td height="36" width="100">类别</td>
    <td height="36" width="74">序号</td>
    <td height="36" width="487">重点整治部位</td>
    <td height="36" width="72">整治情况</td>
    <td height="36" width="72">工作者</td>
    <td height="36" width="72">工长</td>
    <td height="36" width="72">质检员</td>
    <td height="36" width="72">技术员</td>
    <td height="36" width="72">专业包保人员</td>
    <td height="36" width="72">备注</td>
  </tr>
  <c:forEach items="${ qzFixRecs}" var="rec" varStatus="index">
  <tr>
  	<td height="29" name="unit">${rec.items.unitName }</td>
  	<td height="29">${index.index+1 }</td>
  	<td height="29">${rec.itemName }</td>
  	<td height="29">${rec.fixSituation }</td>
  	<td height="29">${fn:substring(rec.workerName,1,fn:length(rec.workerName)-1) }</td>
  	<td height="29">${rec.leadName }</td>
  	<td height="29">${rec.qi }</td>
  	<td height="29">${rec.tech }</td>
  	<td height="29">${rec.bbrw }</td>
  	<td height="29"></td>
  </tr>
  </c:forEach>
</table>
<table width="1093" class="tableStyle" style="font-size:10pt;">
<tr height="19">
    <td colspan="2" height="19" width="200">其他重点报活项目</td>
    <td colspan="7" height="19" width="1334"></td>
  </tr>
  <tr height="19">
    <td colspan="2" height="19" width="200">必检人员</td>
    <td colspan="7" height="19" width="1334">交车工长：${signed.jcgzxm }　　　　　　　　　验收员：${signed.ysyxm }　　</td>
  </tr>
  <tr height="28">
    <td colspan="2" height="28" width="200">抽检人员</td>
    <td colspan="7" height="28" width="1334">     　　　　　　　 检修主任：${signed.jxzrxm}　        　              段领导：${signed.dzxm }　</td>
  </tr>
  <tr height="19">
    <td colspan="2" height="19" width="200">零公里检查</td>
    <td colspan="7" height="19" width="1334"></td>
  </tr>
 </table>
</div>
</center>
</body>
</html>