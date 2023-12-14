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
            <h5>컨텐츠 조회 및 구독 신청</h5>

            <form action="/subscribe/subscribeClick" method="post">
                <table class="table table-bordered">
                    <tr>
                        <th>구독</th> <th>No.</th> <th>콘텐츠 이미지</th> <th>가격/구독기간</th> <th>상품소개</th>
                    </tr>

                    <c:forEach var="gameContent" items="${gameContentsList}" varStatus="status">
                        <tr id="gameContent${status.count}">
                            <td><input type="checkbox" name="gameIds" value="${gameContent.id}"></td>
                            <td>${status.count}</td>
                            <td>${gameContent.imageName}</td>
                            <td>${gameContent.price}원 / ${gameContent.subscribeDate}개월</td>
                            <td>${gameContent.content}</td>
                        </tr>
                    </c:forEach>
                </table>
                <button type="submit">구독하기</button>
            </form>

            <%-- 페이징 작업하기 --%>


        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
