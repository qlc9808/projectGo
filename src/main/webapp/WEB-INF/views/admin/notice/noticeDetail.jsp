<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
        <style>
    main {
    padding: 20px;
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    }
    </style>
    <title>Title</title>
</head>
<body>

<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/Sidebar.jsp"%>

<form action="noticeUpdate" method="post">

    <h1>${board.title}</h1>
    <p>작성자ID : ${board.userId}</p>
    <p>작성일: ${board.createdAt}</p>
    <p>조회수: ${board.readCount}</p>
    <p>${board.content}</p>
    <a href="${fileAddress}" download>Download file</a>

    <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='/admin/board/noticeUpdateForm?id=${board.id}&currentPage=${currentPage}'">수정하기</button>
    <a href="#" onclick="deleteNotice('${board.id}', '${currentPage}')">삭제</a>
</form>

<!-- 댓글 출력 -->
<c:choose>
    <c:when test="${board.boardType eq 1 }">
        <div class="container p-3 comment-custom">
            <div class="row row-cols-1 align-items-start">

                <div class="col">
                    <!-- input 영역 -->
                    <div class="container p-0">
                        <form action="commentInsert" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${board.id }">
                            <!-- 사용자 ID 대신 고정 값인 1 사용 -->
                            <input type="hidden" name="userId" value="1">
                            <input type="hidden" name="commentGroupId" value="${board.id}">
                            <input type="hidden" name="commentStep" value="${board.commentStep }">
                            <input type="hidden" name="commentIndent" value="${board.commentIndent }">

                            <div class="form-group col comment-input">
                                <input type="text" class="form-control" name="content" placeholder="댓글을 입력하세요.">
                            </div>

                            <div class="form-group col comment-btn">
                                <c:choose>
                                    <c:when test="${board.userId != 0 }">
                                        <button type="submit" class="btn btn_detail_custom">등록</button>
                                    </c:when>
                                </c:choose>
                            </div>
                        </form>
                        <!-- input 영역 END -->
                    </div>

                    <!-- 대댓글 출력  -->
                    <div class="container p-3 comments-custom">
                        <c:forEach var="comments" items="${comments }">
                            <div class="row row-cols-2 align-items-start">
                                <div class="col comments-nickname">
                                    <p>${comments.id }</p>
                                </div>

                                <div class="col comments-content">
                                    <p class="d-inline-flex gap-1">
                                        <c:forEach begin="2" end="${comments.commentIndent }">└▶</c:forEach>
                                        <button class="btn" type="button" data-bs-toggle="collapse"
                                                data-bs-target="#collapseExample${comments.id}"
                                                aria-expanded="false" aria-controls="collapseExample"
                                                style="width: 900px; text-align: left;">
                                                ${comments.content }</button>

                                    </p>
                                    <span class="blink" style="font-size: 16px; font-weight: bold; color: #FF4379; margin-left: -740px; margin-top: 6px;">new</span>
                                </div>
                                <c:choose>
                                    <c:when test="${board.userId != 0 }">
                                        <div class="collapse comments-collapse-custom" id="collapseExample${comments.id}">
                                            <div class="card card-body comments-body-custom">
                                                <!-- input 영역 -->
                                                <div class="container p-0 row row-cols-2">
                                                    <form class="col" action="commentInsert" method="post" enctype="multipart/form-data">
                                                        <input type="hidden" name="id" value="${board.id }">
                                                        <input type="hidden" name="userId" value="1">
                                                        <input type="hidden" name="commentGroupId" value="${board.id }">
                                                        <input type="hidden" name="commentStep" value="${comments.commentStep }">
                                                        <input type="hidden" name="commentIndent" value="${comments.commentIndent }">

                                                        <div class="row row-cols-3 p-0">
                                                            <div class="form-group col comment-md-input">
                                                                <input type="text" class="form-control" name="content"
                                                                       placeholder="댓글을 입력하세요.">
                                                            </div>
                                                            <div class="form-group col comment-md-btn">
                                                                <button type="submit" class="btn">등록</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                    <!-- input 영역 END -->
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</main>
</body>
</html>

<script>
    function deleteNotice(id, currentPage) {
        if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
            location.href=`noticeDelete?id=${board.id}&currentPage=${currentPage}`;
        }
    }
</script>