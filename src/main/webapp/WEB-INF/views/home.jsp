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
        .carousel-item {
            height: 350px;
        }

        .carousel-item img {
            position: absolute;
            top: 0;
            left: 0;
            min-height: 350px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="container px-5">
            <div id="carouselExampleDark" class="carousel carousel-dark slide px-5">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-bs-interval="10000">
                        <img src="https://file.tygem.com/updata/ckimages/20219/92023846x298.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item" data-bs-interval="2000">
                        <img src="https://mgameimage.gscdn.com/mgamezzang/games/baduk_2009/lecture/091215_banner_2.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="http://file.tygem.com/updata/ckimages/20218/155327201.jpg" class="d-block w-100" alt="...">
                        </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <div class="d-flex">

            <div id="main-content" class="container px-5 ">
                <%-- 이곳에 작성을 해주세요 --%>
                <h1>HOME</h1>
                <div class="container_top">
                    <div class="box">- 공지사항 </div>
                    <div class="box">- 인기게임 튜토리얼 영상</div>
                </div>
                <div class="container_middle">
                    <div class="box">- 우수 학습그룹<br>- 이달의 우수 학습자(숙제 제출시 많이 제출하고 평가가 좋게나온 사람)</div>
                    <div class="box">- 이달의 우수 학습자(숙제 제출시 많이 제출하고 평가가 좋게나온 사람)</div>
                </div>
            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
