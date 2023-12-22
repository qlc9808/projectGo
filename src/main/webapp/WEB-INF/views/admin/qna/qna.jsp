
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function changePageSize() {
            var pageSize = document.getElementById("pageSize").value;
            document.cookie = "pageSize=" + pageSize;
            location.href = "QNABoardList?pageSize=" + pageSize; // 현재 URL을 수정해야 합니다.
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



    </style>

    <%@ include file="/WEB-INF/components/Header.jsp"%>

    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
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
            <form action="QNASearch" method="get" class="container justify-content-center">
                <div class="col-15 my-5 d-flex align-items-center">
                    <label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
                    <div class="col-4">
                        <select id="searchType" name="searchType" class="form-select">
                            <option value="title" ${title ? 'selected' : ''}>제목</option>
                            <option value="content" ${content ? 'selected' : ''}>내용</option>
                            <option value="userId" ${userId ? 'selected' : ''}>작성자</option>
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
            <div class="container justify-content-end p-0">
                <button style="float: right; margin-right: 12px;" id="regist-btn" type="button" class="btn btn-primary mb-4" onclick="location.href='QNAInsertForm'">등록</button>
            </div>
        </div>
        <div class="container table-container p-4">
            <div class="table-responsive">
                <table id="userTable" class="table table-md text-center p-3">
                    <thead>
                    <h1>QNA 리스트</h1>
                    <h3>총 게시글 수 : ${totalQNAboard}</h3>
                    <tr>
                        <th scope="col">순번</th>
                        <th scope="col">분류</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">등록일시</th>
                        <th scope="col">조회수</th>
                        <th scope="col">답변여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="num" value="${page.start}"/>
                    <c:forEach var="QNA" items="${listQNABoard}" varStatus="st">
                        <tr id="QNA${st.index}">
                            <td><input type="hidden" value="${QNA.id}" id="id${st.index}">${num}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${QNA.boardType == 1}">공지</c:when>
                                    <c:when test="${QNA.boardType == 2}">FAQ</c:when>
                                    <c:when test="${QNA.boardType == 3}">QnA</c:when>
                                </c:choose>
                            </td>
                            <td><a href="QNADetail?id=${QNA.id}">${QNA.title}</a></td>
                            <td>${QNA.userId}</td>
                            <td><fmt:formatDate value="${QNA.createdAt}" type="date" pattern="YY/MM/dd"/></td>
                            <td>${QNA.readCount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${QNA.commentCount >= 1}">답변 완료</c:when>
                                    <c:otherwise>답변 대기</c:otherwise>
                                </c:choose>
                            </td>

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
                                <a href="QNABoardList?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="QNABoardList?pageSize=${pageSize}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="QNABoardList?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="QNASearch?pageSize=${pageSize}&currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="QNASearch?pageSize=${pageSize}&currentPage=${i}&searchType=${param.searchType}&keyword=${param.keyword}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="QNAeSearch?pageSize=${pageSize}&currentPage=${page.startPage+page.pageBlock}"
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
