<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>그룹가입 승인</title>
    <link href="/css/homework.css" rel="stylesheet" type="text/css">
</head>
<script>
    function listSearch() {
        $.ajax({
            url: '/group/approvalGroupMember',
            type: 'POST',  // POST 방식으로 변경
            dataType: 'json',
            data: {
                groupId: $('#groupId').val()
                // 다른 필요한 데이터들
            },
            success: function (data) {
                alert(data)
                var tbody = $("#homework-table tbody");

                // 기존 테이블의 내용을 지웁니다.
                tbody.empty();

                // 새로운 테이블의 내용을 추가합니다.
                $.each(data.learningGroupMembers, function(index, item) {
                    var row = $("<tr>");
                    row.append($("<td>").text(index + 1));
                    row.append($("<td>").text(item.userName));
                    row.append($("<td>").text(item.phone));
                    row.append($("<td>").text(item.approvalDate));
                    row.append($("<td>").text(item.status));
                    tbody.append(row);
                });
            },
            error: function (error) {
                console.log(error); // 오류가 발생한 경우 콘솔에 오류 출력
            }
        });
    }
</script>
<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-2">
                <%@ include file="/WEB-INF/components/EducateSidebar.jsp"%>
            </div>

            <div id="main-content" class="container p-5 col-10">

                <div class="container my-4 py-3">
                    <div class="container">
                        <h1>그룹신청 승인관리</h1>
                    </div>
                    <div class="container">
                        <h2>신청 내역</h2>
                        <hr/>
                    </div>

                    <%--디테일 상단부--%>
                    <div class="container">
                        <form action="/group/approvalGroupMember" method="post">
                            <div class="d-flex justify-content-between">
                                <div class="col-5 d-flex">
                                    <div class="input-group">
                                        <label for="groupId" class="input-group-text fw-bold"
                                               style="font-size: 16px;">그룹명</label>
                                        <select class="form-select text-center searchContent" id="groupId" name="groupId" onchange="listSearch()">
                                            <option value="0">그룹을 선택하세요</option>
                                            <c:forEach var="learningGroup" items="${learningGroup}" varStatus="status">
                                                <option value="${learningGroup.id}">${learningGroup.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <%--본문 리스트--%>
                    <div class="container border p-2 m-2" style="height: auto;">
                        <div class="table">
                            <table id="homework-table" class="table text-center">
                                <thead>
                                <tr>
                                    <th scope="col" style="">No</th>
                                    <th scope="col" style="">학생이름</th>
                                    <th scope="col" style="">연락처</th>
                                    <th scope="col" style="">가입요청일자</th>
                                    <th scope="col" style="">승인상태</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="learningGroupMembers" items="${learningGroupMembers}" varStatus="ststus">
                                    <tr>
                                        <td>${ststus.index + 1}</td>
                                        <td>${learningGroupMembers.userName}</td>
                                        <td>${learningGroupMembers.phone}</td>
                                        <td>${learningGroupMembers.approvalDate}</td>
                                        <td>${learningGroupMembers.status}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
