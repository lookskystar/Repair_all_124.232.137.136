<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>"/>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   if(jcsType!=""){
			   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
	               var result=eval("("+data+")");
	               var firstUnitId = '${firstUnitId}';
	               var firstUnits=result.firstUnits;
	               var str="<option value=''>请选择大部件</option>";
	               for(var i=0;i<firstUnits.length;i++){
	            	   if(firstUnitId!=null && firstUnitId!="" && firstUnits[i].firstUnitId==firstUnitId){
	                   		str+="<option selected='selected' value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }else{
	                   		str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }
	               }
	               $("#firstUnitId").children().remove();
	               $("#firstUnitId").append(str);
	           });
		   }
	   }
	   
	   function query(){
			var jcsType=$("#jcsType").val()==undefined?"":$("#jcsType").val();
			var firstUnitId=$("#firstUnitId").val()==undefined?"":$("#firstUnitId").val();
			var pjName=$("#pjName").val()==undefined?"":$("#pjName").val();
			window.location.href="<%=basePath%>partFixAction!listPJDynamicInfo.do?jcsType="+jcsType+"&firstUnitId="+firstUnitId+"&pjName="+pjName;
		}

	   $(function(){
		   getFirstUnit();
	   });
		
	</script>
  </head>
  
 <body>
   	 <div class="box2" panelTitle="配件信息" roller="false">
   	 <form id="form" action="partFixAction!listPJDynamicInfo.do" method="post">
	   <table>
	       <tr>
	          <td>
		                      车型:<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcsTypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
                    </select>
               </td>
               <td>
                                            大部件：<select id="firstUnitId" class="default" name="firstUnitId">
                        <option value="">请选择大部件</option>
                         </select>
               </td> 
               <td>    
                                          配件名称:<input type="text" style="width: 100px" name="pjName" value="${pjName }" id="pjName"/>&nbsp;&nbsp;&nbsp;
               </td>
               <td>
				   <button onclick="query();";>
					   <span class="icon_find">查询</span>
				   </button>
                </td>
	      </tr>
	   </table></form>
	  </div>
	  
	  <div>
			<table class="tableStyle">
				<tr align="center">
					<td >
						配件名
					</td>
					<td >
						车型
					</td>
					<td >
						待修数量
					</td>
					<td >
						检修中数量
					</td>
					<td >
						合格数量
					</td>
					<td >
						操作
					</td>
				</tr>
				<c:forEach var="patr" items="${repairParts}">
					<tr>
						<td align="center">
						    <script type="text/javascript">
						       document.write('<a style="color:blue;" href="'+encodeURI("partFixAction!pjDynamicList.do?pjName=${patr[0]}")+'">${patr[0]}</a>');
						    </script>
						</td>
						<td align="center">
						    ${fn:substring(patr[1],1,fn:length(patr[1])-1)}
						</td>
						<td align="center">
							<c:choose>
								<c:when test="${patr[2]>0}">
								    <script type="text/javascript">
						       			document.write('<a style="color:red;" href="'+encodeURI("partFixAction!pjDynamicList.do?jcsType=${fn:substring(patr[1],1,fn:length(patr[1])-1)}&pjStatus=1&pjName=${patr[0]}")+'">有&nbsp;${patr[2]}&nbsp;待修配件</a>');
						    		</script>
								</c:when>
								<c:otherwise>${patr[2]}</c:otherwise>
							</c:choose>
						</td>
						<td align="center">
						       <script type="text/javascript">
						       		document.write('<a href="'+encodeURI("partFixAction!pjDynamicList.do?jcsType=${fn:substring(patr[1],1,fn:length(patr[1])-1)}&pjStatus=3&pjName=${patr[0]}")+'">${patr[3]}</a>');
						       </script>
						</td>
						<td align="center">
							${patr[4]}
						</td>
						<td align="center">
					       <script type="text/javascript">
					       		document.write('<a style="color:blue;" href="'+encodeURI("partFixAction!pjDynamicList.do?pjName=${patr[0]}")+'">查看</a>');
					       </script>
						</td>
					</tr>					
				</c:forEach>
				<tr><td colspan="6"></td></tr>
			</table>
		</div>
  </body>
</html>