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
            <form action="QNAUpdate?id=${board.id}&currentPage=${currentPage}" method="post" enctype="multipart/form-data">
                <H1>수정등록</H1>


                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${board.title}" required>

                <label for="content">내용</label>
                <textarea id="content" name="content" required>${board.content}</textarea>

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
    $('form').on('submit', function(event) {
        if (!$(this).data('submitted')) {
            event.preventDefault();

            var formData = new FormData(this);

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false
            }).done(function(response) {
                $('form').data('submitted', true);
                $('form').submit();
            }).fail(function(xhr, status, error) {
                // 실패 시 특별한 처리를 하지 않습니다.
            });
        }
    });
</script>
</html>

