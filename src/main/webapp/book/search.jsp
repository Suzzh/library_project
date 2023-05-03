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
    
    <title>도서검색</title>
    <style>
        .search-box{
            width: 780px;
            margin: 0 auto;
        }

        .bookSearch{
            margin: auto auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .bookSearch > div{
            display: flex;
            flex-direction: row;
            align-items: center;
            width: 100%;
            margin: 6px 0;
        }

        .bookSearch > div:first-of-type{
            margin-top: 0;
        }

        .bookSearch select{
            width: 150px;
            flex-shrink: 0;
            height: 37px;
            font-size: 16px;
            padding-left: 10px;
            margin-right: 8px;
            border: #7a7f80 1px solid;
            background-color: #eceeee;
        }


        .bookSearch input[type="text"]{
            flex-grow: 1;
            height: 32px;
            font-size: 16px;
            padding-left: 1%;
            border: #7a7f80 1px solid;
        }


        .bottom input[name="publishStart"],
        .bottom input[name="publishEnd"]
        {
            flex-grow: 0;
            min-width: 130px;
        }

        .bottom select{
            background-color: white;
        }

        .labels{
            width: 150px;
            text-align: right;
            padding-right: 30px;
            box-sizing: border-box;
            margin-right: 8px;
        }


        .bookSearch button{
            font-weight: bold;
            width: 120px;
            height: 50px;
            font-size: 17px;
            background-color: #042d04;
            color: white;
            border: none;
            border-radius: 4px;
            margin: 10px 0 20px 0;
            cursor: pointer;
        }



        /*@media screen and (min-height: 500px) {*/
        /*  .search-box{*/
        /*    margin: 10% 0 10% 0;*/
        /*  }*/

        /*}*/


    </style>


    <script>


        $(function(){
        	
        	if('${err}'!=null && '${err}'!=""){
        		alert('${err}');
        	}
        	
        	
        	/*
            $("#exact").change(function(){
                if(this.checked){
                    let opts = document.getElementsByClassName('options');
                    let keys = document.getElementsByClassName('keywords');
                    alert(keys);
                    alert(opts);

                    for(let i=0; i < opts.length; i++){
                    	alert(opts[i]);
                        opts[i].removeAttr("name").attr("name", 'exact_option');
                        keys[i].removeAttr("name").attr("name", 'exact_keyword');
                    }
                }
             });

             $("#key").change(function(){
                 if(this.checked){
                     let opts = document.getElementsByName('options');
                     let keys = document.getElementsByClassName('keywords');

                     for(let i=0; i < opts.length; i++){
                         opts[i].removeAttr("name").attr("name", 'option');
                         keys[i].removeAttr("name").attr("name", 'keyword');
                     }
                 }

             });
             
             */
             

            $('input[name=publishStart]').change(function(){
                let value = this.value;
                value = value.replace(/[^0-9]/g, '');
                if(value.length >4) value = value.substring(0,4);
                else if(value.length <4 && value.length>0){
                    while(value.length!=4){
                        value = "0" + value;
                    }
                }
                else if(value.length == 0) value = "";
                this.value=value;
            });

            $('input[name=publishEnd]').change(function(){
                let value = this.value;
                value = value.replace(/[^0-9]/g, '');
                if(value.length >4) value = value.substring(0,4);
                else if(value.length <4 && value.length>0){
                    while(value.length!=4){
                        value = "0" + value;
                    }
                }
                else if(value.length == 0) value="";
                this.value=value;
            });

        });

        function check(){
            if($("#search1_keyword").val().trim()!="" || $("#search2_keyword").val().trim()!="" || $("#search3_keyword").val().trim()!=""){
                $("#bookSearchForm").submit();
            }
            else{
                alert("검색어를 입력해주세요.");
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
        <h1>도서검색</h1>
    </div>
    <div class="contentsLocation">
        홈 &gt 도서검색
    </div>
    <div class="contentsMain">
        <div class="search-box">
            <form name="bookSearch" class="bookSearch" id="bookSearchForm" method="get" action="${path}/book_servlet/search.do">
                <div>
                    <!-- <input type="radio" name="type" id="key" checked value="key"> <label for="key">키워드검색</label> -->
                    <!-- <input type="radio" name="type" id="prefix"> <label for="prefix">전방일치</label> -->
                    <!-- <input type="radio" name="type" id="exact" value="exact"> <label for="exact">완전일치</label> -->

                </div>
                <div>
                    <select name="option" class="options">
                        <option value="all">전체</option>
                        <option selected value="title">서명</option>
                        <option value="authornames">저자명</option>
                        <option value="publisher_name">출판사</option>
                        <option value="isbn">ISBN</option>
                    </select>
                    <input type="text" name="keyword" id="search1_keyword" class="keywords">
                    <!--        <select>-->
                    <!--          <option selected>AND</option>-->
                    <!--          <option>OR</option>-->
                    <!--          <option>NOT</option>-->
                    <!--        </select>-->
                </div>
                <div>
                    <select name="option" class="options">
                        <option value="all">전체</option>
                        <option value="title">서명</option>
                        <option value="author_name" selected>저자명</option>
                        <option value="publisher_name">출판사</option>
                        <option value="isbn">ISBN</option>
                        <%--                        <option>청구기호</option>--%>
                    </select>
                    <input type="text" name="keyword" id="search2_keyword" class="keywords">
                    <!--        <select>-->
                    <!--          <option selected>AND</option>-->
                    <!--          <option>OR</option>-->
                    <!--          <option>NOT</option>-->
                    <!--        </select>-->
                </div>
                <div>
                    <select name="option" class="options">
                        <option value="all">전체</option>
                        <option value="title">서명</option>
                        <option value="author_name">저자명</option>
                        <option selected value="publisher_name">출판사</option>
                        <option value="isbn">ISBN</option>
                        <%--                        <option>청구기호</option>--%>
                    </select>
                    <input type="text" name="keyword" id="search3_keyword" class="keywords">
                    <!--        <select>-->
                    <!--          <option selected>AND</option>-->
                    <!--          <option>OR</option>-->
                    <!--          <option>NOT</option>-->
                    <!--        </select>-->
                </div>

                <button type=button onclick=check()>검색</button>

                <div class="bottom">
                    <label class="labels">출판년도</label>
                    <input type="text" placeholder="시작년도(YYYY)" name="publishStart"> - 
                    <input type="text" placeholder="종료년도(YYYY)" name="publishEnd"><br>
                </div>
                <div class="bottom">
                    <label class="labels">정렬항목</label>
                    <select name="sort">
                        <option value="title">서명</option>
                        <option value="authorNames">저자명</option>
                        <option value="publication_year">출판년도</option>
                        <option value="register_date">등록일</option>
                        <%--                        <option value="issued">대출횟수</option>--%>
                    </select>
                </div>
                <div class="bottom">
                    <label class="labels">정렬순서</label>
                    <select name="order">
                        <option value="asc">오름차순</option>
                        <option value="desc">내림차순</option>
                    </select>
                </div>





            </form>
        </div>
    </div>


</div>
</div>
<footer>
<jsp:include page="../include/bottom.jsp"></jsp:include>
</footer>


</body>
</html>