<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/meta.jsp" %>
<title>后台管理系统</title>   
</head>
<body>
<%@ include file="common/header.jsp" %>
<div id="menuTree">
<%@ include file="common/side.jsp" %>
</div>
<div id="main">
	<iframe scrolling="yes" frameborder="0" id="mainFrame" src="" name="mainFrame" name="main"> </iframe>
</div>
<script type='text/javascript'>
$(document).ready(function(){
	<c:choose>
		<c:when test="${requestScope.payPatentPageFlag eq 'pagPatent' }">
			$(".currMenu").removeClass("currMenu");
			$(".icon_0").addClass("currMenu");
			$('.menu > ul:visible').addClass("hide");
			$('.menu > ul:eq(0)').removeClass("hide");
			$('#payPatentId').addClass('tabon').click();
		</c:when>
		<c:otherwise>
			clickTop("0");
		</c:otherwise>
	</c:choose>
});

	function clickTop(i) {
		$(".currMenu").removeClass("currMenu");
		$(".icon_"+i).addClass("currMenu");
		$('.menu > ul:visible').addClass("hide");
		$('.menu > ul:eq('+i+')').removeClass("hide");
		$('.menu > ul:eq('+i+') ul:eq(0) a:eq(0)').addClass('tabon').click();
	}

	function clickLeft(t) {
		/* var url = 'module/content1.shtml?a='+t;
		$('#mainFrame').attr("src",url);  */
		$('#mainFrame').attr("src",t);
	}

	$(document).ready(function(){


	$(".menu .menusub li a").on('click', function() {
		$(".menu .menusub li a").removeClass('tabon');
		$(this).addClass('tabon');
		$(".menu ul li.menulist .menutree1").removeClass('asdfon');
		$(this).parent().parent().parent().find(".menutree1").addClass("asdfon");
	});

	$(".menu ul li a").on('click', function() {
		var thisa = $(this);
		$(this).parent().parent().find(".menusub").slideToggle(100,function(){
			if ($(this).css("display") == "block") {
				thisa.removeClass("plus").addClass("mius");
			} else
			thisa.removeClass("mius").addClass("plus");
		});
	});
});
</script>
</body>
</html>
