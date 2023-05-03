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


    <title>도서등록</title>
    <style>

    .bookAddBigBox{
      /*background-color: #9a5c5c;*/
      display: flex;
      /*font-size: 15px;*/
    }

    .bookAddLeft{
      /*background-color: darkseagreen;*/
      width: 600px;
      display: flex;
      flex-direction: column;
    }

    .form-label, .warning {
      /*background-color: #98ddea;*/
      display: flex;
      flex: 0 1 auto;
      width: 100%;
      flex-direction: row;
      align-items: center;
      margin-bottom: 10px;
    }

    .warning{
      padding-left: 110px;
      color: #ff3f34;
      font-size: 15px;
      display: none;
    }


    .form-label label {
      margin-right: 10px;
      width: 100px;
      text-align: right;
    }

    .form-label span{
      font-weight: bold;
      color: #ff3f34;
    }

    .form-label button, #btnSubmit, #btnReset{
      padding: 2px 10px;
      border: none;
      height: 28px;
      margin-left: 5px;
      font-size: 15px;
      background-color: #e0e0dd;
      cursor: pointer;
    }

    #btnSearchISBN{
      background-color: #bcce3c;
    }

    #btnSubmit{
      background-color: #042d04;
      color: white;
    }

    .form-label input,
    .form-label select,
    .form-label textarea {
      flex: 1;
      padding: 5px;
      /*border-radius: 3px;*/
      /*border: 1px solid #ccc;*/
    }


    #isbn{
      flex: 0 0 200px;
      width: 200px;
    }


    .subBox{
      display: flex;
      flex: 0 0 600px;
      width: 600px;
    }

    .subBox > div:first-child > label{
      flex: 0 0 100px;
      min-width: 100px;
    }

    .subBox label{
      flex: 0 1 auto;
      max-width: 100px;
    }

    label[for="pressYear"], label[for="press"],
    label[for="edition"], label[for="seriesOrder"]{
      max-width: 80px;
    }

    /*#pressYear, #press, #edition, #bookCopies{*/
    /*  flex: 0 0 110px;*/
    /*  width: 113px;*/
    /*}*/


    #pages, #size{
      margin-right: 5px;
    }



    .subBox input
    {
      flex: 1 1 auto;
      width: 80px;
    }

    .buttons{
      text-align: center;
    }

    .buttons input{
      margin: 10px 5px;
    }





    </style>


    <script>

        $(function(){

            $("#isbn").change(function(){

                let value = this.value;
                value = value.replace(/[^0-9]/g, '');
                this.value = value;

            });
            
            $('#publication_year').change(function(){
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

            
            $("#page_count").change(function(){

                let value = this.value;
                value = value.replace(/[^0-9]/g, '');
                this.value = value;

            });

            $("#book_size").change(function(){

                let value = this.value;
                value = value.replace(/[^0-9.]/g, '');

                let exp1 = /^[0-9]{1,5}\.[0-9]{1,}$/;
                let exp2 = /^[0-9]{0,5}$/;

                if(exp1.test(value)){
                    let a = value.substr(value.indexOf('.')+1);
                    
                    if(a.charAt(0)==0) value=value.substr(0, value.indexOf('.'));
                   
                    else value = value.substr(0, value.indexOf('.')+1) + a.charAt(0);


                    $("#warning_book_size").html("");
                    $("#warning_book_size").css("display", "none");

                }

                else if(exp2.test(value)){
                    $("#warning_book_size").html("");
                    $("#warning_book_size").css("display", "none");
                }

                else if(value!=""){
                    $("#warning_book_size").html("도서 크기의 형식이 올바르지 않습니다. 다시 입력해주세요.");
                    $("#warning_book_size").css("display", "block");


                }
                
                this.value = value;
            });

            
            $("#volume_number").change(function(){

                let value = this.value;
                value = value.replace(/[^0-9]/g, '');
                this.value = value;

            });
            
            
            $("#classification_code").change(function(){

                let value = this.value;
                value = value.replace(/[^0-9.]/g, '');

                let exp1 = /^[0-9]{1,3}\.[0-9]{1,6}$/;
                let exp2 = /^[0-9]{1,3}$/;

                if(exp1.test(value)){
                    let a = value.substr(0, value.indexOf('.'));
                    while(a.length<3){
                        a = "0"+a;
                    }

                    value = a + value.substr(value.indexOf('.'));

                    while(value.charAt(value.length-1)==0 || value.charAt(value.length-1) == '.') 
                    	{
                    	value=value.substr(0, value.length-1);
                    	}
                    $("#warning_classification_code").html("");
                    $("#warning_classification_code").css("display", "none");
                }

                else if(exp2.test(value)){
                    while(value.length<3) {
                        value = "0"+value;
                    }
                    $("#warning_classification_code").html("");
                    $("#warning_classification_code").css("display", "none");

                }

                else if(value!="") {
                    $("#warning_classification_code").html("분류기호의 형식이 올바르지 않습니다. 다시 입력해주세요.");
                    $("#warning_classification_code").css("display", "block");
                }

                else{
                    $("#warning_classification_code").html("");
                    $("#warning_classification_code").css("display", "none");
				}
                
               

                this.value = value;

            });
            
            
                      



        });


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
        <h1>도서등록</h1>
    </div>
    <div class="contentsLocation">
        홈 &gt 도서관리 &gt 도서등록
    </div>
    <div class="contentsMain">
        <div class="bookAddBigBox">
            <div class="bookAddLeft">
                <%String context = request.getContextPath();%>
                <form name="bookAddForm" method="post" action="<%=context%>/book_servlet/add.do">

                    <div>
                        <div class="form-label" id="isbnSearch">
                            <label for="isbn"><span>*</span>ISBN:</label>
                            <input type="text" id="isbn" name="isbn" required>
                            <button type="button" id="btnSearchISBN">도서정보 조회</button>
                        </div>
                        <div class="warning"></div>
                        <div class="form-label">
                            <label for="series_title">총서명:</label>
                            <input type="text" id="series_title" name="series_title">
                        </div>
                        <div class="form-label">
                            <label for="title"><span>*</span>서명:</label>
                            <input type="text" id="title" name="title" required>
                            <button type="button">복본 조사</button>
                            <!--복본조사 화면에서 판사항에 변동있는지 등 조사-->
                        </div>
                        <!--          <div class="form-label">-->
                        <!--            <label for="series_title">서명권차:</label>-->
                        <!--            <input type="text" id="series_title" name="seriesTitle" required>-->
                        <!--          </div>-->
                        <!--          <div class="form-label">-->
                        <!--            <label for="originalTitle">원표제:</label>-->
                        <!--            <input type="text" id="originalTitle" name="originalTitle">-->
                        <!--          </div>-->
                        <div class="form-label">
                            <label for="author"><span>*</span>저자:</label>
                            <input type="text" id="author" name="author" required>
                            <button type="button">저자 관리</button>
                        </div>
                        <div class="form-label">
                            <label for="translator">역자:</label>
                            <input type="text" id="translator" name="translator">
                            <label for="painter">삽화:</label>
                            <input type="text" id="painter" name="painter">
                        </div>
                        <div class="subBox">
                            <div class="form-label">
                                <label for="publisher_location">출판지:</label>
                                <input type="text" id="publisher_location" name="publisher_location">
                            </div>
                            <div class="form-label">
                                <label for="publisher_name"><span>*</span>출판사:</label>
                                <input type="text" id="publisher_name" name="publisher_name" required>
                            </div>
                            <div class="form-label">
                                <label for="publication_year"><span>*</span>출판년도:</label>
                                <input type="text" id="publication_year" name="publication_year" placeholder="YYYY" required>
                            </div>
                        </div>
                        <div class="subBox">
                            <div class="form-label">
                                <label for="page_count">페이지:</label>
                                <input type="text" id="page_count" name="page_count">p.
                            </div>

                            <div class="form-label">
                                <label for="book_size">크기:</label>
                                <input type="text" id="book_size" name="book_size">cm
                            </div>                                                    
                        </div>
                        <div class="warning" id="warning_book_size"></div>
                        <!--          <div class="form-label">-->
                        <!--            <label for=price>가격:</label>-->
                        <!--            <input type="text" id="price" name="price">-->
                        <!--          </div>-->
                        <div class="subBox">
                            <div class="form-label">
                                <label for="location">소장위치:</label>
                                <select name="location" id="location">
                                    <option value="인문자료실(2층)" selected>인문자료실(2층)</option>
                                    <option value="사회역사자료실(3층)">사회역사자료실(3층)</option>
                                    <option value="과학기술자료실(4층)">과학기술자료실(4층)</option>
                                    <option value="특수자료실(4층)">특수자료실(4층)</option>
                                </select>
                            </div>
                            <div class="form-label">
                                <label for="status">도서상태:</label>
                                <select name="status" id="status">
                                    <option value="정리중" selected>정리중</option>
                                    <option value="대출가능">대출가능</option>
                                    <option value="대출불가">대출불가</option>
                                    <option value="예약서가">예약서가</option>
                                    <option value="분실">분실</option>
                                    <option value="폐기">폐기</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-label">
                            <label for="img_url">이미지 등록:</label>
                            <div class="imageSpace"></div>
                            <input type="file" id="img_url" name="img_url">
                        </div>
                        <div class="form-label">
                            <label for="book_description">도서소개:</label>
                            <textarea id="book_description" name="book_description" rows="5"></textarea>
                        </div>
                    </div>

                    <div class="callNumBox">
                        <div class="subBox">
                            <div class="form-label">
                                <label for="classification_code"><span>*</span>분류기호:</label>
                                <input type="text" id="classification_code" name="classification_code" required>
                                <!--              <button type="button">검색</button><br>-->
                            </div>
                            <!--
                              <div class="form-label">
                                 <label for="bookCopies"><span>*</span>입력도서수:</label> 
                                    여러권 입력하려면 처음에 들어갈때부터 선택하게끔 바꾸자
                                <input type="number" id="bookCopies" name="bookCopies" value="1">
                              </div>
                              -->
                            <!--                <div class="form-label">-->
                            <!--                  <label for="authorCode"><span>*</span>저자기호:</label>-->
                            <!--                  &lt;!&ndash;저자기호는 저자, 서명을 모두 한글로 입력해야만 자동생성됨. 안그러면 에러메시지 출력-->
                            <!--                  이후 화면에 표시되는 저자기호 생성 창에서 한글이 아닌 부분을 한글로 수정(숫자x, 영어x)-->
                            <!--                  ex) 80일 -> 팔십일. 이때 실제 입력한 책 이름이 수정되는건 아님. 저자기호에서만 한글로 바뀜&ndash;&gt;-->
                            <!--                  <input type="text" id="authorCode" name="authorCode"><button type="button">생성</button>-->
                            <!--                </div>-->
                        </div>
                        <div class="warning" id="warning_classification_code"></div>
                        
                        <div class="subBox">
                            <div class="form-label">
                                <label for="volume_number">권차:</label>
                                <input type="text" id="volume_number" name="volume_number">
                            </div>
                            <div class="form-label">
                                <label for="edition">판사항:</label>
                                <input type="text" id="edition" name="edition">
                                <!--판사항 입력되어있는데 (1)복본조사를 통해 기존 판을 가져왔다면 그냥 넘어가고 (2)기존 판 안가져왔으면 메시지 한번 띄워주기-->
                            </div>
                        </div>
                        <div class="form-label">
                            <label for="call_number"><span>*</span>청구기호:</label>
                            <input id="call_number" name="call_number"><button type="button">생성</button><button type="button">청구기호 브라우징</button>
                        </div>
                        <!--              <div class="form-label">-->
                        <!--                <label for="bookID">등록번호:</label>-->
                        <!--                <input id="bookID" name="bookID" disabled>-->
                        <!--              </div>-->
                    </div>
                    <div class="buttons">
                        <input type="submit" value="자료등록" id="btnSubmit"><input type="reset" value="다시입력" id="btnReset">
                    </div>
                    <%
                        if(request.getAttribute("err")!=null){
                            String err = (String)request.getAttribute("err");
                    %>

                    <script>
                        alert("<%=err%>");

                        $(function(){
                            $("#isbn").val(<%=request.getAttribute("isbn")%>);
                            $("#page_count").val(<%=request.getAttribute("page_count")%>);
                            $("#book_size").val(<%=request.getAttribute("book_size")%>);
                            $("#volume_number").val(<%=request.getAttribute("volume_number")%>);
                            $("#classification_code").val(<%=request.getAttribute("classification_code")%>);
                            $("#publication_year").val(<%=request.getAttribute("publication_year")%>);


                            $("#publisher_location").val("<%=(request.getAttribute("publisher_location")!=null) ? request.getAttribute("publisher_location") : "" %>");
                            $("#series_title").val("<%=(request.getAttribute("series_title")!=null) ? request.getAttribute("series_title") : "" %>");
                            $("#edition").val("<%=(request.getAttribute("edition")!=null) ? request.getAttribute("edition") : "" %>");
                            $("#img_url").val("<%=(request.getAttribute("img_url")!=null) ? request.getAttribute("img_url") : "" %>");
                            $("#book_description").val("<%=(request.getAttribute("book_description")!=null) ? request.getAttribute("book_description") : "" %>");

                            $("#publisher_name").val("<%=request.getAttribute("publisher_name")%>");
                            $("#title").val("<%=request.getAttribute("title")%>");
                            $("#call_number").val("<%=request.getAttribute("call_number")%>");
                            $("#location").val("<%=request.getAttribute("location")%>");
                            $("#status").val("<%=request.getAttribute("status")%>");

                            $("#author").val("<%=request.getAttribute("author")%>");
                            $("#painter").val("<%=request.getAttribute("painter")%>");
                            $("#translator").val("<%=request.getAttribute("translator")%>");


                        });

                    </script>

                    <% }%>

                </form>

                <div>
                    유의사항<br>
                    <ol type="1">
                        <li>저자
                            <ul>
                                <li>저자가 2인 이상인 경우 ;로 구분하여 작성합니다. ex) 홍길동; 이순신</li>
                            </ul>
                        </li>
                        <li>청구기호
                            <ul>
                                <li>시리즈 도서의 경우 권차란을 작성해야 합니다.<br>
                                    ex) 서명: 개미 : 베르나르 베르베르 장편소설. 3<br>
                                    권차: 3<br>
                                    ※시리즈 도서는 저자기호와 분류기호가 일치해야 합니다.
                                </li>
                                <li>전집 도서의 경우 총서명, 출판사를 작성해야 합니다.<br>
                                    ex) 총서명: 초등과학학습만화<br>
                                    서명: &ltWhy?&gt 화장과 화장품<br>
                                    출판사: 예림당<br>
                                    권차: 96<br>
                                    ※시리즈 도서는 저자기호와 분류기호가 일치해야 합니다.
                                </li>
                            </ul>
                        </li>
                        <li>기타
                            <ul>
                                <li>기타 작성 방법은 사서지침을 참고하세요.</li>
                                <button type="button">사서지침 파일 열기</button>
                            </ul>
                        </li>
                    </ol>
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