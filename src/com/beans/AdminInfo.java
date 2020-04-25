package com.beans;

import java.io.Serializable;
import java.util.Date;

/***
 * 管理员实体类
 *
 */
public class AdminInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer id; //管理员id
    private String adminName; //管理员账号
    private String password;  //登陆密码
    private String state;  //用户的状态0,1,2三种  1表示正常 2表示禁用 0表示暂停
    private String note;    //备注
    private Date editDate;  //用户最后更新的时间
    private Integer roleId;  //用户所属的角色ID 指向角色表的外键

    private String roleName; //角色名称,adminInfo表中没有这个字段,用来关联查询角色信息

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getEditDate() {
        return editDate;
    }

    public void setEditDate(Date editDate) {
        this.editDate = editDate;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
