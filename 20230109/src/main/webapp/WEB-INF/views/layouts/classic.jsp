<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> <tiles:getAsString name="title"/></title>
</head>
<style>
@font-face {
	font-family: 'GangwonEdu_OTFBoldA';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'GangwonEdu_OTFBoldA';
}

</style>
<body>
	<tiles:insertAttribute name="menu" />
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer"/>
</body>
</html>