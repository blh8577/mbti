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
	$('input[name=text]').keyup(function(e){
	   if (e.key === "Enter") {
		   chatInput();
		} 
	});
});

	function chatInput() {
		var text = $('input[name=text]').val();
		
		if(text == "" || text == null){
			return false;
		}else{
			$.post("./chatInput", {
				text : text
			}, function(data) {
				$('input[name=text]').val("");
			});			
		}

	}
	
	setInterval(function chatView(){
		
		$.post('./chatview', {
		}, function(data) {
			$('.chatview').html(data);
			$(".chatview").scrollTop($(".chatview")[0].scrollHeight);
		});
		
	}, 1000);
	
	
	
</script>
   
</head>
<body>
   <!-- Header Section -->
		<c:import url="./header.jsp"></c:import>

<!-- Content Section -->
<section class="chat_view_wrap">
   <div class="chat_view_500 <c:out value="${color}"/>_background">
	<div class="chatview">
	
	</div>

		<!-- 채팅 -->

	<div class="chat_input_wrap">
            <input type="text" name="text">
            <input type="button" value="전송" onclick="chatInput()">
      
      </div>

   </div>
</section>

<!-- Footer Section -->
<footer class="<c:out value="${color}"/>_background">
   All Contents Copyright© 텀프로젝트 3조. All rights reserved.
</footer>
</body>
</html>