<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
    <div id="main-content">
        <%-- 이곳에 작성을 해주세요 --%>
        <h1>listHomework</h1>

            <div class="table-responsive">
                <table id="homework-table" class="table text-center">
                    <thead>
                    <tr>
                        <th scope="col">회원번호</th>
                        <th scope="col">이름</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="num" value="${page.start}"/>
                    <c:forEach var="homework" items="${homeworkList}" varStatus="st">
                        <tr id="homework-${st.index}">
                            <td>${homework.id}</td>
                            <td>${homework.title}</td>
<%--                            <td><a class="detail-btn" href="userDetail/${user.id}?currentPage=${page.currentPage}">관리</a></td>--%>
                        </tr>
                        <c:set var="num" value="${num + 1}"/>
                    </c:forEach>
                    </tbody>
                </table>
            </div>


    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
