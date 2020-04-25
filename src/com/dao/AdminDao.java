package com.dao;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.jdbc.DBUtil;

import java.util.List;

/**
 * 管理员-dao层类
 */
public class AdminDao {
    /**
     * 管理员登陆
     * @param adminName 账号
     * @param password 密码
     * @return 如果数据库里有该管理员返回管理员信息，否则返回null
     */
    public AdminInfo login(String adminName, String password) {
        String sql = "select * from adminInfo where adminName=? and password=?";
        return DBUtil.getSingleObject(sql,AdminInfo.class,adminName,password);
    }

    /**
     * 添加管理员用户
     * @param adminInfo 管理员实体类
     * @return 如果返回1添加成功，否则添加失败
     */
    public int addAdmin(AdminInfo adminInfo) {
        String sql = "insert into adminInfo(adminName,password,note,state) values(?,?,?,?)";
        return DBUtil.update(sql,adminInfo.getAdminName(),adminInfo.getPassword(),adminInfo.getNote(),adminInfo.getState());
    }

    /**
     * 服务端验证该管理员账号是否已经存在
     * @param adminName 账号
     * @return 如果返回AdminInfo对象则表明该管理员在数据库已存在，否则不存在
     */
    public AdminInfo validateAdminName(String adminName) {
        String sql = "select * from adminInfo where adminName=?";
        return DBUtil.getSingleObject(sql,AdminInfo.class,adminName);
    }

    /**
     * 服务端查看当前登陆用户的状态
     * @param adminName 用户名
     * @return 返回用户的状态
     */
    public String getAdminState(String adminName) {
        String sql="select state from admininfo where adminName=?";
        return DBUtil.getScalar(sql,adminName);
    }

    /**
     * 根据用户的账号和密码,查询用户
     * @param adminName 用户名
     * @param oldPwd  密码
     * @return 返回null则证明数据不存在这个用户，否则存在
     */
    public AdminInfo checkAdmin(String adminName, String oldPwd) {
        String sql="select * from admininfo where adminName=? and password=?";
        return DBUtil.getSingleObject(sql,AdminInfo.class,adminName,oldPwd);
    }

    /**
     * 根据用户名修改用户的密码
     * @param adminName 用户名
     * @param newPwd  新密码
     * @return  返回1修改成功
     */
    public int updatePwd(String adminName, String newPwd) {
        String sql = "update admininfo set password=? where adminName=?";
        return DBUtil.update(sql,newPwd,adminName);
    }

    /**
     * 查询所有的管理员用户
     * @return 返回全部的用户
     */
    public List<AdminInfo> getAllAdmin() {
        String sql = "select * from admininfo";
        return DBUtil.getList(sql,AdminInfo.class);
    }

    /**
     * 根据用户名修改用户状态
     * @param adminName 用户名
     * @return 返回1修改成功
     */
    public int updateStateLock(String adminName) {
        String sql = "update admininfo set state=? where adminName=?";
        return DBUtil.update(sql,"0",adminName);
    }

    /**
     * 根据用户名修改状态
     * @param adminName 用户名
     * @return 返回1修改成功
     */
    public int updateStateUnLock(String adminName) {
        String sql = "update admininfo set state=? where adminName=?";
        return DBUtil.update(sql,"1",adminName);
    }

    /**
     * 根据用户id查询用户
     * @param id 用户id
     * @return 返回Admininfo对象
     */
    public AdminInfo getAdmin(int id) {
        String sql = "select * from admininfo where id=?";
        return DBUtil.getSingleObject(sql,AdminInfo.class,id);
    }

    /**
     * 根据用户id修改信息
     * @param adminInfo 用户信息类
     * @param id 用户id
     * @return 返回1修改成功
     */
    public int updateAdmin(AdminInfo adminInfo, int id) {
        String sql = "update admininfo set adminName=?,password=?,note=? where id=?";
        return DBUtil.update(sql,adminInfo.getAdminName(),adminInfo.getPassword(),adminInfo.getNote(),id);
    }

    /**
     * 根据用户id删除用户
     * @param id 用户id
     * @return 返回1删除成功
     */
    public int delAdmin(int id) {
        String sql = "update admininfo set state=? where id=?";
        return DBUtil.update(sql,"2",id);
    }
    /**
     * 删除多个用户
     */
    public int delAdmins(List<Integer> id){
        int result = 0;
        for (int s:id){
            String sql="update admininfo set state=? where id=?";
            result +=DBUtil.update(sql,"2",s);
        }
        return result;
    }

    /**
     * 获取所有的管理员用户(带有分页)
     * @param page PageInfo类
     * @return 返回所有的管理员用户
     */
    public List<AdminInfo> getAdminList(PageInfo page){
        return DBUtil.getList("select * from adminInfo limit ?, ? ", AdminInfo.class,page.getBeginRow(),page.getPageSize());
    }

    /**
     * 查询用户的总数
     * @return 用户总数
     */
    public int getAdminCount(){
        String sql = "select count(*) from admininfo";
        long count= DBUtil.getScalar(sql);
        return Integer.parseInt(count+"");
    }
    public String getRoleName(int roleId){
        String sql = "select roleName from roleinfo where id=?";
        return DBUtil.getScalar(sql,roleId);
    }
}
