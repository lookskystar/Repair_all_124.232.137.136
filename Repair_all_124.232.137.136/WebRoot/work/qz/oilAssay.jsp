<%@ page contentType="text/html; charset=UTF-8" language="java"
import="java.sql.*" errorPage=""%>
<%@include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>report/">
    <!-- 制动 小辅修 流程 -->
    <title>${unitType}&nbsp;&nbsp;${flowval } 检修记录</title>
    <link href="<%=basePath%>css/test.css" type="text/css" rel="stylesheet" />
    <link href="<%=basePath%>css/linkcss.css" type="text/css"
          rel="stylesheet" />
    <link href="<%=basePath%>js/tree/dtree/dtree.css" type="text/css"
          rel="stylesheet" />
    <script type="text/javascript" src="<%=basePath%>js/test.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.4.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.floatDiv.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/menu.js"></script>
    <!-- 打印插件 -->
    <script type="text/javascript" src="<%=basePath%>js/LodopFuncs.js"></script>
    <object id="LODOP_OB"
            classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
    <!-- 打印end -->
    <style type="text/css">
        #nav,#nav ul {
            margin: 0;
            padding: 0;
            list-style-type: none;
            list-style-position: outside;
            position: relative;
            line-height: 1.5em;
        }

        #nav a {
            display: block;
            padding: 0px 5px;
            border: 1px solid #333;
            color: #fff;
            font-weight: bold;
            text-decoration: none;
            background-color: #328aa4;
        }

        #nav a:link {
            background-color: #328aa4;
        }

        /*#nav a:visited{
            background-color:#fff;
            color:blue;
            }*/
        #nav a:hover {
            background-color: #fff;
            color: red;
        }

        #nav li {
            float: left;
            position: relative;
        }

        #nav ul {
            position: absolute;
            display: none;
            width: 12em;
            top: 1.5em;
        }

        #nav li ul a {
            width: 12em;
            height: auto;
            float: left;
        }

        #nav ul ul {
            top: auto;
        }

        #nav li ul ul {
            left: 12em;
            margin: 0px 0 0 10px;
        }

        #nav li:hover ul ul,#nav li:hover ul ul ul,#nav li:hover ul ul ul ul {
            display: none;
        }

        #nav li:hover ul,#nav li li:hover ul,#nav li li li:hover ul,#nav li li li li:hover ul
        {
            display: block;
        }
    </style>
    <script type="text/javascript">
        //合并表格的单元格
        function cellMege(table, col) {
            var lines = $('#' + table + ' tr').size();
            if (lines <= 2)
                return;
            var v, l = 0, current = '', index = 1;
            for ( var i = 1; i < lines; i++) {
                var tr = $('#' + table + ' tr').eq(i);
                v = tr.find('td[name="' + col + '"]').html();
                //alert(tr.find('td[name="secondname"]').size());
                l++;
                //alert(v);
                if (v != current || i == (lines - 1)) {//如果两个值不相同或者是最后一行
                    if (i == (lines - 1))
                        l++;
                    if (l > 1) {//草果两行，合并
                        var td = $('#' + table + ' tr').eq(index).find(
                                'td[name="' + col + '"]');
                        td.attr('rowspan', l);
                        for ( var j = 1; j < l; j++) {
                            var td = $('#' + table + ' tr').eq(index + j).find(
                                    'td[name="' + col + '"]').remove();
                        }
                    }
                    l = 0;//从新计数
                    current = v;
                    index = i;
                }
            }
        }
        $(function() {
            cellMege('datatabel', 'firstname');
            cellMege('datatabel', 'secondname');
            cellMege('datatabel', 'fixitemname');
            $('#scoll_div_id').floatdiv("middletop");
        });

        function SaveAsFile() {
            //得到LODOP对象
            var LODOP = getLodop(document.getElementById('LODOP_OB'), document
                    .getElementById('LODOP_EM'));
            LODOP.PRINT_INIT(""); //初始化，因为不需要打印，所以不需要为其设置标题
            //增加打印表格,（距离头部距离、距离左边、宽度、高度），得到相应表格中的html元素
            LODOP.ADD_PRINT_TABLE(100, 20, 500, 80, document
                    .getElementById("content").innerHTML);
            //设置相应模式
            LODOP.SET_SAVE_MODE("Orientation", 1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
            LODOP.SET_SAVE_MODE("LINESTYLE", 1);//导出后的Excel是否有边框
            LODOP.SET_SAVE_MODE("CAPTION", "行安检修记录");//标题栏文本内容
            //LODOP.SET_SAVE_MODE("CENTERHEADER","行安检修记录");//页眉内容
            //LODOP.SET_SAVE_MODE("PaperSize",9);  //Excel文件的页面设置：纸张大小   9-对应A4
            //LODOP.SET_SAVE_MODE("Zoom",90);       //Excel文件的页面设置：缩放比例
            //LODOP.SET_SAVE_MODE("CenterHorizontally",true);//Excel文件的页面设置：页面水平居中
            //LODOP.SET_SAVE_MODE("CenterVertically",true); //Excel文件的页面设置：页面垂直居中
            //LODOP.SET_SAVE_MODE("QUICK_SAVE",true);//快速生成（无表格样式,数据量较大时或许用到）
            //保存文件，以窗口弹出对话框的方式，让用户去选择文件保存的位置，参数为文件保存的默认名称
            LODOP
                    .SAVE_TO_FILE("${datePlan.jcType }-${datePlan.jcnum }-${unitType}检修记录.xls");
        };

        var LODOP; //声明为全局变量
        function preview() {
            CreatePrintPage();
            //打印预览
            LODOP.PREVIEW();
        }

        function setup() {
            CreatePrintPage();
            //LODOP.PRINT_SETUP();
            LODOP.PRINT_DESIGN();//打印设置
        }

        function print() {
            CreatePrintPage();
            LODOP.PRINT(); //打印
        }

        //初始化页面
        function CreatePrintPage() {
            //得到LODOP对象，注意head标签里面需引入object和embed标签
            LODOP = getLodop(document.getElementById('LODOP_OB'), document
                    .getElementById('LODOP_EM'));
            //封装我们的html元素
            var strBodyStyle = "<style>table,td{border:1 solid #000000;border-collapse:collapse}</style>";
            var strFormHtml = strBodyStyle + "<body>"
                    + document.getElementById("content").innerHTML + "</body>";
            //打印初始化，页面距离顶部10px，距离左边10px，宽754px，高453px，给打印设置个标题
            LODOP.PRINT_INITA(10, 10, 754, 453, "打印控件操作");
            //设置打印页面属性：2：表示横向打印，0：定义纸张宽度，为0表示无效设置，A4：设置纸张为A4
            LODOP.SET_PRINT_PAGESIZE(2, 0, 0, "A4");
            //设置文本，参数(距离页面头部，距离页面左边距离，文本宽度，文本高度，文本内容)
            LODOP.ADD_PRINT_TEXT(21, 300, 300, 30, "${unitType}${flowval }检修记录\n");
            //给所添加的文本定义样式,0：表示新添加的元素，相应的属性，相应的值
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 15);
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);//固定标题,设置卫页眉页脚
            LODOP.SET_PRINT_STYLEA(0, "Horient", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            //同上
            LODOP
                    .ADD_PRINT_TEXT(
                    40,
                    60,
                    350,
                    30,
                    "机车号:${datePlan.jcType } ${datePlan.jcnum }  修程:${datePlan.fixFreque}  检修日期:${datePlan.kcsj }");
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
            //添加html元素
            LODOP.ADD_PRINT_HTM(63, 38, 684, 330, strFormHtml);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 15);
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 4);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            LODOP.SET_PRINT_STYLEA(0, "Vorient", 3);
            //添加一条线，参数(开始短点距离头部距离，开始端点距左边距离，结束端点距头部距离，结束端点距左边距离)
            LODOP.ADD_PRINT_LINE(53, 23, 52, 725, 0, 1);
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            LODOP.ADD_PRINT_LINE(414, 23, 413, 725, 0, 1);
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            LODOP.SET_PRINT_STYLEA(0, "Vorient", 1);
            //LODOP.ADD_PRINT_TEXT(421,37,144,22,"左下脚的文本小标题");
            //LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
            LODOP.ADD_PRINT_TEXT(421, 542, 165, 22, "第#页/共&页");
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 2);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
            LODOP.SET_PRINT_STYLEA(0, "Vorient", 1);
        }
    </script>
</head>

<body bgcolor="#f8f7f7">
<!-- 浮动导航菜单start -->

<br>
<br>
<!-- 浮动导航菜单end -->
<form id="form1" name="form1" method="post" action="">
    <div style="width:870px;margin-left:-425px;left:50%;position:absolute;" id="content2">
        <table width="864" border="0" align="center" cellspacing="0" vspace="0" style="padding-top:10px;">
            <tr>
                <td colspan="6" align="center" height="40">
                    <h2 align="center">
                        <font style="font-family:'隶书'"> <b>油水化验详细记录</b> </font>
                    </h2></td>
                <td align="right"></td>
            </tr>
            <tr>

            </tr>
            <tr>
                <td colspan="6">
                    <table width="900" border="0" align="center" cellspacing="0" vspace="0" id="content" id="content">
                        <tr>
                            <td align="center" colspan="3" class="tbCELL3">
                                <!-- 2015-5-19    黄亮 添加行内样式style="font-size:10pt;"，设置导出Execl字体大小，Execl字体大小必须是行内样式 -->
                                <table width="900" border="0" align="center" cellspacing="0"
                                       vspace="0" id="datatabel" style="font-size:10pt;">
                                    <tr
                                            style="line-height:40px;height:30px;background-color: #328aa4;font-weight: bolder;">
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="20%">化验项目名称</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;; min-width" width="20%">
                                            化验子项目名称</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="10%">送样人</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="5%">检验人</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="10%">接收待化验样品时间</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="10%">化验完成时间</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="5%">化验情况</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="10%">处理意见</td>
                                        <td class="tbCELL1" align="center"
                                            style="white-space:nowrap;color:#ffffff;" width="10%">合格情况</td>
                                    </tr>
                                    <c:forEach items="${map}" var="m">
                                        <tr>
                                            <td class="tbCELL1" align="center" name="firstname">${m.key.reportItemDefin}&nbsp;</td>
                                            <td class="tbCELL1" align="center" colspan="9"></td>

                                        </tr>
                                        <c:forEach items="${m.value}" var="v">
                                            <tr>
                                                <td class="tbCELL1" align="center">
                                                </td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.subItemId.subItemTitle }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.sentsamPeo }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.receiptPeo }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.recesamTime }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.finTime }</td>
                                                <td class="tbCELL1" align="center">${v.quaGrade }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.dealAdvice }</td>
                                                <td class="tbCELL1" align="center">
                                                    ${v.recPriId.quasituation }</td>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </table></td>
                        </tr>
                    </table></td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>