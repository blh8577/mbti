<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
   <title>글쓰기 - MBTI 커뮤니티</title>
   <c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp"></c:import>
<main class="container">
   <div class="card">
      <h1 class="card-title">게시글 작성</h1>
      <form action="${pageContext.request.contextPath}/createBoard"  method="post" enctype="multipart/form-data">
         <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>
         </div>
         <div class="form-group">
            <label for="category">게시판</label>
            <select id="category" name="category">
               <option value="0">MBTI</option>
               <option value="1">RG</option>
               <option value="2">RB</option>
               <option value="3">LG</option>
               <option value="4">LB</option>
            </select>
         </div>
         <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" required></textarea>
         </div>
         <div class="form-group">
            <label for="files">사진 첨부</label>
            <input type="file" id="files" name="files" multiple>
         </div>
         <div class="form-actions" style="justify-content: flex-end;">
            <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">등록하기</button>
         </div>
      </form>
   </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
</body>
</html>