<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>客房信息列表</title>
    <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
    <style type="text/css">
        .kx,.yrz,.ds{
            width: 100px;
            height:100px;
            display: inline-block;
            margin-bottom: 10px;
            text-align: center;
            cursor: pointer;
        }
        /*空闲*/
        .kx{ background: green; }
        /*已经入住*/
        .yrz{background: red;}
        /*打扫*/
        .ds{background: yellow;}

        /*房间状态图标*/
        .icon{
            height: 20px;
            width: 20px;
            display: inline-block;
        }
        /*定义一个零时样式*/
        .temp{
            width: 100px;
            height:100px;
            border:solid 2px black;
        }
    </style>
    <script type="text/javascript">
        /*选中某个房间*/
        function select(){
            //1、获取点击的div标签
            var $cTag = $(event.target);
            //2、移除其他无关div的temp样式
            $("div").removeClass("temp");
            //3、给点击的div标签添加class="temp"的样式
            $cTag.addClass("temp");
            //4、往div中添加标记
            $("div[flag=1]").attr("flag","0");
            $cTag.attr("flag","1");
        }
    </script>
</head>
<body>
    <div class="icon" style="background: green"></div> 空闲
    <div class="icon" style="background: red"></div>  已经入住
    <div class="icon" style="background: yellow"></div> 打扫
    &nbsp;&nbsp;&nbsp;&nbsp;
    <button style="background: pink" id="ds">保洁打扫</button>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <button style="background: pink" id="edit">编辑房间</button>
    <hr>
    <c:forEach items="${roomList}" var="map">
        <div roomNum="${map.room_num}" roomStatus="${map.room_status}" flag="0" onclick="select()" class="${map.room_status=='0'?'kx':(map.room_status=='1'?'yrz':'ds')}">
            ${map.room_status=='0'?'空闲':(map.room_status=='1'?'已入住':'打扫')}<br>
            ${map.room_num}<br>
            ${map.room_type_name}<br>
            ${map.room_price}
        </div>
    </c:forEach>


    <%--保洁模态框--%>
    <div class="modal fade" id="dsRoom" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="dsRoom2">
                        保洁
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="smsText" class="col-sm-2 control-label">信息</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="smsText">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-2 control-label">手机</label>
                            <div class="col-sm-10">
                                <select id="phone" name="phone" class="form-control">
                                    <option value="18271492181">刘阿姨-18271492181</option>
                                    <option value="13042725201">王阿姨-13042725201</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="roomNum" class="col-sm-2 control-label">房间</label>
                            <div class="col-sm-10">
                                <select id="roomNum" name="roomNum" class="form-control">
                                    <option value="0">--请选择--</option>
                                    <option value="8805">8805</option>
                                    <option value="8806">8806</option>
                                    <option value="8807">8807</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="button" id="dsRoomOk" class="btn btn-primary"
                            data-dismiss="modal">通知
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

   <%--编辑房间--%>
    <div class="modal fade" id="editRoom" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="editRoom2">
                        编辑房间
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="roomNum" class="col-sm-2 control-label">房间号</label>
                            <div class="col-sm-10">
                                <input type="text" readonly class="form-control" name="roomNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="roomNum" class="col-sm-2 control-label">原状态</label>
                            <div class="col-sm-10">
                                <input type="text" readonly class="form-control" name="roomStatus">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="roomStatus" class="col-sm-2 control-label">房间状态</label>
                            <div class="col-sm-10">
                                <select name="roomStatus" class="form-control">
                                    <option value="0">空闲</option>
                                    <option value="1">已入住</option>
                                    <option value="2">打扫</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="button" id="editRoomOk" class="btn btn-primary"
                            data-dismiss="modal">修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <script type="text/javascript">
        $(function(){
            //弹出模态框
            $("#ds").click(function(){
                //触发ajax，从后台获取房间
                //显示模态框
                $("#dsRoom").modal('show');
            });

            //当选择保洁窗口中的房间时，触发
            $("#roomNum").change(function(){
                var content = $(this).find("option:selected").prop("value");
                console.log(content);
                if(content=='0'){
                    $("#smsText").val("");
                }else{
                    $("#smsText").val(content+"号房间目前处于打扫状态，请及时打扫");
                }
            });

            //发送短信
            $("#dsRoomOk").click(function(){
                $.ajax({
                    url:"<%=basePath %>/room/sendDsSMS.do",
                    type:"POST",
                    dataType:"JSON",
                    data:{
                        "smsText":$("#smsText").val(),
                        "phone":$("#phone>option:selected").val()
                    },
                    success:function(rs){
                        if(rs){
                            alert("已经通知成功");
                        }else{
                            alert("发送失败，请重试");
                        }
                    },
                    error:function(rs){
                        alert("发送短信ajax失败");
                    }
                });
            });

            //点击编辑房间按钮时，弹出模态框
            $("#edit").click(function(){
                //首先判断有没有选中房间
                var $divs = $("div[flag=1]");
                var len = $divs.size();
                if(len==1){//选中了
                    //回显数据
                   var roomNum= $divs.attr("roomNum");
                   var roomStatus=$divs.attr("roomStatus");
                   if("0"==roomStatus){
                       roomStatus="空闲";
                   }else if("1"==roomStatus){
                       roomStatus="已入住";
                   }else if("2"==roomStatus){
                       roomStatus="打扫";
                   }
                   $("#editRoom input[name=roomNum]").val(roomNum);
                   $("#editRoom input[name=roomStatus]").val(roomStatus);
                    //显示模态框
                    $("#editRoom").modal('show');
                }else{
                    //模态框提示
                    alert("请选择要修改的房间");
                }

            });

            //编辑房间弹出模态框，点击模态框中的修改时，修改房间状态
            jQuery("#editRoomOk").click(function(){
                jQuery.ajax({
                    url:"<%=basePath %>/room/updateRoomStatusByRoomNum.do",
                    type:"POST",
                    dataType:"JSON",
                    data:{
                        "roomNum":$("#editRoom input[name=roomNum]").val(),
                        "roomStatus":$("#editRoom select[name=roomStatus]>option:selected").val()
                    },
                    success:function(rs){
                        console.log("修改房间状态rs="+rs);
                        if(rs){
                            window.location.reload();
                        }else{
                            //模态框提示
                            alert("修改失败，请重试");
                        }
                    },
                    error:function(rs){
                        alert("哎呀，失败了");
                    }
                });
            });
        });
    </script>
</body>
</html>
