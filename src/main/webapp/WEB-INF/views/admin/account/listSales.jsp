<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    #main-content {
        border: 0px solid red;
        margin: 60px auto auto 550px;
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
    #chart-area {
        width: 1200px;
        height: 700px;
    }
    .btnSaleSearch {
        border-radius: 3px;
        background: rgba(50,111,232,0.78);
        color: white;
    }
    .btnSaleSearch:hover {
        opacity: 0.8; transition: 0.2s;
    }
    .ls-object input {
        border: 0px solid black;
        width: 120px;
        text-align: end;
    }
    .ls-object input[type="radio"] {
        width: 50px;
    }
</style>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-second">
                <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
            </div>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <h1 style="text-align: center; font-weight: bold;">매출 정보 조회</h1>
            <div class="container border my-4 py-3">
                <div id="search" style="display: flex; align-items: end; justify-content: end;">
                    <div class="search-form">
                        조회기간:&nbsp;&nbsp;
                        <input type="date" name="keyword" id="keywordDate1" style="border-radius: 5px;">&nbsp;-&nbsp;
                        <input type="date" name="keyword" id="keywordDate2" style="margin-right: 100px; border-radius: 5px;">

                        검색필터:&nbsp;&nbsp;
                        <select id="searchType" style="margin-right: 100px;">
                            <option value="content" selected="selected">게임</option>
                            <option value="user">이름</option>
                        </select>

                        검색:&nbsp;&nbsp;
                        <input type="text" name="keyword" id="keyword" style="border-radius: 3px;">
                        <button class="btnSaleSearch" id="btnSearch2" onclick="search()">조회</button>
                    </div>
                </div>
                <div class="ls-object">
                    <h5>총 매출액 : <input type="text" id="total-discountPrice" readonly>원
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        건수 : <input type="text" id="totalCount" readonly>회
                    </h5>
                </div>
                <div id="grid1" style="width: 1200px;"></div>
                <hr>
                <h5 style="text-align: center;">
                    <input type="radio" id="salesMonth" name="charts-selector"><label for="salesMonth">월간 내역</label>
                    <input type="radio" id="salesDays" name="charts-selector"><label for="salesDays">일간 내역</label>
                    <br>
                    <select id="selectOption">
                        <option>선택</option>
                    </select>
                </h5>
                <div id="chart-area"></div>
            </div>

        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>

    <script src="/js/admin/sales.js"></script>

</body>
</html>
