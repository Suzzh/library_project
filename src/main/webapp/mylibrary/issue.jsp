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
      background-color: rgba(246, 233, 245, 0.9);
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

    .noticePaging{
      display: flex;
      width:100%;
      justify-content: center;
      margin-top: 20px;
    }

    .noticePaging div{
      padding: 6px 10px;
      transition: background-color 0.1s, font-weight 0.1s;
    }

    .noticePaging div:hover{
      background-color: gainsboro;
      cursor: pointer;
      font-weight: bold;
    }

  </style>

  <script>

    $(function(){

      $("#selectAllCheck").change(function(){
        if($(this).is(":checked")){
          $('input:checkbox[name="renewCheck"]').prop('checked',true);
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

  </script>



</head>
<body>

<div class="float-header">
  <div class="header-upper-box">
    <div class="header-upper">
      <div class="header-left">
        <a href="index.html" title="지혜대학교 도서관"><img src="https://cdn-icons-png.flaticon.com/512/3362/3362210.png" width="40px"></a>
        <a href="index.html" id="sitename" title="지혜대학교 도서관"><strong>지혜대학교 도서관</strong><br><strong>WISDOM UNIVERSITY LIBRARY</strong></a>
      </div>
      <div class="header-right">
        <a href="login.html" id="toLogin" title="로그인">로그인</a>
        <form name="totalSearch" id="totalSearch" method="get">
          <input type="text" size="15" placeholder="사이트내 검색"
                 style="width:120px; height:30px; margin-left: 30px; padding-left: 12px;">
          <input type="submit" value="search"
                 style="width:70px; height:30px;">
        </form>
      </div>
    </div>
  </div>
  <div class="nav">
    <ul class="menu">
      <li>도서검색</li>
      <li>시설예약</li>
      <li>컬렉션</li>
      <li>도서관안내</li>
      <li>내 서재</li>
      <li>#</li>
    </ul>
  </div>
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
<!--        <div id="profile">-->
<!--          <h3>한수진(2014119033)</h3>-->
<!--          <div>문과대 심리학과 / 학부생</div>-->
<!--        </div>-->

        <ul>
          <li>
            <div>상태</div>
            <div>정상</div>
          </li>
          <li>
            <div>대출도서</div>
            <div>2/15</div>
          </li>
          <li>
            <div>예약도서</div>
            <div>1/3</div>
          </li>
          <li>
            <div>연체도서</div>
            <div>0</div>
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
<!--      <div>이용자 대출상태</div>-->
<!--      회원상태: 6권 대출 중, 정상-->
<!--      <ul>-->
<!--        <li>이용자 이름: 한수진</li>-->
<!--        <li>이용자 번호: 2014119033</li>-->
<!--        <li>회원상태: 6권 대출 중, 정상</li>-->
<!--      </ul>-->
    </div>

    <div class="boardUpper">
      <div class="boardUpper-left">
      <span>총 6권 대출</span>
      <div id="selectAll">
<!--        <label for="selectAllCheck">전체선택</label>-->
        <button type="button" id="renewAll">선택도서 대출연장</button>
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
    <table id="noticeBoard">
      <thead>
      <tr>
        <th><input type="checkbox" id="selectAllCheck"></th>
        <th>No.</th>
        <th>도서정보</th>
        <th>대출일</th>
        <th>반납예정일</th>
        <th>연체일수</th>
        <th>연장횟수</th>
      </tr>
      </thead>
      <tbody>
<!--      <img src="https://image.yes24.com/goods/90051766/XL">-->
<!--      <div>달러구트 꿈 백화점 : 주문하신 꿈은 매진입니다 : 이미예 장편소설 / 이미예 지음</div>-->
<!--      </li>-->
<!--      <li>-->
<!--        <img src="https://image.yes24.com/Goods/108887930/XL">-->
<!--        <div>작별인사 : 김영하 장편소설 / 김영하 지음</div>-->
<!--      </li>-->
<!--      <li>-->
<!--        <img src="https://kr.object.ncloudstorage.com/changbi/images/2023/2/230202_ad376051-ab18-4a44-9ab8-a68d4819de97.jpg">-->
<!--        <div>러브 몬스터 : 이두온 장편소설 / 이두온 지음</div>-->
<!--      </li>-->
<!--      <li>-->
<!--        <img src="https://image.yes24.com/goods/90051766/XL">-->
<!--        <div>달러구트 꿈 백화점 : 주문하신 꿈은 매진입니다 : 이미예 장편소설 /이미예 지음</div>-->
<!--      </li>-->
<!--      <li>-->
<!--        <img src="https://image.yes24.com/goods/76106687/XL">-->
<!--        <div>지구에서 한아뿐 : 정세랑 장편소설 / 정세랑 지음</div>-->
<!--        -->
      <tr>
        <td><input type="checkbox" name="renewCheck"></td>
        <td>1</td>
        <td>
          달러구트 꿈 백화점 : 주문하신 꿈은 매진입니다 : 이미예 장편소설 / 이미예 지음</td>
        <td>2023-02-21</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="renewCheck"></td>
        <td>2</td>
        <td>지구에서 한아뿐 : 정세랑 장편소설 / 정세랑 지음</td>
        <td>2023-02-21</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="renewCheck"></td>
        <td>2</td>
        <td>지구에서 한아뿐 : 정세랑 장편소설 / 정세랑 지음</td>
        <td>2023-02-21</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="renewCheck"></td>
        <td>2</td>
        <td>지구에서 한아뿐 : 정세랑 장편소설 / 정세랑 지음</td>
        <td>2023-02-21</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr>
        <td><input type="checkbox" disabled></td>
        <td>3</td>
        <td>러브 몬스터 : 이두온 장편소설 / 이두온 지음</td>
        <td>2023-02-08</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>1</td>
      </tr>
      <tr>
        <td><input type="checkbox" disabled></td>
        <td>3</td>
        <td>러브 몬스터 : 이두온 장편소설 / 이두온 지음</td>
        <td>2023-02-08</td>
        <td>2023-03-04</td>
        <td>0</td>
        <td>1</td>
      </tr>
      </tbody>
    </table>

    <div class="noticePaging">
      <div>&lt&lt</div>
      <div>&lt</div>
      <div>1</div>
      <div>2</div>
      <div>3</div>
      <div>4</div>
      <div>5</div>
      <div>6</div>
      <div>7</div>
      <div>8</div>
      <div>9</div>
      <div>&gt</div>
      <div>&gt&gt</div>

    </div>

  </div>
</div>


<footer>
  지혜대학교도서관 서울특별시 강남구<br>
  COPYRIGHT 2023 WISDOM UNIVERSITY
</footer>


</body>
</html>