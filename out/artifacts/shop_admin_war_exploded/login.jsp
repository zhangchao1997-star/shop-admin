<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>商城管理系统后台</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="stylesheet" type="text/css" href="css/login.css" >
</head>

<body>
    <div id="div_center">
          <form action="LoginServlet" method="post">
            <div id="div_inputbox">
                    <input type="text" id="adminName" name="adminName" />
                    <input type="password" id="password" name="password" />
            </div>
            <input id="btn_img" type="image" src="images/bg_login_btn.jpg" />
         </form>
    </div>
        <script type="text/javascript">
            //如果管理员账号或密码错误,在该页面弹出提示框
            var msg = "${msg}";
            if(msg!=""){
                alert(msg);
            }
        </script>
</body>
</html>
