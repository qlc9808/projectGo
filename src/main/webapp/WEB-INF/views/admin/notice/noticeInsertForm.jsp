
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="noticeInsert" method="post" enctype="multipart/form-data">
        <H1>개시등록</H1>

        <label for="title">제목</label>
        <input type="text" id="title" name="title" required>

        <label for="content">내용</label>
        <textarea id="content" name="content" required></textarea>

        <input type="checkbox" id="isPinned" name="isPinned">
        <label for="isPinned">상단에 고정</label>

        <input type="radio" id="immediate" name="publishOption" value="immediate" checked>
        <label for="immediate">즉시 등록</label>

        <input type="radio" id="scheduled" name="publishOption" value="scheduled">
        <label for="scheduled">원하는 날짜에 등록</label>

        <label for="publishDate">게시일자</label>
        <input type="datetime-local" id="publishDate" name="publishDate"><!-- 게시일자 입력 필드 추가 -->

        <label for="file">파일</label>
        <input type="file" id="file" name="file">

        <input type="submit" value="등록">
    </form>

</body>
</html>
