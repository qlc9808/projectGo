<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>학습그룹 조회</title>
</head>
<script>
    // 그룹 리스트의 선택한 항목의 상세정보로 넘어감.
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
            alert('상세를 보고싶은 학습그룹을 선택해주세요.')
        }
    }

    // 그룹 리스트의 선택한 항목의 수정으로 넘어감.
    function goToUpdateFormLearningGroup() {
        var radios = document.getElementsByName('learningGroup');
        var checkedValue;
        for (var i = 0; i <radios.length; i++) {
            if (radios[i].checked) {
                checkedValue = radios[i].value;
                break;
            }
        }
        if (checkedValue) {
            location.href = '/group/updateFormLearningGroup?id=' + checkedValue;
        } else  {
            alert('수정하고싶은 학습그룹을 선택해주세요.')
        }
    }

    // 그룹 리스트의 선택한 항목의 삭제를 수행함.
    function goToDeleteLearningGroup() {
        var radios = document.getElementsByName('learningGroup');
        var checkedValue;
        for (var i = 0; i <radios.length; i++) {
            if (radios[i].checked) {
                checkedValue = radios[i].value;
                break;
            }
        }
        if (checkedValue) {
            if (confirm('정말로 학습그룹을 삭제하시겠습니까?')) {
                location.href = '/group/deleteLearningGroup?id=' + checkedValue;
            }
        } else {
            alert('삭제하고싶은 학습그룹을 선택해 주세요')
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
                <button onclick="goToUpdateFormLearningGroup()" class="m-5">변경하기</button>
                <button onclick="goToDeleteLearningGroup()" class="m-5">삭제하기</button>
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
                                    <fmt:parseDate var="parsedStartDate" value="${groupList.startDate}" pattern="yyyy-MM-dd" />
                                    <fmt:formatDate value="${parsedStartDate}" type="date" />
                                    ~
                                    <fmt:parseDate var="parsedEndDate" value="${groupList.endDate}" pattern="yyyy-MM-dd" />
                                    <fmt:formatDate value="${parsedEndDate}" type="date" />
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

        <!-- 페이징 처리 -->
        <%--<nav aria-label="Page navigation example">
            <ul class="pagination">
                <c:choose>
                    <c:when test="${path == 0 }">
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="group/listLearningGroup?currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="group/listLearningGroup?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="group/listLearningGroup?currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="course1?currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="course1?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&area=${area}&sigungu=${sigungu}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="course1?currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>--%>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

</body>
</html>
