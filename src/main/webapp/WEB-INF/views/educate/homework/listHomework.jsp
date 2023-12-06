<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp" %>
    <title>Title</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {

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

            updateBirthday();


            const maxTextLength = 2000;
            const textarea = document.getElementById('content');
            const textValidator = document.getElementById('textarea-validate');

            textarea.addEventListener('input', function () {
                const length = this.value.length;

                if (length > maxTextLength) {
                    // 4000자를 초과하면 더 이상 입력하지 못하도록 합니다.
                    this.value = this.value.substring(0, maxTextLength);
                } else {
                    // 현재 입력된 글자 수를 표시합니다.
                    textValidator.innerText = length + "/" + maxTextLength;
                }
            });

        });


        function submitForm(event) {
            event.preventDefault();

            // Form data를 가져옵니다.
            var title = document.getElementById("title").value;
            var content = document.getElementById("content").value;
            var progress = document.getElementById("progress").value;
            const yearSelect = document.getElementById("year");
            const monthSelect = document.getElementById("month");
            const daySelect = document.getElementById("day");


            const year = yearSelect.value;
            const month = monthSelect.value;
            const day = daySelect.value;
            const deadline = new Date(year, month, day);
            // 데이터를 객체로 만듭니다.
            var data = {
                'title': title,
                'content': content,
                'progress': progress,
                'deadline': deadline
            };
            $.ajax({
                url: "<%=request.getContextPath()%>/homework/insertHomework",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function () {
                    console.log("insertHomework() success")
                },
                error: function () {
                    console.log("insertHomework() failed")
                }
            })
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
            <%-- 이곳에 작성을 해주세요 --%>
            <div class="container border">
                <h1>숙제정보입력</h1>
                <form action="/signUp" method="post">
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
                        <label for="content" class="col-sm-2 col-form-label fw-bold text-end"
                               style="font-size: 20px;">숙제내용</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" aria-label="With textarea" id="content"
                                      name="content"></textarea>
                            <p id="textarea-validate" class="helptext text-start"></p>
                        </div>
                    </div>
                    <div class="my-4 row align-items-baseline ">
                        <label for="progress" class="col-sm-2 col-form-label fw-bold text-end"
                               style="font-size: 20px;">숙제진도</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="progress" name="progress">
                        </div>
                    </div>


                    <div class="my-4 row align-items-center ">
                        <label class="col-sm-2 col-form-label fw-bold text-end"
                               style="font-size: 20px;">제출기한</label>
                        <div class="col-sm-8 d-flex align-items-center">
                            <div class="col-4">
                                <select class="form-select text-center" id="year">
                                    <option value=""></option>
                                </select>
                            </div>
                            <span class="date-text">년</span>
                            <div class="col-3">
                                <select class="form-select text-center" id="month">
                                    <option value=""></option>
                                </select>
                            </div>
                            <span class="date-text">월</span>
                            <div class="col-3 ">
                                <select class="form-select text-center" id="day">
                                    <option value=""></option>
                                </select>
                            </div>
                            <span class="date-text">일</span>
                        </div>
                    </div>
                    <div class="container row justify-content-center my-5">

                        <button type="submit" class="btn btn-primary col-4 px-3 mx-2"
                                style="background: #52525C; border: none"
                                onclick="submitForm(event);">저장하기
                        </button>
                        <button type="reset" class="btn btn-primary col-4 px-3 mx-2">취소</button>

                    </div>
                </form>
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
                                <td>${homework.deadline}</td>
                                <td>${homework.distributionDate}</td>
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
