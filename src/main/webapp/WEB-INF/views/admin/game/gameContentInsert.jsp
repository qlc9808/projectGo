<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
    <script>
        function calculateDiscountedPrice(){
            // 사용자한테 정가(price)와 할인율 입력 받기
            const priceInput = document.getElementById("price");
            const discountRateInput = document.getElementById("discountRate");
            const discountPriceInput = document.getElementById("discountPrice");

            // 정가와 할인율 값 가져오기
            const price = parseFloat(priceInput.value);
            const discountRate = parseFloat(discountRateInput.value);

            // 판매가 계산
            const discountedPrice = calculateDiscountedPriceValue(price, discountRate);

            // 결과 출력
            discountPriceInput.value = discountedPrice.toFixed(0);
        }

        function calculateDiscountedPriceValue(price, discountRate){
            return price * (1 - discountRate / 100);
        }

    </script>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <p>게임콘텐츠 등록</p>

            <form:form action="gameContentInsert" method="post" enctype="multipart/form-data">

                <table class="table table-bordered">
                    <tr>
                        <th>게임 콘텐츠명</th>
                        <td>
                            <input type="text" name="title">
                            <form:errors path="title"/>
                        </td>
                    </tr>

                    <tr>
                        <th>학습난이도</th>
                        <td>
                            <select name="gameLevel">
                                    <option value="1">초급</option>
                                    <option value="2">중급</option>
                                    <option value="3">고급</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <th>구독 기간</th>
                        <td>
                            <label for="months">개월 수 입력</label>
                            <input type="number" id="months" name="subscribeDate" min="1" max="12">
                        </td>
                    </tr>

                    <tr>
                        <th>구독 가능 인원 수</th>
                        <td>
                            <input type="number" min="1" name="maxSubscribers">
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <label for="price">정가</label>
                        </th>
                        <td>
                            <input type="number" name="price" id="price" oninput="calculateDiscountedPrice()" placeholder="정가를 입력하세요">
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <label for="discountRate">할인율</label>
                        </th>
                        <td>
                            <input type="number" name="discountRate" id="discountRate" oninput="calculateDiscountedPrice()" placeholder="할인율을 입력하세요">
                        </td>
                    </tr>

                    <tr>
                        <th>판매가</th>
                        <td>
                            <input type="number" name="discountPrice" id="discountPrice" readonly>
                        </td>
                    </tr>

                    <tr>
                        <th>패키지 내용</th>
                        <td>
                            <textarea cols="50" rows="10" name="content"></textarea>
                            <form:errors path="content"/>
                        </td>
                    </tr>

                    <%--<tr>
                        <th>썸네일</th>
                        <td>
                            <input type="file" id="file" name="file1">
                        </td>
                    </tr>--%>

                    <tr>
                        <td><button type="submit" class="btn btn-primary">등록하기</button></td>
                    </tr>

                </table>
            </form:form>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>