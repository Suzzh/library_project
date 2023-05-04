<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"content="width=device-width,initial-scale=1.0">
  <link href="${path}/include/style.css" type="text/css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="${path}/include/header.js"></script>


    <title>공지등록</title>
    <style>

        .writeBox{
            display: flex;
            width: 100%;
            flex-direction: column;
        }

        .writeBox div{
            display: flex;
            flex: 1 1 100%;
        }

        .writeBox > div:first-of-type{
            margin-bottom: 10px;
        }

        .writeBox select{
            padding-left: 10px;
            width: 130px;
            height: 30px;
            font-size: 15px;

        }

        #title{
            flex-grow: 1;
            margin-left: 5px;
            padding-left: 10px;
            font-size: 15px;
        }


        #notice_content{
            height: 350px;
            resize: none;
            padding: 10px 10px;
            font-size: 15px;
        }

        .writeBox input[type="file"], textarea{
            margin-top: 10px;
        }

        .writeBox div:last-of-type {
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        .writeBox div:last-of-type input[type="submit"]{
            width: 100px;
            line-height: 30px;
            font-size: 15px;
            background-color: #042d04;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }





    </style>
    
    
    <script>
    
    function check(){    	
         if($("#title").val().trim()==""){
             alert("제목을 입력해주세요.");
             $("#title").focus();
             return false;
          }
         else if($("#notice_content").val().trim()==""){
             alert("내용을 입력해주세요.");
             $("#notice_content").focus();
             return false;
            }
         
         else if($("#post_category").val()=="" || $("#post_category").val()==null){
             alert("분류를 지정해주세요.");
             $("#post_category").focus();
             return false;
            }
         
         return true;

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
    <form method="post" action="${path}/notice_servlet/write.do">
        <div class="writeBox">
            <div><input type="checkbox" name="fix" id="fix"><label for="fix">상단고정</label></div>
            <div>
                <select name="post_category" id="post_category">
                    <option value="">분류</option>
                    <option value="일반">일반</option>
                    <option value="시설">시설</option>
                    <option value="학술정보">학술정보</option>
                </select>
                <input type="text" placeholder="제목" id="title" name="title">
            </div>
            <textarea id="notice_content" name="notice_content"></textarea>
            <div>
                <input type="file" name="file"><output></output>
            </div>
            <div>
            <input type="submit" value="등록" onclick="return check()">
            </div>
        </div>
      </form>

    </div>
</div>


<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>


</body>
</html>