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
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   if(jcsType!=""){
			   $.post("<%=basePath%>fixItemAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
	               var result=eval("("+data+")");
	               var firstUnits=result.firstUnits;
	               var str="<option value=''>请选择大部件</option>";
	               for(var i=0;i<firstUnits.length;i++){
	                   str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";	                   
	               }
	               $("#first").children().remove();
	               $("#first").append(str);
	           });
		   }
	   }

	    function checkform(){
		    
		}
		
		function xianshi1(){
			$("#fill").css("visibility","visible");
			$(".ui").css("visibility","hidden");
			$(".ui").val("");
		}

		function xianshi2(){
			$("#fill").css("visibility","hidden");
			$(".ui").css("visibility","visible");
			$("#fill").val("");
		}
		
	</script>
  </head>
<body>
    <form action="fixItemAction!addZxItem.do" method="post" id="subForm" target="frmright" onsubmit="return checkform()"> 
    	<input type="hidden" id="unitName" name="zxfixItem.unitName" value=""/>
    	<input type="hidden" id="jcsTypeString" name="zxfixItem.jcsType" value=""/>
		<table class="tableStyle"><!-- transMode="true" -->
		    <tr>
				<td>适用车型: </td>
				<td colspan="3">				
	                  <c:forEach items="${jcsTypes}" var="entry">
	                      <input type="radio"  name="dictjcsType" value="${entry.jcStypeValue}">${entry.jcStypeValue}</input>
	                  </c:forEach>          	
				</td>
			</tr>
			<tr>
			    <td>机车型号: </td>
			    <td ><select  onchange="getFirstUnit();" class="default" id="jcsType" name="jcsType">
		                     <option value="">请选择机车型号</option>
		                     <c:forEach var="jc" items="${jcsTypes}">
		                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
		                     </c:forEach>
                    </select>
               </td>
               <td>检修时长: </td>
				<td>
				   <input  class="uu" type="text" name="zxfixItem.duration"></input>分钟
				</td>
			</tr>
			<tr>
			    <td>大部件名称:</td>
			    <td><select id="first"  class="default" name="zxfixItem.firstUnitId">
                     		<option value="">请选择大部件</option>
               			  </select>
               	</td>
               	<td>部位名称: </td>
				<td>
				   <input class="uu" type="text" name="zxfixItem.posiName"></input>
				</td>	
			</tr>
	 						
			<tr>
			<td colspan="4">
			<input onclick="xianshi1()" class="rad" type="radio" name="item" checked="checked" />检查项目<input onclick="xianshi2()" class="rad" type="radio" name="item" />检测项目
			</td>
			</tr>			
			<tr>
				<td>填报默认值: </td>
				<td>
				   <input id="fill" type="text" name="zxfixItem.fillDefaval" class="uu"></input>
				</td>			
				<td>单位: </td>
				<td>
					<input style="visibility: hidden;" class="ui" type="text" name="zxfixItem.unit"></input>
				</td>
			</tr>
			<tr>
				<td>最小值: </td>
				<td>
					<input style="visibility: hidden;" class="ui" type="text" name="zxfixItem.min" ></input>
				</td>
			
				<td>最大值: </td>
				<td>
					<input style="visibility: hidden;" class="ui" type="text" name="zxfixItem.max" ></input>
				</td>
			</tr>
			<tr>
				<td>组装配件个数: </td>
				<td>
				    <input  class="uu" type="text" name="zxfixItem.amount"></input>
				</td>
				
				<td>被组装配件名: </td>
				<td>
				  <select  id="pjsid"  class="default" name="zxfixItem.stdPJId">
                     <option value="">请选择配件</option>
                     <c:forEach var="pjstat" items="${pJStaticInfoList}">
                         <option value="${pjstat.pjsid}" <c:if test="${pjstat.pjsid==pjsid}">selected="selected"</c:if>>${pjstat.pjName }</option>
                     </c:forEach>
                  </select>
				</td>
			</tr>
			<tr>
				<td>所属班组: </td>
				<td>
				   <select  class="default" name="zxfixItem.bzId.proteamid">
                     <c:forEach var="team" items="${proTeams}">
                         <option value="${team.proteamid}" <c:if test="${team.proteamid==teamId}">selected="selected"</c:if>>${team.proteamname }</option>
                     </c:forEach>
                  </select>
				</td>
				<td>复探卡控: </td>
				<td>
					<input type="radio" name="zxfixItem.itemCtrlRept" value="1"/>卡控<input type="radio" name="zxfixItem.itemCtrlRept" value="0"/>不卡控
				</td>
			</tr>		
			<tr>
				<td>质检员卡控: </td>
				<td>
					<input type="radio" name="zxfixItem.itemCtrlQi" value="1"/>卡控<input type="radio" name="zxfixItem.itemCtrlQi" value="0"/>不卡控
				</td>
				<td>技术员卡控: </td>
				<td>
					<input type="radio" name="zxfixItem.itemCtrlTech" value="1"/>卡控<input type="radio" name="zxfixItem.itemCtrlTech" value="0"/>不卡控
				</td>			
			</tr>			
			<tr>
				<td>交车工长卡控: </td>
				<td>
				  <input type="radio" name="zxfixItem.itemCtrlComld" value="1"/>卡控<input type="radio" name="zxfixItem.itemCtrlComld" value="0"/>不卡控
				</td>			
				<td>验收员卡控: </td>
				<td>
					<input type="radio" name="zxfixItem.itemCtrlAcce" value="1"/>卡控<input type="radio" name="zxfixItem.itemCtrlAcce" value="0"/>不卡控
				</td>
			</tr>
			<tr>
				<td>项目所属流程: </td>
				<td>
				   <select  class="default" name="zxfixItem.nodeId.jcFlowId">
                     <option value="100">机车分解</option>
                     <option value="101">车上组装</option>
                  </select>
				</td>
				
			</tr>
			<tr>
				<td>项目名称: </td>
				<td colspan="3">
				   <textarea rows="5" cols="50" class="default" id="itemName" name="zxfixItem.itemName"></textarea>
				</td>
			</tr>
			<tr>
				<td>修程修次: </td>
				<td colspan="3">
				   <textarea rows="5" cols="50" class="default" id="xcxc" name="zxfixItem.xcxc"></textarea>
				</td>
			</tr>
			<tr><td colspan="4" align="center"><input type="button" id="enter" value="确定"/></td></tr>         
		</table>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#enter').bind('click', function() {
			//参数列
				var jctypeString = "";
				$("input[name='dictjcsType']:checked").each(function() {
					jctypeString += $(this).val() + ",";
				})
				$("#jcsTypeString").val(jctypeString);

				if($("#jcsType").val()==''){
				    alert("机车型号不能为空！");
				    return false;
			    }
			    if($("#first").val()==''){
				    alert("大部件不能为空！");
				    return false;
			    }else{
				    var unitName=$("#first").find("option:selected").text();
				    $("#unitName").val(unitName);
			    }
			    if($("#itemName").val()==''){
				    alert("项目名称不能为空！");
				    return false;
			    }
			    if($("#xcxc").val()==''){
				    alert("修程修次不能为空！");
				    return false;
			    }
				if (jctypeString != "") {
					$("#subForm").submit();
				} else {
					top.Dialog.alert("请选择适用车型！");
				}
			})
	})
</script>
</html>