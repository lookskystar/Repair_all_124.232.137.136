<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- all-综合条件查询 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--框架必需start-->
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8"/>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<link href="<%=basePath %>report/css/global.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/lhgdialog/skins/blue.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/bsFormat.js"></script>
<!--框架必需end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript">
function addOption(objSelectNow, txt, val) {  
    // / 使用W3C标准语法为SELECT添加Option  
    var objOption = document.createElement("OPTION");  
    objOption.text = txt;  
    objOption.value = val;  
    objSelectNow.options.add(objOption);  
}  
function selectJcStype(){
	var v=$('#jcType').val();
	var sel=$('#jcStype').get(0);
	while(sel.options.length>1){
		sel.options.remove(1);
	}
	//if(v==0){
		//selectJcNum();
		//return ;
	//}
	$.post('<%=basePath%>report!getJcSType.do?typeId='+v,{},function(data){
		var list=eval("("+data+")");
		
		for(var i=0;i<list.length;i++){
			addOption(sel,list[i].jcStypeValue,list[i].jcStypeValue);
		}
		//selectJcNum();
	});
}
function selectJcNum(){
	var v=$('#jcStype').val();
	//清空
	var sel=$('#jcNum').get(0);
	//while(sel.options.length>1){
		//sel.options.remove(1);
	//}
	//if(v==0)return ;
	$.post('<%=basePath%>report!getJcNum.do?jcStype='+v,{},function(data){
		var list=eval("("+data+")");
		for(var i=0;i<list.length;i++){
			addOption(sel,list[i].jcNum,list[i].jcNum);
		}
	});
}

function clickJcNum(obj){
    if(obj.value=="请输入机车编号"){
    	obj.value="";
    }	
}

//获取前一个月时间
function getUpMonth(t){
    var tarr = t.split('-');
    var year = tarr[0];                //获取当前日期的年
    var month = tarr[1];            //获取当前日期的月
    var day = tarr[2];                //获取当前日期的日
    var days = new Date(year,month,0);    
    days = days.getDate();//获取当前日期中的月的天数

    var year2 = year;
    var month2 = parseInt(month)-1;
    if(month2==0) {
        year2 = parseInt(year2)-1;
        month2 = 12;
    }
    var day2 = day;
    var days2 = new Date(year2,month2,0);
    days2 = days2.getDate();
    if(day2>days2) {
        day2 = days2;
    }
    if(month2<10) {
        month2 = '0'+month2;
    }
    var t2 = year2+'-'+month2+'-'+day2;
    return t2;
}

$(function(){
	//selectJcStype();
	//jkmegamenu.definemenu("megaanchor1", "megamenu1", "mouseover");
	//jkmegamenu.definemenu("megaanchor2", "megamenu2", "mouseover");
	//jkmegamenu.definemenu("megaanchor3", "megamenu3", "mouseover");
	//jkmegamenu.definemenu("megaanchor4", "megamenu4", "mouseover");
	//jkmegamenu.definemenu("megaanchor5", "megamenu5", "mouseover");
	var myDate = new Date();
	var date=myDate.getYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate(); 
    var upMonthDate=getUpMonth(date);	
    $("#startTime").val(upMonthDate);
    $("#endTime").val(date);
});
</script>
<title>Insert title here</title>
</head>
<body>
<br/>
<center>
<form method="post" action="<%=basePath%>query!query.do" target="selectmain">
开始时间:<input type="text"  id="startTime" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
结束时间:<input type="text"  id="endTime" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
  
<%--
机车类别:<select onchange="selectJcStype()" id="jcType" name="jcType">
		<option value="0">请选择机车类别</option>
		<c:forEach var="type" items="${dicJcType }">
			<option value=${type.jcTypeId }>${type.jcTypeValue }</option>
		</c:forEach>
		</select>
机车类型:<select id="jcStype" name="jcStype">
			<option value="0">请选择机车类型</option>
		</select> --%>
机车编号:<input type="text" id="jcNum" name="jcNum"/>
修程修次:<input type="text" name="xcxc"/>&nbsp;&nbsp;
<input type="submit" value="查  询" />
</form>
</center>
<div id="scrollContent" style="height: 100%">
  <iframe scrolling="auto" width="100%" frameBorder=0  allowTransparency="true" height="100%" src="<%=basePath%>query!query.do" id="selectmain" name="selectmain"></iframe>
</div>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>