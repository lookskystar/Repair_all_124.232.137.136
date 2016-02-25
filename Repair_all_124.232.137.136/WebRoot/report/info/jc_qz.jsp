<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>report/">
<title>
${flowval }
检修记录
</title>
<link href="<%=basePath %>css/test.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/tree/dtree/dtree.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=basePath %>js/test.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/tree/dtree/dtree.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/float.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/print.js"></script>
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
		cellMege('datatabel','firstname');
		cellMege('datatabel','secondname');
		cellMege('datatabel','fixitemname');
		//cellMege(0);
		//cellMege('secondname');
		$('.add-collect-to').float({
			position:'rm'
		});
	});
</script>
</head>

<body bgcolor="#f8f7f7">
<form id="form1" name="form1" method="post" action="">
<div style="width:870px;margin-left:-435px;left:50%;position:absolute;" id="content2">
<table width="864" border="0" align="center" cellspacing="0" vspace="0" style="padding-top:10px;">
<tr>
<td colspan="6" align="center" height="40"><h2 align="center"><font style="font-family:'隶书'">
<b>
	${flowval }检修记录</b></font></h2></td>
<td  align="right"></td>
</tr>
<tr>
<td width="163" align="right">机车号：</td>
<td width="240">${datePlan.jcType }  ${datePlan.jcnum }</td>
<td width="55" align="left">修程：</td><td width="251">${datePlan.fixFreque}</td>
<td width="140" align="left">检修日期：</td><td width="195" algin="left">${datePlan.kcsj }</td>
</tr>
<tr><td colspan="6">
<table width="864" border="0" align="center" cellspacing="0" vspace="0">
 <tr>
	<td align="center" colspan="3" class="tbCELL3">
	<table width="864" border="0" align="center" cellspacing="0" vspace="0" id="datatabel">
		<tr style="line-height:40px;height: 40px;background-color: lightblue;font-weight: bolder;">
			<!-- <td class="tbCELL1" align="center">专业</td> -->
			<!-- <td class="tbCELL1" align="center" style="white-space:nowrap" width="10%">大部件</td> -->
			<td class="tbCELL1" align="center" style="white-space:nowrap; min-width" width="15%">检修部件</td>
			<!-- <td class="tbCELL1" align="center">项目编号</td> -->
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="25%">检修项目</td>
			<!-- <td class="tbCELL1" align="center" style="white-space:nowrap" width="10%">部位</td> -->
			<!-- <td class="tbCELL1" align="center">要求及标准</td> -->
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="6%">检修情况</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="6%">检修人</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="7%">工长</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="7%">质检员</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="7%">技术员</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="7%">交车工长</td>
			<td class="tbCELL1" align="center" style="white-space:nowrap" width="6%">验收员</td>
		</tr>
		<c:forEach items="${qzFixRecs}" var="item">
		<tr>
			<td class="tbCELL1" align="center" name="firstname">${item.items.unitName }&nbsp;</td>
			<td class="tbCELL1" align="center" name="fixitemname">${item.items.itemName }&nbsp;</td>
			<%--<td class="tbCELL1" align="center">${item.items.posiName }</td>--%>
		 	<td class="tbCELL1" align="center">${item.fixSituation }&nbsp;
		 	   	  <c:if test="${!empty item.upPjNum}">
				      <br/>
		              <c:forTokens items="${item.upPjNum }" delims="," var="num">
							<a href="query!findPjRecordByPjNum.do?rjhmId=${datePlan.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num }</a>&nbsp;
					  </c:forTokens>
				  </c:if>
		 	</td>
			<td class="tbCELL1" align="center">${fn:substring(item.fixEmp,1,fn:length(item.fixEmp)-1)}&nbsp;</td>
			<td class="tbCELL1" align="center">${item.lead}<br>${fn:substring(item.ldAffirmTime, 5, 16) }</td>
			<td class="tbCELL1" align="center">${item.qi }<br>${fn:substring(item.qiAffiTime, 5, 16) }&nbsp;</td>
			<td class="tbCELL1" align="center">${item.technician }<br>${fn:substring(item.techAffiTime, 5, 16) }&nbsp;</td>
			<td class="tbCELL1" align="center">${item.commitLd }<br>${fn:substring(item.comLdAffiTime, 5, 16) }&nbsp;</td>
			<td class="tbCELL1" align="center">${item.accepter }<br>${fn:substring(item.acceTime, 5, 16) }&nbsp;</td>
		</tr>
		</c:forEach>
	</table>
  </td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
  </div>
  <div class="add-collect-to" >
  <a href="javascript:screenPrint();" style="font-size:14px;font-weight: bold;">打印</a>
  </div>
</form>
</body>
</html>