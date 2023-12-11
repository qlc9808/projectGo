<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp" %>
    <title>Title</title>
    <script>

        $(document).ready(function() {


            $.ajax({
                url: '/homework/getHomeworkTitleList',
                type: 'GET',
                success: function(data) {
                    const select = $('#homeworkTitles');
                    select.empty();
                    select.append('<option value="">전체</option>');

                    $.each(data, function(index, value) {
                        select.append('<option value="' + value + '">' + value + '</option>');
                    });

                    const title = '${searchOptions.title != null ? searchOptions.title :""}';
                    if(title !== '') {
                        // 올바른 jQuery 선택자를 사용하여 선택된 옵션을 설정
                        $('option[value="'+title+'"]').attr('selected', 'selected');
                    } else {
                        // title 값이 없는 경우 "전체" 옵션을 선택
                        $('option[value=""]').attr('selected', 'selected');
                    }

                    // AJAX 요청이 성공적으로 완료된 후에 이벤트 핸들러 등록
                    select.on('change', function() {
                        console.log("wow");
                        const selectedTitle = $(this).val();
                        $('form').append('<input type="hidden" name="title" value="' + selectedTitle + '" />')
                            .submit();
                    });
                },
                error: function(error) {
                    console.log("Error: ", error);
                }
            });
        });

    </script>
    <style>
        h1 {
            color: black;
            font-size: 32px;
            font-weight: 600;
            word-wrap: break-word;
            text-align: center;
        }
        h2 {
            color: #FF4379;
            font-size: 24px;
            font-weight: 800;
            word-wrap: break-word
        }
        h3 {
            color: #6D6A6A;
            font-size: 20px;
            font-weight: 600;
            word-wrap: break-word
        }
        h4 {
            color: black;
            font-size: 15px;
            font-weight: 500;
            word-wrap: break-word
        }

        .btn-remove {
            padding: 0 7px;
            height: 15px;
            flex-shrink: 0;
            border-radius: 10px;
            background: #FF4379;
            text-decoration: none;
            color: #F8FCF4;
            justify-content: center;
            align-items: center;
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


            <div class="container my-4 py-3">
                <div class="container">
                    <h1>숙제 전송</h1>
                </div>
                <div class="container">
                    <h2>숙제 선택</h2>
                    <hr/>
                </div>
                <div class="container">
                    <form action="/homework/distributeHomeworkForm" method="post">
                        <label for="homeworkTitles" class="form-label" >숙제명:</label>
                        <select class="text-center" id="homeworkTitles">
                        </select>

                    </form>
                </div>
                <div class="container border p-2 m-2" style="height: auto;">
                    <div class="table-responsive">
                        <table id="homework-table-header" style="width: 98%" class="table text-center">
                            <thead>
                            <tr>
                                <th scope="col" style="width: 5%">선택</th>
                                <th scope="col" style="width: 15%">숙제명</th>
                                <th scope="col" style="width: 20%">숙제내용</th>
                                <th scope="col" style="width: 10%">진도</th>
                                <th scope="col" style="width: 15%">제출기한</th>
                                <th scope="col" style="width: 15%">전송일자</th>
                                <th scope="col" style="width: 15%">생성일자</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="table-responsive" style="height: 200px; overflow: auto;">
                        <table id="homework-table-body" class="table text-center">
                            <tbody>
                            <c:forEach var="homework" items="${homeworkList}" varStatus="st">
                                <tr id="homework-${st.index}">
                                    <td style="width: 5%"><input type="checkbox" class="form-check-input" id="checkbox-${homework.id}"></td>
                                    <td style="width: 15%">${homework.title}</td>
                                    <td style="width: 20%">${homework.content}</td>
                                    <td style="width: 10%">${homework.progress}</td>
                                    <td style="width: 15%"><fmt:formatDate value="${homework.deadline}" pattern="yyyy/MM/dd (HH시)"/></td>
                                    <td style="width: 15%">${homework.distributionDate}</td>
                                    <td style="width: 15%"><fmt:formatDate value="${homework.createdAt}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="container my-4 py-3">
                <div class="container my-1">
                    <h2>숙제를 전송 할 학습자 선택</h2>
                    <hr/>
                </div>
                <!-- 학습 그룹 선택 -->
                <div class="container my-3 py-4 d-flex justify-content-between ">
                    <div class="col-9">
                        <div class="input-group">
                            <label class="input-group-text fw-bold " for="learningGroupSelect" style="font-size: 18px;">그룹명</label>
                            <select id="learningGroupSelect" class="form-control form-select">
                                <option value="groupAll" selected>그룹 전체</option>
                                <c:forEach var="group" items="${learningGroupList}">
                                    <option value="${group.id}">${group.name}</option>
                                </c:forEach>
                            </select>
                            <!-- 학생 목록과 선택된 학생 목록 -->
                            <button id="selectAll" class="btn">전체 선택</button>
                            <button id="deselectAll" class="btn ">전체 해제</button>
                        </div>
                    </div>
                    <!-- 숙제 배포 버튼 -->

                    <button id="distributeHomework" class="btn btn-primary col-sm-2">전송하기</button>
               </div>
                <div class="d-flex justify-content-between ">
                    <div class="col-6 px-2">
                        <h3>그룹 내 학습자</h3>
                        <table id="studentList" class="table border  text-center">
                            <thead>
                            <tr>
                                <th>선택</th>
                                <th>아이디</th>
                                <th>학습자명</th>
                                <th>전화번호</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 학생 목록이 여기에 추가됩니다 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="col-6 px-2">
                        <h3>선택된 학습자</h3>
                        <table id="selectedStudents" class="table border text-center">
                        <thead>
                        <tr>
                            <th>아이디</th>
                            <th>학습자명</th>
                            <th>전화번호</th>
                            <th>제외</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 선택된 학생 목록이 여기에 추가됩니다 -->
                        </tbody>
                        </table>
                    </div>
                </div>


                <script>
                    $(document).ready(function() {
                        // 변수 정의
                        let selectedStudentsList = [];
                        const studentList = $('#studentList tbody');
                        const selectedStudents = $('#selectedStudents tbody');

                        // 함수 정의
                        function updateTables() {
                            selectedStudents.empty();
                            studentList.find('tr').each(function() {
                                const studentId = $(this).children('td').eq(1).text();
                                const checkbox = $(this).find('input[type="checkbox"]');
                                if (checkbox.prop('checked')) {
                                    if (!selectedStudentsList.includes(studentId)) {
                                        selectedStudentsList.push(studentId);
                                    }
                                    const selectedStudent = $(this).clone();
                                    selectedStudent.children('td').first().remove(); // 체크박스 제거
                                    selectedStudent.append('<td><a class="btn-remove">x</a></td>'); // 'x' 버튼 추가
                                    selectedStudents.append(selectedStudent);
                                } else {
                                    const index = selectedStudentsList.indexOf(studentId);
                                    if (index > -1) {
                                        selectedStudentsList.splice(index, 1);
                                    }
                                }
                                checkbox.prop('checked', selectedStudentsList.includes(studentId)); // 학생 목록의 체크박스 상태 업데이트
                            });
                        }

                        // 이벤트 핸들러 정의
                        $('#learningGroupSelect').change(function() {
                            const selectedGroup = $(this).val();
                            let url = "";
                            let data = {};

                            if (selectedGroup === "groupAll") {
                                url = '/group/getGroupMembersByEducatorId';
                                data = { educatorId: 1 };
                            } else {
                                url = '/group/getGroupMemberByGroupId';
                                data = { groupId: selectedGroup };
                            }

                            $.ajax({
                                url: url,
                                type: 'GET',
                                data: data,
                                success: function(data) {
                                    studentList.empty();
                                    selectedStudents.empty();
                                    $.each(data, function(index, user) {
                                        const trEl = document.createElement("tr");
                                        const checkboxCell = document.createElement("td");
                                        const checkbox = document.createElement("input");
                                        checkbox.setAttribute("type","checkbox");
                                        checkbox.className="form-check-input";
                                        checkboxCell.appendChild(checkbox);
                                        trEl.appendChild(checkboxCell);

                                        const userId = document.createElement("td");
                                        userId.innerText = user.id;
                                        trEl.appendChild(userId);

                                        const userName = document.createElement("td");
                                        userName.innerText = user.name;
                                        trEl.appendChild(userName);

                                        const userPhone = document.createElement("td");
                                        userPhone.innerText = user.phone;
                                        trEl.appendChild(userPhone);

                                        studentList.append(trEl);
                                    });
                                }
                            });
                        });

                        $('#selectedStudents').on('click', '.btn-remove', function() {
                            const studentId = $(this).closest('tr').children('td').eq(0).text(); // 'x' 버튼이 있는 행의 학생 ID
                            const index = selectedStudentsList.indexOf(studentId);
                            if (index > -1) {
                                selectedStudentsList.splice(index, 1);
                            }
                            studentList.find('tr').each(function() {
                                if ($(this).children('td').eq(1).text() === studentId) {
                                    $(this).find('input[type="checkbox"]').prop('checked', false);
                                }
                            });
                            updateTables();
                        });

                        $('#studentList').on('change', 'input[type="checkbox"]', function() {
                            updateTables();
                        });

                        $('#selectAll').click(function() {
                            studentList.find('input[type="checkbox"]').prop('checked', true);
                            updateTables();
                        });

                        $('#deselectAll').click(function() {
                            studentList.find('input[type="checkbox"]').prop('checked', false);
                            updateTables();
                        });

                        // 초기 실행 함수
                        $('#learningGroupSelect').trigger('change');
                    });
                </script>
            </div>



        </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>
