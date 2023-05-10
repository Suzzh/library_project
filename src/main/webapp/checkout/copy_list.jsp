<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!-- 도서 대출 가능: 대출가능/예약서가/정리중 -->
		<c:choose>
			<c:when test="${cdto.status eq '정리중' || cdto.status eq '대출가능' || cdto.status eq'예약서가'}">
		
			<tr id="${cdto.copy_id}" class="selected copies">
            <td><input type="checkbox" name="checkoutCheck" value="${cdto.copy_id}" id="${cdto.copy_id}chk" checked>
			<label for="${cdto.copy_id}chk" class="numbers">0</label></td>
            <td>${cdto.copy_id}
            <input type="hidden" value="${cdto.getBookDTO().getIsbn()}" name="isbn">
            </td>
            <td>${cdto.getBookDTO().getTitle()}<input type="hidden" value="${cdto.getBookDTO().getTitle()}" name="title">
            </td>
            <td>${cdto.call_number}</td>
            <td>${cdto.location}</td>
            <td><input type="date" name="due_date" value="" disabled="disabled"></td>
            <td>${cdto.status}</td>
			</c:when>
			
			<c:otherwise>
			<tr id="${cdto.copy_id}" class="prohibited">
            <td><input type="checkbox" name="checkoutCheck" value="${cdto.copy_id}" id="${cdto.copy_id}chk" disabled="disabled">
			<label for="${cdto.copy_id}chk" class="numbers">0</label></td>
            <td>${cdto.copy_id}
            <input type="hidden" value="${cdto.getBookDTO().getIsbn()}" name="isbn">
            </td>
            <td>${cdto.getBookDTO().getTitle()}<input type="hidden" value="${cdto.getBookDTO().getTitle()}" name="title">
            </td>
            <td>${cdto.call_number}</td>
            <td>${cdto.location}</td>
            <td><input type="date" name="due_date" value="" disabled="disabled"></td>
            <td>${cdto.status}</td>
			</c:otherwise>
			
		</c:choose>
