<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        form {
            max-width: 600px;
            margin: auto;
        }

        label {
            display: block;
            margin-top: 20px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        #drop_zone {
            margin-top: 20px;
            padding: 10px;
            text-align: center;
            width: 500px;
            height: 200px;
            border: 1px solid black;
        }

        #uploadBtn {
            display: block;
            margin-top: 20px;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/AdminSidebar.jsp"%>
    <div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
        <div class="container table-container p-4">
            <form action="noticeUpdate?id=${board.id}&currentPage=${currentPage}" method="post" enctype="multipart/form-data">
                <H1>수정등록</H1>


                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${board.title}" required>

                <label for="content">내용</label>
                <textarea id="content" name="content" required>${board.content}</textarea>

                <div style="display: flex; align-items: center;">
                    <input type="hidden" id="isPinnedHidden" name="isPinned" value="${board.isPinned}">
                    <input type="checkbox" id="isPinned" name="isPinned" ${board.isPinned ? "checked" : ""} onchange="updateIsPinnedValue()">
                    <label for="isPinned">상단에 고정</label>
                </div>

                <input type="hidden" id="immediate" name="publishOption" value="immediate" checked>


                <input type="hidden" id="scheduled" name="publishOption" value="scheduled">

                <input type="hidden" id="publishDate" name="publishDate">

                <div id="drop_zone">파일을 여기에 드래그하세요.(최대 30MB)</div>
                <button id="uploadBtn" type="button">파일 선택 및 업로드</button>
                <input type="file" id="file" name="file" multiple style="display: none;">

                <input type="hidden" id="createdAt" name="createdAt" value="<fmt:formatDate value='${board.createdAt}' pattern='EEE MMM dd HH:mm:ss zzz yyyy'/>" required>
                <input type="submit" value="수정">
            </form>
        </div>
    </div>
</main>
</body>


<script>
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
            result += "Size: " + sizeInMB + " MB<br>";

            // 파일 취소 버튼 추가
            result += "<button class='cancelBtn' data-file-index='" + i + "'>X</button><br><br>";
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

            // 파일 취소 버튼 클릭 이벤트 핸들러 추가
            var cancelBtns = document.getElementsByClassName('cancelBtn');
            for (var i = 0; i < cancelBtns.length; i++) {
                cancelBtns[i].addEventListener('click', function(event) {
                    // 버튼의 기본 동작 취소
                    event.preventDefault();

                    // 파일 취소: 해당 파일 정보를 fileInfo에서 제거
                    var fileIndex = event.target.dataset.fileIndex;
                    fileInfo = fileInfo.replace(new RegExp("File " + (Number(fileIndex) + 1) + ":(.|)*?X"), "");

                    // 드롭존의 내용을 업데이트
                    document.getElementById("drop_zone").innerHTML = fileInfo;
                });
            }
        }
    });
    $(document).ready(function() {
        $('input[type=radio][name=publishOption]').change(function () {
            if (this.value == 'scheduled') {
                // 라디오 버튼이 '원하는 날짜에 게시'에 체크되면 '게시일자' 입력 필드와 라벨을 보여줌
                $('#publishDate').prop('disabled', false).show();
                $('#publishDateLabel').show();
                alert('이 경우 해당 글을 게시일까지 삭제 및 수정 할 수 없습니다'); // 알림창 띄우기
            } else if (this.value == 'immediate') {
                // 라디오 버튼이 '즉시 등록'에 체크되면 '게시일자' 입력 필드와 라벨을 다시 숨김
                $('#publishDate').prop('disabled', true).hide();
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
    })
    function updateIsPinnedValue() {
        var checkbox = document.getElementById('isPinned');
        var hiddenInput = document.getElementById('isPinnedHidden');
        if (checkbox.checked) {
            hiddenInput.value = 1;
        } else {
            hiddenInput.value = 0;
        }
    }

</script>
</html>
