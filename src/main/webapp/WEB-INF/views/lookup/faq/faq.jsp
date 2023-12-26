
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function changePageSize() {
            var pageSize = document.getElementById("pageSize").value;
            document.cookie = "pageSize=" + pageSize;

            // Get the search type and keyword values
            var searchType = document.getElementById("searchType").value;
            var keyword = document.getElementsByName("keyword")[0].value.toLowerCase(); // 대소문자 구분 없이 검색

            // Modify the URL with case-insensitive search parameters
            location.href = "FAQBoardList?pageSize=" + pageSize + "&searchType=" + searchType + "&keyword=" + keyword;
        }
    </script>
    <style>
        .custom-select-box {
            width: 100px;
            height: 30px;
            margin-top: 30px;

        }

        .my-custom-class {
            align-items: center;
            height: 38px;
        }

        #searchType {
            width: 300px;  /* 원하는 너비로 조절하세요 */

        }
        input[name="keyword"] {
            width: 600px;  /* 원하는 너비로 조절하세요 */
            margin-left: 0px;

        }
        .col-15.my-5.d-flex.align-items-center {
            width: 1400px;
            margin-right: 0;
            margin-left: -20px;
            padding-right: 0;
        }
        .p-4 {
            width : 1600px;
            margin-left: 0;
            margin-right: 0;
        }
        .table-responsive {
            width : 1350px;
            margin-left: -50px;
        }





    </style>

    <%@ include file="/WEB-INF/components/Header.jsp"%>

    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/LookupSidebar.jsp"%>
    <div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
        <div class="container justify-content-end p-0">
            <select id="pageSize" onchange="changePageSize()" class="custom-select-box">
                <c:forEach var="size" items="${['10', '20', '30']}">
                    <c:choose>
                        <c:when test="${param.pageSize eq size or (empty param.pageSize and size eq '10')}">
                            <option value="${size}" selected>${size}개씩 보기</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${size}">${size}개씩 보기</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <form action="FAQSearch" method="get" class="container justify-content-center">
                <div class="col-15 my-5 d-flex align-items-center">
                    <label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
                    <div class="col-4">
                        <select id="searchType" name="searchType" class="form-select">
                            <option value="title" ${title ? 'selected' : ''}>제목</option>
                            <option value="content" ${content ? 'selected' : ''}>내용</option>
                            <option value="name" ${name ? 'selected' : ''}>작성자</option>
                        </select>
                    </div>
                    <div class="d-flex col-6 mx-2 my-custom-class">
                        <label>
                            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
                        </label>
                        <button type="submit" class="btn btn-primary mx-3">검색</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="container table-container p-4">
            <div class="table-responsive">
                <table id="userTable" class="table table-md text-center p-3">
                    <thead>
                    <h1>FAQ 리스트</h1>
                    <h5>총 게시글 수 : ${totalFAQboard}</h5>
                    <tr>
                        <th scope="col">순번</th>
                        <th scope="col">분류</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">등록일시</th>
                        <th scope="col">조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="num" value="${page.start}"/>
                    <c:forEach var="FAQ" items="${listFAQBoard}" varStatus="st">
                        <tr id="FAQ${st.index}">
                            <td><input type="hidden" value="${FAQ.id}" id="id${st.index}">${num}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${FAQ.boardType == 1}">공지</c:when>
                                    <c:when test="${FAQ.boardType == 2}">FAQ</c:when>
                                    <c:when test="${FAQ.boardType == 3}">QnA</c:when>
                                </c:choose>
                            </td>
                            <td><a href="FAQDetail?id=${FAQ.id}">${FAQ.title}</a></td>
                            <td>${FAQ.name}</td>
                            <td><fmt:formatDate value="${FAQ.createdAt}" type="date" pattern="YY/MM/dd"/></td>
                            <td>${FAQ.readCount}</td>

                        </tr>
                        <c:set var="num" value="${num + 1}"/>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <c:choose>
                    <c:when test="${path ==0}">
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="FAQBoardList?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="FAQBoardList?pageSize=${pageSize}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="FAQBoardList?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="FAQSearch?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="FAQSearch?pageSize=${pageSize}&currentPage=${i}&searchType=${param.searchType}&keyword=${param.keyword}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="FAQSearch?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
