<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header class="header_wrap <c:out value="${color}"/>_bottom">
   <div class="header_top_wrap">
      <div class="header_top_1000">
         <div class="header_logo">
         	<a href="./"><img src="./img/<c:out value="${mbti}"/>.png" alt="이미지 없음"/></a>
         </div>
         <div class="header_title <c:out value="${color}"/>_color">
             <c:out value="${mbti}"/> 커뮤니티
         </div>
      </div>
   </div>
   <nav class="header_nav_wrap <c:out value="${color}"/>_background">
      <div class="header_nav_1000">
         <ul>
            <li><a href="./board?cat=0">게시판</a>
               <ul>
                  <li class="<c:out value="${color}"/>_background"><a href="./board?cat=0">MBTI 게시판</a></li>
                  <li class="<c:out value="${color}"/>_background"><a href="./board?cat=1">RG 게시판</a></li>
                  <li class="<c:out value="${color}"/>_background"><a href="./board?cat=2">RB 게시판</a></li>
                  <li class="<c:out value="${color}"/>_background"><a href="./board?cat=3">LG 게시판</a></li>
                  <li class="<c:out value="${color}"/>_background"><a href="./board?cat=4">LB 게시판</a></li>
               </ul>
            </li>
            <li><a href="./chatroom">채팅</a></li>
         </ul>
      </div>
   </nav>
</header>