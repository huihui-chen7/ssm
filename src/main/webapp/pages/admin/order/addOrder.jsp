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
<link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>/static/css/select.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="/static/js/jquery.js"></script>--%>
  <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/select-ui.min.js"></script>
<%--<script type="text/javascript" src="../../editor/kindeditor.js"></script>--%>
<script type="text/javascript" src="<%=basePath%>/static/js/laydate/laydate.js"></script>
<%--<script type="text/javascript">
    KE.show({
        id : 'content7',
        cssPath : './index.css'
    });
  </script>--%>
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
  <style type="text/css">
    .hideTag{
      display: none;
    }
  </style>
</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">订单管理</a></li>
    <li><a href="#">添加订单</a></li>
  </ul>
</div>
<div class="formbody">
  <div class="formtitle"><span>订单信息</span></div>
  <div id="usual1" class="usual">
    <div id="tab1" class="tabson">
      <ul class="forminfo">
        <li  style="margin-top:20px;">
          <label for="room_num" >房间号<b>*</b></label>
          <div class="vocation">
            <input id="room_num" name="room_num" type="text" class="dfinput" style="width:344px;"/>
          </div>
        </li>
        <br />

        <li class="hideTag">
          <label for="customerName" >客户名<b>*</b></label>
          <div class="vocation">
            <input disabled name="customerName" type="text" class="dfinput" style="width:344px;"/>
          </div>
        </li>
        <br />
        <li class="hideTag">
          <label for="phone" >手机号<b>*</b></label>
          <div class="vocation">
            <input disabled name="phone" type="text" class="dfinput"  style="width:344px;"/>
          </div>
        </li>
        <br />
        <li class="hideTag">
          <label for="idcard" >身份证号<b>*</b></label>
          <div class="vocation">
            <input disabled name="idcard" type="text" class="dfinput"  style="width:344px;"/>
          </div>
        </li>
        <br />

        <li>
          <label for="order_money" >订单金额<b>*</b></label>
          <div class="vocation">
            <input id="order_money" name="order_money"  type="text" class="dfinput" style="width:344px;"/>
          </div>
        </li>
        <li>
          <label for="remark" >备注<b>*</b></label>
          <div class="vocation">
            <input name="remark" id="remark"  type="text" class="dfinput" style="width:344px;"/>
          </div>
        </li>
        <br />
        <li><cite>
          <label for="order_status">支付状态<b>*</b></label>
          <input id="order_status" name="order_status" type="radio" value="1" checked="checked" />
          已支付&nbsp;&nbsp;&nbsp;&nbsp;
          <input name="order_status" type="radio" value="0" />
          未支付</cite></li>
        <br />

        <li>
          <label>&nbsp;</label>
          <input id="addOrder" type="button" class="btn" value="添加"/>
        </li>
      </ul>
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

  <script type="text/javascript">
    $(function(){
        $("#room_num").blur(function(){
            //1、触发ajax，传递房间号roomNum过去
            $.ajax({
                url:"<%=basePath %>order/getInRoomInfoByRoomNum.do",
                type:"POST",
                data:{
                    "roomNum":$("#room_num").val()
                },
                dataType:"JSON",
                success:function(rs){
                    if(rs.ok=='0'){//输入的房间号对应的客人信息不存在
                        $(".hideTag").hide(600);
                        //模态框提示
                        alert("此房间对应的客户信息不存在!!!");
                    }else{
                        //2、根据ajax返回的结果进一步处理
                        $(".hideTag").slideDown(600);
                        //3、回显数据
                        $("input[name=phone]").val(rs.phone);
                        $("input[name=idcard]").val(rs.idcard);
                        $("input[name=customerName]").val(rs.customer_name);
                    }

                }
            });

        });

        //添加订单，触发ajax
        $("#addOrder").click(function(){
            $.ajax({
                url:"<%=basePath %>order/addOrder.do",
                type:"POST",
                data:{
                    "room_num":$("#room_num").val(),
                    "money":$("#order_money").val(),
                    "remark":$("#remark").val(),
                    "order_status":$("input[name=order_status]:checked").val()
                },
                dataType:"JSON",
                success:function(rs){
                    if(rs){//添加成功
                        window.location.href="<%=basePath %>order/toOrderList.do";
                    }else{//添加失败
                        alert("订单添加失败");
                    }
                }
            });
        });
    });
  </script>
</div>
</body>
</html>
