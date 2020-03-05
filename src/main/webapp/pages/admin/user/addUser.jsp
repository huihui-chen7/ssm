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
<title>添加系统用户</title>
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>/static/css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath %>/static/js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/select-ui.min.js"></script>
<!--<script type="text/javascript" src="../../editor/kindeditor.js"></script>-->
<script type="text/javascript" src="<%=basePath %>/static/js/laydate/laydate.js"></script>
<!--<script type="text/javascript">
    KE.show({
        id : 'content7',
        cssPath : './index.css'
    });
  </script>-->
<script type="text/javascript">



$(document).ready(function(e) {
    $(".select1").uedSelect({
		width : 345			  
	});
	$(".select2").uedSelect({
		width : 167  
	});
	$(".select3").uedSelect({
		width : 100
	});
	
	
	
});


</script>
</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">系统用户管理</a></li>
    <li><a href="#">添加用户</a></li>
  </ul>
</div>
<div class="formbody">
  <div class="formtitle"><span>添加用户</span></div>
<div id="usual1" class="usual">
  <div id="tab1" class="tabson">
    <form action="<%=basePath %>/authority/addSystemUser.do" method="post">
      <ul class="forminfo">
        <li  style="margin-top:20px;">
          <label for="username" >账号<b>*</b></label>
          <div class="vocation">
            <input name="username" type="text" class="dfinput" style="width:344px;"/>
          </div>
        </li>
        <br>
        <br>
        <br>
        <br>
        <li>
          <label for="pwd" style="cursor:pointer" >密码<b>*</b></label>
          <div class="vocation">
            <input name="pwd" class="dfinput" value=""  style="width:344px;"/>
          </div>
        </li>
        <br>
        <br>
        <li>
          <label for="useStatus" style="cursor:pointer" >状态<b>*</b></label>
          <div class="vocation">
            <input name="useStatus" type="radio" value="1" />启用
            &nbsp;
            &nbsp;
            <input name="useStatus" type="radio" value="0" checked/>禁用
          </div>
        </li>
        <li>
          <label>选择角色<b>*</b></label>
          <div class="vocation">
            <select class="select1" name="roleId">
              <c:forEach items="${roleList}" var="map">
                <option value="${map.roleId}">${map.roleName}</option>
              </c:forEach>
            </select>
          </div>
        </li>
        <li>
          <label>&nbsp;</label>
          <input type="submit" class="btn" value="添加" />
        </li>
      </ul>
    </form>
  </div>
</div>
<script type="text/javascript"> 
  
      $("#usual1 ul").idTabs(); 
    </script> 
<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	
	!function(){
laydate.skin('qianhuang');
laydate({elem: '#Calendar'});
laydate.skin('qianhuang');
laydate({elem: '#Calendar2'});
}();
$(function dd(){
		var d=new Date(),str="";
		str+=(d.getFullYear()+"-");
		str+="0";
		str+=(d.getMonth()+1+"-");
		str+=d.getDate();
		$("#Calendar").attr("value",str);
		$("#Calendar2").attr("value",str);
	});

	</script>
</div>
</body>
</html>
