function getByType(a_type){
	if(a_type == ""){
		alert("类型为空！"); 
	} else {
		$.ajax({
			url:basePath+"listByJcType.do",
			dataType:"json",
			method:"post",
			data:{"jcType":a_type},
			success:function(data){
				var code = data.code.value;
				var result = data.result;
				if(code == 0){
					$("#dictTable").html("");
					$.each(result,function(key,value){
						var dayRunKilo = value.dayRunKilo;
						if($.type(dayRunKilo) == "undefined"){
							dayRunKilo = 0;
						}
						var registRant = value.registRant;
						if($.type(registRant) == "undefined"){
							registRant = "无登记人";
						}
						$("#dictTable").append("<tr>"+
								"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value=''/></td>"+
								"<td width='70' align='center' class='jc_runId'><span  class='jc_runId2'>"+value.runId+"</span></td>"+
								"<td width='90' align='center'><span>"+registRant+"</span></td>"+
								"<td width='80' align='center'><span>"+value.jcType+"</span></td>"+
								"<td width='90' align='center'><span>"+value.jcNum+"</span></td>"+
								"<td width='90' align='center'><span>"+dayRunKilo+"</span></td>"+
								"<td width='100' align='center'><span class='img_edit hand' title='修改'></span><span class='img_delete hand' title='删除'></span></td>"+
							"</tr>");
					});
					$(".img_delete").bind("click",function(){
//						alert($(this).parent().parent().children(".jc_runId").find(".jc_runId2").html());
						deleteById($(this).parent().parent().children(".jc_runId").find(".jc_runId2").html(),a_type);
					});
				} else if(code == -2){
					alert("无此型号的机车信息");
				}
			}
		});
	}
}

function getByTypeAndNum(a_num,a_type){
	if(a_type == ""){
		alert("类型为空！");
	} else if(a_num == ""){
		alert("请输入机车编号")
	}else {
		$.ajax({
			url:basePath+"listByJcTypeAndJcNum.do",
			dataType:"json",
			method:"post",
			data:{"jcType":a_type,"jcNum":a_num},
			success:function(data){
				var code = data.code.value;
				var result = data.result;
				if(code == 0){
					$("#dictTable").html("");
					$.each(result,function(key,value){
						var dayRunKilo = value.dayRunKilo;
						if($.type(dayRunKilo) == "undefined"){
							dayRunKilo = 0;
						}
						var registRant = value.registRant;
						if($.type(registRant) == "undefined"){
							registRant = "无登记人";
						}
						$("#dictTable").append("<tr>"+
								"<td width='25' align='center'><input id='dictId' name='dict' type='checkbox' value=''/></td>"+
								"<td width='70' align='center' class='jc_runId'><span  class='jc_runId2'>"+value.runId+"</span></td>"+
								"<td width='90' align='center'><span>"+registRant+"</span></td>"+
								"<td width='80' align='center'><span>"+value.jcType+"</span></td>"+
								"<td width='90' align='center'><span>"+value.jcNum+"</span></td>"+
								"<td width='90' align='center'><span>"+dayRunKilo+"</span></td>"+
								"<td width='100' align='center'><span class='img_edit hand' title='修改'></span><span class='img_delete hand' title='删除'></span></td>"+
							"</tr>");
					});
					$(".img_delete").bind("click",function(){
//						alert($(this).parent().parent().children(".jc_runId").find(".jc_runId2").html());
						deleteById($(this).parent().parent().children(".jc_runId").find(".jc_runId2").html(),a_type);
					});
				} else if(code == -2){
					alert("找不到所查询的信息");
				}
			}
		});
	}
}


function deleteById(a_runId,a_type){
	if(a_runId == "" || a_runId == 0){
		alert("找不到此机车");
	} else {
		$.ajax({
			url:basePath+"jcDelete.do",
			dataType:"json",
			method:"post",
			data:{"runId":a_runId},
			success:function(data){
				var code = data.code.value;
				var result = data.result;
				if(code == 0){
					alert("OK");
					getByType(a_type);
				} else if(code == -5){
					alert("没有此机车信息");
				}
			}
		});
	}
}

function addJc123(a_jcType,a_jcNum,a_dayRunKilo,a_minorRunKilo,a_smaRunKilo,a_midRunKilo,a_larRunKilo,a_totalRunKilo,a_registRant){
	$.ajax({
		url:basePath+"jcInsert.do",
		dataType:"json",
		method:"post",
		data:{"jcType":a_jcType,"jcNum":a_jcNum,"dayRunKilo":a_dayRunKilo,
		"minorRunKilo":a_minorRunKilo,"smaRunKilo":a_smaRunKilo,"midRunKilo":a_midRunKilo,
		"larRunKilo":a_larRunKilo,"totalRunKilo":a_totalRunKilo,"registRant":a_registRant},
		success:function(data){
			var code = data.code.value;
			var result = data.result;
			if(code == 0){
				alert("添加成功");
			} else {
				alert("添加失败");
			}
		}
	});
}