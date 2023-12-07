<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp" %>
    <title>Title</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            populateYear();
            populateMonth();
            populateDay();
            populateHour();
            updateBirthday();
        });

        function populateYear() {
            const yearSelect = document.getElementById("year");
            const currentYear = new Date().getFullYear();
            for (let i = currentYear; i >= currentYear - 100; i--) {
                addOption(yearSelect, i);
            }
        }

        function populateMonth() {
            const monthSelect = document.getElementById("month");
            for (let j = 1; j <= 12; j++) {
                addOption(monthSelect, j);
            }
        }

        function populateDay() {
            const daySelect = document.getElementById("day");
            for (let k = 1; k <= 31; k++) {
                addOption(daySelect, k);
            }
        }

        function populateHour() {
            const hourSelect = document.getElementById("hour");
            for (let l = 1; l <= 31; l++) {
                addOption(hourSelect, l);
            }
        }


        function addOption(selectElement, value) {
            const option = document.createElement("option");
            option.value = value;
            option.text = value;
            selectElement.appendChild(option);
        }

        function updateBirthday() {
            const today = new Date();
            document.getElementById("year").value = today.getFullYear();
            document.getElementById("month").value = today.getMonth() + 1;
            document.getElementById("day").value = today.getDate();
            document.getElementById("hour").value = today.getHours();
        }

        function submitForm(event) {
            event.preventDefault();
            const body = getFormData();
            sendRequest(body);
        }

        function getFormData() {
            const title = document.getElementById("title").value;
            const content = document.getElementById("content").value;
            const progress = document.getElementById("progress").value;
            const year = document.getElementById("year").value;
            const month = document.getElementById("month").value;
            const day = document.getElementById("day").value;
            const hour = document.getElementById("hour").value;
            const deadline = new Date(year, month - 1, day, hour); 

            return {
                'title': title,
                'userId': 1,
                'content': content,
                'progress': progress,
                'deadline': deadline
            };
        }

        function sendRequest(body) {
            $.ajax({
                url: "<%=request.getContextPath()%>/homework/insertHomework",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(body),
                contentType: "application/json",
                success: function (response) {
                    console.log("insertHomework() success");
                    alert(response.message);
                    window.location.href = "/homework/listHomework";
                },
                error: function (jqXHR) {
                    console.log("insertHomework() failed");
                    const errorResponse = JSON.parse(jqXHR.responseText);
                    console.log(errorResponse);
                    alert(errorResponse.message + ": " + errorResponse.error);
                }
            })
        }

        function createQueryURL(page) {

            const params = {
                currentPage: page
            };
            return '/homework/listHomework?' + Object.entries(params)
                .filter(([key, value]) => value !== undefined && value !== null && value !== '')
                .map(([key, value]) => key + '=' + value).join('&');
        }

    </script>
    <style>
        .date-text {
            font-size: 16px;
            font-weight: 600;
            margin-right: 20px;
            margin-left: 10px;
            text-align: center;
        }

        h1 {
            color: black;
            font-size: 32px;
            font-weight: 600;
            word-wrap: break-word;
            text-align: center;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp" %>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp" %>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <div class="container border my-4 py-3">
                <div class="container my-3 py-3">
                    <h1>숙제정보입력</h1>
                </div>
                <div>
                    <form action="/homework/listHomework" method="post">
                        <input type="hidden" name="status" value="1">
                        <input type="text" id="birthday" name="birthday" style="display: none;">

                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">숙제명</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="title" name="title">
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="progress" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">숙제진도</label>
                            <div class="col-sm-8">
                                <input type="number" class="form-control" id="progress" name="progress">
                                <p class="helptext text-start">숙제 진도는 숫자만 입력바랍니다.</p>
                            </div>
                        </div>


                        <div class="my-4 row align-items-center ">
                            <label class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">제출기한</label>
                            <div class="col-sm-8 d-flex align-items-center">
                                <div class="col-3">
                                    <select class="form-select text-center" id="year">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="date-text">년</span>
                                <div class="col-2">
                                    <select class="form-select text-center" id="month">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="date-text">월</span>
                                <div class="col-2 ">
                                    <select class="form-select text-center" id="day">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="date-text">일</span>
                                <div class="col-2 ">
                                    <select class="form-select text-center" id="hour">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="date-text">시</span>
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="content" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">숙제내용</label>
                            <div class="col-sm-8">
                            <textarea class="form-control" aria-label="With textarea" id="content" rows="5"
                                      name="content"></textarea>
                                <p id="textarea-validate" class="helptext text-end"></p>
                            </div>
                        </div>


                        <div class="container row justify-content-center my-5">

                            <button type="submit" class="btn btn-primary col-4 px-3 mx-2"
                                    style="background: #52525C; border: none"
                                    onclick="submitForm(event);event.preventDefault();">저장하기
                            </button>
                            <button type="reset" class="btn btn-primary col-4 px-3 mx-2">취소</button>

                        </div>
                    </form>

                </div>

            </div>
            <div class="container border">
                <div class="table-responsive">
                    <table id="homework-table" class="table text-center">
                        <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">숙제명</th>
                            <th scope="col">숙제내용</th>
                            <th scope="col">진도</th>
                            <th scope="col">제출기한</th>
                            <th scope="col">전송일자</th>
                            <th scope="col">생성일자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="num" value="${page.start}"/>
                        <c:forEach var="homework" items="${homeworkList}" varStatus="st">
                            <tr id="homework-${st.index}">
                                <td>${homework.id}</td>
                                <td>${homework.title}</td>
                                <td>${homework.content}</td>
                                <td>${homework.progress}</td>
                                <td><fmt:formatDate value="${homework.deadline}" pattern="yyyy/MM/dd (HH시)"/></td>
                                <td>${homework.distributionDate}</td>
                                <td><fmt:formatDate value="${homework.createdAt}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                                    <%--                            <td><a class="detail-btn" href="userDetail/${user.id}?currentPage=${page.currentPage}">관리</a></td>--%>
                            </tr>
                            <c:set var="num" value="${num + 1}"/>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div>
                    <nav aria-label="Page navigation example ">
                        <ul class="pagination">
                            <c:if test="${page.startPage > page.pageBlock}">
                                <li class="page-item">
                                    <a href="javascript:void(0)"
                                       onclick="location.href=createQueryURL(${page.startPage-page.pageBlock})"
                                       class="pageblock page-link">[이전]</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                                <li class="page-item">
                                    <a href="javascript:void(0)" onclick="location.href=createQueryURL(${i})"
                                       class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${page.endPage < page.totalPage}">
                                <li class="page-item">
                                    <a href="javascript:void(0)"
                                       onclick="location.href=createQueryURL(${page.startPage+page.pageBlock})"
                                       class="pageblock page-link">[다음]</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>
