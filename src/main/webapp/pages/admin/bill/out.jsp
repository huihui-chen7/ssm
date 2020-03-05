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
<title>结账退房</title>
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>/static/css/select.css" rel="stylesheet" type="text/css" />
<!-- 引入bootstrap分页 -->
<link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
<script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
<script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=basePath %>/static/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/select-ui.min.js"></script>
<%--<script type="text/javascript" src="../../editor/kindeditor.js"></script>--%>
<script type="text/javascript" src="<%=basePath %>/static/js/laydate/laydate.js"></script>
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
</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">入住信息管理</a></li>
    <li><a href="#">结账退房</a></li>
  </ul>
</div>
<div class="formbody">
  <div class="formtitle"><span>消费信息</span></div>
<div id="usual1" class="usual">
  <div id="tab1" class="tabson">
    <ul class="forminfo">
      <li>
        <label>房间号<b>*</b></label>
        <div class="vocation"> 
          <!--   <input name="" type="text" class="dfinput" value="请填写单位名称"  style="width:518px;"/>-->
          <select class="select1" name="roomid">
            <option value="0">--请选择--</option>
            <c:forEach items="${roomList}" var="map">
              <option value="${map.roomId}">${map.room_num}--${map.room_type_name}(${map.room_price}元)</option>
            </c:forEach>
          </select>
        </div>
      </li>
      <li  style="margin-top:20px;"> 
        <label for="name" >客人姓名<b>*</b></label>
        <div class="vocation">
          <input name="customerName" type="text" readonly class="dfinput" style="width:344px;"/>
        </div>
      </li>
      <br /> <br />
      <li>
        <label for="price" style="cursor:pointer" >单价<b>*</b></label>
        <div class="vocation">
          <input name="price" id="price" class="dfinput" readonly  style="width:344px;"/>
        </div>
      </li>
      <br />
      <li>
        <label for="yajin" style="cursor:pointer" >押金<b>*</b></label>
        <div class="vocation">
          <input name="yajin"  id="yajin" type="text" readonly class="dfinput" value="押金"  style="width:344px;"/>
        </div>
      </li>
      <br />
       <li>
        <label for="qita" style="cursor:pointer" >其他消费<b>*</b></label>
        <div class="vocation">
          <input name="qita"  id="qita" type="text" class="dfinput" value=""  style="width:344px;"/>
          <button type="button" class="btn btn-primary" style="width: 50px;">查看</button>
        </div>
      </li>
      <br />
      <li>
        <label for="date1" style="cursor:pointer" >入住时间<b>*</b></label>
        <div class="vocation">
          <input name="date1" readonly  id="date1" class="dfinput" style="width:344px;"/>
        </div>
      </li>
      <br />
      <li>
        <label for="Calendar" style="cursor:pointer" >退房时间<b>*</b></label>
        <div class="vocation">
          <input type="text"  class="laydate-icon span1-1" id="Calendar" style="width:324px; height:30px; line-height:28px; text-indent:10px; "/>
        </div> <br />
      </li>
      <li>
        <label>&nbsp;</label>
        <%--<input name="" type="submit" class="btn" value="提交" />--%>
        <button type="button" class="btn btn-primary" id="outRoom">退房</button>
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
		//分别获取时分秒
        str+=" "+d.getHours();
        str+=":"+d.getMinutes();
        str+=":"+d.getSeconds();
		$("#Calendar").attr("value",str);
		$("#Calendar2").attr("value",str);
	});

	</script>

  <script type="text/javascript">
      $(function(){

          //退房结算
          $("#outRoom").click(function(){
              $.ajax({
                  url:"<%=basePath %>inroominfo/calcOutRoomCost.do",
                  type:"POST",
                  data:{
                      "roomId":$("select[name=roomid]>option:selected").val(),
                      "outRoomTime":$("#Calendar").val()
                  },
                  dataType:"JSON",
                  success:function(rs){
                      var status = rs.status;
                      if(status=='0'){//成功
                          var cost = rs.cost;
                          var str = "";
                          if(cost>0){//补钱
                                str = "客户您还需要补"+cost+"元";
                          }else{
                                if(cost<0){
                                    cost=-cost;
                                }
                               str = "酒店需要找"+cost+"元给客户";
                          }
                          var flag = confirm("提示："+str);
                          if(flag){//客户认同结果
                              //请求后台修改数据库中的数据
                              $.ajax({
                                  url:"<%=basePath %>inroominfo/finalOutRoom.do",
                                  type:"POST",
                                  data:{
                                      "roomId":$("select[name=roomid]>option:selected").val()
                                  },
                                  dataType:"JSON",
                                  success:function(rs){
                                      if(rs){
                                          window.open("<%=basePath %>inroominfo/toInRoomInfo.do","_self")
                                      }else{
                                          //模态框
                                          alert("哎呀，提交失败");
                                      }
                                  }
                              });
                          }
                      }else{//失败
                          alert("计算账单失败");
                      }
                  }
              });
          });

          //当切换房间时，触发ajax事件，传递roomId(房间主键),获取退房客户详细信息
          $("select[name=roomid]").change(function(){
              var v = $("select[name=roomid]>option:selected").val();
              if(v=='0'){//如果是请选择则不触发ajax，但是清空数据
                  //清空文本输入框中的值
                  $(".dfinput").val("");
              }else{
                  $.ajax({
                      url:"<%=basePath %>inroominfo/getOutRoomInfoByRoomId.do",
                      type:"POST",
                      data:{
                          "roomId":$("select[name=roomid]>option:selected").val()
                      },
                      dataType:"JSON",
                      success:function(rs){
                          console.log("rs="+rs);
                          console.log("cm="+rs.customer_name);
                          //回显客人姓名
                          $("input[name=customerName]").val(rs.customer_name);
                          //回显押金
                          $("input[name=yajin]").val(rs.money);
                          //回显入住时间
                          $("input[name=date1]").val(rs.create_date);
                          //回显房间单价
                          $("input[name=price]").val(rs.room_price);
                          //回显其他消费
                          $("input[name=qita]").val(rs.order_cost);
                      }
                  });
              }
          });
      });
  </script>
</div>
</body>
</html>
