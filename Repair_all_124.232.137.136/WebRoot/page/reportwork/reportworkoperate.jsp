<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>" />
	<title>报活添加或修改</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<!-- Ajax上传图片 -->
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->

	<!--文本截取start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--文本截取end-->
	<script src="js/menu/contextmenu.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
		    var option = { width: 150, items: [
                    { text: "ⅠⅡ室", icon: "<%=basePath%>images/icons/ico4.gif", alias: "ⅠⅡ室", type: "group", width: 180, items: [
                        { text: "Ⅰ室", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "Ⅰ室", action: menuAction },
                        { text: "Ⅱ室", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "Ⅱ室", action: menuAction },
                        { text: "ⅠⅡ室", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "ⅠⅡ室", action: menuAction }
                    	]
                    },
                    { text: "左右侧", icon: "<%=basePath%>images/icons/ico4.gif", alias: "左右侧", type: "group", width: 180, items: [
                        { text: "左侧", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "左侧", action: menuAction },
                        { text: "右侧", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "右侧", action: menuAction },
                        { text: "左右侧", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "左右侧", action: menuAction }
                    	]
                    },
                    { text: "前后端", icon: "<%=basePath%>images/icons/ico4.gif", alias: "前后端", type: "group", width: 180, items: [
                        { text: "前端", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "前端", action: menuAction },
                        { text: "后端", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "后端", action: menuAction },
                        { text: "前后端", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "前后端", action: menuAction }
                    	]
                    },
                    { text: "第1-16", icon: "<%=basePath%>images/icons/ico4.gif", alias: "第1-16", type: "group", width: 180, items: [
                        { text: "第一", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第一", action: menuAction },
                        { text: "第二", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第二", action: menuAction },
                        { text: "第三", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第三", action: menuAction },
                        { text: "第四", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第四", action: menuAction },
                        { text: "第五", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第五", action: menuAction },
                        { text: "第六", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第六", action: menuAction },
                        { text: "第七", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第七", action: menuAction },
                        { text: "第八", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第八", action: menuAction },
                        { text: "第九", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第九", action: menuAction },
                        { text: "第十", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十", action: menuAction },
                        { text: "第十一", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十一", action: menuAction },
                        { text: "第十二", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十二", action: menuAction },
                        { text: "第十三", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十三", action: menuAction },
                        { text: "第十四", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十四", action: menuAction },
                        { text: "第十五", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十五", action: menuAction },
                        { text: "第十六", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "第十六", action: menuAction }
                    	]
                    },
                    { text: "常报处所", icon: "<%=basePath%>images/icons/ico4.gif", alias: "常报处所", type: "group", width: 180, items: [
                        { text: "牵引电机", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "牵引电机", action: menuAction },
                        { text: "主发电机", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "主发电机", action: menuAction },
                        { text: "CF电机", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "CF电机", action: menuAction },
                        { text: "抱轴瓦油盒", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "抱轴瓦油盒", action: menuAction },
                        { text: "齿轮箱", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "齿轮箱", action: menuAction },
                        { text: "齿轮箱吊杆", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "齿轮箱吊杆", action: menuAction },
                        { text: "扭石器", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "扭石器", action: menuAction },
                        { text: "排障器", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "排障器", action: menuAction },
                        { text: "手制机", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "手制机", action: menuAction },
                        { text: "闸瓦调整器", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "闸瓦调整器", action: menuAction },
                        { text: "塞门", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "塞门", action: menuAction },
                        { text: "自阀", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "自阀", action: menuAction },
                        { text: "单阀", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "单阀", action: menuAction },
                        { text: "喷油泵", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "喷油泵", action: menuAction },
                        { text: "喷油器", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "喷油器", action: menuAction },
                        { text: "油缸盖", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "油缸盖", action: menuAction }
                    	]
                    },
                    { text: "常见故障", icon: "<%=basePath%>images/icons/ico4.gif", alias: "常见故障", type: "group", width: 180, items: [
                        { text: "丢失", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "丢失", action: menuAction },
                        { text: "损坏", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "损坏", action: menuAction },
                        { text: "失效", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "失效", action: menuAction },
                        { text: "断裂", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "断裂", action: menuAction },
                        { text: "偏磨", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "偏磨", action: menuAction },
                        { text: "漏油", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "漏油", action: menuAction },
                        { text: "漏水", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "漏水", action: menuAction },
                        { text: "漏风", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "漏风", action: menuAction },
                        { text: "松动", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "松动", action: menuAction },
                        { text: "烧损", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "烧损", action: menuAction },
                        { text: "脱落", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "烧损", action: menuAction },
                        { text: "烧损", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "烧损", action: menuAction },
                        { text: "接触不良", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "接触不良", action: menuAction },
                        { text: "作用不良", icon: "<%=basePath%>images/icons/ico6-2.gif", alias: "作用不良", action: menuAction }
                    	]
                    }
                    ], onShow: applyrule,
        onContextMenu: BeforeContextMenu
    };
    function menuAction() {
    	var obj = $("#explain").html();
        $("#explain").html(obj+this.data.alias);
    }
    function BeforeContextMenu() {
        return this.id != "target3";
    }
    
    function applyrule(menu) {               
       menu.applyrule({ name: "all",
           disable: true,
           items: []
       });
    }
    $("#explain").contextmenu(option);
});
</script>
</head>
	<body>
		<div class="box1" whiteBg="true"><!-- frmright  jcmain leadmain-->
		    <c:choose>
		      <c:when test="${roleType=='jcgz'}">
		        <form action="reportWorkManage!jtPreDictConfirm.action" method="post" id="subform" target="jcmain" onsubmit="return submitValidate()" enctype="multipart/form-data">
		      </c:when>
		      <c:when test="${roleType=='lead'}">
		        <form action="reportWorkManage!jtPreDictConfirm.action" method="post" id="subform" target="leadmain" onsubmit="return submitValidate()" enctype="multipart/form-data">
		      </c:when>
		      <c:otherwise>
		        <form action="reportWorkManage!jtPreDictConfirm.action" method="post" id="subform" target="frmright" onsubmit="return submitValidate()" enctype="multipart/form-data">
		      </c:otherwise>
		    </c:choose>
				<input type="hidden" id="rjhmId" name="rjhmId" value="${rjhmId}"/>
				<input type="hidden" id="score" name="preDict.score" value="1"/>
				<table width="100%">
					<tr><td width="50%" valign="top">
						<table>
					<tr>
						<td height="12px;">
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td width="30%">
							<div style="text-align: right; margin-right: 20px;">报活类型：</div>
						</td>
						<td>
							<input type="radio" name="type" value="0" onclick="zeroReport(this)"/>JT28报活
							<input type="radio" name="type" value="1" onclick="zeroReport(this)"/>复检报活
							<input type="radio" name="type" value="2" onclick="zeroReport(this)"/>过程报活
							<input type="radio" name="type" value="6"/>零公里报活<br/>
						</td>
					</tr>
				    <tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">班组：</div>
						</td>
						<td>
							<select id="proteamId" name="preDict.proTeamId.proteamid" class="default" style="width: 209px;">
				    	        <option value="">请选择班组名称</option>
				    	        <c:if test="${!empty dictProTeams}">
				    	        	<c:forEach var="entry" items="${dictProTeams}">
					    	           <option value="${entry.proteamid}">${entry.proteamname}</option>
					    	        </c:forEach>
					    	        <option value="0">交车组</option>
				    	        </c:if>
				    	    </select>&nbsp;&nbsp;&nbsp;<input type="checkbox" id="jczCheck" onclick="jczSelect();"/>交车组
						</td>
					</tr>
					<!-- 
					<tr id="preset">
						<td>
							<div style="text-align: right; margin-right: 20px;">预分工大类：</div>
						</td>
						<td>
							<select id="division" name="preDict.divisionId" class="default" style="width: 209px;">
							    <option value="">请选择预分工大类</option>
				    	    </select>
						</td>
					</tr>
					 -->
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">故障所处：</div>
						</td>
						<td>
							<select id="yjbj" onchange="getSecUnit()" class="default" style="width: 209px;">
							    <option value="0">请选择专业</option>
							    <c:if test="${!empty dictFirstUnits}">
							    	<c:forEach items="${dictFirstUnits}" var="entry">
							    		<option value="${entry}">${entry}</option>
							    	</c:forEach>
							    </c:if>
							</select><br/>
							<select id="ejbj" class="default" onchange="getThirdUnit()" name="preDict.repPosi" style="margin-top: 5px;width: 209px;">
							    <option value="">请选择部位</option>
							</select><br/>
							<select id="sjbj" class="default" name="preDict.repPosi" onchange="listDictFailure()" style="margin-top: 5px;width: 209px;">
							    <option value="">请选择处所</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">故障说明：</div>
						</td>
						<td>
							<textarea id="explain" name="preDict.repsituation"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">照片：</div>
						</td>
						<td valign="top">
							<input id="fileupload" name="fileMaterial" type="file" /> 
							<input type="button" onclick="uploadImage()" value="上传" />
							<input type="hidden" id="imgUrl" value=""/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">提票签字：</div>
						</td>
						<td>
							<input type="hidden" id="userId" name="id" value="${session_user.userid}"/>
							<input type="hidden" id="gonghao" name="preDict.repempNo" value="${session_user.gonghao}"/>
							<input type="text" id="repemp" value="${session_user.xm}" readonly="readonly" name="preDict.repemp"/>
						</td>
					</tr>
					</table></td>
						<td align="left" valign="top"><div style="overflow: auto;height: 435px;">
							<table width="100%" id="radioTable" border="1px" cellpadding="0" cellspacing="0">
								<tr bgcolor="lightblue"><th width="10px"></th><th>故障内容</th></tr>
							</table></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" height="30px">
							<input type="button" id="subEnter" value="提 交 " />
							<input type="button" onclick="return getMyReport()"  value="查看报活信息" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#subEnter").bind("click",function(){
					//日计划ID
					var rjhmId = $("#rjhmId").val();
					//报活类型
					var predictType = $("input[name='type']:checked").val();
					//班组ID
					var proteamId = $("#proteamId").val();
					//一级部件
					var yjbj = $("#yjbj").val();
					//二级部件
					var ejbj = $("#ejbj").val();
					//三级部件
					var sjbj = $("#sjbj").val();
					//故障说明
					var explain = $("#explain").val();
					//用户ID
					var userId = $("#userId").val();
					//工号
					var gonghao  = $("#gonghao").val();
					//姓名
					var repemp = $("#repemp").val();
					//图片URL
					var imgUrl = $("#imgUrl").val();
					//故障分值
					var score=$("#score").val();
					//验证
//					submitValidate();
					var flag = submitValidate();
					if(flag){
						//ACTION
						$.post("reportWorkManage!jtPreDictConfirm.action",{"rjhmId":rjhmId,"type":predictType,"proteamId":proteamId,
								"yjbj":yjbj,"ejbj":ejbj,"sjbj":sjbj,"explain":explain,"userId":userId,"gonghao":gonghao,"repemp":repemp,"imgUrl":imgUrl,"score":score},
							function(data){
								if(data == "success"){
									top.Dialog.alert("报活成功！");
								}else{
									top.Dialog.alert("报活失败!");
								}
						})
					}
					
				})
			
			})
			
			function uploadImage(){  
			    $(document).ready(
                   function(){  
                       var options = { 
                       	  //跳转到相应的Action  
                          url : "reportWorkManage!ajaxGetImage.action",
                          //提交方式  
                          type : "POST",
                          //数据类型  
                          dataType : "script",
                          //调用Action后返回过来的数据  
                          success : function(msg) {
                               if (msg.indexOf(",") > 0) {  
                                    var data = msg.split(",");  
                                    $("#imgUrl").val(data[0]); 
                                    top.Dialog.alert(data[1]);
                                } else {  
                                	top.Dialog.alert(msg);
                                }  
                               
                          }  
                       };  
                       //绑定页面中form表单的id  
                       $("#subform").ajaxSubmit(options);
                       return false;  
                   });  
			}  

		
			function submitValidate() {
				var type = $('input[type=radio]').filter('[checked=true]').val();
				if (!type) {
					top.Dialog.alert("请选择报活类型！");
					return false;
				}
				
				var proTeam = $('#proteamId').val();
				if (!proTeam) {
					top.Dialog.alert("请选择报给的班组！");
					return false;
				}
				
				var ejbj = $('#ejbj').val();
				if (!ejbj) {
					top.Dialog.alert("请选择故障所处位置！")
					return false;
				}
				
				var explain = $('#explain').val();
				if (!explain) {
					top.Dialog.alert("请输入故障说明！")
					return false;
				}
				return true;
			}
			
			
			function getSecUnit() {
				var firstunitid=$("#yjbj").val();
				var ejbj ;
				if(firstunitid!=''){
					$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":firstunitid,"type":0},function(data){
						var map=eval("("+data+")");
						var result=map['unit'];
						var ejbj = "<option value=''>请选择部位</option><option value='其他'>其他</option>";
						for(var i=0;i<result.length;i++){
							if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
								ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
							}
					    }
						$('#ejbj').html(ejbj);
						result=map['failure'];
						ejbj = "<tr bgcolor='lightblue'><th width='10px'></th><th>故障内容</th></tr>";
						var id;
						for(var i=0;i<result.length;i++){
							id = 'gznr_'+i;
							ejbj+="<tr><td><input type='radio' name='gznr' id='id_"+id+"' onclick='fillFailure(\""+id+"\")' /></td><td id='"+id+"' onclick='fillFailure(\""+id+"\",1)'>"+result[i].content+"</td><input type='hidden' id='score_"+id+"' value='"+result[i].score+"'/></tr>";
					    }
						$('#radioTable').html(ejbj);
					});
				}
			}
			
			function getThirdUnit(){
				var first=$("#yjbj").val();
				var second=$("#ejbj").val();
				if(first!='' && second!=''){
					$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":first,"second":second,"type":1},function(data){
						var map=eval("("+data+")");
						var result=map['unit'];
						var ejbj = "<option value=''>请选择处所</option>";
						for(var i=0;i<result.length;i++){
							if(result[i].unitName!=null&&result[i].unitName!=''&&result[i].unitName!=undefined){
								ejbj+="<option value='"+result[i].unitName+"'>"+result[i].unitName+"</option>";
							}
					    }
						$('#sjbj').html(ejbj);
						result=map['failure'];
						ejbj = "<tr bgcolor='lightblue'><th width='10px'></th><th>故障内容</th></tr>";
						for(var i=0;i<result.length;i++){
							id = 'gznr_'+i;
							ejbj+="<tr><td><input type='radio' name='gznr' id='id_"+id+"' onclick='fillFailure(\""+id+"\")'/></td><td id='"+id+"' onclick='fillFailure(\""+id+"\",1)'>"+result[i].content+"</td><input type='hidden' id='score_"+id+"' value='"+result[i].score+"'/></tr>";
					    }
						$('#radioTable').html(ejbj);
					});
				}
			}
			
			function listDictFailure(){
				var first=$("#yjbj").val();
				var second=$("#ejbj").val();
				var third=$("#sjbj").val();
				if(first!='' && second!='' && third!=''){
					$.post("reportWorkManage!ajaxGetDictSecunit.action",{"first":first,"second":second,"third":third,"type":2},function(data){
						var map=eval("("+data+")");
						var result=map['failure'];
						var ejbj = "<tr bgcolor='lightblue'><th width='10px'></th><th>故障内容</th></tr>";
						var id;
						for(var i=0;i<result.length;i++){
							id = 'gznr_'+i;
							ejbj+="<tr><td><input type='radio' name='gznr' id='id_"+id+"' onclick='fillFailure(\""+id+"\")'/></td><td id='"+id+"' onclick='fillFailure(\""+id+"\",1)'>"+result[i].content+"</td><input type='hidden' id='score_"+id+"' value='"+result[i].score+"'/></tr>";
					    }
						$('#radioTable').html(ejbj);
					});
				}
			}
			
			
			//根据班组ID得到班组下的预设分工信息
			function getPresetDivision(){
				if($("#proteamId").val()!=0){
					$("#jczCheck").attr("checked",false);
				}
				
				var jcType='${type}';
				var proTeamId=$("#proteamId").val();
				if(proTeamId!=""||proTeamId!=undefined){
					$.post("reportWorkManage!ajaxGetDivision.do",{"proTeamId":proTeamId,"jcType":jcType},function(data){
						var map=eval("("+data+")");
						var result=map.division;
						var str="<option value=''>请选择预分工大类</option>";
						for(var i=0;i<result.length;i++){
							str+="<option value="+result[i].divisionId+">"+result[i].divisionName+"</option>";
						}
						$("#division").html(str);
					});
				}
			}
			
			function fillFailure(id,type){
				if(type==1){
					$("#id_"+id).attr("checked",true)
				}
				var con = $("#"+id).html();
				var score=$("#score_"+id).val();
				$("#explain").val(con);
				$("#score").val(score);
			}
			
			function zeroReport(obj){
				if(obj.value==6){
					$("#preset").hide();
				}else{
					$("#preset").show();
				}
			}
			
			function jczSelect(){
				if($("#jczCheck").attr("checked")){
					$("#proteamId").val("0");
					getPresetDivision();
				}else{
					$("#proteamId").val("");
				}
			} 
			
			function getMyReport(){
//			  var dpId=$("#rjhmId").val();
			  window.parent.frames[1].location.reload();   
//			  window.location.href="<%=basePath%>reportWorkManage!reportWork.action?id=${rjhmId}";
			}
			
		</script>
	</body>
</html>