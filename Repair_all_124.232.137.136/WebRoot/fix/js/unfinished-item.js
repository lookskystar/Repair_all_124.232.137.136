/**
 * 有关操作配件检修的js代码
 */
$(function() {
	$("#sign_inspection").click(function() {
		var itemArr = new Array();
		$("input[name='itemcheck']:checked").each(function(index,data){
			itemArr.push(data.value);
		});
		if(itemArr.length==0){
			top.Dialog.alert("请选择检修项目");
		}else{
			var items = itemArr.join(",");
			var diag = new top.Dialog();
			diag.Title = "签认检查项目";
			diag.Width = "400px";
			diag.Height = 200;
			diag.URL = 'fix/sign/signInspectionDialog.jsp';
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定";
			diag.OKEvent = function() {
				var flag = true;
				var doc = diag.innerFrame.contentWindow.document;
				var obj=doc.getElementById("pj_status");
				var pj_status=$(obj).attr("editValue");
				if(pj_status==undefined){
					pj_status=doc.getElementById("pj_status").value;
				}
				//var pjStatus = $.trim(doc.getElementById("pj_status").value);
				$.post("partFixAction!signFixItem.do", {
					'records' : items,
					'status' : pj_status,
					'roleFlag' : 1
				}, function(data) {
					top.Dialog.alert(data, function() {
						window.location.reload()
					})
				}, 'text');
				diag.close();
			};
			diag.show();
		}
	
	});
	
	//签认检测项目
	$("input[name='fix_status']").blur(function(){
		var detectValue = $(this).val();
		var itemArr = $(this).attr("id");
		var userName = $("#userName").val();
		var valArr = itemArr.split(",");
		var recId = valArr[0];
		var minVal = valArr[1];
		var maxVal = valArr[2];
		var reg = /^-?[0-9]*(\.[0-9]+)?(\*-?[0-9]*(\.[0-9]+)?)?$/;
		if(detectValue!=null && detectValue!=""){
			if(!reg.test(detectValue)){
				top.Dialog.alert("测量值只能输入数值和*号，请重新输入！");
				$(this).val("");
			}else{
				var result = checkMinMax(minVal,maxVal,detectValue);
				if(result=='success'){
					$.post("partFixAction!signDetectItem.do", {
						'recId' : recId,
						'status' : detectValue
					}, function(data) {
						$.messager.show(0,data,5000);
						$("#fix"+recId).text(userName);//把当前用户的名字动态加入到检修员栏目
					}, 'text');
				}else{
					top.Dialog.alert(result);
					$(this).val("");
					return false;
				}
			}
		}
	});
	
	function signItem(obj){
	    	var detectValue = $(obj).val();
			var itemArr = $(obj).attr("id");
			var userName = $("#userName").val();
			var valArr = itemArr.split(",");
			var recId = valArr[0];
			var minVal = valArr[1];
			var maxVal = valArr[2];
			var reg = /^-?[0-9]*(\.[0-9]+)?(\*-?[0-9]*(\.[0-9]+)?)?$/;
			if(!reg.test(detectValue)){
				top.Dialog.alert("测量值只能输入数值和*号，请重新输入！");
				$(obj).val("");
			}else{
				var result = checkMinMax(minVal,maxVal,detectValue);
				if(result=='success'){
					$.post("partFixAction!signDetectItem.do", {
						'recId' : recId,
						'status' : detectValue
					}, function(data) {
						$.messager.show(0,data,5000);
						$("#fix"+recId).text(userName);//把当前用户的名字动态加入到检修员栏目
					}, 'text');
				}else{
					top.Dialog.alert(result);
					$(obj).val("");
					return false;
				}
			}
	    }
	
	//判断最大最小值和所填值的比较
	function checkMinMax(minVal,maxVal,detValue){
		var min;
		var max;
		detValue = parseFloat(detValue);
		if(minVal.length>0){//存在最小值
			min = parseFloat(minVal);
			if(maxVal.length>0){
				max = parseFloat(maxVal);
				if(detValue<min || detValue>max){
					return "所填测量值不在该检测项目的标准范围内";
				}else{
					return "success";
				}
			}else{
				if(detValue<min){
					return "所填测量值不在该检测项目的标准范围内";
				}else{
					return "success";
				}
			}
		}else{//不存在最小值
			if(maxVal.length>0){
				max = parseFloat(maxVal);
				if(detValue > max){
					return "所填测量值不在该检测项目的标准范围内";
				}else{
					return "success";
				}
			}else{
				return "success";
			}
		}
		
	}
	
	//除工人外其他用户的签认
	$("#sign_item").click(function() {
		var itemArr = new Array();
		$("input[name='itemcheck']:checked").each(function(index,data){
			itemArr.push(data.value);
		});
		if(itemArr.length==0){
			top.Dialog.alert("请选择检修项目");
		}else{
			var items = itemArr.join(",");
			var roleFlag = $("#role_flag").val();
			$.post("partFixAction!signFixItem.do", {
				'records' : items,
				'roleFlag' : roleFlag
			}, function(data) {
				top.Dialog.alert(data, function() {
					window.location.reload()
				})
			}, 'text');
		}
	});
	

	/**
	 * 报活
	 */
	$(".create_predict").click(
		function() {
			var diag = new top.Dialog();
			diag.Title = "报活";
			diag.Width = "400px";
			diag.Height = 280;
			diag.URL = "fix/createPredict.jsp";
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定 ";
			var memberId = $(this).attr("id");
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var approve = doc.getElementsByName("approve");
				var approveVal = 0;
				for(var i=0;i<approve.length;i++){
					if(approve[i].checked){
						approveVal = approve[i].value;
					}
				}
				var desc = $.trim(doc.getElementById("description").value);
				var bzSelect = doc.getElementById("bz_select");
				var bzId = bzSelect.options[bzSelect.selectedIndex].value;
				var bzName = bzSelect.options[bzSelect.selectedIndex].text;
				var flag = true;

				if(desc == null || desc.length==0){
					alert("报活故障描述不能为空")
					flag = false;
				}
				if(flag == true){
					$.post("partServiceAction!createPredict.do", {
						'member.id' : memberId,
						'member.name' : name,
						'member.sex' : sex,
						'member.enterDate' : enterDate,
						'member.phone' : phone,
						'member.departmentId' : departId,
						'member.departmentName' : departName
					}, function(data) {
						if (data == 'success') {
							top.Dialog.alert("操作成功", function() {
								window.location.reload()
							})
						} else {
							top.Dialog.alert("操作失败");
						}
					}, 'text')
					diag.close();
				}
			};
			diag.show();
	});
	

	$("#choice_pjds").click(function(){
		var pjdids = new Array();
		$('input[name="checkbox"]:checked').each(function(index,pj){
			pjdids.push(pj.value);
		})	
		var amount = eval($("#part_amount").val());
		var selectNum = pjdids.length;
		if(selectNum==0){
			top.Dialog.alert("请选择配件");
		}else{
			if(selectNum>amount){
				top.Dialog.alert("所选择的配件个数大于需要选择的个数"); 
			}else{
				var pjdidStr = pjdids.join(",");
				var planId = $("#plan_id").val();
				$.post("partServiceAction!choicePJDynamic.do", {
					'pjdids' : pjdidStr,
					'planId' : planId
				}, function(data) {
					if (data == "success") {
						top.Dialog.alert("操作成功");
					} else {
						top.Dialog.alert("操作失败");
					}
					window.location.href="partPlanAction!findAllPartPlan.do";
				}, 'text');
			}
		}
		
	})
})

//输入组装配件的编号
function inputNumber(recId, type){
	var diag = new top.Dialog();
	diag.Title = "输入组装配件的编号";
	diag.Width = "500px";
	diag.Height = 400;
	//diag.URL = 'fix/sign/addPJNum.jsp';
	diag.URL = 'partFixAction!inputPJNumInit.do?recId='+recId;
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定";
	diag.OKEvent = function() {
		var flag = true;
		var doc = diag.innerFrame.contentWindow.document;
		//var pjNumber = $.trim(doc.getElementById("pjNumber").value);
	   var pjNums=[];
	   var array=doc.getElementsByName("pjNum");
	   var len=array.length;
	   for(var i=0;i<len;i++){
		   if(array[i].value!=""){
			   pjNums.push(array[i].value);
		   }
	   }
	   if(pjNums.length!=len){
		   top.Dialog.alert("编号不能为空!");
	   }else{
		  var pjNum=pjNums.join(",");
		  $.post("partFixAction!inputPJNum.do", {
			'recId' : recId,
			'pjNumber' : pjNum
		}, function(data) {
			top.Dialog.alert(data, function() {
				window.location.reload();
			});
		}, 'text');
		diag.close();
	   }
	};
	diag.show();
}
function pjNumUpdate(pjRecId,type,pJNum){
	var diag = new top.Dialog();
	diag.Title = "修改配件编号信息";
	diag.Width = "500px";
	diag.Height = 400;
	diag.URL = "partFixAction!pjNumUpdateInput.do?pjRecId="+pjRecId+"&pJNum="+pJNum+"&type="+type;
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定";
	diag.OKEvent = function() {
		var flag = true;
		var doc = diag.innerFrame.contentWindow.document;
		var pjNumsOld = doc.getElementById("pjNumsOld").value;
		var pjNums=[];
	   var array=doc.getElementsByName("pjNum");
	   var len=array.length;
	   for(var i=0;i<len;i++){
		   if(array[i].value!=""){
			   pjNums.push(array[i].value);
		   }
	   }
	   if(pjNums.length!=len){
		   top.Dialog.alert("编号不能为空!");
	   }else{
		   for(var i = 0; i < pjNums.length-1; i++ ){
	   	       for(var j = 0; j < pjNums.length-i-1; j++){
	   	       	   if(pjNums[j] == pjNums[j+1]){
	   	       	       top.Dialog.alert("所填编号不能相同 !");
	   	       	       flag = false;
	   	       	       break;
	   	       	   }
	   	       }
	   	       if(flag){
	   	           continue;
	   	       }else{
	   	       	   break;
	   	       }
	   	   }
		 if(flag){
		   var pjNum=pjNums.join(",");
		  $.post("partFixAction!pjNumUpdate.do", {
			'pjRecId' : pjRecId,
			'pjNum' : pjNum,
			'pjNumsOld' : pjNumsOld
		}, function(data) {
			if(data == "success"){
	   	   	   top.Dialog.alert("操作成功!",function(){
	   	   			window.location.reload();
	   	   	   });
	   	   	   diag.close(); 	   
	   	   }else if(data.indexOf("noexist") >=0 ){
	   	       var array=data.split("-");
	   	       top.Dialog.alert("存在找不到的配件编号!");
	   	       $("input[name=pjNum]").each(function(i){
				    if(i==array[1]){
				    	$(this).css({border:"1px solid red"});
				    }
   			   });
	   	   }
		
		}, 'text');
	   }
	   }
	};
	diag.show();
}
//工长签认已经填写了检测项目值的检测项目
function leadSignDetectItem(recId,detVal){
	$.post("partFixAction!signDetectItem.do", {
		'recId' : recId,
		'status' : detVal
	}, function(data) {
		window.location.reload();
	}, 'text');
}

function choicePj(pjsid){
	var diag = new top.Dialog();
	diag.Title = "给日计划选择确定检修的动态配件";
	diag.Width = "400px";
	diag.Height = "100px";
	diag.URL = "partPlanAction!pjDynamicInfoList.do";
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定 ";
	var memberId = $(this).attr("id");
	diag.OKEvent = function() {
		var doc = diag.innerFrame.contentWindow.document;
		var username = $.trim(doc.getElementById("m_username").value);
		var password = $.trim(doc.getElementById("m_password").value);
		var flag = true;
		if (username == null || username.length == 0) {
			alert("岗位名字不能为空");
			flag = false;
		}
		if (password == null || password.length == 0) {
			alert("密码不能为空");
			flag = false;
		}
		if (flag == true) {
			$.post("assSystemSettings!assignMemberAccount.do", {
				'member.id' : memberId,
				'member.username' : username,
				'member.password' : password
			}, function(data) {
				if (data == 'success') {
					top.Dialog.alert("帐号分配成功", function() {
						window.location.reload()
					})
				} else {
					top.Dialog.alert("操作失败");
				}
			}, 'text')
			diag.close();
		}
	}
	diag.show();
}

/**
 * 报活
 */
function createPredict(recordId){
	var diag = new top.Dialog();
	diag.Title = "报活";
	diag.Width = "400px";
	diag.Height = 280;
	diag.URL = "fix/createPredict.jsp";
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定 ";
	var memberId = $(this).attr("id");
	diag.OKEvent = function() {
		var doc = diag.innerFrame.contentWindow.document;
		var approve = doc.getElementsByName("approve");
		var approveVal = 0;
		for(var i=0;i<approve.length;i++){
			if(approve[i].checked){
				approveVal = approve[i].value;
			}
		}
		var desc = $.trim(doc.getElementById("description").value);
		var bzSelect = doc.getElementById("bz_select");
		var bzId = bzSelect.options[bzSelect.selectedIndex].value;
		var bzName = bzSelect.options[bzSelect.selectedIndex].text;
		var flag = true;

		if(desc == null || desc.length==0){
			alert("报活故障描述不能为空")
			flag = false;
		}
		if(flag == true){
			$.post("partFixAction!createPredict.do", {
				'pjFixRecord.pjRecId' : recordId,
				'bzId' : bzId,
				'bzName' : bzName,
				'approve' : approveVal,
				'description' : desc
			}, function(data) {
				if (data == 'success') {
					top.Dialog.alert("操作成功", function() {
						window.location.reload()
					})
				} else {
					top.Dialog.alert("操作失败");
				}
			}, 'text')
			diag.close();
		}
	};
	diag.show();
}

//时间转字符串方法
function StringToDate(DateStr)  
{   
    var converted = Date.parse(DateStr);  
    var myDate = new Date(converted);  
    if (isNaN(myDate))  
    {   
        //var delimCahar = DateStr.indexOf('/')!=-1?'/':'-';  
        var arys= DateStr.split('-');  
        myDate = new Date(arys[0],--arys[1],arys[2]);  
    }  
    return myDate;  
} 
