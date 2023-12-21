<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/components/Header.jsp"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TopBar.jsp"%>
<main>
    <%@ include file="/WEB-INF/components/Sidebar.jsp"%>
    <div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
        <div class="container table-container p-4">
            <body>
            <form action="noticeInsert" method="post" enctype="multipart/form-data">
                <H1>개시등록</H1>


                <label for="title">제목</label>
                <input type="text" id="title" name="title" required>

                <label for="content">내용</label>
                <textarea id="content" name="content" required></textarea>

                <input type="hidden" id="isPinnedHidden" name="isPinned" value="0">
                <input type="checkbox" id="isPinned" name="isPinned">
                <label for="isPinned">상단에 고정</label>

                <input type="radio" id="immediate" name="publishOption" value="immediate" checked>
                <label for="immediate">즉시 등록</label>

                <input type="radio" id="scheduled" name="publishOption" value="scheduled">
                <label for="scheduled">원하는 날짜에 등록</label>

                <label for="publishDate">게시일자</label>
                <input type="datetime-local" id="publishDate" name="publishDate"><!-- 게시일자 입력 필드 추가 -->

                <div id="drop_zone" style="width: 300px; height: 200px; border: 1px solid black;">파일을 여기에 드래그하세요.(최대 30MB)</div>
                <button id="uploadBtn" type="button">파일 선택 및 업로드</button>
                <input type="file" id="file" name="file" multiple style="display: none;">

                <input type="submit" value="등록">
            </form>
            </body>
        </div>
    </div>
</main>
<script>
    $(document).ready(function() {
        $('input[type=radio][name=publishOption]').change(function () {
            if (this.value == 'scheduled') {
                $('#publishDate').prop('disabled', false);
            } else if (this.value == 'immediate') {
                $('#publishDate').prop('disabled', true);
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
</script>
</html>
