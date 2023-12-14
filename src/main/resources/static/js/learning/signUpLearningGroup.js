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
            var learningGroupList = response.learningGroupList;

            gridData = learningGroupList.map(function (item) {

                return {
                    id: item.id,
                    image: item.image,
                    name: item.name,
                    userName: item.userName,
                    groupSize: item.groupSize,
                    etc: item.etc1+"/"+item.etc2,
                    startDate: item.startDate,
                    endDate: item.endDate
                };
            });

            grid = new tui.Grid({
                el: document.getElementById('grid1'),
                data: gridData,
                scrollX: true,
                scrollY: true,
                rowHeaders: [
                    {type: 'checkbox'}
                ],
                columns: [
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
                        name: 'startDate',
                        align: 'center',
                        width: 250
                    },
                    {
                        header: '학습종료날짜',
                        name: 'endDate',
                        align: 'center',
                        width: 250
                    }
                ],
                pageOptions: {
                    useClient: true,
                    perPage: 10
                },
            });
        },
    })
}
