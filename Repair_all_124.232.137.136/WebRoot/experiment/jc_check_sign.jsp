<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<Script type="text/javascript" src="js/jquery.form.js"></Script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--文本截取end-->
<script type="text/javascript">
  //得到机车信息
  function getJc(id){
	  $.post("checkSign!getSignatureByDatePlanId.do",{"datePlanId":id},function(result){
		  parseJson(result);
	  });
	  // || (type.indexof('HX')>0)
	  if(xcxc=='LX' || xcxc=='JG' || xcxc=='CJ' || xcxc=='QZ'){
	 	$("#skqj").hide();
	 	$("#skqd").show();
	 	$("#signEnd").hide();
	 	$("#ajaxSignEnd").show();
	 }else{
	 	$("#skqj").show();
	 	$("#skqd").hide();
	 	$("#signEnd").show();
	 	$("#ajaxSignEnd").hide();
	 }
  }
  
  //签到方式转换
  function signConvert(type){
	  if(type==1){
		  $("#msg1").hide();
		  $("#msg2").show();
		  $("#signMsg1").hide();
		  $("#signMsg2").show();
		  $("#cardnum").val("");
		   $("#loginType").val(0);
	  }
	  if(type==2){
		  $("#msg1").show();
		  $("#msg2").hide();
		  $("#signMsg1").show();
		  $("#signMsg2").hide();
		  $("#uname").val("");
		  $("#pwd").val("");
		  $("#loginType").val(1);
	  }
  }
  
  //签到
  function sign(){
	  var datePlanId=$("#rjhmId").val();
	  var uname=$("#uname").val();
	  var pwd=$("#pwd").val();
	  var loginType = $("#loginType").val();
	  var cardnum = $("#cardnum").val();
	  if(loginType==0){
		  if(uname==""){
			top.Dialog.alert("用户名不能为空!");
			return ;
		  }
		  if(pwd==""){
			top.Dialog.alert("密码不能为空!");
			return ;
		 }		
	  }else{
		 if(cardnum==""){
			top.Dialog.alert("请刷卡!");
			return ;
		}
	  }
	  $.post("checkSign!roleSign.do",{"datePlanId":datePlanId,"uname":uname,"pwd":pwd,"cardnum":cardnum},function(data){
		  if(data=="login_failure"){
			   top.Dialog.alert("用户不存在!");
		  }else if(data=="success"){
			   top.Dialog.alert("签到成功!");
			   $.post("checkSign!getSignatureByDatePlanId.do",{"datePlanId":datePlanId},function(result){
				   parseJson(result);
			   });
			   $("#cardnum").val("");
			   $("#uname").val("");
			   $("#pwd").val("");
		  }else if(data=="user_sign"){
			   top.Dialog.alert("用户已经签认!");
		  }else{
			   top.Dialog.alert("签到失败!");
		  }
	 });
  }
  
  function parseJson(data){
	  var rs=eval("("+data+")");
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
  }
  
   //LX.JG.CJ.QZ进入交车检验记录
  function signEnter(){
	  var datePlanId=$("#rjhmId").val();
	  var str=$("#userMsg tr:gt(0)").children().text();
	  if(str==''||str==undefined||str==null){
		 top.Dialog.alert("请签到!");
	  }else{
		  window.location.href="<%=basePath%>checkSign!checkRecInput.do?dpId="+datePlanId;
	  }
  }
  
  //LX.JG.CJ.QZ不进入交车检验记录
  function ajaxSignEnter(){	
	  var datePlanId=$("#rjhmId").val();
	  var str=$("#userMsg tr:gt(0)").children().text();
	  if(str==''||str==undefined||str==null){
		 top.Dialog.alert("请签到!");
	  }else{
	  	  $.post("checkSign!ajaxCheckRecInput.do",{"dpId":datePlanId},function(text){
	  	  	if(text=="success"){
	  	  		top.Dialog.alert("签到成功");
	  	  	}else{
	  	  		top.Dialog.alert("签到失败");
	  	  	}
	  	  })
	  }
  }

  //报活补签
  function reSign(id){
	   top.Dialog.open({URL:"<%=basePath%>checkDealJc!reSignInput.do?rjhmId="+id,Width:"100",Height:"100",Title:"报活签认"});
  }
  
  $(function(){
	    var rjhmId=$("#rjhmId").val();
  		getJc(rjhmId);
  });
</script>
<script type="text/javascript" src="js/timer2.src.js"></script> 
<script type='text/javascript'>
var CallShowMsg = function(){
	var xx = document.getElementById("x");
	xx.Test('这是读卡数据：');
	document.getElementById("cardnum").value=xx.Msg;
	if (document.getElementById("cardnum").value!=""){
		//alert(document.all.idkid.value); 
		//alert(document.all.idkid.value); 
		//submitForm();
	}
}
//CallShowMsg()
var timer = new Timer(50); 
var globalTimer = new Timer(1000); 

function init() { 
	timer.addEventListener(TimerEvent.TIMER, calTime); 
	timer.start(); 
	globalTimer.addEventListener(TimerEvent.TIMER, controlTime); 
	globalTimer.start(); 
} 

function controlTime() { 
	if (!timer.running) { 
		timer.reset(); 
		timer.start(); 
	} 
} 

function calTime() { 
	CallShowMsg();
	var v=document.getElementById("cardnum").value;
	if (v != null) { 
		timer.stop(); 
		document.getElementById("cardnum").value=x.Msg; 
		CallShowMsg();
	} 
} 
window.onload = init;
</script>
<body>
<div id="scrollContent">
    <input type="hidden" value="${datePlanPri.rjhmId }" id="rjhmId"/>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
		<td  width="40%" class="ver01">
	    	<div class="box2" panelHeight="200"  panelTitle="交车签到"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto"><br/>
	    	  <div id="showImage" align="center">
	    	  	<table width="100%" class="tableStyle">
				    <tr><th colspan="2" align="center">当前机车信息</th></tr>
				    <tr>
				       <td align="center">机车</td>
				       <td align="center">${datePlanPri.jcType}-${datePlanPri.jcnum}-${datePlanPri.fixFreque}</td>
				    </tr>
				    <tr>
				       <td align="center">交车工长</td>
				       <td align="center">${datePlanPri.gongZhang.xm }</td>
				    </tr>
				    <c:if test="${count!=0}">
					    <tr>
					       <td align="center">报活情况</td>
					       <td align="center">
					                                     有<font style="color:red;">${count}</font>条未完成的报活&nbsp;&nbsp;&nbsp;&nbsp;
					           <button onclick="reSign(${datePlanPri.rjhmId});">报活补签</button>
					       </td>
					    </tr>
				    </c:if>
				</table>
	    	  </div>
	    	</div>
		</td>
		<td rowspan="2">
		  	<div class="box2" panelHeight="550"  panelTitle="交车签认列表"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
	    	  <div id="showImage">
	    	    <table width="100%" class="tableStyle" id="userMsg">
					<tr>
					    <th  class="ver01">班组</th>
					<!-- 	<th class="ver01">工号</th>   -->
						<th class="ver01">签到人</th>
						<th class="ver01">签到时间</th>
					</tr>
				</table>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	  <tr>
	    <td rowspan="3" width="40%" class="ver01">
	    	<div class="box2" panelHeight="350"  panelTitle="签认信息"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
	    	  <input type="hidden" id="loginType"/>
	    	  <a id="msg1" href="javascript:void(0)" onclick="signConvert(1);" style="color: blue;">登录签到</a>
	    	  <a id="msg2" href="javascript:void(0)" onclick="signConvert(2);" style="color: blue;display: none;">刷卡签到</a>
	    	  <div id="signMsg1"><br/>
	    	    <table width="100%" class="tableStyle" border="0">
					<tr>
					    <th  class="ver01">IC卡号:</th>
					    <td  class="ver01"><input type="text" style="width: 150px" id="cardnum" name="cardnum"/></td>
					</tr>
					<tr>
					    <th  class="ver01">职工工号:</th>
					    <td  class="ver01"><input type="text" style="width: 150px"/></td>
					</tr>
					<tr>
					    <th  class="ver01">职工姓名:</th>
					    <td  class="ver01"><input type="text" style="width: 150px"/></td>
					</tr>
					<tr>
					    <th  class="ver01">所属部门:</th>
					    <td  class="ver01"><input type="text" style="width: 150px"/></td>
					</tr>
					<tr>
					    <th  class="ver01">所在班组:</th>
					    <td  class="ver01"><input type="text" style="width: 150px"/></td>
					</tr>
					<tr>
					    <input type="button" style="width: 160px" value="签到" onclick="sign();"/>
					    <td  class="ver01" colspan="2" align="center">
					    	<input id="skqj" type="button" style="width: 160px" value="签到完成  进入交车记录" onclick="signEnter();"/>
					    	<input id="skqd" type="button" style="width: 100px;display: none;" value="签到完成 " onclick="ajaxSignEnter();"/>
					    </td>
					</tr>
					<object width="32" height="32" title="MyActiveX" id="x" name="x" classid="clsid:A4D8D89A-CF2A-49BB-B703-25E48360D2A8" codebase="ActiveX.CAB#version=1,0,0,0"></object>
				</table>
	    	  </div>
	    	  <div id="signMsg2" style="display: none;"><br/>
	    	  <table  width="100%" class="tableStyle">
	    	    	<tr>
					    <th  class="ver01">用户名:</th>
					    <td  class="ver01"><input type="text" style="width: 150px" id="uname"/></td>
					</tr>
					<tr>
					    <th  class="ver01">密码:</th>
					    <td  class="ver01"><input type="password" style="width: 150px" id="pwd"/></td>
					</tr>
					<tr>
					    <td  class="ver01" colspan="2" align="center">
					       <input type="button" style="width: 160px" value="签到" onclick="sign();"/>
					    </td>
					</tr>
					<tr>
					    <td  class="ver01" colspan="2" align="center">
					       <input type="button" style="width: 160px" value="签到完成  进入交车记录" onclick="signEnter();" id="signEnd"/>
					       <input type="button" style="width: 100px;display: none;" value="签到完成 " onclick="ajaxSignEnter();" id="ajaxSignEnd"/>		       
					       <!-- <input type="button" style="width: 160px" value="进入内燃机交车记录" onclick="window.location.href='checkSign!checkRecInput.do?opt=1&dpId=887'"/> -->
					    </td>
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