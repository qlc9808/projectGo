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
    <p>작성자: ${board.writer}</p>
    <p>작성일: ${board.date}</p>
    <p>${board.content}</p>

    <a href="noticeUpdateForm?userId=${userId}&currentPage=${currentPage}">수정</a>
    <a href="noticeDelete?userId=${userId}&currentPage=${currentPage}">삭제</a>


</body>
</html>
