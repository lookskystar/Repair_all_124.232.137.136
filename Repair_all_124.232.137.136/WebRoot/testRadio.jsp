<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>testRadio.jsp</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
  </head>
  
  <body>
  <form action="" name="form1">
  <table border="1" id="playList">
  <tr><td><input type="radio" name="test1" /></td><td>小辅修</td></tr>
  <tr><td><input type="radio" name="test2" /></td><td>中修</td></tr>
  <tr><td><input type="radio" name="test3" /></td><td>配件维修</td></tr>
  <tr><td><input type="radio" name="test4" /></td><td>月修</td></tr>
  <!-- 
  <tr><td><input type="button" id="selectAll" name="selectAll" value="全选" onclick="selAll(true);" /></td>
  <td><input type="button" id="unSelect" name="unSelect" value="全不选" onclick="selAll(false);" />
  <input type="button" id="reverse" name="reverse" value="反选" onclick="selAll();" />
  </td></tr>
   -->
   <tr><td><input type="button" id="selectAll" name="selectAll" value="全选" /></td>
  <td><input type="button" id="unSelect" name="unSelect" value="全不选" />
  <input type="button" id="reverse" name="reverse" value="反选" />
  </td></tr>
  </table>
  </form>
 <script type="text/javascript">
 $(function () {  
	 $("#selectAll").click(function () {//全选  
	 	$("#playList :input").attr("checked", true);  
	 });  
	 $("#unSelect").click(function () {//全不选  
	 	$("#playList :input").attr("checked", false);  
	 });  
	 $("#reverse").click(function () {//反选  
		$("#playList :input").each(function () {  
	 $(this).attr("checked", !$(this).attr("checked"));  
	 	});  
	 });  
});  
	  
 function selAll(flag){
 	/*document.form1.test1.checked = true;
 	document.form1.test2.checked = true;
 	document.form1.test3.checked = true;
 	document.form1.test4.checked = true;
 	*/
  	var radios = document.getElementsByTagName('input');
	for(var i = 0;i < radios.length;i++){
		//å¨é
		if(flag==true)
			radios[i].checked = true;
		//å¨ä¸é
		else if(flag==false)
			radios[i].checked = false;
		//åé
		else{
			if(radios[i].checked == false)
				radios[i].checked = true;
			else
				radios[i].checked = false
		}
	}
		
  }

 </script>  
  </body>
 
</html>
