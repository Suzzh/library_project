<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>파일 업로드 테스트</h2>
<form name="form1" method="post" enctype="multipart/form-data" action="${path}/notice/upload_result.jsp">
이름 : <input name="name"><br>
제목 : <input name="subject"><br>
파일1 : <input type="file" name="file1">
파일2: <input type="file" name="file2">
<input type="submit" value="업로드">
</form>


</body>
</html>