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

  <title>지혜대학교 도서관</title>
  <style>

    .contentsMain{
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .upperContent{
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-top: 50px;
    }

    #mainImage{
      width: 600px;
      margin-bottom: 20px;
    }

    #bookSearch{
      width: 600px;
      display: flex;
    }

    #bookSearch select{
      width: 110px;
      height: 50px;
      padding-left: 10px;
      border: #7a7f80 1px solid;
      font-size: 16px;
    }

    #bookSearch input{
      flex-grow: 1;
      margin-left: 5px;
      margin-right: 5px;
      height: 45px;
      padding-left: 15px;
      border: #7a7f80 1px solid;
      font-size: 16px;
    }

    #bookSearch button{
      width: 100px;
      height:50px;
      text-align: center;
      background-color: #042d04;
      color: white;
      border: none;
      font-size: 16px;
      border-radius: 4px;
      cursor: pointer;
    }



    .indexContents{
      display: flex;
      flex-direction: column;
      align-items: center;
    }


    div[id*="container_"] {
      margin-top: 10px;
      display: flex;
    }

    #container_notice{
      width: 1000px;
      padding: 0 50px;    
      margin: 20px 0;
      height: 210px;
    }

    #noticeBox{
      width: 550px;
      display: flex;
      flex-direction: column;
      margin-right: 20px;
    }

    #noticeUpper{
      padding: 10px 0;
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
    }

    #noticeUpper h2{
      margin: 0 0 10px 0;
      padding: 0;
    }

    #noticeUpper span{
      font-size: 25px;
      padding-right: 10px;
      cursor: pointer;
    }

    #noticeBox table{
	  font-size: 17px;
      width: 550px;
      table-layout: fixed;
    }
    
    #noticeBox table a{
    text-decoration: none;
    color: #042d04;
    }
    

    #noticeBox td{
      padding-top: 5px;
      padding-bottom: 5px;
      white-space: nowrap;
      overflow: hidden;
    }
    
    #noticeBox td:nth-of-type(2){
      text-overflow: ellipsis;
    }

    #noticeBox td:first-of-type{
      padding-left: 10px;
      width: 60px;
    }

    #noticeBox td:last-of-type{
      width: 100px;
    }

    #banner{
      padding-right: 10px;
      width: 330px;
      height: 210px;
      padding-right: 10px;
    }
    
    #bannerImg{
      width: 320px;
      height: 210px;
    }

    #container_book{
      flex-direction: column;
      width: 1000px;
    }

    #container_book > hr{
      width: 100%;
      margin: 30px 0 20px 0;
    }

    .bookInnerContainer {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .bookInnerContainer h2{
      width: 900px;
      margin: 0 0 10px 0;
      padding: 10px 0;
    }

    .listBox{
      width: 100%;
      display: flex;
    }

    .swap{
      display: inline-block;
      height: 50px;
      width: 50px;
      border-radius: 4px;
      font-size: 20px;
      text-align: center;
      line-height: 45px;
      margin: auto 0;
      transition: background-color 0.3s, font-weight 0.3s;

    }

    .swap:hover{
      background-color: gainsboro;
      cursor: pointer;
      font-weight: bold;
    }


    .bookList{
      display: flex;
      justify-content: space-around;
      margin: 0 10px;
      width: 900px;
      height: 190px;
    }

    .book{
      position: relative;
    }


    .book_desc{
      background-color: #042d04;
      color: white;
      width: 140px;
      height: 190px;
      z-index:1;
      left:0;
      top:0;
      position: absolute;
      opacity: 0;
      transition: opacity 0.3s;
      display: flex;
      align-items: center;
    }

    .book_desc span{
      display: -webkit-box;
      -webkit-line-clamp: 9;
      -webkit-box-orient: vertical;
      text-overflow: ellipsis;
      overflow: hidden;
      width: 140px;
      padding: 0 7px;
      text-align: center;
      font-size: 15px;
    }

    .book_desc:hover{
      opacity: 85%;
      cursor: pointer;
    }

    .bookList img{
      width:140px;
      height: 190px;
    }


  </style>
  
  
  <script>
  
  let p_curPage = 1;
  let r_curPage = 1;
  
  window.onpageshow = function (event) {
	  
	  p_curPage = 1;
	  r_curPage = 1;
	  
	  
	//공지사항 불러오기
		$.ajax({
			type: "post",
			url : "${path}/notice_servlet/recentNotices.do",
			dataType: "json",
			success: function(result){
				let noticeList = result.noticeList;
				if(noticeList!=null && noticeList.length > 0){
					let tableTd;
					for(let i=0 ; i<noticeList.length; i++){
						let row = noticeList[i];
	
						tableTd += '<tr>';
						tableTd += '<td>' + row.post_category + '</td>';
						tableTd += '<td><a href="${path}/notice_servlet/view.do?notice_id=' + row.notice_id + '">' + row.title + '</a></td>';
						tableTd += '<td>' + row.post_date + '</td></tr>';
					}
					$('#noticeTable').html(tableTd);
				}
			}
		});
	  
		
	getPopularBooks();
	getRecentBooks();
	
  }
  
  
  function getPopularBooks(){
	  //인기도서 불러오기
		$.ajax({
			type: "post",
			url : "${path}/collection_servlet/popularBooks.do",
			data : {'curPage' : p_curPage},
			dataType: "json",
			success: function(result){
				let popularList = result.popularList;
				if(popularList!=null && popularList.length > 0){
					if(result.p_curPage == 1) p_curPage = 2;
					else p_curPage = 1;

					let divBooks = "";
					for(let i=0 ; i<popularList.length; i++){
						let row = popularList[i];
						let img_url = row.img_url;
						if(img_url == null || img_url == '') 
							img_url = "${path}/include/default_book.png";
						
						divBooks += '<div class="book"><img src="' + img_url + '">';
						divBooks += '<div onclick="location.href=\'${path}/book_servlet/view.do?isbn=' + row.isbn + '\'" class="book_desc" id="hot_desc' + i + '">';
						divBooks += '<span>' + row.title + '<hr>' + row.main_author + '</span></div></div>';
						
					}
					$('#hotList').html(divBooks);
					
				}
				else p_curPage = 1;
			}
		});
  }
  
  function getRecentBooks(){
	  //인기도서 불러오기
		$.ajax({
			type: "post",
			url : "${path}/collection_servlet/recentBooks.do",
			data : {'curPage' : r_curPage},
			dataType: "json",
			success: function(result){
				let recentList = result.recentList;
				if(recentList!=null && recentList.length > 0){
					if(result.r_curPage == 1) r_curPage = 2;
					else r_curPage = 1;
					
					let divBooks = "";
					for(let i=0 ; i<recentList.length; i++){
						let row = recentList[i];
						let img_url = row.img_url;
						if(img_url == null || img_url == '') 
							img_url = "${path}/include/default_book.png";
						
						divBooks += '<div class="book"><img src="' + img_url + '">';
						divBooks += '<div onclick="location.href=\'${path}/book_servlet/view.do?isbn=' + row.isbn + '\'" class="book_desc" id="hot_desc' + i + '">';
						divBooks += '<span>' + row.title + '<hr>' + row.main_author + '</span></div></div>';
						
					}
					$('#recentList').html(divBooks);
					
				}
				else r_curPage = 1;
			}
		});
  }
  
  
  function search(){
      $("#keyword").val($("#keyword").val().trim());
      if($("#keyword").val() != '') document.bookSearchForm.submit();

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
  <div class="contentsMain">
  <div class="upperContent">
    <img id="mainImage" src="https://thumbs.dreamstime.com/b/old-book-flying-letters-magic-light-background-bookshelf-library-ancient-books-as-symbol-knowledge-history-218640948.jpg">
    <form name="bookSearchForm" id="bookSearch" method="get" action="${path}/book_servlet/search.do">
		<select id="option" name="option">
			<option value="all">전체</option>
	        <option selected value="title">서명</option>
	        <option value="author_name">저자명</option>
	        <option value="publisher_name">출판사</option>
	        <option value="isbn">ISBN</option>		            
		</select>
      <input type="text" name="keyword" id="keyword" size="30" placeholder="소장 자료를 검색합니다.">
      <button type="button" onclick="search()">검색</button>
    </form>
  </div>


  <div class="indexContents">
    <div id="container_notice">
      <div id="noticeBox">
      <div id="noticeUpper">
        <h2>공지사항</h2><span onclick="location.href='${path}/notice_servlet/board.do'">+</span></div>
      <table id="noticeTable">
        <tr><td colspan="3">공지사항이 없습니다.</td></tr>
      </table>
      </div>
      <div id="banner"><img id="bannerImg" src="${path}/include/banner.png"></div>
   </div>
    <div id="container_book">
      <div class="bookInnerContainer">
        <h2>인기도서</h2>
        <div class="listBox">
          <span class="swap" onclick="getPopularBooks()">&lt</span>
          <div id="hotList" class="bookList">
          </div>
          <span class="swap" onclick="getPopularBooks()">&gt</span>
        </div>
      </div>
    <hr>
      <div class="bookInnerContainer">
      <h2>신착도서</h2>
      <div class="listBox">
        <span class="swap" onclick="getRecentBooks()">&lt</span>
        <div id="recentList" class="bookList">
        </div>
        <span class="swap" onclick="getRecentBooks()">&gt</span>
      </div>
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