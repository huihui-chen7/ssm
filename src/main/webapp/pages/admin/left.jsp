<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统菜单</title>
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=basePath %>/static/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson .header").click(function(){
		var $parent = $(this).parent();
		$(".menuson>li.active").not($parent).removeClass("active open").find('.sub-menus').hide();
		
		$parent.addClass("active");
		if(!!$(this).next('.sub-menus').size()){
			if($parent.hasClass("open")){
				$parent.removeClass("open").find('.sub-menus').hide();
			}else{
				$parent.addClass("open").find('.sub-menus').show();	
			}
			
		}
	});
	
	// 三级菜单点击
	$('.sub-menus li').click(function(e) {
        $(".sub-menus li.active").removeClass("active")
		$(this).addClass("active");
    });
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('.menuson').slideUp();
		if($ul.is(':visible')){
			$(this).next('.menuson').slideUp();
		}else{
			$(this).next('.menuson').slideDown();
		}
	});
})	
</script>
</head>

<body style="background:#fff3e1;">
<div class="lefttop"><span></span>功能菜单</div>
<dl class="leftmenu">
  <dd>
    <div class="title"> <span><img src="<%=basePath %>/static/images/leftico03.png" /></span>入住管理</div>
    <ul class="menuson">
      <li>
        <div class="header"> <cite></cite> <a href="<%=basePath %>/inroominfo/toInRoomInfo.do" target="rightFrame">入住信息查询</a> <i></i> </div>
      </li>
      <li>
        <div class="header"> <cite></cite> <a href="<%=basePath %>/inroominfo/toCheckInPage.do" target="rightFrame">入住信息添加</a> <i></i> </div>
      </li>
      <li class="active">
        <div class="header"><cite></cite><a href="<%=basePath %>/pages/admin/bill/billinfo.jsp" target="rightFrame">消费记录</a><i></i></div>
      </li>
      <li>
        <div class="header">
        <cite></cite><a href="<%=basePath %>/inroominfo/toOutPage.do" target="rightFrame">结账退房</a><i></i></li>
      </div>
    </ul>
  </dd>
  <dd>
    <div class="title"> <span><img src="<%=basePath %>/static/images/leftico03.png" /></span>订单管理</div>
    <ul class="menuson">
      <li><div class="header"><cite></cite><a href="<%=basePath %>/order/toOrderList.do" target="rightFrame">订单信息</a><i></i></div></li>
      <li><div class="header"><cite></cite><a href="<%=basePath %>/pages/admin/order/addOrder.jsp" target="rightFrame">添加订单</a><i></i></div></li>
    </ul>
  </dd>
  <dd>
    <div class="title"><span><img src="<%=basePath %>/static/images/leftico03.png" /></span>会员管理</div>
    <ul class="menuson">
      <li>
        <div class="header"><cite></cite><a href="vip/vipinfo.html" target="rightFrame">会员信息查询</a><i></i></div>
      </li>
      <li>
        <div class="header"><cite></cite><a href="vip/vipmanage.html" target="rightFrame">会员信息管理</a><i></i></div>
      </li>
      <li>
        <div class="header"><cite></cite><a href="vip/addvip.html" target="rightFrame">添加会员</a><i></i></div>
      </li>
    </ul>
  </dd>
  <dd>
    <div class="title"><span><img src="<%=basePath %>/static/images/leftico03.png" /></span>客房管理</div>
    <ul class="menuson">
      <li><div class="header"><cite></cite><a href="<%=basePath %>/room/toRoomListPage.do" target="rightFrame">客房信息查询</a><i></i></div></li>
      <li><div class="header"><cite></cite><a href="<%=basePath %>/room/toRoomTypeListPage.do" target="rightFrame">房型信息管理</a><i></i></div></li>
<%--
      <li><div class="header"><cite></cite><a href="room/addroom.html" target="rightFrame">添加客房</a><i></i></div></li>
--%>
    </ul>
  </dd>
  <dd>
    <div class="title"><span><img src="<%=basePath %>/static/images/leftico03.png" /></span>用户管理</div>
    <ul class="menuson">
      <li><div class="header"><cite></cite><a href="user/userinfo.html" target="rightFrame">用户信息查询</a><i></i></div></li>
      <li><div class="header"><cite></cite><a href="user/usermanage.html" target="rightFrame">用户信息管理</a><i></i></div></li>
      <li><div class="header"><cite></cite><a href="user/adduser.html" target="rightFrame">添加用户</a><i></i></div></li>
    </ul>
  </dd>
  <dd>
    <div class="title"><span><img src="<%=basePath %>/static/images/leftico03.png" /></span><a href="suggestion/suggestion.html" target="rightFrame">客人意见</a></div>
  </dd>
</dl>
</body>
</html>