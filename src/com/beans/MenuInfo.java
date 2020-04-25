package com.beans;

import java.util.List;

/**
 * 系统菜单表
 */
public class MenuInfo {
    private int id;  //当前菜单id
    private String menuName;  //菜单名
    private String icon;  //图片
    private String url;  //链接的地址
    private String target;  //要跳转的页面
    private int parentId; //父级菜单id
    private List<MenuInfo> subMenuList; //子菜单

    public List<MenuInfo> getSubMenuList() {
        return subMenuList;
    }

    public void setSubMenuList(List<MenuInfo> subMenuList) {
        this.subMenuList = subMenuList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
}
