<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
</head>
<body>
<center>
<div class="box2" style="width: 80%;text-align: center;" showStatus="false">
<div style="font-size: 24px;font-weight: bold">电力机车秋季整治记录卡</div>
<div>                              
	<span>机车型号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	<span>修程：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	<span>扣车时间：    年   月   日     时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	<span>交车时间：    年   月   日     时</span>
</div>
<table width="1093" height="1516" class="tableStyle">
  <col width="100" />
  <col width="74" />
  <col width="487" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <col width="72" />
  <tr height="36">
    <td height="36" width="100">类别</td>
    <td height="36" width="74">序号</td>
    <td height="36" width="487">重点整治部位</td>
    <td height="36" width="72">整治情况</td>
    <td height="36" width="72">工作者</td>
    <td height="36" width="72">工长</td>
    <td height="36" width="72">质检员</td>
    <td height="36" width="72">专业包保人员</td>
    <td height="36" width="72">备注</td>
  </tr>
  <tr height="29">
    <td rowspan="3" height="87" width="100">电机</td>
    <td x:num="1" height="29" width="74">1</td>
    <td height="29" width="487"><div align="left">主变压器、平波电抗器状态检查、高压电压互感器</div></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="2" height="29" width="74">2</td>
    <td height="29" width="487"><div align="left">各辅助电机接线、绝缘、连结法兰和相关部件检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="3" height="29" width="74">3</td>
    <td height="29" width="487"><div align="left">各牵引电动机检查、吹扫及相关部件检查</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
  </tr>
  <tr height="29">
    <td rowspan="3" height="87" width="100">车顶设备</td>
    <td x:num="4" height="29" width="74">4</td>
    <td height="29" width="487"><div align="left">受电弓状态检查、测试</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
    <td rowspan="3" height="87" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="5" height="29" width="74">5</td>
    <td height="29" width="487"><div align="left">主断路器、高压电压、电流互感器、隔离开关、避雷器状态检查</div></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="6" height="29" width="74">6</td>
    <td height="29" width="487"><div align="left">彻底检查、清洁车顶复合绝缘子和瓷瓶</div></td>
  </tr>
  <tr height="29">
    <td rowspan="12" height="384" width="100">电器</td>
    <td x:num="7" height="29" width="74">7</td>
    <td height="29" width="487"><div align="left">司机控制器、琴键开关箱等操纵台设备检查</div></td>
    <td rowspan="7" height="203" width="72"></td>
    <td rowspan="7" height="203" width="72"></td>
    <td rowspan="8" height="232" width="72"></td>
    <td rowspan="12" height="384" width="72"></td>
    <td rowspan="12" height="384" width="72"></td>
    <td rowspan="12" height="384" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="8" height="29" width="74">8</td>
    <td height="29" width="487"><div align="left">机车空调系统窗、加热、壁炉等取暖装置状态检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="9" height="29" width="74">9</td>
    <td height="29" width="487"><div align="left">主回路大线线耳检查，压接良好,各电线路检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="10" height="29" width="74">10</td>
    <td height="29" width="487"><div align="left">转换开关、接触器、继电器、屏柜插件检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="11" height="29" width="74">11</td>
    <td height="29" width="487"><div align="left">主变压器阻容保护电阻、电容元件检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="12" height="29" width="74">12</td>
    <td height="29" width="487"><div align="left">各接触器触头状态检查、三相自动开关检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="13" height="29" width="74">13</td>
    <td height="29" width="487"><div align="left">整流柜状态检查、清扫和测量</div><td>
  </tr>
  <tr height="29">
    <td x:num="14" height="29" width="74">14</td>
    <td height="29" width="487"><div align="left">微机系统、电子柜检查、测试</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="15" height="29" width="74">15</td>
    <td height="29" width="487"><div align="left">按范围校验和检查各电器仪表</div></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="16" height="29" width="74">16</td>
    <td height="29" width="487"><div align="left">蓄电池状态检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="17" height="29" width="74">17</td>
    <td height="29" width="487"><div align="left">光电速度传感器检查</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td rowspan="2" height="94" width="72"></td>
  </tr>
  <tr height="65">
    <td x:num="18" height="65" width="74">18</td>
    <td height="65" width="487"><div align="left">弓网动态检测装置、自动过分相装置，车顶绝缘检测装置、欠风压报警装置、视频装置整治、走行部监测装置检查、轮缘润滑装置检查</div></td>
    <td height="65" width="72"></td>
    <td height="65" width="72"></td>
  </tr>
  <tr height="29">
    <td rowspan="11" height="344" width="100">走行部</td>
    <td x:num="19" height="29" width="74">19</td>
    <td height="29" width="487"><div align="left">轮箍、轮轴按范围进行探伤</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td rowspan="11" height="344" width="72"></td>
    <td rowspan="11" height="344" width="72"></td>
    <td rowspan="11" height="344" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="20" height="29" width="74">20</td>
    <td height="29" width="487"><div align="left">轮对尺寸测量，轮对踏面不良者进行镟修</div></td>
    <td rowspan="9" height="286" width="72"></td>
    <td rowspan="9" height="286" width="72"></td>
    <td rowspan="10" height="315" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="21" height="29" width="74">21</td>
    <td height="29" width="487"><div align="left">各轮对齿轮箱检查、整治</div></td>
  </tr>
  <tr height="29">
    <td x:num="22" height="29" width="74">22</td>
    <td height="29" width="487"><div align="left">牵引装置及电机悬挂装置检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="23" height="29" width="74">23</td>
    <td height="29" width="487"><div align="left">油压减振器下托板螺栓及托板、安装座检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="24" height="29" width="74">24</td>
    <td height="29" width="487"><div align="left">轴箱及拉杆、一系圆簧、二系橡胶堆支承状态检查</div></td>
  </tr>
  <tr height="41">
    <td x:num="25" height="41" width="74">25</td>
    <td height="41" width="487"><div align="left">机车转向架焊缝，减振器，轴箱拉杆安装座，牵引座，车钩尾框可见部分检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="26" height="29" width="74">26</td>
    <td height="29" width="487"><div align="left">单元制动器检查</div></td>
  </tr>
  <tr height="42">
    <td x:num="27" height="42" width="74">27</td>
    <td height="42" width="487"><div align="left">车钩高度调整及缓冲装置、吊杆、均衡梁、磨耗板、缓冲器安装座检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="28" height="29" width="74">28</td>
    <td height="29" width="487"><div align="left">扫石器、排障器检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="29" height="29" width="74">29</td>
    <td height="29" width="487"><div align="left">轮对、电机轴承按范围进行轴承检测</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
  </tr>
  <tr height="29">
    <td rowspan="11" height="319" width="100">制动</td>
    <td x:num="30" height="29" width="74">30</td>
    <td height="29" width="487"><div align="left">空压机油位，润滑油状态，泵风时间测试</div></td>
    <td rowspan="11" height="319" width="72"></td>
    <td rowspan="11" height="319" width="72"></td>
    <td rowspan="11" height="319" width="72"></td>
    <td rowspan="11" height="319" width="72"></td>
    <td rowspan="11" height="319" width="72"></td>
    <td rowspan="11" height="319" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="31" height="29" width="74">31</td>
    <td height="29" width="487"><div align="left">辅助压缩机作用良好</div></td>
  </tr>
  <tr height="29">
    <td x:num="32" height="29" width="74">32</td>
    <td height="29" width="487"><div align="left">空气干燥器各部工作正常</div></td>
  </tr>
  <tr height="29">
    <td x:num="33" height="29" width="74">33</td>
    <td height="29" width="487"><div align="left">制动管路安装牢固，漏泄不超标；防缓标识清晰</div></td>
  </tr>
  <tr height="29">
    <td x:num="34" height="29" width="74">34</td>
    <td height="29" width="487"><div align="left">机车总风管路逆止阀检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="35" height="29" width="74">35</td>
    <td height="29" width="487"><div align="left">电空控制器定位机构等状态检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="36" height="29" width="74">36</td>
    <td height="29" width="487"><div align="left">空气制动阀接线、微动开关及安装状态检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="37" height="29" width="74">37</td>
    <td height="29" width="487"><div align="left">快装胶垫式接头的列车管、均衡风缸管检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="38" height="29" width="74">38</td>
    <td height="29" width="487"><div align="left">司机室紧急放风阀加铅封</div></td>
  </tr>
  <tr height="29">
    <td x:num="39" height="29" width="74">39</td>
    <td height="29" width="487"><div align="left">制动机各阀件按范围检修，性能试验良好</div></td>
  </tr>
  <tr height="29">
    <td x:num="40" height="29" width="74">40</td>
    <td height="29" width="487"><div align="left">刮雨器试验作用良好</div></td>
  </tr>
  <tr height="29">
    <td rowspan="6" height="174" width="100">车体及其他</td>
    <td x:num="41" height="29" width="74">41</td>
    <td height="29" width="487"><div align="left">检查、处理机车顶棚，砂箱盖等漏水处所</div></td>
    <td rowspan="4" height="116" width="72"></td>
    <td rowspan="4" height="116" width="72"></td>
    <td rowspan="4" height="116" width="72"></td>
    <td rowspan="6" height="174" width="72"></td>
    <td rowspan="6" height="174" width="72"></td>
    <td rowspan="6" height="174" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="42" height="29" width="74">42</td>
    <td height="29" width="487"><div align="left">对机车内部、车体、走行部进行彻底清扫</div></td>
  </tr>
  <tr height="29">
    <td x:num="43" height="29" width="74">43</td>
    <td height="29" width="487"><div align="left">车门、柜门锁、门框、窗帘、踏板等重点整治检查</div></td>
  </tr>
  <tr height="29">
    <td x:num="44" height="29" width="74">44</td>
    <td height="29" width="487"><div align="left">机车排障器、车体油漆斑剥严重的进行油漆</div></td>
  </tr>
  <tr height="29">
    <td x:num="45" height="29" width="74">45</td>
    <td height="29" width="487"><div align="left">机车工具箱清理和工具清点</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
    <td rowspan="2" height="58" width="72"></td>
  </tr>
  <tr height="29">
    <td x:num="46" height="29" width="74">46</td>
    <td height="29" width="487"><div align="left">机车灭火器及安装状态检查</div></td>
    <td height="29" width="72"></td>
    <td height="29" width="72"></td>
  </tr>
  <tr height="19">
    <td colspan="2" height="19" width="200">其他重点报活项目</td>
    <td colspan="7" height="19" width="1334"></td>
  </tr>
  <tr height="19">
    <td colspan="2" height="19" width="200">必检人员</td>
    <td colspan="7" height="19" width="1334">交车工长：　　　　　　　　　验收员：</td>
  </tr>
  <tr height="28">
    <td colspan="2" height="28" width="200">抽检人员</td>
    <td colspan="7" height="28" width="1334">     　　　　　　　 检修主任：        　　　　 质检科长：        　　　　技术科长：                段领导：</td>
  </tr>
  <tr height="19">
    <td colspan="2" height="19" width="200">零公里检查</td>
    <td colspan="7" height="19" width="1334"></td>
  </tr>
</table>
</div>
</center>
</body>
</html>