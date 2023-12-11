// homeworkSelection.js
export default function homeworkSelection(stateManager) {

    // 선택된 숙제 ID 리스트를 업데이트하는 함수
    function updateSelectedHomeworkIdList() {
        stateManager.selectedHomeworkIdList = []; // 리스트 초기화

        // 체크된 체크박스를 가진 모든 행을 찾아 숙제 ID를 리스트에 추가
        $('#homework-table-body tr').each(function() {
            const checkbox = $(this).find('input[type="checkbox"]');
            if (checkbox.prop('checked')) { // 체크박스가 체크된 경우
                const homeworkId = $(checkbox).attr('id').split('-')[1]; // 체크박스의 id에서 숙제 ID 추출

                // 선택된 숙제 ID 리스트에 숙제 ID 추가
                stateManager.selectedHomeworkIdList.push(homeworkId);
            }
        });
    }

    // 체크박스 상태가 변경될 때마다 선택된 숙제 ID 리스트 업데이트
    $('#homework-table-body').on('change', 'input[type="checkbox"]', function() {
        updateSelectedHomeworkIdList();
    });
}