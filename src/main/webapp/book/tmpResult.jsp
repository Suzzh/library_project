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
            

		    
		    
        </style>


        <script>

           
        </script>

    </head>
<body>
<div class="float-header">
<%@include file="../include/top.jsp" %>
</div>

<div class="header-location">
</div>


                    <ul class="resultList">
                        <%
                        
                        List<BookDTO> books = (List<BookDTO>)request.getAttribute("books");

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


<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>



</body>
</html>