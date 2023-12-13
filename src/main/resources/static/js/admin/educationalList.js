var grid;
var gridData;

document.addEventListener("DOMContentLoaded", function () {
    listEdu();
});

function listEdu() {
    $.ajax({
        url: '/admin/resource/api/listEdu',
        method: 'GET',
        success: function (response) {
            var listEdu = response.listEdu;
            var count = response.count;
            gridData = listEdu.map(function (item) {

                return {
                    id: item.id,
                    gameTitle: item.gameTitle,
                    title: item.title,
                    resourceType: item.resourceType,
                    serviceType: item.serviceType,
                    createdAt: item.createdAt,
                    readCount: item.readCount
                };
            });

            grid = new tui.Grid({
                el: document.getElementById('grid1'),
                data: gridData,
                scrollX: false,
                scrollY: false,
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
                        header: '학습자료',
                        name: 'title',
                        align: 'center',
                        width: 300
                    },
                    {
                        header: '자료구분',
                        name: 'resourceType',
                        align: 'center'
                    },
                    {
                        header: '서비스',
                        name: 'serviceType',
                        align: 'center'
                    },
                    {
                        header: '자료업로드일자',
                        name: 'createdAt',
                        align: 'center',
                        width: 250,
                        sortable: true,
                        sortingType: 'desc'
                    },
                    {
                        header: '관련컨텐츠',
                        name: 'gameTitle',
                        align: 'center',
                        width: 300
                    },
                    {
                        header: '조회수',
                        name: 'readCount',
                        align: 'center',
                        width: 70
                    }
                ],
                pageOptions: {
                    useClient: true,
                    perPage: 10
                },
            });

            grid.on('click', function(ev) {
                var column = ev.columnName;
                var rowKey = ev.rowKey;

                console.log(column, rowKey);

                if (column === 'title') {
                    var id = grid.getValue(rowKey, 'id');
                    window.location.href = '/admin/resource/detailEdu?id='+id;
                }
            });

        }
    });

}


