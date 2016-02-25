<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>水阻试验</title>
    <script type="text/javascript" src="js/jquery-1.4.js"></script>
    <script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
  <style>
table{ font-size:12px; color:#333; border:1px solid #ccc; border-right:2px solid #ccc; border-bottom:2px solid #ccc; }
td{border-top:1px solid #ccc;border-left:1px solid #ccc; padding:1px;}
td{ vertical-align:middle;}
input{height:20px;width:80%; line-height:20px; border:1px solid #ccc; color:#666; }
.font10{ font-size:10px;}
.bge3e3e3{ background-color:#e3e3e3;}
.bgf3f3f3{ background-color:#f3f3f3;}
.bgf3f3f3 input{ background-color:f3f3f3;}
</style>
<script type="text/javascript">
	$(function(){
		$("input").change(function(){
			var val = $(this).val();
			var name = $(this).attr("name");
			var rjhmId = $("#rjhmId").val();
			var expId = $("#expId").val();
			var roleFlag = $("#roleFlag").val();
			var recId = $(this).attr("recid");
			//alert("试验项目记录id："+recId);
			if(recId.length>0){
				var changeFlag = confirm("你确认修改当前记录吗？");
				if(changeFlag){
					$.post("experiment!changeExpItemRec.do",{recId:recId,itemVal:val},function(data){
						alert(data);
						window.location.reload();
					},"text");
				}
			}else{
				if($.trim(val).length>0){
					$.post("experiment!signExpItem.do",{itemName:name,itemVal:val,rjhmId:rjhmId,expId:expId,roleFlag:roleFlag},function(data){
						if(data=="success"){
							$.messager.show(0, '保存成功', 1000);
							//top.Dialog.alert("保存成功");
						}else{
							top.Dialog.alert("保存失败");
						}
					},"text");
				}
			}
			
		})
	})
	
	//保存或修改试验时间
	function changeExpTime(){
		var time = $("#sytime").val();
		var rjhmId = $("#rjhmId").val();
		var expId = $("#expId").val();
		$.post("experiment!signExpTime.do",{rjhmId:rjhmId,expId:expId,time:time},function(data){
			if(data=="success"){
				alert("操作成功");
			}else{
				alert("操作失败");
			}
		},"text");
	}
</script>
</head>
<body >
<table style="text-align:center;" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td colspan="28"><h1 style="text-align:center;">${datePlan.jcType}内燃机车水阻试验记录</h1></td>
    </tr>
    <tr class="bgf3f3f3">
      <td colspan="3" class="bge3e3e3">机车号</td>
      <td colspan="3">${datePlan.jcnum}</td>
      <td colspan="2">修程</td>
      <td colspan="2">${datePlan.fixFreque}</td>
      <td colspan="3">试验时间</td>
      <td colspan="15">
      	<c:choose>
      	 	<c:when test="${empty experiment.empAffirmTime}">
      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width:120px;"/>
   		 		<input type="button" value="提交时间" onclick="changeExpTime()" style="width:70px;background-color:#9cc5f8";/>
      	 	</c:when>
      	 	<c:otherwise>
      	 		<input type="text" id="sytime" class="Wdate" onclick="WdatePicker()" value="${experiment.empAffirmTime}" style="width: 120px;"/>
   		 		<input type="button" value="修改时间" onclick="changeExpTime()" style="width:70px;background-color:#9cc5f8"/>
      	 	</c:otherwise>
      	 </c:choose>
      </td>
     </tr>
    <tr>
      <td class="bge3e3e3">磨合试验</td>
      <td colspan="5">空载磨合</td>
      <td colspan="5">第一次负载磨合</td>
      <td colspan="3">第二次负载磨合</td>
      <td colspan="3">第三次负载磨合</td>
      <td colspan="11">各部状态及参数</td>
      </tr>
    <tr>
      <td class="bge3e3e3">手柄位</td>
      <td width="4%">0</td>
      <td width="4%">2</td>
      <td>4</td>
      <td>6</td>
      <td width="4%">8</td>
      <td width="4%">1</td>
      <td>2</td>
      <td width="4%">4</td>
      <td width="4%">6</td>
      <td width="4%">8</td>
      <td width="4%">10</td>
      <td width="4%">11</td>
      <td width="4%">13</td>
      <td width="4%">14</td>
      <td width="4%">15</td>
      <td width="4%">16</td>
      <td colspan="11"></td>
      </tr>
    <tr>
      <td class="bge3e3e3">转速(A型)</td>
      <td >500&plusmn;10</td>
      <td >&plusmn;10</td>
      <td >620&plusmn;10</td>
      <td >700&plusmn;10</td>
      <td >780&plusmn;10</td>
      <td >500&plusmn;10</td>
      <td >&plusmn;10</td>
      <td >620&plusmn;10</td>
      <td >700&plusmn;10</td>
      <td >780&plusmn;10</td>
      <td >860&plusmn;10</td>
      <td >&plusmn;10</td>
      <td >980&plusmn;10</td>
      <td >1020&plusmn;10</td>
      <td >&plusmn;10</td>
      <td >1100&plusmn;10</td>
      <td colspan="3" width="6%">1SJ 延时</td>
      <td colspan="2" width="6%"><input name="c1" value="${itemRecs.c1}" recid="${itemRecs.c1id}" type="text"></td>
      <td colspan="4">双风泵打风时间</td>
      <td colspan="2"><input name="d1" value="${itemRecs.d1}" recid="${itemRecs.d1id}" type="text"></td>
      </tr>
    <tr>
      <td class="bge3e3e3">rpm（B型）</td>
      <td >430&plusmn;10</td>
      <td >470&plusmn;10</td>
      <td >545&plusmn;10</td>
      <td >620&plusmn;10</td>
      <td >695&plusmn;10</td>
      <td >430&plusmn;10</td>
      <td >470&plusmn;10</td>
      <td >545&plusmn;10</td>
      <td >620&plusmn;10</td>
      <td >695&plusmn;10</td>
      <td >775&plusmn;10</td>
      <td >810&plusmn;10</td>
      <td >890&plusmn;10</td>
      <td >925&plusmn;10</td>
      <td >960&plusmn;10</td>
      <td >1000&plusmn;10</td>
      <td colspan="5">&nbsp;</td>
      <td colspan="4">&nbsp;</td>
      <td colspan="2">&nbsp;</td>
      </tr>
    <tr>
      <td class="bge3e3e3">时间（min）</td>
      <td>20</td>
      <td>15</td>
      <td>15</td>
      <td>20</td>
      <td>20</td>
      <td>20</td>
      <td>15</td>
      <td>15</td>
      <td>20</td>
      <td>20</td>
      <td>15</td>
      <td>15</td>
      <td>15</td>
      <td>15</td>
      <td>15</td>
      <td>60</td>
      <td colspan="3">联调波动次数</td>
      <td colspan="2"><input name="c2" value="${itemRecs.c2}" recid="${itemRecs.c2id}" type="text"></td>
      <td colspan="4">稳定时间（s）</td>
      <td colspan="2"><input name="d2" value="${itemRecs.d2}" recid="${itemRecs.d2id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">起止时分</td>
      <td><input name="A1a1" value="${itemRecs.A1a1}" recid="${itemRecs.A1a1id}" type="text"></td>
      <td><input name="A1a2" value="${itemRecs.A1a2}" recid="${itemRecs.A1a2id}" type="text"></td>
      <td><input name="A1a3" value="${itemRecs.A1a3}" recid="${itemRecs.A1a3id}" type="text"></td>
      <td><input name="A1a4" value="${itemRecs.A1a4}" recid="${itemRecs.A1a4id}" type="text"></td>
      <td><input name="A1a5" value="${itemRecs.A1a5}" recid="${itemRecs.A1a5id}" type="text"></td>
      <td><input name="A1a6" value="${itemRecs.A1a6}" recid="${itemRecs.A1a6id}" type="text"></td>
      <td><input name="A1a7" value="${itemRecs.A1a7}" recid="${itemRecs.A1a7id}" type="text"></td>
      <td><input name="A1a8" value="${itemRecs.A1a8}" recid="${itemRecs.A1a8id}" type="text"></td>
      <td><input name="A1a9" value="${itemRecs.A1a9}" recid="${itemRecs.A1a9id}" type="text"></td>
      <td><input name="A1a10" value="${itemRecs.A1a10}" recid="${itemRecs.A1a10id}" type="text"></td>
      <td><input name="A1a11" value="${itemRecs.A1a11}" recid="${itemRecs.A1a11id}" type="text"></td>
      <td><input name="A1a12" value="${itemRecs.A1a12}" recid="${itemRecs.A1a12id}" type="text"></td>
      <td><input name="A1a13" value="${itemRecs.A1a13}" recid="${itemRecs.A1a13id}" type="text"></td>
      <td><input name="A1a14" value="${itemRecs.A1a14}" recid="${itemRecs.A1a14id}" type="text"></td>
      <td><input name="A1a15" value="${itemRecs.A1a15}" recid="${itemRecs.A1a15id}" type="text"></td>
      <td><input name="A1a16" value="${itemRecs.A1a16}" recid="${itemRecs.A1a16id}" type="text"></td>
      <td colspan="3">柴油机升速时间</td>
      <td colspan="2"><input name="c3" value="${itemRecs.c3}" recid="${itemRecs.c3id}" type="text"></td>
      <td colspan="4">柴油机降速时间</td>
      <td colspan="2"><input name="d3" value="${itemRecs.d3}" recid="${itemRecs.d3id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">电流（A）</td>
      <td><input name="A2a1" value="${itemRecs.A2a1}" recid="${itemRecs.A2a1id}" type="text"></td>
      <td><input name="A2a2" value="${itemRecs.A2a2}" recid="${itemRecs.A2a2id}" type="text"></td>
      <td><input name="A2a3" value="${itemRecs.A2a3}" recid="${itemRecs.A2a3id}" type="text"></td>
      <td><input name="A2a4" value="${itemRecs.A2a4}" recid="${itemRecs.A2a4id}" type="text"></td>
      <td><input name="A2a5" value="${itemRecs.A2a5}" recid="${itemRecs.A2a5id}" type="text"></td>
      <td><input name="A2a6" value="${itemRecs.A2a6}" recid="${itemRecs.A2a6id}" type="text"></td>
      <td><input name="A2a7" value="${itemRecs.A2a7}" recid="${itemRecs.A2a7id}" type="text"></td>
      <td><input name="A2a8" value="${itemRecs.A2a8}" recid="${itemRecs.A2a8id}" type="text"></td>
      <td><input name="A2a9" value="${itemRecs.A2a9}" recid="${itemRecs.A2a9id}" type="text"></td>
      <td><input name="A2a10" value="${itemRecs.A2a10}" recid="${itemRecs.A2a10id}" type="text"></td>
      <td><input name="A2a11" value="${itemRecs.A2a11}" recid="${itemRecs.A2a11id}" type="text"></td>
      <td><input name="A2a12" value="${itemRecs.A2a12}" recid="${itemRecs.A2a12id}" type="text"></td>
      <td><input name="A2a13" value="${itemRecs.A2a13}" recid="${itemRecs.A2a13id}" type="text"></td>
      <td><input name="A2a14" value="${itemRecs.A2a14}" recid="${itemRecs.A2a14id}" type="text"></td>
      <td><input name="A2a15" value="${itemRecs.A2a15}" recid="${itemRecs.A2a15id}" type="text"></td>
      <td><input name="A2a16" value="${itemRecs.A2a16}" recid="${itemRecs.A2a16id}" type="text"></td>
      <td colspan="3">差示停机</td>
      <td colspan="2"><input name="c4" value="${itemRecs.c4}" recid="${itemRecs.c4id}" type="text"></td>
      <td colspan="4">过流继电器</td>
      <td colspan="2"><input name="d4" value="${itemRecs.d4}" recid="${itemRecs.d4id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">电压（V）</td>
      <td><input name="A3a1" value="${itemRecs.A3a1}" recid="${itemRecs.A3a1id}" type="text"></td>
      <td><input name="A3a2" value="${itemRecs.A3a2}" recid="${itemRecs.A3a2id}" type="text"></td>
      <td><input name="A3a3" value="${itemRecs.A3a3}" recid="${itemRecs.A3a3id}" type="text"></td>
      <td><input name="A3a4" value="${itemRecs.A3a4}" recid="${itemRecs.A3a4id}" type="text"></td>
      <td><input name="A3a5" value="${itemRecs.A3a5}" recid="${itemRecs.A3a5id}" type="text"></td>
      <td><input name="A3a6" value="${itemRecs.A3a6}" recid="${itemRecs.A3a6id}" type="text"></td>
      <td><input name="A3a7" value="${itemRecs.A3a7}" recid="${itemRecs.A3a7id}" type="text"></td>
      <td><input name="A3a8" value="${itemRecs.A3a8}" recid="${itemRecs.A3a8id}" type="text"></td>
      <td><input name="A3a9" value="${itemRecs.A3a9}" recid="${itemRecs.A3a9id}" type="text"></td>
      <td><input name="A3a10" value="${itemRecs.A3a10}" recid="${itemRecs.A3a10id}" type="text"></td>
      <td><input name="A3a11" value="${itemRecs.A3a11}" recid="${itemRecs.A3a11id}" type="text"></td>
      <td><input name="A3a12" value="${itemRecs.A3a12}" recid="${itemRecs.A3a12id}" type="text"></td>
      <td><input name="A3a13" value="${itemRecs.A3a13}" recid="${itemRecs.A3a13id}" type="text"></td>
      <td><input name="A3a14" value="${itemRecs.A3a14}" recid="${itemRecs.A3a14id}" type="text"></td>
      <td><input name="A3a15" value="${itemRecs.A3a15}" recid="${itemRecs.A3a15id}" type="text"></td>
      <td><input name="A3a16" value="${itemRecs.A3a16}" recid="${itemRecs.A3a16id}" type="text"></td>
      <td colspan="3">紧急停机</td>
      <td colspan="2"><input name="c5" value="${itemRecs.c5}" recid="${itemRecs.c5id}" type="text"></td>
      <td colspan="4">接地继电器</td>
      <td colspan="2"><input name="d5" value="${itemRecs.d5}" recid="${itemRecs.d5id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">缸号</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>13</td>
      <td>14</td>
      <td>15</td>
      <td>16</td>
      <td colspan="3">极限停机</td>
      <td colspan="2"><input name="c6" value="${itemRecs.c6}" recid="${itemRecs.c6id}" type="text"></td>
      <td colspan="4">水温继电器</td>
      <td colspan="2"><input name="d6" value="${itemRecs.d6}" recid="${itemRecs.d6id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">压缩压力(MPa)</td>
      <td><input name="B1b1" value="${itemRecs.B1b1}" recid="${itemRecs.B1b1id}" type="text"></td>
      <td><input name="B1b2" value="${itemRecs.B1b2}" recid="${itemRecs.B1b2id}" type="text"></td>
      <td><input name="B1b3" value="${itemRecs.B1b3}" recid="${itemRecs.B1b3id}" type="text"></td>
      <td><input name="B1b4" value="${itemRecs.B1b4}" recid="${itemRecs.B1b4id}" type="text"></td>
      <td><input name="B1b5" value="${itemRecs.B1b5}" recid="${itemRecs.B1b5id}" type="text"></td>
      <td><input name="B1b6" value="${itemRecs.B1b6}" recid="${itemRecs.B1b6id}" type="text"></td>
      <td><input name="B1b7" value="${itemRecs.B1b7}" recid="${itemRecs.B1b7id}" type="text"></td>
      <td><input name="B1b8" value="${itemRecs.B1b8}" recid="${itemRecs.B1b8id}" type="text"></td>
      <td><input name="B1b9" value="${itemRecs.B1b9}" recid="${itemRecs.B1b9id}" type="text"></td>
      <td><input name="B1b10" value="${itemRecs.B1b10}" recid="${itemRecs.B1b10id}" type="text"></td>
      <td><input name="B1b11" value="${itemRecs.B1b11}" recid="${itemRecs.B1b11id}" type="text"></td>
      <td><input name="B1b12" value="${itemRecs.B1b12}" recid="${itemRecs.B1b12id}" type="text"></td>
      <td><input name="B1b13" value="${itemRecs.B1b13}" recid="${itemRecs.B1b13id}" type="text"></td>
      <td><input name="B1b14" value="${itemRecs.B1b14}" recid="${itemRecs.B1b14id}" type="text"></td>
      <td><input name="B1b15" value="${itemRecs.B1b15}" recid="${itemRecs.B1b15id}" type="text"></td>
      <td><input name="B1b16" value="${itemRecs.B1b16}" recid="${itemRecs.B1b16id}" type="text"></td>
      <td colspan="3">油压继电器（停机）</td>
      <td colspan="2"><input name="c7" value="${itemRecs.c7}" recid="${itemRecs.c7id}" type="text"></td>
      <td colspan="4">空转减载</td>
      <td colspan="2"><input name="d7" value="${itemRecs.d7}" recid="${itemRecs.d7id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">爆发压力(MPa)</td>
      <td><input name="B2b1" value="${itemRecs.B2b1}" recid="${itemRecs.B2b1id}" type="text"></td>
      <td><input name="B2b2" value="${itemRecs.B2b2}" recid="${itemRecs.B2b2id}" type="text"></td>
      <td><input name="B2b3" value="${itemRecs.B2b3}" recid="${itemRecs.B2b3id}" type="text"></td>
      <td><input name="B2b4" value="${itemRecs.B2b4}" recid="${itemRecs.B2b4id}" type="text"></td>
      <td><input name="B2b5" value="${itemRecs.B2b5}" recid="${itemRecs.B2b5id}" type="text"></td>
      <td><input name="B2b6" value="${itemRecs.B2b6}" recid="${itemRecs.B2b6id}" type="text"></td>
      <td><input name="B2b7" value="${itemRecs.B2b7}" recid="${itemRecs.B2b7id}" type="text"></td>
      <td><input name="B2b8" value="${itemRecs.B2b8}" recid="${itemRecs.B2b8id}" type="text"></td>
      <td><input name="B2b9" value="${itemRecs.B2b9}" recid="${itemRecs.B2b9id}" type="text"></td>
      <td><input name="B2b10" value="${itemRecs.B2b10}" recid="${itemRecs.B2b10id}" type="text"></td>
      <td><input name="B2b11" value="${itemRecs.B2b11}" recid="${itemRecs.B2b11id}" type="text"></td>
      <td><input name="B2b12" value="${itemRecs.B2b12}" recid="${itemRecs.B2b12id}" type="text"></td>
      <td><input name="B2b13" value="${itemRecs.B2b13}" recid="${itemRecs.B2b13id}" type="text"></td>
      <td><input name="B2b14" value="${itemRecs.B2b14}" recid="${itemRecs.B2b14id}" type="text"></td>
      <td><input name="B2b15" value="${itemRecs.B2b15}" recid="${itemRecs.B2b15id}" type="text"></td>
      <td><input name="B2b16" value="${itemRecs.B2b16}" recid="${itemRecs.B2b16id}" type="text"></td>
      <td colspan="3">油压继电器（卸载）</td>
      <td colspan="2"><input name="c8" value="${itemRecs.c8}" recid="${itemRecs.c8id}" type="text"></td>
      <td colspan="4">过压动作值（V）</td>
      <td colspan="2"><input name="d8" value="${itemRecs.d8}" recid="${itemRecs.d8id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">支管温度(℃)</td>
      <td><input name="B3b1" value="${itemRecs.B3b1}" recid="${itemRecs.B3b1id}" type="text"></td>
      <td><input name="B3b2" value="${itemRecs.B3b2}" recid="${itemRecs.B3b2id}" type="text"></td>
      <td><input name="B3b3" value="${itemRecs.B3b3}" recid="${itemRecs.B3b3id}" type="text"></td>
      <td><input name="B3b4" value="${itemRecs.B3b4}" recid="${itemRecs.B3b4id}" type="text"></td>
      <td><input name="B3b5" value="${itemRecs.B3b5}" recid="${itemRecs.B3b5id}" type="text"></td>
      <td><input name="B3b6" value="${itemRecs.B3b6}" recid="${itemRecs.B3b6id}" type="text"></td>
      <td><input name="B3b7" value="${itemRecs.B3b7}" recid="${itemRecs.B3b7id}" type="text"></td>
      <td><input name="B3b8" value="${itemRecs.B3b8}" recid="${itemRecs.B3b8id}" type="text"></td>
      <td><input name="B3b9" value="${itemRecs.B3b9}" recid="${itemRecs.B3b9id}" type="text"></td>
      <td><input name="B3b10" value="${itemRecs.B3b10}" recid="${itemRecs.B3b10id}" type="text"></td>
      <td><input name="B3b11" value="${itemRecs.B3b11}" recid="${itemRecs.B3b11id}" type="text"></td>
      <td><input name="B3b12" value="${itemRecs.B3b12}" recid="${itemRecs.B3b12id}" type="text"></td>
      <td><input name="B3b13" value="${itemRecs.B3b13}" recid="${itemRecs.B3b13id}" type="text"></td>
      <td><input name="B3b14" value="${itemRecs.B3b14}" recid="${itemRecs.B3b14id}" type="text"></td>
      <td><input name="B3b15" value="${itemRecs.B3b15}" recid="${itemRecs.B3b15id}" type="text"></td>
      <td><input name="B3b16" value="${itemRecs.B3b16}" recid="${itemRecs.B3b16id}" type="text"></td>
      <td colspan="3">曲轴箱压力</td>
      <td colspan="2"><input name="c9" value="${itemRecs.c9}" recid="${itemRecs.c9id}" type="text"></td>
      <td colspan="4">故障发电值（V）</td>
      <td colspan="2"><input name="d9" value="${itemRecs.d9}" recid="${itemRecs.d9id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">总管温度(℃)</td>
      <td><input name="B4b1" value="${itemRecs.B4b1}" recid="${itemRecs.B4b1id}" type="text"></td>
      <td><input name="B4b2" value="${itemRecs.B4b2}" recid="${itemRecs.B4b2id}" type="text"></td>
      <td><input name="B4b3" value="${itemRecs.B4b3}" recid="${itemRecs.B4b3id}" type="text"></td>
      <td><input name="B4b4" value="${itemRecs.B4b4}" recid="${itemRecs.B4b4id}" type="text"></td>
      <td><input name="B4b5" value="${itemRecs.B4b5}" recid="${itemRecs.B4b5id}" type="text"></td>
      <td><input name="B4b6" value="${itemRecs.B4b6}" recid="${itemRecs.B4b6id}" type="text"></td>
      <td><input name="B4b7" value="${itemRecs.B4b7}" recid="${itemRecs.B4b7id}" type="text"></td>
      <td><input name="B4b8" value="${itemRecs.B4b8}" recid="${itemRecs.B4b8id}" type="text"></td>
      <td><input name="B4b9" value="${itemRecs.B4b9}" recid="${itemRecs.B4b9id}" type="text"></td>
      <td><input name="B4b10" value="${itemRecs.B4b10}" recid="${itemRecs.B4b10id}" type="text"></td>
      <td><input name="B4b11" value="${itemRecs.B4b11}" recid="${itemRecs.B4b11id}" type="text"></td>
      <td><input name="B4b12" value="${itemRecs.B4b12}" recid="${itemRecs.B4b12id}" type="text"></td>
      <td><input name="B4b13" value="${itemRecs.B4b13}" recid="${itemRecs.B4b13id}" type="text"></td>
      <td><input name="B4b14" value="${itemRecs.B4b14}" recid="${itemRecs.B4b14id}" type="text"></td>
      <td><input name="B4b15" value="${itemRecs.B4b15}" recid="${itemRecs.B4b15id}" type="text"></td>
      <td><input name="B4b16" value="${itemRecs.B4b16}" recid="${itemRecs.B4b16id}" type="text"></td>
      <td colspan="3">供油齿条刻线</td>
      <td colspan="2"><input name="c10" value="${itemRecs.c10}" recid="${itemRecs.c10id}" type="text"></td>
      <td colspan="4">油马达位置</td>
      <td colspan="2"><input name="d10" value="${itemRecs.d10}" recid="${itemRecs.d10id}" type="text"></td>
    </tr>
    <tr>
      <td rowspan="11" class="bge3e3e3">恒
        功
        率
        特
        性
        调
      整</td>
      <td colspan="2" rowspan="2">柴油机转速（rpm）</td>
      <td colspan="6">主整流柜输出</td>
      <td colspan="8">励磁参数</td>
      <td colspan="4">增压空气压力（KPa）</td>
      <td width="4%" colspan="2">前</td>
      <td width="4%" colspan="2"><input name="H1h1" value="${itemRecs.H1h1}" recid="${itemRecs.H1h1id}" type="text"></td>
      <td width="4%" colspan="2">后</td>
      <td width="4%"><input name="H1h2" value="${itemRecs.H1h2}" recid="${itemRecs.H1h2id}" type="text"></td>
    </tr>
    <tr>
      <td colspan="2">电流（A）</td>
      <td colspan="2">电压（V）</td>
      <td colspan="2">功率（KW）</td>
      <td colspan="2">励磁电流（A）</td>
      <td colspan="2">励磁电压（V）</td>
      <td colspan="2">励磁机励磁电流（A）</td>
      <td colspan="2">测发电机励磁电  流（A）</td>
      <td colspan="4">柴油机转速(rpm)</td>
      <td colspan="4">430&plusmn;10</td>
      <td colspan="3">1000&plusmn;10</td>
    </tr>
    <tr>
      <td colspan="2">430&plusmn;10</td>
      <td colspan="2"><input name="E1e1" value="${itemRecs.E1e1}" recid="${itemRecs.E1e1id}" type="text"></td>
      <td colspan="2"><input name="E1e2" value="${itemRecs.E1e2}" recid="${itemRecs.E1e2id}" type="text"></td>
      <td colspan="2"><input name="E1e3" value="${itemRecs.E1e3}" recid="${itemRecs.E1e3id}" type="text"></td>
      <td colspan="2"><input name="F1f1" value="${itemRecs.F1f1}" recid="${itemRecs.F1f1id}" type="text"></td>
      <td colspan="2"><input name="F1f2" value="${itemRecs.F1f2}" recid="${itemRecs.F1f2id}" type="text"></td>
      <td colspan="2"><input name="F1f3" value="${itemRecs.F1f3}" recid="${itemRecs.F1f3id}" type="text"></td>
      <td colspan="2"><input name="F1f4" value="${itemRecs.F1f4}" recid="${itemRecs.F1f4id}" type="text"></td>
      <td colspan="4">主机油泵出口压力（KPa）</td>
      <td colspan="4"><input name="H2h1" value="${itemRecs.H2h1}" recid="${itemRecs.H2h1id}" type="text"></td>
      <td colspan="3"><input name="H2h2" value="${itemRecs.H2h2}" recid="${itemRecs.H2h2id}" type="text"></td>
    </tr>
    <tr>
    <td colspan="2">700&plusmn;10</td>
      <td colspan="2"><input name="E2e1" value="${itemRecs.E2e1}" recid="${itemRecs.E2e1id}" type="text"></td>
      <td colspan="2"><input name="E2e2" value="${itemRecs.E2e2}" recid="${itemRecs.E2e2id}" type="text"></td>
      <td colspan="2"><input name="E2e3" value="${itemRecs.E2e3}" recid="${itemRecs.E2e3id}" type="text"></td>
      <td colspan="2"><input name="F2f1" value="${itemRecs.F2f1}" recid="${itemRecs.F2f1id}" type="text"></td>
      <td colspan="2"><input name="F2f2" value="${itemRecs.F2f2}" recid="${itemRecs.F2f2id}" type="text"></td>
      <td colspan="2"><input name="F2f3" value="${itemRecs.F2f3}" recid="${itemRecs.F2f3id}" type="text"></td>
      <td colspan="2"><input name="F2f4" value="${itemRecs.F2f4}" recid="${itemRecs.F2f4id}" type="text"></td>
      <td colspan="4">滤清器前机油压力(KPa)</td>
      <td colspan="4"><input name="H3h1" value="${itemRecs.H3h1}" recid="${itemRecs.H3h1id}" type="text"></td>
      <td colspan="3"><input name="H3h2" value="${itemRecs.H3h2}" recid="${itemRecs.H3h2id}" type="text"></td>
    </tr>
    <tr>
     <td colspan="2">850&plusmn;10</td>
      <td colspan="2"><input name="E3e1" value="${itemRecs.E3e1}" recid="${itemRecs.E3e1id}" type="text"></td>
      <td colspan="2"><input name="E3e2" value="${itemRecs.E3e2}" recid="${itemRecs.E3e2id}" type="text"></td>
      <td colspan="2"><input name="E3e3" value="${itemRecs.E3e3}" recid="${itemRecs.E3e3id}" type="text"></td>
      <td colspan="2"><input name="F3f1" value="${itemRecs.F3f1}" recid="${itemRecs.F3f1id}" type="text"></td>
      <td colspan="2"><input name="F3f2" value="${itemRecs.F3f2}" recid="${itemRecs.F3f2id}" type="text"></td>
      <td colspan="2"><input name="F3f3" value="${itemRecs.F3f3}" recid="${itemRecs.F3f3id}" type="text"></td>
      <td colspan="2"><input name="F3f4" value="${itemRecs.F3f4}" recid="${itemRecs.F3f4id}" type="text"></td>
      <td colspan="4">滤清器后机油压力(KPa)</td>
      <td colspan="4"><input name="H4h1" value="${itemRecs.H4h1}" recid="${itemRecs.H4h1id}" type="text"></td>
      <td colspan="3"><input name="H4h2" value="${itemRecs.H4h2}" recid="${itemRecs.H4h2id}" type="text"></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="6">1000&plusmn;10</td>
      <td colspan="2">3000</td>
      <td colspan="2"><input name="E4e1" value="${itemRecs.E4e1}" recid="${itemRecs.E4e1id}" type="text"></td>
      <td colspan="2"><input name="E4e2" value="${itemRecs.E4e2}" recid="${itemRecs.E4e2id}" type="text"></td>
      <td colspan="2"><input name="F4f1" value="${itemRecs.F4f1}" recid="${itemRecs.F4f1id}" type="text"></td>
      <td colspan="2"><input name="F4f2" value="${itemRecs.F4f2}" recid="${itemRecs.F4f2id}" type="text"></td>
      <td colspan="2"><input name="F4f3" value="${itemRecs.F4f3}" recid="${itemRecs.F4f3id}" type="text"></td>
      <td colspan="2"><input name="F4f4" value="${itemRecs.F4f4}" recid="${itemRecs.F4f4id}" type="text"></td>
      <td colspan="4">机 油 末 端 压 力(KPa)</td>
      <td colspan="4"><input name="H5h1" value="${itemRecs.H5h1}" recid="${itemRecs.H5h1id}" type="text"></td>
      <td colspan="3"><input name="H5h2" value="${itemRecs.H5h2}" recid="${itemRecs.H5h2id}" type="text"></td>
    </tr>
    <tr>
      <td colspan="2">3200</td>
      <td colspan="2"><input name="E5e1" value="${itemRecs.E5e1}" recid="${itemRecs.E5e1id}" type="text"></td>
      <td colspan="2"><input name="E5e2" value="${itemRecs.E5e2}" recid="${itemRecs.E5e2id}" type="text"></td>
      <td colspan="2"><input name="F5f1" value="${itemRecs.F5f1}" recid="${itemRecs.F5f1id}" type="text"></td>
      <td colspan="2"><input name="F5f2" value="${itemRecs.F5f2}" recid="${itemRecs.F5f2id}" type="text"></td>
      <td colspan="2"><input name="F5f3" value="${itemRecs.F5f3}" recid="${itemRecs.F5f3id}" type="text"></td>
      <td colspan="2"><input name="F5f4" value="${itemRecs.F5f4}" recid="${itemRecs.F5f4id}" type="text"></td>
      <td colspan="4">前增压器机油压力(KPa)</td>
     <td colspan="4"><input name="H6h1" value="${itemRecs.H6h1}" recid="${itemRecs.H6h1id}" type="text"></td>
      <td colspan="3"><input name="H6h2" value="${itemRecs.H6h2}" recid="${itemRecs.H6h2id}" type="text"></td>
    </tr>
    <tr>
     <td colspan="2">3600</td>
      <td colspan="2"><input name="E6e1" value="${itemRecs.E6e1}" recid="${itemRecs.E6e1id}" type="text"></td>
      <td colspan="2"><input name="E6e2" value="${itemRecs.E6e2}" recid="${itemRecs.E6e2id}" type="text"></td>
      <td colspan="2"><input name="F6f1" value="${itemRecs.F6f1}" recid="${itemRecs.F6f1id}" type="text"></td>
      <td colspan="2"><input name="F6f2" value="${itemRecs.F6f2}" recid="${itemRecs.F6f2id}" type="text"></td>
      <td colspan="2"><input name="F6f3" value="${itemRecs.F6f3}" recid="${itemRecs.F6f3id}" type="text"></td>
      <td colspan="2"><input name="F6f4" value="${itemRecs.F6f4}" recid="${itemRecs.F6f4id}" type="text"></td>
      <td colspan="4">后增压器机油压力(KPa)</td>
      <td colspan="4"><input name="H7h1" value="${itemRecs.H7h1}" recid="${itemRecs.H7h1id}" type="text"></td>
      <td colspan="3"><input name="H7h2" value="${itemRecs.H7h2}" recid="${itemRecs.H7h2id}" type="text"></td>
    </tr>
    <tr>
     <td colspan="2">4000</td>
      <td colspan="2"><input name="E7e1" value="${itemRecs.E7e1}" recid="${itemRecs.E7e1id}" type="text"></td>
      <td colspan="2"><input name="E7e2" value="${itemRecs.E7e2}" recid="${itemRecs.E7e2id}" type="text"></td>
      <td colspan="2"><input name="F7f1" value="${itemRecs.F7f1}" recid="${itemRecs.F7f1id}" type="text"></td>
      <td colspan="2"><input name="F7f2" value="${itemRecs.F7f2}" recid="${itemRecs.F7f2id}" type="text"></td>
      <td colspan="2"><input name="F7f3" value="${itemRecs.F7f3}" recid="${itemRecs.F7f3id}" type="text"></td>
      <td colspan="2"><input name="F7f4" value="${itemRecs.F7f4}" recid="${itemRecs.F7f4id}" type="text"></td>
      <td colspan="4">燃油压力(KPa)</td>
      <td colspan="4"><input name="H8h1" value="${itemRecs.H8h1}" recid="${itemRecs.H8h1id}" type="text"></td>
      <td colspan="3"><input name="H8h2" value="${itemRecs.H8h2}" recid="${itemRecs.H8h2id}" type="text"></td>
    </tr>
    <tr>
     <td colspan="2">4400</td>
      <td colspan="2"><input name="E8e1" value="${itemRecs.E8e1}" recid="${itemRecs.E8e1id}" type="text"></td>
      <td colspan="2"><input name="E8e2" value="${itemRecs.E8e2}" recid="${itemRecs.E8e2id}" type="text"></td>
      <td colspan="2"><input name="F8f1" value="${itemRecs.F8f1}" recid="${itemRecs.F8f1id}" type="text"></td>
      <td colspan="2"><input name="F8f2" value="${itemRecs.F8f2}" recid="${itemRecs.F8f2id}" type="text"></td>
      <td colspan="2"><input name="F8f3" value="${itemRecs.F8f3}" recid="${itemRecs.F8f3id}" type="text"></td>
      <td colspan="2"><input name="F8f4" value="${itemRecs.F8f4}" recid="${itemRecs.F8f4id}" type="text"></td>
      <td colspan="4">机油温度(℃)</td>
      <td colspan="4"><input name="H9h1" value="${itemRecs.H9h1}" recid="${itemRecs.H9h1id}" type="text"></td>
      <td colspan="3"><input name="H9h2" value="${itemRecs.H9h2}" recid="${itemRecs.H9h2id}" type="text"></td>
    </tr>
    <tr>
     <td colspan="2">4800</td>
      <td colspan="2"><input name="E9e1" value="${itemRecs.E9e1}" recid="${itemRecs.E9e1id}" type="text"></td>
      <td colspan="2"><input name="E9e2" value="${itemRecs.E9e2}" recid="${itemRecs.E9e2id}" type="text"></td>
      <td colspan="2"><input name="F9f1" value="${itemRecs.F9f1}" recid="${itemRecs.F9f1id}" type="text"></td>
      <td colspan="2"><input name="F9f2" value="${itemRecs.F9f2}" recid="${itemRecs.F9f2id}" type="text"></td>
      <td colspan="2"><input name="F9f3" value="${itemRecs.F9f3}" recid="${itemRecs.F9f3id}" type="text"></td>
      <td colspan="2"><input name="F9f4" value="${itemRecs.F9f4}" recid="${itemRecs.F9f4id}" type="text"></td>
      <td colspan="4">冷却水温度(℃)</td>
      <td colspan="4"><input name="H10h1" value="${itemRecs.H10h1}" recid="${itemRecs.H10h1id}" type="text"></td>
      <td colspan="3"><input name="H10h2" value="${itemRecs.H10h2}" recid="${itemRecs.H10h2id}" type="text"></td>
    </tr>
    <tr>
      <td class="bge3e3e3">故障功率调整</td>
      <td colspan="2">1000&plusmn;10</td>
      <td colspan="2">4800</td>
 	  <td colspan="2"><input name="g1" value="${itemRecs.g1}" recid="${itemRecs.g1id}" type="text"></td>
      <td colspan="2"><input name="g2" value="${itemRecs.g2}" recid="${itemRecs.g2id}" type="text"></td>
      <td colspan="2"><input name="g3" value="${itemRecs.g3}" recid="${itemRecs.g3id}" type="text"></td>
      <td colspan="2"><input name="g4" value="${itemRecs.g4}" recid="${itemRecs.g4id}" type="text"></td>
      <td colspan="2"><input name="g5" value="${itemRecs.g5}" recid="${itemRecs.g5id}" type="text"></td>
      <td colspan="2"><input name="g6" value="${itemRecs.g6}" recid="${itemRecs.g6id}" type="text"></td>
      <td colspan="11">&nbsp;</td>
    </tr>
    <tr>
      <td class="bge3e3e3">平稳启动调整</td>
      <td colspan="8"><input name="i1" value="${itemRecs.i1}" recid="${itemRecs.i1id}" type="text"></td>
      <td colspan="3">空磨拆检情况</td>
      <td colspan="3">第一次负磨拆检情况</td>
      <td colspan="3">第二次负磨拆检情况</td>
      <td colspan="5">第三次负磨拆检情况</td>
      <td colspan="5">试验记事</td>
    </tr>
    <tr>
      <td rowspan="2" class="bge3e3e3">绝缘电阻测定</td>
      <td colspan="2">测定日期</td>
      <td colspan="2">主电路/地</td>
      <td colspan="2">控制电路/地</td>
      <td colspan="2">主/控制电路</td>
      <td colspan="3" rowspan="2"><input name="k1" value="${itemRecs.k1}" recid="${itemRecs.k1id}" type="text"></td>
      <td colspan="3" rowspan="2"><input name="k2" value="${itemRecs.k2}" recid="${itemRecs.k2id}" type="text"></td>
      <td colspan="3" rowspan="2"><input name="k3" value="${itemRecs.k3}" recid="${itemRecs.k3id}" type="text"></td>
      <td colspan="5" rowspan="2"><input name="k4" value="${itemRecs.k4}" recid="${itemRecs.k4id}" type="text"></td>
      <td colspan="5" rowspan="2"><input name="o1" value="${itemRecs.o1}" recid="${itemRecs.o1id}" type="text"></td>
    </tr>
    <tr>
    <td colspan="2"><input name="j1" value="${itemRecs.j1}" recid="${itemRecs.j1id}" type="text"></td>
    <td colspan="2"><input name="j2" value="${itemRecs.j2}" recid="${itemRecs.j2id}" type="text">M&Omega;</td>
    <td colspan="2"><input name="j3" value="${itemRecs.j3}" recid="${itemRecs.j3id}" type="text">M&Omega;</td>
    <td colspan="2"><input name="j4" value="${itemRecs.j4}" recid="${itemRecs.j4id}" type="text">M&Omega;</td>
    </tr>
   
  </table> 
  <input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
  <input type="hidden" id="expId" value="${expId}"/>
  <input type="hidden" id="roleFlag" value="${roleFlag}"/>
  <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>
  