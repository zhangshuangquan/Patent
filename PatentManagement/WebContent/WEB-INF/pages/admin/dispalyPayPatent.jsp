<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root}/public/js/jsTree.js"></script>
<script type="text/javascript" src="${root}/public/js/litewin.js"></script>
<script type="text/javascript" src="${root}/public/js/splitpage.js"></script>
</head>
<body>
	<br/>
	<br/>
	<br/>
	<br/>
	
	</div>
	<table class="tableBox" style="width:98%;margin-left:20px;">
		<thead id="tHead">
			<tr>
			<th>申请号</th>
			<th>发明名称</th>
			<th>申请日</th>
			<th>优先权日</th>
			<th>授权通知日</th>
			<th>年费金额</th>
			<th>缴纳年度</th>
			<th>缴纳绝限</th>
			<th>缴纳状态</th>
			<th>提醒周期</th>
			<th>操作</th>
			</tr>
		</thead>
		<tbody id="mals">
		</tbody>
	</table>
	<div id="pager"></div>
	</body>
<script type="text/javascript">
	var config = {
			url:"${root}/patent/getPagePayPatentList.do",
			node:$id("pager"),
			count:10,
			callback:getAllList,
			};
	var page1 = new SplitPage(config);
	
	 function getAllList(data,total){
		var html = "";
		for(var i=0,j=data.length;i<j;i++){
			
			html +="<tr id="+data[i].applyNum+" name="+data[i].payStatus+">";
			html += "<td style='width:10%'>" + data[i].applyNum +"</td>";
			html += "<td style='width:18%'>" + data[i].name+"</td>";
			html += "<td style='width:8%'>" + data[i].applyDate+"</td>";
			if(data[i].priorityDate == null){
				html += "<td style='width:8%'></td>";
			}else{
				html += "<td style='width:8%'>" + data[i].priorityDate+"</td>";
			}
			html += "<td style='width:8%'>" + data[i].grantDate+"</td>";
			html += "<td style='width:8%'>" + data[i].perYearPay*data[i].disCount +"</td>";
			html += "<td style='width:8%'>"+checkPatent(data[i].patentTypeId,data[i].payStatus)+"</td>";
			html += "<td style='width:8%'>" + dateCompute(data[i].applyDate,data[i].haveYear) +"</td>";
			if(data[i].payStatus == data[i].haveYear ){
				html += "<td style='width:8%'>本年度已缴费</td>";
			}else{
				html += "<td style='width:8%'>本年度未缴费</td>";
			}
			html += "<td style='width:8%'>" + getRelRemindTime(data[i].remindType) +"</td>";
			html += "<td><button id='jiabtn' onclick='payOnePatent(this)'>缴费</button></td></tr>";
		}
		if(html == '') {
			html = '<tr><td colspan="11">无需要缴费的专利</td></tr>';
		}
		$("#mals").html(html);
	}; 
	
	//针对缴费的专利
	function payOnePatent(val){
		var applyNum = $(val).parent("td").parent("tr").attr("id");
		var yearNum = parseInt($(val).parent("td").parent("tr").attr("name"))+1;
		win_edit_malfunction = Win.open({
			'id':'edit_malfunction',
			'title':'缴费专利信息',
			'url':'${root}/patent/getpaypatent.do?applyNum='+applyNum+'&yearNum='+yearNum,
			'width':350,
			'height':353
		});
	}
	//得到绝限日前
	function dateCompute(applyDate,haveYear){
		var remindDate=new Date(applyDate); 
		remindDate.setFullYear(remindDate.getFullYear()+haveYear); 
		remindDate.setDate(remindDate.getDate()-1);
		return remindDate.toLocaleDateString();
	}
	//得到提前提醒的天数
	function check(remindType,applyDate,haveYear){ 
		
		var jueXianDate = new Date(dateCompute(applyDate,haveYear));
		var date = new Date();
		//得到当前时间的字符串，然后放到date中
		var current =date.toLocaleDateString();
		var currentDate = new Date(current);
		//alert(jueXianDate - currentDate);
		if(remindType.substring(1,2) == "D" ){
			//得到相差的天数
			var difDate = (jueXianDate - currentDate)/(1000 *60*60*24); 
			var flag = remindType.substring(0,1);
			if(difDate <= flag){
				return "difDateFlag";
			}
		}else{
			var month = remindType.substring(0,1);
			//alert(currentDate.getMonth()+parseInt(month));
			currentDate.setMonth(currentDate.getMonth()+parseInt(month));
			if(jueXianDate - currentDate <= 0){
				return "difMonthFlag";
			}
		}
	};
	function getRelRemindTime(remindType){
		if(remindType.substring(remindType.length-1,remindType.length) == "D"){
			return remindType.substring(0,remindType.length-1)+"天";
		}else{
			return remindType.substring(0,remindType.length-1)+"个月";
		}
		
	};
	//判断专利是否该交第几年度的的费用或者是否是专利终止
	function checkPatent(patentTypeId,payStatus,status){
		if(payStatus > 20 && parseInt(patentTypeId) == 1){
			return "专利终止";
		}else if(parseInt(patentTypeId) == 2 && payStatus > 10){
			return "专利终止";
		}else if(parseInt(patentTypeId) == 3 && payStatus > 10){
			return "专利终止";
		}else{
			if(status == 2){
				return "专利终止";
			}else{
				return "该交第"+ (payStatus+1) +"年度";
			}
		}
	};
	</script>
</html>
