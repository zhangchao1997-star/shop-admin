package com.servlet;

import com.beans.AdminInfo;
import com.dao.AdminDao;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/LoginServlet")
public class LoginServlet extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminDao dao = new AdminDao();
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
      doGet(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
       String adminName = request.getParameter("adminName");
       String password = request.getParameter("password");
       //首先判断管理员用户的状态
       String state = dao.getAdminState(adminName);
       if("0".equals(state)){
           request.setAttribute("msg","你的账号已被暂停使用");
           request.getRequestDispatcher("/login.jsp").forward(request,response);
       }
       else if("2".equals(state)){
           request.setAttribute("msg","你已被禁止使用该系统");
           request.getRequestDispatcher("/login.jsp").forward(request,response);
       }
       else {
           //如果是第一次登陆,那么会进入到if条件中，否则不会
           if (adminName != null && password != null) {
               request.getSession().setAttribute("adminName", adminName);
               request.getSession().setAttribute("password", password);
           }
           String adminNameSession = adminName;
           String passwordSession = password;
           //如果用户已经入到系统,那么其再次刷新时,adminName或者password都为null,此时赋值其session作用域里的数据
           if (adminName == null || password == null) {
               adminNameSession = (String) request.getSession().getAttribute("adminName");
               passwordSession = (String) request.getSession().getAttribute("password");
           }
           AdminInfo adminInfo = dao.login(adminNameSession, passwordSession);
           if (adminInfo != null) {
               request.getSession().setAttribute("adminSession", adminInfo);
               request.getRequestDispatcher("/main.html").forward(request, response);
           } else {
               request.setAttribute("msg", "用户名或密码错误");
               request.getRequestDispatcher("/login.jsp").forward(request, response);
           }
       }
    }
}
