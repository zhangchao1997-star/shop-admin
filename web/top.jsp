<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,java.text.*" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <script type="text/javascript" src="js/jquery-1.8.0.js"></script>
    <script type="text/javascript" src="js/jquery.easing.js"></script>
    <script type="text/javascript" src="js/jquery.accordion.js"></script>
    <script type="text/javascript" src="js/time.js"></script>
    <link rel="stylesheet" type="text/css" href="css/top.css" >
</head>
<body>
<table id="t_head">
    <tr>
        <td id="td1" ></td>
        <td id="td2">&nbsp;</td>
        <td id="td3">
            <a id="td3_a1" title="修改密码" target="centerFrame" href="admin/password_edit.jsp"><img src="images/btn_head_bg1.jpg"/>修改密码</a>
            <a  target="centerFrame" title="个人信息" href="admin/admin_info.jsp"><img src="images/btn_head_bg1.jpg"/>用户信息</a>
            <a  href="AdminServlet.do?flag=logOut" target="_top" ><img src="images/btn_head_bg1.jpg"/>退出系统</a>
        </td>
    </tr>
</table>
<table id="t_bar" >
    <tr>
        <td id="bar_td1"></td>
        <td id="bar_td2">
            <div id="div_date">
            </div>
        </td>

        <td id="bar_td3">
            商城后台管理系统
        </td>
    </tr>
</table>
<table id="t_title">
    <tr>
        <td id="title_td1">
            <img src="images/main_28.gif"/>
        </td>
        <td id="title_td2"><img src="images/main_29.gif" /></td>
        <td id="title_td3"><img src="images/main_30.gif" /></td>
        <td id="title_td4">&nbsp;
            <label class="admininfo">
                当前登录用户: ${adminSession.adminName} &nbsp;&nbsp;&nbsp;
                用户状态  : ${adminSession.state=="1"?"正常":"错误"}
            </label>
        </td>
        <td id="title_td5"><img src="images/main_32.gif" /></td>
    </tr>
</table>
</body>
</html>
