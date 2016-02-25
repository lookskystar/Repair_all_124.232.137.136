<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/framework.js"></script>
<link href="<%=basePath%>css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<script type="text/javascript" src="js/nav/switchable.js"></script>

<!--文本截取start-->
<script type="text/javascript" src="<%=basePath%>js/text/text-overflow.js"></script>
<!--文本截取end-->
<script type="text/javascript">
	//交车项目签认  
   function signIT(){
   		//日计划
   		var rjhmId = ${rjhmId};
   		var itemString = "{";
   		//循环所有有值得项目
   		$("input[name='jc_item']").each(function(){
   			var idvalue = $(this).attr("id");
   			var itemvalue = $(this).val();
   			//判断所有有值项目的标准值
  			if(itemvalue != null && itemvalue != "" && itemvalue != undefined){
   				itemString += "\""+ idvalue +"\":";
			    itemString += "\""+ itemvalue +"\"";
			    itemString += ",";
   			}
   		})
   		itemString += "}";
   		$.ajax({
			type:'post',
			url:'workAction!finishItemSignHuaihua.action',
			data:{"rjhmId":rjhmId,"itemString":itemString},
			success:function(result){
				if("success"==result){
					top.Dialog.alert("签认成功！");
				}else{
					top.Dialog.alert("签认失败！");
				}
			}
		}); 
   }
	//质检技术签认  
   function signJS(){
   		//用户AJAX登陆
   		var diag = new top.Dialog();
		diag.Title = "用户登陆窗口";
		diag.URL = '<%=basePath%>loginAction!ajaxLoginInput.do?rjhmId='+${rjhmId};
		diag.Width=250;
		diag.Height=100;
		diag.show();
   }
   
   //验收员签认  
   function signYS(){
   		//用户AJAX登陆
   		var diag = new top.Dialog();
		diag.Title = "用户登陆窗口";
		diag.URL = '<%=basePath%>loginAction!ajaxLoginInput.do?rjhmId='+${rjhmId};
		diag.Width=250;
		diag.Height=100;
		diag.show();
   }

   //交车工长签认
   function signGZ(){
	   //用户AJAX登陆
   		var diag = new top.Dialog();
		diag.Title = "用户登陆窗口";
		diag.URL = '<%=basePath%>loginAction!ajaxLoginInput.do?rjhmId='+${rjhmId};
		diag.Width=250;
		diag.Height=100;
		diag.show();
   }
   $(function(){
   		//初始化Tab
		$("#tabs3").switchable("#panels3 >div",{  
		     triggerType:"click"
		});
		
   		//加载签到人
 		$.post("<%=basePath%>checkSign!getSignatureByDatePlanId.do",{"datePlanId":${rjhmId}},function(result){
	  		  var rs=eval("("+result+")");
			  $("#userMsg tr:gt(0)").children().remove();
			  var str="";
			  var other="";
			  for(var key in rs){ 
			  	if(rs[key].length==0){
			  		if(key=="other"){
			  			other+="<tr>";
						other+="<td class='ver01' align='center'>其他</td>";
						other+="<td class='ver01' align='center'></td>";
						other+="<td class='ver01' align='center'></td>";
						other+="</tr>";
			  		}else{
				  		str+="<tr>";
						str+="<td class='ver01' align='center'>"+key+"</td>";
						str+="<td class='ver01' align='center'></td>";
						str+="<td class='ver01' align='center'></td>";
						str+="</tr>";
					}
			  	}else{
		     		var obj = rs[key];
		     		var tm;
				  	for(var i=0;i<obj.length;i++){
				  		tm = obj[i];
				  		if(key=="other"){
				  			if(i==0){
					  			other+="<tr>";
								other+="<td class='ver01' align='center'>其他</td>";
						  		other+="<td class='ver01' align='center'>"+tm.name+"</td>";
						  		other+="<td class='ver01' align='center'>"+tm.signTime+"</td>";
								other+="</tr>";
					  		}else{
					  			other+="<tr>";
								other+="<td class='ver01' align='center'></td>";
						  		other+="<td class='ver01' align='center'>"+tm.name+"</td>";
						  		other+="<td class='ver01' align='center'>"+tm.signTime+"</td>";
								other+="</tr>";
					  		}
				  		}else{
					  		if(i==0){
					  			str+="<tr>";
								str+="<td class='ver01' align='center'>"+key+"</td>";
						  		str+="<td class='ver01' align='center'>"+tm.name+"</td>";
						  		str+="<td class='ver01' align='center'>"+tm.signTime+"</td>";
								str+="</tr>";
					  		}else{
					  			str+="<tr>";
								str+="<td class='ver01' align='center'></td>";
						  		str+="<td class='ver01' align='center'>"+tm.name+"</td>";
						  		str+="<td class='ver01' align='center'>"+tm.signTime+"</td>";
								str+="</tr>";
					  		}
					  	}
				  	}
			  	}
			  }
			  str += other;
			 $("#userMsg").append(str);
		});
  });
</script>
</head>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td  width="67%">
	    	<div class="box2"  panelTitle="交车检测项目" roller="true" showStatus="false" overflow="auto" panelHeight="450" >
	    		<div>
	    			<button id="signIT" onclick="signIT();" ><span class="icon_save">试验项目签认</span></button>&nbsp;&nbsp;
	    			<button id="signJS" onclick="signJS();" ><span class="icon_save">质检技术全签</span></button>&nbsp;&nbsp;
	    			<button id="signYS" onclick="signYS();" ><span class="icon_save">驻段验收全签</span></button>&nbsp;&nbsp;
	    			<button id="signGZ" onclick="signGZ();" ><span class="icon_save">交车工长全签</span></button>&nbsp;&nbsp;
	    		</div>
				<div id="tabs3" class="tabs-trigger" style="width:100%;">
					<div class="tabs-triggerLeft">
						<div class="tabs-triggerRight">
							<c:forEach var="rec" items="${itemListMap}" varStatus="idx">
								<a href="#${idx.index+1}">${rec.key}</a>
							</c:forEach>
						</div>
					</div>
				</div>
				<div id="panels3" class="tabs-panel" style="width: 100%;min-height: 350px">
					<c:forEach var="rec" items="${itemListMap}" varStatus="idx">
						<div class="padding_left10">
							<table class="tableStyle" width="100%">
								<tr><th width="20%">项目</th><th width="30%">情况</th><th width="14%">质检/技术</th><th width="14%">验收</th><th width="14%">交车工长</th></tr>
								<c:forEach var="obj" items="${rec.value}">
									<tr align="center">
										<td>${obj.itemName}</td>
										<td align="left">
											<input type="hidden" id="${obj.recId }-max" value="${obj.item.max}"/>
											<input type="hidden" id="${obj.recId }-min" value="${obj.item.min }"/>
											<input type="hidden" id="${obj.recId }-isCheck" value="${obj.item.isCheck }"/>
											<input type="text" id="${obj.recId }" name="jc_item" value="${obj.fixSituation }"/>${obj.unit}
										</td>
										<td>${obj.tech }</td>
										<td>${obj.accept }</td>
										<td>${obj.commitLead }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</c:forEach>
				</div>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="交车签认列表"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
	    	  <div id="showImage">
	    	    <table width="100%" class="tableStyle" id="userMsg">
					<tr>
					    <th  class="ver01">班组</th>
						<th class="ver01">签到人</th>
						<th class="ver01">签到时间</th>
					</tr>
				</table>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>