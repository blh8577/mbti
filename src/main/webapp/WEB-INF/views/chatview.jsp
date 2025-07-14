<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="chat" items="${chatlist}">

	  <c:choose>
         <c:when test = "${sessionScope.member.mid eq chat.member_mid}">
	      <div class="chat_my_wrap">
	         <table>
	            <tr>
	               <td colspan="2"><b>나</b></td>
	            </tr>
	            <tr>
	               <td><c:out value="${chat.chat}"/>&nbsp;</td>
	               <td><c:out value="${chat.wrdate}"/></td>
	            </tr>
	         </table>
	      </div>
         </c:when>

         <c:otherwise>
	      <div class="chat_you_wrap">
	         <table>
	            <tr>
	               <td colspan="2"><b><c:out value="${chat.mbti_idx}"/></b></td>
	            </tr>
	            <tr>
	               <td><c:out value="${chat.chat}"/>&nbsp;</td>
	               <td><c:out value="${chat.wrdate}"/></td>
	            </tr>
	         </table>
	      </div>
         </c:otherwise>
      </c:choose>

</c:forEach>
