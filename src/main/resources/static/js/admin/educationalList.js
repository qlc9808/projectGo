var grid;
var gridData;

document.addEventListener("DOMContentLoaded", function () {
    console.log("실행된거??");
    listEdu();
});

function listEdu() {
    console.log("함수들어온거?")
    $.ajax({
        url: '/admin/resource/api/listEdu',
        method: 'GET',
        success: function (response) {
            var listEdu = response.listEdu;
            var count = response.count;
            gridData = listEdu.map(function (item) {

                return {
                    id: item.id,
                    name: item.name,
                    title: item.title,
                    paymentType: item.paymentType,
                    status: item.status,
                    purchaseDate: item.purchaseDate,
                    price: item.price
                };
            });

            grid = new tui.Grid({
                el: document.getElementById('grid1'),
                data: gridData,
                scrollX: false,
                scrollY: false,
                rowHeaders: ['checkbox'],
                columns: [
                    {
                        header: '결제번호',
                        name: 'id',
                        align: 'center',
                        sortable: true,
                        sortingType: 'desc'
                    },
                    {
                        header: '이름',
                        name: 'name',
                        align: 'center'

                    },
                    {
                        header: '게임',
                        name: 'title',
                        align: 'center'
                    },
                    {
                        header: '결제방법',
                        name: 'paymentType',
                        align: 'center'
                    },
                    {
                        header: '결제상태',
                        name: 'status',
                        align: 'center'
                    },
                    {
                        header: '구매일자',
                        name: 'purchaseDate',
                        align: 'center',
                        width: 250,
                        sortable: true,
                        sortingType: 'desc'
                    },
                    {
                        header: '결제금액',
                        name: 'price',
                        align: 'center'
                    }
                ],
                pageOptions: {
                    useClient: true,
                    perPage: 10
                },
            });
        }
    });
}

