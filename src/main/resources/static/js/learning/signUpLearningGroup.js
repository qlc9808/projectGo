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
                    image: item.image,
                    name: item.name,
                    userName: item.userName,
                    groupSize: item.groupSize,
                    etc: item.etc1+"/"+item.etc2,
                    formatStartDate: item.formatStartDate,
                    formatEndDate: item.formatEndDate
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
                    name: 'image',
                    align: 'center',
                    width: 200,
                },
                {
                    header: '그룹명',
                    name: 'name',
                    align: 'center',
                    width: 200
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
                    name: 'formatStartDate',
                    align: 'center',
                    width: 130
                },
                {
                    header: '학습종료날짜',
                    name: 'formatEndDate',
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

                        if (result === 0) {
                            console.log(result);
                            return `<button id="requestSignUp-${id}" style="border-radius: 10px;" onclick="requestSignUp(${id})">신청</button>`;
                        } else if (result === 1) {
                            return `<button id="cancelSignUp-${id}" style="border-radius: 10px;" onclick="cancelSignUp(${id})">취소</button>`;
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


// function requestSignUp(id) {
//     console.log(id)
//     $.ajax({
//         url: "/learning/api/requestSignUp?groupId="+id,
//         method: "POST",
//         success: function (response) {
//             let result = response.result;
//             if (result === 1) {
//                 alert("신청이 완료되었습니다.");
//                 let button = document.getElementById(`requestSignUp_${id}`);
//                 button.textContent = '취소';
//                 button.setAttribute('onclick', `cancelSignUp(${id})`);
//             } else {
//                 alert("신청실패..");
//             }
//         }
//     })
// }
//
// function cancelSignUp(id) {
//     $.ajax({
//         url: "/learning/api/cancelSignUp?groupId="+id,
//         method: "DELETE",
//         success: function (response) {
//             let result = response.result;
//             if (result === 1) {
//                 let button = document.getElementById(`requestSignUp_${id}`);
//                 button.textContent = '신청';
//                 button.setAttribute('onclick', `requestSignUp(${id})`);
//             }
//         }
//     })
//
//
// }

function requestSignUp(id) {
    console.log(id)
    $.ajax({
        url: "/learning/api/requestSignUp?groupId="+id,
        method: "POST",
        success: function (response) {
            let result = response.result;
            if (result === 1) {
                alert("신청이 완료되었습니다.");
                let button = document.getElementById(`requestSignUp-${id}`); // id 값 수정
                button.textContent = '취소';
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
                let button = document.getElementById(`cancelSignUp-${id}`); // id 값 수정
                button.textContent = '신청';
                button.setAttribute('onclick', `requestSignUp(${id})`);
            } else {
                alert("신청취소실패..");
            }
        }
    })
}

