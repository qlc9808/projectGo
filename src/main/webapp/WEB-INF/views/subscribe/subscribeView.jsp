<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    th, td { text-align: center; }
</style>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <h5>컨텐츠 조회 및 구독 신청</h5>

            <form action="/subscribe/subscribeClick" method="post">
                <table class="table table-bordered">
                    <tr>
                        <th>구독</th> <th>No.</th> <th>콘텐츠 이미지</th> <th>가격 / 구독기간</th> <th>상품소개</th>
                    </tr>

                    <c:forEach var="gameContent" items="${gameContentsList}">
                        <tr id="gameContent${gameContent.rn}">
                            <td><input type="checkbox" name="gameIds" value="${gameContent.id}"></td>
                            <td>${gameContent.rn}</td>
                            <td>${gameContent.imageName}</td>
                            <td>
                                ${gameContent.discountPrice}원 / ${gameContent.subscribeDate}개월<br>
                                ${gameContent.subscribleStart} - ${gameContent.subscribleEnd}
                            </td>
                            <td>${gameContent.content}</td>
                        </tr>
                    </c:forEach>
                </table>
                <button type="submit" class="btn btn-primary">구독하기</button>
            </form>

            <!-- 페이징 작업 -->
            <ul class="pagination justify-content-center">
                <c:if test="${page.startPage > page.pageBlock}">
                    <a href="subscribeView?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
                </c:if>

                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <a href="subscribeView?currentPage=${i}">[${i}]</a>
                </c:forEach>

                <c:if test="${page.endPage < page.totalPage}">
                    <a href="subscribeView?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
                </c:if>
            </ul>

        </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
