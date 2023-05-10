<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
  <div class="header-upper-box">
    <div class="header-upper">
      <div class="header-left">
        <a href="${path}/index.jsp" title="지혜대학교 도서관"><img src="https://cdn-icons-png.flaticon.com/512/3362/3362210.png" width="40px"></a>
        <a href="${path}/index.jsp" id="sitename" title="지혜대학교 도서관"><strong>지혜대학교 도서관</strong><br><strong>WISDOM UNIVERSITY LIBRARY</strong></a>
      </div>
      <div class="header-right">
        <%
          String user_name = "";
          user_name = (String)session.getAttribute("user_name");
          if(user_name != null && user_name != ""){%>
        <a href="#" id="toLogout" title="로그아웃" onclick="logoutCheck()">로그아웃</a>
        <script>
          function logoutCheck(){
            let result = confirm('로그아웃하시겠습니까?');
            if(result){
              location.href="${path}/member_servlet/logout.do";
            }
            else return false;
          }
        </script>
        <%}
        else{%>
        <a href="${path}/member_servlet/loginForm.do" id="toLogin" title="로그인">로그인</a>
        <%}%>
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
      <li><a href="${path}/book_servlet/searchForm.do" class="toMenu" title="도서검색">도서검색</a></li>
      <li><a href="${path}/collection_servlet/top_list.do" class="toMenu" title="컬렉션">컬렉션</a></li>
      <li>도서관서비스</li>
      <li><a href="${path}/notice_servlet/board.do" class="toMenu" title="도서관안내">도서관안내</a></li>
      <li><a href="${path}/my_library/borrowedBooks.do" class="toMenu" title="내 서재">내 서재</a></li>
      <li>#</li>
    </ul>
  </div>