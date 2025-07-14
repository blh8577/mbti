<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%--
    [수정] 세션에 저장된 loginMember 객체의 mbtiIdx 값을 사용합니다.
    [참고] color 값은 세션에 저장하는 로직이 없으므로, 일단 비워두거나 기본값을 지정해야 합니다.
--%>
<c:set var="mbti" value="${sessionScope.loginMember.mbtiIdx}" />
<c:set var="color" value="default_color" /> <%-- 예시: 기본 색상 지정 --%>

<!DOCTYPE html>
<html>
<head>
    <title>MBTI</title>
    <%-- [수정] 절대 경로 사용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainCss.css">
</head>
<body>
<!-- Header Section -->
<c:import url="/WEB-INF/views/header.jsp"></c:import>

<!-- Content Section -->
<section class="home_content_wrap">
    <div class="home_content_1000">
        <table>
            <tr>
                <td width="70%" height="50%" class="<c:out value="${color}"/>_border">
                    <div class="home_content_title  <c:out value="${color}"/>_bottom">인기글 게시판 뷰</div>
                    <div class="home_content_list_wrap">
                        <ul>
                            <%-- [수정] 절대 경로 사용 --%>
                            <c:import url="/latestBoard?homeboard=2"></c:import>
                        </ul>
                    </div>
                </td>
                <td width="30%" class="<c:out value="${color}"/>_border">
                    <div class="home_my_info_wrap <c:out value="${color}"/>_color"><c:out value="${mbti}"/></div>
                    <%-- [수정] 절대 경로 사용 --%>
                    <div class="home_my_logint_wrap"><button class="<c:out value="${color}"/>_background" onClick="location.href='${pageContext.request.contextPath}/logout'">로그아웃</button></div>
                </td>
            </tr>
            <tr>
                <td height="50%" class="<c:out value="${color}"/>_border">
                    <div class="home_content_title  <c:out value="${color}"/>_bottom">최신글 게시판 뷰</div>
                    <div class="home_content_list_wrap">
                        <ul>
                            <%-- [수정] 절대 경로 사용 --%>
                            <c:import url="/latestBoard?homeboard=1"></c:import>
                        </ul>
                    </div>
                </td>
                <td class="<c:out value="${color}"/>_border">
                    <%-- 쪽지 리스트 (주석 처리됨) --%>
                </td>
            </tr>
        </table>
    </div>

    <div class="search_wrap">
        <div>
            <%-- [수정] 절대 경로 사용 --%>
            <form action="${pageContext.request.contextPath}/search?cat=${param.cat}" method="post">
                <input type="text" name="search" class="<c:out value="${color}"/>_border">
                <input type="submit" value="검색" class="<c:out value="${color}"/>_background" />
            </form>
        </div>
    </div>
</section>

<!-- Footer Section -->
<c:import url="/WEB-INF/views/footer.jsp"></c:import>

</body>
</html>