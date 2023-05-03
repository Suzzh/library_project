<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
          <tr id="${cdto.copy_id}" class="selected copies">
            <td><input type="checkbox" name="checkoutCheck" value="${cdto.copy_id}" id="${cdto.copy_id}chk" checked>
			<label for="${cdto.copy_id}chk" class="numbers">0</label></td>
            <td>${cdto.copy_id}</td>
            <td>${cdto.getBookDTO().getTitle()}<input type="hidden" value="${cdto.getBookDTO().getTitle()} name="title"></td>
            <td>${cdto.call_number}</td>
            <td>${cdto.location}</td>
            <td><input type="date" name="due_date" value=""></td>
            <td>${cdto.status}</td>
          </tr>
