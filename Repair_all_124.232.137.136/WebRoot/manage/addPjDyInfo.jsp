<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript">
	   function validate(){
		   var pjName=$("#pjName").val();
		   var staticName=$("#staticName").val();
		   if(pjName==""){
			    top.Dialog.alert("请填写配件名称!");
			    return false;
		   }
		   if(staticName==""){
			    top.Dialog.alert("请选择所属的静态配件信息!");
			    return false;
		   }
		   if($("#more").attr("checked")&&$("#amount").val()==""){
			   top.Dialog.alert("待修配件数量不能为空!");
			   return false;
		   }
		   <!-- 20150511 ning 防止误操作添加过多配件  -->
		   if($("#more").attr("checked")&&$("#amount").val()>99){
			   top.Dialog.alert("您输入的配件数量过大!");
			   return false;
		   }
		   <!-- 唐倩 2015-6-24  添加多个待修配件时把配件编号默认值设置为空,如果默认值已经被添加将无法添加多个待修配件  -->
		   if($("#more").attr("checked")){
			   $("#pjNum").val("");
		   }
		   
		   var stid = $("#static_id").val();
		   var pjnum = $("#pjNum").val();
		   
		   if(pjnum!=""){
			   $.post("pjManageAction!ajaxUniquePJNum.do",{"pjnum":pjnum},function(text){
			   		if(text==0){
			   			document.form.submit();
			   		}else{
			   			top.Dialog.alert("配件编码不唯一 ,请重新输入!");
			   		}
			   });
		   }else{
			   //top.Dialog.alert("配件编码不能为空!");
		   	   document.form.submit();
		   }
	   }
	   
	   function choicePart(){
			var diag = new top.Dialog();
			diag.Title = "选择配件";
			diag.Width = 700;
			diag.URL = 'part/partFixAction!toChoicePJS.action';
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定";
			diag.OKEvent = function() {
				var flag = true;
				var doc = diag.innerFrame.contentWindow.document;
				var pj = doc.getElementsByName("pjRadio");
				var pjId;
				var pjName;
				for(var i=0;i<pj.length;i++){
					if(pj[i].checked){
						pjId = pj[i].value;
						pjName = pj[i].id;
					}
				}
				if (pjId == null || pjId.length == 0) {
					top.Dialog.alert("请选择所属的静态配件信息!");
				}else{
					$("#staticName").val(pjName);
					$("#static_id").val(pjId);
					diag.close();
				}
			};
			diag.show();
	   }
	   
	   function choiceWzNum(){
		   var pjName=$("#pjName").val();
		   var diag = new top.Dialog();
			diag.Title = "选择配件物资编号";
			diag.Width = 700;
			diag.URL = '<%=basePath%>pjManageAction!choiceWzNum.action?pjName='+pjName;
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定";
			diag.OKEvent = function() {
				var flag = true;
				var doc = diag.innerFrame.contentWindow.document;
				var pj = doc.getElementsByName("pjRadio");
				var pjNum;
				for(var i=0;i<pj.length;i++){
					if(pj[i].checked){
						pjNum = pj[i].value;
					}
				}
				$("#pjNum").val(pjNum);
				diag.close();
			};
			diag.show();
	   }
	   
	   function addMore(obj){
		   if($(obj).attr("checked")){
			   $("#single").hide();
			   $("#multi").show();
		   }else{
			   $("#single").show();
			   $("#multi").hide();
		   }
	   }
	</script>
  </head>
<body><br/>
    <form action="pjManageAction!addPjDyInfo.do" method="post" target="frmright" name="form"> 
        <input type="hidden" name="pjDy.pjStaticInfo.pjsid" id="static_id" value="${pjsId}"/>
        <input type="hidden" name="jcsType" value="${jcsType }"/>
		<table class="tableStyle" transMode="true"><!-- transMode="true" -->
		   <tr>
				<td>配件名称: </td>
				<td colspan="3">
				   <input class="easyui-validatebox" type="text" name="pjDy.pjName" style="width: 300px;" id="pjName" value="${pjName}"></input>
				</td>
			</tr>
			<tr>
				<td>所属静态配件: </td>
				<td colspan="3">
				   <input class="easyui-validatebox" type="text" style="width: 150px;" id="staticName" readonly="readonly" name="pjName" value="${pjsName}"/>&nbsp;&nbsp;&nbsp;
				   <input type="button" value="选择" onclick="choicePart();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				   <input type="checkbox" onclick="addMore(this);" id="more"/>添加多个待修配件
				</td>
			</tr>
		    <tr id="single">
				<td>配件编号:</td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjDy.pjNum" id="pjNum" style="width: 150px;" value="${py}"></input>&nbsp;&nbsp;
				   <input type="button" value="选择物资编号" onclick="choiceWzNum();"/>
				</td>
			
				<td>出厂编号: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjDy.factoryNum"></input>
				</td>
			</tr>
			<tr style="display: none;" id="multi">
			    <td>添加待修配件数量:</td>
			    <td>
			      <input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" id="amount" name="amount"/>
			    </td>
			    
			</tr>
			<tr>
			     <td>存储位置:</td>
			     <td><select id="storePosition" class="default" name="pjDy.storePosition">
		                    <option value="1">班组</option>
		                    <option value="0">中心库</option>
		                    <!-- 	
		                    <option value="2">车上</option>
		                    <option value="3">外地</option>
		                     -->
                        </select>
                        </td>
               	<td>配件状态</td>
               	<td>
               	  <select id="pjStatus" class="default" name="pjDy.pjStatus">
               	        <option value="1">待修</option>
               	        <option value="0">合格</option>
               	      <!-- 
	                    <option value="2">报废</option>
	                    <option value="3">检修中</option>
               	      -->   
               	  </select>
               	</td>
			</tr>
			<tr><td colspan="4" align="center"><input type="button" value="确定" onclick="validate()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"/></td></tr>         
		</table>
	</form>
</body>
</html>