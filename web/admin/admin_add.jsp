<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户添加</title>

    <link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>
    <link rel="stylesheet" type="text/css" href="css/validate.css"  ></link>
    <!--客户端验证-->
    <script type="text/javascript"  src="js/validate.js"></script>
    <script type="text/javascript"  src="js/jquery-1.8.0.js"></script>

    <script>
        $(function () {
            $("input[type=text],textarea").focus(function(){
                $(this).addClass("input_focus");
            }).blur(function(){
                $(this).removeClass("input_focus");
            });

            $(".form_btn").hover(function(){
                    $(this).css("color","red").css("background","#6FB2DB");
                },

                function(){
                    $(this).css("color","#295568").css("background","#BAD9E3");
                });
        });
    </script>
</head>

<body>
<div class ="div_title">
    <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理员添加</span></div>
</div>

<form action="AdminServlet.do" method="post" onsubmit="return validate()">
    <input type="hidden" name="flag" value="add">
    <table class="edit_table" >
        <tr>
            <td class="td_info">用户账号:</td>
            <td class="td_input_short">
                <input type="text" class="txtbox" id="adminName" value="${param.adminName}" name="adminName" onclick="showInfo(this,'')" onblur="validateAdminName(this)"  />&nbsp;&nbsp;&nbsp;
                <label class="validate_info" id="adminName_msg" >4-15位；只限数字(0-9)和英文(a-z),不区分大小写</label>
            </td>
        </tr>
        <tr>
            <td class="td_info">用户密码:</td>
            <td>
                 <input type="text"  class="txtbox"  name="password" value="${param.password}" id="password" onclick="showInfo(this,'')" onblur="validatePassword(this)"/>&nbsp;&nbsp;&nbsp;
                 <label  class="validate_info" id="password_msg" >数字或英文,6-20位</label>
            </td>
        </tr>
        <tr>
            <td class="td_info">确认密码:</td>
                <td><input type="text" class="txtbox" id="pwdconfirm"  name="password" value="${param.password}" onclick="showInfo(this,'')" onblur="validateConfirm(this)" />&nbsp;&nbsp;&nbsp;
                <label  class="validate_info"  id="pwdconfirm_msg">请输入确认密码</label>
            </td>
        </tr>
        <tr>
            <td class="td_info">备注信息:</td>
            <td><textarea rows="4" cols="27" name="note" class="txtarea">${param.note}</textarea> </td>
            <td><label></label></td>
        </tr>
        <tr>
            <td class="td_info"> </td>
            <td>
                <input class="form_btn" type="submit" value="提交" />
                <input type="reset"  class="form_btn" value="重置" /> &nbsp;&nbsp;&nbsp;
                <label id="result_msg" class="result_msg">${msg}</label>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
