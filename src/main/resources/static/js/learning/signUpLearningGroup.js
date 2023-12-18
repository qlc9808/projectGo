var grid;
var gridData;

document.addEventListener("DOMContentLoaded", function (){
    learningGroupList();
})

function learningGroupList() {
    $.ajax({
        url: "/learning/api/signUpLearningGroup",
        method: "GET",
        success: function (response) {
            let learningGroupList = response.learningGroupList;
            let userType = response.userType;
            let result = response.result;

            gridData = learningGroupList.map(function (item) {
                return {
                    id: item.id,
                    title: item.title,
                    name: item.name,
                    userName: item.userName,
                    groupSize: item.groupSize,
                    etc: item.etc1+"/"+item.etc2,
                    startDate: item.startDate,
                    endDate: item.endDate,
                    applied: item.applied
                };
            });

            let columns = [
                {
                    header: 'NO',
                    name: 'id',
                    align: 'center',
                    sortable: true,
                    sortingType: 'desc',
                    width: 50
                },
                {
                    header: '콘텐츠이미지',
                    name: 'title',
                    align: 'center',
                    width: 200
                },
                {
                    header: '그룹명',
                    name: 'name',
                    align: 'center',
                    width: 250
                },
                {
                    header: '교육자명',
                    name: 'userName',
                    align: 'center',
                    width: 100
                },
                {
                    header: '등록가능인원',
                    name: 'groupSize',
                    align: 'center',
                    sortable: true,
                    sortingType: 'desc',
                    width: 150
                },
                {
                    header: '그룹소개',
                    name: 'etc',
                    align: 'center',
                    width: 100
                },
                {
                    header: '학습시작날짜',
                    name: 'startDate',
                    align: 'center',
                    width: 130
                },
                {
                    header: '학습종료날짜',
                    name: 'endDate',
                    align: 'center',
                    width: 130
                }
            ];
            if (userType === '3') {
                console.log(userType);
                columns.push({
                    header: '',
                    name: '',
                    align: 'center',
                    width: 100,
                    formatter: function ({row}) {
                        const id = row.id;
                        console.log(row.applied);
                        if (row.applied) {
                            return `<button id="cancelSignUp-${id}" style="border-radius: 10px;" onclick="cancelSignUp(${id})">취소</button>`;
                        } else {
                            return `<button id="requestSignUp-${id}" style="border-radius: 10px;" onclick="requestSignUp(${id})">신청</button>`;
                        }
                    }
                });
            }

            grid = new tui.Grid({
                el: document.getElementById('grid1'),
                data: gridData,
                scrollX: false,
                scrollY: false,
                columns: columns,
                pageOptions: {
                    useClient: true,
                    perPage: 10
                },
            });
        },
    })
}

function requestSignUp(id) {
    $.ajax({
        url: "/learning/api/requestSignUp?groupId="+id,
        method: "POST",
        success: function (response) {
            let result = response.result;
            if (result === 1) {
                alert("신청이 완료되었습니다.");

                // 버튼 업데이트
                let button = document.getElementById(`requestSignUp-${id}`);
                button.textContent = '취소';
                button.id = `cancelSignUp-${id}`;
                button.setAttribute('onclick', `cancelSignUp(${id})`);
            } else {
                alert("신청실패..");
            }
        }
    })
}

function cancelSignUp(id) {
    $.ajax({
        url: "/learning/api/cancelSignUp?groupId="+id,
        method: "DELETE",
        success: function (response) {
            let result = response.result;
            if (result === 1) {
                alert("신청취소완료");

                // 버튼 업데이트
                let button = document.getElementById(`cancelSignUp-${id}`);
                button.textContent = '신청';
                button.id = `requestSignUp-${id}`;
                button.setAttribute('onclick', `requestSignUp(${id})`);
            } else {
                alert("신청취소실패..");
            }
        }
    })
}


