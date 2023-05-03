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


    <title>도서대출</title>
    <style>

        .findUser{
            display: flex;
            align-items: center;
        }

        #user_id{
            height: 21px;
            margin: 0 5px;
        }

        #btnFindUser{
            background-color: #042d04;
            color: white;
            border: none;
            font-size: 16px;
            padding: 4px 20px;
            cursor: pointer;
        }



    </style>
    
    
    <script>
    
    
    $(function(){
    	$("#btnFindUser").click(function(){
    		check();
    	});
    	
    });
    
    
    function check(){
    	let user_id = $("#user_id").val();
    	
        let exp1 = /^[0-9]{10,15}$/;
        if(exp1.test(user_id)){
    		document.findUserForm.submit();
    	}
        
        else {
        	alert("잘못된 ID 형식입니다. 10-15자리 숫자로 입력해주세요.");
        	return;
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
<c:if test="${param.message=='error'}">
<script>
$(function(){
	alert("일치하는 회원이 없습니다.");
});
</script>
</c:if>

<c:if test="${param.message=='access'}">
<script>
$(function(){
	alert("회원 ID를 입력해주세요.");
});
</script>
</c:if>

    <div class="contentsHeader">
        <h1>도서대출</h1>
    </div>
    <div class="contentsLocation">
        홈 &gt 도서대출
    </div>
    <div class="contentsMain">

		<form name="findUserForm" action="${path}/member_servlet/view.do">
        <div class="findUser">
            <span>회원ID</span><input name="user_id" id="user_id" value=${param.user_id}><button type="button" id="btnFindUser">회원조회</button>
        </div>
        </form>
        

    </div>

</div>


<footer>
<%@include file="../include/bottom.jsp" %>
</footer>


</body>
</html>