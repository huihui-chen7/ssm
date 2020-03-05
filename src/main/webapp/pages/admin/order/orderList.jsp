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
                  return 'order/toOrderList.do?pageNum=' + page+"&flag=${flag}&value=${value}";
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
    <li><a href="#">订单管理</a></li>
    <li><a href="#">订单信息</a></li>
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
        <form method="post" action="<%=basePath %>/order/toOrderList.do" name="serch">
          <tr>
            <td class="zi"><span>选择分类：</span></td>
            <td>
              <select name="flag">
                <option value="0" <c:if test="${flag=='0'}">selected</c:if>>全部</option>
                <option value="1" <c:if test="${flag=='1'}">selected</c:if>>客人姓名</option>
                <option value="2" <c:if test="${flag=='2'}">selected</c:if>>手机号码</option>
                <option value="3" <c:if test="${flag=='3'}">selected</c:if>>身份证号码</option>
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
        <th>序号</th>
        <th>订单编号</th>
        <th>订单金额</th>
        <th>订单状态</th>
        <th>备注</th>
        <th>创建时间</th>
        <th>客户名</th>
        <th>身份证号</th>
        <th>手机号</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${pageInfo.list}" var="map" varStatus="num">
        <tr>
          <td><input type="checkbox" value="${map.orderId}" /></td>
          <td>${num.count}</td>
          <td>${map.order_num}</td>
          <td>${map.order_money}</td>
          <td>${map.order_status=='1'?'已结算':'未结算'}</td>
          <td>${map.remark}</td>
          <td>${map.order_createdate}</td>
          <td>${map.customer_name}</td>
          <td>${map.idcard}</td>
          <td>${map.phone}</td>
          <td>
              <c:choose>
                <c:when test="${map.order_status=='1' && map.out_room_status=='1'}">
                   <a href="#">删除</a>
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

</body>
</html>
