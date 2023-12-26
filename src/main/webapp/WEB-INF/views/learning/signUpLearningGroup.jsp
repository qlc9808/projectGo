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
        .slg-search {
            background: rgba(50,111,232,0.78);
            color: white;
            border-radius: 3px;
            height: 25px;

        }
        .slg-select-box {
            margin-bottom: 10px;
        }
        .tui-ico-next, .tui-ico-last, .tui-ico-prev, .tui-ico-prev, .tui-ico-first {
            position: relative;
            top: 7px;
        }
        .tui-pagination .tui-is-selected, .tui-pagination strong {

            background: #0C4DA2;
        }
        .tui-pagination .tui-is-selected:hover, .tui-pagination strong:hover {
            background: #0C4DA2;
            color: white;
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

                <c:if test="${users.userType != '3'}">
                    <h1 style="text-align: center; font-weight: bold;">학습그룹 가입신청</h1>
                    <div class="container my-4 py-3" style="width: 1190px;">
                </c:if>
                <c:if test="${users.userType == '3'}">
                    <h1 style="text-align: center; font-weight: bold;">학습그룹 가입신청</h1>
                    <div class="container my-4 py-3" style="width: 1273px;">
                </c:if>
                        <div class="slg-select-box">
                            <select id="slg-select">
                                <option>그룹명</option>
                                <option>교육자명</option>
                            </select>
                            ㅡ
                            <select id="slg-selected">
                                <option></option>
                            </select>
                            <button onclick="slgsearch(document.getElementById('slg-selected').value, document.getElementById('slg-select').value)" class="slg-search">조회하기</button>

                        </div>
                        <div id="grid1"></div>
                <c:if test="${users.userType == '3'}">
                    </div>
                </c:if>
                <c:if test="${users.userType != '3'}">
                    </div>
                </c:if>
            </div>
        </div>
    </main>
        <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script src="/js/learning/signUpLearningGroup.js"></script>

</body>
</html>
