<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
    <script>
        if (window.location.search.includes('error')) {
            alert('접근할 수 없는 페이지입니다.');
        }
    </script>
    <style>
        .box {
            width: 46%;
            border: solid 1px;
            height: 100px;
            margin: 20px;
            padding: 12px;
        }

        .notify_box{
            width: 100%;
            border: solid 1px;
            height: 100px;
            margin: 20px;
            padding: 12px;
        }

        .container_notify {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
            width: 100%;
        }

        .container_top {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
        }

        .container_middle {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
        }

        .container_bottom {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
        }
    </style>
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
                    <div class="container_notify">
                        <div class="notify_box">- 이용가이드(필수)<br>- 공지사항(필수)<br>- 인기 게시글</div>
                    </div>
                    <div class="container_top">
                        <div class="box">- 이벤트, 광고 등</div>
                        <div class="box">- 인기게임 튜토리얼 영상</div>
                    </div>
                    <div class="container_middle">
                        <div class="box">- 우수 학습그룹<br>- 이달의 우수 학습자(숙제 제출시 많이 제출하고 평가가 좋게나온 사람)</div>
                        <div class="box">- 이달의 우수 학습자(숙제 제출시 많이 제출하고 평가가 좋게나온 사람)</div>
                    </div>
                    <div class="container_bottom">
                        <div class="box">- 신규게임<br>- 인기게임 튜토리얼 영상</div>
                        <div class="box">- 인기게임(매출기준)<br>- 이달의 게임(이번달 매출기준)<br>- 금주의 게임(이번주 매출기준)</div>
                    </div>

            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
