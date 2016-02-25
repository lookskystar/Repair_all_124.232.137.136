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
   function showSubItem(id){
	       var recId=$("#recId").val();
		   $('#oilsubitem').attr("src","oilAssay!oilSubItemInput.do?itemId="+id+"&recId="+recId+"&tmp="+new Date().getTime());
   }
   
   function fillValue(){
	    var subItemId="";
	    var subItems=top.frmright.oilsubitem.document.getElementsByName("subItem");
	    var recId=$("#recId").val();
	    for(var i=0;i<subItems.length;i++){
		  if(subItems[i].checked==true){
			  subItemId=subItems[i].id;
		  }
	    }
	    if(subItemId==""||subItemId==undefined||subItemId==null){
	    	top.Dialog.alert("请选择要填值的项目!");
	    }else{
	    	 var diag = new top.Dialog();
			 diag.Title = "填报值";
			 diag.URL = "oilAssay!updateOilRecorderDialog.do?recId="+recId;
			 diag.Width=420;
			 diag.Height=320;
			 diag.show();
	    }
   }
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	 <input type="hidden" value="${recorder.recPriId}" id="recId" />
	  <tr>
	    <td  width="25%">
	    	<div class="box2"  panelTitle="油样项目目录" roller="true" showStatus="false" overflow="auto" panelHeight="450" >
				<table width="100%" class="tableStyle">
					<tr>
					    <th class="ver01" width="3%">选择</th>
						<th class="ver01">油样项目</th>
					</tr>
					<c:forEach items="${items}" var="entity">
					   <tr onclick="showSubItem(${entity.reportItemId});" id="tr_${entity.reportItemId}">
					    <td><input type="radio" id="${entity.reportItemId}" name="checkjc" value="${entity.reportItemId}"/></td>
					    <td class="ver01">${entity.reportItemDefin}</td>
					  </tr>
					</c:forEach>
				</table>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="油样化验项目"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  	   当前机车：${recorder.jcsTypeVal}-${recorder.jcNum}
		  	   <IFRAME scrolling="auto" width="100%" height="390px"  frameBorder=0 id=oilsubitem name=oilsubitem src=""  allowTransparency="true"></IFRAME>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>