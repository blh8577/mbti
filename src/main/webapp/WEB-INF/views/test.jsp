
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<c:forEach var="img" items="${piclist}">   
<img alt="오류" src="${img}">
</c:forEach>



<form action="./imguploadTest"  method="post" enctype="multipart/form-data">

이미지 : <input type="file" name="file1" multiple><br>
<input type="submit" value="전송">
</form>


</body>
</html>
