<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="mbti" value="${sessionScope.member.mbti_idx}" />
<c:set var="color" value="${sessionScope.color}"/>

<!DOCTYPE html>
<html>
<head>
   <title>MBTI</title>
   <link rel="stylesheet" href="css.css">
</head>
<body>
<!-- Header Section -->

<c:import url="./header.jsp"></c:import>

<!-- Content Section -->
<section class="board_content_wrap">
   <form action="./imguploadTest"  method="post" enctype="multipart/form-data">
      제목 : <input type="text" name="title"><br>
      사진 : <input type="file" name="file1" multiple><br>
      내용 : <textarea name="context" cols="30" rows="5"></textarea><br>
      게시판 : <select name="cat">
         <option value="0">MBTI</option>
         <option value="1">RG</option>
         <option value="2">RB</option>
         <option value="3">LG</option>
         <option value="4">LB</option>
     </select>
      <input type="submit" value="등록">
   </form>
</section>

<!-- Footer Section -->

<c:import url="./footer.jsp"></c:import>

</body>
</html>