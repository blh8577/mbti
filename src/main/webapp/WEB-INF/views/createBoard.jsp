<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
   <title>MBTI - 글쓰기</title>
   <%-- [수정] CSS 파일 경로를 절대 경로로 변경 --%>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainCss.css">
   <style>
      /* 글쓰기 폼을 위한 추가 스타일 */
      .create_form_wrap {
         padding: 20px;
         border: 1px solid #ddd;
         margin-top: 20px;
      }
      .create_form_wrap table {
         width: 100%;
      }
      .create_form_wrap table td {
         padding: 10px 5px;
         font-size: 14px;
      }
      .create_form_wrap input[type=text],
      .create_form_wrap select {
         width: 100%;
         height: 35px;
         padding: 5px;
      }
      .create_form_wrap textarea {
         width: 100%;
         height: 200px;
         padding: 10px;
         resize: vertical;
      }
      .create_form_wrap .submit_btn {
         width: 100px;
         height: 40px;
         border: none;
         color: white;
         cursor: pointer;
         float: right;
         margin-top: 10px;
      }
   </style>
</head>
<body>
<!-- Header Section -->
<c:import url="/WEB-INF/views/header.jsp"></c:import>

<!-- Content Section -->
<section class="board_content_wrap">
   <div class="board_content_1000">
      <div class="board_content_title <c:out value="${sessionScope.color}"/>_bottom <c:out value="${sessionScope.color}"/>_color">게시글 작성</div>

      <div class="create_form_wrap">
         <form action="${pageContext.request.contextPath}/createBoard"  method="post">
            <table>
               <colgroup>
                  <col width="15%">
                  <col width="85%">
               </colgroup>
               <tbody>
               <tr>
                  <td><label for="title">제목</label></td>
                  <td><input type="text" id="title" name="title" required></td>
               </tr>
               <tr>
                  <td><label for="category">게시판</label></td>
                  <td>
                     <select id="category" name="category">
                        <option value="0">MBTI</option>
                        <option value="1">RG</option>
                        <option value="2">RB</option>
                        <option value="3">LG</option>
                        <option value="4">LB</option>
                     </select>
                  </td>
               </tr>
               <tr>
                  <td><label for="content">내용</label></td>
                  <td><textarea id="content" name="content" required></textarea></td>
               </tr>
               </tbody>
            </table>

            <%-- 파일 업로드는 추후 구현 필요 --%>
            <%-- 사진 : <input type="file" name="file1" multiple><br> --%>

            <input type="submit" value="등록" class="submit_btn <c:out value="${sessionScope.color}"/>_background">
         </form>
      </div>
   </div>
</section>

<!-- Footer Section -->
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
</body>
</html>