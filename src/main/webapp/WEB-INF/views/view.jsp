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
      function reple_btn(ri){
         $(".board_view_reple_table .board_view_reple_input").css("display","none");
         $(".rrd"+ri).fadeIn();
      }
      
      function recommendation(){
  		$.post("boardRecommendation?view=<c:out value="${param.view}"/>", {
  		}, function(data) {
  			if (data == 0) {
  				//히든값 변경 해줘야함
  				alert("추천!");
  			} else {
  				alert("이미 추천ㅜ");
  			}
  		});
      }
      
      function comrecommendation(com){
    		$.post("comRecommendation" , {
    			com : com
    		}, function(data) {
    			if (data == 0) {
    				//히든값 변경 해줘야함
    				alert("추천!");
    			} else {
    				alert("이미 추천ㅜ");
    			}
    		});
        }
      
   </script>
</head>
<body>
   <!-- Header Section -->
	<c:import url="./header.jsp"></c:import>
<!-- Content Section -->
<section class="board_view_wrap">
   <div class="board_view_1000">
      <div class="board_view_top <c:out value="${color}"/>_bottom">
      <p>제목 : <b><c:out value="${boardview.title}" /></b></p>
      <p><c:out value="${boardview.wrdate}" /></p>
      <p>추천수 : <c:out value="${boardview.recommendation}" /></p></div>
      <div class="board_view_mid">

      		<c:forEach var="img" items="${piclist}">   
				<img alt="오류" src="${img}">
			</c:forEach>

      </div>
      <div class="board_view_bottom">

<c:out value="${boardview.content}" />

      </div>
      <div class="board_view_recommend">
         <button onclick="recommendation()" class="<c:out value="${color}"/>_background">추천하기</button>
      </div>
      <div class="board_view_reple_wrap">
         <div class="board_view_reple_input">
            <form action="./commentInput" method="post">
               <input type="text" name="content" placeholder="댓글을 입력해주세요.">
               <input type="hidden" name="view" value="<c:out value="${param.view}"/>"/>
               <input type="hidden" name="mgr" value="0"/>
               <input type="submit" value="등록" class="<c:out value="${color}"/>_background">
            </form>
         </div>
         <hr>
         <div class="board_view_reple_table">
            <table>
               <!-- 상위 부모 댓글 -->
               
               
               <c:forEach var="com" items="${comlist}" varStatus="s">
               
               				<c:choose>
								<c:when test="${com.level == 1}">
									
									
									<tr>
					                  <td><a
										href="noteView?recipients=<c:out value="${com.member_mid}"/>"><c:out value="${com.mbti_idx}"/></a></td>
					                  <td>추천:<c:out value="${com.recommendation}"/></td>
					                  <td>
					                        <input type="hidden" name="reple_no" value="<c:out value="${com.commentno}"/>">
					                        <button onclick="comrecommendation(<c:out value="${com.commentno}"/>)">추천</button>
					                  </td>
					                  <td><button onclick="reple_btn(<c:out value="${s.count}"/>)">댓글달기</button></td>
					                  <td><c:out value="${com.wrdate}"/></td>
					               </tr>
					               <tr>
					                  <td colspan="6"><c:out value="${com.content}"/>
					                     <div class="board_view_reple_input rrd<c:out value="${s.count}"/>">
					                        <form action="./commentInput" method="post">
					    	                   <input type="hidden" name="mgr" value="<c:out value="${com.commentno}"/>">
					                           <input type="hidden" name="index" value="<c:out value="${s.count}"/>">
					                           <input type="hidden" name="view" value="<c:out value="${param.view}"/>"/>
					                           <input type="text" name="content" placeholder="대댓글을 입력해주세요.">
					                           <input type="submit" value="등록" class="<c:out value="${color}"/>_background">
					                        </form>
					                     </div>
					                  </td>
					               </tr>
									
									
								</c:when>
								<c:otherwise>
									
									
									<!-- 하위 댓글 -->
					               <tr>
					                  <td width="10%" style="font-size: 30px">&rdca;</td>
					                  <td><a
										href="noteView?recipients=<c:out value="${com.member_mid}"/>"><c:out value="${com.mbti_idx}"/></a></td>
					                  <td>추천:<c:out value="${com.recommendation}"/></td>
					                  <td><button onclick="comrecommendation(<c:out value="${com.commentno}"/>)">추천</button></td>
					                  <td><c:out value="${com.wrdate}"/></td>
					               </tr>
					               <tr>
					                  <td></td>
					                  <td colspan="5"><c:out value="${com.content}"/></td>
					               </tr>
									
									
								</c:otherwise>
							</c:choose>
               
               </c:forEach>

            </table>
         </div>
      </div>
   </div>
</section>

<!-- Footer Section -->

	<c:import url="./footer.jsp"></c:import>
	
</body>
</html>