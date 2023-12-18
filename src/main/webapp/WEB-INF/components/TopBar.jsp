<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2023-12-05
  Time: 오후 4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header id="topbar" class="app-navbar fixed-top" >
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <a class="navbar-brand" href="/">
                <img src="/asset/logo.png" height="70" alt="Logo">
            </a>
        </div>
        <div>
            <h1>게임으로 배우는 바둑 교실</h1>
        </div>
        <div>
            <%
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if ((auth != null && auth.isAuthenticated()) == false){
            %>

            <a href="/logout">로그아웃 </a>

            <%
            } else {
            %>

            <a href="/login">로그인  </a>

            <%
                }
            %>

        </div>

    </div>

    <div class="d-flex justify-content-center align-items-center">
        <nav class="navbar  navbar-expand-md navbar-light  justify-content-between ">
            <div class="container d-flex justify-content-between ">
                <div>
                    <button class="navbar-toggler" type="button"
                            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse justify-content-center " id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link app-nav-link" href="/festival">이용안내</a></li>
                        <li class="nav-item"><a class="nav-link app-nav-link" href="/subscribe/subscribeView">구독서비스</a></li>
                        <li class="nav-item"><a class="nav-link app-nav-link" href="/learning/signUpLearningGroup">학습서비스</a></li>
                        <li class="nav-item"><a class="nav-link app-nav-link" href="/group/listLearningContent">교육자마당</a></li>
                        <li class="nav-item"><a class="nav-link app-nav-link" href="/game/gameContentSelect">운영마당</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

</header>
