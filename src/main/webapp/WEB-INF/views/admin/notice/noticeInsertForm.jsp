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
    <form action="noticeInsert" method="post">
    <label for="title">제목</label>
    <input type="text" id="title" name="title" required>
    <label for="content">내용</label>
    <textarea id="content" name="content" required></textarea>
    <input type="submit" value="등록">
    </form>

</body>
</html>
