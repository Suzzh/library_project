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

    #toList{
      margin: 20px auto 0 auto;
      width: 80px;
      height: 36px;
      line-height: 36px;
      font-size: 15px;
      background-color: #042d04;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }


  </style>



</head>
<body>

<div class="float-header">
  <div class="header-upper-box">
    <div class="header-upper">
      <div class="header-left">
        <a href="index.html" title="지혜대학교 도서관"><img src="https://cdn-icons-png.flaticon.com/512/3362/3362210.png" width="40px"></a>
        <a href="index.html" id="sitename" title="지혜대학교 도서관"><strong>지혜대학교 도서관</strong><br><strong>WISDOM UNIVERSITY LIBRARY</strong></a>
      </div>
      <div class="header-right">
        <a href="login.html" id="toLogin" title="로그인">로그인</a>
        <form name="totalSearch" id="totalSearch" method="get">
          <input type="text" size="15" placeholder="사이트내 검색"
                 style="width:120px; height:30px; margin-left: 30px; padding-left: 12px;">
          <input type="submit" value="search"
                 style="width:70px; height:30px;">
        </form>
      </div>
    </div>
  </div>
  <div class="nav">
    <ul class="menu">
      <li>도서검색</li>
      <li>시설예약</li>
      <li>컬렉션</li>
      <li>도서관안내</li>
      <li>내 서재</li>
      <li>#</li>
    </ul>
  </div>
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
      <button onclick="location.href='${path}/notice_servlet/board.do?category=${category}&curPage=${curPage}'" id="toList">목록</button>
    </div>



  </div>
</div>


<footer>
  지혜대학교도서관 서울특별시 강남구<br>
  COPYRIGHT 2023 WISDOM UNIVERSITY
</footer>


</body>
</html>