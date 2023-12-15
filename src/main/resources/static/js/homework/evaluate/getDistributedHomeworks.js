import {HomeworksEvaluateType} from "/js/enum.js";

export function getDistributedHomeworks(homeworkId) {
    $.ajax({
        url: '/homework/getDistributedHomeworks',
        type: 'POST',
        dataType: "json",
        contentType: 'application/json',
        data: JSON.stringify({homeworkId: homeworkId}),
        success: function(response) {
            $('#distributedHomework-table tbody').empty(); // 테이블 초기화
            $.each(response, function(index, item) {
                var row = $('<tr>').attr('id', 'homework-' + homeworkId + '-user-' + item.userId);
                row.append($('<td>').text(index + 1)); // 번호
                row.append($('<td>').text(item.userName)); // 학습자명
                row.append($('<td>').text(item.submissionDate)); // 숙제제출일자
                row.append($('<td>').text(item.content)); // 제출내용
                row.append($('<td>').text(item.progress)); // 학습진도
                row.append($('<td>').text(item.questions)); // 질문

                // evaluationSelect 생성
                const evaluationSelect = $('<select>').attr('id', 'evaluation-' + index);
                for (let key in HomeworksEvaluateType) {
                    let evaluateType = HomeworksEvaluateType[key];
                    let option = $('<option>').attr('value', evaluateType.value).text(evaluateType.label);
                    if (item.evaluation == key) {
                        option.attr('selected', 'selected');
                    }
                    evaluationSelect.append(option);
                }

                row.append($('<td>').append(evaluationSelect));
                $('#distributedHomework-table tbody').append(row);
            });
        },
        error: function(error) {
            console.log(error);
            // showNotification(error.responseText, "error", 3000);
        }
    });
}