<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <base href="<%=basePath %>">
<title>无标题文档</title>
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
  <!-- 引入bootstrap分页 -->
  <!-- 引入bootstrap分页 -->
  <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
  <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
  <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
  <script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
  <script type="text/javascript">
      $(function() {
          $('#pagination').bootstrapPaginator({
              bootstrapMajorVersion: 3,
              currentPage: ${requestScope.pageInfo.pageNum },
              totalPages: ${requestScope.pageInfo.pages },
              pageUrl: function(type, page, current) {
                  return 'room/toRoomTypeListPage.do?pageNum=' + page;
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

  </script>

</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="main.html">首页</a></li>
    <li><a href="#">客房管理</a></li>
    <li><a href="#">房型信息管理</a></li>
  </ul>
</div>
<div class="rightinfo">
  <div class="tools">
    <ul class="toolbar">
      <li class="click" id="addRoomType"><span><img src="<%=basePath %>/static/images/t01.png" /></span>添加房型</li>
      <li class="click" id="addRoom"><span><img src="<%=basePath %>/static/images/t01.png" /></span>添加客房</li>
      <li><span><img src="<%=basePath %>/static/images/t03.png" /></span>删除房型</li>
      <li><span><img src="<%=basePath %>/static/images/t03.png" /></span>删除房间</li>
    </ul>

    
  </div>
  <table class="tablelist">
    <thead>
      <tr>
        <th><input name="" type="checkbox" value="" checked="checked"/></th>
        <th>编号</th>
        <th>房型</th>
        <th>单价</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${pageInfo.list}" var="map" varStatus="num">
          <tr>
            <td><input name="" type="checkbox" value="" /></td>
            <td>${num.count}</td>
            <td>${map.room_type_name}</td>
            <td>${map.room_price}</td>
          </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 把分页搞出来 -->
  <ul id="pagination"></ul>


  <%--添加房型--%>
  <div class="modal fade" id="tianRoomType" tabindex="-1" role="dialog"
       aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close"
                  data-dismiss="modal" aria-hidden="true">
            &times;
          </button>
          <h4 class="modal-title" id="tianRoomType2">
            添加房型
          </h4>
        </div>
        <div class="modal-body">
          <form class="form-horizontal" role="form">
            <input type="hidden" name="iriId">
            <div class="form-group">
              <label for="roomTypeName" class="col-sm-2 control-label">房型名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="roomTypeName">
              </div>
            </div>
            <div class="form-group">
              <label for="roomPrice" class="col-sm-2 control-label">单价</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="roomPrice">
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default"
                  data-dismiss="modal">取消
          </button>
          <button type="button" id="addRoomTypeOk" class="btn btn-primary"
                  data-dismiss="modal">确定
          </button>
        </div>
      </div>
    </div>
  </div>

  <%--添加房间--%>
  <div class="modal fade" id="tianRoom" tabindex="-1" role="dialog"
       aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close"
                  data-dismiss="modal" aria-hidden="true">
            &times;
          </button>
          <h4 class="modal-title" id="tianRoom2">
            添加房间
          </h4>
        </div>
        <div class="modal-body">
          <form class="form-horizontal" role="form">
            <input type="hidden" name="iriId">
            <div class="form-group">
              <label for="roomNum" class="col-sm-2 control-label">房间号</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="roomNum">
              </div>
            </div>
            <div class="form-group">
              <label for="roomStatus" class="col-sm-2 control-label">房间状态</label>
              <div class="col-sm-10">
                <select id="roomStatus" name="roomStatus" class="form-control">
                    <option value="0">空闲</option>
                    <option value="2">打扫</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="roomTypeId" class="col-sm-2 control-label">房间类型</label>
              <div class="col-sm-10">
                <select id="roomTypeId" name="roomTypeId" class="form-control">

                </select>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default"
                  data-dismiss="modal">取消
          </button>
          <button type="button" id="tianRoomOk" class="btn btn-primary"
                  data-dismiss="modal">确定
          </button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal -->
  </div>


<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');

	$(function(){
	    //判断指定的房型名是否存在
	    $("#roomTypeName").blur(function(){
              $.ajax({
                  url:"<%=basePath %>/room/validateRoomTypeName.do",
                  type:"POST",
                  dataType:"JSON",
                  data:{
                      "roomTypeName":$(this).val()
                  },
                  success:function(rs){
                      console.log("rs="+rs);
                      if(!rs){//不满足要求
                          $("#roomTypeName").val("房间类型名已经存在或者格式错误");
                          $("#roomTypeName").focus();
                          //alert("房间类型名已经存在或者格式错误");
                      }
                  }
              });
        });

	    //添加房型
        $("#addRoomType").click(function(){
            $("#tianRoomType").modal('show');
        });

        //添加房型，将数据保存到数据库中去
        $("#addRoomTypeOk").click(function(){
            $.ajax({
                url:"<%=basePath %>/room/addRoomType.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "roomTypeName":$("#roomTypeName").val(),
                    "price":$("#roomPrice").val()
                },
                success:function(rs){
                    if(rs){//添加房型成功
                        window.open("<%=basePath %>/room/toRoomTypeListPage.do","_self");
                    }else{//添加房型事变
                        alert("添加失败");
                    }
                }
            });
        });

        //添加房间
        $("#addRoom").click(function(){
            //触发ajax，从后台获取所有的房间类型
            $.ajax({
                url:"<%=basePath %>/room/getRoomType.do",
                type:"POST",
                dataType:"JSON",
                success:function(rs){
                    var content = "";
                    for(var i in rs){
                        content+="<option value='"+rs[i].id+"'>"+rs[i].room_type_name+"-"+rs[i].room_price+"</option>";
                    }
                    $("#roomTypeId").html(content);
                }
            });
            $("#tianRoom").modal('show');
        });

        //添加房间，将数据保存到数据库中去
        $("#tianRoomOk").click(function(){
            $.ajax({
                url:"<%=basePath %>/room/addRoom.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "roomNum":$("#roomNum").val(),
                    "roomStatus":$("#roomStatus>option:selected").val(),
                    "roomTypeId":$("#roomTypeId>option:selected").val()
                },
                success:function(rs){
                    if(rs){//添加成功
                      window.open("<%=basePath %>/room/toRoomListPage.do","_self");
                    }else{//添加失败
                      alert("房间添加失败，请重试");
                    }
                },
                error:function(rs){
                    alert("添加房间的ajax失败");
                }
            });
        });
    });
</script>
</body>
</html>
