<%@page import="work.Pager"%>
<%@page import="notice.dto.NoticeDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>


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

    .boardCategory{
      display: flex;
      width: available;
      border-bottom: 1px solid #777777;
      margin-bottom: 30px;
    }


    .boardCategory div{
      padding: 7px 28px;
      border-top: 1px #777777 solid;
      border-right: 1px #777777 solid;
      border-left: 1px #777777 solid;
      margin-right: 4px;
      border-top-left-radius: 5px;
      border-top-right-radius: 5px;
      color: black;
    }

    .boardCategory div:hover{
      cursor: pointer;
    }
    
    /*
    
    .selectedCategory{
      background-color: #042d04;
      color:  white;
      border: 1px solid #042d04;
      font-weight: bold;
    }
    
    */

    .boardUpper{
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .boardUpper span{
      font-size: 0.9em;
    }


    .search-box select{
       width: 22%;
       height: 29px;
       font-size: 15px;
       padding-left: 5px;
       border: #7a7f80 1px solid;
     }

     .search-box input[type="text"]{
     	height: 25px;
        width: 50%;
        font-size: 15px;
        padding-left: 1%;
        border: #7a7f80 1px solid;
      }


      .search-box input[type="submit"]{
        width: 18%;
        height: 30px;
        font-size: 15px;
        background-color: #042d04;
        color: white;
        border: none;
        border-radius: 4px;
      }
        

    #noticeBoard{
      width: 100%;
      border-collapse: collapse;
      text-align: center;
      border-top: #777777 solid 1px;
      margin-top: 10px;
    }

    #noticeBoard td, th{
      border-bottom: #bbc4c7 solid 1px;
      padding: 10px 10px;
      font-size: 15px;
    }


    #noticeBoard td:nth-of-type(2){
      text-align: left;
    }

    #noticeBoard th{
      background-color: #eceeee;
    }
    
     #noticeBoard th:first-of-type{
         width: 50px;
     }

     #noticeBoard th:nth-of-type(2){
         width: 50%;
     }

     #noticeBoard th:nth-of-type(3){
         width: 160px;
     }
     
     .to_notice a{
     	text-decoration: none;
     	color: black;
     }

    #noticeBoard tbody tr:hover{
      /*background-color: #dcfaf3;*/
      background-color: rgba(246, 233, 245, 0.9);
    }

    .fixed{
      background-color: #e9f8d1;
    }
    

    #addNotice{
      margin-top: 10px;
      float: right;
      padding: 0 10px;
    }


    .noticePaging{
      display: flex;
      width:100%;
      justify-content: center;
      margin: 25px 0 0 0;
    }

    .noticePaging div{
      clear: both;
      padding: 6px 10px;
      transition: background-color 0.1s, font-weight 0.1s;
    }
    
    .noticePaging div:hover{
      background-color: gainsboro;
      cursor: pointer;
      font-weight: bold;
    }
    
    .noticePaging a{
	    text-decoration: none;
	    color: black;
    }
    
    
    #curPage{
    	text-decoration: underline;
    	font-weight: bold;
    }


  </style>
 
  
  <script>
  
  $(function(){
	 
	  	let category = "${category}";
	  	if(category=="") category = "all";
	  	let div = document.getElementById(category);
	  	$(div).css({
	        "background-color": "#042d04",
	        "color": "white",
	        "border": "1px solid #042d04",
	        "font-weight": "bold"
	  	});
	    
  });
  
  
  function list(curPage){
	      location.href="${path}/notice_servlet/board.do/?category=${category}&curPage=" + curPage;
  }

  </script>


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
  
	  
    <div class="boardCategory">
      <a href="${path}/notice_servlet/board.do" style="text-decoration: none;"><div id="all">전체</div></a>
      <a href="${path}/notice_servlet/board.do?category=general" style="text-decoration: none;"><div id="general">일반</div></a>
      <a href="${path}/notice_servlet/board.do?category=facility" style="text-decoration: none;"><div id="facility">시설</div></a>
      <a href="${path}/notice_servlet/board.do?category=academic" style="text-decoration: none;"><div id="academic">학술정보</div></a>
    </div>
        
    <div id="table">   
    	   <div class="boardUpper">
      <span>총 ${count}건, ${page.curPage}/${page.totPage}페이지</span>
      <div class="search-box">
        <form name="noticeSearch" class="noticeSearch" method="get">
            <select>
              <option selected>전체</option>
              <option>제목</option>
              <option>내용</option>
              <option>작성자</option>
            </select>
            <input type="text" size="30">
            <input type="submit" value="검색">
        </form>
      </div>
    </div>
     <table id="noticeBoard">
      <thead>
      <tr>
        <th>No.</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회</th>
        <th>첨부 파일</th>
      </tr>
      </thead>
      <tbody>
     <c:set var = "pageScale" value="${page.page_scale}"/>
     
      <c:forEach var="dto" items="${notices}" varStatus="status">
      <c:choose>
      	<c:when test="${dto.fix==1}">
      	 <tr class="fixed"><td>공지</td>
      	</c:when>
      	<c:otherwise> 	
      	 <tr><td>${count-(page.curPage-1)*pageScale-status.index}</td>
      	</c:otherwise>
      </c:choose>      
        <td class="to_notice">[${dto.post_category}] 
        <a href="<%=request.getContextPath()%>/notice_servlet/view.do?notice_id=${dto.notice_id}&category=${category}&curPage=${page.curPage}">${dto.title}</a></td>
        <td>${dto.dept_name}</td>
        <td><fmt:formatDate value="${dto.post_date}" pattern="yyyy-MM-dd"/></td>
        <td>${dto.view_count}</td>
        <td></td>
      </tr>
      </c:forEach>
      </tbody>
      </table>
    </div>
    
    <c:if test="${sessionScope.admin_id!=null}">
    <button type="button" id="addNotice" onclick="location.href='${path}/notice/write.jsp'">글쓰기</button>
    </c:if>

    <div class="noticePaging">
    <c:if test="${page.curPage > 1}">
      <a href="#" onclick="list('1')">
      <div>&lt&lt</div>
      </a>
    </c:if>
    <c:if test="${page.curBlock > 1}">
      <a href="#" onclick="list('page.prevPage')">
      <div>&lt</div>
      </a>
    </c:if>
    <c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
    	<c:choose>
    		<c:when test="${num==page.curPage}">
    		      <a href="#" onclick="list('${num}')">
    		      <div id="curPage">${num}</div>
				  </a>
    		</c:when>
    		<c:otherwise>
    		      <a href="#" onclick="list('${num}')">
    		      <div>${num}</div>
				  </a>
    		</c:otherwise>
    	</c:choose>
    </c:forEach>
    <c:if test="${page.curBlock < page.totBlock}">
	  <a href="#" onclick="list('${page.nextPage}')">
      <div>&gt</div>
      </a>
    </c:if>
    <c:if test="${page.curPage < page.totPage}">
	  <a href="#" onclick="list('${page.totPage}')">
      <div>&gt&gt</div>
      </a>
    </c:if>
    </div>


  </div>
</div>


<footer>
<%@include file="../include/bottom.jsp" %>
</footer>



</body>
</html>