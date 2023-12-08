$.ajax({
    url: '/admin/account/api/listSales',
    method: 'GET',
    success: function(response) {
        var listSales = response.salesInfo;
        var count = response.count;

     //   var pagination = new tui.Pagination('pagination', {
     //       totalItems: 100,
     //       itemsPerPage: 10,
     //       visiblePages: 10,
     //       centerAlign: true
     //   });

        var gridData = listSales.map(function(item) {
            return {
                id: item.id,
                userid: item.userid,
                contentId: item.contentId,
                paymentType: item.paymentType,
                status: item.status,
                purchaseDate: item.purchaseDate,
                price: item.price
            };
        });

        const grid = new tui.Grid({
            el: document.getElementById('grid1'),
            data: gridData,
            scrollX: false,
            scrollY: false,
            rowHeaders: ['checkbox'],
            columns: [
                {
                    header: '결제 번호',
                    name: 'id',
                    align: 'center'
                },
                {
                    header: '회원 번호',
                    name: 'userid',
                    align: 'center'
                },
                {
                    header: '게임 번호',
                    name: 'contentId',
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
                    width: 250
                },
                {
                    header: '결제금액',
                    name: 'price',
                    align: 'center'
                }
            ]



        });

        const el = document.getElementById('chart-area');
        const data = {
            categories: ['6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            series: [
                {
                    name: 'Sales',
                    data: [5000, 3000, 5000, 7000, 6000, 4000, 1000],
                },
            ],
        };
        const options = {
            chart: { title: '월별 평균매출내역', width: 1100, height: 400 },
            series: {
                stack: {
                    type: 'normal',
                },
            },
        };

        const chart = toastui.Chart.barChart({ el, data, options });

    }
});

