<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit">
<%
	String contextPath = request.getContextPath();
	if (contextPath.equals("/")) {
		request.getSession().setAttribute("root", "");
	} else {
		request.getSession().setAttribute("root", contextPath);
	}

%>
<link media="all" type="text/css" rel="stylesheet" href="${root }/public/css/reset.css"/>
<link type="text/css" rel="stylesheet" href="${root }/public/css/header.css" media="screen">
<link type="text/css" rel="stylesheet" href="${root }/public/css/global.css" media="screen">
<link type="text/css" rel="stylesheet" href="${root }/public/css/common.css" media="screen">
<script> var ROOT =  '${root }';</script>
<script src="${root }/public/js/jquery.js" type="text/javascript"></script> 
<script src="${root }/public/js/extend.js" type="text/javascript"></script>
<script src="${root }/public/js/litewin.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js" type="text/javascript"></script>
<script src="${root }/public/js/splitpage.js" type="text/javascript"></script>
<script src="${root }/public/easyui/jquery.easyui.min.js" type="text/javascript"></script>
