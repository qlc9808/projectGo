<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>학습그룹 등록</title>
</head>
<script type="text/javascript">
    window.onload = function() {
        var subscribeDate = ${insertFormLearningContent.subscribeDate}; // subscribeDate를 가져옵니다.
        var createdAt = new Date("${insertFormLearningContent.createdAt}"); // createdAt를 가져옵니다.

        // subscribeEndDate를 계산합니다.
        createdAt.setMonth(createdAt.getMonth() + subscribeDate);

        // subscribeEndDate를 yyyy-mm-dd 형식으로 변환합니다.
        var year = createdAt.getFullYear();
        var month = ("0" + (createdAt.getMonth() + 1)).slice(-2);
        var day = ("0" + createdAt.getDate()).slice(-2);
        var subscribeEndDate = year + "-" + month + "-" + day;

        // endDate input 필드의 max 속성을 설정합니다.
        document.getElementById("endDate").max = subscribeEndDate;
    }
</script>
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
                        <th class="col-4">게임콘텐츠명 : ${insertFormLearningContent.title}</th>
                        <th class="col-4">학습가능인원 : ${insertFormLearningContent.maxSubscribers}명</th>
                        <th class="col-4">그룹 총 배정인원 : ${insertFormLearningContent.assignedPeople}명</th>
                    </tr>
                </table>
            </div>

            <%--컨텐츠 메인--%>
            <div class="container p-5">
                <h3 class="pb-5">그룹 상세 정보</h3>
                <form id="insertForm" action="/group/insertLearningGroup" method="post">
                    <input type="hidden" id="id" name="id" value="${insertFormLearningContent.contentId}">
                    <input type="hidden" id="userId" name="userId" value="${insertFormLearningContent.payUserId}">
                    <div>
                        <label class="col-2">교육자명</label>
                        <label>${insertFormLearningContent.name}</label>
                    </div>
                    <div>
                        <label class="col-2">그룹명</label>
                        <input type="text" id="name" name="name" required="required">
                    </div>
                    <div>
                        <label class="col-2">그룹인원</label>
                        <input type="text" id="groupSize" name="groupSize" required="required">
                    </div>
                    <div>
                        <label class="col-2">구독기간</label>
                        <input type="date" id="startDate" name="startDate" required="required"> ~
                        <input type="date" id="endDate" name="endDate" required="required">
                    </div>
                    <div>
                        <label class="col-2">기타항목1</label>
                        <input type="text" id="etc1" name="etc1">
                    </div>
                    <div>
                        <label class="col-2">기타항목2</label>
                        <input type="text" id="etc2" name="etc2">
                    </div>
                    <div class="text-center">
                        <button type="submit">학습 그룹 등록</button>
                    </div>
                </form>
            </div>

        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
