package com.servlet;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.dao.AdminDao;
import com.utils.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AdminServlet.do")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    AdminDao dao = new AdminDao();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag = request.getParameter("flag");
        if("add".equals(flag)){
            addAdmin(request,response);
        }
        else if("validateAdmin".equals(flag)){
            validateAdmin(request,response);
        }
        else if("updatePwd".equals(flag)){
            updatePwd(request,response);
        }
        else if("logOut".equals(flag)){
            logOut(request,response);
        }
        else if("manage".equals(flag)){
            manage(request,response);
        }
        else if("lock".equals(flag)){
            lock(request,response);
        }
        else if("unlock".equals(flag)){
            unlock(request,response);
        }
        else if("beforeUpdate".equals(flag)){
            beforeUpdate(request,response);
        }
        else if("update".equals(flag)){
            update(request,response);
        }
        else if("del".equals(flag)){
            del(request,response);
        }
        else if("delMore".equals(flag)){
            delMore(request,response);
        }
    }
    //删除多个用户
    private void delMore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           String[] ids =  request.getParameterValues("ck_id");
           List<Integer> list = new ArrayList<>();
           for (String s:ids){
               int id = Integer.parseInt(s);
               list.add(id);
           }
          int result =  dao.delAdmins(list);
          if(result==list.size()){
              request.setAttribute("msg","删除成功");
              manage(request,response);
          }
    }

    //删除用户
    private void del(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int result = dao.delAdmin(id);
        if(result == 1){
            request.setAttribute("msg","删除成功");
           manage(request, response);
        }
    }

    //修改用户信息
    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminName = request.getParameter("adminName");
        String password = request.getParameter("password");
        String note = request.getParameter("note");
        int id = Integer.parseInt(request.getParameter("id"));
        AdminInfo adminInfo = new AdminInfo();
        adminInfo.setAdminName(adminName);
        adminInfo.setPassword(password);
        adminInfo.setNote(note);
        int result = dao.updateAdmin(adminInfo,id);
        AdminInfo admin = dao.getAdmin(id);
        if(result == 1){
            request.setAttribute("msg","修改成功");
            request.setAttribute("admin",admin);
            request.getRequestDispatcher("/admin/admin_update.jsp").forward(request,response);
        }
    }

    //管理员信息修改前的操作
    private void beforeUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        AdminInfo adminInfo = dao.getAdmin(id);
        request.setAttribute("admin",adminInfo);
        request.getRequestDispatcher("/admin/admin_update.jsp").forward(request,response);
    }

    //给用户加锁
    private void lock(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String adminName = request.getParameter("adminName");
        int result = dao.updateStateLock(adminName);
        if(result == 1){
            request.setAttribute("msg","加锁成功");
           manage(request, response);
        }
    }

    //给用户解锁
    private void unlock(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String adminName = request.getParameter("adminName");
        int result = dao.updateStateUnLock(adminName);
        if(result == 1){
            request.setAttribute("msg","解锁成功");
           manage(request,response);
        }
    }

    //用户管理
    private void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pageSize = 6;
        int rowCount = dao.getAdminCount();
        int pageIndex = 1;
        String pageIndexStr = request.getParameter("pageIndex");
        if(pageIndexStr!=null){
            pageIndex = Integer.parseInt(pageIndexStr);
        }
        PageInfo page = PageUtil.getPageInfo(pageSize,rowCount,pageIndex);

        List<AdminInfo> adminInfoList = dao.getAdminList(page);
        request.setAttribute("adminList",adminInfoList);
        request.setAttribute("page",page);
        request.getRequestDispatcher("/admin/admin_manage.jsp").forward(request,response);
    }
    //退出系统
    private void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();
        request.getRequestDispatcher("/login.jsp").forward(request,response);
    }

    //修改密码
    private void updatePwd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String adminName = request.getParameter("adminName");
        String oldPwd = request.getParameter("password");  //旧密码
        String newPwd = request.getParameter("newPwd");  //新密码
        String pwdconfirm = request.getParameter("pwdconfirm");  //确认密码
        AdminInfo adminInfo = dao.checkAdmin(adminName,oldPwd);
        String reg = "[0-9a-zA-Z]{6,20}";
        if(adminInfo==null){
            response.getWriter().print("旧密码输入有误,请检查后重试");  //f:用户的旧密码输入有误
        }
        else if(!newPwd.matches(reg)){
            response.getWriter().print("新密码格式错误");  //1：新密码格式错误
        }
        else if(!pwdconfirm.matches(reg)){
            response.getWriter().print("确认密码格式错误");  //2：确认密码格式错误
        }
        else if(!pwdconfirm.equals(newPwd)){
            response.getWriter().print("确认密码与新密码不一致");
        }
        else{
           int result= dao.updatePwd(adminName,newPwd);
           if(result == 1){
              response.getWriter().print("修改成功");
           }
        }
    }

    // 验证用户账号不能重复
    private void validateAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String adminName = request.getParameter("adminName");
        AdminInfo resultValidate = dao.validateAdminName(adminName);
        if (resultValidate != null) {
            response.getWriter().print("该管理员用户已存在");
        }
    }

    //添加管理员用户
    private void addAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
            String adminName = request.getParameter("adminName");
            String password = request.getParameter("password");
            String note = request.getParameter("note");

            AdminInfo adminInfo = new AdminInfo();
            adminInfo.setAdminName(adminName);
            adminInfo.setPassword(password);
            adminInfo.setNote(note);
            adminInfo.setState("1");  //用户默认是可用状态
            int result = dao.addAdmin(adminInfo);
            if (result == 1) {
                request.setAttribute("msg", "添加成功");
                request.getRequestDispatcher("/admin/admin_add.jsp").forward(request, response);
            }
        }
}
