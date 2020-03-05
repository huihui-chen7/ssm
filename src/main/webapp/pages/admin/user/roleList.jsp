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
<link href="<%=basePath %>static/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath %>/static/js/jquery.js"></script>
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
                  return 'authority/toRoleList.do?pageNum='+page;
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
    <li><a href="#">系统用户管理</a></li>
    <li><a href="#">角色信息管理</a></li>
  </ul>
</div>
<div class="rightinfo">
  <div class="tools">
    <ul class="toolbar">
      <li class="click" id="addRole"><span><img src="<%=basePath %>/static/images/t01.png" /></span>添加角色</li>
      <li><span><img src="<%=basePath %>/static/images/t03.png" /></span>删除角色</li>
    </ul>
  </div>
  <table class="tablelist">
    <thead>
      <tr>
        <th><input name="" type="checkbox" value="" checked="checked"/></th>
        <th>编号</th>
        <th>角色名</th>
        <th>修改时间</th>
        <th>状态</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${pageInfo.list}" var="map" varStatus="num">
        <tr>
          <td><input name="" type="checkbox" value="" /></td>
          <td>${num.count}</td>
          <td>${map.role_name}</td>
          <td>${map.create_date}</td>
          <td>${map.status=='1'?'启用':'禁用'}</td>
          <td>
            <c:choose>
              <c:when test="${map.flag=='0'}">
                <a href="javascript:void(0)" roleId="${map.id}" class="tablelink">编辑</a>
              </c:when>
              <c:otherwise>
                  无操作
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 把分页搞出来 -->
  <ul id="pagination"></ul>
</div>

<%--添加角色--%>
<div class="modal fade" id="addRoleWin" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="tianRoom2">
          添加角色
        </h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form">
          <div class="form-group">
            <label for="roleName" class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="roleName">
            </div>
          </div>
          <div class="form-group">
            <label for="roleStatus" class="col-sm-2 control-label">状态</label>
            <div class="col-sm-10">
              <select name="roleStatus" class="form-control">
                <option value="0">禁用</option>
                <option value="1">启用</option>
              </select>
            </div>
          </div>
          <%--授权模块--%>
          <div class="form-group">
            <label for="authId" class="col-sm-2 control-label">授权</label>
            <div class="col-sm-10">
                <table>
                  <c:forEach items="${ptAuthList}" var="oneMenu">
                    <tr>
                      <td width="80px" align="left"><h6>${oneMenu.oneName}</h6></td>
                      <td>
                        <c:forEach items="${oneMenu.twoMenuList}" var="twoMenu">
                          <input type="checkbox" oneId="${oneMenu.oneId}" twoId="${twoMenu.twoId}">${twoMenu.twoName}&nbsp;&nbsp;
                        </c:forEach>
                      </td>
                    </tr>
                  </c:forEach>
                </table>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">取消
        </button>
        <button type="button" id="addRoleOk" class="btn btn-primary"
                data-dismiss="modal">确定
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<%--编辑角色--%>
<div class="modal fade" id="editRoleWin" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"
                data-dismiss="modal" aria-hidden="true">
          &times;
        </button>
        <h4 class="modal-title" id="editRoleWin2">
          编辑角色
        </h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form">
          <div class="form-group">
            <label for="roleName" class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="roleName">
            </div>
          </div>
          <div class="form-group">
            <label for="roleStatus" class="col-sm-2 control-label">状态</label>
            <div class="col-sm-10">
              <select name="roleStatus" class="form-control">
                <option value="0">禁用</option>
                <option value="1">启用</option>
              </select>
            </div>
          </div>
          <input type="hidden" name="roleId">
          <%--授权模块--%>
          <div class="form-group">
            <label for="authId" class="col-sm-2 control-label">授权</label>
            <div class="col-sm-10">
              <table class="authDisplay">
                <c:forEach items="${ptAuthList}" var="oneMenu">
                  <tr>
                    <td width="80px" align="left"><h6>${oneMenu.oneName}</h6></td>
                    <td>
                      <c:forEach items="${oneMenu.twoMenuList}" var="twoMenu">
                        <input type="checkbox" oneId="${oneMenu.oneId}" twoId="${twoMenu.twoId}">${twoMenu.twoName}&nbsp;&nbsp;
                      </c:forEach>
                    </td>
                  </tr>
                </c:forEach>
              </table>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">取消
        </button>
        <button type="button" id="editRoleOk" class="btn btn-primary"
                data-dismiss="modal">修改
        </button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal -->
</div>

<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

<script type="text/javascript">
    $(function(){
        //点击编辑a标签，弹出编辑窗口
        $(".tablelink").click(function(){
            //执行ajax获取数据
            jQuery.ajax({
                url:"<%=basePath %>/authority/getRoleDetailInfo.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "roleId":$(this).attr("roleId")
                },
                success:function(rs){
                    //回显之前先清空
                    $(".authDisplay input[type=checkbox]").prop("checked",false);
                  //rs中封装了role_name、status、roleAuthList(权限list集合)
                    var role_name = rs.role_name;
                    var status = rs.status;
                    var roleAuthList = rs.roleAuthList;
                    var roleId = rs.id;
                    //回显角色id
                    $("#editRoleWin input[name=roleId]").val(roleId);
                    //进行数据回显
                    $("#editRoleWin input[name=roleName]").val(role_name);
                    if('0'==status) {//禁用
                        $("#editRoleWin select[name=roleStatus]>option[value='0']").prop("selected",true);
                    }else if('1'==status){//启用
                        $("#editRoleWin select[name=roleStatus]>option[value='1']").prop("selected",true);
                    }
                    //回显权限信息
                    for(var i in roleAuthList){
                      var authId = roleAuthList[i];
                      $(".authDisplay input[twoId="+authId+"]").prop("checked",true);
                    }
                    //显示模态框
                    $("#editRoleWin").modal('show');
                },
                error:function(rs){
                    alert("哎呀，失败了");
                }
            });

        });

        //点击编辑角色窗口中的修改按钮，请求后台，将数据保存进数据库中去
        $("#editRoleOk").click(function(){
            //获取所有被选中的一级权限和二级权限的主键，并且以","拼接成字符串
            var $cks = $("#editRoleWin input[type=checkbox]:checked");
            var authIdStr = "";
            $cks.each(function(index,dom) {
                var oneId = $(dom).attr("oneId");
                var twoId = $(dom).attr("twoId");
                authIdStr += oneId + "," + twoId + ","
            });
            jQuery.ajax({
                url:"<%=basePath %>/authority/updateRoleInfo.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "roleId":$("#editRoleWin input[name=roleId]").val(),
                    "role_name":$("#editRoleWin input[name=roleName]").val(),
                    "roleStatus":$("#editRoleWin select[name=roleStatus]>option:selected").val(),
                    "authIdStr":authIdStr
                },
                success:function(rs){
                    if(rs){//修改成功
                        window.open("<%=basePath %>/authority/toRoleList.do","_self");
                    }else{//修改失败
                        //模态框提示
                        alert("角色信息修改失败");
                    }
                },
                error:function(rs){
                    alert("哎呀，失败了");
                }
            });
        });

        //点击添加角色按钮，弹出模态框
        $("#addRole").click(function(){
            $("#addRoleWin").modal('show');
        });

        //点击模态框中的确定按钮，将数据保存进数据库中去
        $("#addRoleOk").click(function(){
            //获取所有被选中的一级权限和二级权限的主键，并且以","拼接成字符串
            var $cks = $("#addRoleWin input[type=checkbox]:checked");
            var authIdStr = "";
            $cks.each(function(index,dom) {
                var oneId = $(dom).attr("oneId");
                var twoId = $(dom).attr("twoId");
                authIdStr += oneId + "," + twoId + ","
            });
            jQuery.ajax({
                url:"<%=basePath %>/authority/addRole.do",
                type:"POST",
                dataType:"JSON",
                data:{
                    "roleName":$("#addRoleWin input[name=roleName]").val(),
                    "roleStatus":$("#addRoleWin select[name=roleStatus]>option:selected").val(),
                    "authIdStr":authIdStr
                },
                success:function(rs){
                    if(rs){
                        window.open("<%=basePath %>/authority/toRoleList.do","_self");
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
