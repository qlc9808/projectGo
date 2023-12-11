export default function studentSelection(stateManager) {
    const studentList = $('#studentList tbody');
    const selectedStudents = $('#selectedStudents tbody');

    // 함수 정의
    function updateTables() {
        selectedStudents.empty();
        studentList.find('tr').each(function() {
            const studentId = $(this).children('td').eq(1).text();
            const checkbox = $(this).find('input[type="checkbox"]');
            if (checkbox.prop('checked')) {
                if (!stateManager.selectedStudentsList.includes(studentId)) {
                    stateManager.selectedStudentsList.push(studentId);
                }
                const selectedStudent = $(this).clone();
                selectedStudent.children('td').first().remove(); // 체크박스 제거
                selectedStudent.append('<td><a class="btn-remove">x</a></td>'); // 'x' 버튼 추가
                selectedStudents.append(selectedStudent);
            } else {
                const index = stateManager.selectedStudentsList.indexOf(studentId);
                if (index > -1) {
                    stateManager.selectedStudentsList.splice(index, 1);
                }
            }
            checkbox.prop('checked', stateManager.selectedStudentsList.includes(studentId)); // 학생 목록의 체크박스 상태 업데이트
        });
    }

    // 이벤트 핸들러 정의
    $('#learningGroupSelect').change(function() {
        const selectedGroup = $(this).val();
        let url = "";
        let data = {};

        if (selectedGroup === "groupAll") {
            url = '/group/getGroupMembersByEducatorId';
            data = { educatorId: 1 };
        } else {
            url = '/group/getGroupMemberByGroupId';
            data = { groupId: selectedGroup };
        }

        $.ajax({
            url: url,
            type: 'GET',
            data: data,
            success: function(data) {
                studentList.empty();
                selectedStudents.empty();
                $.each(data, function(index, user) {
                    const trEl = document.createElement("tr");
                    const checkboxCell = document.createElement("td");
                    const checkbox = document.createElement("input");
                    checkbox.setAttribute("type","checkbox");
                    checkbox.className="form-check-input";
                    checkboxCell.appendChild(checkbox);
                    trEl.appendChild(checkboxCell);

                    const userId = document.createElement("td");
                    userId.innerText = user.id;
                    trEl.appendChild(userId);

                    const userName = document.createElement("td");
                    userName.innerText = user.name;
                    trEl.appendChild(userName);

                    const userPhone = document.createElement("td");
                    userPhone.innerText = user.phone;
                    trEl.appendChild(userPhone);

                    studentList.append(trEl);
                });
            }
        });
    });

    $('#selectedStudents').on('click', '.btn-remove', function() {
        const studentId = $(this).closest('tr').children('td').eq(0).text(); // 'x' 버튼이 있는 행의 학생 ID
        const index = stateManager.selectedStudentsList.indexOf(studentId);
        if (index > -1) {
            stateManager.selectedStudentsList.splice(index, 1);
        }
        studentList.find('tr').each(function() {
            if ($(this).children('td').eq(1).text() === studentId) {
                $(this).find('input[type="checkbox"]').prop('checked', false);
            }
        });
        updateTables();
    });

    $('#studentList').on('change', 'input[type="checkbox"]', function() {
        updateTables();
    });

    $('#selectAll').click(function() {
        studentList.find('input[type="checkbox"]').prop('checked', true);
        updateTables();
    });

    $('#deselectAll').click(function() {
        studentList.find('input[type="checkbox"]').prop('checked', false);
        updateTables();
    });

    // 초기 실행 함수
    $('#learningGroupSelect').trigger('change');

}