<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>edit one patent</title>
<link href="${root}/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<script src="${root}/public/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<script src="${root}/public/js/litewin.js" type="text/javascript"></script>
</head>
<body style="background: #F1C181">
	<form id="myform">
		<table border="0">
		<c:forEach items="${list}" var="patent">
		<input type="hidden" value="${patent.patentId }" name="patentId" id="patentId" />
			<tr>
				<td>申请号</td>
				<td><input type="text" id="applyNum" name="applyNum" value="${patent.applyNum }" /></td>
			</tr>
			<tr>
				<td>专利类型</td>
				<td>
					<select id="patentTypeId" name="patentTypeId" style="width: 100%">
							<option value="0">请选择</option>
							<option value="1" 
								<c:if test="${patent.patentTypeId eq '1'}">
									selected
								</c:if>
							>发明</option>
							<option value="2" 
								<c:if test="${patent.patentTypeId eq '2'}">
									selected
								</c:if>
							>实用新型</option>
							<option value="3" 
								<c:if test="${patent.patentTypeId eq '3'}">
									selected
								</c:if>
							>外观设计</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>发明名称</td>
				<td><input type="text" name="name" id="name" value="${patent.name}" /></td>
			</tr>
			<tr>
				<td>申请日</td>
				<td><input type="text" name="applyDate" class="Wdate" id="applyDate" onclick="WdatePicker();" value="<fmt:formatDate value="${patent.applyDate}" type='date'/>" /></td>
			</tr>
			<tr>
				<td>授权通知日</td>
				<td><input type="text" name="grantDate" class="Wdate" id="grantDate" onclick="WdatePicker();" value="<fmt:formatDate value="${patent.grantDate}" type='date'/>" /></td>
			</tr>
			<tr>
				<td>授权日</td>
				<td><input type="text" name="grantFlagDate" class="Wdate" id="grantFlagDate" onclick="WdatePicker();" value="<fmt:formatDate value="${patent.grantFlagDate}" type='date'/>" /></td>
			</tr>
			<tr>
				<td>优先日</td>
				<td><input type="text" name="priorityDate" class="Wdate" id="priorityDate" onclick="WdatePicker();" value="<fmt:formatDate value="${patent.priorityDate}" type='date'/>" /></td>
			</tr>
			<%-- <tr>
				<td>缴费总额</td>
				<td><input type="text" id="totalPay" name="totalPay" value='${patent.totalPay }'></td>
			</tr> --%>
			<input type="hidden" id="totalPay" name="totalPay" value='0'>
			<tr>
				<td>已缴纳年度</td>
				<td><input type="text" name="payStatus" id="payStatus"  value="${patent.payStatus }"/></td>
			</tr>
			<tr>
				<td>状态</td>
				<td>
					<select id="status" name="status" style="width: 100%">
							<option value="1">有权</option>
							<option value="2" 
							<c:if test="${patent.status eq '2'}">
								selected
							</c:if>
							>失效</option>
					</select>
				</td>
			</tr>
		</c:forEach>
	</table>
</form>
		<div align="center">
		<input type="button" value="提交" id="mybtn" onclick="return patentSbmit();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" id="quxiaobtn"  value="取消" onclick="quxiao()"/></input>
		</div>
</body>
<script type="text/javascript">

	function applyDateMiss(){
		$("#applyDate").attr('value','');
	};
	function grantDateMiss(){
		$("#grantDate").attr('value','');
	};
	function priorityDateMiss(){
		$("#priorityDate").attr('value','');
	};
	//表单的提交
	function patentSbmit(){
		
		var payStatus = $("#payStatus").val();
		var patentTypeId = $("#patentTypeId").val();
		
		if($.trim(($("#applyNum").val())).length == 0){
			alert("申请号为空，请输入");
			$("#applyNum").focus();
			return false;
		}
		if($.trim(($("#patentTypeId").val())).length == 0){
			alert("专利类型为空，请输入");
			$("#patentTypeId").focus();
			return false;
		}
		if($.trim(($("#name").val())).length == 0){
			alert("名称为空，请输入");
			$("#name").focus();
			return false;
		}
		if($.trim(($("#applyDate").val())).length == 0){
			alert("申请时间为空，请输入");
			$("#applyDate").focus();
			return false;
		}
		if($.trim(($("#grantDate").val())).length == 0){
			alert("授权时间为空，请输入");
			$("#grantDate").focus();
			return false;
		}
		if($.trim(($("#payStatus").val())).length == 0){
			alert("已缴纳年度为空，请输入");
			$("#payStatus").focus();
			return false;
		}else if(!/^\d*$/g.test(payStatus)){
			alert("已缴纳年度必须是数字");
			$("#payStatus").focus();
			return false; 
		}else if(payStatus > 10 && patentTypeId == "2" || patentTypeId == "3"){
			alert("此专利已缴纳年度不能高于10年");
			$("#payStatus").focus();
			return false; 
		}else if(payStatus > 20 && patentTypeId == "1"){
			alert("此专利已缴纳年度不能高于20年");
			$("#payStatus").focus();
			return false; 
		}
		/* if($.trim(($("#totalPay").val())).length == 0){
			alert("缴费总额为空，请输入");
			$("#totalPay").focus();
			return false;
		} else if(!/^[\d\.]*$/g.test($.trim(($("#totalPay").val())))){
			alert("缴费总额必须是数字");
			$("#totalPay").focus();
			return false;
		} */
		if($.trim(($("#status").val())).length == 0){
			alert("状态为空，请输入");
			$("#status").focus();
			return false;
		}
		
		//得到申请的时间
		var preDate = $("#applyDate").val();
		var prearys= preDate.split('-');
		var new_preDate = new Date(prearys[0], prearys[1], prearys[2]);
		//得到申请的时间
		var sufDate = $("#grantDate").val();
		var sufarys= sufDate.split('-');
		var new_sufDate = new Date(sufarys[0], sufarys[1], sufarys[2]);
		
		if(new_sufDate - new_preDate < 0){
			alert("授权时间不能在申请时间的前面！");
			return false;
		}
		
		$.ajax({
			url:'${root}/patent/editpatent.do?'+$("#myform").serialize(),
			success: function(data){
				if(data != null){
					alert("编辑成功！");	
					if(window.frameElement) 
					var domid =frameElement.getAttribute("domid");
					parent.page.reload();
					parent.Win.wins[domid].close();
				}
			}
			
		});
};
	function quxiao(){
		if(window.frameElement) 
		var domid =frameElement.getAttribute("domid");
		parent.Win.wins[domid].close();
	};
	
</script>
</html>
