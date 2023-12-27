<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-12-15
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

    var isEmailchecked = false;

    function fn_nickCheck(){
        const email = $("#email").val();
        const data = {"email" : email}
        console.log(data);
        $.ajax({
            url : "/emailCheck",
            type : "POST",
            dataType: "json",
            data: email,
            contentType: 'application/json',
            success : function (data){
                if (data == 1){
                    alert("중복된 email입니다");
                } else if (data == 0 ){
                    isEmailchecked = true;  // 중복 체크 완료
                    alert("사용 가능한 email 입니다")
                }
            }
        })
    }

    function fn_register() {
        if (!isEmailchecked) {
            alert("email 중복 확인을 해주세요.");
            event.preventDefault()
            return;
        } else{

        }

    }
</script>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="container col-4 justify-content-start border mt-3 p-5">
        <form action="/emailAuth" method="post">
            <div class="mt-5 mb-5">
                <div class="justify-content-center pt-3 pb-3" align="center">
                    <h1>이메일 인증 </h1>
                </div>
                <div class="justify-content-center pb-1" align="center">
                    <p>입력하신 EMAIL로 인증번호를 보냅니다</p>
                </div>
                <hr>
                <div class="justify-content-start pb-3">
                    <label for="name" class="form-label mb-2">이름</label>
                    <input type="text" class="form-control" name="name" id ="name" required>
                </div>

                <div class="justify-content-start pb-3">
                    <label for="email" class="form-label mb-2">Email</label>
                    <input type="text" class="form-control" name="email" id ="email" required>
                </div>
                <div class="col-lm-2">
                    <button type="button" class="btn btn-primary w-100" onclick="fn_nickCheck()">중복 확인</button>
                </div>
                <div>
                <div class="justify-content-center pt-3 pb-3" align="center">
                    <button type="submit" class="btn btn-primary" onclick="fn_register()">다음</button>
                    <button type="reset" class="btn btn-primary" onclick="">초기화</button>
                    <button type="button" class="btn btn-primary" onclick="window.history.back()">취소</button>
                </div>
                </div>
            </div>
        </form>
    </div>
</main>

</body>
</html>
