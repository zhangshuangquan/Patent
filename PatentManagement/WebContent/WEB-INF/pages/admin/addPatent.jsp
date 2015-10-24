<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp"%>
<html>
<head>
<link href="${root}/public/calendar/skin/WdatePicker.css"	rel="stylesheet" type="text/css">
<script type="text/javascript"	src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<title>增加专利</title>
	<style type="text/css">
		body{
		font-size:20px;
		}
	</style>
</head>
<body>
	<div style="background: #1C5D6F;height:500px;width:700px;text-align:center;margin-right:auto;margin-left: auto">
		<div style="margin-top: 130px;padding-top: 40px">
		<a style="font-size: 25px; color: #00CCFF">请输入</a>
		<table align="center" style="margin-top: 20px">
			<tr id="applyNumP">
				<td align="right" style="color: #00CCFF">申&nbsp;&nbsp;请&nbsp;&nbsp;号:</td>
				<td><input type="text" id="applyNum" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" maxlength="14"></td>
				<td align="left" width="45%" ><span id = testApplyNum style="font-size:20px;color: red" >*</span></td>
			</tr>
			<tr>
				<td align="right" style="color: #00CCFF">专利类型:</td>
				<td>
					<select id="patentTypeId" name="patentTypeId" style="width: 100%">
							<option value=0>请选择</option>
							<option value=1>发明</option>
							<option value=2>实用新型</option>
							<option value=3>外观设计</option>
					</select>
				</td>
				<td align="left" width="40%"><span id ="testPatentTypeId" style="font-size:20px;color: red" >*</span></td>
			</tr>
			<tr>
				<td align="right" style="color: #00CCFF">发明名称:</td>
				<td><input type="text" id="name" maxlength="100"></td>
				<td align="left" width="40%"><span id = testName style="font-size:20px;color: red" >*</span></td>
			</tr>
			<tr id="applyDateP">
				<td align="right" style="color: #00CCFF">申&nbsp;&nbsp;请&nbsp;&nbsp;日:</td>
				<td><input type="text" class="Wdate" id="applyDate" onclick="WdatePicker()" value=""></td>
				<td align="left" width="40%"><span id = testApplyDate style="font-size:20px;color: red" size="10">*</span></td>
			</tr>
			<tr id="priorityDateP">
				<td align="right" style="color: #00CCFF">优先权日:</td>
				<td><input type="text" class="Wdate" id="priorityDate"	onclick="WdatePicker()" value=""></td>
				<td align="left" width="40%"></td>
			</tr>
			<tr id="grantDateP">
				<td align="right" style="color: #00CCFF">授权通知日:</td>
				<td><input type="text" class="Wdate" id="grantDate"		onclick="WdatePicker()" value=""></td>
				<td align="left" width="40%"><span id = testGrantDate style="font-size:20px;color: red" size="10">*</span></td>
			</tr>
			<tr id="grantDateP">
				<td align="right" style="color: #00CCFF">授权日:</td>
				<td><input type="text" class="Wdate" id="grantFlagDate"		onclick="WdatePicker()" value=""></td>
				<td align="left" width="40%"><span id = testGrantFlagDate style="font-size:20px;color: red" size="10"></span></td>
			</tr>
			<!-- <tr id="totalPayP">
				<td align="right" style="color: #00CCFF">缴费总额:</td>
				<td><input type="text" id="totalPay" value=''></td>
				<td align="left" width="40%"><span id = testTotalPay style="font-size:20px;color: red" size="10">*</span></td>
			</tr> -->
			<tr id="payStatusP">
				<td align="right" style="color: #00CCFF">已缴纳年度:</td>
				<td><input type="text" id="payStatus" value=''></td>
				<td align="left" width="40%"><span id = testPayStatus style="font-size:20px;color: red" size="10">*</span></td>
			</tr>
			<tr id="statusP">
				<td align="right" style="color: #00CCFF">状态:</td>
				<td>
					<select id="status" style="width: 100%">
							<option value=0>请选择</option>
							<option value=1>有权</option>
							<option value=2>失效</option>
					</select>
				</td>
				<td align="left" width="40%"><span id = testStatus style="font-size:20px;color: red" size="10">*</span></td>
			</tr>
		</table>
		<div style="text-align: center;margin-top: 20px">
			<input type="button" class="quit" 	value="放弃数据" style="cursor: pointer" />
			<input type="button" class="addNew" value="增加数据" style="cursor: pointer" />
		</div>
	</div>
</div>
</body>
<script type="text/javascript">

$(".addNew").on('click',function(){
	var applyNum = $("#applyNum").val().trim();
	var name = $("#name").val().trim();
	var applyDate = $("#applyDate").val().trim();
	/* var totalPay = $("#totalPay").val().trim();
	if(totalPay==''){
		totalPay = '0';
	} */
	var patentTypeId = $("#patentTypeId").val();
	var priorityDate = $("#priorityDate").val().trim();
	var payStatus = $("#payStatus").val().trim();
	if(payStatus==''){
		payStatus = '0';
	}
	alert(payStatus);
	var grantDate = $("#grantDate").val().trim();
	var grantFlagDate = $("#grantFlagDate").val().trim();
	var status = $("#status").val().trim();
	if($.trim(applyNum).length==0){
		$("#testApplyNum").html("×");
		Win.alert("申请号不能为空哦！");
		return;
	}else if (patentTypeId == '0') {
		$("#testPatentTypeId").html("×");
		Win.alert("专利类型不能为空哦！");
		return;
	}else if (name == '') {
		$("#testName").html("×");
		Win.alert("专利名称不能为空哦！");
		return;
	}
	else if($.trim(applyDate).length==0){
		$("#testApplyDate").html("×");
		Win.alert("申请日不能为空");
		return;
	} else if($.trim(grantDate).length==0){
		$("#testGrantDate").html("×");
		Win.alert("授权通知日不能为空");
		return;
	}else if(grantDate<applyDate){
		$("#testGrantDate").html("×");
		Win.alert("授权通知日不能早于申请日");
		return;
	}
	/* else if($.trim(totalPay).length==0){
		$("#testTotalPay").html("×");
		Win.alert("缴费总额不能为空");
		return;
	}else if(!/^[\d\.]*$/g.test(totalPay)){
		$("#testTotalPay").html("×");
		Win.alert("缴费总额必须是数字");
		return; 
	}else if(totalPay > 999999.99){
		$("#testTotalPay").html("×");
		Win.alert("缴费总额不能大于7位数");
		return;
	} */
	else if($.trim(payStatus).length==0){
		$("#testPayStatus").html("×");
		Win.alert("已缴纳年度不能为空");
		return;
	}else if(!/^\d*$/g.test(payStatus)){
		$("#testPayStatus").html("×");
		Win.alert("已缴纳年度必须是数字");
		return; 
	}else if(payStatus > 10 && (patentTypeId == "2" || patentTypeId == "3")){
		$("#testPayStatus").html("×");
		Win.alert("此专利已缴纳年度不能高于10年");
		return; 
	}else if(payStatus > 20 && patentTypeId == "1"){
		$("#testPayStatus").html("×");
		Win.alert("此专利已缴纳年度不能高于20年");
		return; 
	}else if(status=="0"){
		$("#testStatus").html("×");
		Win.alert("请选择状态");
		return;
	}
	$.ajax({
		Type:"post",
		cache:false,
		datatype:'json',
		url:"${root}/patent/addNewPatent.do",
		data:{
			"applyNum":applyNum,
			"name":name,
			"applyDate":applyDate,
			"totalPay":0,
			"patentTypeId":patentTypeId,
			"priorityDate":priorityDate,
			"grantDate":grantDate,
			"grantFlagDate":grantFlagDate,
			"payStatus":payStatus,
			"status":status
		},
		success:function(data){
			if(data.result){
				alert("保存成功");
				location.reload();
				 $("input").each(function(index){
					$(this).val('');
					//$("#remindType").val('0');
					$("#status").val('0');
					
				});
			}else{
				alert("保存失败");
				alert(data.message);
			} 
		},
		error:function(){
			alert("出错了");
		}
		
	});
	
});
		
</script>
</html>