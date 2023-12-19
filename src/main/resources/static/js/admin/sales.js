var grid;
var gridData;
var chart;

$.ajax({
    url: '/admin/account/api/listSales',
    method: 'GET',
    success: function(response) {
        var listSales = response.salesInfo;
        var count = response.count;
        gridData = listSales.map(function(item) {

            return {
                id: item.id,
                name: item.name,
                title: item.title,
                paymentType: item.paymentType,
                status: item.status,
                purchaseDate: item.purchaseDate,
                discountPrice: item.discountPrice+"원"
            };
        });

        grid = new tui.Grid({
            el: document.getElementById('grid1'),
            data: gridData,
            scrollX: false,
            scrollY: false,
            rowHeight: 'auto',
//          rowHeaders: ['checkbox'],
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
                    header: '구매자',
                    name: 'name',
                    align: 'center'

                },
                {
                    header: '구매한게임',
                    name: 'title',
                    align: 'center',
                    width: 300
                },
                {
                    header: '결제방법',
                    name: 'paymentType',
                    align: 'center',
                    sortable: true,
                    sortingType: 'desc'
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
                    width: 150,
                    sortable: true,
                    sortingType: 'desc'
                },
                {
                    header: '결제금액',
                    name: 'discountPrice',
                    align: 'center'
                }
            ],
            pageOptions: {
                useClient: true,
                perPage: 10
            },
        });
        
        // 그래프 생성
        let monthlySalesSum = Array(12).fill(0); // 월별 매출액 합계를 저장할 배열
        const monthlySalesCount = Array(12).fill(0); // 월별 매출액 개수를 저장할 배열

        listSales.forEach(item => {
            const month = parseInt(item.purchaseDate.split('-')[1], 10) - 1;
            const price = parseInt(item.discountPrice, 10);

            monthlySalesSum[month] += price; // 해당 월의 매출액에 더함
            monthlySalesCount[month] += 1; // 해당 월의 매출액 개수 증가
        });
        const monthlySalesAvg = monthlySalesSum.map((sum, i) => {
            if (monthlySalesCount[i] === 0) {
                // 해당 월의 매출이 없으면 평균 매출을 0으로 설정
                return 0;
            } else {
                // 그렇지 않으면 평균 매출을 계산
                return Math.floor(sum / monthlySalesCount[i]);
            }
        });
        monthlySalesSum = monthlySalesSum.map(sum => Math.floor(sum / 10000));

        // 총 매출액 계산
        const totalSales = monthlySalesSum.reduce((a, b) => a + b, 0) * 10000; // 만원 단위에서 원 단위로 변경
        document.getElementById('total-discountPrice').value = totalSales;

        // 총 건수 계산
        const totalCount = monthlySalesCount.reduce((a, b) => a + b, 0);
        document.getElementById('totalCount').value = totalCount;

        const el = document.getElementById('chart-area');
        const data = {
            categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            series: [
                {
                    name: '매출액(만원)',
                    data: monthlySalesSum
                },
            ],
        };
        
        // 그래프 옵션
        const options = {
            chart: { title: '2023년 매출내역' },
            xAxis : {
                title: '',
            },
            yAxis : {
                title: '만원',
            },
            series: { showDot: true, dataLabels: { visible: true, offsetY: 0 } },
        };

        chart = toastui.Chart.columnChart({ el, data, options });
    }
});

// 매출 조회 검색 시
function search() {
    let keyword = document.getElementById('keyword').value;
    let keywordDate1 = document.getElementById('keywordDate1').value
    let keywordDate2 = document.getElementById('keywordDate2').value
    let searchType = document.getElementById('searchType').value
    let status = 1;

    if (keywordDate2 < keywordDate1) {
        alert("기간조회 날짜를 다시 확인해주세요.");
        return null;
    }

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
            grid.clear();
            const searchInfo = response.searchInfo;

            // 총 매출액과 전체 건수를 계산합니다.
            let totalSales = 0;
            let totalCount = 0;

            for (let item of searchInfo) {
                grid.appendRow(item);

                totalSales += item.discountPrice;
                totalCount += 1;
            }
            document.getElementById('total-discountPrice').value = totalSales;
            document.getElementById('totalCount').value = totalCount;
        }
    })
}

window.addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        search();
    }
});

document.getElementById('keyword').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        search();
    }
});

document.getElementById('salesMonth').addEventListener('change', function() {
    const select = document.getElementById('selectOption');
    select.innerHTML = "";
    ['2023년', '2024년'].forEach((optionText, index) => {
        const option = document.createElement('option');
        option.text = optionText;
        option.value = index + 2023;
        select.add(option);
    });
    chartSelector(select.options[select.selectedIndex].value);
});

document.getElementById('salesDays').addEventListener('change', function() {
    const select = document.getElementById('selectOption');
    select.innerHTML = "";
    for (let i = 1; i <= 12; i++) {
        const option = document.createElement('option');
        option.text = `${i}월`;
        option.value = i;
        select.add(option);
    }
    chartSelector(select.options[select.selectedIndex].value);
});

document.getElementById('selectOption').addEventListener('change', function() {
    chartSelector(this.value);
});

function chartSelector(value) {
    console.log("선택된 옵션의 value: " + value);
    $.ajax({
        url: "/admin/account/api/chartSelector?value="+value,
        method: "GET",
        success: function (response) {
            console.log(response.chartSelectorList);
            chart.destroy();

            if ( value > 1000 ) {
                // 월별 그래프 생성
                let monthlySalesSum = Array(12).fill(0); // 월별 매출액 합계를 저장할 배열

                response.chartSelectorList.forEach(item => {
                    const month = parseInt(item.purchaseDate.split('-')[1], 10) - 1;
                    const price = parseInt(item.discountPrice, 10);

                    monthlySalesSum[month] += price; // 해당 월의 매출액에 더함
                });

                monthlySalesSum = monthlySalesSum.map(sum => Math.floor(sum / 10000));

                const el = document.getElementById('chart-area');
                const data = {
                    categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    series: [
                        {
                            name: '매출액(만원)',
                            data: monthlySalesSum
                        },
                    ],
                };

                // 그래프 옵션
                const options = {
                    chart: { title: value+'년 매출내역' },
                    xAxis : {
                        title: '',
                    },
                    yAxis : {
                        title: '만원',
                    },
                    series: { showDot: true, dataLabels: { visible: true, offsetY: 0 } },
                };

                chart = toastui.Chart.columnChart({ el, data, options });
            } else {
                // 일별 그래프 생성
                let dailySalesSum = Array(31).fill(0); // 일별 매출액 합계를 저장할 배열

                response.chartSelectorList.forEach(item => {
                    const day = parseInt(item.purchaseDate.split('-')[2], 10) - 1;
                    const price = parseInt(item.discountPrice, 10);

                    dailySalesSum[day] += price; // 해당 일의 매출액에 더함
                });

                dailySalesSum = dailySalesSum.map(sum => Math.floor(sum / 10000));

                const el = document.getElementById('chart-area');
                const data = {
                    categories: Array.from({length: 31}, (_, i) => `${i+1}일`),
                    series: [
                        {
                            name: '매출액(만원)',
                            data: dailySalesSum
                        },
                    ],
                };

                // 그래프 옵션
                const options = {
                    chart: { title: value+'월 매출내역' },
                    xAxis : {
                        title: '',
                    },
                    yAxis : {
                        title: '만원',
                    },
                    series: { showDot: true, dataLabels: { visible: true, offsetY: 0 } },
                };

                chart = toastui.Chart.columnChart({ el, data, options });
            }




        }
    })
}

