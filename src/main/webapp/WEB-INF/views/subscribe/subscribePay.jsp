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
            <%--${user.id}, ${user.name}, ${user.phone} 이 값들은 못 가지고 옴 --%>

            <h3>결제 선택 방법</h3>
            <h6>모바일에서도 신용카드, 무통장 입금 등 결제가 가능합니다.</h6><hr>

            <form action="/payment/subscriblePay" method="post">
                <input type="hidden" name="contentId" value="${gameIds}"/>
                구독한 게임 아이디(여러 개 가능) : ${gameIds}

                <table>
                    <tr>
                        <th>주문하실 상품</th>
                    </tr>
                    <tr>
                        <th>구매상품명</th> <td>${title}</td>
                    </tr>

                    <tr>
                        <th>구매자 정보</th>
                    </tr>
                   <tr>
                       <th>구매자명</th> <td>${users.name}</td>
                       <th>연락처</th> <td>${users.phone}</td>
                   </tr>

                    <tr>
                        <th>주문합계</th> <th>${totalPrice}원</th>
                    </tr>

                    <tr>
                        <th>결제 방법 선택</th>
                        <th><input type="radio" name="paymentType" value="1">무통장입금</th>
                        <th><input type="radio" name="paymentType" value="2">계좌이체</th>
                        <th><input type="radio" name="paymentType" value="3">카카오페이</th>
                    </tr>

                    <tr>
                        <th>입금자명</th> <td>${users.name}</td>
                    </tr>
                </table>
                <button type="button">결제하기</button>
            </form>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
