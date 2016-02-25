<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <title>考试系统</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/json2.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script type="text/javascript">
	var timer;
	$(document).ready(function(){
		String.prototype.trim = function(){
		    return this.replace(/(^[\\s]*)|([\\s]*$)/g, "");
		}
		$("#simulate").bind('click',function(){
			$("#mid").removeAttr("style");
			$("#points").attr("style","border: 1px solid black; height: 200px; width: 660px;");
			$("#pager").attr("style","border: 1px solid black; height: 90px; width:660px; margin: 5px 0 0 0;")
			$("#start").html("重新出题");
			$("#example").html("<div style='background-color: #D9E3EC;height: 20px;float: left;margin: 5px 5px 0px 0px;'><span>当前答题</span></div>"
							  +"<div style='background-color: #3366CC;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>未作答题</span></div>"
							  +"<div style='background-color: #168498;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>已作答题</span></div>"
							  +"<div style='background-color: #8AD150;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>正确答题</span></div>"
							  +"<div style='background-color: #C72003;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>错误答题</span></div>")
			$.post("examin!ajaxExaminQuestionList.do",{},
				function(data){
					if(data != ""){
						var result = eval("("+data+")");
				        var datas = result.datas;
				        var userId = result.userId;
				        var minutes = result.minutes;
				        var secondes = result.secondes;
				        var m,s;
				        if(minutes == "" && secondes == ""){
				        	//自动从服务端校准个人考试时间
							m = getCookie(userId+"m");   
							s = getCookie(userId+"s"); 
				        }else{
				        	clearTimeout(timer);
				        	$("#currTime").html("");
				        	m = minutes;
				        	s = secondes;
				        }
			        	Change(userId, m, s);
				        //参数
				        var type = result.type;
				        var pageNow = result.pageNext;
				        var pageFirst = result.pageFirst;
				        var pageLast = result.rowCount;
			        	var rowCount = result.rowCount;
			        	var initAnswer = result.initAnswer;
			        	var initAnswerStr = JSON.stringify(initAnswer);
			        	var initAnswerObj = eval("("+initAnswerStr+")");
			        	//将参数保存在页面隐藏域
			        	$("#type").val(type);
			        	$("#pageNow").val(pageNow);
			        	$("#pageLast").val(pageLast);
			        	$("#pageFirst").val(pageFirst);
				        $("#rowCount").val(rowCount);
				        $("#initAnswer").val(initAnswerStr);
				        //初始化页面
				        var questionStr = "";
				        var answerStr = "";
				        var pageString = "";
				        var pagerString = "";
				        if(datas.length > 0){
				            for(var i = 0;i < datas.length; i++){
				            	questionStr += "<table><tr><td><span>"+ pageNow +"."+ datas[i].question +"</span></td></tr></table>";
								answerStr += "<table>"
											+"<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>A."+ datas[i].chooseA +"</span></td></tr>"
											+"<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
											+"<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
											+"<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
											+"</table>";
								pageString += "<table><tr>";
								if(parseInt(pageNow) > parseInt(pageFirst)){
									pageString += "<td><button onclick='prePage();'><span>上一题</span></button></td>";
								}
								if(parseInt(pageNow) < parseInt(pageLast)){
									pageString += "<td><button onclick='nextPage();'><span>下一题</span></button></td>";
								}
								pageString += "<td><button onclick='overExamin();'><span>交&nbsp;&nbsp;&nbsp;&nbsp;卷</span></button></td><td><span id='currTime'></span></td></tr></table>"
								
				            }
				            for(var j=1; j<= rowCount; j++){
				            	if(parseInt(pageNow) == j){
				            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswer[j].id +","+ initAnswer[j].order +")'><font color='black' >"+ initAnswer[j].order +"</a></font></div>"
				            	}else{
					            	//错误之处
				            		//pagerString += "<div style='height: 20px;width: 20px;background-color: #3366CC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswer[j].id +","+ initAnswer[j].order +")'><font color='white' >"+ initAnswer[j].order +"</a></font></div>"
				            	}
				            }
				        }else{
				        	top.Dialog.alert("题库为空请添加！");
				            questionStr += "<table><tr><td><font size='5' style='margin:'>题库为空请添加！</font></td></tr></table>";
				            pagerString += "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>题库为空请添加！</font></div></td></tr></table>"
				            clearTimeout(timer);
							$("#currTime").html("");
				        }
				        $("#mid").removeAttr("style");
				        //清空页面
				        $("#question").html("");
				        $("#answer").html("");
				        $("#page").html("");
				        $("#pager").html("");
				        $("#expres").html("");
				        //动态加载页面 
				        $("#answer").html(answerStr);
				        $("#page").html(pageString);
			    	}else{
			    		top.Dialog.alert("非考试人员！");
				    	var questionStr = "<table><tr><td><font size='5' style='margin:'>非考试人员！</font></td></tr></table>";
					    var pagerString = "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>非考试人员！</font></div></td></tr></table>"
			    	}
			    	$("#question").html(questionStr);
					$("#pager").html(pagerString);
			})
		});
		
		//我的错题
		$("#userWrongItem").bind('click',function(){
			$("#mid").removeAttr("style");
			$("#start").html("开始考试");
			$("#points").attr("style","border: 1px solid black; height: 200px; width: 660px;");
			$("#pager").attr("style","border: 1px solid black; height: 90px; width:660px; margin: 5px 0 0 0;")
			$("#example").html("<div style='background-color: #D9E3EC;height: 20px;float: left;margin: 5px 5px 0px 0px;'><span>当前答题</span></div>"
							  +"<div style='background-color: #3366CC;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>未作答题</span></div>"
							  +"<div style='background-color: #168498;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>已作答题</span></div>"
							  +"<div style='background-color: #8AD150;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>正确答题</span></div>"
							  +"<div style='background-color: #C72003;height: 20px;float: left;margin: 5px 5px 0px 5px;'><span>错误答题</span></div>")
			$.post("examin!ajaxUserExaminQuestionList.do",{},
				function(data){
					var pagerString = "";
				    var pointString = "";
			        if(data != ""){
			        	var result = eval("("+data+")");
				        var examinQuestionArry = result.datas;
				        var firstExamin = result.firstExamin;
						pointString += "<div style='height: 200px;width:300px; float: left;'>"
		 							 +"<div id='question' style='margin: 20px 0px 0px 20px;'><table><tr><td><span>"+ firstExamin.question +"</span></td></tr></table></div>"
		 							 +"<div id='page' style='margin: 55px 0px 0px 20px;'></div>"
		 							 +"</div>"
		 							 +"<div style='height: 200px;width:300px; float: left;margin-left:50px;'>"
		 							 +"<div id='answer' style='margin: 20px 0px 0px 20px;'>"
		 							 +"<table>"
									 +"<tr><td><span>A."+ firstExamin.chooseA +"</span></td></tr>"
									 +"<tr><td><span>B."+ firstExamin.chooseB +"</span></td></tr>"
									 +"<tr><td><span>C."+ firstExamin.chooseC +"</span></td></tr>"
									 +"<tr><td><span>D."+ firstExamin.chooseD +"</span></td></tr>"
									 +"</table>"
		 							 +"</div>"
		 							 +"<div id='expres' style='margin: 10px 0px 0px 20px;float:left;'>"
		 							 +"<table><tr><td>该题的正确答案：" + firstExamin.answer + "</td></tr></table>"
		 							 +"</div>"
		 							 +"</div>"
		 				for(var i = 0;i < examinQuestionArry.length; i++){
		 					pagerString += "<div style='height: 20px;width: 20px;background-color: #C72003; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='userWrongExaminShow("+ examinQuestionArry[i] +");'><font color='white' >"+ parseInt(i+1) +"</a></font></div>"
		            	}
			        	$("#examinTime").html("");
			        	$("#currTime").html("");
			        }else{
			        	top.Dialog.alert("最近没有考试记录！");
			        	pointString += "<div style='height: 200px;width:300px; float: left;'>"
		 							 +"<div id='question' style='margin: 20px 0px 0px 20px;'><table><tr><td><font size='5'>最近没有考试记录！</font></td></tr></table></div>"
		 							 +"<div id='page' style='margin: 55px 0px 0px 20px;'></div>"
		 							 +"</div>"
		 							 +"<div style='height: 200px;width:300px; float: left;margin-left:50px;'>"
		 							 +"<div id='answer' style='margin: 20px 0px 0px 20px;'>"
		 							 +"</div>"
		 							 +"<div id='expres' style='margin: 10px 0px 0px 20px;float:left;'>"
		 							 +"</div>"
		 							 +"</div>"
					    pagerString += "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>最近没有考试记录！</font></div></td></tr></table>"
			        }
			        $("#points").html(pointString);
			        $("#pager").html(pagerString);
			})
			clearTimeout(timer);
			$("#currTime").html("");
		})
	})
	
	
	function userWrongExaminShow(examinId){
		$.post("examin!ajaxWorngExamin.do",{"id":examinId},
			function(data){
		        var result = eval("("+data+")");
		        var datas = result.datas;
		        var pointStr = "";
	            for(var i = 0;i < datas.length; i++){
					pointStr += "<div style='height: 200px;width:300px; float: left;'>"
	 							 +"<div id='question' style='margin: 20px 0px 0px 20px;'><table><tr><td><span>"+ datas[i].question +"</span></td></tr></table></div>"
	 							 +"<div id='page' style='margin: 60px 0px 0px 20px;'></div>"
	 							 +"</div>"
	 							 +"<div style='height: 200px;width:300px; float: left;margin-left:50px;'>"
	 							 +"<div id='answer' style='margin: 20px 0px 0px 20px;'>"
	 							 +"<table>"
								 +"<tr><td><span>A."+ datas[i].chooseA +"</span></td></tr>"
								 +"<tr><td><span>B."+ datas[i].chooseB +"</span></td></tr>"
								 +"<tr><td><span>C."+ datas[i].chooseC +"</span></td></tr>"
								 +"<tr><td><span>D."+ datas[i].chooseD +"</span></td></tr>"
								 +"</table>"
	 							 +"</div>"
	 							 +"<div id='expres' style='margin: 10px 0px 0px 20px;float:left;'>"
	 							 +"<table><tr><td>该题的正确答案：" + datas[i].answer + "</td></tr></table>"
	 							 +"</div>"
	 							 +"</div>"
	            }
		        $("#points").html(pointStr);
		    }
		);
	}
	
	function goPage(id, order){
		//参数
        var type = $("#type").val();
        var pageNow = order;
        var pageFirst = $("#pageFirst").val();
        var pageLast = $("#pageLast").val();
       	var rowCount = $("#rowCount").val();
       	var initAnswer = $("#initAnswer").val();
		var initAnswerObj = eval("("+initAnswer+")");
		$("#pageNow").val(pageNow);
		$.post("examin!ajaxWorngExamin.do",{"id":id},
			function(data){
		        var result = eval("("+data+")");
		        var datas = result.datas;
		        var questionStr = "";
		        var answerStr = "";
		        var answerOfPage = "";
		        var answerOfPageByOrder = "";
		        var pageString = "";
		        var pagerString = "";
		        if(datas.length > 0){
		            for(var i = 0;i < datas.length; i++){
		            	answerOfPage = initAnswerObj[pageNow].answer;
		            	questionStr += "<table><tr><td><span>"+ pageNow +"."+ datas[i].question +"</span></td></tr></table>";
						answerStr += "<table>"
									if(answerOfPage != "false"){
										if(answerOfPage == "A"){
											answerStr += "<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}
										if(answerOfPage == "B"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}
										if(answerOfPage == "C"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}
										if(answerOfPage == "D"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}
									}else{
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>A."+ datas[i].chooseA +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
									}
									answerStr += "</table>";
						pageString += "<table><tr>";
						if(parseInt(pageNow) > parseInt(pageFirst)){
							pageString += "<td><button onclick='prePage();'><span>上一题</span></button></td>";
						}
						if(parseInt(pageNow) < parseInt(pageLast)){
							pageString += "<td><button onclick='nextPage();'><span>下一题</span></button></td>";
						}
						pageString += "<td><button onclick='overExamin();'><span>交&nbsp;&nbsp;&nbsp;&nbsp;卷</span></button></td><td><span id='currTime'></span></td></tr></table>"
						
		            }
		            for(var j=1; j<=rowCount; j++){
		            	answerOfPageByOrder = initAnswerObj[j].answer;
		            	if(answerOfPageByOrder == "false" && pageNow != parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #3366CC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='white'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder == "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder != "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else{
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #168498; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}
		            }
		        }else{
		        	top.Dialog.alert("题库为空请添加！");
		            questionStr += "<table><tr><td><font size='5' style='margin:'>题库为空请添加！</font></td></tr></table>";
			        pagerString += "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>题库为空请添加！</font></div></td></tr></table>"
		        }
		        $("#mid").removeAttr("style");
		        $("#question").html(questionStr);
		        $("#answer").html(answerStr);
		        $("#page").html(pageString);
		        $("#pager").html(pagerString);		        
		        if(answerOfPage != "false"){
		        	$("#expres").html("<table><tr><td>已选择:"+ answerOfPage +"</td></tr></table>");
		        }else{
		        	$("#expres").html("");
		        }
		    }
		);
	}
		
	function prePage(){
		//参数
        var type = $("#type").val();
        var pageNext = $("#pageNow").val();
        var pageFirst = $("#pageFirst").val();
        var pageLast = $("#pageLast").val();
       	var rowCount = $("#rowCount").val();
       	var initAnswer = $("#initAnswer").val();
		var initAnswerObj = eval("("+initAnswer+")");
		//当前页 
		var pageNow = parseInt(pageNext)- parseInt(1);
		$("#pageNow").val(pageNow);
		//上一题的ID
		var examinid = initAnswerObj[pageNow].id;
		$.post("examin!ajaxWorngExamin.do",{"id":examinid},
			function(data){
		        var result = eval("("+data+")");
		        var datas = result.datas;
		        var questionStr = "";
		        var answerStr = "";
		        var answerOfPage = "";
		        var answerOfPageByOrder = "";
		        var pageString = "";
		        var pagerString = "";
		        if(datas.length > 0){
		            for(var i = 0;i < datas.length; i++){
		            	answerOfPage = initAnswerObj[pageNow].answer;
		            	questionStr += "<table><tr><td><span>"+ pageNow +"."+ datas[i].question +"</span></td></tr></table>";
						answerStr += "<table>"
									if(answerOfPage != "false"){
										if(answerOfPage == "A"){
											answerStr += "<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}
										if(answerOfPage == "B"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}
										if(answerOfPage == "C"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}
										if(answerOfPage == "D"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}
									}else{
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>A."+ datas[i].chooseA +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
									}
									answerStr += "</table>";
						pageString += "<table><tr>";
						if(parseInt(pageNow) > parseInt(pageFirst)){
							pageString += "<td><button onclick='prePage();'><span>上一题</span></button></td>";
						}
						if(parseInt(pageNow) < parseInt(pageLast)){
							pageString += "<td><button onclick='nextPage();'><span>下一题</span></button></td>";
						}
						pageString += "<td><button onclick='overExamin();'><span>交&nbsp;&nbsp;&nbsp;&nbsp;卷</span></button></td><td><span id='currTime'></span></td></tr></table>"
						
		            }
		            for(var j=1; j<=rowCount; j++){
		            	answerOfPageByOrder = initAnswerObj[j].answer;
		            	if(answerOfPageByOrder == "false" && pageNow != parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #3366CC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='white'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder == "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder != "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else{
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #168498; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}
		            }
		        }else{
		        	top.Dialog.alert("题库为空请添加！");
		            questionStr += "<table><tr><td><font size='5' style='margin:'>题库为空请添加！</font></td></tr></table>";
			        pagerString += "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>题库为空请添加！</font></div></td></tr></table>"
		        }
		        $("#mid").removeAttr("style");
		        $("#question").html(questionStr);
		        $("#answer").html(answerStr);
		        $("#page").html(pageString);
		        $("#pager").html(pagerString);		        
		        if(answerOfPage != "false"){
		        	$("#expres").html("<table><tr><td>已选择:"+ answerOfPage +"</td></tr></table>");
		        }else{
		        	$("#expres").html("");
		        }
		    }
		);
	}
	
	function nextPage(){
		//参数
        var type = $("#type").val();
        var pagePre = $("#pageNow").val();
        var pageFirst = $("#pageFirst").val();
        var pageLast = $("#pageLast").val();
       	var rowCount = $("#rowCount").val();
       	var initAnswer = $("#initAnswer").val();
		var initAnswerObj = eval("("+initAnswer+")");
		//当前页 
		var pageNow = parseInt(pagePre)+ parseInt(1);
		$("#pageNow").val(pageNow);
		//下一题的ID
		var examinid = initAnswerObj[pageNow].id;
		$.post("examin!ajaxWorngExamin.do",{"id":examinid},
			function(data){
		        var result = eval("("+data+")");
		        var datas = result.datas;
		        var questionStr = "";
		        var answerStr = "";
		        var answerOfPage = "";
		        var answerOfPageByOrder = "";
		        var pageString = "";
		        var pagerString = "";
		        if(datas.length > 0){
		            for(var i = 0;i < datas.length; i++){
		            	answerOfPage = initAnswerObj[pageNow].answer;
		            	questionStr += "<table><tr><td><span>"+ pageNow +"."+ datas[i].question +"</span></td></tr></table>";
						answerStr += "<table>"
									if(answerOfPage != "false"){
										if(answerOfPage == "A"){
											answerStr += "<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");' /><span>A."+ datas[i].chooseA +"</span></td></tr>"
										}
										if(answerOfPage == "B"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										}
										if(answerOfPage == "C"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										}
										if(answerOfPage == "D"){
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' checked='checked' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}else{
											answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
										}
									}else{
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='A' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>A."+ datas[i].chooseA +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='B' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>B."+ datas[i].chooseB +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='C' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>C."+ datas[i].chooseC +"</span></td></tr>"
										answerStr +="<tr><td><input type='radio' name='choose' value='"+ datas[i].id +"' title='D' onclick='isTrue("+ initAnswerObj[pageNow].order +");'/><span>D."+ datas[i].chooseD +"</span></td></tr>"
									}
									answerStr += "</table>";
						pageString += "<table><tr>";
						if(parseInt(pageNow) > parseInt(pageFirst)){
							pageString += "<td><button onclick='prePage();'><span>上一题</span></button></td>";
						}
						if(parseInt(pageNow) < parseInt(pageLast)){
							pageString += "<td><button onclick='nextPage();'><span>下一题</span></button></td>";
						}
						pageString += "<td><button onclick='overExamin();'><span>交&nbsp;&nbsp;&nbsp;&nbsp;卷</span></button></td><td><span id='currTime'></span></td></tr></table>"
						
		            }
		            for(var j=1; j<=rowCount; j++){
		            	answerOfPageByOrder = initAnswerObj[j].answer;
		            	if(answerOfPageByOrder == "false" && pageNow != parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #3366CC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='white'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder == "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else if(answerOfPageByOrder != "false" && pageNow == parseInt(initAnswerObj[j].order)){
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #D9E3EC; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}else{
		            		pagerString += "<div style='height: 20px;width: 20px;background-color: #168498; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='goPage("+ initAnswerObj[j].id +","+ initAnswerObj[j].order +")'><font color='black'>"+ j +"</font></div>"
		            	}
		            }
		        }else{
		        	top.Dialog.alert("题库为空请添加！");
		            questionStr += "<table><tr><td><font size='5' style='margin:'>题库为空请添加！</font></td></tr></table>";
			        pagerString += "<table><tr><td><div style='margin: 15px 0px 5px 20px;'><font size='5'>题库为空请添加！</font></div></td></tr></table>"
		        }
		        $("#mid").removeAttr("style");
		        $("#question").html(questionStr);
		        $("#answer").html(answerStr);
		        $("#page").html(pageString);
		        $("#pager").html(pagerString);		        
		        if(answerOfPage != "false"){
		        	$("#expres").html("<table><tr><td>已选择:"+ answerOfPage +"</td></tr></table>");
		        }else{
		        	$("#expres").html("");
		        }
		    }
		);
	}
	
	function isTrue(order){
		var initAnswer = $("#initAnswer").val();
		var initAnswerObj = eval("("+initAnswer+")");
		var myAnswer = $("input[name='choose']:checked").attr('title');
		var examinid = $("input[name='choose']:checked").val();
		var expreStr = "";
		initAnswerObj[order].answer = myAnswer;
    	expreStr = "<table><tr><td>我的答案：" + myAnswer + "</td></tr></table><div>";
		$("#initAnswer").val(JSON.stringify(initAnswerObj));
		$("#expres").html(expreStr);
	}
	
	function wrongExaminShow(examinId, sequence){
		$.post("examin!ajaxWorngExamin.do",{"id":examinId},
			function(data){
		        var result = eval("("+data+")");
		        var datas = result.datas;
		        var pointStr = "";
	            for(var i = 0;i < datas.length; i++){
					pointStr += "<div style='height: 200px;width:300px; float: left;'>"
	 							 +"<div id='question' style='margin: 20px 0px 0px 20px;'><table><tr><td><span>"+sequence+"."+ datas[i].question +"</span></td></tr></table></div>"
	 							 +"<div id='page' style='margin: 100px 0px 0px 20px;'></div>"
	 							 +"</div>"
	 							 +"<div style='height: 200px;width:30 0px; float: left;margin-left:50px;'>"
	 							 +"<div id='answer' style='margin: 20px 0px 0px 20px;'>"
	 							 +"<table>"
								 +"<tr><td><span>A."+ datas[i].chooseA +"</span></td></tr>"
								 +"<tr><td><span>B."+ datas[i].chooseB +"</span></td></tr>"
								 +"<tr><td><span>C."+ datas[i].chooseC +"</span></td></tr>"
								 +"<tr><td><span>D."+ datas[i].chooseD +"</span></td></tr>"
								 +"</table>"
	 							 +"</div>"
	 							 +"<div id='expres' style='margin: 10px 0px 0px 20px;float:left;'></div>"
	 							 +"<table><tr><td>该题的正确答案：" + datas[i].answer + "</td></tr></table>"
	 							 +"</div>"
	            }
		        $("#points").html(pointStr);
		    }
		);
	}
	
	//交卷
	function overExamin(){
		var initAnswer = $("#initAnswer").val();
		var rowCount = $("#rowCount").val();
		$.post("examin!ajaxExaminOver.do",{"initAnswer":initAnswer,"rowCount":rowCount},
			function(data){
				var result = eval("("+data+")");
				var points = result.points;
				var examins = result.examins;
		        var pagerString = "";
	         	for(var i = 0;i < examins.length; i++){
		        	if(examins[i].value == "1" ){
		        		pagerString += "<div style='height: 20px;width: 20px;background-color: #8AD150; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='wrongExaminShow("+ examins[i].id +","+ parseInt(i+1) +");'><font color='white' >"+ parseInt(i+1) +"</a></font></div>"
		        	}else{
		        		pagerString += "<div style='height: 20px;width: 20px;background-color: #C72003; float: left; margin: 5px 0px 5px 5px; text-align: center;' onclick='wrongExaminShow("+ examins[i].id +","+ parseInt(i+1) +");'><font color='white' >"+ parseInt(i+1) +"</a></font></div>"
		        	}
		        }
		        $("#pager").html(pagerString);
				var pointsStr = "<div style='margin:100px 0px 0px 150px;'><font size='6'>您的答题正确率为:"+ points +"</font></div>";
				$("#points").html(pointsStr);
			}
		);
		clearTimeout(timer);
	}
	
	function Change(userId, m, s) {
		var mi = parseInt(m);           
		var si = parseInt(s) - 1;   
		if (si < 0) {                 
			si = 60 + si;                 
			mi = mi - 1;             
		}
		if(mi > 0){
			document.getElementById("currTime").innerHTML = parseInt(m) + "分" + parseInt(s) + "秒"; 
			setCookie( userId +"m", mi);
			setCookie( userId +"s", si);
			timer = setTimeout(function(){                 
				Change(userId, mi, si);             
			}, 1000); 
		} 
		if(mi == 0){
			overExamin();
		}      
	}

	function setCookie(name, value) { 
	    var argv = setCookie.arguments; 
	    var argc = setCookie.arguments.length; 
	    var expires = (argc > 2) ? argv[2] : null; 
	    if(expires!=null){ 
	        var LargeExpDate = new Date (); 
	        LargeExpDate.setTime(LargeExpDate.getTime() + (expires*1000*60));         
	    } 
	    document.cookie = name + "=" + escape (value)+((expires == null) ? "" : ("; expires=" +LargeExpDate.toGMTString())); 
	}

	function getCookie(Name){ 
	    var search = Name + "=" 
	    if(document.cookie.length > 0){ 
	        offset = document.cookie.indexOf(search) 
	        if(offset != -1){ 
	            offset += search.length 
	            end = document.cookie.indexOf(";", offset) 
	            if(end == -1) end = document.cookie.length 
	            return unescape(document.cookie.substring(offset, end)) 
	        } 
	        else return "" 
	    } 
	} 

  
	function deleteCookie(name) { 
        var expdate = new Date(); 
        expdate.setTime(expdate.getTime() - (86400 * 1000 * 1)); 
	    setCookie(name, "", expdate); 
	}
		

	
</script>
	<!--框架必需end-->
  </head>
 <body>
 	<input type="hidden" id="type" value=""/>
 	<input type="hidden" id="pageNow" value=""/>
 	<input type="hidden" id="pageFirst" value=""/>
 	<input type="hidden" id="pageLast" value=""/>
 	<input type="hidden" id="rowCount" value=""/>
 	<input type="hidden" id="initAnswer" value=""/>
 	<div class="box1" panelWidth="700" panelHeight="465" style="margin:auto;">
	 	<div style="height: 100px;">
	 		<div style="float: left;" class="msg_icon4" ><span>理论考试系统</span></div>
			<div style="float: left; padding: 30px 10px 30px 10px;"><button id="simulate"><span id="start">开始考试</span></button></div>
			<div style="float: left; padding: 30px 10px 30px 10px;"><button id="userWrongItem"><span>我的错题</span></button></div>
			<font style="float: left; padding: 30px 10px 30px 5px;" id="currTime" size="3px;" color="#C72003;" ></font>
	 	</div>
	 	<div style="background-image: url('plant/image/examination_index.jpg;');height: 330px;" id="mid">
	 		<div id="points">
	 			<div style="height: 200px;width:300px; float: left;">
	 				<div style="margin: 20px 0px 0px 20px;" id="question"></div>
	 				<div style="margin: 60px 0px 0px 20px;" id="page" ></div>
	 			</div>
	 			<div style="height: 200px;width:300px; float: left;margin-left:50px;">
	 				<div style="margin: 20px 0px 0px 20px;" id="answer" ></div>
	 				<div style="margin: 10px 0px 0px 20px;" id="expres" ></div>
	 			</div>
	 		</div>
	 		<div id="pager">
			</div>
			<div id="example">
			</div>
	 	</div>
 	</div>
</body>
</html>