<%@page import="work.Library"%>
<%@page import="member.dto.MemberDTO"%>
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


  <title>대출현황</title>
  <style>


    .contentsMain{
      position: relative;
    }


    .userSummary{
      float: right;
      position: absolute;
      top: -20px;
      right: 0;
      display: flex;
      flex-direction: column;
      align-items: end;
      margin-bottom: 20px;
    }

    .userSummary ul{
      margin-left: 0;
      padding: 0;
      list-style: none;
    }

    #profile{
      display: flex;
      flex-direction: column;
      text-align: right;
      margin-bottom: 10px;
    }

    .userSummary h3{
      padding: 0;
      margin: 0 0 4px 0;
    }


    .userSummary > ul{
      display: flex;
      justify-content: space-between;
      width: 300px;
      margin: 0 0 0 20px;
      padding: 0;
    }

    .userSummary > ul > li{
      border: 1px solid black;
      text-align: center;
      height: 40px;
      flex: 1 1 23%;
      max-width: 23%;
    }


    .boardCategory{
      clear: both;
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
    }

    .boardCategory div:hover{
      cursor: pointer;
    }

    .boardCategory div:first-of-type{
      background-color: #042d04;
      color:  white;
      border: 1px solid #042d04;
      font-weight: bold;
    }

    .boardUpper{
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 15px;
    }

    .boardUpper-left{
      display: flex;
      align-items: center;
    }

    .boardUpper-left span{
      margin-right: 10px;
    }

    .noticeSearch select{
      width: 25%;
      height: 30px;
      font-size: 15px;
      text-align: center;
      border: #7a7f80 1px solid;
    }


    .noticeSearch input[type="text"]{
      height: 25px;
      width: 55%;
      font-size: 15px;
      padding-left: 1%;
      border: #7a7f80 1px solid;
    }


    .noticeSearch input[type="submit"]{
      width: 15%;
      height: 30px;
      font-size: 15px;
      background-color: #042d04;
      /*background-color: rgb(19, 78, 110);*/
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


    #noticeBoard td:nth-of-type(3){
      text-align: left;
    }

    #noticeBoard th{
      background-color: #eceeee;
    }

    #noticeBoard tbody tr:hover{
      /*background-color: #dcfaf3;*/
       background-color: rgba(228, 253, 200, 0.9);
    }

    #renewAll{
      border: none;
      font-size: 15px;
      cursor: pointer;
      height: 30px;
      margin-left: 3px;
      width: 140px;
     background-color: #bcce3c;
    }

    .unable{
      background-color: #bbc4c7;
    }

   .paging{
      display: flex;
      width:100%;
      justify-content: center;
      margin: 25px 0 0 0;
    }

    .paging div{
      clear: both;
      padding: 6px 10px;
      transition: background-color 0.1s, font-weight 0.1s;
    }
    
    .paging div:hover{
      background-color: gainsboro;
      cursor: pointer;
      font-weight: bold;
    }
    
    .paging a{
	    text-decoration: none;
	    color: black;
    }
    
    
    #curPage{
    	text-decoration: underline;
    	font-weight: bold;
    }
    
    
    @media screen and (max-width: 820px) {
      .userSummary{
        float: none;
        position: initial;
        display: flex;
        flex-direction: column;
        align-items: end;
        margin-bottom: 20px;
      }


  </style>

  <script>

    $(function(){
    	
    	
    	let message = "${message}";
    	if(message != null && message != ''){
    		alert(message);
    	}
    	

      $("#selectAllCheck").change(function(){
        if($(this).is(":checked")){
          $('input:checkbox[name="renewCheck"][disabled=false]').prop('checked',true);
        }
        else{
          $('input:checkbox[name="renewCheck"]').prop('checked',false);
        }
      });


      $("input:checkbox[name='renewCheck']").change(function(){
        if(!$(this).is(":checked")){
          if($("#selectAllCheck").is(":checked")){
            $("#selectAllCheck").prop('checked',false);
          }
        }
      });

    });
    
	function list(curPage){
	      location.href="${path}/my_library/borrowedBooks"+"&curPage=" + curPage;
	}
	
	
	function renewAll(){
		
		if("${dto.checkout_status}"=="대출불가"){
			alert("대출 연장이 불가능한 상태입니다.");
			return false;
		}
		
		let checked = $("input[name='renewCheck']:checked");
		
		if(checked.length > 0){
			$("input[name='title']").attr("disabled", true);
			let selectedRows = checked.closest("tr");
			
			selectedRows.each(function() {
	        	  let row = $(this);
	        	  row.find("input[name='title']").attr("disabled", false);
	        });
			
			
			document.form1.action = "${path}/my_library/renewal.do";
			document.form1.submit();

		}
		
		else{
			alert("대출기간 연장을 희망하는 도서를 선택해주세요.");
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
  <div class="contentsHeader">
    <h1>대출·연장·예약 조회</h1>
  </div>
  <div class="contentsLocation">
    홈 &gt 내 서재 &gt 대출·연장·예약 조회
  </div>
  <div class="contentsMain">


    <div class="userSummary">
        <ul>
          <li>
            <div>상태</div>
            <div>${dto.checkout_status}</div>
          </li>
          <li>
            <div>대출도서</div>
            <%  
            MemberDTO dto = (MemberDTO)request.getAttribute("dto");
            int max_borrow = Library.getMaxBorrow(dto.getUser_type()); %>
            <div>${dto.numCheckedOut}/<%=max_borrow%></div>
          </li>
          <li>
            <div>예약도서</div>
            <div>${dto.numReservations}/<%=Library.MAX_RESERVATION%></div>
          </li>
          <li>
            <div>연체도서</div>
            <div>${dto.numLateReturns}</div>
            <!--얘네 클릭해서 정보 확인하거나 가져올 수 있게-->
          </li>
        </ul>
<!--        <ul>-->
<!--          <li>연체료 0건이 있습니다.</li>-->
<!--          <li>분실도서 0건이 있습니다.</li>-->
<!--        </ul>-->
      </div>

    <div class="boardCategory">
      <div onclick="location.href='https://www.google.com/'">대출현황/연장</div>
      <div>예약현황</div>
      <div>이전대출내역</div>
    </div>

    <div class="userStatus">
    </div>
    <div class="boardUpper">
      <div class="boardUpper-left">
      <span>총 ${dto.numCheckedOut}권 대출중</span>
      <div id="selectAll">
<!--        <label for="selectAllCheck">전체선택</label>-->
        <button type="button" id="renewAll" onclick="renewAll()">선택도서 대출연장</button>
      </div>
      </div>
        <div id="sorting">
          <select>
            <option selected>정렬항목</option>
            <option>대출일</option>
            <option>반납예정일</option>
            <option>서명</option>
          </select>
          <select>
            <option>정렬</option>
            <option>오름차순</option>
            <option>내림차순</option>
          </select>
          <button>정렬</button>
        </div>
      </div>
<!--      <div class="search-box">-->
<!--        <form name="noticeSearch" class="noticeSearch" method="get">-->
<!--          <div id="noticeSearchinnerBox">-->
<!--            <select>-->
<!--              <option selected>전체</option>-->
<!--              <option>제목</option>-->
<!--              <option>내용</option>-->
<!--              <option>작성자</option>-->
<!--            </select>-->
<!--            <input type="text" size="30">-->
<!--            <input type="submit" value="검색">-->
<!--          </div>-->
<!--        </form>-->
<!--      </div>-->

	<form name="form1" method="post">
    <input type="hidden" name="curPage" value="${page.curPage}">
    <table id="noticeBoard">
      <thead>
      <tr>
        <th><input type="checkbox" id="selectAllCheck"></th>
        <th>No.</th>
        <th>도서정보</th>
        <th>대출일</th>
        <th>반납기한</th>
        <th>연체일수</th>
        <th>연장횟수</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="row" items="${list}" varStatus="status">
        <tr>
        <td>
        <c:choose>
        	<c:when test="${row.renewal_count>=maxRenewal || dto.checkout_status=='대출불가'}">
	        	<input type="checkbox" name="renewCheck" disabled="disabled" value="${row.checkout_id}">
        	</c:when>
        	<c:otherwise>
        		<input type="checkbox" name="renewCheck" value="${row.checkout_id}">
        	</c:otherwise>
        </c:choose>
        </td>
        <c:set var="num" value="${(page.curPage-1)*page.page_scale+status.count}"/>
        <td>${num}</td>
        <td>
          ${row.title} <input type="hidden" name="title" value="${row.title}">
           / ${row.main_author} 지음</td>
        <td><fmt:formatDate value="${row.checkout_date}" pattern="yyyy-MM-dd"/></td>
        <td><fmt:formatDate value="${row.due_date}" pattern="yyyy-MM-dd"/></td>
        <td>${row.late_days}</td>
        <td>${row.renewal_count}</td>
      </tr>    
      </c:forEach>
      </tbody>
    </table>
    </form>

    <div class="paging">
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

  </div>
</div>


<footer>
<%@include file="../include/bottom.jsp" %>
</footer>


</body>
</html>