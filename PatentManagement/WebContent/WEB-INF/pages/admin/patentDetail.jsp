<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp" %>
<script src="${root }/public/js/basiccheck.js"></script>
<script>

var domid = frameElement.getAttribute("domid");

</script>
<style>
	.basic_info {margin-left:10px;}
	b{
	    color: #f8a001;
	    font-size: 12px;
	    font-weight: bolder;
	}
</style>
<head>
<body>
	<div style="text-align:left; padding:0px 25px;">
		<label class="basic_info"><b>专利名称:</b></label>
		${basePatentMap.NAME}
		<br />
		
		<label class="basic_info"><b>专利类型:</b></label>
		${basePatentMap.PATENT_TYPE_NAME}
		
		<br />
		
		<label class="basic_info"><b>申请日:</b></label>
		${basePatentMap.APPLY_DATE}
		<br />
		
		<label class="basic_info"><b>授权通知日:</b></label>
		${basePatentMap.GRANT_DATE}
	</div>
	<div class="commonWrap" style="text-align:center">
		<table class="tableBox" style="width:90%;margin-left:37px;">
			<tr>
					<th>专利年度时间</th>
					<th>专利年度</th>
					<th>授权年费</th>
					<th>是否缴费</th>
			</tr>
	    	<tbody id="detailList"></tbody>
		</table>
	</div>
	<script>
		var patentId = '${basePatentMap.patent_id}';
		var validYears = parseInt('${basePatentMap.VALID_YEARS}');
		var applyDate = '${basePatentMap.APPLY_DATE}';
		var grantDate = '${basePatentMap.GRANT_DATE}';
		var payStatus = '${basePatentMap.PAY_STATUS}';
		
		$(document).ready(function() {
			getPatentDetail();
		}) ;
		
		function getPatentDetail() {
			$.get("${root}/patent/getPatentDetail.do",{"patentId":patentId},function(result) {
				
				var html = "";
				
				var len = result.length > validYears ? validYears : result.length
				var beginYear = payBeginFromYear();
				for(var i = 0; i < len; i ++) {
					
					var payMoney = result[i].PAY_DISCOUNT * result[i].FEE;
					var payFlag = renderPayFlag(result[i].PAY_FLAG);
					
					if(result[i].YEAR_NUM < beginYear) {
						payMoney = "";
						payFlag = "";
					}
			
					if(result[i].YEAR_NUM - beginYear > 2) {
						payMoney = result[i].FEE;
					}
					html += "<tr>";
					html += "<td>"+getPayDateRange(applyDate,result[i].YEAR_NUM)+"</td>";
					html += "<td>第"+result[i].YEAR_NUM+"年</td>";
					html += "<td>"+payMoney+"</td>";
					html += "<td>"+payFlag+"</td>";
					/* if(result[i].PAY_FLAG == 'Y') {
						html += "<td><button id='jiabtn' disabled='true'>缴费</button></td>";
					} else {
						html += "<td><button id='jiabtn' onclick='pay(\""+payMoney+"\",\""+result[i].PATENT_DETAIL_ID+"\",\""+result[i].YEAR_NUM+"\")'>缴费</button></td>";
					} */
					html += "</tr>";
				}
				
				$("#detailList").html(html);
				
			}, "json");
		}
		
		function pay(payMoney, patentDetailId, yearNum) {
			Win.confirm("缴费金额为"+payMoney+"元,确认要缴费吗?", function () {
				$.post('${root}/patent/pay.do', {"patentId" : patentId,"patentDetailId" : patentDetailId,"yearNum" : yearNum}, function(result){
					if(result.result) {
						Win.alert("删除成功");
						getClsSchoolList();
					} else {
						Win.alert(result.message);
					}
				}, "json");
			}
			);
		}
		
		function renderPayFlag(flag) {
			var chineseFlag = "未缴";
			if(flag == 'Y') {
				chineseFlag = "已缴";
			}
			return chineseFlag;
		}
		
		function getPayDateRange(sDate,n) {
			var sYear = sDate.substring(0,4);
			var leftDate = sDate.substr(4);
			var intYear = parseInt(sYear);
			
			var fromYear = intYear + (n - 1);
			var toYear = intYear + n;
			
			return fromYear+leftDate + " - " + toYear+leftDate;
		}
		
		function payBeginFromYear() {
			var applyYear = parseInt(applyDate.substring(0,4));
			var applyMonth = parseInt(applyDate.substring(5,7));
			var applyDay = parseInt(applyDate.substring(8,10));
			
			var grantYear = parseInt(grantDate.substring(0,4));
			var grantMonth = parseInt(grantDate.substring(5,7));
			var grantDay = parseInt(grantDate.substring(8,10));
			
			
			
			if(grantMonth > applyMonth) {
				return grantYear - applyYear + 1;
			} else if(grantMonth < applyMonth) {
				return grantYear - applyYear;
			} else {
				if(grantDay >= applyDay) {
					return grantYear - applyYear + 1;
				} else {
					return grantYear - applyYear;
				}
			}
		}

	</script>
</body>

</html>