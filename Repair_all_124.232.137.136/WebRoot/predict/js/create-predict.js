/**
 * 有关操作报活的js代码 
 */

/**
 * 报活
 */
function createPredict(predictId){
	var diag = new top.Dialog();
	diag.Title = "签认";
	diag.Width = "500px";
	diag.Height = 320;
	diag.URL = 'partFixAction!workerList.do';
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定";
	diag.OKEvent = function() {
		var flag = true;
		var doc = diag.innerFrame.contentWindow.document;
		var userRadio = doc.getElementsByName("userRadio");
		var userid;
		var uname;
		for(var i=0;i<userRadio.length;i++){
			if(userRadio[i].checked){
				userid = userRadio[i].value;
				uname = userRadio[i].id;
			}
		}
		$.post("partFixAction!assignPredict.do", {
			'predictId' : predictId,
			'userId' : userid,
			'userName' : uname
		}, function(data) {
			top.Dialog.alert(data, function() {
				window.location.reload()
			})
		}, 'text');
		diag.close();
	};
	diag.show();
}

/**
 * 调度审批报活（指派给某个班组）
 * @param {Object} predictId 报活id
 */
function choiceBZ(predictId){
	var diag = new top.Dialog();
	diag.Title = "选择班组";
	diag.Width = "300px";
	diag.Height = 320;
	diag.URL = 'partFixAction!toChoiceBZ.do';
	diag.ShowButtonRow = true;
	diag.OkButtonText = "确 定";
	diag.OKEvent = function() {
		var flag = true;
		var doc = diag.innerFrame.contentWindow.document;
		var bzRadio = doc.getElementsByName("bzRadio");
		var bzid;
		var bzname;
		for(var i=0;i<bzRadio.length;i++){
			if(bzRadio[i].checked){
				bzid = bzRadio[i].value;
				bzname = bzRadio[i].id;
			}
		}
		$.post("partFixAction!choiceBZ.do", {
			'predictId' : predictId,
			'bzId' : bzid,
			'bzName' : bzname
		}, function(data) {
			top.Dialog.alert(data, function() {
				window.location.reload()
			})
		}, 'text');
		diag.close();
	};
	diag.show();
}

/**
 *报活签认 
 * @param {Object} predictId 报活id
 * @param {Object} flag 标识：1工人、2工长
 */
function signPredict(predictId,flag){
	$.post("partFixAction!signPredict.do", {
		'predictId' : predictId,
		'flag':flag
	}, function(data) {
		top.Dialog.alert(data, function() {
			window.location.reload()
		})
	}, 'text');
}
