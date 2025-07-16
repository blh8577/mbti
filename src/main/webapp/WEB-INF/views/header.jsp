<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="header-wrap">
   <div class="container header-inner">
      <div class="header-logo">
         <a href="${pageContext.request.contextPath}/">
            <c:if test="${not empty sessionScope.loginMember}">
               <img src="${pageContext.request.contextPath}/img/${sessionScope.loginMember.mbtiIdx}.png" alt="MBTI 로고"/>
            </c:if>
            <span>MBTI 커뮤니티</span>
         </a>
      </div>
      <nav class="header-nav">
         <ul>
            <li>
               <a href="${pageContext.request.contextPath}/board?cat=0">게시판</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/board?cat=0">MBTI</a></li>
                  <li><a href="${pageContext.request.contextPath}/board?cat=1">RG</a></li>
                  <li><a href="${pageContext.request.contextPath}/board?cat=2">RB</a></li>
                  <li><a href="${pageContext.request.contextPath}/board?cat=3">LG</a></li>
                  <li><a href="${pageContext.request.contextPath}/board?cat=4">LB</a></li>
               </ul>
            </li>
            <li>
               <a href="${pageContext.request.contextPath}/chatroom?cat=0">채팅</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/chatroom?cat=0">MBTI</a></li>
                  <li><a href="${pageContext.request.contextPath}/chatroom?cat=1">RG</a></li>
                  <li><a href="${pageContext.request.contextPath}/chatroom?cat=2">RB</a></li>
                  <li><a href="${pageContext.request.contextPath}/chatroom?cat=3">LG</a></li>
                  <li><a href="${pageContext.request.contextPath}/chatroom?cat=4">LB</a></li>
               </ul>
            </li>
            <c:choose>
               <c:when test="${empty sessionScope.loginMember}">
                  <li><a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">로그인</a></li>
                  <li><a href="${pageContext.request.contextPath}/join" class="btn btn-primary blue-bg">회원가입</a></li>
               </c:when>
               <c:otherwise>
                  <li><a href="${pageContext.request.contextPath}/myNotes">내 쪽지함</a></li>
                  <li><a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">로그아웃</a></li>
               </c:otherwise>
            </c:choose>
         </ul>
      </nav>
      <button class="mobile-menu-btn" id="mobile-menu-toggle">
         <span></span><span></span><span></span>
      </button>
   </div>
   <nav class="mobile-nav" id="mobile-nav">
      <ul>
         <li><a href="${pageContext.request.contextPath}/board?cat=0">MBTI 게시판</a></li>
         <li><a href="${pageContext.request.contextPath}/chatroom?cat=0">MBTI 채팅방</a></li>
         <li><a href="${pageContext.request.contextPath}/myNotes">내 쪽지함</a></li>
         <c:if test="${empty sessionScope.loginMember}">
            <li><a href="${pageContext.request.contextPath}/login">로그인</a></li>
         </c:if>
         <c:if test="${not empty sessionScope.loginMember}">
            <li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
         </c:if>
      </ul>
   </nav>
</header>
<script>
   document.getElementById('mobile-menu-toggle').addEventListener('click', function() {
      document.getElementById('mobile-nav').classList.toggle('is-active');
   });
</script>