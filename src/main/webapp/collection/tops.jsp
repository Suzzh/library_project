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
      cursor: pointer;
      transition: all 0.1s;
    }

    .boardCategory div:first-of-type{
      background-color: #042d04;
      color:  white;
      border: 1px solid #042d04;
      font-weight: bold;
    }

    .bestBooksUpper{
      border-bottom: 1px solid #777777;
      display: flex;
      justify-content: right;
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
      <div onclick="location.href='https://www.google.com/'">전체</div>
      <div>총류/철학/종교</div>
      <div>언어/사회과학</div>
      <div>순수과학/기술과학</div>
      <div>예술/문학/역사</div>
    </div>
    <div class="bestBooksUpper">
      <div class="period">
        <span>기간: 2023-01-23 ~ 2023-02-22</span>
        <select>
          <option>최근 1개월</option>
          <option>3개월</option>
          <option>6개월</option>
          <option>1년</option>
        </select>
      </div>

    </div>
    <div class="bestBooks">
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>1</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>2</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>3</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>4</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>5</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>6</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
        </div>
      </div>
      <div class="bestBook">
        <div class="bestBookWrapper">
          <div class="imagewrapper">
            <div>7</div>
            <img src="https://image.yes24.com/goods/90051766/XL">
          </div>
          <div>맨큐의 경제학</div>
          <div>N. Gregory Mankiew<br>Cengage Learning</div>
          <div>대출횟수:12</div>
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