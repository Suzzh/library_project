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
        
        #deleteFileLink{
        	text-decoration: none;
        	color: black;
        }
        
        #deleteFileLink:hover{
        	text-decoration: underline;
        }        
        
        
        #hidden_file{
        	display: none;
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
    
    window.onpageshow = function (event) {
		$('#hidden_file').css('display', 'none');
		$('#old_file').css('display', 'block');
		$('input[name="fileDel"]').val('n');
		$('input[type="file"]').val('');
    }
    
    
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
    
    
    function deleteFile(){
    	if(confirm('첨부파일을 삭제하시겠습니까?')){
    		$('#hidden_file').css('display', 'block');
			$('#old_file').css('display', 'none');
			$('input[name="fileDel"]').val('y');
    	}
    	
    	
    	
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
    <form method="post" enctype="multipart/form-data" 
    action="${path}/notice_servlet/update.do">
    <input type="hidden" name="notice_id" value="${dto.notice_id}">
        <div class="writeBox">
        	<c:choose>
        		<c:when test="${dto.fix==1}">
        			<div><input type="checkbox" name="fix" id="fix" checked="checked">
        			<label for="fix">상단고정</label></div>
        		</c:when>
        		<c:otherwise>
        			<div><input type="checkbox" name="fix" id="fix">
        			<label for="fix">상단고정</label></div>
        		</c:otherwise>
        	</c:choose>
            <div>
                <select name="post_category" id="post_category">
                <c:choose>
                	<c:when test="${dto.post_category=='일반'}">
                	<option value="">분류</option>
                    <option value="일반" selected="selected">일반</option>
                    <option value="시설">시설</option>
                    <option value="학술정보">학술정보</option>
                	</c:when>
                	<c:when test="${dto.post_category=='시설'}">
                	<option value="">분류</option>
                    <option value="일반">일반</option>
                    <option value="시설" selected="selected">시설</option>
                    <option value="학술정보">학술정보</option>
                	</c:when> 
                	<c:when test="${dto.post_category=='학술정보'}">
                	<option value="">분류</option>
                    <option value="일반">일반</option>
                    <option value="시설">시설</option>
                    <option value="학술정보" selected="selected">학술정보</option>
                	</c:when> 
                	<c:otherwise>
                	<option value="" selected="selected">분류</option>
                    <option value="일반">일반</option>
                    <option value="시설">시설</option>
                    <option value="학술정보">학술정보</option>
                	</c:otherwise> 
                </c:choose>

                </select>
                <input type="text" placeholder="제목" id="title" name="title" value="${dto.title}">
            </div>
            <textarea id="notice_content" name="notice_content">${dto.notice_content}</textarea>
            <c:choose>
            	<c:when test="${dto.filesize>0}">
		            <div id="old_file">
						<img src="${path}/include/disk.png" width="30px;">
				        <a href="${path}/notice_servlet/download.do?notice_id=${dto.notice_id}">
		   			    ${dto.filename}</a> (${dto.filesize} bytes)&nbsp&nbsp
						<a href="#" onclick="deleteFile()" id="deleteFileLink">X 첨부파일 삭제</a>
						<input type="hidden" name="fileDel" value="n">
		            </div>            	
			        <div id="hidden_file">
			            <input type="file" name="file1"><output></output>
			        </div>
            	</c:when>
            	<c:otherwise>
		            <div>
		                <input type="file" name="file1"><output></output>
		            </div>
            	</c:otherwise>
            </c:choose>
            <div>
            <input type="submit" value="수정" onclick="return check()">
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