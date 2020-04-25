<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*,com.beans.AdminInfo,java.text.*,com.dao.AdminDao" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户信息</title>
    <link rel="stylesheet" type="text/css" href="css/edittable.css"  ></link>
</head>
<body>
    <div class ="div_title">
        <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>信息表</span>
        </div>
    </div>
    <table class="edit_table" >
        <tr>
            <td class="td_info">账号</td>
            <td style="font-size: 18px">
               ${adminSession.adminName}
            </td>
        </tr>
        <tr>
            <td class="td_info">当前状态</td>
            <td style="font-size: 18px">
              <%
                  AdminInfo adminInfo = (AdminInfo) request.getSession().getAttribute("adminSession");
                  String state = adminInfo.getState();
                  if("1".equals(state))
                      out.print("正常");
                  else
                      out.print("0".equals(state)?"暂停":"禁用");
              %>
            </td>
        </tr>
        <tr>
            <td class="td_info">最后更新的时间</td>
            <td style="font-size: 18px">
                <%
                    Date date = adminInfo.getEditDate();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 hh时mm分ss秒");
                    out.print(sdf.format(date));
                %>
            </td>
        </tr>
        <tr>
            <td class="td_info">角色</td>
            <td style="font-size: 18px">
                <%
                   int roleid=adminInfo.getRoleId();
                   out.print(new AdminDao().getRoleName(roleid));
                %>
            </td>
        </tr>
    </table>
</body>
</html>
