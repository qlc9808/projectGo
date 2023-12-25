<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
    <script>
        function isDeleted(row, isDeletedValue) {
            // 해당 행의 isDeleted 클래스에 값을 설정
            $(row).find(".isDeleted").val(isDeletedValue);
        }

        // 사용자가 공개/비공개 설정
        function deleteCheck(id){
            alert("삭제/비공개 설정하는 게임 id: " + id);
            $.ajax({
                url         : 'deleteCheck',
      //          type        : "POST",
                data        : {'id' : id},      // 보낼 데이터
                dataType    : 'text',           // 받아올 데이터 자료형 지정
                success     : function(data){
                    alert("data-> " + data);
                    if (data === "nondisclosure" || data === "public") {
                        // 비공개 처리되었거나 공개 처리되었을 경우에만 체크박스 상태 변경
                        toggleCheckbox(id);
                    }
                }
            });
        }

        // 체크박스 상태 전환 함수
        function toggleCheckbox(id) {
            // 해당 ID를 가진 체크박스 선택
            var checkbox = $("tr#gameContent" + id + " .isDeleted");

            // 체크박스 상태 변경
            checkbox.prop('checked', !checkbox.prop('checked'));

            // 비공개일 때 레이블 변경
            var label = $("tr#gameContent" + id + " label[for=isDeleted]");
            label.text(checkbox.prop('checked') ? '공개' : '비공개');
        }
    </script>
</head>
<style>
    th, td {
        text-align: center;
        vertical-align: middle;
    }
    #gameImg{
        width: 110px;
    }
</style>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <div class="d-flex">
        <div class="col-2">
            <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        </div>
        <div id="main-content" class="container p-5 col-10">
            <%-- 이곳에 작성을 해주세요 --%>
            <p>총 건수: ${gameContentsTotalCount}</p>

                <table class="table table-bordered">
                    <tr>
                        <th>No.</th> <th>콘텐츠 이미지</th> <th>게임 콘텐츠명</th> <th>패키지 내용</th> <th>level</th> <th>구독 가능 인원</th>
                        <th>구독 기간</th> <th>정가</th> <th>할인율</th> <th>판매가</th> <th>공개 여부</th>
                    </tr>

                    <c:forEach var="gameContent" items="${gameContentsList}">
                        <tr id="gameContent${gameContent.rn}" onclick="isDeleted(this, ${gameContent.isDeleted})">

                            <td>${gameContent.rn}</td>
                            <td>
                                <img id="gameImg" alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/gameContents/${gameContent.imageName}">
                            </td>
                            <td>${gameContent.title}</td>
                            <td>${gameContent.content}</td>
                            <td>${gameContent.gameLevel}</td>
                            <td>${gameContent.maxSubscribers}명</td>
                            <td>${gameContent.subscribeDate}개월</td>
                            <td>${gameContent.price}원</td>
                            <td>${gameContent.discountRate}%</td>
                            <td>${gameContent.discountPrice}원</td>
                            <td>
                                <%--<select name="isDeleted" class="isDeleted" onclick="deleteCheck(${gameContent.id})">
                                    <option value="0" ${gameContent.isDeleted eq '0' ? 'selected' : ''}>공개</option>
                                    <option value="1" ${gameContent.isDeleted eq '1' ? 'selected' : ''}>비공개</option>
                                </select>--%>
                                    <input type="checkbox" name="isDeleted" class="isDeleted" onclick="deleteCheck(${gameContent.id})"
                                           value="${gameContent.isDeleted}" ${gameContent.isDeleted eq '1' ? 'checked' : ''}>
                                    <label for="isDeleted${gameContent.rn}">${gameContent.isDeleted eq '1' ? '비공개' : '공개'}</label>

                            </td>
                        </tr>
                    </c:forEach>
                </table>
                    <%--<button type="submit">등록하기</button>--%>


            <!-- 페이징 작업 -->
            <ul class="pagination justify-content-center">
                <c:if test="${page.startPage > page.pageBlock}">
                    <a href="gameContentSelect?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
                </c:if>

                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <a href="gameContentSelect?currentPage=${i}">[${i}]</a>
                </c:forEach>

                <c:if test="${page.endPage < page.totalPage}">
                    <a href="gameContentSelect?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
                </c:if>
            </ul>

        </div>
    </div>

</main>
<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
