<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>

<%--
<script>
    // JSON 형식으로 변환
    document.getElementById("gameIds").value = JSON.stringify(gameIds);
    // 확인용 출력
    document.getElementById("confirmation").innerText = "확인용 - 구독한 게임 아이디(여러 개 가능): " + gameIds;
</script>
--%>

<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>

            <h3>결제 선택 방법</h3>
            <h6>모바일에서도 신용카드, 무통장 입금 등 결제가 가능합니다.</h6><hr>

            <form action="/subscribe/subscribePay" method="post">
                <div id="confirmation"></div>

                <input type="hidden" id="gameIds"  value="${gameIds}" name="gameIds"/>
                확인용 - 구독한 게임 아이디(여러 개 가능) : ${gameIds}
<%--            문제 : 이 방식은 배열 전체를 문자열로 변환하여 설정하고 있어서 controller에 넘기면 2차원 배열로 됨
                단일 문자열로 전달되어 컨트롤러에서 이를 단일 값으로 인식하고 1차원 배열로 처리해야 함
                해결책 : 자바스크립트로 JSON 형식으로 변환하고 hidden으로 보낸다           --%>

                <table class="table table-bordered">
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
                <button type="submit">결제하기</button>
            </form>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
