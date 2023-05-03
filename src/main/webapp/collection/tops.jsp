<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="work.Pager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"content="width=device-width,initial-scale=1.0">
 	<link href="${path}/include/style.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>


        <title>인기도서</title>



  <style>


    .boardCategory{
      display: flex;
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

    .bestBooksUpper{
      border-bottom: 1px solid #777777;
      display: flex;
      justify-content: space-between;
      align-content: center;
      min-height: 40px;
      line-height: 40px;
      padding: 0 20px;
      font-size: 15px;
    }


    .period select{
      font-size: 15px;
      height: 25px;
    }

    .bestBooks{
      display: flex;
      padding: 0 0;
      margin: 20px 0 0 0;
      width: 100%;
      flex-wrap: wrap;
    }

    div.bestBook{
      padding-left: 20px;
      padding-right: 20px;
      /*padding-bottom: 40px;*/
      text-align: center;
      flex: 0 0 16.666667%;
      max-width: 16.666667%;
    }

    .bestBookWrapper{
      margin: 20px 0 20px 0;
    }


    .imagewrapper{
      margin: 0 auto;
      width: 160px;
      height: 240px;
    }


    .imagewrapper > div:first-child{
      position: absolute;
      /*left: 1px;*/
      /*top: 1px;*/
      z-index: 300;
      padding: 1px 2px 2px 1px;
      width: 20px;
      height: 20px;
      border-top: #bbc4c7 solid 1px;
      border-left: #bbc4c7 solid 1px;
      background-color: #6b5b95;
      color: white;
      margin: 0 0;
      font-size: 14px;
      text-align: center;
      line-height: 19px;
    }

    .imagewrapper img{
      width: 100%;
      border: #bbc4c7 solid 1px;

    }


    .bestBookWrapper> div:nth-of-type(2){
      padding: 7px 0;
      font-weight: bold;
    }

    .bestBookWrapper> div:nth-of-type(3),
    .bestBookWrapper> div:nth-of-type(4) {
      font-size: 13px;
      padding-bottom: 5px;
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


    @media screen and (max-width: 1290px) {
      div.bestBook{
        flex: 0 0 20%;
        max-width: 20%;
      }

    }

    @media screen and (max-width: 1090px) {
      div.bestBook{
        flex: 0 0 25%;
        max-width: 25%;
      }

    }

    @media screen and (max-width: 890px) {
      div.bestBook{
        flex: 0 0 33.33333%;
        max-width: 33.33333%;
      }


      .boardCategory div{
        font-size: 13px;
        padding: 7px 14px;
        margin-right: 4px;
      }
      
     }


    @media screen and (max-width: 700px) {
      div.bestBook{
        padding-left: 15px;
        padding-right: 15px;
        flex: 0 0 50%;
        max-width: 50%;
      }
    }

    @media screen and (max-width: 480px) {
      div.bestBook{
        padding-left: 15px;
        padding-right: 15px;
        flex: 0 0 50%;
        max-width: 50%;
      }

      .imagewrapper{
        width: 120px;
        height: 180px;
      }

    }


  </style>
  
  
  <script>
  
    let days = "${days}";
    let category = "${category}";
  	
	 $(function(){
			 
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
		      location.href="${path}/collection_servlet/top_list.do?days="+days+"&category="+category+"&curPage=" + curPage;
	}
	
	function daysFilter(){

		let period_select = document.getElementById("period_select");
	    days = period_select.options[period_select.selectedIndex].value;

		location.href="${path}/collection_servlet/top_list.do?days="+days+"&category="+category;
		
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
  <h1>대출인기도서</h1>
  </div>
  <div class="contentsLocation">
    컬렉션 &gt 대출인기도서
  </div>
  <div class="contentsMain">
    <div class="boardCategory">
      <a href="${path}/collection_servlet/top_list.do" style="text-decoration: none;">
      <div id="all">전체</div></a>
      <a href="${path}/collection_servlet/top_list.do?category=1" style="text-decoration: none;">
      <div id="1">총류/철학/종교</div></a>
      <a href="${path}/collection_servlet/top_list.do?category=2" style="text-decoration: none;">
      <div id="2">언어/사회과학</div></a>
      <a href="${path}/collection_servlet/top_list.do?category=3" style="text-decoration: none;">
      <div id="3">순수과학/기술과학</div></a>
      <a href="${path}/collection_servlet/top_list.do?category=4" style="text-decoration: none;">
      <div id="4">예술/문학/역사</div></a>
    </div>
    <div class="bestBooksUpper">
    <span>
    
    <%
    Pager pager = (Pager)request.getAttribute("page");
    ArrayList<Map> list = (ArrayList<Map>)request.getAttribute("list");
    int listSize = list.size();
    %>
    
    <%=(pager.getCurPage()-1)*pager.getPage_scale()+1%> - <%=(pager.getCurPage()-1)*pager.getPage_scale()+listSize%>건 출력 / 총 ${count}건</span>
        
        <div class="period">
        <span>기간: 2023-01-23 ~ 2023-02-22</span>
        <select id="period_select" name="days" onchange="daysFilter()">
        <c:choose>
        	<c:when test="${days==90}">
        		<option value="30">최근 1개월</option>
		        <option value="90"  selected="selected">3개월</option>
	            <option value="180">6개월</option>
	            <option value="365">1년</option>
        	</c:when>
        	<c:when test="${days==180}">
        		<option value="30">최근 1개월</option>
		        <option value="90">3개월</option>
	            <option value="180" selected="selected">6개월</option>
	            <option value="365">1년</option>
        	</c:when>
        	<c:when test="${days==365}">
        		<option value="30">최근 1개월</option>
		        <option value="90">3개월</option>
	            <option value="180">6개월</option>
	            <option value="365" selected="selected">1년</option>
        	</c:when>
        	<c:otherwise>
        		<option value="30" selected="selected">최근 1개월</option>
		        <option value="90">3개월</option>
	            <option value="180">6개월</option>
	            <option value="365">1년</option>
        	</c:otherwise>
        </c:choose>
        </select>
      </div>

    </div>
    <div class="bestBooks">
    	<c:forEach var="book" items="${list}">
	      <div class="bestBook">
	        <div class="bestBookWrapper">
	          <div class="imagewrapper">
	            <div>${book.rn}</div>
	            <a href="#" onclick="location.href='${path}/book_servlet/view.do?isbn=${book.isbn}'" >
                <c:choose>
                	<c:when test="${book.img_url!='' && book.img_url!=null}">
	         		   <img src="${book.img_url}">
                	</c:when>
                	<c:otherwise>
                		<img src="${path}/include/default_book.png">
                	</c:otherwise>
                </c:choose>
                </a>
	          </div>
	          <div>${book.title}</div>
	          <div>
	          ${fn:split(book.authornames, ';')[0]}
	          <br>
	          ${book.publisher_name}
	          </div>
	          <div>대출횟수:${book.checkout_times}</div>
	        </div>
	      </div>
    	</c:forEach>
    </div>
    
    
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


<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>


</body>
</html>