<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>QNA 상세</title>
</head>
<body>
<form action="QNAUpdate" method="post">
    <h1>${board.title}</h1>
    <p>작성일: ${board.createdAt}</p>
    <p>조회수: ${board.readCount}</p>
    <p>${board.content}</p>

    <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='/admin/board/noticeUpdateForm?id=${board.id}&currentPage=${currentPage}'">수정하기</button>
    <a href="#" onclick="deleteNotice('${board.id}', '${currentPage}')">삭제</a>
</form>
<form name="updateForm">
    <input type="hidden" name="target_id" value="${board.id}">
    <input type="hidden" name="title" id="${board.title}">
    <input type="hidden" name="content" id="${board.content}">
    <input type="hidden" name="content" id="${board.createdAt}">

</form>

<script>
    function deleteNotice(id, currentPage) {
        if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
            location.href=`noticeDelete?id=${board.id}&currentPage=${currentPage}`;
        }
    }
</script>

</body>
</html>


