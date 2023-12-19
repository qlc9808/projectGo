<%--
  Created by IntelliJ IDEA.
  User: 1
  Date: 2023-12-11
  Time: 오후 3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="noticeUpdate?id=${board.id}&currentPage=${currentPage}" method="post">
    <label for="title">제목</label>
    <input type="text" id="title" name="title" value="${board.title}" required>
    <label for="content">내용</label>
    <textarea id="content" name="content" required>${board.content}</textarea>
    <input type="submit" value="수정">
</form>

</body>
</html>
