<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    #main-content {
        border: 0px solid red;
        margin: auto auto auto 300px;
    }
    .date-text {
        font-size: 16px;
        font-weight: 600;
        margin-right: 20px;
        margin-left: 10px;
        text-align: center;
    }

    h1 {
        color: black;
        font-size: 32px;
        font-weight: 600;
        word-wrap: break-word;
        text-align: center;
    }
    .form-check-input[type=radio] {
        width: 20px;
        height: 20px;
        border-width: 2px;
    }

</style>

<body>
    <%@ include file="/WEB-INF/components/TopBar.jsp"%>
    <main>
        <div class="d-flex">
            <div class="col-second">
                <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
            </div>
        </div>
        <div id="main-content" class="container p-5 col-10" style="border: 0px solid red;">
            <div class="container border my-4 py-3">
                <div class="container my-3 py-3" style="text-align: center">
                    <h1>교육정보수정</h1>
                </div>
                <div>
                    <form action="/admin/resource/updateEdu" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${edu.id}">
                        <input type="hidden" name="contentId" value="${edu.contentId}">
                        <input type="hidden" name="userId" value="${edu.userId}">
                        <input type="hidden" name="image" value="${edu.image}">
                        <input type="hidden" name="createdAt" value="${edu.createdAt}">
                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">학습자료명</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="title" name="title" value="${edu.title}">
                            </div>
                        </div>
                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">자료구분</label>
                            <div class="col-sm-8">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="resourceType" id="tutorial" value="1" <c:if test="${edu.resourceType == 1}">checked="checked"</c:if>>
                                    <label class="form-check-label" for="free" style="font-size: 20px; font-weight: bold;">
                                        튜토리얼
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="resourceType" id="eduVideo" value="2" <c:if test="${edu.resourceType == 2}">checked="checked"</c:if>>
                                    <label class="form-check-label" for="paid" style="font-size: 20px; font-weight: bold;">
                                        교육영상
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">자료유형</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="fileType" name="fileType" value="${edu.fileType}">
                            </div>
                        </div>
                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">자료file주소</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="fileAddress" name="fileAddress" value="${edu.fileAddress}">
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">서비스구분</label>
                            <div class="col-sm-8">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="serviceType" id="free" value="1" <c:if test="${edu.serviceType == 1}">checked="checked"</c:if>>
                                    <label class="form-check-label" for="free" style="font-size: 20px; font-weight: bold;">
                                        무료
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="serviceType" id="paid" value="2" <c:if test="${edu.serviceType == 2}">checked="checked"</c:if>>
                                    <label class="form-check-label" for="paid" style="font-size: 20px; font-weight: bold;">
                                        유료
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="content" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">자료내용</label>
                            <div class="col-sm-8">
                            <textarea class="form-control" aria-label="With textarea" id="content" rows="5"
                                      name="content">${edu.content}</textarea>
                                <p id="textarea-validate" class="helptext text-end"></p>
                            </div>
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                   style="font-size: 20px;">썸네일</label>
                            <div class="col-sm-8">
                                <input type="file" class="form-control" id="file" name="file" value="${edu.image}">
                            </div>
                        </div>

                        <div class="container row justify-content-center my-5">

                            <button type="submit" class="btn btn-primary col-4 px-3 mx-2"
                                    style="background: #52525C; border: none">저장하기
                            </button>
                            <button type="reset" class="btn btn-primary col-4 px-3 mx-2">취소</button>

                        </div>
                    </form>
                </div>
            </div>

        </div>
    </main>
    <%@ include file="/WEB-INF/components/Footer.jsp"%>
    <script>

    </script>
</body>
</html>
