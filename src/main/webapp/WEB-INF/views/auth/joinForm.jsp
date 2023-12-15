<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-12-07
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
        });

        function updateBirthday() {
            const yearSelect = document.getElementById("year");
            const monthSelect = document.getElementById("month");
            const daySelect = document.getElementById("day");


            const year = yearSelect.value;
            const month = monthSelect.value.padStart(2, '0');
            const day = daySelect.value.padStart(2, '0');
            const birthdate = year + month + day;
            document.getElementById("birthdate").value = birthdate;
        }

        function checkSubmitHandler(event) {
            // 필요한 입력 필드 가져오기
            const email = document.getElementById("email");
            const pw = document.getElementById("password");
            const pw2 = document.getElementById("passwordCheck");
            const name = document.getElementById("name");
            const nickname = document.getElementById("nickname");
            const phone = document.getElementById("phone");
            // 추가 필요한 필드...


            // 닉네임이 제공되었는지 확인
            if (nickname.value === "") {
                alert("닉네임을 입력해주세요.");
                event.preventDefault();
                return false;
            }

            // 패스워드가 제공되었는지 확인
            if (pw.value === "") {
                alert("패스워드를 입력해주세요.");
                event.preventDefault();
                return false;
            }
            // 패스워드 확인이 제공되었는지 확인
            if (pw2.value === "") {
                alert("패스워드 확인을 입력해주세요.");
                event.preventDefault();
                return false;
            }

            // 패스워드와 패스워드 확인이 일치하는지 확인
            if (pw.value !== pw2.value) {
                alert("패스워드가 일치하지 않습니다.");
                event.preventDefault();
                return false;
            }


            // 사용자명이 제공되었는지 확인
            if (name.value === "") {
                alert("사용자명을 입력해주세요.");
                event.preventDefault();
                return false;
            }

            // 이메일이 제공되었는지 확인
            if (email.value === "") {
                alert("이메일을 입력해주세요.");
                event.preventDefault();
                return false;
            }

            // 핸드폰번호가 제공되었는지 확인
            if (phone.value === "") {
                alert("핸드폰번호를 입력해주세요.");
                event.preventDefault();
                return false;
            }

        }

        function submitForm(event) {
            updateBirthday();
            checkSubmitHandler(event)
        }

        function fn_nickCheck(){
            event.preventDefault()
            const data = {"nickname" : $("#nickname").val()}
            console.log(data);
            $.ajax({
                url : "/nickCheck",
                type : "POST",
                dataType: "json",
                data: $("#nickname").val(),
                contentType: 'application/json',
                success : function (data){
                    if (data == 1){
                        alert("중복된 닉네임입니다");
                    } else if (data == 0 ){
                        alert("사용 가능한 닉네임 입니다")
                    }
                }
            })
        }

    </script>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
    <div id="main-content">
        <div class="my-5">
            <div class="" id="detail-main-container">

                <div class="container p-5" id="form-container">
                    <form action="/signUp" method="post">
                        <input type="text" id="birthdate" name="birthdate" style="display: none;">

                        <label for="nickname" class="form-label col-2">아이디</label>
                        <div class="mb-3 d-flex">
                            <div class="col-10">
                                <input type="text" class="form-control" name="nickname" id="nickname" required="required">
                                <button type="button" class="btn btn-primary w-100" onclick="fn_nickCheck();">중복 확인</button>
                            </div>
                        </div>


                        <div class="mb-3 ">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" name="password" id="password" required="required">
                        </div>
                        <div class="mb-3 ">
                            <label for="passwordCheck" class="form-label">비밀번호확인</label>
                            <input type="password" class="form-control" name="passwordCheck" id="passwordCheck" required="required">
                        </div>
                        <div class="mb-3 ">
                            <label for="name" class="form-label">이름</label>
                            <input type="text" class="form-control" name="name" id="name" required="required">
                        </div>
                        <div class="my-4 row align-items-center ">
                            <label class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">생년월일<SUP
                                    style="color: #FF4379; font-size: 18px;">*</SUP></label>
                            <div class="col-sm-8 d-flex align-items-center">
                                <div class="col-4"	>
                                    <select class="form-select text-center" id="year" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="birthday-text">년</span>
                                <div class="col-3"	>
                                    <select class="form-select text-center" id="month" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="birthday-text">월</span>
                                <div class="col-3 "	>
                                    <select class="form-select text-center" id="day" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                                <span class="birthday-text">일</span>
                            </div>
                        </div>

                        <div class="mb-3 ">
                            <label for="email" class="form-label">email</label>
                            <input type="text" class="form-control" name="email" id="email">
                        </div>
                        <div class="mb-3 ">
                            <label for="userType" class="form-label">회원구분</label>
                            <select class="form-control" name="userType" id="userType">
                                <option value="1">관리자</option>
                                <option value="2">교육자</option>
                                <option value="3">학습자</option>
                                <option value="4">일반인</option>
                            </select>
                        </div>
                        <div class="my-4 row align-items-baseline ">
                            <label class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">성별<SUP
                                    style="color: #FF4379; font-size: 18px;">*</SUP></label>
                            <div class="col-sm-8 d-flex">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" id="male"
                                           value="0" checked> <label class="form-check-label" for="male">남자</label>
                                </div>
                                <div class="col-1"></div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" id="female"
                                           value="1" > <label class="form-check-label" for="female">여자</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3 ">
                            <label for="address" class="form-label">주소</label>
                            <input type="text" class="form-control" name="address" id="address">
                        </div>
                        <div class="mb-3 ">
                            <label for="phone" class="form-label">전화번호</label>
                            <input type="text" class="form-control" name="phone" id="phone">
                        </div>

                        <div class="col-12 d-flex justify-content-between">
                            <div class="col-8 form-check">
                                <label class="form-check-label">이벤트, 커리큘럼, 신규컨텐츠 등 광고 메세지 수신</label>
                            </div>
                            <div class="col-2 form-check">
                                <input class="form-check-input" type="radio" name="consent1"
                                       id="consent1" value="1" >
                                <label class="form-check-label" for="consent1">이메일</label>
                            </div>
                            <div class="col-2 form-check">
                                <input class="form-check-input" type="radio" name="consent2"
                                       id="consent2" value="1" >
                                <label class="form-check-label" for="consent2">SMS</label>
                            </div>
                        </div>



                        <hr class="hr" />



                        <div class="d-flex justify-content-between">
                            <div class="col-6 mb-3" >
                                <button type="submit" class="form-control btn btn-primary w-100" onclick="submitForm(event);">등록</button>
                            </div>
                            <div class="col-3 mb-3">
                                <button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
                            </div>
                            <div class="col-2 mb-3">
                                <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='/login'">취소</button>
                            </div>
                        </div>



                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>