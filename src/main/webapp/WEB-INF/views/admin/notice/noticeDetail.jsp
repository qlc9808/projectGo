
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="noticeUpdate" method="post">
    <h1>${board.title}</h1>
    <p>작성일: ${board.createdAt}</p>
    <p>조회수: ${board.readCount}</p>
    <p>${board.content}</p>
        <a href="${fileUrl}" download>Download file</a>


        <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='/admin/board/noticeUpdateForm?id=${board.id}&currentPage=${currentPage}'">수정하기</button>
    <a href="noticeDelete?Id=${board.id}&currentPage=${currentPage}">삭제</a>
    </form>
    <form name="updateForm">
        <input type="hidden" name="target_id" value="${board.id}">
        <input type="hidden" name="title" id="${board.title}">
        <input type="hidden" name="content" id="${board.content}">
    </form>



</body>
</html>
