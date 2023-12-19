<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>학습그룹 상세조회</title>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="col-2">
            <%@ include file="/WEB-INF/components/EducateSidebar.jsp"%>
        </div>

        <div class="container p-5 col-10">
            <%--디테일 상단부--%>
            <div class="container p-5">
                <table class="table table-bordered">
                    <tr>
                        <th class="col-2">학습그룹 : </th><td class="col-2">${detailLearningGroup[0].name}</td>
                        <th class="col-2">게임콘텐츠 : </th><td class="d-flex">${detailLearningGroup[0].title}</td>
                    </tr>
                    <tr>
                        <th class="col-2">그룹제한인원 : </th><td class="col-2">${detailLearningGroup[0].groupSize}</td>
                        <th class="col-2">그룹가입인원 : </th><td class="d-flex">${detailLearningGroup[0].studentCount}</td>
                    </tr>
                    <tr>
                        <th colspan="4">그룹가입내역 : </th>
                    </tr>
                </table>
            </div>

            <%--디테일 리스트 메인--%>
            <div class="container p-5">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th>No</th><th>학생이름</th><th>연락처</th><th>이메일</th><th>주소</th><th>가입일자</th>
                        </tr>
                        <c:forEach var="detailGroup" items="${detailLearningGroup}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${detailGroup.studentName}</td>
                                <td>${detailGroup.phone}</td>
                                <td>${detailGroup.email}</td>
                                <td>${detailGroup.address}</td>
                                <td><fmt:formatDate value="${detailGroup.approvalDate}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
