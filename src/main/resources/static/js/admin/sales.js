var grid;
var gridData;

$.ajax({
    url: '/admin/account/api/listSales',
    method: 'GET',
    success: function(response) {
        var listSales = response.salesInfo;
        var count = response.count;
        gridData = listSales.map(function(item) {

            // let paymentMethod;
            // let statusMethod;
            //
            // switch (item.paymentType) {
            //     case '1':
            //         paymentMethod = "무통장입금";
            //         break;
            //     case '2':
            //         paymentMethod = "계좌이체";
            //         break;
            //     case '3':
            //         paymentMethod = "카카오페이";
            //         break;
            // }
            //
            // if (item.status === '1') {
            //     statusMethod = "결제완료";
            // } else if (item.status === '2') {
            //     statusMethod = "미결제";
            // }

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

        const el = document.getElementById('chart-area');
        const data = {
            categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            series: [
                {
                    name: 'Sales',
                    data: [1000, 5000, 3000, 5000, 1000, 5000, 3000, 5000, 7000, 6000, 4000, 1000],
                },
            ],
        };
        const options = {
            chart: { title: '월간 매출내역' },
            xAxis : {
                title: 'Month',
            },
            yAxis : {
                title: 'Amount',
            },
            series: { showDot: true, dataLabels: { visible: true, offsetY: -25 } },
        };

        const chart = toastui.Chart.areaChart({ el, data, options });

    }
});

// 매출 조회 검색 시
function search() {
    let keyword = document.getElementById('keyword').value;
    let keywordDate1 = document.getElementById('keywordDate1').value
    let keywordDate2 = document.getElementById('keywordDate2').value
    let searchType = document.getElementById('searchType').value
    let status = 1;

    if ((keywordDate1 == null || keywordDate1 === "") && (keywordDate2 == null || keywordDate2 === "")) {
        status = 2;
    }

    if ((keywordDate1 == null || keywordDate1 === "") && (keywordDate2 == null || keywordDate2 === "") && (keyword == null || keyword === "")) {
        status = 3;
    }

    if ((keywordDate1 != null && keywordDate1 !== "") && (keywordDate2 == null || keywordDate2 === "")) {
        status = 4;
    }

    console.log("keywordDate1 ->" + keywordDate1);
    console.log("keywordDate2 ->" + keywordDate2);

    if ((keywordDate1 == null || keywordDate1 === "") && (keywordDate2 != null && keywordDate2 !== "")) {
        status = 5;
    }

    if ((keywordDate1 != null && keywordDate1 !== "") && (keywordDate2 == null || keywordDate2 === "") && (keyword == null || keyword === "") ) {
        status = 6;
    }

    if ((keywordDate1 == null || keywordDate1 === "") && (keywordDate2 != null && keywordDate2 !== "") && (keyword == null || keyword === "")) {
        status = 7;
    }

    if ((keywordDate1 != null && keywordDate1 !== "") && (keywordDate2 != null && keywordDate2 !== "") && (keyword == null || keyword === "")) {
        status = 8;
    }

    if (grid) {
        grid.clear();
    }

    $.ajax({
        url: '/admin/account/api/listSaleSearch',
        method: 'GET',
        data: {
            keyword:keyword,
            keywordDate1: keywordDate1,
            keywordDate2: keywordDate2,
            searchType: searchType,
            status: status
        },
        success: function(response) {

            const searchInfo = response.searchInfo;
            console.log(searchInfo);

            for (let item of searchInfo) {
                grid.appendRow(item);
            }
        }
    })
}

