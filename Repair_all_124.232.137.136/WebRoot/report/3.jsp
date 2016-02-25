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
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<title>机车报活记录</title>
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
		cellMege('datatabel','preType');
	});



</script>
</head>

<body bgcolor="#f8f7f7">
<form id="form1" name="form1" method="post" action="">
<table width="800" border="0" align="center" cellspacing="0" vspace="0">
<tr>
<td colspan="5" align="center"><h2 align="center"><font style="font-family:'隶书'"><b>机车报活记录</b></font></h2></td>
</tr>
<tr>
<td width="163" align="right">机车号：</td>
<td width="240">${datePlan.jcType }  ${datePlan.jcnum }</td>
<td width="55" align="left">修程：</td><td width="251">${datePlan.fixFreque}</td>
<td width="140" align="left">检修日期：</td><td width="195" algin="left">${fn:substring(datePlan.kcsj,0,10)}</td>
<td  align="right"><h5></h5></td>
</tr>
<tr><td colspan="6">
<table width="800" border="0" align="center" cellspacing="0" vspace="0">
 <tr>
	<td align="center" colspan="3" class="tbCELL3">
  <table width="800" border="0" align="center" cellspacing="0" vspace="0" id="datatabel">
    <tr>
      <td class="tbCELL1" align="center" nowrap="nowrap">报活类型</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">报活情况</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">报活人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">检修人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">工长</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">交车工长</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">质检员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">技术员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">验收员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap">故障备注</td>
    </tr>
    <c:forEach var="rec" items="${preDictRecs }">
    <tr>
      <td class="tbCELL1" align="center"  name="preType">
		<c:if test="${rec.type==0}">
			JT28报活
		</c:if>
		<c:if test="${rec.type==1}">
			复检报活
		</c:if>
		<c:if test="${rec.type==2}">
			检修过程报活
		</c:if>
		<c:if test="${rec.type==6}">
			零公里检查
		</c:if>
	  </td>
      <td class="tbCELL1" align="center">${rec.repPosi }|${rec.repsituation }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.repemp }&nbsp;</td>
      <c:if test="${! empty rec.fixEmp }">
      	<td class="tbCELL1" align="center">${rec.fixEmp }&nbsp;</td>
      </c:if>
      <c:if test="${empty rec.fixEmp }">
      	<td class="tbCELL1" align="center">${fn:replace(rec.dealFixEmp,',','') }&nbsp;</td>
      </c:if>
      <td class="tbCELL1" align="center">${rec.lead}<br>${fn:substring(rec.ldAffirmTime, 5, 16) }</td>
	  <td class="tbCELL1" align="center">${rec.qi }<br>${fn:substring(rec.qiAffiTime, 5, 16) }&nbsp;</td>
	  <td class="tbCELL1" align="center">${rec.technician }<br>${fn:substring(rec.techAffiTime, 5, 16) }&nbsp;</td>
	  <td class="tbCELL1" align="center">${rec.commitLd }<br>${fn:substring(rec.comLdAffiTime, 5, 16) }&nbsp;</td>
	  <td class="tbCELL1" align="center">${rec.accepter }<br>${fn:substring(rec.acceTime, 5, 16) }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.failNum}&nbsp;</td>
    </tr>
    </c:forEach>
  </td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
</form>
</body>
</html>