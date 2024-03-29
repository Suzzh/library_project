<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"content="width=device-width,initial-scale=1.0">
  <link href="${path}/include/style.css" type="text/css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="${path}/include/header.js"></script>

 <title>공지사항</title>
  <style>

    .notice_view{
      border-top: #777777 solid 1px;
      display: flex;
      flex-direction: column;
    }

    .title{
      background-color: #eceeee;
      padding: 15px 15px;
    }

    .title h3{
      font-size: 1.4em;
      margin: 0;
      padding: 0;
    }

    .detail{
      display: flex;
      justify-content: right;
      padding: 8px 3px;
      align-items: center;
      border-bottom: #bbc4c7 solid 1px;
    }

    .detail div{
      padding: 0 12px;
      border-right: 1px solid black;
    }

    .detail div:last-of-type{
      border: none;
    }

    .notice_content{
      padding: 30px 15px;
      border-bottom: 1px solid #bbc4c7;
    }
    
    #buttonSpace{
    	display: flex;
    	flex-direction: row;
    	justify-content: center;
    }
    
    .buttons{
      margin: 20px 5px 0 5px;
      width: 80px;
      height: 36px;
      line-height: 36px;
      font-size: 15px;
      background-color: #6e736e;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    #toList{
	  background-color: #042d04;
    }
    



  </style>



</head>
<body>

<div class="float-header">
<%@include file="../include/top.jsp" %>
</div>

<div class="header-location">
</div>


<div class="contents">
  <div class="contentsHeader">
    <h1>공지사항</h1>
  </div>
  <div class="contentsLocation">
    홈 &gt 도서관안내 &gt 공지사항
  </div>
  <div class="contentsMain">
    <div class="notice_view">
      <div class="title"><h3>[${dto.post_category}] ${dto.title}</h3></div>
      <div class="detail"><div>${dto.dept_name}</div>
      <div><fmt:formatDate value="${dto.post_date}" pattern="yyyy-MM-dd"/></div>
      <div>조회: ${dto.view_count}</div></div>
      <div class="notice_content">${dto.notice_content}</div>
      <div>
      <c:if test="${dto.filesize>0}">
      <img src="${path}/include/disk.png" width="30px;">
      <a href="${path}/notice_servlet/download.do?notice_id=${dto.notice_id}">
      ${dto.filename}</a> (${dto.filesize} bytes)
      </c:if>
      </div>
      <div id="buttonSpace">
	      <button onclick="location.href='${path}/notice_servlet/board.do?category=${category}&curPage=${curPage}'" class="buttons" id="toList">목록</button>
	      <c:if test="${sessionScope.admin_id == dto.writer_id}">
	      <button onclick="location.href='${path}/notice_servlet/editForm.do?notice_id=${dto.notice_id}'" class="buttons">수정</button>
	      <button onclick="location.href='${path}/notice_servlet/delete.do?notice_id=${dto.notice_id}'" class="buttons">삭제</button>      
	      </c:if>
      </div>
    </div>



  </div>
</div>


<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>


</body>
</html>