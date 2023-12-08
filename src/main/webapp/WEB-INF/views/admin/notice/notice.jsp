<%--
  Created by IntelliJ IDEA.
  User: gyuco
  Date: 2023-12-05
  Time: 오후 2:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        <div id="main-content">
            <h2>Notice Board List</h2>

            <table border="1">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Content</th>
                    <th>Author</th>
                    <th>Created At</th>
                    <th>Updated At</th>
                    <th>Read Count</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="board" items="${board}">
                    <tr>
                        <td>${board.id}</td>
                        <td>${board.title}</td>
                        <td>${board.content}</td>
                        <td>${board.userId}</td>
                        <td>${board.createdAt}</td>
                        <td>${board.updatedAt}</td>
                        <td>${board.readCount}</td>
                        <td>${board.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <c:choose>
                    <c:when test="${path ==0}">
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="admin/noticeBoardList?currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="admin/noticeBoardList?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="admin/noticeBoardList?currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="IndexnoticeSearch?currentPage=${page.startPage-page.pageBlock}"
                                   class="pageblock page-link">[이전]</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="IndexnoticeSearch?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&area=${area}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="IndexnoticeSearch?currentPage=${page.startPage+page.pageBlock}"
                                   class="pageblock page-link">[다음]</a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
