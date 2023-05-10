<%@page import="work.Library"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="type" value="${dto.user_type}"/>



<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"content="width=device-width,initial-scale=1.0">
  <link href="${path}/include/style2.css" type="text/css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="${path}/include/header.js"></script>



  <title>도서대출</title>
  <style>



    .contentsMain{
      display: flex;
    }

    .userSummary{
      min-width: 280px;
      flex: 0;
    }

    .summaryTop{
      display: flex;
      flex-direction: column;
    }

    .summaryTop > div:first-of-type{
      padding-bottom: 10px;
      border-bottom: #777777 solid 1px;
    }

    .summaryTop h3{
      margin: 0;
      padding: 0;
    }

    .summaryTop ul{
      margin: 0;
      padding: 0;
      list-style: none;
    }

    .summaryTop > ul:first-of-type{
      display: flex;
      padding: 10px 0;
    }

    .summaryTop > ul:first-of-type > li{
      border: 1px solid black;
      flex: 1 1 23%;
      max-width: 23%;
      margin: auto;
      text-align: center;
    }

    .userSummary table{
      border-top: #777777 solid 1px;
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    .userSummary table td, .userSummary table th{
      text-align: left;
      border-bottom: #bbc4c7 dashed 1px;
    }
    
    .userSummary table th{
     width: 65px;
    }
        
    
    .userSummary table tr:last-child td,
    .userSummary table tr:last-child th
    {
      border-bottom: #777777 solid 1px;
    }
    

    .userMain{
      flex-grow: 1;
      margin-left: 20px;
    }

    .bookScan{
      /*background-color: #195372;*/
      min-height: 180px;
    }

    .bookScan > div{
      display: flex;
      align-items: center;
    }

    input[name="copy_id"]{
      height: 21px;
      width: 150px;
    }

    .issuingListBoxUpper{
      text-align: right;
    }
    
        .issuingListBox{
      /*background-color: #bcce3c;*/
    }

    .issuingListBox table{
      width: 100%;
      border-collapse: collapse;
    }
    
    #numHeader{
      width: 50px;
    }

    #idHeader, #callNumberHeader, #locationHeader, #duedateHeader{
      width: 100px;
    }

    #titleHeader{
      width: 40%;
    }

    #statusHeader{
      width: 80px;
    }
    
    .selected{
      background-color: #e9f8d1;
    }
    
    .prohibited{
      background-color: rgba(246, 233, 245, 0.9);
    }

    #btnChangeDueDate, #btnCheckout, #btnDelete, #btnReset, #btnSearchBook{
      background-color: gainsboro;
      color: black;
      border: none;
      font-size: 16px;
      padding: 4px 15px;
      margin: 4px 0;
      cursor: pointer;
    }

    #btnSearchBook{
      background-color: #042d04;
      color: white;
    }

    #btnCheckout {
      background-color: #bcce3c;
      padding: 4px 40px;
    }

    #btnSearchBook{
      margin-left: 5px;
    }



  </style>


  <script>
  
  
  var due_date;
  var user_type = "${type}";

    $(function(){

    	
    	//1분마다 한번씩 반납예정일 갱신
    	renewDueDate();
    	setInterval(renewDueDate, 60000);
    	
    	
    	$("#btnSearchBook").click(function(){
    		searchBook();
    	});
    	

    	$("#btnDelete").click(function(){
    		deleteBook();
    	});
    	
    	$("#btnReset").click(function(){
    		if(confirm("대출 목록을 초기화하시겠습니까?")) $("#copyList").html('');
    	});
    	

      $("#selectAllCheck").change(function(){
    	  
        if($(this).is(":checked")){
          $('input:checkbox[name="checkoutCheck"][disabled=false]').prop('checked',true);
          $(".copies").addClass('selected');
        }
        else{
          $('input:checkbox[name="checkoutCheck"]').prop('checked',false);
          $(".copies").removeClass('selected');
        }
      });
    	
    	
      $("#copyList").on("change", "input:checkbox[name='checkoutCheck']", function(){
			let id = this.value;
  	        let row = document.getElementById(id);

  	        if(!$(this).is(":checked")){
    		    $(row).removeClass('selected');
    		    
    		    if($("#selectAllCheck").is(":checked")){

    		    $("#selectAllCheck").prop('checked',false);
    		 }
    		    
    		}
  	        
   		 else{
   			$(row).addClass('selected');
 		 }
 		    
      });
     
      
      $('input[name=copy_id]').change(function(){
          let value = this.value;
          value = value.replace(/[^0-9]/g, '');
          this.value=value;
      });
      

    });
    
    
    function searchBook(){

    	let copy_id = $('input[name=copy_id]').val();
        let exp = /^[0-9]{9}$/;
            if(exp.test(copy_id)){
            	
                let copy_ids = document.getElementsByName("checkoutCheck");
                for(let i = 0; i < copy_ids.length; i++){
                    if(copy_id === copy_ids[i].value){
                        alert("이미 입력한 바코드 번호입니다.");
                        $('input[name=copy_id]').val('');
                        return false;
                    }
                }
                
        		$.ajax({
        			type: "get", //ajax에선 get이랑 post 차이가 뭐지?
        			url : "${path}/book_servlet/view_copy.do",
        			data : {copy_id : copy_id},
        			success: function(result){
        				
        				if(result!=null && result!=""){
                            $("#copyList").append(result);
                            $('input[name=copy_id]').val('');
                            $('input[name=due_date]').val(due_date); //반납예정일 갱신
                            numbering(); //넘버링
        				}
        				
        				else{
        					alert("존재하지 않는 도서 바코드 번호입니다.");
        				}
        				
        			}
         		});
            }
            
                      
            else if(copy_id==""||copy_id==null){
            alert("도서 바코드 번호를 입력해주세요.");
        	$('input[name=copy_id]').focus();
        	return;

            }
            
            else {
            	alert("잘못된 바코드 형식입니다. 9자리 숫자로 입력해주세요.");
            	$('input[name=copy_id]').focus();
            	return;
            }
        }
    
    
    function deleteBook(){
        let selected = document.getElementsByClassName('selected');
        $(selected).remove();
        numbering();
    }
    
    
    
    function checkoutSubmit() {
    	
        if(document.getElementsByClassName("selected").length > 0)
        	{
        	
        	let selectedRows = $("form[name=checkoutForm] input[type=checkbox]:checked").closest("tr").not(".prohibited");
        	let data = [];
        	
        	selectedRows.each(function() {
        	  let row = $(this);
        	  let copy_id = row.find("input[name=checkoutCheck]").val();
        	  let due_date = row.find("input[name=due_date]").val();
        	  let isbn = row.find("input[name=isbn]").val();
        	  let title = row.find("input[name=title]").val();

        	  data.push({
        		user_id: "${dto.user_id}",
        		user_type: "${type}",
        	    copy_id: copy_id,
        	    due_date: due_date,
        	    title: title,
        	    isbn: isbn
        	  });
        	});
        	
        	
    		$.ajax({
    			type: "post",
    			url : "${path}/circulate_servlet/checkout.do",
    			data : JSON.stringify(data),
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			dataType: "json",
    			success: function(result){
    				
                    let successList = result.successList;
                    let member = result.member;
                    
    				if(successList!=null && successList.length > 0){
    					
    					let message = "*** 총 " + successList.length + "권의 도서가 성공적으로 대출되었습니다. ***\n";
    	                
    					$("#checkout_status").text(member.checkout_status);
    					$("#numCheckedOut").text(member.numCheckedOut);
    					$("#numReservations").text(member.numReservations);
    					$("#numLateReturns").text(member.lateReturns);
    					
    					for(let i=0; i<successList.length; i++){
    						message += (i+1 + ") ");
                            let dto = successList[i];
                            message += dto.title + "\n";
                            let copy_id = dto.copy_id;
                            let tr = document.getElementById(copy_id);
                            $(tr).remove();
                            numbering();
    					}
    							
    					alert(message);
    				

    					
    				} else {
    					alert("도서 대출에 실패하였습니다.")
    				}
    			},
    			error: function(){
    				alert("대출 도중 문제가 발생하였습니다.");
    			}
    				
    		});
    				
    		} else {
        	alert("대출할 도서를 선택하세요.");
        	return false;
        }
    }
    
    
    function numbering() {
        let rows = document.getElementsByClassName("numbers");
        for (let i = 0; i < rows.length; i++) {
            rows[i].innerText = i+1;
    }
        
    }
    
    
    function renewDueDate(){
    	
    	    $.ajax ({
    	    	
    			type: "post",
    			url : "${path}/circulate_servlet/getDuedate.do",
    			data : {"user_type": user_type},
    			dataType: "json",
    			success: function(result){
    				
    				due_date = result.due_date;
    	    	}
    			});
    	
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
    <h1>도서대출</h1>
  </div>
  <div class="contentsLocation">
    홈 &gt 도서대출
  </div>
  <div class="contentsMain">
  

  <% 
  
  MemberDTO dto = (MemberDTO)request.getAttribute("dto");
  if(dto == null) {
	  response.sendRedirect("checkout.jsp?message=access");
  }
  
  int max_borrow = Library.getMaxBorrow(dto.getUser_type());
  
  %>

    <div class="userSummary">
      <div class="summaryTop">
        <div>
          <ul>
            <li><h3>${dto.name}(${dto.user_id})</h3></li>
            <c:choose>
            	<c:when test="${type=='학생'}">
            	    <li>${dto.sdto.dept_name}</li>
            		<li>${dto.sdto.status}</li>           
            	</c:when>
            	<c:when test="${type=='교수'}">
            	    <li>${dto.pdto.dept_name}</li>
            		<li>${dto.pdto.rank}</li>           
            	</c:when>
            </c:choose>            
          </ul>
        </div>

        <ul>
          <li>
            <div>상태</div>
            <div id="checkout_status">${dto.checkout_status}</div>
          </li>
          <li>
            <div>대출도서</div>
            <div><span id="numCheckedOut">${dto.numCheckedOut}</span>/<%= max_borrow %></div>
          </li>
          <li>
            <div>예약도서</div>
            <div><span id="numReservations">${dto.numReservations}</span>/<%=Library.MAX_RESERVATION%></div>
          </li>
          <li>
            <div>연체도서</div>
            <div id="numLateReturns">${dto.numLateReturns}</div>
            <!--얘네 클릭해서 정보 확인하거나 가져올 수 있게-->
          </li>
        </ul>
        <ul>
          <li>연체료 0원이 있습니다.</li>
          <!--<li>분실도서 0건이 있습니다.</li>-->
        </ul>

      </div>




      <table>
        <tr>
          <th>생년월일</th> <td>${dto.birthdate}</td>
        </tr>
        <tr>
          <th>연락처1</th> <td>${dto.tel1}</td>
        </tr>
        <tr>
          <th>연락처2</th> 
          <c:choose>
            <c:when test="${dto.tel2!=null}">
	          <td>${dto.tel2}</td>
	         </c:when>
    	  <c:otherwise>
          	 <td>-</td>
          </c:otherwise>
          </c:choose>
        </tr>
        <tr>
          <th>이메일</th> <td>${dto.email}</td>
        </tr>
        <tr>
          <th>주소</th> <td>${dto.address1} ${dto.address2}</td>
        </tr>
      </table>

    </div>

    <div class="userMain">
      <div class="bookScan">
        <span>도서 바코드를 스캔하거나 입력하세요.</span>
        <div><input name="copy_id"><button type="button" id="btnSearchBook">검색</button></div>
      </div>

      <div class="issuingListBox" id="issuingListBox">
        <form name="checkoutForm" method="post">
        <!-- <input type="hidden" name="user_id" value="${dto.user_id}"> -->
        <input type="checkbox" id="selectAllCheck"> <label for="selectAllCheck">전체선택</label>
        <button type="button" id="btnDelete">삭제</button>
        <!-- <button type="button" id="btnChangeDueDate">반납일 변경</button> -->
        <table id="copyListTable" border="1">
        <thead>
          <tr>
            <th id="numHeader">No.</th>
            <th id="idHeader">도서등록번호</th>
            <th id="titleHeader">서명</th>
            <th id="callNumberHeader">청구기호</th>
            <th id="locationHeader">서가위치</th>
            <th id="duedateHeader">반납예정일</th>
            <th id="statusHeader">도서상태</th>
          </tr>
          </thead>
          <tbody id="copyList">
          </tbody>
        </table>
        </form>
      </div>
      <div class="issuingListBoxUpper">
        <input type="reset" value="초기화" id="btnReset">
        <button type="button" id="btnCheckout" onclick="checkoutSubmit()">대출</button>
      </div>


    </div>


  </div>

</div>


<footer>
  지혜대학교도서관 서울특별시 강남구<br>
  COPYRIGHT 2023 WISDOM UNIVERSITY
</footer>


</body>
</html>