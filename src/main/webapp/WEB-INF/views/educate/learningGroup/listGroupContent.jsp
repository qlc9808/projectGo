<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2023-12-11
  Time: 오전 9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="col-2">
            <%@ include file="/WEB-INF/components/EducateSidebar.jsp"%>
        </div>

        <%--본문 리스트--%>
        <div class="container p-5 col-10">
            <p>그룹 콘텐츠 수 : ${GroupContentCnt}</p>
            <div class="d-flex justify-content-end align-items-center mb-3">
                <button onclick="">조회하기</button>
            </div>
            <div>
                <c:if test="${learningGroupList.size() == 0}">해당하는 코스 정보가 없습니다.</c:if>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th> </th><th>게임콘텐츠명</th><th>학습구독기간</th><th>학습가능인원</th><th>그룹지정된인원</th>
                        </tr>
                        <c:forEach var="GroupList" items="${learningGroupList}">
                            <tr>
                                <td><input type="checkbox" name="gameContent" id="gameContent"></td>
                                <td>${GroupList.title}</td>
                                <td>${GroupList.startDate} ~ ${GroupList.endDate}</td>
                                <td>${GroupList.maxSubscribers}</td>
                                <td>${GroupList.availableSlots}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="text-center">
                    <button onclick="">학습그룹 상세입력</button>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>
