<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<link rel="stylesheet" href="/css/edu/detailEdu.css?after">
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-2">
                <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
            </div>
            <div id="main-content" class="container p-5 col-10">
                <h1 style="text-align: center;">detailEdu 왔다</h1>
                <div class="container border my-4 py-3">
                    <div class="detailEdu-header">
                        <div class="detailEdu-title">
                            <span class="title">${edu.title}</span>
                        </div>
                        <div class="detailEdu-object">
                            <button onclick="eduList()">목록</button>
                            <button onclick="eduUpdate(${id})">수정</button>
                            <button onclick="eduDelete(${id})">삭제</button>
                        </div>
                    </div>
                    <div class="detailEdu-body">
                        <div class="detailEdu-source">
                            <iframe width="888" height="480" src="https://www.youtube.com/embed/bxhNCYw3shY" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                        </div>
                        <br>
                        <div class="detailEdu-textarea">
                            <span class="contents">${edu.content}</span>
                        </div>


                    </div>

                </div>
            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script src="/js/admin/edu/detailEdu.js"></script>
</body>
</html>
