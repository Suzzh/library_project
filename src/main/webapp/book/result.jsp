<%@page import="work.Pager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page import="java.util.stream.Collectors"%>
<%@page import="book.dto.FilterDTO"%>
<%@page import="book.dto.Book_AuthorDTO"%>
<%@page import="java.util.List"%>
<%@page import="book.dto.BookDTO"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"content="width=device-width,initial-scale=1.0">
 	<link href="${path}/include/style.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>


        <title>도서검색결과</title>

        <style>
            .bookSearch{
                margin: 0 auto 40px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-width: 480px;
            }

            .search-box{
                width: 100%;
            }

            .search-box div{
                min-width: 480px;
            }

            .search-box div{
                text-align: center;
            }

            .search-box div:first-of-type{
                text-align: right;
                margin-bottom: 10px;
            }

            .bookSearch select{
                width: 25%;
                height: 35px;
                font-size: 16px;
                border: #7a7f80 1px solid;
                padding-left: 5px;
            }

            .bookSearch input[type="text"]{
                height: 30px;
                width: 55%;
                font-size: 16px;
                padding-left: 1%;
                border: #7a7f80 1px solid;
            }


            #bookSearchinnerBox{
                position: relative;
                padding-right: 60px;
            }

            #bookSearchinnerBox a{
                margin-left: 5px;
                text-decoration: none;
                display: none;
                border-radius: 3px;
                padding: 2px 2px;
            }

            #bookSearchinnerBox a:visited, #bookSearchinnerBox a:link{
                color: #333;
                background-color: #bcce3c;
            }
            
            
            #btnSearch{
                width: 15%;
                height: 35px;
                font-size: 16px;
                background-color: #042d04;
                /*background-color: rgb(19, 78, 110);*/
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            

            #btnRedirect {
                position: absolute;
                left: 480px;
                bottom: 0;
                width: 120px;
                height: 35px;
                border: none;
                border-radius: 4px;
                background-color: #bcce3c;
                /*background-color: yellowgreen;*/
                font-size: 16px;
                cursor: pointer;

            }


            .result-box{
                display: flex;
            }

            .filter{
                width: 19%;
                margin-right: 1%;
                height: 100%;
                font-size: 0.9em;
            }

            .filterUpper{
                /*border-bottom: 1px solid black;*/
                min-height: 40px;
                line-height: 40px;
                /*이부분 수정해야 함*/
            }


            .filterBody{
                border: 1px #bbc4c7 solid;
            }
            
            .filterBody a{
		      text-decoration: none;
		      color: black;
		    }
		
		    .filterBody a:hover{
		      text-decoration: underline;
		    }
		    
           .filter_count {
		      color: #999;
		      font-size: 0.9em;
		      margin-left: 3px;
		    }

            /*.filterBody div:first-child{*/
            /*  background-color: #dcdcdc;*/
            /*}*/

            .filterBody div{
                line-height: 2em;
                padding: 0 14px 8px 14px;
            }

            /*.filterBody h2{*/
            /*  padding: 15px 0 10px 14px;*/
            /*  margin: 0 -10px;*/
            /*}*/

            .filterBody h3{
                margin: 0 -14px 8px -14px;
                padding: 5px 0 5px 14px;
                background-color: #eceeee;
            }


            .filterBody ul{
                margin: 0;
                padding: 0 0 0 2px;
                list-style-position: inside;
            }

            #rangeDiv{
                text-align: center;
                padding: 0 0 8px 0;
            }

            #range {
                width: 90%;
                margin: 20px auto 10px auto;
                background-color: #eceeee;
                /*background-color: #bcce3c;*/
            }

            #range .ui-slider-range {
                /*background-color: rgba(0, 0, 0, 0.3);*/
                background-color: rgb(188, 206, 60);
                height: 100%;
                margin: 0;
                padding: 0;
            }

            #rangeDiv input[type="text"]{
                margin: 0 2px;
                width: 50px;
            }

            #rangeDiv button{
                width: 50px;
                margin: 0 0px;
            }


            .resultListBox{
                width: 80%;
                height: 100%;
                margin-left: 10px;
            }

            .resultListUpper{
                border-bottom: 1px solid #777777;
                min-height: 40px;
                line-height: 40px;
                padding: 0 20px;
                display: flex;
                justify-content: space-between;
                font-size: 15px;
            }

            .resultListUpper select{
                height: 25px;
                font-size: 15px;
            }

            .resultListUpper button{
                height: 25px;
                font-size: 15px;
                margin-left: 2px;
                margin-right: 0;

            }

            #sorting select{
                margin-left: 2px;
                margin-right: 0;
            }

            ul.resultList{
                margin: 0 0;
                padding: 0 0;
            }

            .resultList li{
                list-style: none;
            }

            .searchedBook{
                width: 100%;
                display: flex;
                border-bottom: 1px #bbc4c7 solid;
                padding: 10px 10px;
            }

            .searchedBook img{
                width: 91px;
                height: 130px;
          	    border: 1px #bbc4c7 solid;
            }

            .searchedBookDetails{
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                margin-left: 12px;
                width: 80%;
                height: 130px;
            }
            
            
            .searchedBookDetails a{
            	text-decoration: none;
            	color: black;
            }
            
            .searchedBookDetails a:hover{
            	text-decoration: underline;
            }
            
            
            .bookIssued{
                font-size: 12px;
                color: #999;
                margin-bottom: 3px;
            }

            .bookName{
                margin-top: 0;
                margin-bottom: 7px;
            }
            

            .bookAuthor, .bookPublisherYear{
                font-size: 14px;
                margin-bottom: 7px;

            }

            .bookNow{
                font-size: 14px;
            }

            [class*="bookStatus"]{
                font-weight: bold;
            }

            .bookStatus_ok{
                /*color: #0077be;*/
                color: #2e86c1;
            }

            .bookStatus_no{
                color: #ff3f34;
                /*color: #d90202;*/
            }

            .bookStatus_wait{
                color: #666;
            }



            .noticePaging{
                display: flex;
                width:100%;
                justify-content: center;
            }

            .noticePaging div{
                margin-top: 20px;
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
            


		
    /*@media screen and (max-width: 725px) {*/
    /*  .search-box div{*/
    /*    min-width: auto;*/
    /*    width: 90%;*/
    /*  }*/
    
    /*  .resultListUpper{*/
    /*    flex-direction: column;*/
    /*  }*/
    
    /*  #bookSearchinnerBox a{*/
    /*    display: inline;*/
    /*  }*/
    
    /*  .bookSearch button{*/
    /*    display: none;*/
    /*  }*/
    
    /*  #bookSearchinnerBox{*/
    /*    padding-right: 0px;*/
    /*  }*/
    
    /*}
		    
		    
        </style>


        <script>

            $(function(){
            	
                $(window).scroll(function(){
                    let position = $(window).scrollTop();
                    $(window).scroll
                    if(position<50){
                        $('.header-upper-box').css('height', '78px');
                        $('.header-upper-box').css('visibility', 'visible');
                        $('.header-upper').css('height', '78px');
                        $('.header-upper').css('visibility', 'visible');
                        // $('.hide').addClass('header-upper');
                        // $('.hide').removeClass('hide');
                        $('.header-location').css('height', '129px');
                        $('.header-upper-box').css('opacity', '100%');
                        $('.header-upper').css('opacity', '100%');
                    }
                    else{
                        $('.header-upper-box').css('height', '0px');
                        $('.header-upper-box').css('visibility', 'hidden');
                        $('.header-upper-box').css('opacity', '0%');
                        $('.header-upper').css('height', '0px');
                        $('.header-upper').css('visibility', 'hidden');
                        $('.header-upper').css('opacity', '0%');
                        // $('.header-upper').addClass('hide');
                        // $('.header-upper').removeClass('header-upper');
                        $('.header-location').css('height', '50px');
                    }

                });
                
                
            	
                $("#selectAllCheck").change(function(){
                    if($(this).is(":checked")){
                        $('input:checkbox[name="toMyBookCheck"]').prop('checked',true);
                    }
                    else{
                        $('input:checkbox[name="toMyBookCheck"]').prop('checked',false);
                    }
                });


                $("input:checkbox[name='toMyBookCheck']").change(function(){
                    if(!$(this).is(":checked")){
                        if($("#selectAllCheck").is(":checked")){
                            $("#selectAllCheck").prop('checked',false);
                        }
                    }
                });

            });
            
            
            
            function submitfilter(option, keyword){

                let opt = $("#new_opt");
                opt.attr("name", "exact_option");
                opt.val(option);

                let filter = $("#new_filter");
                filter.attr("name", "exact_keyword");
                filter.val(keyword);

                $("#type").val('keyAndExact');

                document.filter_form.submit();

            }


            function search(){

                let option = $("#option").val();
                let keyword = $("#keyword").val();

                if($("#inSearch").is(":checked")){
                    let opt = $("#new_opt");
                    opt.attr("name", "option");
                    opt.val(option);
                    let filter = $("#new_filter");
                    filter.attr("name", "keyword");
                    filter.val(keyword);

                    let type = '${type}';
                    if(type == 'key'){
                        $("#type").val('key');
                    }
                    else{
                    	$("#type").val('keyAndExact');
                    }

                    document.filter_form.submit();

                }

                else{
                    document.bookSearchForm.submit();
                }

            }


            function list(curPage){

                let type = '${type}';
                $("#type").val(type);
                $("#curPage").val(curPage);
                let opt = $("#new_opt");
                opt.remove();
                let filter = $("#new_filter");
                filter.remove();

                document.filter_form.submit();
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
        <h1>도서검색</h1>
    </div>
    <div class="contentsLocation">
        홈 &gt 도서검색
    </div>
    <div class="contentsMain">
    
    
    
    
		  <div class="search-box">
		    <form name="bookSearchForm" class="bookSearch" method="get" action="${path}/book_servlet/search.do">
		      <div id="bookSearchinnerBox">
		        <div>
		          <input type="checkbox" name="inSearch" value="true" id="inSearch"><label for="inSearch">결과 내 재검색</label>
		          <a href="{path}/book/search.jsp">상세검색</a>
		        </div>
		        <div>
		          <select id="option" name="option">
		            <option value="all">전체</option>
                    <option selected value="title">서명</option>
                    <option value="author_name">저자명</option>
                    <option value="publisher_name">출판사</option>
                    <option value="isbn">ISBN</option>		            
		          </select>
		          <input type="text" name="keyword" size="30" id="keyword">
		          <button type="button" onclick="search()" id="btnSearch">검색</button>
		        </div>
		        <button type="button" onclick="location.href='${path}/book/search.jsp'" id="btnRedirect">상세검색</button>
		      </div>
		    </form>
		  </div>

        <div class="result-box">
            <div class="filter">
                <div class="filterUpper">
                
                <% 
                
                List<FilterDTO> filter = (List<FilterDTO>) request.getAttribute("filter");
                
                int size = filter.size();
                int recentest = 0;
                int oldest = 0;
                if(size>=1){
                    recentest = filter.get(size-1).getRecentest();
                    oldest = filter.get(size-1).getOldest();
                }
                
                
                List<FilterDTO> f_authors = filter.stream()
                	    .filter((item) -> item.getF_author()!=null )
                	    .collect(Collectors.toList());
                
                List<FilterDTO> f_publishers = filter.stream()
                	    .filter((item) -> item.getF_publisher() != null)
                	    .collect(Collectors.toList());
                
                List<FilterDTO> f_category = filter.stream()
                	    .filter((item) -> item.getF_category() != null)
                	    .collect(Collectors.toList());
                
                %>                
                    <span>${(page.curPage-1)*page.page_scale+1}-${(page.curPage-1)*page.page_scale+books.size()}건 출력 / 총 ${size}건</span>
                </div>
           <form name="filter_form" action="${path}/book_servlet/search.do">
                <div class="filterBody">
                    <div>
                        <h3>제한된 항목</h3>
                        <ul>
                        <c:forEach var="keyword" items="${keywords}" varStatus="status">
                        	<c:if test="${keyword!=null && keyword!=''}">
                        	   <input type="hidden" name="option" value="${options[status.index]}">
                        	   <input type="hidden" name="keyword" value="${keyword}">
                        	<c:choose>
                        		<c:when test="${options[status.index] == 'title'}">
                        			<li>서명: ${keyword}</li>
                        		</c:when>
                        		<c:when test="${options[status.index] == 'author_name'}">
                        			<li>저자명: ${keyword}</li>
                        		</c:when>
                        		<c:when test="${options[status.index] == 'publisher_name'}">
                        			<li>출판사: ${keyword}</li>
                        		</c:when>
                        		<c:otherwise>
                        		    <li>전체: ${keyword}</li>
                        		</c:otherwise>
                        	</c:choose>
                        	</c:if>
                        </c:forEach>
                        <c:forEach var="exact_keyword" items="${exact_keywords}" varStatus="status">
                        	<c:if test="${exact_keyword!=null && exact_keyword!=''}">
                        	   <input type="hidden" name="exact_option" value="${exact_options[status.index]}">
                        	   <input type="hidden" name="exact_keyword" value="${exact_keyword}">
                        	<c:choose>
                        		<c:when test="${exact_options[status.index] == 'title'}">
                        			<li>서명: ${exact_keyword}</li>
                        		</c:when>
                        		<c:when test="${exact_options[status.index] == 'author_name'}">
                        			<li>저자명: ${exact_keyword}</li>
                        		</c:when>
                        		<c:when test="${exact_options[status.index] == 'publisher_name'}">
                        			<li>출판사: ${exact_keyword}</li>
                        		</c:when>
                        		<c:when test="${exact_options[status.index] == 'classification_code'}">
                        			<li>주제분류: 
                        			<c:choose>
                        				<c:when test="${exact_keyword==0}">총류</c:when>
                        				<c:when test="${exact_keyword==1}">철학/심리학</c:when>
                        				<c:when test="${exact_keyword==2}">종교</c:when>
                        				<c:when test="${exact_keyword==3}">사회과학</c:when>
                        				<c:when test="${exact_keyword==4}">언어</c:when>
                        				<c:when test="${exact_keyword==5}">순수과학</c:when>
                        				<c:when test="${exact_keyword==6}">기술과학</c:when>
                        				<c:when test="${exact_keyword==7}">예술</c:when>
                        				<c:when test="${exact_keyword==8}">문학</c:when>
                        				<c:when test="${exact_keyword==9}">역사/지리</c:when>
                        			</c:choose>
                        			</li>
                        		</c:when>
                        		<c:otherwise>
                        		    <li>전체: ${exact_keyword}</li>
                        		</c:otherwise>
                        	</c:choose>
                        	</c:if>
                        </c:forEach>
                        </ul>
                        <input type="hidden" name="sort" value="${sort}">
                        <input type="hidden" name="order" value="${order}">
                        <input type="hidden" name="publishEnd" value="${publishStart}">
                        <input type="hidden" name="publishEnd" value="${publishEnd}">
                        <input type="hidden" name="type" id="type" value="${type}">
                        <input type="hidden" name="option" id="new_opt">
                        <input type="hidden" name="keyword" id="new_filter">                        
                        <input type="hidden" name="curPage" id="curPage" value="${page.curPage}">   
                        </div>
                    
                    <script>
                    
                    $(function(){
                    	
                    	
                        var range = $("#range");
                        var min = $("#min");
                        var max = $("#max");
                        var oldest = <%=oldest%>;
                        var recentest = <%=recentest%>;
                        

                        range.slider({
                            range: true,
                            min: oldest,
                            max: recentest,
                            step: 1,
                            values: [oldest, recentest],
                            slide: function(event, ui){
                                min.val(ui.values[0]);
                                max.val(ui.values[1]);
                            }
                        });

                        min.val(range.slider("values", 0));
                        max.val(range.slider("values", 1));

                        $("#min, #max").on("input", function(){
                            var minVal = parseInt(min.val());
                            var maxVal = parseInt(max.val());

                            if(minVal >= maxVal){
                                return false;
                            }

                            range.slider("values", 0, minVal);
                            range.slider("values", 1, maxVal);

                        });
                    	
                    });
                    
                    </script>
                    
                    <div>
                        <h3>발행년도</h3>
                        <div id="rangeDiv">
                            <div id="range"></div>
                            <input type="text" id="min">-<input type="text" id="max">
                            <button type="button" onclick="yearFilter()">검색</button>
                        </div>
                    </div>
                    <div>
                        <h3>저자명</h3>
                        <ul>
                            <%
                            for(FilterDTO f : f_authors){
                            %>
                            <li><a href="#" onclick="submitfilter('author_name', '<%=f.getF_author()%>')"><%=f.getF_author()%></a><span class="filter_count">(<%=f.getF_count()%>)</span></li>
                            <%
                            }
                            %>                            
                        </ul>
                    </div>
                    <div>
                        <h3>출판사</h3>
                        <ul>
                            <%
                            for(FilterDTO f : f_publishers){
                            %>
                            <li><a href="#" onclick="submitfilter('publisher_name', '<%=f.getF_publisher()%>')"><%=f.getF_publisher()%></a><span class="filter_count">(<%=f.getF_count()%>)</span></li>
                            <%
                            }
                            %>   
                        </ul>
                    </div>
                    <div>
                        <h3>주제분류</h3>
                        <ul>
                            <%
                            for(FilterDTO f : f_category){
                            	String category = "";
                                switch (f.getF_category()){
                                case "0": category = "총류"; break;
                                case "1": category = "철학/심리학"; break;
                                case "2": category = "종교"; break;
                                case "3": category = "사회과학"; break;
                                case "4": category = "언어"; break;
                                case "5": category = "순수과학"; break;
                                case "6": category = "기술과학"; break;
                                case "7": category = "예술"; break;
                                case "8": category = "문학"; break;
                                case "9": category = "역사/지리"; break;
                                }
                            %>
                            <li><a href="#" onclick="submitfilter('classification_code', '<%=f.getF_category()%>')"><%=category%></a><span class="filter_count">(<%=f.getF_count()%>)</span></li>
                            <%
                            }
                            %>   
                        </ul>
                    </div>
                </div>
                </form>
            </div>
            <div class="resultListBox">
                <form name="toMyBook">
                    <div class="resultListUpper">
                        <div id="selectAll">
                            <input type="checkbox" id="selectAllCheck">
                            <label for="selectAllCheck">전체선택</label><button type="button">내 서재에 담기</button>
                        </div>
                        <div id="sorting">
                            <select>
                                <option selected>10</option>
                                <option>20</option>
                                <option>30</option>
                                <option>50</option>
                                <option>100</option>
                            </select>
                            <select>
                                <option selected>정렬항목</option>
                                <option>서명</option>
                                <option>저자명</option>
                                <option>출판년</option>
                                <option>입수일</option>
                                <!-- <option>대출횟수</option> -->
                            </select>
                            <select>
                                <option selected>정렬</option>
                                <option>오름차순</option>
                                <option>내림차순</option>
                            </select>
                            <button type="button">정렬</button>
                        </div>
                    </div>
                    
                    
                    <ul class="resultList">
                        <%
                        
                        List<BookDTO> books = (List<BookDTO>)request.getAttribute("books");
                        Pager pager = (Pager)request.getAttribute("page");    		
                        
                        for(int i=0; i<books.size(); i++){
                        	BookDTO book = (BookDTO) books.get(i);
                        	String title = book.getTitle();
                        	String publisher_name = book.getPublisher_name();
                        	int publication_year = book.getPublication_year();
                        	long isbn = book.getIsbn();
                        	String img_url = book.getImg_url();
                        	
                        	String authorNames = book.getAuthorNames();
                        	String authors[] = authorNames.split(";");
                        	
                        	
                        %>

                        <li>
                            <div class="searchedBook">                            
                                <span><input type="checkbox" value="등록번호" name="toMyBookCheck"><%=(pager.getCurPage()-1)*pager.getPage_scale()+i+1%>.</span>
                                <a href="#" onclick="location.href='${path}/book_servlet/view.do?isbn=<%=isbn%>'" >
                                <%if(img_url!="" && img_url!=null) {%>
                                <img src="<%=img_url%>">
                                <% } else {%>
                                <img src="${path}/include/default_book.png">
                                <%}%>
                                </a>
                                
                                <div class="searchedBookDetails">
                                    <!-- <span class="bookIssued">25회 대출</span> -->
                                    <a href="#" onclick="location.href='${path}/book_servlet/view.do?isbn=<%=isbn%>'" ><h4 class="bookName"><%=title%></h4></a>
                                    <div class="bookAuthor"><%=authors[0]%><%if(authors.length>1){ %> 외<%}%> </div>
                                    <div class="bookPublisherYear"><%=publisher_name%>&nbsp<%=publication_year%></div>
                                    <div class="bookNow">
                                        <span class="bookLocationCallNumber"><%=books.get(i).getCopies().get(0).getLocation()%> 
                                        [<%=books.get(i).getCopies().get(0).getCall_number()%>]</span>
                                        <span class="bookStatus_ok"><%=books.get(i).getCopies().get(0).getStatus()%> </span>
                                    </div>
                                </div>
                            </div>
                        </li>

                        <%
                            }

                        %>

                    </ul>
                </form>


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
    </div>
</div>

<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>



</body>
</html>