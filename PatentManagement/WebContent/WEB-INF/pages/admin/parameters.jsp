<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${root}/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<script type="text/javascript" src="${root}/public/js/jquery.js"></script>
</head>
<body >
	<div style="background: #1C5D6F;height:500px;width:700px;text-align:center;margin-right:auto;margin-left: auto">
		<div style="margin-top: 130px;padding-top: 110px">
			
			<form  action="${root}/patent/updateParameters.do" method="post" onSubmit="return check()">
				<c:forEach items="${patentParameters}" var="patentParameters">
			        <p>
			                <span><b style="color:black">${patentParameters.patentTypeName}</b></span>
			        </p>
			        <p>
			                <input type="button" style="width:13%" value="减缓比例"/>
			                <input type="text" class="payDiscount" name="payDiscount" value="${100 - patentParameters.payDiscount}"/>
			                <input type="button" value="%"/>
			                <br /><br />
			                <input type="button" style="width:13%" value="提醒周期"/>
			                <input type="text" name="remindTypeNum" style="width:18%" class="remindTypeNum" value="${patentParameters.remindTypeNum }"/>
			                <select class="remindTypeUnit" name="remindTypeUnit" style="width: 7%">
								<option value=D>天</option>
								<option value=M 
								<c:if test="${patentParameters.remindTypeUnit eq 'M' }">
									selected="selected"
								</c:if>
								>月</option>
							</select>
			               <%--  <select id="remindType" name="remindType"  style="width: 27%">
								<option value=0D>请选择</option>
								<!-- <option value=1D>1天</option> -->
								
								<option value=5D
									<c:if test="${patentParameters.remindType eq '5D' }">
										selected="selected"
									</c:if>
								>5天</option>
								<option value=10D 
								<c:if test="${patentParameters.remindType eq '10D' }">
									selected="selected"
								</c:if>
								>10天</option>
								<option value=20D 
								<c:if test="${patentParameters.remindType eq '20D' }">
									selected="selected"
								</c:if>
								>20天</option>
								<option value=1M 
								<c:if test="${patentParameters.remindType eq '1M' }">
									selected="selected"
								</c:if>
								>一个月</option>
								<option value=2M 
								<c:if test="${patentParameters.remindType eq '2M' }">
									selected="selected"
								</c:if>
								>两个月</option>
								<option value=3M 
								<c:if test="${patentParameters.remindType eq '3M' }">
									selected="selected"
								</c:if>
								>三个月</option>
							</select> --%>
			        	    <input type="text" name="patentTypeId" value="${patentParameters.patentTypeId}" style="display: none"/>
			        </p>
			        <br/>
				</c:forEach>
				<input type="submit" value="提交">
			</form>
		</div>
	</div>
	<script type="text/javascript">
	function check()   
	{   
		var valid = true;
		
		if(valid) {
			$.each($(".payDiscount"),function(index,obj){
				var payDiscount = $.trim(obj.value);
				if(payDiscount == '') {
					alert("减缓比例不能为空");
					valid = false;
					return false;
				}
				
				if(!/^[\d\.]*$/g.test(payDiscount)) {
					alert("减缓比例必须是整数或小数");
					valid = false;
					return false;
				}
			}); 
		}
		
		if(valid) {
			$.each($(".remindTypeNum"),function(index,obj){
				var remindTypeNum = $.trim(obj.value);
				if(remindTypeNum == '') {
					alert("提醒周期不能为空");
					valid = false;
					return false;
				}
				
				if(!/^[\d]*$/g.test(remindTypeNum)) {
					alert("提醒周期必须是整数");
					valid = false;
					return false;
				}
			});
		}
		
		if(!valid) {
			return false;
		}
		
		if(confirm("确定要修改参数吗？")){
			return true;
		}else{
			return false;
		}
	}   
	</script>
	</body>
</html>
