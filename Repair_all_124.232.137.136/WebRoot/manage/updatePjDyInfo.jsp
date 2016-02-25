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
		   var pjNum = $("#pjNum").val();
		   var pjdid=$("#pjdid").val();
		   if(pjName==""){
			    top.Dialog.alert("请填写配件名称!");
			    return false;
		   }
		   if(staticName==""){
			    top.Dialog.alert("请选择所属的静态配件信息!");
			    return false;
		   }
		   if(pjNum!=""){
			   $.post("pjManageAction!ajaxUniquePJNum.do",{"pjnum":pjNum,"pjdid":pjdid},function(text){
			   		if(text==0){
			   			$("#enterForm").submit();
			   		}else{
			   			top.Dialog.alert("配件编码已存在 ,请重新输入!");
			   		}
			   });
		   }else{
		   		$("#enterForm").submit();
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
	</script>
  </head>
<body><br/>
    <form action="pjManageAction!updatePjDyInfo.do" method="post" target="frmright" id="enterForm"> 
        <input type="hidden" value="${pjDy.pjdid}" name="pjDy.pjdid" id="pjdid"/>
        <input type="hidden" name="pjDy.pjStaticInfo.pjsid" id="static_id" value="${pjDy.pjStaticInfo.pjsid}"/>
		<table class="tableStyle" transMode="true"><!-- transMode="true" -->
		   <tr>
				<td>配件名称: </td>
				<td colspan="3">
				   <input class="easyui-validatebox" type="text" name="pjDy.pjName" style="width: 300px;" id="pjName" value="${pjDy.pjName}"></input>
				</td>
			</tr>
			<tr>
				<td>所属静态配件: </td>
				<td colspan="3">
				     <input class="easyui-validatebox" type="text" style="width: 150px;" id="staticName" readonly="readonly" name="pjName" value="${pjDy.pjStaticInfo.pjName}"/>&nbsp;&nbsp;&nbsp;
				   	 <input type="button" value="选择" onclick="choicePart();"/>
				</td>
			</tr>
		    <tr>
				<td>配件编号: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjDy.pjNum" value="${pjDy.pjNum}" id="pjNum"></input>&nbsp;&nbsp;
				   <input type="button" value="选择物资编号" onclick="choiceWzNum();"/>
				</td>
			
				<td>出厂编号: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjDy.factoryNum" value="${pjDy.factoryNum}"></input>
				</td>
			</tr>
			<tr>
			     <td>存储位置:</td>
			     <td><select id="storePosition" class="default" name="pjDy.storePosition">
		                    <option value="0" <c:if test="${pjDy.storePosition==0}">selected="selected"</c:if>>中心库</option>
		                    <option value="1" <c:if test="${pjDy.storePosition==1}">selected="selected"</c:if>>班组</option>
		                    <option value="2" <c:if test="${pjDy.storePosition==2}">selected="selected"</c:if>>车上</option>
		                    <option value="3" <c:if test="${pjDy.storePosition==3}">selected="selected"</c:if>>外地</option>
                        </select>
                        </td>
               	<td>配件状态</td>
               	<td>
               	  <select id="pjStatus" class="default" name="pjDy.pjStatus">
               	        <option value="0" <c:if test="${pjDy.pjStatus==0}">selected="selected"</c:if>>合格</option>
	                    <option value="1" <c:if test="${pjDy.pjStatus==1}">selected="selected"</c:if>>待修</option>
	                    <option value="2" <c:if test="${pjDy.pjStatus==2}">selected="selected"</c:if>>报废</option>
	                    <option value="3" <c:if test="${pjDy.pjStatus==3}">selected="selected"</c:if>>检修中</option>
               	  </select>
               	</td>
			</tr>
			<!-- 
			<tr>
				<td>所属流程: </td>
				<td colspan="3">
				   <select id="flow" class="default" name="pjDy.fixFlowName">
				     <option value="流程类型一">流程类型一</option>
				     <option value="流程类型二">流程类型二</option>
               	   </select>&nbsp;&nbsp;<font color="red">(*流程类型一有5个流程节点，流程类型二有2个流程节点)</font>
				</td>
			</tr> -->
			<tr><td colspan="4" align="center"><input type="button" value="确定" onclick="validate()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"/></td></tr>         
		</table>
	</form>
</body>
</html>