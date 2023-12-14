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
            <h3>내 구독 상품 조회하기</h3>

<%--      구매 기간 클릭해서 조회 가능하게 하기      구매 기간 <input type="date">--%>

<%--            <form>
                <table class="table table-bordered">
                    <tr>
                        <th>콘텐츠 이미지</th> <th>가격/구독기간(개월)</th> <th>구매일자</th> <th>학습그룹</th>
                    </tr>

                    <c:forEach var="" items="${}" varStatus="status">
                        <tr>
                            <td>${.imageName}</td>
                            <td>${.price}/${.subscribeDate}개월</td>
                            <td>${.subscribleStart}</td>
                            <td>${.~~~~~~~~}</td>
                        </tr>
                    </c:forEach>
                </table>
            </form>--%>

            <%-- 페이징 작업 --%>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
