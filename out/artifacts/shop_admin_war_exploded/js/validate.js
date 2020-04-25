/**
 * 添加用户
 * @param item
 * @param msg
 */
//这三个方法分别用来显示提示信息,错误信息,正确信息
function showInfo(item,msg){
    document.getElementById(item.id+"_msg").innerHTML=msg;
    document.getElementById(item.id+"_msg").className="validate_info";
}

function showError(item,msg){
    document.getElementById(item.id+"_msg").innerHTML=msg;
    document.getElementById(item.id+"_msg").className="validate_error";
}

function showOk(item,msg){
    document.getElementById(item.id+"_msg").innerHTML=msg;
    document.getElementById(item.id+"_msg").className="validate_ok";
}

//验证用户名
function validateAdminName(item){
    var result=true;
    var reg=/^[a-zA-Z0-9]{4,15}$/;
    if(item.value==""){
        result=false;
        showError(item,"账号不能为空");
    }
    else {
        if (!reg.test(item.value)) {
            result = false;
            showError(item, "用户名格式非法(4-15位数字或大小写英文)");
        }
        else {
           onload = $.ajax({
                url: "AdminServlet.do",
                type: "post",
                async: false,
                data: {flag: "validateAdmin", adminName: $("#adminName").val()},
                dataType: "text",
                success: function (data) {
                    if (data == "该管理员用户已存在") {
                        result = false;
                        $("#adminName_msg").html(data);
                        $("#adminName_msg").addClass("validate_error");
                    }
                }
            });
            if(result)
            {
                showOk(item, "验证通过");
            }
        }
    }
    return result;
}

//验证密码
function validatePassword(item){
    var result=true;
    var reg=/^[a-zA-Z0-9]{6,20}$/;
    if(item.value==""){
        result=false;
        showError(item,"密码不能为空");
    }
    else {
        if (!reg.test(item.value)) {
            result = false;
            showError(item, "密码格式非法!(数字或英文,6-20位) ");
        } else {
            showOk(item, "验证通过");
        }
    }
    return result;
}

//验证确认密码
function validateConfirm(item){
    var result=true;
    if(item.value==""){
        result=false;
        showError(item,"请输入确认密码!");
    }
    else{
        if(item.value!=document.getElementById("password").value){
            result=false;
            showError(item,"两次输入的密码不一致");
        }
        else{
            showOk(item,"验证通过");
        }
    }

    return result;
}

//总验证
function validate(){
    var result=true;
    //验证用户名
    if(validateAdminName(document.getElementById("adminName"))==false){
        result=false;
    }

    //验证密码
    if(validatePassword(document.getElementById("password"))==false){
        result=false;
    }

    //验证重复密码
    if(validateConfirm(document.getElementById("pwdconfirm"))==false){
        result=false;
    }

    if(result==true){
        return confirm("确定要提交吗");
    }

    return result;
}