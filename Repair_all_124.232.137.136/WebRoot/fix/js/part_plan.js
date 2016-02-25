/**
 * 选择一个配件做检修
 */
$(function() {
	//选择动态配件供日计划的检修
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
				$.post("partFixAction!choicePJDynamic.do", {
					'pjdids' : pjdidStr,
					'planId' : planId
				}, function(data) {
					if (data == "success") {
						top.Dialog.alert("操作成功");
					} else {
						top.Dialog.alert("操作失败");
					}
					window.location.href="partFixAction!datePlanList.do";
				}, 'text');
			}
		}
		
	})
}) 

//选择一个动态配件做检修
function choicePJFix(pjdid,pjNum){
	if(pjNum.length==0){
		top.Dialog.alert("当前配件还没编码编码，请生成编码后再检修");
	}else{
		top.Dialog.confirm("您确定检修当前配件吗？",function(){
			$.post("partFixAction!choicePJFix.do", {
				"pjdid" : pjdid,
			}, function(data) {
				if (data == "success") {
					top.Dialog.alert("操作成功", function() {
						window.location.reload()
					})
				} else {
					top.Dialog.alert("操作失败");
				}
			}, "text");
		});
	}
}

 function inputByHand(pjdid){
		var diag = new top.Dialog();
			diag.Title = "输入配件编号信息";
			diag.Width = "400px";
			diag.Height = 150;
			diag.URL = "fix/inputByHand.jsp";
			diag.ShowButtonRow = true;
			diag.OkButtonText = "确 定 ";
			diag.OKEvent = function() {
				var doc = diag.innerFrame.contentWindow.document;
				var pjNum = doc.getElementById("pjNum").value;
				if(pjNum==""){
					top.Dialog.alert("配件编号不能为空!");
				}else{
					$.post("partFixAction!createPJNum.do",{"pjdid":pjdid,"pjNum":pjNum},function(data){
						top.Dialog.alert(data, function() {
							window.location.reload()
						})
					});
					diag.close();
				}
			};
			diag.show();
		}

function createFacNumAuto(pjdid){
	top.Dialog.confirm("确定要自动生成编号吗?",function(){
		$.post("partFixAction!createPJNum.do",{"pjdid":pjdid},function(data){
				top.Dialog.alert(data, function() {
					window.location.reload()
				})
		  });
	});
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
