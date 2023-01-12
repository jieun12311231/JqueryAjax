/**
 * 
noticePaging.js
 */

//🍓tr만드는 함수

function makeTr(obj = {}) {
    let tr = $('<tr />').append(
        $('<td />').text(obj.noticeId), //넘어온 속성 값이 그대로 넘어 와야함
        $('<td />').text(obj.noticeWriter),
        $('<td />').text(obj.noticeDate),
        $('<td />').text(obj.noticeTitle),
        $('<td />').text(obj.noticeFile),
        $('<td />').text(obj.noticeHit),
        $('<td />').append($('<button />')
            .text('💥').attr('rowid', obj.noticeId)
            .on('click', delNoticeList))

    )
    // tr.attr('id', obj.noticeId)
    return tr
}

//🍓noticeList지우는 기능 
function delNoticeList(e) {
    // console.log($(e.currentTarget).parent().parent().children().eq(0).text())
    // let id = $(e.currentTarget).parent().parent().children().eq(0).text()
    // id = $(e.currentTarget).parent().parent().attr('id');
    let id = $(e.currentTarget).attr('rowid');
    // let taget = e.currentTarget
    // let currPage = $(e.currentTarget).attr('currentPage')
    // console.log(id)
    // console.log(localStorage.getItem('currentPage'))
    // console.log(localStorage.getItem('searchCondition'))
    // console.log(localStorage.getItem('keyword'))
    // console.log(localStorage.getItem('perPage'))

    // let page = e.currentTarget.getAttribute('page'); //page라는 속성을 읽어와서 사용하겠다  
    // let amount = e.currentTarget.getAttribute('amount'); //page라는 속성을 읽어와서 사용하겠다  
    // let searchCondition = e.currentTarget.getAttribute('searchCondition')
    // let keyword = e.currentTarget.getAttribute('keyword')

    $.ajax({
        url: 'noticeDelListAjax.do?id=' + id,
        dataType: 'json',
        success: function (result) {
            console.log(result)
            if (result.retCode == 'Success') {
                alert('💥펑💥')
                let page = localStorage.getItem('currentPage')
                let amount = localStorage.getItem('perPage')
                let searchCondition = localStorage.getItem('searchCondition')
                let keyword = localStorage.getItem('keyword')

                ajaxCall(page, amount, searchCondition, keyword)
            } else {
                alert('💥삭제 실패💥')
            }
        },
        error: function (reject) {
            console.log(reject)
        }
    })
}

//🍓 페이징에 번호 클릭하면 페이지 이동하는 함수 
function pageChangeFnc(e) {
    e.preventDefault();
    // console.log(e.currentTarget.innerText) //번호를 눌렀을 때의 이벤트의 currentTarget의 innerText를 하면 번호가 나옴
    // let page = e.currentTarget.innerText;  //<a>25</a> 
    let page = e.currentTarget.getAttribute('page'); //page라는 속성을 읽어와서 사용하겠다  
    let amount = e.currentTarget.getAttribute('amount'); //page라는 속성을 읽어와서 사용하겠다  
    let searchCondition = e.currentTarget.getAttribute('searchCondition')
    let keyword = e.currentTarget.getAttribute('keyword')
    ajaxCall(page, amount, searchCondition, keyword);
}

// 🍓Ajax호출하는 함수 
function ajaxCall(page, amount, searchCondition, keyword) { //페이지를 매개변수로 받아와야함
    console.log(searchCondition)
    console.log(keyword)
    //🍓list만들어주는 함수 
    $.ajax({
        url: `noticePagingAjax.do?page=` + page + '&amount=' + amount + '&searchCondition=' +
            searchCondition + '&keyword=' + keyword, //[{},{},{}...{}]
        dataType: 'json',
        success: function (result) {
            console.log(result)
            $('#list tr').remove(); //기존 화면 지우고 페이징에 누르는 번호의 페이지를 띄움 
            //가지고 온 배열을 루핑돌면서 값을 꺼내옴 
            for (let i = 0; i < result.length; i++) {
                $('#list').append(makeTr(result[i]))

            }
        },
        error: function (error) {
            console.log(error)
        }
    })

    //🍓pageDTO 생성하는 부분(paging 넣는 함수 )
    $.ajax({
        url: `noticePagingDTO.do?page=` + page + '&amount=' + amount + '&searchCondition=' +
            searchCondition + '&keyword=' + keyword,
        dataType: 'json',
        success: function (result) {
            console.log(result)
            $('.pagination a').remove();
            let start = result.startPage;
            let end = result.endPage;
            let curr = result.currPage;
            let prev = result.prev;
            let next = result.next;
            let total = result.total;
            //이전 페이지 있는지 있으면 생성
            if (prev) {
                $('.pagination').append(
                    $('<a href=""/>').html('🍓').attr('page', 1).attr('amount', amount).attr(
                        'keyword', keyword).attr('searchCondition', searchCondition).on('click',
                        pageChangeFnc)
                )
                $('.pagination').append(
                    $('<a href=""/>').html('&laquo;').attr('page', start - 1).attr('amount', amount)
                    .attr('keyword', keyword).attr('searchCondition', searchCondition).on('click',
                        pageChangeFnc)
                )

            }
            for (let p = start; p <= end; p++) {
                let atag = $('<a href="noticePagingAjax.do"/>').text(p).attr('page', p).attr('amount',
                    amount).attr('keyword', keyword).attr('searchCondition',
                    searchCondition) //페이지라는 속성을 하나 추가해줌
                atag.on('click', pageChangeFnc)
                if (p == curr) {
                    atag.addClass('active') //현재 페이지 정보
                    localStorage.setItem('currentPage', curr); //localStorage 웹 페이지 마다 있는 속성 값=>currentPage정보를 담아놓음  //여러페이지에서 공유 가능함
                    localStorage.setItem('searchCondition', $('#searchCondition').val())
                    localStorage.setItem('keyword', $('#keyword').val())
                    localStorage.setItem('perPage', $('#perPage').val())

                }
                $('.pagination').append(atag)

            }
            //🍓이후 페이지 있는지 있으면 생성 
            if (next) {

                $('.pagination').append(
                    $('<a href=""/>').html('&raquo;').attr('page', end + 1).attr('amount', amount)
                    .attr('keyword', keyword).attr('searchCondition', searchCondition).on('click',
                        pageChangeFnc)
                )
                $('.pagination').append(
                    $('<a href="" />').html('🍓').attr('amount', amount).attr('page', Math.ceil(
                        total / amount)).attr('keyword', keyword).attr('searchCondition',
                        searchCondition).on('click', pageChangeFnc)
                )
            }

        },
        error: function (error) {
            console.log(error);
        }
    })


}

//🍓서버가 로딩되면 1페이지부터 나오도록 설정 
//설정된 amount값으로 리스트 개수를 출력함
let amount = $('#perPage').val();
ajaxCall(1, amount) //페이지 정보와 amount를 같이 넘김

//🍓목록을 선택 하면 변경 되도록 하는 함수 
$('#perPage').on('change', function () {
    //이벤트를 받는 대상 = this
    ajaxCall(1, $(this).val());
})

//🍓 검색 버튼
$('#searchBtn').on('click', function () {
    let searchCondition = $('#searchCondition').val();
    let keyword = $('#keyword').val();

    //아작스 호출
    ajaxCall(1, $('#perPage').val(), searchCondition, keyword)
})


//🍓공지사항 등록🍓 
//🍓form submit 이벤트
$('#frm').on('submit', function (e) {
    e.preventDefault() //기본submit 이벤트 차단
    // let frm = $('#frm')
    let frm = document.getElementById('frm');
    let fData = new FormData(frm); //폼의 데이터를 쉽게 가지고 올수 있음  -> 얘 자체가 멀티파트 요청임
    for (let val of fData.entries()) {
        console.log(val)

    }
    // if(fData)  //값이 제대로 넘어오는지 확인
    //     return
    $.ajax({
        url: 'noticeInsertAjax.do', //처리하는 컨트롤 생성해야함
        method: 'post',
        data: fData,
        dataType: 'json',

        processData: false, //멀티파트로 넘기기 위해서 써줘야함
        contentType: false, ///멀티파트로 넘기기 위해서 써줘야함
       
        success: function (result) {
            console.log(result)
            if (result.retCode == 'Success') { //페이지 그려줄때 페이지 개수 정보랑, 현재 페이지 정보만 넘겨야함// 작성자 정보는 넘기지않아도 됨

                //아작스 호출  -> 처리가 되었다는 ajax콜만 하면 됨
                ajaxCall(1, $('#perPage').val(), null, null)

            } else {
                alert('처리중 오류 발생')
            }
        },
        error: function (error) {
            console.log(error)
        }
    })
})