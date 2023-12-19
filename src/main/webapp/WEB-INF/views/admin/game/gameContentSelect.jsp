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
            <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <p>총 건수: ${gameContentsTotalCount}</p>

            <table class="table table-bordered">
                <tr>
                    <th>No.</th> <th>콘텐츠 이미지</th> <th>게임 콘텐츠명</th> <th>패키지 내용</th> <th>난이도</th> <th>구독 가능 인원</th>
                    <th>구독 기간</th> <th>정가</th> <th>할인율</th> <th>판매가</th>
                </tr>

                <c:forEach var="gameContent" items="${gameContentsList}">
                    <tr id="gameContent${gameContent.rn}">
                        <td>${gameContent.rn}</td>
                        <td>

                            <a href="/${gameContent.imagePath}${gameContent.imageName}">${gameContent.imageName}</a><br>
                        </td>

                        <td>${gameContent.title}</td>
                        <td>${gameContent.content}</td>
                        <td>${gameContent.gameLevel}</td>
                        <td>${gameContent.maxSubscribers}명</td>
                        <td>${gameContent.subscribeDate}개월</td>
                        <td>${gameContent.price}원</td>
                        <td>${gameContent.discountRate}%</td>
                        <td>${gameContent.discountPrice}원</td>
                    </tr>
                </c:forEach>
            </table>

            <!-- 페이징 작업 -->
            <ul class="pagination justify-content-center">
                <c:if test="${page.startPage > page.pageBlock}">
                    <a href="gameContentSelect?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
                </c:if>

                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <a href="gameContentSelect?currentPage=${i}">[${i}]</a>
                </c:forEach>

                <c:if test="${page.endPage < page.totalPage}">
                    <a href="gameContentSelect?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
                </c:if>
            </ul>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
