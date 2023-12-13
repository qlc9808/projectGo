<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>학습그룹 컨텐츠</title>
</head>
<script>
    // 버튼 클릭 시 선택된 라디오 버튼의 userId 값을 가져와 URL에 추가하는 함수를 추가합니다.
    function goToDetailLearningContent() {
        var radios = document.getElementsByName('gameContent');
        var checkedValue;
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                checkedValue = radios[i].value;
                break;
            }
        }
        if (checkedValue) {
            location.href = '/group/insertFormLearningContent?id=' + checkedValue;
        } else {
            alert('게임콘텐츠를 선택해주세요.');
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
            <p>게임 콘텐츠 수 : ${learningContentCnt}</p>
            <div class="d-flex justify-content-end align-items-center mb-3">
                <button onclick="">조회하기</button>
            </div>
            <div>
                <c:if test="${learningContentList.size() == 0}">해당하는 게임콘텐츠 정보가 없습니다.</c:if>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th> </th><th>게임콘텐츠명</th><th>학습구독기간</th><th>학습가능인원</th><th>그룹지정된인원</th>
                        </tr>
                        <c:forEach var="contentList" items="${learningContentList}">
                            <tr>
                                <td><input type="radio" name="gameContent" id="gameContent" value="${contentList.id}"></td>
                                <td>${contentList.title}</td>
                                <td>
                                    <fmt:formatDate value="${contentList.subscribleStart}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>
                                    ~ <fmt:formatDate value="${contentList.subscribleEnd}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>
                                </td>
                                <td>${contentList.maxSubscribers}</td>
                                <td>#</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="text-center">
                    <button onclick="goToDetailLearningContent()">학습그룹 상세입력</button>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>
