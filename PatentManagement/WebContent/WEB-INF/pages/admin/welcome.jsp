<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/meta.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>欢迎进入专利收费查询系统</title>   
<script src="${root }/public/js/basiccheck.js"></script>
</head>
<body class="adminSchool" >
<div class="container" style="width: 100%;height: 94%;text-align:center;">
	<div class="wrap" style="text-align:center;">
        <img src="${root }/public/img/login/text1.png" />
        <br/><br/><br/>
            <c:choose>
                <c:when test="${count == 0 }">
                    <a style="font-size: 30px;color: #67B1EE;">您当前没有需要缴费的专利</a>
                </c:when>
                <c:otherwise>
					<a href="${root }/patent/index.do?unpaidStatus=3" style="font-size: 30px;color: #FF5A00;text-decoration: underline;">
					您当前有${count }项专利需要缴费
					</a>
                </c:otherwise>
            </c:choose>
        
        <img src="${root }/public/img/login/text2.png" id=patentInfo style="cursor: pointer;vertical-align:-70%;"/>
    </div>
	<%-- 版权信息图片 --%>
	<div class="footer" style="height: 6%">
		<div class="footerInner">
			<p>版权所有&copy;2007-2013苏州阔地网络科技有限公司</p>
			<div class="footerBox" style="float: left">
				<img src="${root }/public/img/common/logo.gif" />
				<img src="${root }/public/img/login/contact.gif" />
			</div>
		</div>
	</div>
</div>
<script>
	$("#patentInfo").click(function(){
		window.location.href = "${root}/patent/index.do";
	});	
</script>
<style type="text/css">
	html
	{
		hetght:100%;
		margin:0;
	}
	body
	{
		height:100%;
		margin:0;
	}
</style>


</body>
</html>