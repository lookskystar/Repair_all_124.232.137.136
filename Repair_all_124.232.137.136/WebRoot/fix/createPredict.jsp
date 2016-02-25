<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增一个报活</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
 <script type="text/javascript">
 $(function(){
	//加载班组供选择
	$.post("partFixAction!obtainBZ.do", function(data) {
		var op;
		$("#bz_select").empty();
		$.each(data,function(index,bz){
			op = '<option value="'+bz.id+'">'+bz.name+'</option>'
			$("#bz_select").append(op);
		});

	}, 'json');
	
	$("input[type='radio']").click(function(){
		var way = $(this).val();
		if(way=='0'){
			$("#bz_select").attr("disabled",false);
		}else{
			$("#bz_select").attr("disabled",true);
			$("#bz_select").find("option").each(function(){
				var txt = $(this).text();
				if(txt.indexOf("调度")!=-1){
					$(this).attr("selected",true);
					return;
				}
			});
		}
	})
 })
 
 //使用刷卡签认
 function userCard(){
	 $("#untr").css("display","none");
	 $("#pwdtr").css("display","none");
	 $("#cardtr").css("display","block");
	 $("#use_way").val(1);
 }
	
  </script>
</head>
<body>
<div style="padding: 20px 20px;">
		<table width="100%" align="center" >
			<tr>
				<td>指派班组：</td>
				<td>
					<select id="bz_select" class="default"></select>
				</td>
			</tr>
			<tr id="untr">
				<td>是否需要审核：</td>
				<td>
					<label>否</label><input type="radio" name="approve" value="0" checked="checked"/>
					<label style="padding-left: 5px;">是</label><input type="radio" name="approve" value="1"/>
				</td>
			</tr>
			<tr id="pwdtr">
				<td>故障描述：</td>
				<td>
					<textarea style="width: 95%;height: 150px" id="description"></textarea>
				</td>
			</tr>
			
		</table>
    </div>
 </body>
</html>