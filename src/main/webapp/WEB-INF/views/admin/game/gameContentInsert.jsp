<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <h5>gameContent insert</h5>

            <form:form action="/gameContentInsert" method="post" enctype="multipart/form-data">
                <table border="1">
                    <tr>
                        <th>게임 콘텐츠명</th>
                        <td>
                            <input type="text" name="title">
                            <form:errors path="title"/>
                        </td>
                    </tr>

                    <tr>
                        <th>학습난이도</th>
                        <td>
                            <select name="gameLevel">
                                    <option value="1">초급</option>
                                    <option value="2">중급</option>
                                    <option value="3">고급</option>
                            </select>
                            <form:errors path="gameLevel"/>
                        </td>
                    </tr>

                    <tr>
                        <th>구독 기간</th>
                        <td>
                            <input type="month" name="subscribeDate">
                            <form:errors path="subscribeDate"/>
                        </td>
                    </tr>

                    <tr>
                        <th>구독 가능 인원 수</th>
                        <td>
                            <input type="number" name="maxSubscribers">
                            <form:errors path="maxSubscribers"/>
                        </td>
                    </tr>

                    <tr>
                        <th>정가</th>
                        <td>
                            <input type="number" name="price">
                            <form:errors path="price"/>
                        </td>
                    </tr>

                    <tr>
                        <th>할인율</th>
                        <td>
                            <input type="number" name="discountRate">
                            <form:errors path="discountRate"/>
                        </td>
                    </tr>

                    <tr>
                        <th>판매가</th>
                        <td>
                            <input type="number" name="discountPrice">
                        </td>
                    </tr>

                    <tr>
                        <th>패키지 내용</th>
                        <td>
                            <textarea cols="50" rows="10" name="content"></textarea>
                            <form:errors path="content"/>
                        </td>
                    </tr>

                    <tr>
                        <th>썸네일</th>
                        <td>
                            <input type="file" id="file" name="file1">
                        </td>
                    </tr>

                    <tr>
                        <td><button type="submit">등록하기</button></td>
                    </tr>

                </table>
            </form:form>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>