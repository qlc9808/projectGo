
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function changePageSize() {
            var pageSize = document.getElementById("pageSize").value;
            document.cookie = "pageSize=" + pageSize;
            location.href = "noticeBoardList?pageSize=" + pageSize; // 현재 URL을 수정해야 합니다.
        }
    </script>

    <%@ include file="/WEB-INF/components/Header.jsp"%>

    <title>noticeList</title>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        <div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
            <div class="container d-flex justify-content-end p-0">
                <select id="pageSize" onchange="changePageSize()">
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
                <form action="noticeSearch" method="get" class="container justify-content-center">
                    <div class="col-12 my-4 d-flex align-items-center">
                        <label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
                        <div class="col-4">
                            <select id="searchType" name="searchType" class="form-select">
                                <option value="title" ${title ? 'selected' : ''}>제목</option>
                                <option value="content" ${content ? 'selected' : ''}>내용</option>
                                <option value="userId" ${userId ? 'selected' : ''}>작성자</option>
                            </select>
                        </div>
                        <div class="col-5 mx-2">
                            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
                        </div>
                    </div>
                    <button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='noticeInsertForm'">등록</button>
                </form>
            </div>
            <div class="container table-container p-4">
                <div class="table-responsive">
                    <table id="userTable" class="table table-md text-center p-3">
                        <thead>
                        <h1>공지 리스트</h1>
                        <h3>총 게시글 수 : ${totalnoticeboard}</h3>
                        <tr>
                            <th scope="col">순번</th>
                            <th scope="col">분류</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일시</th>
                            <th scope="col">조회수</th>
                            <th scope="col">댓글수</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:set var="num" value="${page.start}"/>
                        <c:forEach var="notice" items="${listnoticeBoard}" varStatus="st">
                            <tr id="notice${st.index}">
                                <td><input type="hidden" value="${notice.id}" id="id${st.index}">${num}</td>
                                <td>
                                <c:choose>
                                    <c:when test="${notice.boardType == 1}">공지</c:when>
                                    <c:when test="${notice.boardType == 2}">FAQ</c:when>
                                    <c:when test="${notice.boardType == 3}">QnA</c:when>
                                </c:choose>
                                </td>
                                <td><a href="noticeDetail?id=${notice.id}">${notice.title}</a></td>
                                <td>${notice.userId}</td>
                                <td><fmt:formatDate value="${notice.createdAt}" type="date" pattern="YY/MM/dd"/></td>
                                <td>${notice.readCount}</td>
                                <td>${notice.commentStep}</td>

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
                                <a href="noticeBoardList?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="noticeBoardList?pageSize=${pageSize}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="noticeBoardList?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="noticeSearch?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="noticeSearch?pageSize=${pageSize}&currentPage=${i}&keyword=${keyword}&title=${title}&content=${content}&userId=${userId}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="noticeSearch?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
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
