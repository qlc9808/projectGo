<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    .d-flex {
        margin: auto;
    }
    #main-content {
         border: 0px solid red;
         margin-left: 280px;
    }
</style>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-second">
                <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
            </div>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <h1 style="text-align: center;">매출 정보 조회(관리자입장)</h1>
            <div id="search" style="display: flex; align-items: end; justify-content: end;">
                <input type="text">
                <button id="btnSearch">search</button>
            </div>
            <div id="grid1"></div>
            <div></div>
            <div id="chart-area"></div>
        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

    <script src="/js/admin/sales.js"></script>

</body>
</html>
