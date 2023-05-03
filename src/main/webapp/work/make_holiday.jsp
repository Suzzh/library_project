<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">
<title>Insert title here</title>

<script>


let page = 1;
let rows = 0;
let totalCount = 0;

$(function(){
  getHoliday();
});

function getHoliday() {

    $.getJSON('https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo',
            {
              serviceKey : '1uJ4yDd/s1CLd4FGIQzIJA0aLVlur+CbOzXxxpiSGNxdE0+SOX2fnM2SYN6CaN+DNvz2kma/Wlg/f53P7LmbKw==',
              solYear : '2023',
              _type : 'json',
              pageNo : page
            },
            function (data) {
              rows+=data.response.body.numOfRows;
              totalCount = data.response.body.totalCount;
              let items = data.response.body.items.item;

              for(let i = 0; i < items.length; i ++){

                if(items[i].isHoliday=='N') continue;
                
                let li = $('<li></li>')


                let date = $('<input type="text" name="date">');
                let name = $('<input type="text" name="name">');

                date.val(items[i].locdate);
                name.val(items[i].dateName);
                
                li.append(date);
                li.append(name);
                $("#result").append(li);

                
              }

              if(rows < totalCount) {
                page+=1;
                getHoliday();
              }

            }).fail(function(jqXHR, textStatus, errorThrown){
      console.log("ERROR : " + textStatus + ": " + errorThrown)
    });


  }

</script>

</head>
<body>
<h4>2023년의 공휴일</h4>
<form action="${path}/work_servlet/make_holiday.do" method="post">
<div id="result">
</div>
<input type="submit" value="저장">
</form>
</body>
</html>
