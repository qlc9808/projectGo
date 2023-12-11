<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <h5>총 건수: ${gameContentsTotalCount}</h5>

            <table border="1">
                <tr>
                    <th>No.</th> <th>콘텐츠 이미지</th> <th>게임컨텐츠명</th> <th>패키지 내용</th> <th>난이도</th> <th>구독가능인원</th>
                    <th>구독 기간</th> <th>구독 시작 날짜</th> <th>구독 종료 날짜</th> <th>정가</th> <th>할인율</th> <th>판매가</th>
                </tr>

                <c:forEach var="gameContent" items="${gameContentsList}" varStatus="status">
                    <tr id="gameContent${status.count}">
                        <td>${status.count}</td>
                        <td>${gameContent.imageName}</td>
                        <td>${gameContent.title}</td>
                        <td>${gameContent.content}</td>
                        <td>${gameContent.gameLevel}</td>
                        <td>${gameContent.maxSubscribers}</td>
                        <td>${gameContent.subscribeDate}</td>
                        <td>${gameContent.subscribleStart}</td>
                        <td>${gameContent.subscribleEnd}</td>
                        <td>${gameContent.price}</td>
                        <td>${gameContent.discountRate}</td>
                        <td>${gameContent.discountPrice}</td>
                    </tr>
                </c:forEach>
            </table>


            <!-- 페이징 작업 -->
            <div style="text-align: center;">
                <c:if test="${page.startPage > page.pageBlock }">
                    <a href="gameSelect?currentPage=${page.startPage - page.pageBlock }">[이전]</a>
                </c:if>
                <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
                    <a href="gameSelect?currentPage=${i }">[${i}]</a>
                </c:forEach>
                <c:if test="${page.endPage < page.totalPage }">
                    <a href='gameSelect?currentPage=${page.startPage + page.pageBlock}'>[다음]</a>
                </c:if>
            </div>


        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
