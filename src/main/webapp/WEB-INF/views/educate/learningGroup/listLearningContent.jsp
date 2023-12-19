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
            <form action="/group/listLearningContent1" class="d-flex justify-content-end align-items-center mb-3">
                <input  class="form-control keyword-input mr-3" type="text" name="keyword" placeholder="키워드를 검색해보세요." id="keyword" style="flex-grow: 1;">
                <button class="btn btn-primary mr-3" style="min-width: 90px;" onclick="submitForm();">조회하기</button>
            </form>
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
                                    <%--<fmt:formatDate value="${contentList.subscribleStart}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>
                                    ~ <fmt:formatDate value="${contentList.subscribleEnd}" type="date" pattern="yyyy.MM.dd"></fmt:formatDate>--%>
                                </td>
                                <td>${contentList.maxSubscribers}</td>
                                <td>${contentList.assignedPeople}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="text-center">
                    <button onclick="goToDetailLearningContent()">학습그룹 상세입력</button>
                </div>
            </div>
        </div>

        <!-- 페이징 처리 -->
        <nav aria-label="Page navigation example ">
            <ul class="pagination">
                <c:if test="${page.startPage > page.pageBlock}">
                    <c:choose>
                        <c:when test="${path == 0}">
                            <li class="page-item">
                                <a href="/group/listLearningContent?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
                            </li>
                        </c:when>
                        <c:when test="${path == 1}">
                            <li class="page-item">
                                <a href="/group/listLearningContent1?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
                            </li>
                        </c:when>
                    </c:choose>
                </c:if>

                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <c:choose>
                        <c:when test="${path == 0}">
                            <li class="page-item">
                                <a href="/group/listLearningContent?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:when>
                        <c:when test="${path == 1}">
                            <li class="page-item">
                                <a href="/group/listLearningContent1?currentPage=${i}&keyword=${keyword}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:when>
                    </c:choose>
                </c:forEach>

                <c:if test="${page.endPage < page.totalPage}">
                    <c:choose>
                        <c:when test="${path == 0}">
                            <li class="page-item">
                                <a href="/group/listLearningContent?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
                            </li>
                        </c:when>
                        <c:when test="${path == 1}">
                            <li class="page-item">
                                <a href="/group/listLearningContent1?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
                            </li>
                        </c:when>
                    </c:choose>
                </c:if>
            </ul>
        </nav>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>
