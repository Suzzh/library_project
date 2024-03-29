<%@page import="book.dto.AuthorDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page import="book.dto.CopyDTO"%>
<%@page import="book.dto.BookDTO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport"content="width=device-width,initial-scale=1.0">
 	<link href="${path}/include/style.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="${path}/include/header.js"></script>

    <title>도서정보</title>
    <style>


        .contentsMain{
            display: flex;
            /*background-color: #bcce3c;*/
        }

        .book_content{
            flex: 1 1 auto;
            display: flex;
            flex-direction: column;
            /*background-color: #bbc4c7;*/
        }

        .profileUpper{
            margin-bottom: 20px;
        }

        .profileUpper h2{
            margin-top: 0;
            margin-bottom: 10px;
        }

        .profile{
            display: flex;
        }


        .bookImgWrapper{
            width: 220px;
            height: auto;
            padding-right: 40px;
        }

        .book_img {
            width: 180px;
            height: 250px;
            border: 1px #bbc4c7 solid;
            box-shadow: 4px 4px 4px 2px #bbc4c7;
        }


        .bookDetail{
            flex: 1 1 auto;
            min-height: 250px;
        }

        .bookDetail table{
            height: 100%;
            width: 100%;
        }

        .bookDetail th{
            width: 130px;
            text-align: left;
        }

        .bookDetail td{
            padding-right: 40px;
        }


        .bookInfo h2{
            margin-top: 0;
        }


        /*.myBook{*/
        /*    float: right;*/
        /*    display: flex;*/
        /*    align-items: center;*/
        /*    margin: 10px 10px;*/
        /*}*/


        /*#toMyBook{*/
        /*    text-decoration: none;*/
        /*}*/

        /*#toMyBook:active, :visited{*/
        /*    color: black;*/
        /*}*/

        .headers{
            border-bottom: 1px solid black;
            width: 100%;
            height: 35px;
            /*background-color: #042d04;*/
            /*color: white;*/
            /*margin-top: 50px;*/
            /*padding-left: 25px;*/
            /*height: 40px;*/
            /*line-height: 40px;*/
        }

        .headers h3{
            margin: 0 0;
            padding: 0 0;
            background-color: #042d04;
            color: white;
            width: 120px;
            height: 100%;
            line-height: 35px;
            text-align: center;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }


        [class*="info_"]{
            margin-top: 50px;
        }


        .info_search table{
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            border-bottom: #777777 solid 1px;
        }

        .info_search th, .info_search td{
            font-size: 15px;
        }

        .info_search table th{
            background-color: #eceeee;
            height: 60px;
        }

        .info_search table td{
            padding: 10px 10px;
            border-bottom: dashed 1px #bbc4c7;
        }
        

        .info_search table tbody tr:hover{
            background-color: rgba(228, 253, 200, 0.9);
        }

        /*.book_info div:nth-of-type(2){*/
        /*    padding: 20px 25px;*/
        /*    border-bottom: #777777 solid 1px;*/
        /*    line-height: 1.6em;*/
        /*}*/
        
        
        .info_search a{
        	color: black;
        	text-decoration: underline;
        }


        .info_desc{
            border-bottom: #777777 solid 1px;
            display: flex;
            flex-direction: column;
        }

        .info_desc > div:nth-of-type(2){
            padding: 20px 0;
        }


        .info_review{
		display: flex;
		flex-direction: column;
		}
		
		.info_review > div:nth-of-type(2){
		background-color: #eceeee;
		padding: 10px 0;
		text-align: center;
		}
		
		
		#noReviewForm button{
		margin-top: 5px;
		width: 200px;
		font-size: 16px;
		}
		
		form[name='reviewForm']{
		display: none;
		}
		
		#stars{
		width: 70%;
		min-width: 300px;
		margin: 0 auto;
		font-size: 34px;
		display: flex;
		justify-content: flex-start;
		}		
		
		.star {
		margin: 0 6px;
		cursor: pointer;
		}
		
		#stars span:first-child{
		left-margin: 0;
		}
		
		#review_write_box textarea{
		margin: 10px auto 0 auto;
		width: 70%;
		min-width: 300px;
		margin-top: 10px;
		font-size: 16px;
		resize: none;
		}
		
		#review_content{
		height: 180px;
		margin-bottom: 10px;
		}
		
		form[name='reviewForm'] button{
		cursor: pointer;
		height: 30px;
		width: 120px;
		font-size: 17px;
		color: white;
		border: none;
		margin-left: 6px;
		margin-top: 10px;
		}
		
		#reviewSubmitBtn{
		background-color: #042d04;
		}
		
		#reviewResetBtn{
		background-color: #6e736e;
		}

        .reviews{
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .review{
            /*background-color: indigo;*/
            border-bottom: 1px solid black;
            padding: 10px 0;
        }

        .review dt{
            padding-bottom: 5px;
        }

        .review ul{
            /*background-color: #bcce3c;*/
            list-style: none;
            padding: 0;
            display: flex;
        }

        .review ul > li{
            padding: 0 10px;
            border-right: 1px solid black;
        }

        .review ul > li:first-of-type{
            padding-left: 0;
        }

        .review ul > li:last-of-type{
            border-right: none;
        }

        .review dd{
            padding-top: 8px;
            margin: 0;
        }


        article{
            /*background-color: rebeccapurple;*/
            width: 240px;
            flex-shrink: 0;
            margin-left: 30px;
        }

        .recommendBox{
            /*background-color: #bcce3c;*/
            display: flex;
            flex-direction: column;
            text-align: center;
        }

        .recommendBox h4{
            margin-top: 0;
            margin-bottom: 14px;
        }


        .recommendedBooks{
            border: 1px solid #bbc4c7;
            padding: 13px 8px 0 8px;
            display: flex;
            flex-direction: column;
            font-size: 14px;
        }

        .recommendedBooks ul{
            list-style: none;
            padding: 0 0;
            margin: 0 0;
        }

        .recommendedBooks > ul > li{
            display: flex;
            margin-bottom: 13px;
        }

        .recommendedBooks img{
            width: 75px;
            height: 104px;
        }

        .recommendedBooks ul > li > div {
            text-align: left;
            margin: auto 0 auto 8px;
        }

        .recommendedBooks > div:last-child{
            width: 100%;
            padding: 5px 10px 12px 10px;
            display: flex;
            justify-content: center;
        }

        .recommendBox button{
            height: 30px;
            width: 30px;
            margin: auto 5px;
        }


    </style>

    <script>
    
    
    $(function(){
    	$(".star").click(function(){
    		let stars = $(".star");
        	let grade = $(this).attr("id");
        	$("input[name='rating']").val(grade);

        	stars.each(function() {
        		if($(this).attr("id") <= grade)
        			$(this).text("★");
        		else $(this).text("☆");
        	});
    	});
    });
    	

    function goReservation(isbn, title){
    	
    	let top = screen.availHeight/2 - 250;
		if(top < 0) top = 0;

		let left = screen.availWidth/2 - 200;
		if(left < 0) left = 0;
		
		window.open("${path}/my_library/reservation.do?isbn=" + isbn + "&title=" + title, "도서예약",  "left="+left+", top="+top+", width=400, height=500");
	
    }
    
    
    function showReviewForm(){
    	let user_id = "${sessionScope.user_id}";
    	if(user_id!=null && user_id!=''){
	    	$("#noReviewForm").css("display", "none");
	    	$("form[name='reviewForm").css({
	    	"display": "flex",
	    	"flex-direction": "column"
	    	});
    	}
    	
    	else{
    		alert('로그인이 필요한 기능입니다.');
    		location.href = "${path}/member_servlet/loginForm.do";
    	}
    	
    	}


    	function resetReview(){
	    	if($("#review_content").val().trim()!=''){
		    	if(confirm('리뷰 작성을 취소하시겠습니까?')){
			    	$("#review_content").val("");
			    	$("#review_title").val("");
			    	$("#1").text("★");
			    	$("#2").text("★");
			    	$("#3").text("★");
			    	$("#4").text("☆");
			    	$("#5").text("☆");
			    	$("input[name='rating']").val("3");
			    	$("form[name='reviewForm").css("display", "none");
			    	$("#noReviewForm").css("display", "block");
	    	}
	    	}
	    	
	    	else{
		    	$("#1").text("★");
		    	$("#2").text("★");
		    	$("#3").text("★");
		    	$("#4").text("☆");
		    	$("#5").text("☆");
		    	$("input[name='rating']").val("3");
		    	$("#review_content").val("");
		    	$("#review_title").val("");	    		
	    		$("form[name='reviewForm").css("display", "none");
		    	$("#noReviewForm").css("display", "block");
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
        <h1>상세정보</h1>
    </div>
    <div class="contentsLocation">
        홈 &gt 도서검색 &gt 상세정보
    </div>
    <div class="contentsMain">
    <div class="book_content">
        <div class="profileBox">
        <div class="profileUpper">
        
        
        <%
        
        BookDTO book = (BookDTO) request.getAttribute("bdto");
        
        List<String> authorNames = new ArrayList<>();
        List<String> translatorNames = new ArrayList<>();
        List<String> painterNames = new ArrayList<>();
        List<AuthorDTO> authors = book.getAuthors();
        
        for (AuthorDTO author : authors){
        	if(author.getAuthor_type().equals("그림")){
        		painterNames.add(author.getAuthor_name());
        	} else if(author.getAuthor_type().equals("옮김")){
        		translatorNames.add(author.getAuthor_name());
        	} else {authorNames.add(author.getAuthor_name());
        	}
        }
        
        String author = String.join(", ", authorNames) + " 지음";
        if(translatorNames.size()>=1) author += "; " + String.join(", ", translatorNames) + " 옮김";
        if(painterNames.size()>=1) author += "; " + String.join(", ", painterNames) + " 그림";
        
        %>

        <h2>${bdto.title}</h2> <%=author%>
        </div>
        <div class="profile">
            <div class="bookImgWrapper">
              <c:choose>
              	<c:when test="${bdto.img_url!='' && bdto.img_url!=null}">
	              <img src="${bdto.img_url}" class="book_img">
                </c:when>
                <c:otherwise>
                  <img src="${path}/include/default_book.png" class="book_img">
                </c:otherwise>
               </c:choose>
            </div>
                <div class="bookDetail">
                <table>
                    <tr>
                        <th>서명</th>
                        <td>${bdto.title}</td>
                    </tr>
                    <tr>
                        <th>저자</th>
                        <td>
                            <c:forEach var="author" items="${bdto.authors}">
                            ${author.author_name}<br>
                            </c:forEach>
                    </tr>
                    <tr>
                        <th>발행사항</th>
                        <td>${bdto.publisher_location} : ${bdto.publisher_name}, ${bdto.publication_year}</td>
                    </tr>
                    <tr>
                        <th>형태사항</th>
                        <td>
                        <c:if test="${bdto.page_count!=0 && bdto.page_count!=null}">
                        ${bdto.page_count}
                        </c:if>
                        p. ; 
                        <c:if test="${bdto.book_size!=0 && bdto.book_size!=null}">
                        ${bdto.book_size}
                        </c:if>                        
                        cm</td>
                    </tr>
<!--                     <tr>
                        <th>원표제</th>
                        <td>Go</td>
                    </tr> -->
                    <tr>
                        <th>ISBN</th>
                        <td>${bdto.isbn}</td>
                    </tr>
                    <tr>
                        <th>분류번호</th>
                        <td>${bdto.classification_code}</td>
                    </tr>
                </table>
            </div>
        </div>
            </div>

<!--            <a href="bookInfo3.html" id="toMyBook">-->
<!--                <div class="myBook" id="myBook">-->
<!--                    <img src="https://static.thenounproject.com/png/241665-200.png" width="25px" style="margin-right: 4px;">-->
<!--                    <div>내 서재에 담기</div>-->
<!--                </div>-->
<!--            </a>-->


            <div class="info_search">
                <div class="headers">
                    <h3>소장정보</h3>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>등록번호</th>
                        <th>청구기호</th>
                        <th>소장처</th>
                        <th>도서상태</th>
                        <th>반납예정일</th>
                        <th>예약</th>
                    </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach var="copy" items="${copies}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td>${copy.copy_id}</td>
                        <td>${copy.call_number}</td>
                        <td>${copy.location}</td>
                        <td>${copy.status}</td>
                        <td><fmt:formatDate value="${copy.due_date}" pattern="yyyy-MM-dd"/></td>
                        <td>
                        <c:if test="${status.count == 1}">
                            <c:choose>
	                        	<c:when test="${reservation_status=='예약가능'}">
	                        	<a href="#" onclick="goReservation(${bdto.isbn}, '${bdto.title}')">${reservation_status}<br>
	                        	(${reservation_count}명 예약중)
	                        	</a>
	                        	</c:when>
	                        	<c:otherwise>
	                        	${reservation_status}<br>
	                        		<c:if test="${reservation_count} > 0">
	                        		(${reservation_count}명 예약중)
	                        		</c:if>
	                        	</c:otherwise>
                            </c:choose>
                        </c:if>
                        </td>
                    </tr>
                    </c:forEach>

                    </tbody>
                </table>

            </div>

        <div class="info_desc">
            <div class="headers">
                <h3>책 소개</h3>
            </div>
            <div>
              ${bdto.book_description}
            </div>
        </div>

        <div class="info_review">
            <div class="headers">
                <h3>서평</h3>
            </div>
	<div id="review_write_box">
		<div id="noReviewForm"> 4건의 서평이 있습니다.<br>
		<button type="button" onclick="showReviewForm()">서평을 작성하세요.</button>
		</div>
		
		<form name="reviewForm" id="reviewForm" action="${path}/my_library/addReview.do">
		<div id="stars">
		<span id="1" class="star">★</span><span id="2" class="star">★</span>
		<span id="3" class="star">★</span><span id="4" class="star">☆</span>
		<span id="5" class="star">☆</span>
		<input type="hidden" name="rating" value="3">
		</div>
		
		<textarea name="review_title" id="review_title" rows="1" value="${review_title}"></textarea>
		<textarea name="review_content" id="review_content" value="${review.content}"></textarea>
		<div>
		<button type="button" id="reviewSubmitBtn">작성</button>
		<button type="button" id="reviewResetBtn" onclick="resetReview()">작성취소</button>
		</div>
		</form>
	</div>
            <ul class="reviews">
                <li class="review">
                    <dt>재미있어요.</dt>
                    <ul><li class="score">★★★★☆</li><li class="date">2023-01-16</li></ul>
                    <dd>제 취향의 책을 찾아서 좋습니다. 이 책을 추천합니다.</dd>
                </li>
                <li class="review">
                    <dt>조금 아쉬운 부분이 있다면...</dt>
                    <ul><li class="score">★★☆☆☆</li><li class="date">2023-01-16</li></ul>
                    <dd>심리묘사가 다소 아쉬웠던 작품입니다.</dd>
                </li>
                <li class="review">
                    <dt>재미있어요.</dt>
                    <ul><li class="score">★★★★☆</li><li class="date">2023-01-16</li></ul>
                    <dd>제 취향의 책을 찾아서 좋습니다. 이 책을 추천합니다.</dd>
                </li>
                <li class="review">
                    <dt>조금 아쉬운 부분이 있다면...</dt>
                    <ul><li class="score">★★☆☆☆</li><li class="date">2023-01-16</li></ul>
                    <dd>심리묘사가 다소 아쉬웠던 작품입니다.</dd>
                </li>
            </ul>
        </div>

    </div>

        <article>
            <div class="recommendBox">
                <h4>관련분야 인기대출도서</h4>
                    <div class="recommendedBooks">
                        <ul>
                            <li>
                                <img src="https://image.yes24.com/goods/90051766/XL">
                                <div>달러구트 꿈 백화점 : 주문하신 꿈은 매진입니다 : 이미예 장편소설 / 이미예 지음</div>
                            </li>
                            <li>
                                <img src="https://image.yes24.com/Goods/108887930/XL">
                                <div>작별인사 : 김영하 장편소설 / 김영하 지음</div>
                            </li>
                            <li>
                                <img src="https://kr.object.ncloudstorage.com/changbi/images/2023/2/230202_ad376051-ab18-4a44-9ab8-a68d4819de97.jpg">
                                <div>러브 몬스터 : 이두온 장편소설 / 이두온 지음</div>
                            </li>
                            <li>
                                <img src="https://image.yes24.com/goods/90051766/XL">
                                <div>달러구트 꿈 백화점 : 주문하신 꿈은 매진입니다 : 이미예 장편소설 /이미예 지음</div>
                            </li>
                            <li>
                                <img src="https://image.yes24.com/goods/76106687/XL">
                                <div>지구에서 한아뿐 : 정세랑 장편소설 / 정세랑 지음</div>
                            </li>
                        </ul>
                        <div>
                            <button>&lt</button><button>&gt</button></div>
                        </div>

                </div>

        </article>
    </div>
    </div>


<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>


</body>
</html>