<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户添加</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="js/jquery-1.8.0.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#ch_checkall,#top_ch_checkall").click(function(){
                if(this.checked){
                    $("input[name=ck_id]").attr("checked","checked");
                }else{
                    $("input[name=ck_id]").removeAttr("checked");
                }
            });

            $("table tr").mouseover(function(){
                $(this).css("background","#D3EAEF");
                $(this).siblings().css("background","white");
            });
        });

        function delMore() {
            //判断用户至少选了一项
            if($("input[name=ck_id]:checked").size()==0){
                alert("请至少选一项!");
            }
            else{
                if(confirm('确定要删除所选项吗')){
                    document.form1.submit();
                }

            }
        }
        function subForm(pageIndex) {
            window.location.href="AdminServlet.do?flag=manage&pageIndex="+pageIndex;
        }
        function getPageIndex() {
            var v =document.getElementById("zhuandao");
            if(v.value<=0){
                return 1;
            }
            else
                return v.value;
        }
        function delAdmin(item) {
             var adminId = '${adminSession.id}';
             if(item == adminId){
                 alert('不能够删除自己');
             }else{
                 if(confirm("确定要删除吗?"))
                 window.location.href="AdminServlet.do?flag=del&id="+item+"&pageIndex="+${page.pageIndex};
             }
        }
    </script>

    <link rel="stylesheet" type="text/css" href="css/maintable.css" ></link>
    <style type="text/css">
        /**
          备注特别长,进行相应的处理
         */
        .desc { width:200px;
            word-break:break-all;
            display:-webkit-box;
            -webkit-line-clamp:1;
            -webkit-box-orient:vertical;
            overflow:hidden;}
    </style>
</head>

<body>

<div class ="div_title">
    <div class="div_titlename"> <img src="images/san_jiao.gif" ><span>管理人员基本信息列表</span></div>
    <div class="div_titleoper">
        <input type="checkbox" id="top_ch_checkall"/> 全选 <a href="admin/admin_add.jsp"> <img src="images/add.gif"/>添加 </a> <a href="javascript:delMore()"><img src="images/del.gif"/>删除</a> </div>
</div>

<form action="AdminServlet.do"  name="form1">
    <input type="hidden" name="flag" value="delMore">
    <input type="hidden"name="pageIndex" value="${page.pageIndex}">
    <table class="main_table" >
        <tr>
            <th><input type="checkbox" id="ch_checkall" /></th>	<th>账号</th> 	<th>状态</th>	<th>备注</th>  <th>最后更新日期</th> 	<th>操作</th>
        </tr>
        <c:forEach var="admin" items="${adminList}">
            <tr>
                 <c:choose>
                     <c:when test="${admin.state==2}"><td></td></c:when>
                     <c:when test="${admin.state!=2}">
                         <td>
                          <input type="checkbox" name="ck_id" value="${admin.id}"  />
                         </td>
                     </c:when>
                 </c:choose>

                <td>
                    ${admin.adminName}
                </td>
                <td>
                   <c:choose>
                       <c:when test="${admin.state==0}">已锁定</c:when>
                       <c:when test="${admin.state==1}"></c:when>
                       <c:when test="${admin.state==2}">已删除</c:when>
                   </c:choose>
                </td>
                <td>
                    <div class="desc">
                        <a title="${admin.note}">${admin.note}</a>
                    </div>

                </td>
                <td>
                      ${admin.editDate}
                </td>
                <td>
                    <c:choose>
                        <c:when test="${admin.state==2}"></c:when>
                        <c:when test="${admin.state!=2}">
                            <c:choose>
                                <c:when test="${admin.state==0}">
                                    <a href="AdminServlet.do?flag=unlock&adminName=${admin.adminName}&pageIndex=${page.pageIndex}">解锁</a> |
                                </c:when>
                                <c:when test="${admin.state==1}">
                                    <a href="AdminServlet.do?flag=lock&adminName=${admin.adminName}&pageIndex=${page.pageIndex}">锁定</a> |
                                    <a href="AdminServlet.do?flag=beforeUpdate&id=${admin.id}">修改</a> |
                                </c:when>
                            </c:choose>
                            <a href="javascript:delAdmin(${admin.id})">删除</a>
                        </c:when>
                    </c:choose>

                </td>
            </tr>
        </c:forEach>
    </table>
</form>

<div class="div_page" >
    <div class="div_page_left">    共有 <label>${page.rowCount}</label> 条记录，当前第 <label>${page.pageIndex}</label> 页，共 <label> ${page.pageCount }</label> 页	</div>
    <div class="div_page_right" >
        <c:choose>
            <c:when test="${page.hasPre }">
                <a href="AdminServlet.do?flag=manage&pageIndex=1">首页</a>
                <a href="AdminServlet.do?flag=manage&pageIndex=${page.pageIndex-1 }">上一页</a>  &nbsp;  &nbsp;  &nbsp;  &nbsp;
            </c:when>
            <c:otherwise>
                首页
                上一页
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${page.hasNext }">
                <a href="AdminServlet.do?flag=manage&pageIndex=${page.pageIndex+1 }">下一页</a>
                <a href="AdminServlet.do?flag=manage&pageIndex=${page.pageCount }">尾页</a>
            </c:when>
            <c:otherwise>
                下一页
                尾页
            </c:otherwise>
        </c:choose>
        <button onclick="subForm(getPageIndex()<=${page.pageCount}?getPageIndex():${page.pageIndex})">转到</button>  第 <input name="pageIndex" id="zhuandao" class="page" value="${page.pageIndex }"> 页
    </div>
</div>
    <script type="text/javascript">
        var msg = '${msg}';
        if(msg != ""){
            alert(msg);
        }
    </script>
</body>
</html>
