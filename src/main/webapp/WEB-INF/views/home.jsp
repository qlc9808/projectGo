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
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-2">
                <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
            </div>
            <div id="main-content" class="container p-5 col-10">
                <%-- 이곳에 작성을 해주세요 --%>
                    <h1>HOME</h1>

            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
