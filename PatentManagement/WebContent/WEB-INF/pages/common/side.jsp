<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="menu">
	<ul class="hide">
		<li class="menulist">
			<div class="menutree1">
				<a hidefocus="true" href="javascript:;" class="mius" style="background-color:#006600 ">专利管理</a>
			</div>
			<ul class='menusub'>
				<li><a href='javascript:;' onclick='clickLeft("${root}/patent/getallpatent.html")'>专利信息</a></li>
				<li><a href='javascript:;' onclick='clickLeft("${root}/patent/addPatent.html")'>增加专利</a></li>
				<%-- <li><a href='javascript:;' id="payPatentId" onclick='clickLeft("${root}/patent/getInDispalyPayPatent.html")'>查看需缴费专利</a></li> --%>
				<%-- <li><a href='javascript:;' onclick='clickLeft("${root}/patent/import.html")'>信息导入</a></li> --%>
			</ul>
		</li>
	</ul>
	<ul>
		<li class="menulist">
			<div class="menutree1">
				<a hidefocus="true" href="javascript:;" class="mius" style="background-color:#006600 ">专利参数设置</a>
			</div>
			<ul class='menusub'>
 				<li><a href='javascript:;' onclick='clickLeft("${root}/patent/getInParameters.html")'>参数配置</a></li> 
<%-- 				<li><a href='javascript:;' onclick='clickLeft("${root}/admin/user/userlist.html")'>参数配置</a></li> --%>
			</ul>
		</li>
	</ul>
	
</div>