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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>缴费管理</title>
</head>
<body style="background: #F1C181">
	<form id="myform" >
		
		<table border="0">
		<c:forEach items="${list }" var="patent">
		<input type="hidden" value="${patent.patentId }" name="patentId" id="patentId" />
		<tr>
			<td>申&nbsp;请&nbsp;号</td>
			<td><input style="border:0;text-align:center" type="text" name="applyNum" readonly="readonly" value="${patent.applyNum}" ></input></td>
		</tr>
		<tr>
			<td>发&nbsp;明&nbsp;名&nbsp;称&nbsp;&nbsp;&nbsp;</td>
			<td><input style="border:0;text-align:center" type="text" name="name"  readonly="readonly" value="${patent.name}" ></input></td>
		</tr>
		<tr>
			<td>已&nbsp;缴&nbsp;费&nbsp;总&nbsp;额&nbsp;</td>
			<td><input style="border:0;text-align:center" type="text" name="totalPay"  readonly="readonly" value="${patent.totalPay}0" ></input></td>
		</tr>
		<tr>
			<td>缴费金额</td>
			<td><input style="border:0;text-align:center" type="text" name = "perYearPay"  readonly="readonly" value="${patent.perYearPay}" ></input></td>
		</tr>
		<%-- <tr>
			<td>应&nbsp;缴&nbsp;费&nbsp;年&nbsp;度</td>
			<td><input style="border:0;text-align:center" type="text" name = "haveYear" readonly="readonly" value="${patent.haveYear}" ></input></td>
		</tr> --%>
		<tr>
			<td>缴&nbsp;费&nbsp;年&nbsp;度</td>
			<td>
			<input style="border:0;text-align:center" type="hidden" name = "payStatus" readonly="readonly" value="${patent.yearNum - 1}" />
			<input style="border:0;text-align:center" type="text" readonly="readonly" value="${patent.yearNum}" />
			
			</td>
		</tr>

		</c:forEach>
		</table>
	</form>
	<div align="center">
		<button name="conbtn" id="conbtn" value="缴费" onclick="return confirm();">缴费</button>
		<button name="faibtn" id="faibtn" value="放弃" onclick="fangqi()">放弃</button>
		</div>
</body>
	<script type="text/javascript">
		//缴费的确认
		function confirm(){
			$.ajax({
				url:'${root}/patent/savepatent.do?'+$("#myform").serialize(),
				success: function(data){
					if(data != null){
						alert("缴费成功！");
						if(window.frameElement) 
							var domid =frameElement.getAttribute("domid");
						parent.page.reload();
						parent.Win.wins[domid].close();
					}
				}
			})
		};
		//放弃缴费，并回到主页面
		function fangqi(){
			if(window.frameElement) 
				var domid =frameElement.getAttribute("domid");
			//parent.page.reload();
			parent.Win.wins[domid].close();
		}
	</script>
</html>