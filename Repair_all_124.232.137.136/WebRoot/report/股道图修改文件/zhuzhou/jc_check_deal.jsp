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
   //显示记录信息
   function showMsg(id){
	   var d=new Date();
	   var now=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
	   var type=$("#tr_"+id+" td:eq(1)").text();
	   var num=$("#tr_"+id+" td:eq(2)").text();
	   var xcxc=$("#tr_"+id+" td:eq(3)").text();
	   var kcsj=$("#tr_"+id+" td:eq(4)").text();
	   $("#jctype").text(type);
	   $("#jcnum").text(num);
	   $("#xcxc").text(xcxc);
	   $("#kcsj").text(kcsj);
	   $("#jcsj").text(now);
   }
   
   //角色签到
   function roleSign(){
	   var datePlanId=$("input[type='radio']").filter("[checked=true]").val();
	   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
		 	top.Dialog.alert("请选择机车!");
	   }else{
		    top.Dialog.open({URL:"<%=basePath%>checkDealJc!roleSignInput.do?dpId="+datePlanId,Width:350,Height:150,Title:"用户签认"});
	   }
   }
   
   //交车
   function dealJc(type){
	   var datePlanId=$("input[type='radio']").filter("[checked=true]").val();
	  // var datePlanId='${entry.rjhmId}';
	   var gzgh=$("#gzgh").val();
	   var gzxm=$("#gzxm").val();
	   var zrgh=$("#zrgh").val();
	   var zrxm=$("#zrxm").val();
	   var ysgh=$("#ysgh").val();
	   var ysxm=$("#ysxm").val();
	   var dzgh=$("#dzgh").val();
	   var dzxm=$("#dzxm").val();
	   var status=$("#status_"+datePlanId).val();
	   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
		 	top.Dialog.alert("请选择机车!");
		 	return;
	   }
	   if(status!=type){
		   top.Dialog.alert("交车方式与机车状态不一致!");
		 	return;
	   }
	   if(zrgh==""||dzgh==""){
		    top.Dialog.alert("请签认完全!");
		 	return;
	   }
	   
	   $.post("<%=basePath%>checkDealJc!saveSignedForFinish.do",
		      {
		        "dpId":datePlanId,
		        "status":status,
		        //"gzgh":gzgh,
		        //"gzxm":gzxm,
		        "zrgh":zrgh,
		        "zrxm":zrxm,
		        //"ysgh":ysgh,
		        //"ysxm":ysxm,
		        "dzgh":dzgh,
		        "dzxm":dzxm
		      },function(data){
		    	  if(data=="success"){
		    		  top.Dialog.alert("交车成功!",function(){
		    			  top.document.location.href="<%=basePath%>report/jcgz_main.jsp";
		    		  });
		    	  }else{
		    		   top.Dialog.alert("交车失败!");
		    	  }
		      });
   }
   
   $(function(){
   		showMsg('${rjhmId}');
   });
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td  width="45%">
	    	<div class="box2"  panelTitle="待验机车" roller="true" showStatus="false" overflow="auto" panelHeight="450" >
	    	  允许列出未签到机车信息
				<table width="100%" class="tableStyle">
					<tr>
					 	<th class="ver01">选择</th>
						<th class="ver01">机车型号</th>
						<th class="ver01">机车号</th>
						<th class="ver01">修程修次</th>
						<th class="ver01">交车工长</th>
						<th class="ver01">检修时间</th>
						<th class="ver01">所处节点</th>
						<th class="ver01">状态</th>
					</tr>
					<c:forEach items="${checkDealJcs}" var="entity">
						<c:if test="${entity.rjhmId==rjhmId}">
						   <tr onclick="showMsg(${entity.rjhmId});" id="tr_${entity.rjhmId}">
						    <td><input type="radio" name="dealJc" value="${entity.rjhmId}" checked="checked"/></td>
						    <td class="ver01">${entity.jcType}</td>
							<td class="ver01">${entity.jcnum}</td>
							<td class="ver01">${entity.fixFreque}</td>
							<td class="ver01">${entity.gongZhang}</td>
							<td class="ver01">${entity.kcsj}</td>
							<td class="ver01">${entity.nodeName}</td>
							<td class="ver01">
							  <c:if test="${entity.planStatue==0}"><font style="color: blue">在修</font></c:if>
							  <c:if test="${entity.planStatue==1}">待验</c:if>
							  <input type="hidden" id="status_${entity.rjhmId}" value="${entity.planStatue}"/>
							</td>
						  </tr>
						</c:if>
					</c:forEach>
				</table>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="机务段检修竣工交验单"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  	 <button  onclick="roleSign();"><span class="icon_save">签认</span></button>&nbsp;&nbsp;&nbsp;&nbsp;
		  	 <button  onclick="dealJc(1);"><span class="icon_save">正常交车</span></button>&nbsp;&nbsp;&nbsp;&nbsp;
		  	 <button  onclick="dealJc(0);"><span class="icon_save">强制交车</span></button>
	    	  <div id="jgjl">
	    	      <h3><center>机车竣工验收记录</center></h3><Br/>
	    	      &nbsp;&nbsp;&nbsp;<font size="3">配属&nbsp;广州&nbsp;局&nbsp;株洲&nbsp;段_<span id="jctype" style="color: blue"></span>_型号_<span id="jcnum" style="color: blue"></span>_号机车，已于_<span id="kcsj" style="color: blue"></span>_至
	    	      _<span id="jcsj" style="color: blue"></span>_由&nbsp;株洲&nbsp;机务段，按照有关技术规定经_<span id="xcxc" style="color: blue"></span>_修次竣工，经局驻段验收员检查验收，确认技术状态合格，准予交付运用。</font>
	    	  </div>
	    	  <hr width="100%" color="blue" size="3"><br/>
	    	  <div>
	    	    <table width="50%" class="tableStyle">
	    	      <tr><th colspan="3">签到信息列表</th></tr>
	    	      <tr>
	    	          <th class="ver01">角色</th>
					  <th class="ver01">工号</th>
					  <th class="ver01">姓名</th>
	    	      </tr>
	    	      <!-- 
	    	      <tr>
	    	          <th class="ver01">交车工长</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="gzgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="gzxm"/></th>
	    	      </tr> -->
	    	       <tr>
	    	          <th class="ver01">检修主任</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="zrgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="zrxm"/></th>
	    	      </tr>
	    	     <!-- <tr>
	    	          <th class="ver01">驻段验收员</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="ysgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="ysxm"/></th>
	    	      </tr>-->
	    	      <tr>
	    	          <th class="ver01">段长</th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="dzgh"/></th>
					  <th class="ver01"><input type="text" style="width: 150px" readonly="readonly" id="dzxm"/></th>
	    	      </tr>
	    	    </table>
	    	  </div>
	    	  <div>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>