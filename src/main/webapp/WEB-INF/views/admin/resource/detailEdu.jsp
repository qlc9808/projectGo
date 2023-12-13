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
                <h1>detailEdu 왔다</h1>
                <button onclick="eduList()">목록</button>
                <button onclick="eduUpdate(${id})">수정</button>
                <button onclick="eduDelete(${id})">삭제</button>

            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script>
        function eduList() {
            window.location.href = '/admin/resource/listEdu';
        }
        function eduUpdate(id) {
            window.location.href = '/admin/resource/updateEduForm?id='+id;
        }
        function eduDelete(id) {

            var isConfirmed = confirm("정말로 삭제하시겠습니까?");
            if (isConfirmed) {
                console.log("아작스 실행전");
                $.ajax({
                    url: '/admin/resource/deleteEdu',
                    method: 'DELETE',
                    data: {
                        id: id
                    },
                    success: function (response) {
                        if (response.result > 0) {
                            alert("교육자료 삭제성공!");
                            window.location.href = '/admin/resource/listEdu';
                        } else {
                            alert("교육자료 삭제실패..");
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            } else {
                return null;
            }
        }
    </script>
</body>
</html>
