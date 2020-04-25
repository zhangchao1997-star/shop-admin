function tick(){
    var time=new Date();
    var month = time.getMonth()+1;
    var date1= time.getFullYear()+"年"+month+"月"+time.getDate()+"日    "+time.getHours()+"时"+time.getMinutes()+"分"+time.getSeconds()+"秒";
    var div = document.getElementById("div_date");
    div.innerHTML = date1;
}
setInterval("tick()",1000);
