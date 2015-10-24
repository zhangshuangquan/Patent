<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="../common/meta.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<script src="${root}/public/js/litewin.js" type="text/javascript"></script>
<style>
	.btn{
	    border: 0 none;
	    border-radius: 3px;
	    color: #fff;
	    cursor: pointer;
	    display: inline-block;
	    font-size: 14px;
	    line-height: 1.6;
	    padding: 0 5px;
	    text-align: center;
	    margin-left:4px;
	}
	
	.btnBlue {
    	background-color: #14adfd;
	}
	
	.btnOrange {
    	background-color: #f8a001;
	}
</style>
</head>
<body>
	<br/>
	<br/>
	<br/>
	<br/>
	<div>
	</div>
	<form action="exportExcel.do"  method="post">
	<ul class="searchWrap">
		<li>
			<label class="labelText">专利号：</label>
			<input type="text" id="applyNum" name="applyNum" ></input>
			
			<label class="labelText">名称：</label>
			<input type="text" id="applyName" name="name" value=""></input>
			
			&nbsp;&nbsp;
			<label class="labelText"> 缴纳状态： </label> 
			<select id="status"  name="status">
					<option value="">请选择</option>
					<option value="1">本年度已交费</option>
					<option value="2">本年度未交费</option>
			</select>
			
			&nbsp;&nbsp;
			<label class="labelText"> 提醒类型： </label> 
			<select id="unpaidStatus"  name="unpaidStatus">
					<option value="">请选择</option>
					<option value="1">超过提醒日期</option>
					<option value="2">超过缴费绝限</option>
					<option value="3"
					<c:if test="${not empty unpaidStatus and unpaidStatus == '3' }">
						selected
					</c:if>
					>超过提醒日期或缴费绝限</option>
			</select>
		</li>
		<li>
			
			<label class="labelText">申请时间：</label> 
			<input type="text" class="Wdate" id="applyFromTime" onclick="WdatePicker();" name="start" /> 
			-- 
			<input type="text" class="Wdate" id="applyToTime" onclick="WdatePicker();" name="end" /> 
			
			<label class="labelText">授权通知日：</label> 
			<input type="text" class="Wdate" id="authorityFromTime" onclick="WdatePicker();" name="authorityFromTime" /> 
			-- 
			<input type="text" class="Wdate" id="authorityToTime" onclick="WdatePicker();" name="authorityToTime" /> 
		
			<label style="margin-left:10px;"> 状态： </label> 
			<select id="liveStatus"  name="liveStatus">
					<option value="">请选择</option>
					<option value="1">有权</option>
					<option value="2">失效</option>
			</select>
			
		</li>
		<li>
			
			<label class="labelText">授权日：</label> 
			<input type="text" class="Wdate" id="grantFlagDateFrom" onclick="WdatePicker();" name="grantFlagDateFrom" /> 
			-- 
			<input type="text" class="Wdate" id="grantFlagDateTo" onclick="WdatePicker();" name="grantFlagDateTo" /> 
			
			<label class="labelText">缴纳绝限：</label> 
			<input type="text" class="Wdate" id="fromDeadline" onclick="WdatePicker();" name="fromDeadline" /> 
			-- 
			<input type="text" class="Wdate" id="toDeadline" onclick="WdatePicker();" name="toDeadline" /> 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input   type="button" class="btn btnBlue"   id="mybtn4" onclick="searchPatentList();" style="cursor:pointer"  value="查询"/>
			<div class="totalPageBox" style="width:98%;margin-left:20px;">
		</li>
		<li>
			<label class="labelText">排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;序： </label> 
			<select id="orderType"  name="orderType" onchange="searchPatentList();">
					<option value="0">请选择</option>
					<option value="1">申请日降序</option>
					<option value="2">申请日升序</option>
					<option value="3">授权日降序</option>
					<option value="4">授权日升序</option>
					<option value="5">缴纳绝限降序</option>
					<option value="6">缴纳绝限升序</option>
			</select>
			
			<input style="cursor:pointer;float:right;margin-right:20px;" class="btn btnBlue" type="button" onclick="showFileUploadPage();" value="批量新增专利"/>
			<input style="cursor:pointer;float:right;margin-right:10px;" class="btn btnBlue" type="submit" value="导出查询出的信息"/>
		</li>
	</ul>
	</form> 
	</div>
	<table class="tableBox" style="width:98%;margin-left:20px;" >
		<tr>
			<th>申请号</th>
			<th>发明名称</th>
			<th>申请日</th>
			<th>优先权日</th>
			<th>授权通知日</th>
			<th>授权日</th>
			<th>缴纳总额</th>
			<th>年费金额</th>
			<th>缴纳年度</th>
			<th>缴纳绝限</th>
			<th>状态</th>
			<th>缴纳状态</th>
			<th>提醒周期</th>
			<th>操作</th>
		</tr>
		<tbody id="mals">
		</tbody>
		<tfoot>
			<tr>
				<td style="" colspan="14">
					<img style="vertical-align:-50%" src="${root}/public/img/common/yellow.png"> 表示到了提醒日期的专利
					<img style="vertical-align:-50%;margin-left:10px;" src="${root}/public/img/common/red.png"> 表示超过缴费绝限的专利
					<img style="vertical-align:-50%;margin-left:10px;" src="${root}/public/img/common/green.png"> 表示已交完所有年度费用的专利
				</td>
			</tr>
		</tfoot>
	</table>
	<div id="fuzzypage" ></div>
	<div id="page"></div>
	</body>
<script type="text/javascript">

	$(document).ready(function(){
		searchPatentList();
	});
	
	var page = null;
	
	function searchPatentList() {
		
		var applyFromTime = $("#applyFromTime").val();
		var applyToTime = $("#applyToTime").val();
		var liveStatus = $("#liveStatus").val();
		var status = $("#status").val();
		var applyNum = $("#applyNum").val();
		var applyName = $("#applyName").val();
		var orderType = $("#orderType").val();
		var authorityFromTime = $("#authorityFromTime").val();
		var authorityToTime = $("#authorityToTime").val();
		var fromDeadline = $("#fromDeadline").val();
		var toDeadline = $("#toDeadline").val();
		var unpaidStatus = $("#unpaidStatus").val();
		var grantFlagDateFrom = $("#grantFlagDateFrom").val();
		var grantFlagDateTo = $("#grantFlagDateTo").val();
		//var totalPay = $("#totalPay").val();
		
		var url = "${root}/patent/searchPatentList.do";
		var data = {"applyFromTime":applyFromTime,"applyToTime":applyToTime,"liveStatus":liveStatus,"status":status,
				"applyNum":applyNum,"applyName":applyName, "orderType":orderType, 
				"authorityFromTime":authorityFromTime,"authorityToTime":authorityToTime,"fromDeadline":fromDeadline,"toDeadline":toDeadline,"unpaidStatus":unpaidStatus,
				"grantFlagDateFrom":grantFlagDateFrom,"grantFlagDateTo":grantFlagDateTo};
		if(page == null) {
			page = new SplitPage({
				url:url,
				node:$id("page"),
				count:10,
				data:data,
				callback:getAllList,
				});
		} else {
			page.search(url,data);
		}
	}
	
	//得到回调函数，拼接html
	function getAllList(data,total){
		var html = "";
		for(var i=0,j=data.length;i<j;i++){
			
			var patentTypeId = data[i].patentTypeId;
			var payStatus = data[i].payStatus;
			var enablePay = true;
			
			if(patentTypeId == '1') {
				if(payStatus >= 20) {
					enablePay = false;
				}
			} else if (patentTypeId == '2' || patentTypeId == '3') {
				if(payStatus >= 10) {
					enablePay = false;
				}
			}
			
			if(!enablePay) {
				html +="<tr style='background:#D7F185' id="+data[i].applyNum+" name="+data[i].shouldPayYear+">";
			}else if(data[i].expiredFlag == 'Y') {
				html +="<tr style='background:#FF8C69' id="+data[i].applyNum+" name="+data[i].shouldPayYear+">";
			} else if (data[i].warningFlag == 'Y') {
				html += "<tr style='background:yellow'; id="+data[i].applyNum+" name="+data[i].shouldPayYear+">";
			} else {
				html +="<tr id="+data[i].applyNum+" name="+data[i].shouldPayYear+">";
			}
			
			html += "<td style='width:8%'>" + data[i].applyNum +"</td>";
			html += "<td style='width:10%'>" + data[i].name+"</td>";
			html += "<td style='width:6%'>" + data[i].applyDate+"</td>";
			if(data[i].priorityDate == null){
				html += "<td style='width:6%'></td>";
			}else{
				html += "<td style='width:6%'>" + data[i].priorityDate+"</td>";
			}
			html += "<td style='width:6%'>" + data[i].grantDate+"</td>";
			
			if(data[i].grantFlagDate == null){
				html += "<td style='width:6%'>&nbsp;</td>";
			} else {
				html += "<td style='width:6%'>" + data[i].grantFlagDate+"</td>";
			}
			
			html += "<td style='width:6%'>" + data[i].totalPay+"</td>";
			
			if(parseInt(data[i].haveYear) + 1 - parseInt(data[i].applyToGrantYear) > 3) {
				html += "<td style='width:6%'>" + data[i].perYearPay +"</td>";
			} else {
				html += "<td style='width:6%'>" + data[i].perYearPay*data[i].disCount +"</td>";
			}
			html += "<td style='width:6%'>第"+data[i].haveYear+"年度</td>";
			html += "<td style='width:6%'>" + data[i].expiredDate +"</td>";
			html += "<td style='width:4%'>" + renderStatus(data[i].status) +"</td>";
			if(data[i].curYearPayFlag == 'Y' ){
				html += "<td style='width:6%'>本年度已缴费</td>";
			}else{
				html += "<td style='width:6%'>本年度未缴费</td>";
			}
			html += "<td style='width:6%'>" + getRelRemindTime(data[i].remindType) +"</td>";
			html += "<td style='width:18%'><button class='btnBlue btn' id='editbtn' onclick= 'editOnePatent(this) '>编辑</button>";
			html += "<button id='delbtn' class='btnOrange btn' onclick='delOnePatent(this,\""+data[i].patentId+"\")'>删除</button>";
			html += "<button id='viewbtn' class='btnBlue btn' onclick='viewDetail(\""+data[i].patentId+"\")' >缴费明细</button>";
			
			if(data[i].status == 1 && enablePay){
				html += "<button id='jiabtn' class='btnBlue btn' onclick='payOnePatent(this)'>缴费</button></td></tr>";
			}else{
				html += "<button id='jiabtn' class='btnBlue btn' onclick='payOnePatent(this)' disabled='true'>缴费</button></td></tr>";
			}
		}
		if(html == '') {
			html = '<tr><td colspan="14">无满足条件的专利</td></tr>';
		}
		
		$("#mals").html(html);
	};
	
	//渲染状态
	function renderStatus(status) {
		if(status == '1') {
			return '有权';
		} else if (status == '2') {
			return '失效';
		} else {
			return '';
		}
	}
	
	//删除某条专利
	function delOnePatent(val, patentId){
		var applyNum = $(val).parent("td").parent("tr").attr("id");
		if(window.confirm("确定要删除么？")){
			$.post("${root}/patent/delonepatent.do",{"applyNum":applyNum, "patentId":patentId},function(data){
				page.reload();
			});
		}
	};
	
	//针对编辑一个专利提交数据
	function editOnePatent(val){
		var applyNum = $(val).parent("td").parent("tr").attr("id");
		var yearNum = parseInt($(val).parent("td").parent("tr").attr("name"))+1;
		 win_edit_malfunction = Win.open({
			'id':'edit_malfunction',
			'title':'修改专利',
			'url':'${root}/patent/getonepatent.do?applyNum='+applyNum+'&yearNum='+yearNum,
			'width':350,
			'height':353
		});
	}
	//针对需要缴费的专利打开一个新的窗口，记录其信息
	function payOnePatent(val){
		var applyNum = $(val).parent("td").parent("tr").attr("id");
		var yearNum = parseInt($(val).parent("td").parent("tr").attr("name"));
		win_edit_malfunction = Win.open({
			'id':'edit_malfunction',
			'title':'缴费专利信息',
			'url':'${root}/patent/getpaypatent.do?applyNum='+applyNum+'&yearNum='+yearNum,
			'width':350,
			'height':353
		});
	}
	
	function viewDetail(patentId) {
		Win.open({
			id	   : "showPatentDetailPageId" ,
			title : "专利缴费明细" ,
			width : 600,
			height : 550,
			url : "${root}/patent/showPatentDetailPage.html?patentId=" + patentId
		});
	}
	
	
	//得到按天和月为最后一位的显示格式
	function getRelRemindTime(remindType){
		if(remindType.substring(remindType.length-1,remindType.length) == "D"){
			return remindType.substring(0,remindType.length-1)+"天";
		}else{
			return remindType.substring(0,remindType.length-1)+"个月";
		}
		
	};
	
	function showFileUploadPage(){
		Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增专利",url:"${root}/patent/importPatentPage.do",mask:true});
	}

	
	</script>
</html>
