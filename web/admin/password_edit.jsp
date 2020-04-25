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
    <script type="text/javascript"  src="js/jquery-1.8.0.js"></script>

    <script>
        $(function () {
            $("input[type=text],textarea").focus(function () {
                $(this).addClass("input_focus");
            }).blur(function () {
                $(this).removeClass("input_focus");
            });

            $(".form_btn").hover(function () {
                    $(this).css("color", "red").css("background", "#6FB2DB");
                },

                function () {
                    $(this).css("color", "#295568").css("background", "#BAD9E3");
                });

            $(".form_btn").click(function(){
                $.ajax({
                    url: "AdminServlet.do",
                    type: "post",
                    async: false,
                    data: {  flag: "updatePwd",
                             adminName: '${adminSession.adminName}',
                             password:$("#old_password").val(),
                             newPwd:$("#password").val(),
                             pwdconfirm:$("#pwdconfirm").val() },
                    dataType: "text",
                    success: function (data) {
                        alert(data);
                    }
              });
          }
            );
        });
    </script>
</head>
<body>
<div class ="div_title">
    <div class="div_titlename"> <img src="images/btn_head_bg1.jpg" ><span>修改密码</span></div>
</div>

  <table class="edit_table" >
        <tr>
            <td class="td_info">旧密码:</td>
            <td>
                <input type="text"  class="txtbox" placeholder="请输入账号当前密码" name="old_password" value="${param.old_password}" id="old_password"/>&nbsp;&nbsp;&nbsp;
                <label  class="validate_info" id="old_password_msg" ></label>
            </td>
        </tr>
        <tr>
            <td class="td_info">新的密码:</td>
            <td><input type="text" class="txtbox" id="password" placeholder="6-20位(大小写字母+数字)密码" name="password" value="${param.password}" />&nbsp;&nbsp;&nbsp;
                <label  class="validate_info"  id="password_msg"></label>
            </td>
        </tr>
        <tr>
            <td class="td_info">确认新密码:</td>
            <td><input type="text" class="txtbox" id="pwdconfirm" placeholder="6-20位(大小写字母+数字)密码"  name="pwdconfirm" value="${param.pwdconfirm}" />&nbsp;&nbsp;&nbsp;
                <label  class="validate_info"  id="pwdconfirm_msg"></label>
            </td>
        </tr>
        <tr>
            <td class="td_info"> </td>
            <td>
                <input class="form_btn" type="submit" value="保存" />&nbsp;&nbsp;&nbsp;
                <label id="result_msg" class="result_msg"></label>
            </td>
        </tr>
  </table>
</body>
</html>
