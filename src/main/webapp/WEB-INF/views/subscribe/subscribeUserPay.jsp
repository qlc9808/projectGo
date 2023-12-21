<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    th, td {
        text-align: center;
        vertical-align: middle;
    }
    #gameImg{
        width: 110px;
    }
</style>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/SubscribeSidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <p>내 구독 상품 조회하기</p>

<%--      구매 기간 클릭해서 조회 가능하게 하기      구매 기간 <input type="date">--%>

                <p>총 건수: ${subscribeUserPayTotalCount}</p>
                <table class="table table-bordered">
                    <tr>
                        <th>No.</th> <th>콘텐츠 이미지</th> <th>가격 / 구독 기간 (개월)</th> <th>결제일</th> <th>학습 그룹</th>
                    </tr>

                    <c:forEach var="my" items="${mySubscribePayList}">
                        <tr>
                            <td>${my.rn}</td>
                            <td><img id="gameImg" alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/gameContents/${my.imageName}"></td>
                            <td>${my.discountPrice}원 / ${my.subscribeDate}개월</td>
                            <td>${my.purchaseDate}</td>
                            <td>${my.name}</td>
                        </tr>
                    </c:forEach>
                </table>

            <%-- 페이징 작업 --%>
            <ul class="pagination justify-content-center">
                <c:if test="${page.startPage > page.pageBlock}">
                    <a href="subscribeUserPay?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
                </c:if>

                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <a href="subscribeUserPay?currentPage=${i}">[${i}]</a>
                </c:forEach>

                <c:if test="${page.endPage < page.totalPage}">
                    <a href="subscribeUserPay?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
                </c:if>
            </ul>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
