<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    th, td { text-align: center; }
</style>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        </div>


    <div class="container col-9 mt-5">
        <form action="userList" method="POST" class="container">

            <!-- 기간 -->
    <div class="col-12 my-4 d-flex ">
        <label for="searchType" class="col-form-label col-2">가입기간</label>
        <div class="col-10 d-flex">
            <div class="col-10 d-flex">
                <input type="date" class="mx-2" id="startDatePicker" name="startDate" value="${startDate}">
                <input type="date" class="mx-2" id="endDatePicker" name="endDate" value="${endDate}">
            </div>
        </div>
    </div>
    <div class="col-12 my-4 d-flex">
        <label for="searchType" class="col-form-label col-2">검색어</label>
        <div class="col-4 mx-2">
            <select id="searchType" name="searchType" class="form-select">
                <option selected value="name">사용자 이름</option>
                <option value="email">이메일</option>
                <option value="nickname">닉네임</option>
            </select>
        </div>
        <div class="col-4 mx-2">
            <input type="text" name="keyword" class="form-control" value="${keyword}">
        </div>
    </div>


    <!-- 옵션 -->
    <div class="col-12 my-4 d-flex">
        <label for="searchType" class="col-form-label col-2">구분</label>
    <div class="col-2 d-flex ">

            <select class="form-select mx-2" id="userType" name="userType">
                <option value="" selected>전체 회원</option>
                <option value="1">관리자</option>
                <option value="2">교육자</option>
                <option value="3">학습자</option>
                <option value="4">일반인</option>
            </select>
    </div>
        <label for="searchType" class="col-form-label col-1" style="margin-left: 40px;">자격</label>
    <div class="col-2 d-flex ">

            <select class="form-select mx-2" id="" name="">
                <option value="" selected>전체 회원</option>
                <option value="0">무료회원</option>
                <option value="1">유료회원</option>
            </select>
    </div>
    </div>
    <div class="container col-10 d-flex justify-content-center">
        <button type="submit" class="btn btn-outline-secondary col-2 mx-3">검색</button>
        <button type="reset" class="btn btn-outline-secondary col-2 mx-3">초기화</button>
    </div>
    </form>
    </div>
    </div>

    <div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
        <div class="container table-container p-4">
            <div class="table-responsive">
                <table id="userTable" class="table table-md text-center p-3">
                    <thead>
                    <tr>
                        <th scope="col">구분</th>
                        <th scope="col">이름</th>
                        <th scope="col">아이디</th>
                        <th scope="col">연락처</th>
                        <th scope="col">이메일</th>
                        <th scope="col">자격</th>
                        <th scope="col">가입일자</th>
                        <th scope="col">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="num" value="${page.start}"/>
                    <c:forEach var="user" items="${listUsers}" varStatus="st">
                        <tr id="user${st.index}">

                            <td>
                                <c:choose>
                                    <c:when test="${user.userType == 1}">
                                        관리자
                                    </c:when>
                                    <c:when test="${user.userType == 2}">
                                        교육자
                                    </c:when>
                                    <c:when test="${user.userType == 3}">
                                        학습자
                                    </c:when>
                                    <c:when test="${user.userType == 4}">
                                        일반인
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>${user.name}</td>
                            <td>${user.nickname}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.qualification == 0}">
                                        무료회원
                                    </c:when>
                                    <c:when test="${user.qualification == 1}">
                                        유료회원
                                    </c:when>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${user.createdAt}" type="date" pattern="YY/MM/dd"/></td>
                            <td><a class="detail-btn" href="userDetail/${user.id}?currentPage=${page.currentPage}">관리</a></td>
                        </tr>
                        <c:set var="num" value="${num + 1}"/>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <nav aria-label="Page navigation example ">
        <ul class="pagination">
            <c:if test="${page.startPage > page.pageBlock}">
                <li class="page-item">
                    <a href="userList?currentPage=${page.startPage-page.pageBlock}&searchType=${searchType}&keyword=${keyword}"
                       class="pageblock page-link">Prev</a>
                </li>
            </c:if>
            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                <li class="page-item">
                    <a href="userList?currentPage=${i}&searchType=${searchType}&keyword=${keyword}"
                       class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${page.endPage < page.totalPage}">
                <li class="page-item">
                    <a href="userList?currentPage=${page.startPage+page.pageBlock}&searchType=${searchType}&keyword=${keyword}"
                       class="pageblock page-link">Next</a>
                </li>
            </c:if>
        </ul>
    </nav>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
