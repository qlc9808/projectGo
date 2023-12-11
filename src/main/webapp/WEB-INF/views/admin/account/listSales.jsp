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
    .search-form {
        border: 1px solid black;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 50px;
        margin-bottom: 20px;
        margin-top: 50px;
        border-radius: 16px;
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
                <div class="search-form">
                    기간조회:&nbsp;&nbsp;
                    <input type="date" name="keyword" id="keywordDate1" style="border-radius: 5px;">&nbsp;-&nbsp;
                    <input type="date" name="keyword" id="keywordDate2" style="margin-right: 200px; border-radius: 5px;">

                    검색:&nbsp;&nbsp;
                    <select id="searchType">
                        <option value="content" selected="selected">결제한컨텐츠</option>
                        <option value="user">결제회원</option>
                    </select>
                    <input type="text" name="keyword" id="keyword" style="border-radius: 5px;">
                    <button id="btnSearch2" onclick="search()" style="border-radius: 5px;">조회</button>
                </div>
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
