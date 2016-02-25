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
			$.post("experiment!changeExpItemRec.do",{recId:recId,itemVal:val},function(data){
				top.Dialog.alert(data,function(){
					window.location.reload();
				});
			},"text");
		}else{
			if($.trim(val).length>0){
				$.post("experiment!signExpItem.do",{itemName:name,itemVal:val,rjhmId:rjhmId,expId:expId,roleFlag:roleFlag},function(data){
					if(data=="success"){
						//top.Dialog.alert("操作成功");
						$.messager.show(0, '保存成功', 1000);
					}else{
						top.Dialog.alert("操作失败");
					}
				},"text");
			}
		}
		
	});
	
	$("input[flat=date]").blur(function(){
		var val = $(this).val();
		var name = $(this).attr("name");
		var rjhmId = $("#rjhmId").val();
		var expId = $("#expId").val();
		var roleFlag = $("#roleFlag").val();
		var recId = $(this).attr("recid");
		//alert("试验项目记录id："+recId);
		if(recId.length>0){
			$.post("experiment!changeExpItemRec.do",{recId:recId,itemVal:val},function(data){
				top.Dialog.alert(data,function(){
					window.location.reload();
				});
			},"text");
		}else{
			if($.trim(val).length>0){
				$.post("experiment!signExpItem.do",{itemName:name,itemVal:val,rjhmId:rjhmId,expId:expId,roleFlag:roleFlag},function(data){
					if(data=="success"){
						//top.Dialog.alert("操作成功");
						$.messager.show(0, '保存成功', 1000);
					}else{
						top.Dialog.alert("操作失败");
					}
				},"text");
			}
		}
		
	});
	
	$("textarea").change(function(){
		var val = $(this).val();
		var name = $(this).attr("name");
		var rjhmId = $("#rjhmId").val();
		var expId = $("#expId").val();
		var roleFlag = $("#roleFlag").val();
		var recId = $(this).attr("recid");
		//alert("试验项目记录id："+recId);
		if(recId.length>0){
			$.post("experiment!changeExpItemRec.do",{recId:recId,itemVal:val},function(data){
				top.Dialog.alert(data,function(){
					window.location.reload();
				});
			},"text");
		}else{
			if($.trim(val).length>0){
				$.post("experiment!signExpItem.do",{itemName:name,itemVal:val,rjhmId:rjhmId,expId:expId,roleFlag:roleFlag},function(data){
					if(data=="success"){
						top.Dialog.alert("保存成功");
					}else{
						top.Dialog.alert("保存失败");
					}
				},"text");
			}
		}
		
	})
});
	
//保存试验时间
function changeExpTime(){
	var time = $("#sytime").val();
	var rjhmId = $("#rjhmId").val();
	var expId = $("#expId").val();
	$.post("experiment!signExpTime.do",{rjhmId:rjhmId,expId:expId,time:time},function(data){
		if(data=="success"){
			top.Dialog.alert("提交成功",function(){
				window.location.reload();
			});
		}
	},"text");
}

/**
 * 全签
 */
function signAll(){
	var rjhmId = $("#rjhmId").val();
	var expId = $("#expId").val();
	var roleFlag = $("#roleFlag").val();
	$.post("experiment!signItemAll.do",{rjhmId:rjhmId,expId:expId,roleFlag:roleFlag},function(data){
		top.Dialog.alert(data,function(){
			window.location.reload();
		});
	},"text");
}
