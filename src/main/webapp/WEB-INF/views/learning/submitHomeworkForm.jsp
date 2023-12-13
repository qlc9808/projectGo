<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp" %>
    <title>Title</title>
    <link href="/css/homework.css" rel="stylesheet" type="text/css">
    <script type="module">
        import showNotification from '/js/utils/notification.js'; // 모듈을 불러옵니다.
        import {storeNotification,showStoredNotification }from '/js/utils/notificationManager.js';

        $(document).ready(function(){
            $("form").on("submit", function(e){
                e.preventDefault();
                let checkedItems = [];
                $("input[type=checkbox]:checked").each(function(){
                    const index = $(this).attr("data-index");
                    const item = {
                        homeworkId: $("input[name='distributedHomeworks[" + index + "].homeworkId']").val(),
                        userId: $("input[name='distributedHomeworks[" + index + "].userId']").val(),
                        content: $("textarea[name='distributedHomeworks[" + index + "].content']").val(),
                        questions: $("textarea[name='distributedHomeworks[" + index + "].questions']").val()
                    };
                    checkedItems.push(item);
                });
                if(checkedItems.length > 0){
                    $.ajax({
                        url: "/homework/submissionHomework",
                        type: "POST",
                        data: JSON.stringify(checkedItems),
                        contentType: "application/json",
                        success: function(response) {
                            storeNotification(response.message, "success");

                            // 페이지를 새로고침합니다.
                            location.reload();            },
                        error: function(jqXHR, textStatus, errorThrown) {
                            const error = jqXHR.responseJSON;
                            showNotification(error.message, "error", 3000);
                        }
                    });
                } else{
                    showNotification("선택된 숙제가 없습니다.", "warn", 3000);
                }
            });
            showStoredNotification();
        });
    </script>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp" %>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/Sidebar.jsp" %>
        </div>
        <div id="main-content" class="border col-9">
            <h1>숙제 등록</h1>
            <form action="/homework/submissionHomework" method="post">
                <hr/>
                <div class="container d-flex justify-content-between">
                   학습자 : ${distributedHomeworksList[0].userName}
                    <button class="btn btn-primary col-lg-2">제출하기</button>
                </div>
                <hr/>
                <div class="d-flex justify-content-around">
                    <h2>숙제 내용</h2>
                    <h2>제출 내용</h2>
                </div>
                <c:forEach var="distributedHomeworks" items="${distributedHomeworksList}" varStatus="st">
                    <input type="hidden" name="distributedHomeworks[${st.index}].userId" value="${distributedHomeworks.userId}">
                    <input type="hidden" name="distributedHomeworks[${st.index}].homeworkId" value="${distributedHomeworks.homeworkId}">
                    <input type="hidden" name="distributedHomeworks[${st.index}].userId" value="${distributedHomeworks.userId}">
                    <div class="d-flex">
                        <div class="col-6 border d-flex p-2">
                            <div class="col-1 border d-flex justify-content-center align-content-center flex-wrap" style="background-color: #F8FCF4;">
                                <input type="checkbox" class="form-check-input" name="distributedHomeworks[${st.index}].checked"  style="font-size: 30px"
                                       value="true" data-index="${st.index}" ${(distributedHomeworks.submissionDate != null)? 'disabled':''}>
                            </div>
                            <div class="container ">
                                <h3>${distributedHomeworks.homeworkTitle}</h3>
                                <h4>교육자 : ${distributedHomeworks.educatorName}</h4>
                                <h4>진도 : ${distributedHomeworks.homeworkProgress}</h4>
                                <h4>제출 마감일 : <fmt:formatDate value="${distributedHomeworks.homeworkDeadline}" pattern="yyyy/MM/dd (HH시)"/></h4>
                                <h4>숙제내용</h4>
                                <textarea class="form-control" disabled>${distributedHomeworks.homeworkContent}</textarea>
                            </div>
                        </div>
                        <div class="col-6 border p-2">
                            <c:choose>
                                <c:when test="${distributedHomeworks.submissionDate != null}">
                                    <div class="d-flex justify-content-between align-content-center"  >
                                        제출일 :
                                        <fmt:formatDate value="${distributedHomeworks.submissionDate}"
                                                        pattern="yyyy/MM/dd (HH시)"/>
                                        <div>
                                            <button type="button" class="btn" data-index="${st.index}" data-homework-id="${distributedHomeworks.homeworkId}" data-user-id="${distributedHomeworks.userId}">수정하기</button>
                                        </div>
                                    </div>
                                    <label>학습 내용</label>
                                    <textarea class="form-control" id="content-${st.index}" disabled>${distributedHomeworks.content}</textarea>
                                    <label>추가 질문</label>
                                    <textarea class="form-control" id="questions-${st.index}" disabled>${distributedHomeworks.questions}</textarea>
                                </c:when>
                                <c:otherwise>
                                    <label>학습 내용</label>
                                    <textarea class="form-control" id="content-${st.index}" name="distributedHomeworks[${st.index}].content">${distributedHomeworks.content}</textarea>
                                    <label>추가 질문</label>
                                    <textarea class="form-control" id="questions-${st.index}" name="distributedHomeworks[${st.index}].questions">${distributedHomeworks.questions}</textarea>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </form>
            <div>
                <nav aria-label="Page navigation example ">
                    <ul class="pagination">
                        <c:if test="${page.startPage > page.pageBlock}">
                            <li class="page-item">
                                <a href="javascript:void(0)"
                                   onclick="location.href=createQueryURL(${page.startPage-page.pageBlock})"
                                   class="pageblock page-link">[이전]</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                            <li class="page-item">
                                <a href="javascript:void(0)" onclick="location.href=createQueryURL(${i})"
                                   class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${page.endPage < page.totalPage}">
                            <li class="page-item">
                                <a href="javascript:void(0)"
                                   onclick="location.href=createQueryURL(${page.startPage+page.pageBlock})"
                                   class="pageblock page-link">[다음]</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>
