<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
  <%--引入bootstrap--%>
<%--  <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
  <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>--%>
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="<%=basePath %>/static/js/jquery.js"></script>--%>
<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});
</script>
  <!-- 引入bootstrap分页 -->
  <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
  <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
  <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
  <script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
  <script>
      $(function() {
          $('#pagination').bootstrapPaginator({
              bootstrapMajorVersion: 3,
              currentPage: ${requestScope.pageInfo.pageNum },
              totalPages: ${requestScope.pageInfo.pages },
              pageUrl: function(type, page, current) {
                  return 'inroominfo/toInRoomInfo.do?pageNum=' + page+"&flag=${flag}&value=${value}";
              },
              itemTexts: function(type, page, current) {
                  switch(type) {
                      case "first":
                          return "首页";
                      case "prev":
                          return "上一页";
                      case "next":
                          return "下一页";
                      case "last":
                          return "末页";
                      case "page":
                          return page;
                  }
              }
          });
      });


      //复选框单击事件
      function allOrNoAll(){
          //1、获取发生单击事件的标签
          var $c = $(event.target);//是一个dom对象---->jquery对象
          //2、取出其中的checked属性值，判断
          var flag = $c.prop("checked");
          if(flag){//全选
              $("tbody input[type=checkbox]").prop("checked",true);
          }else{//全不选
              $("tbody input[type=checkbox]").prop("checked",false);
          }
      }
  </script>

</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="main.html">首页</a></li>
    <li><a href="#">入住管理</a></li>
    <li><a href="#">入住信息查询</a></li>
  </ul>
</div>
<div class="rightinfo">
  <div class="tools">
    <ul class="toolbar">
      <li class="click"><span><img src="<%=basePath %>/static/images/t01.png" /></span>添加</li>
      <li class="click" id="singleUpdate"><span><img src="<%=basePath %>/static/images/t02.png" /></span>修改</li>
      <li id="batchDel"><span><img src="<%=basePath %>/static/images/t03.png" /></span>删除</li>
    </ul>
    
    <div class="toolbar1">
      <table>
        <form method="post" action="<%=basePath %>/inroominfo/toInRoomInfo.do" name="serch">
          <tr>
            <td class="zi"><span>选择分类：</span></td>
            <td>
              <select name="flag">
                <option value="0" <c:if test="${flag=='0'}">selected</c:if>>全部</option>
                <option value="1" <c:if test="${flag=='1'}">selected</c:if>>房间号</option>
                <option value="2" <c:if test="${flag=='2'}">selected</c:if>>客人姓名</option>
                <option value="3" <c:if test="${flag=='3'}">selected</c:if>>手机号码</option>
                <option value="4" <c:if test="${flag=='4'}">selected</c:if>>身份证号码</option>
              </select></td>
            <td class="zi"><span>关键字：</span></td>
            <td><input type="text" name="value" value="${value}"/></td>
            <td><input type="submit" value="查询" class="button"/></td>
          </tr>
        </form>
      </table>
    </div>
    
  </div>
  <table class="tablelist">
    <thead>
      <tr>
        <th><input name="" onclick="allOrNoAll()" type="checkbox" value=""/></th>
        <th>编号</th>
        <th>房间号</th><th>房间类型</th>
        <th>客人姓名</th>
        <th>性别</th>
        <th>身份证号码</th>
        <th>手机号码</th>
        <th>押金</th>
        <th>入住时间</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${pageInfo.list}" var="map" varStatus="num">
        <tr>
<%--
          <td><input type="checkbox" <c:if SMSUtil="${map.out_room_status=='1'}"> data-toggle="tooltip" title="不能够对未退房记录进行编辑" disabled</c:if>  value="${map.id}" flag="${map.out_room_status}"/></td>
--%>
          <td><input type="checkbox" value="${map.id}" shouji="${map.phone}" fangjian="${map.room_num}" flag="${map.out_room_status}"/></td>
          <td>${num.count}</td>
          <td>${map.room_num}</td>
          <td>${map.room_type_name}</td>
          <td>${map.customer_name}</td>
          <td>${map.gender=='1'?'男':'女'}</td>
          <td>${map.idcard}</td>
          <td>${map.phone}</td>
          <td>${map.money}</td>
          <td>${map.create_date}</td>
          <td>
              <c:choose>
                  <c:when test="${map.out_room_status=='0'}"><a href="out.jsp" class="tablelink">退房</a></c:when>
                  <c:otherwise><a href="javascript:void(0)" class="tablelink" style="color: red">已退房</a></c:otherwise>
              </c:choose>
              <%--<a href="javascript:void(0)" class="tablelink" onclick="singleDel(${map.id})"  data-toggle="modal"
                 data-target="#myModal">删除</a>--%>
            <a href="javascript:void(0)" class="tablelink" onclick="singleDel(${map.id},${map.out_room_status})">删除</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 把分页搞出来 -->
  <ul id="pagination"></ul>

  <div class="tip">
    <div class="tiptop"><span>提示信息</span><a></a></div>
    <div class="tipinfo"> <span><img src="images/ticon.png" /></span>
      <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite> </div>
    </div>
    <div class="tipbtn">
      <input name="" type="button"  class="sure" value="确定" />
      &nbsp;
      <input name="" type="button"  class="cancel" value="取消" />
    </div>
  </div>
</div>

<%--删除时触发模态框--%>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="myModalLabel">
          提示
        </h4>
      </div>
      <div class="modal-body">
        您确认删除本条记录吗
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">关闭
        </button>
        <button onclick="ok()" type="button" class="btn btn-primary">
          确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<!-- 模态框-提示 -->
<div class="modal fade" id="msg" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="mLabel">
          提示
        </h4>
      </div>
      <div class="modal-body">
        不能删除还未退房的记录
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"
                data-dismiss="modal">关闭
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<div class="modal fade" id="error" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="errorLabel">
          提示
        </h4>
      </div>
      <div class="modal-body">
        亲，删除失败，请重试!
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"
                data-dismiss="modal">确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<%--批量删除时，没有选中记录的提示框--%>
<div class="modal fade" id="info" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="info2">
          提示
        </h4>
      </div>
      <div class="modal-body">
        没有选中记录！！！
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"
                data-dismiss="modal">确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<%--批量删除时，选中的记录中包含未退房信息，提示框--%>
<div class="modal fade" id="weiTuiFang" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="weiTuiFang2">
          提示
        </h4>
      </div>
      <div class="modal-body">
          选中的记录中不能包含未退房记录!!!
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"
                data-dismiss="modal">确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<%--修改入住信息的模态框--%>
<div class="modal fade" id="updateInRoomInfo" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="updateInRoomInfo2">
          修改
        </h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form">
          <input type="hidden" name="iriId">
          <div class="form-group">
            <label for="oldRoom" class="col-sm-2 control-label">原房间</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" readonly id="oldRoom">
            </div>
          </div>
          <div class="form-group">
            <label for="room_num" class="col-sm-2 control-label">房间</label>
            <div class="col-sm-10">
              <select id="room_num" name="room_num" class="form-control">

              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="phone" class="col-sm-2 control-label">手机</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="phone">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">取消
        </button>
        <button type="button" id="updateOk" class="btn btn-primary"
                data-dismiss="modal">确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');

	var iriId;
	/*单个删除，触发单击事件*/
	function singleDel(id,status){
	    //判断是否已经退房
	    //手动打开模态框
        if(status=='0'){
            $('#msg').modal('show');
        }else{
            $('#myModal').modal('show');
            iriId=id;
        }

    }
    /*单个删除确定，关闭模态框*/
    function ok(){
        $('#myModal').modal('hide');
        //触发ajax
        $.ajax({
            url:"<%=basePath %>inroominfo/updateInRoomInfoById.do",
            type:"POST",
            data:{
                "id":iriId
            },
            dataType:"JSON",
            success:function(rs){
                if(rs){//删除成功
                    window.location.reload();
                }else{//删除失败
                    $('#error').modal('show');
                }
            }
        });
        //根据ajax的返回值结果进一步处理
    }

    //修改
    $(function(){
        //修改确定--->触发ajax将数据保存到数据库中去
        $("#updateOk").click(function(){
            $.ajax({
                url:"<%=basePath %>inroominfo/updateInRoomInfo.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "oldRoomNum":$("#oldRoom").val(),
                    "iriId":$("input[name=iriId]").val(),
                    "room_id":$("#room_num>option:selected").val(),
                    "phone":$("#phone").val()
                },
                success:function(rs){
                    if(rs){//修改成功
                      window.open("<%=basePath %>/inroominfo/toInRoomInfo.do","_self");
                    }else{
                      //模态框提示
                        alert("修改失败");
                    }
                }
            });
        });

        //入住信息修改
        $("#singleUpdate").click(function(){
            var $cks = $("tbody input[type=checkbox]:checked");
            var len = $cks.size();
            if(len==0){//未选中
                alert("未选中要修改的记录");
            }else if(len==1){//选中一行
                var inRoomStatus = $cks.attr("flag");
                //判断是否已经退房
                if(inRoomStatus=='0'){//客人还未退房
                    //往窗口中添加指定的数据
                    var phone = $cks.attr("shouji");
                    var fangjian = $cks.attr("fangjian");
                    var iriId = $cks.val();
                    //回显值
                    $("#oldRoom").val(fangjian);
                    $("#phone").val(phone);
                    $("input[name=iriId]").val(iriId);
                    //触发ajax--->动态获取空闲房间
                    $.ajax({
                        url:"<%=basePath %>inroominfo/getKXRoom.do",
                        type:"POST",
                        dataType:"JSON",
                        success:function(rs){
                            var content = "";
                            for(var i in rs){
                                var room_num = rs[i].room_num;
                                var room_id = rs[i].id;
                                content +="<option value='"+room_id+"'>"+room_num+"</option>";
                            }
                            $("#room_num").html(content);
                        }
                    });
                    //弹出修改的模态框
                    $("#updateInRoomInfo").modal("show");
                }else{//已经退房
                    alert("不能对已经退房的记录进行修改");
                }
            }else if(len>=2){
                alert("修改不能选中多行");
            }
        });

        //点击删除--批量删除
        $("#batchDel").click(function(){
            //判断有没有勾选
            var $cks = $("tbody input[type=checkbox]:checked");
            var len = $cks.size();
            if(len==0){//没有选中记录
                $('#info').modal('show');
            }else{//触发ajax，做批量删除
                //判断记录是否包含未退房信息
                var f =true;//记录中不包含未退房信息
                $cks.each(function(index,dom){
                    var flag = $(dom).attr("flag");
                    console.log("flag="+flag);
                    if(flag=='0'){//未退房
                        f = false;//包含未退房信息
                        return;
                    }
                });
                if(f){
                    var idStr = "";
                    //将多个id值以","拼接成字符串
                    $cks.each(function(index,dom){
                        var iriId = $(dom).attr("value");
                        idStr+=iriId+",";
                    });
                    $.ajax({
                      url:"<%=basePath %>inroominfo/batchUpdateInRoomInfo.do",
                      type:"POST",
                      data:{
                          "idStr":idStr
                      },
                      dataType:"JSON",
                      success:function(rs){
                          if(rs){//删除成功
                              //window.location.reload();
                              //window.top.location.reload();
                              window.open("<%=basePath %>inroominfo/toInRoomInfo.do","_self");
                          }else{//删除失败
                              //$('#error').modal('show');
                              alert("批量删除失败");
                          }
                      }
                  });
                }else{
                    $('#weiTuiFang').modal('show');
                }
            }
        });
    });
</script>
</body>
</html>
