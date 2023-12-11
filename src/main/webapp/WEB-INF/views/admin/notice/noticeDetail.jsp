<%--
  Created by IntelliJ IDEA.
  User: 1
  Date: 2023-12-11
  Time: 오후 3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>${board.title}</h1>
    <p>작성일: ${board.createdAt}</p>
    <p>조회수: ${board.readCount}</p>
    <p>${board.content}</p>

    <a href="noticeUpdateForm?userId=${board.userId}&currentPage=${currentPage}">수정</a>
    <a href="noticeDelete?userId=${board.userId}&currentPage=${currentPage}">삭제</a>



</body>
</html>
