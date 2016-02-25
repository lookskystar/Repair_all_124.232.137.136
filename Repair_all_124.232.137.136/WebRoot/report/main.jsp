<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>机车检修查询条件窗口</title>
<link href="<%=basePath %>css/test.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/tree/dtree/dtree.css" type="text/css" rel="stylesheet" />
<!-- 浮动js -->
<script type="text/javascript" src="<%=basePath %>js/test.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/tree/dtree/dtree.js"></script>
<script language="JavaScript" type="text/javascript">
			
function renovate(url, name){
	var substance = document.getElementById('substance');
	if(substance != undefined && url != null && url.length > 0) {
		if(url.indexOf("?")>=0)
			url+="&"+Math.random();
		else
			url+="?"+Math.random();
		substance.src = url;
	}
	
	if ('2' == '2' && (url.indexOf('enterApp=FI') > -1 || url.indexOf('fi.alisoft.com') > -1)) {
		mainbody.css('border-bottom=1px solid #4677b5,border-top=1px solid #4677b5,width=1030px,float=left,margin-left=-35px,_margin-left=0');
		mainbottom.hidden();
		iframe1.css('width=1030px,height=480px,float=left');
	} else {
		mainbody.css('border-bottom=0px,border-top=0px,width=958px,float=none,margin-left=0px');
		mainbottom.show();
		iframe1.css('width=938px,height=480px,float=none,margin-left=10px');
	}
	if(KB.bom.ie=='6.0'){
		mainbody.css('margin-left=0');
	}
	return false;
}


function setWinH(){
	SetWinHeight(document.getElementById('substance'));
}

 function SetWinHeight(obj){
      try {
      	var win=obj;
		var h = 0;
       if (document.getElementById) {
			if (win && !window.opera) {
				if (win.contentDocument && win.contentDocument.body.offsetHeight) {
					win.style.height = win.contentDocument.body.offsetHeight;
					h=win.contentDocument.body.offsetHeight;
				} else if(win.Document && win.Document.body.scrollHeight) {
					win.style.height = win.Document.body.scrollHeight;
					h=win.Document.body.scrollHeight;
				} else {
					h=win.contentDocument.body.offsetHeight;
				}
			} else {
				//win.height = 600;
			}
       } else {
		//win.height = 600;
	   }

		h = parseInt(h);
		iframe1.css('height='+h+'px');
      } catch (e) {
	     //win.height = 600;
      }
 }
function init(){
	var navs ;
	/*--初始导航--*/
	var navs = new KB('ul@nav:li');
	/*--初始导航--*/
	var debugx = 0;
	var debugInt = true;
	/*--解决IE6下背景图片加载缓慢问题--*/
	if(KB.bom.ie=='6.0'){
       try{
         document.execCommand("BackgroundImageCache", false, true);
        }catch(e){}
    }
	
	for(var i=0; i<navs.nod.length; i++){
		if(KB.isNode('subnav_'+navs.nod[i].id)){
			var pos = KB.getPos(navs.nod[i]);
			var x = parseInt(pos.x)-160;
			if(debugInt){
				if(x<110){
					debugx = 110-x;	
				}
				if(x>120){
					debugx = 120-x;
				}
				debugInt = false;
			}
			x = x+debugx+'px';
			var y = 45+'px';
			var s = new KB('dl=subnav_'+navs.nod[i].id);
			s.css('position=absolute,left='+x+',top='+y);
		}
		(function(i,k){
				 	KB.reg(k.nod[i],'mouseover',function(){
														 		if(k.nod[i].className=="nav_active")return;
																new KB('div@header').css('position=relative');
																if(KB.isNode('subnav_'+k.nod[i].id)){
																	var s = new KB('dl=subnav_'+k.nod[i].id);
																	s.show();
																	k.nod[i].className='vor';
																}
															}); 
					KB.reg(k.nod[i],'mouseout',function(){
														 		new KB('div@header').css('position=static');
																if(k.nod[i].className=="nav_active")return;
																if(KB.isNode('subnav_'+k.nod[i].id)){
																	var s = new KB('dl=subnav_'+k.nod[i].id);
																	s.hidden();
																	k.nod[i].className='';
																}
															});
				 })(i,navs);	
	}
	//KB.regHover(navs,'','','mainmenu_1_on',changeMenu);
	/*--初始top链接切换--*/
	navs = new KB('dl@top_right:li');
	KB.regHover(navs,'','','margin10',DHchange);
	navs = new KB('div=topnav1:div');
	KB.regHover(navs,'top_nav_hover','','');
	navs = new KB('div=topnav2:div');
	KB.regHover(navs,'top_nav_hover','','');
	 /*--初始ShortCut快捷方式--*/
	ShortCut.cut = new KB('div@shortcut');
	var f = ShortCut.cut.getChild('*');
	for(var i=0; i<f.length; i++){
		(function(i){
				  KB.reg(f[i],'mouseover',ShortCut.show);
				  })(i);	
	}
	var scubtn = new KB('b=short_cu');
	ShortCut.cuBtn = scubtn.nod[0];
	ShortCut.title1 = '开启前端显示';
	ShortCut.title2 = '关闭前端显示';
	ShortCut.cutBtn = new KB('div=shortcut_btn');
	scubtn.show();
	ShortCut.init();
	tips.width=80;
	tips.xdebug = 140;
}
//KB.ready(init);
function openTopnav(num,t){
	if(t){
		new KB('div=topnav'+num).show();
	}else{
		new KB('div=topnav'+num).hidden();
	}
}
</script>
<script type="text/javascript">
	try{
		if(top.location != self.location) {
		   //top.location.href = 'home.jspa';
		}
	}catch(e){}
	
	//合并表格的单元格
	function cellMege(col){
		var lines=$('#datatabel tr').size();
		if(lines<=2) return ;
	}

//	$(function(){
//		  d = new dTree('d');//创建一个树对象   
//         d.add(0,-1,'机务检修系统'); //创建一个树对象 
//         d.add(1,0,'机车检修管理','<%=basePath %>report/select_main.jsp');
//         d.add(2,0,'配件检修管理','#');
//         d.add(3,0,'配件周转管理','#');
//         d.add(4,0,'技术标准管理','#');
//         d.add(5,0,'机车技术管理','#');
//         d.add(6,0,'检修车间管理','#');
//         d.add(7,0,'综合查询统计','<%=basePath %>report/select_main.jsp');
//         $('#tt').append(d.toString());
//	});
</script>
</head>

<body bgcolor="#f8f7f7">
<form id="form1" name="form1" method="post" action="">
<!--top end-->
<div class="top" id="top" style="display:none">
  <!--top_right begin-->
  <dl class="top_right">
    <dd>
      <ul>
      
        <li style="position: static;" class=""><a onclick="openTopnav(1,true)" href="javascript:void(0)">系统设置</a><b class="icon9"></b>
          <div id="topnav1" class="top_nav" style="display: none;">
            <h2><a onclick="openTopnav(1,true)" href="javascript:void(0)">系统设置</a><b class="icon9"></b></h2>
            <div><a onclick="openUrlToNewPage('#','初始设置');'return false';" href="javascript:void(0)">初始设置</a></div>
            <iframe frameborder="0" style="z-index:-1; position:absolute; top:0; left:0; width:100px; height:140px; opacity:0; filter:alpha(opacity=0)"></iframe>
          </div>
        </li>
        <li class="margin10">|</li>
        <li style="position: static;" class=""><a onclick="openTopnav(2,true)" href="javascript:void(0)">在线帮助</a><b class="icon9"></b>
          <div id="topnav2" class="top_nav" style="display: none;">
            <h2><a onclick="openTopnav(2,false)" href="javascript:void(0)">在线帮助</a><b class="icon9"></b></h2>
            <div><a href="" target="_blank">在线帮助</a></div>
            <div><a href="javascript:changeFaceAdpter('STATIC_SERVER/c2c/face0/images','0');">新手上路</a></div>
            <iframe frameborder="0" style="z-index:-1; position:absolute; top:0; left:0; width:100px; height:140px; opacity:0; filter:alpha(opacity=0)"></iframe>
          </div>
        </li>
        <li class="margin10">|</li>
      </ul>
    </dd>
  </dl>
</div>
<!--left box-->

<div class="shortcut" style="z-index:1000">
<!-- 浮动菜单 
  <div class="shortcut_top"><span>机务检修系统</span><b class="icon57" title="" id="short_cu" onclick="ShortCut.cu()" style="display:none;"></b></div>
  <div class="shortcut_wrap"></div>
  <div class="shortcut_body" id="left_menu">
    <ul id="tt" class="easyui-tree">  
</ul> 
  </div>
  <div class="shortcut_bottom"></div>-->
  <iframe style="position:absolute; left:0px; top:0px; width:142px; height:300px; border:1px solid #229900; z-index:-1; opacity:0; filter:alpha(opacity=0);"></iframe>
</div> 
<div class="shortcut_btn" id="shortcut_btn"></div>
<div style="width:100%;height:100%;left:0px;top:0px;position:absolute;dispay:hidden;z-index: -1" id="content1">
	<iframe scrolling="auto" frameborder="0"  src="<%=basePath %>report!findAllJC.do" style="width:100%;height:100%;"></iframe>
</div>
</form>
</body>
</html>