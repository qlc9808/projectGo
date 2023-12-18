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
            margin: auto auto auto 350px;
        }
        .searchForm {
            width: 1200px;
            border: 0px solid red;
            height: 100px;
        }
        .objectForm {
            width: 1200px;
            border: 0px solid red;
            height: 20px;
            display: flex;
            align-items: end;
            justify-content: end;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-second">
                <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
            </div>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <h1 style="text-align: center;">교육자료</h1>
            <div class="container border my-4 py-3" style="overflow: auto;">
                <div class="searchForm">


                </div>
                <div class="objectForm">
                    <button style="margin: 10px;" onclick="uploadEdu()">교육자료등록</button>

                </div>
                <div id="grid1"></div>
            </div>

        </div>
    </main>
        <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script src="/js/admin/educationalList.js"></script>
    <script>
        function uploadEdu() {
            window.location.href = '/admin/resource/uploadForm';
        }
        var contextPath = "${pageContext.request.contextPath}";
    </script>


</body>
</html>
