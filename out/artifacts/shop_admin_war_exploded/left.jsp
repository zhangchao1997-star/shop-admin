<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.beans.MenuInfo" %>
<%@ page import="com.dao.MenuDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beans.AdminInfo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <script type="text/javascript" src="js/jquery-1.8.0.js"></script>
    <script type="text/javascript" src="js/jquery.easing.js"></script>
    <script type="text/javascript" src="js/jquery.accordion.js"></script>

    <script type="text/javascript">
        $(function(){
            $('#navigation').accordion({
                active:1,   /* 第三个被激活 */
                header: '.head',
                /*navigation1: false,  */
                event: 'click',
                fillSpace: true,
                animated: 'bounceslide'   /*slide,bounceslide ,bounceslide,easeslide'*/
            });
        });
    </script>
    <link rel="stylesheet" type="text/css" href="css/menu.css">

</head>
<body>
<ul id="navigation">
    <%
        MenuDao dao=new MenuDao();
        Object obj=request.getSession().getAttribute("adminSession");
        AdminInfo adminInfo = (AdminInfo)obj;
        Integer roleId = adminInfo.getRoleId();
        List<MenuInfo> menuList= dao.getMenuListByRole(roleId);
        request.setAttribute("menuList", menuList);
    %>
    <c:forEach var="menuP" items="${menuList}">
        <li>
            <a class="head">${menuP.menuName}</a>
            <ul>
                <li>
                    <c:forEach var="menu" items="${menuP.subMenuList}">
                        <a href="${menu.url}" target="${menu.target }"><img src="images/${menu.icon}" /><label>${menu.menuName}</label></a>
                    </c:forEach>
                </li>
            </ul>
        </li>
    </c:forEach>
</ul>
</body>
</html>
