<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/public/js/webuploader/webuploader.css">	
<script type="text/javascript"
	src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root}/public/js/jquery.js"></script>
<script type="text/javascript" src="/public/js/webuploader/webuploader.js">

</script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">报修中心</a> &gt; <a href="javascript:;">欢迎页</a>
	</h3>

	<ul class="searchWrap">
		<li>
			<label class="labelText">报修时间：</label> 
			<input type="text" class="Wdate" id="repair_fromtime" onclick="WdatePicker();" value=""> 
			-- 
			<input type="text" class="Wdate" id="repair_totime" onclick="WdatePicker();" value=""> 
			<label class="labelText"> 状态： </label> 
			<select id="status">
					<option value="">请选择</option>
					<option value="1">待处理</option>
					<option value="2">处理中</option>
					<option value="3">已处理</option>
					<option value="4">已验收</option>
			</select>
		</li>
	</ul>
	<div class="totalPageBox" style="width:98%;margin-left:20px;">
		总共<span class="totalNum">15</span> 条数据
	</div>
	<table class="tableBox" style="width:98%;margin-left:20px;">
		<tr>
			<th>Name</th>
			<th>Password</th>
			<th>
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
    <form action="/PatentManagement/patent/batchInsert.do" method="post" enctype="multipart/form-data">
        <input id="file" name="file" type="file">
        <input id="import" type="submit" value="开始上传">
        </form>
    </div>


			</th>
		</tr>
		<tbody id="mals">
			<c:forEach items="${userList}" var="user">
				<tr>
					<td><c:out value="${user.username}"></c:out></td>
					<td><c:out value="${user.password}"></c:out></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>
	
    
	</body>

	<!--  <script type="text/javascript">
	 	$("#import").click(function(){
			var fileUrl= $("#file").val();
			$.post("/PatentManagement/patent/batchInsert.do",{"url":fileUrl},function(data){
				alert(data);
				
			},'json');
			
		 	$.ajax({
				type:"post",
				url:"/PatentManagement/patent/batchInsert.do",
				dataType:"json",
				data:{"url":fileUrl},
				success:function(data){
					alert(data);
					
						
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert(textStatus);
				}
			}); 
			
			
		}) 
/* $(document).ready(function(){
	 var uploader = WebUploader.create({
         pick: {
        	 id:'#file',
             
         },
      	
         swf: '${root}/public/js/webuploader/Uploader.swf',
         server: '/patent/batchInsert.do',//上传的URL
         // runtimeOrder: 'flash',
          accept: {
        	  
              title: 'Excel',
              extensions: 'xlsx'
          },
     
     });
  
	})
 */

		
	</script> -->
	<script type="text/javascript">
		/* (function(){
		 var msg = "${helloWorld}";
		 var realName = "${user.realName}";
		 $.messager.show({
		 width:300,
		 height:200,
		 title:"提示",
		 msg:"欢迎！"
		 });
		 $.messager.alert('提示',"您好："+realName,'info');
		 })(); */
	</script>
</html>
