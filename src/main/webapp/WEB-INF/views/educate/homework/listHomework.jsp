<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp" %>
    <title>Title</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {


            // 년도 옵션 생성
            const yearSelect = document.getElementById("year");
            const currentYear = new Date().getFullYear();
            for (let i = currentYear; i >= currentYear - 100; i--) {
                const option = document.createElement("option");
                option.value = i;
                option.text = i;
                yearSelect.appendChild(option);
            }

            // 월 옵션 생성
            const monthSelect = document.getElementById("month");
            for (let j = 1; j <= 12; j++) {
                const option = document.createElement("option");
                option.value = j;
                option.text = j;
                monthSelect.appendChild(option);
            }

            // 일 옵션 생성
            const daySelect = document.getElementById("day");
            for (let k = 1; k <= 31; k++) {
                const option = document.createElement("option");
                option.value = k;
                option.text = k;
                daySelect.appendChild(option);
            }

            function updateBirthday() {
                const yearSelect = document.getElementById("year");
                const monthSelect = document.getElementById("month");
                const daySelect = document.getElementById("day");


                const year = yearSelect.value;
                const month = monthSelect.value.padStart(2, '0');
                const day = daySelect.value.padStart(2, '0');
                const birthday = year + month + day;
                document.getElementById("birthday").value = birthday;
            }
        });

    </script>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp" %>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
        <h1>listHomework</h1>
        <div class="container">
            <h1>숙제정보입력</h1>
            <form action="/signUp" method="post">
                <input type="hidden" name="status" value="1">

                <input type="text" id="birthday" name="birthday" style="display: none;">

                <div class="my-4 row align-items-baseline ">
                    <label for="email" class="col-sm-2 col-form-label fw-bold text-end"
                           style="font-size: 20px;">이메일<SUP
                            style="color: #FF4379; font-size: 18px;">*</SUP></label>
                    <div class="col-sm-8">
                        <input type="email" class="form-control" id="email" name="email">
                        <p id="emailValidationFeedback" class="helptext text-start"></p>
                    </div>
                </div>

                <div class="my-4 row align-items-center ">
                    <label class="col-sm-2 col-form-label fw-bold text-end"
                           style="font-size: 20px;">생일<SUP
                            style="color: #FF4379; font-size: 18px;">*</SUP></label>
                    <div class="col-sm-8 d-flex align-items-center">
                        <div class="col-4"	>
                            <select class="form-select text-center" id="year">
                                <option value=""></option>
                            </select>
                        </div>
                        <span class="birthday-text">년</span>
                        <div class="col-3"	>
                            <select class="form-select text-center" id="month">
                                <option value=""></option>
                            </select>
                        </div>
                        <span class="birthday-text">월</span>
                        <div class="col-3 "	>
                            <select class="form-select text-center" id="day">
                                <option value=""></option>
                            </select>
                        </div>
                        <span class="birthday-text">일</span>
                    </div>
                </div>
            </form>
        </div>
        <div class="table-responsive">
            <table id="homework-table" class="table text-center">
                <thead>
                <tr>
                    <th scope="col">회원번호</th>
                    <th scope="col">이름</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="num" value="${page.start}"/>
                <c:forEach var="homework" items="${homeworkList}" varStatus="st">
                    <tr id="homework-${st.index}">
                        <td>${homework.id}</td>
                        <td>${homework.title}</td>
                            <%--                            <td><a class="detail-btn" href="userDetail/${user.id}?currentPage=${page.currentPage}">관리</a></td>--%>
                    </tr>
                    <c:set var="num" value="${num + 1}"/>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>
