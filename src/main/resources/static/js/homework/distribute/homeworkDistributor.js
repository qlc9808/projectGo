import {storeNotification} from '/js/utils/notificationManager.js'; // 모듈을 불러옵니다.
export default function homeworkDistributor(stateManager) {
    $('#distributeHomework').click(function(e) {
        e.preventDefault();

        const data = {
            studentIds: stateManager.selectedStudentsList,
            homeworkIds: stateManager.selectedHomeworkIdList
        };

        if (data.homeworkIds.length === 0) {
            showNotification("숙제를 선택 해주세요","warn",3000)
            return;
        }
        if (data.studentIds.length === 0) {
            showNotification("학습자를 선택 해주세요","warn",3000)
            return;
        }

        $.ajax({
            url: '/homework/distributeHomework',
            type: 'POST',
            dataType: "json",
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function(response) {
                storeNotification(response.message, "success");

                // 페이지를 새로고침합니다.
                location.reload();            },
            error: function(error) {
                console.log("Error: ", error);
            }
        });
    });
}

