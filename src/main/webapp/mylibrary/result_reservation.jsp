<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"content="width=device-width,initial-scale=1.0">
  <link href="${path}/include/popstyle.css" type="text/css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>


  <title>도서예약</title>
  <style>
  
  
   .reservation-main{
      margin: 0 auto;
      width: auto;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    
    h3{
  	  margin-bottom: 30px;
  	}

    #buttons{
      margin-top: 15px;
    }

    #cancelBtn {
      cursor: pointer;
      height: 30px;
      width: 120px;
      font-size: 17px;
      background-color: #6e736e;
      color: white;
      border: none;
    }
    
    #reservationDesc{
      margin-top: 20px;
      background-color: #f1f1f1;
      font-size: 14px;
      line-height: 1.5em;
    }

    #reservationDesc ul{
      padding: 10px 30px 10px 40px;
    }    


  </style>


</head>


  <script>
  $(function(){
	  opener.location.reload();
  });
  </script>


<body>
<div class = "contents">
  <div class="contentsHeader">
    <h1>도서예약</h1>
  </div>
  <div class="contentsMain">
      <div class="reservation-main">
        <h3>${title}</h3>
        <c:choose>
        	<c:when test="${message!=null}">
        	<div>${message}</div>
        	</c:when>
        	<c:otherwise>
        	<div>비정상적인 접근입니다.</div>
        	</c:otherwise>
        </c:choose>
        <div id="buttons">
        <button id="cancelBtn" onclick="window.close()">닫기</button>
        </div>
      </div>
    	<c:if test="${message=='success'}">
    	<div id="reservationDesc">
	      <ul>
	        <li>예약도서 도착 시 이메일 및 문자메시지로 통보해 드립니다.</li>
	        <li>예약순번이 되었으나 3일간 대출하지 않을 경우 예약이 자동으로 취소됩니다.</li>
	      </ul>
	    </div>
    	</c:if>
  </div>
</div>
</body>
</html>


