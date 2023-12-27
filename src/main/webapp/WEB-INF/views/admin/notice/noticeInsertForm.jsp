<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <title>Title</title>
</head>
<style>
    #main-content {
        margin-left: 440px;
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
            <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
        </div>
    </div>
    <div id="main-content" class="container p-5 col-10" style="border: 0px solid red;">
        <div class="container border my-4 py-3">
            <div class="container my-3 py-3" style="text-align: center">
                <H1>공지 등록</H1>
            </div>
            <div>
            <form action="noticeInsert" method="post" enctype="multipart/form-data">
                <div class="my-4 row align-items-baseline">
                    <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                           style="font-size: 20px;">제목</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                <div class="my-4 row align-items-baseline">
                <label for="content" class="col-sm-2 col-form-label fw-bold text-end"
                       style="font-size: 20px;">내용</label>
                    <div class="col-sm-8">
                    <textarea id="content" name="content" class="form-control" required></textarea>
                    </div>
                </div>

                <div class="my-4 row align-items-baseline ">
                    <input type="hidden" id="isPinnedHidden" name="isPinned" value="0">
                    <label for="isPinned" class="col-sm-2 col-form-label fw-bold text-end" style="font-size: 20px;"> 상단에 고정 </label>
                    <div class="col-sm-8">
                        <input type="checkbox" id="isPinned" name="isPinned">
                    </div>
                </div>
                    <div class="my-4 row align-items-baseline ">
                       <label for="immediate" class="col-sm-2 col-form-label fw-bold text-end"
                           style="font-size: 20px;">등록 일자 </label>
                        <div class="col-sm-8">
                            <div class="form-check">
                        <input class="form-check-input" type="radio" id="immediate" name="publishOption" value="immediate" checked>
                                <label class="form-check-label" for="immediate" style="font-size: 20px; font-weight: bold;">
                                    즉시 등록
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="scheduled" name="publishOption" value="scheduled">
                                <label class="form-check-label" for="scheduled" style="font-size: 20px; font-weight: bold;">원하는 날짜에 등록
                                </label>
                            </div>
                        </div>
                        <div class="my-4 row align-items-baseline ">
                        <label for="publishDate" class="col-sm-2 col-form-label fw-bold text-end"
                        style="font-size: 20px; display: none;" id="publishDateLabel">게시일자</label>
                        <input type="datetime-local" id="publishDate" name="publishDate" style="display: none; width: 300px;"><!-- 게시일자 입력 필드 추가 -->
                        </div>

                        <div class="my-4 row align-items-baseline ">
                            <label for="title" class="col-sm-2 col-form-label fw-bold text-end"
                                       style="font-size: 20px;">파일 업로드</label>
                            <div class="col-sm-8" id="drop_zone" style="width: 300px; height: 200px; border: 1px solid black;">
                                파일을 여기에 드래그하세요.(최대 30MB)</div>
                            </div>
                        <button id="uploadBtn" type="button" style="width: 300px; margin-left: 195px;">파일 선택 및 업로드</button>
                            <input type="file" id="file" name="file" multiple style="display: none;">
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
</main>
</body>
<script>
    $(document).ready(function() {
        $('input[type=radio][name=publishOption]').change(function () {
            if (this.value == 'scheduled') {
                // 라디오 버튼이 '원하는 날짜에 게시'에 체크되면 '게시일자' 입력 필드와 라벨을 보여줌
                $('#publishDate').show();
                $('#publishDateLabel').show();
                alert('이 경우 해당 글을 게시일까지 삭제 및 수정 할 수 없습니다'); // 알림창 띄우기
            } else if (this.value == 'immediate') {
                // 라디오 버튼이 '즉시 등록'에 체크되면 '게시일자' 입력 필드와 라벨을 다시 숨김
                $('#publishDate').hide();
                $('#publishDateLabel').hide();

                // 현재 날짜와 시간을 얻어옴
                var now = new Date();
                var year = now.getFullYear();
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var day = ("0" + now.getDate()).slice(-2);
                var hours = ("0" + now.getHours()).slice(-2);
                var minutes = ("0" + now.getMinutes()).slice(-2);

                // HTML datetime-local input에 현재 날짜와 시간을 설정
                $('#publishDate').val(year + "-" + month + "-" + day + "T" + hours + ":" + minutes);
            }
        });

        var dropZone = document.getElementById('drop_zone');
        var fileInfo = "";

        dropZone.ondragover = function (event) {
            event.preventDefault();
            this.style.background = "#cccccc";
        };

        dropZone.ondragleave = function (event) {
            event.preventDefault();
            this.style.background = "white";
        };

        dropZone.ondrop = function (event) {
            event.preventDefault();
            this.style.background = "white";

            var files = event.dataTransfer.files;
            if (handleFiles(files)) {
                fileInfo += displayFileInfo(files);
                document.getElementById("drop_zone").innerHTML = fileInfo;
            }
        };

        function displayFileInfo(files) {
            var result = "";
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var sizeInMB = (file.size / 1000000).toFixed(2); // 파일 크기를 메가바이트로 변환
                result += "File " + (i + 1) + ":<br>"; // 파일 번호
                result += "Name: " + file.name + "<br>";
                result += "Size: " + sizeInMB + " MB<br><br>";
            }
            return result;
        }

        function handleFiles(files) {
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var sizeInMB = (file.size / 1000000).toFixed(2); // 파일 크기를 메가바이트로 변환
                if (sizeInMB > 30) { // 파일 크기가 30MB를 초과하는지 체크
                    alert('파일 크기가 30MB를 초과하였습니다. 다른 파일을 선택해주세요.');
                    return false;
                }
            }
            return true;
        }

        document.getElementById('uploadBtn').addEventListener('click', function() {
            document.getElementById('file').click();
        });

        document.getElementById('file').addEventListener('change', function() {
            if (handleFiles(this.files)) {
                fileInfo += displayFileInfo(this.files);
                document.getElementById("drop_zone").innerHTML = fileInfo;
            }
        });
    })
    $(document).ready(function() {
        // 체크박스 상태 감지
        $('#isPinned').change(function() {
            if($(this).is(":checked")) {
                // 체크박스가 체크되면 hidden input의 value를 1로 변경
                $('#isPinnedHidden').val('1');
            } else {
                // 체크박스가 체크 해제되면 hidden input의 value를 0으로 변경
                $('#isPinnedHidden').val('0');
            }
        });

    });
</script>
</html>
