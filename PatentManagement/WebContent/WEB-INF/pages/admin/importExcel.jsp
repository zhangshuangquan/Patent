<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="${root}/public/js/webuploader/webuploader.css">
<link href="${root}/public/css/jquery-ui.css" rel="stylesheet">
<head>
<script type="text/javascript" src="${root}/public/js/webuploader/webuploader.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${root}/public/js/jquery.js"></script>
<script src="${root}/public/js/jquery-ui.js"></script>
<title>Insert title here</title>

</head>
<body>

	<div style="background: #1C5D6F;height:500px;width:700px;text-align:center;margin-right:auto;margin-left: auto">
		
		<div style="margin-top: 130px;padding-top: 150px">
		<div id="tip" style="margin-bottom:70px "><a style="font-size: 25px;color:#00CCFF">请先下载模板</a></div>
		<div id="showupload" hidden="true">
  		<div id="list"></div>
        <div id="upload" style="font-size: 20px;">选择文件</div>
        <div style="margin-bottom: 30px"><button id="ctlbtn" class="btn btn-default" style="font-size: 20px">开始上传</button></div>
     	</div>
        </div>
        <button id="show" onclick="showupload()" style="mmargin-top: 50px">模板已下载</button>
        <a href="${root}/public/upload/importTemplate.xls" download="导入模版.xls"  id="but">模板下载</a>
    </div>
        
</body>

<script type="text/javascript">
$("button[id!=ctlbtn]").on("click",function(){
	var uploader = WebUploader.create({
	    pick: {
	   	 id:'#upload'
	        
	    },
	 	
	    swf: '${root}/public/js/webuploader/Uploader.swf',
	    server: '${root}/patent/batchInsert.do',//上传的URL
	    // runtimeOrder: 'flash',
	     accept: {
	   	  
	         title:'Excel',
	         extensions:'xlsx,xls',
	         mimeTypes:'application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
	     }

	});
	//+++++监听文件队列+++++//
	uploader.on( 'fileQueued', function( file ) {
		
	    $("#list").append( '<div id="check" class="item">' +
	        '<h4 class="info">' + file.name + '</h4>' +
	        '<p class="state">等待上传...</p>' +
	    '</div>' );
	});
	//++++点击上传+++++//
	$("#ctlbtn").click(function(){
		uploader.upload();
	})

	uploader.on( 'uploadAccept', function(file,response ) {
		if(response=="success") {
			$("p").text('已上传');
			alert(response); 
			
		}  else{
			$("p").text('上传出错');
			alert(response); 
			
			
		}
	   
	})

	uploader.on('beforeFileQueued',function(file){
		$("#check").remove();
		uploader.reset();
	})
	
})
$("button[id!=ctlbtn],#but").button();

/* uploader.on('uploadComplete',function(file){
	$('#'+file.id).remove();
	uploader.reset();
}) */



 function showupload(){
	$("#tip").remove();
	$("#showupload").removeAttr("hidden");
	
}  
</script> 
</html>