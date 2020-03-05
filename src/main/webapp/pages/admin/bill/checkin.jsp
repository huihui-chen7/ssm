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
<link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>/static/css/select.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="<%=basePath %>/static/js/jquery.js"></script>--%>
<script type="text/javascript" src="<%=basePath %>/static/js/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/select-ui.min.js"></script>
<script type="text/javascript" src="../../editor/kindeditor.js"></script>
<script type="text/javascript" src="<%=basePath %>/static/js/laydate/laydate.js"></script>
<script type="text/javascript">
    KE.show({
        id : 'content7',
        cssPath : './index.css'
    });
  </script>
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
    .errorMsg{
      color: red;
      font-size: 12px;
      float: right;
    }
  </style>
</head>

<body>
<div class="place"> <span>位置：</span>
  <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">入住信息管理</a></li>
    <li><a href="#">添加入住信息</a></li>
  </ul>
</div>
<div class="formbody">
  <div class="formtitle"><span>入住信息</span></div>
  <div id="usual1" class="usual">
    <div id="tab1" class="tabson">
      <form action="<%=basePath %>/inroominfo/addInRoomInfo.do" method="post">
        <ul class="forminfo">
        <li>
          <label>房间号<b>*</b></label>
          <div class="vocation"> 
            <!--   <input name="" type="text" class="dfinput" value="请填写单位名称"  style="width:518px;"/>-->
            <select name="roomId" class="select1">
              <c:forEach items="${roomList}" var="map">
                <option value="${map.id}">${map.room_num}</option>
              </c:forEach>
            </select>
          </div>
        </li>
        <br />
        <li  style="margin-top:20px;">
          <label for="name" >客人姓名<b>*</b></label>
          <div class="vocation">
            <input id="name" value="${errorMap.customerName==null?info.customerName:''}" name="customerName" type="text" class="dfinput" placeholder="请填写客户姓名"  style="width:344px;"/>
            <span class="errorMsg">${errorMap.customerName}</span>
          </div>
        </li>
        <br />
        <li>
          <label for="sex">性别<b>*</b></label>
          <c:choose>
            <c:when test="${errorMap.gender!=null}">
              <input name="gender" type="radio" flag="man" value="1"/>
              男&nbsp;&nbsp;&nbsp;&nbsp;
              <input id="sex" name="gender" flag="women" type="radio" value="0" />
              女
            </c:when>
            <c:when test="${errorMap.gender==null && info.gender=='1'}">
                <input name="gender" type="radio" flag="man" value="1" checked/>
                男&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="sex" name="gender" flag="women" type="radio" value="0" />
                女
            </c:when>
            <c:otherwise>
              <input name="gender" type="radio" flag="man" value="1"/>
              男&nbsp;&nbsp;&nbsp;&nbsp;
              <input id="sex" name="gender" flag="women" type="radio" value="0" checked />
              女
            </c:otherwise>
          </c:choose>
          <span class="errorMsg">${errorMap.gender}</span>
        </li>
        <br />
        <li><cite>
          <label for="isVip">会员<b>*</b></label>
          <c:choose>
            <c:when test="${errorMap.isVip!=null}">
              <input name="isVip" type="radio" value="1"/>
              是&nbsp;&nbsp;&nbsp;&nbsp;
              <input id="isVip" name="isVip" type="radio" value="0" />
              否</cite></li>
            </c:when>
            <c:when test="${errorMap.isVip==null && info.isVip=='1'}">
                <input name="isVip" type="radio" value="1" checked/>
                是&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="isVip" name="isVip" type="radio" value="0" />
                否</cite></li>
            </c:when>
            <c:otherwise>
                <input name="isVip" type="radio" value="1"/>
                是&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="isVip" name="isVip" type="radio" value="0" checked/>
                否</cite></li>
            </c:otherwise>
          </c:choose>
          <span class="errorMsg">${errorMap.isVip}</span>
        <br />
        <li  style="margin-top:20px;">
          <label for="vipNum" >会员卡号<b>*</b></label>
          <div class="vocation">
            <input id="vipNum" name="vipNum" type="text" class="dfinput" placeholder="请填写会员号"  style="width:344px;"/>
          </div>
        </li>
        <br>
        <li>
          <label for="idcard" >身份证号码<b>*</b></label>
          <div class="vocation">
            <input id="idcard" value="${errorMap.idcard==null?info.idcard:''}" name="idcard" type="text" class="dfinput" placeholder="请填写客户身份证号码"  style="width:344px;"/>
            <span class="errorMsg">${errorMap.idcard}</span>
          </div>
        </li>
        <br />
        <li>
          <label for="name" >手机号码<b>*</b></label>
          <div class="vocation">
            <input name="phone" value="${errorMap.phone==null?info.phone:''}" type="text" class="dfinput" placeholder="请填写客户手机号码"  style="width:344px;"/>
            <span class="errorMsg">${errorMap.phone}</span>
          </div>
        </li>
        <br />
        <li>
          <label for="name" >押金<b>*</b></label>
          <div class="vocation">
            <input name="money" value="${errorMap.money==null?info.money:''}" type="text" class="dfinput" placeholder="输入押金金额"  style="width:344px;"/>
            <span class="errorMsg">${errorMap.money}</span>
          </div>
        </li>
        <br />
        <li>
          <label for="date" >入住时间<b>*</b></label>
          <div class="vocation">
            <input type="text" name="createDate"  class="laydate-icon span1-1" id="Calendar" style="width:324px; height:30px; line-height:28px; text-indent:10px; "/>
          </div>
        </li>
        <br />
        <li>
          <label>&nbsp;</label>
          <input  type="submit" class="btn" value="入住"/>
        </li>
      </ul>
      </form>
    </div>
  </div>

  <script type="text/javascript">
    $(function(){
        //在会员编号的文本输入框中添加失去焦点事件
        $("#vipNum").blur(function(){
            var isVip = $("input[name=isVip]:checked").val();
            if(isVip=='1'){//使用会员号
                $.ajax({
                    url:"<%=basePath %>inroominfo/getCustomerInfoByVipNum.do",
                    type:"POST",
                    data:{
                        "vipNum":$("#vipNum").val()
                    },
                    dataType:"JSON",
                    success:function(rs){
                        var flag = rs.status;
                        if(flag=='0'){//vip存在
                            //1、回显客人名
                            var customerName =rs.vipInfoMap.customer_name;
                            $("input[name=customerName]").val(customerName);
                            //2、回显性别
                            var gender =rs.vipInfoMap.gender;
                            if(gender=='1'){//男人
                                $("input[flag=man]").prop("checked",true);
                            }else{//女
                                $("input[flag=women]").prop("checked",true);
                            }
                            //3、回显身份证号
                            var idcard = rs.vipInfoMap.idcard;
                            $("input[name=idcard]").val(idcard);
                            //4、回显手机号码
                            var phone = rs.vipInfoMap.phone;
                            $("input[name=phone]").val(phone);
                        }else{//vip不存在
                            //模态框提示不存在
                            alert("您输入的会员号不存在!!!");
                        }
                    }
                });
            }
        });
    });
  </script>

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
              //获取时分秒
              str+=" "+d.getHours()+":";
              str+=d.getMinutes()+":";
              str+=d.getSeconds();
              $("#Calendar").attr("value",str);
              $("#Calendar2").attr("value",str);
          });

	</script> 
</div>
</body>
</html>
