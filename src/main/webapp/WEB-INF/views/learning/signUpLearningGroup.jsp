<%--
  Created by IntelliJ IDEA.
  User: gyuco
  Date: 2023-12-05
  Time: 오후 2:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
    <style>
        .d-flex {
            margin: auto;
        }
        #main-content {
            border: 0px solid red;
            margin: auto auto auto 100px;
        }
        .myButton:hover {
            background-color: rgba(90, 90, 255, 0.78); /* 배경색을 좀 더 밝은 파란색으로 변경 */
            border: 0px solid white; /* 테두리를 흰색으로 강조 */
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-2">
                <%@ include file="/WEB-INF/components/LearningSidebar.jsp"%>
            </div>
            <div id="main-content" class="container p-5 col-10">
                <h1 style="text-align: center; font-weight: bold;">학습그룹 가입신청</h1>
                <div class="container my-4 py-3">
                    <div id="grid1" style="width: 1200px; height: 1000px;"></div>
                </div>
            </div>
        </div>
    </main>
        <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script src="/js/learning/signUpLearningGroup.js"></script>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</body>
</html>
