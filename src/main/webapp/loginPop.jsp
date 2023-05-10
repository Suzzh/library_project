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


  <title>로그인</title>
  <style>
  
  
  .contentsHeader{
    /*background-color: #7db0e8;*/
    margin: 0;
    padding-top: 32px;
    padding-bottom: 16px;
    display: flex;
    flex-direction: column;
    justify-content: center;
	}

	.contentsLocation{
    margin-bottom: 40px;
    /*background-color: #1d688f;*/
	}
  

    .login-box{
      margin: 0 auto;
      width: 580px;
      display: flex;
      flex-direction: column;
    }


    .login-box-main{
      width: 580px;
    }


    .login-box-main form {
      display: flex;
      flex-direction: column;
    }


    .formUpper{
      padding-bottom: 8px;
      border-bottom: #777777 solid 1px;
    }

    .formBody{
      width: 580px;
      margin: auto;
      display: flex;
      flex-direction: row;
      padding: 25px 0;
    }

    .formBody > div{
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      margin-right: 10px;
    }

    .formBody > div > div{
      display: flex;
    }

    .form-label{
      display: flex;

    }

    .form-label label {
      width: 90px;
      text-align: left;
      margin-left: 5px;
      padding-top: 9px;
    }

    .form-label input{
      flex-grow: 1;
      height: 30px;
    }

    #loginBtn {
      cursor: pointer;
      height: 85px;
      width: 120px;
      font-size: 17px;
      background-color: #042d04;
      /*background-color: rgb(19, 78, 110);*/
      color: white;
      border: none;
    }


    #errorMessage{
      border: #ff3f34 solid 1px;
      padding: 10px 10px 10px 30px;
      font-size: 15px;
      font-weight: bolder;
      color: #ff3f34;
      margin-bottom: 10px;
      display: none;
    }



    #loginDesc{
      background-color: #f1f1f1;
      font-size: 14px;
      line-height: 1.5em;
    }

    #loginDesc ul{
    padding: 10px 30px 10px 40px;
    }
    
    
    
@media screen and (max-width: 620px) {

      .login-box, .login-box-main{
        width: auto;
      }

      .formBody{
        width: 100%;
      }

      .formBody{
        flex-direction: column;
      }

      #loginBtn {
        margin-top: 10px;
        width: 100%;
        height: 50px;
      }


    }




  </style>

  <script>
  
  
    $(function(){
    	
    	$('input[name=login_type]').change(function(){
    		
    		if($("input[name=login_type]:checked").val()=="admin"){
    			$("#id").attr("placeholder", "관리자 ID");
    			$("#passwd").attr("placeholder", "관리자 비밀번호");
    		}
    		
    		else{
    			$("#id").attr("placeholder", "학사포탈시스템 ID(학번)");
    			$("#passwd").attr("placeholder", "학사포탈시스템 비밀번호");    			
    		}
    		
    	});



    });
    
    
    
    function gotoLogin(){
      	let id = $("#id").val();
      	//5~10자리 숫자 입력하지 않으면 에러
      	let exp1 = /^\d{5,10}$/;

      	if(id==""){
          $("#errorMessage").css("display", "block");
          $("#errorMessage").html("※ 아이디를 입력해 주세요.");
          $("#id").focus();
          return false;
        }

        if($("#passwd").val()==""){
          $("#errorMessage").css("display", "block");
          $("#errorMessage").html("※ 비밀번호를 입력해 주세요.");
          $("#passwd").focus();
          return false;
        }
        
		if($("input[name=login_type]:checked").val()=="admin"){
			document.loginForm.action = "${path}/admin_servlet/login.do";
			document.loginForm.submit();
		}
		
		else{
			document.loginForm.action = "${path}/member_servlet/login.do";
			document.loginForm.submit();
		}
        
    }



  </script>



</head>


<body>
<div class = "contents">
  <div class="contentsHeader">
  <h1>로그인</h1>
  </div>
  <div class="contentsMain">
  <div class="login-box">
     <div>
      <input type="radio" name="login_type" value="student" checked="checked" id="std_radio">
      <label for="std_radio">학생 로그인</label>
      <input type="radio" name="login_type" value="admin" id="admin_radio">
      <label for="admin_radio">관리자 로그인</label>
     </div>
    <div class="login-box-main">
      <form method="post" class="loginForm" name="loginForm">
      
      
      <%
      	
      	String originalRequestURI = "";
        if(session.getAttribute("originalRequestURI")!=null) {
        	originalRequestURI = (String)session.getAttribute("originalRequestURI");
    		session.removeAttribute("originalRequestURI");
    		%>
    		<input type="hidden" name="originalRequestURI" value="<%=originalRequestURI%>"> 
      <%
        }
     	
        if (session != null && session.getAttribute("user_id") != null) { 
     		if(originalRequestURI.equals("")) response.sendRedirect("index.jsp");
     		else response.sendRedirect(originalRequestURI);
     		return;
      	}
        
       %>

         <input type="hidden" name="pop" value="yes">
         
      <div class="formBody">
      <div>
        <div class="form-label">
          <label for="id">아이디</label>
          <input type="text" id="id" name="id" autofocus placeholder="학사포탈시스템 ID(학번)">
        </div>
        <div class="form-label">
          <label for="passwd">비밀번호</label>
          <input type="password" id="passwd" name="passwd" placeholder="학사포탈시스템 비밀번호">
      </div>
      </div>
        <button type="button" id="loginBtn" onClick="gotoLogin()">로그인</button>
      </div>
      </form>
    </div>
    <div id="errorMessage">
    <%
    String message = request.getParameter("message");
    if(message != null){
    %>
    <script>
    $(function(){
        $("#errorMessage").css("display", "block");
    });
    </script>
    <%=message%>
    <%}%>
    </div>
    <div id="loginDesc">
      <ul>
        <li>학사포탈시스템의 ID(학번)와 비밀번호로 로그인해주세요.</li>
        <li>계정 분실 시 학사포탈시스템에서 확인해주세요.</li>
        <!-- <li>졸업생은 <a href="#">회원제 서비스 가입</a> 후 로그인해 해주세요.<br> -->
        </li>
        <li>기타 문의: 학술자료운영팀 (02-1234-5678)</li>
      </ul>
    </div>

  </div>
  </div>
</div>
</body>
</html>


