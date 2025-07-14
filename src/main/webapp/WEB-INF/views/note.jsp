<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
   <title>MBTI</title>
   <link rel="stylesheet" href="css.css">
   <script src="./jquery.js"></script>
   <script>
   $(document).ready(function(){
	   history.replaceState({}, null, location.pathname);
	});
</script>
   
</head>
</head>
<body>
   <!-- Header Section -->
		<c:import url="./header.jsp"></c:import>

<!-- Content Section -->
<section class="chat_view_wrap">
   <div class="chat_view_500 <c:out value="${color}"/>_background">
	<div class="chatview">
	
	<c:forEach var="note" items="${notelist}">

	  <c:choose>
         <c:when test = "${sessionScope.member.mid eq note.member_mid}">
	      <div class="chat_my_wrap">
	         <table>
	            <tr>
	               <td colspan="2"><b>나</b></td>
	            </tr>
	            <tr>
	               <td><c:out value="${note.content}"/>&nbsp;</td>
	               <td><c:out value="${note.wrdate}"/></td>
	            </tr>
	         </table>
	      </div>
         </c:when>

         <c:otherwise>
	      <div class="chat_you_wrap">
	         <table>
	            <tr>
	               <td colspan="2"><b><c:out value="${note.reMbti}"/></b></td>
	            </tr>
	            <tr>
	               <td><c:out value="${note.content}"/>&nbsp;</td>
	               <td><c:out value="${note.wrdate}"/></td>
	            </tr>
	         </table>
	      </div>
         </c:otherwise>
      </c:choose>

</c:forEach>
	
	
	</div>

		<!-- 채팅 -->

	<div class="chat_input_wrap">
	
	<form action="./noteInput" method="post">
            <input type="text" name="text">
            <input type="hidden" value="<c:out value="${param.recipients}"/>" name="recipients">
            <input type="submit" value="전송">
	</form>
      </div>

   </div>
</section>

<!-- Footer Section -->
<footer class="<c:out value="${color}"/>_background">
   All Contents Copyright© 텀프로젝트 3조. All rights reserved.
</footer>
</body>
</html>