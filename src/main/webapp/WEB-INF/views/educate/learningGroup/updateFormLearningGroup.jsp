<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>학습그룹 등록</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="col-2">
        <%@ include file="/WEB-INF/components/EducateSidebar.jsp"%>
    </div>

    <div class="container p-5 col-10">
        <%--컨텐츠 헤더--%>
        <div class="container p-5">
            <table class="table table-bordered">
                <tr>
                    <th class="col-4">게임콘텐츠명 : ${updateFormLearningGroup.title}</th>
                    <th class="col-4">학습가능인원 : ${updateFormLearningGroup.maxSubscribers}</th>
                    <th class="col-4">그룹 총 배정인원 : #</th>
                </tr>
            </table>
        </div>

        <%--컨텐츠 메인--%>
        <div class="container p-5">
            <h3 class="pb-5">그룹 상세 정보</h3>
            <form id="insertForm" action="/group/updateLearningGroup" method="post">
                <input type="hidden" id="id" name="id" value="${updateFormLearningGroup.id}">
                <input type="hidden" id="userId" name="userId" value="${updateFormLearningGroup.userId}">
                <div>
                    <label class="col-2">교육자명</label>
                    <label>${updateFormLearningGroup.userName}</label>
                </div>
                <div>
                    <label class="col-2">그룹명</label>
                    <input type="text" id="groupName" name="groupName" value="${updateFormLearningGroup.name}" required="required">
                </div>
                <div>
                    <label class="col-2">그룹인원</label>
                    <input type="text" id="groupSize" name="groupSize" value="${updateFormLearningGroup.groupSize}" required="required">
                </div>
                <div>
                    <label class="col-2">구독기간</label>
                    <input type="date" id="startDate" name="startDate" value="<fmt:formatDate value='${updateFormLearningGroup.startDate}' pattern='yyyy-MM-dd' />" required="required"> ~
                    <input type="date" id="endDate" name="endDate" value="<fmt:formatDate value='${updateFormLearningGroup.endDate}' pattern='yyyy-MM-dd' />" required="required">
                </div>
                <div>
                    <label class="col-2">기타항목1</label>
                    <input type="text" id="groupEtc1" name="groupEtc1" value="${updateFormLearningGroup.etc1}">
                </div>
                <div>
                    <label class="col-2">기타항목2</label>
                    <input type="text" id="groupEtc2" name="groupEtc2" value="${updateFormLearningGroup.etc2}">
                </div>
                <div class="text-center">
                    <button type="submit">학습 그룹 수정</button>
                </div>
            </form>
        </div>

    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
