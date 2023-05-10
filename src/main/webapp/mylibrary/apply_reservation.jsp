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

    #submitBtn {
      cursor: pointer;
      height: 30px;
      width: 120px;
      font-size: 17px;
      background-color: #042d04;
      color: white;
      border: none;
      margin-right: 6px;
    }

    #cancelBtn {
      cursor: pointer;
      height: 30px;
      width: 120px;
      font-size: 17px;
      background-color: #6e736e;
      color: white;
      border: none;
      margin-left: 6px;
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
  
  
  <script>
  
  $(function(){
	  opener.location.reload();
  });
  
  </script>


</head>


<body>
<div class = "contents">
  <div class="contentsHeader">
    <h1>도서예약</h1>
  </div>
  <div class="contentsMain">
    <form name="form1" action="${path}/my_library/make_reservation.do">
      <div class="reservation-main">
      <input type="hidden" name="isbn" value="${isbn}">
      <input type="hidden" name="title" value="${title}">
        <h3>${title}</h3>
        <div>이 도서를 예약하시겠습니까?</div>
        <div id="buttons">
        <input type="submit" id="submitBtn" value="확인">
        <button id="cancelBtn" onclick="window.close()">취소</button>
        </div>
      </div>
    </form>
        <div id="reservationDesc">
      <ul>
        <li>1인당 최대 3권의 책을 예약할 수 있습니다.</li>
        <li>책 1권당 최대 10명까지 예약이 가능합니다.</li>
        <li>예약도서 도착 시 이메일 및 문자메시지로 통보해 드립니다.</li>
        <li>예약순번이 되었으나 3일간 대출하지 않을 경우 예약이 자동으로 취소됩니다.</li>
      </ul>
    </div>
    
  </div>
</div>
</body>
</html>


