<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<script>
    //
    function goToDetailLearningGroup() {
        var radios = document.getElementsByName('learningGroup');
        var checkedValue;
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                checkedValue = radios[i].value;
                break;
            }
        }
        if (checkedValue) {
            location.href = '/group/detailLearningGroup?id=' + checkedValue;
        } else {
            alert('학습그룹을 선택해주세요.')
        }
    }
</script>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="col-2">
            <%@ include file="/WEB-INF/components/EducateSidebar.jsp"%>
        </div>

        <%--본문 리스트--%>
        <div class="container p-5 col-10">
            <p>학습그룹 수 :${totalLearningGroupCnt}</p>
            <div class="d-flex justify-content-end align-items-center mb-3">
                <button onclick="" class="m-5">조회하기</button>
                <button onclick="" class="m-5">변경하기</button>
                <button onclick="" class="m-5">삭제하기</button>
            </div>
            <div>
                <c:if test="${learningGroupList.size() == 0}">해당하는 학습그룹 정보가 없습니다.</c:if>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th></th><th>학습그룹명</th><th>게임콘텐츠명</th><th>그룹 T/O</th><th>구독기간</th><th>등록 학생수</th>
                        </tr>
                        <c:forEach var="groupList" items="${learningGroupList}">
                            <tr>
                                <td><input type="radio" name="learningGroup" id="learningGroup" value="${groupList.id}"></td>
                                <td>${groupList.name}</td>
                                <td>${groupList.title}</td>
                                <td>${groupList.groupSize}</td>
                                <td>
                                    <fmt:formatDate value="${groupList.startDate}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>
                                    ~ <fmt:formatDate value="${groupList.endDate}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>
                                </td>
                                <td>#</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="text-center">
                    <button onclick="goToDetailLearningGroup()">학습그룹 상세조회</button>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>
