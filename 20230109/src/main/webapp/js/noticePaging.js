/**
 * 
noticePaging.js
 */

//๐tr๋ง๋๋ ํจ์

function makeTr(obj = {}) {
    let tr = $('<tr />').append(
        $('<td />').text(obj.noticeId), //๋์ด์จ ์์ฑ ๊ฐ์ด ๊ทธ๋๋ก ๋์ด ์์ผํจ
        $('<td />').text(obj.noticeWriter),
        $('<td />').text(obj.noticeDate),
        $('<td />').text(obj.noticeTitle),
        $('<td />').text(obj.noticeFile),
        $('<td />').text(obj.noticeHit),
        $('<td />').append($('<button />')
            .text('๐ฅ').attr('rowid', obj.noticeId)
            .on('click', delNoticeList))

    )
    // tr.attr('id', obj.noticeId)
    return tr
}

//๐noticeList์ง์ฐ๋ ๊ธฐ๋ฅ 
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

    // let page = e.currentTarget.getAttribute('page'); //page๋ผ๋ ์์ฑ์ ์ฝ์ด์์ ์ฌ์ฉํ๊ฒ ๋ค  
    // let amount = e.currentTarget.getAttribute('amount'); //page๋ผ๋ ์์ฑ์ ์ฝ์ด์์ ์ฌ์ฉํ๊ฒ ๋ค  
    // let searchCondition = e.currentTarget.getAttribute('searchCondition')
    // let keyword = e.currentTarget.getAttribute('keyword')

    $.ajax({
        url: 'noticeDelListAjax.do?id=' + id,
        dataType: 'json',
        success: function (result) {
            console.log(result)
            if (result.retCode == 'Success') {
                alert('๐ฅํ๐ฅ')
                let page = localStorage.getItem('currentPage')
                let amount = localStorage.getItem('perPage')
                let searchCondition = localStorage.getItem('searchCondition')
                let keyword = localStorage.getItem('keyword')

                ajaxCall(page, amount, searchCondition, keyword)
            } else {
                alert('๐ฅ์ญ์  ์คํจ๐ฅ')
            }
        },
        error: function (reject) {
            console.log(reject)
        }
    })
}

//๐ ํ์ด์ง์ ๋ฒํธ ํด๋ฆญํ๋ฉด ํ์ด์ง ์ด๋ํ๋ ํจ์ 
function pageChangeFnc(e) {
    e.preventDefault();
    // console.log(e.currentTarget.innerText) //๋ฒํธ๋ฅผ ๋๋ ์ ๋์ ์ด๋ฒคํธ์ currentTarget์ innerText๋ฅผ ํ๋ฉด ๋ฒํธ๊ฐ ๋์ด
    // let page = e.currentTarget.innerText;  //<a>25</a> 
    let page = e.currentTarget.getAttribute('page'); //page๋ผ๋ ์์ฑ์ ์ฝ์ด์์ ์ฌ์ฉํ๊ฒ ๋ค  
    let amount = e.currentTarget.getAttribute('amount'); //page๋ผ๋ ์์ฑ์ ์ฝ์ด์์ ์ฌ์ฉํ๊ฒ ๋ค  
    let searchCondition = e.currentTarget.getAttribute('searchCondition')
    let keyword = e.currentTarget.getAttribute('keyword')
    ajaxCall(page, amount, searchCondition, keyword);
}

// ๐Ajaxํธ์ถํ๋ ํจ์ 
function ajaxCall(page, amount, searchCondition, keyword) { //ํ์ด์ง๋ฅผ ๋งค๊ฐ๋ณ์๋ก ๋ฐ์์์ผํจ
    console.log(searchCondition)
    console.log(keyword)
    //๐list๋ง๋ค์ด์ฃผ๋ ํจ์ 
    $.ajax({
        url: `noticePagingAjax.do?page=` + page + '&amount=' + amount + '&searchCondition=' +
            searchCondition + '&keyword=' + keyword, //[{},{},{}...{}]
        dataType: 'json',
        success: function (result) {
            console.log(result)
            $('#list tr').remove(); //๊ธฐ์กด ํ๋ฉด ์ง์ฐ๊ณ  ํ์ด์ง์ ๋๋ฅด๋ ๋ฒํธ์ ํ์ด์ง๋ฅผ ๋์ 
            //๊ฐ์ง๊ณ  ์จ ๋ฐฐ์ด์ ๋ฃจํ๋๋ฉด์ ๊ฐ์ ๊บผ๋ด์ด 
            for (let i = 0; i < result.length; i++) {
                $('#list').append(makeTr(result[i]))

            }
        },
        error: function (error) {
            console.log(error)
        }
    })

    //๐pageDTO ์์ฑํ๋ ๋ถ๋ถ(paging ๋ฃ๋ ํจ์ )
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
            //์ด์  ํ์ด์ง ์๋์ง ์์ผ๋ฉด ์์ฑ
            if (prev) {
                $('.pagination').append(
                    $('<a href=""/>').html('๐').attr('page', 1).attr('amount', amount).attr(
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
                    searchCondition) //ํ์ด์ง๋ผ๋ ์์ฑ์ ํ๋ ์ถ๊ฐํด์ค
                atag.on('click', pageChangeFnc)
                if (p == curr) {
                    atag.addClass('active') //ํ์ฌ ํ์ด์ง ์ ๋ณด
                    localStorage.setItem('currentPage', curr); //localStorage ์น ํ์ด์ง ๋ง๋ค ์๋ ์์ฑ ๊ฐ=>currentPage์ ๋ณด๋ฅผ ๋ด์๋์  //์ฌ๋ฌํ์ด์ง์์ ๊ณต์  ๊ฐ๋ฅํจ
                    localStorage.setItem('searchCondition', $('#searchCondition').val())
                    localStorage.setItem('keyword', $('#keyword').val())
                    localStorage.setItem('perPage', $('#perPage').val())

                }
                $('.pagination').append(atag)

            }
            //๐์ดํ ํ์ด์ง ์๋์ง ์์ผ๋ฉด ์์ฑ 
            if (next) {

                $('.pagination').append(
                    $('<a href=""/>').html('&raquo;').attr('page', end + 1).attr('amount', amount)
                    .attr('keyword', keyword).attr('searchCondition', searchCondition).on('click',
                        pageChangeFnc)
                )
                $('.pagination').append(
                    $('<a href="" />').html('๐').attr('amount', amount).attr('page', Math.ceil(
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

//๐์๋ฒ๊ฐ ๋ก๋ฉ๋๋ฉด 1ํ์ด์ง๋ถํฐ ๋์ค๋๋ก ์ค์  
//์ค์ ๋ amount๊ฐ์ผ๋ก ๋ฆฌ์คํธ ๊ฐ์๋ฅผ ์ถ๋ ฅํจ
let amount = $('#perPage').val();
ajaxCall(1, amount) //ํ์ด์ง ์ ๋ณด์ amount๋ฅผ ๊ฐ์ด ๋๊น

//๐๋ชฉ๋ก์ ์ ํ ํ๋ฉด ๋ณ๊ฒฝ ๋๋๋ก ํ๋ ํจ์ 
$('#perPage').on('change', function () {
    //์ด๋ฒคํธ๋ฅผ ๋ฐ๋ ๋์ = this
    ajaxCall(1, $(this).val());
})

//๐ ๊ฒ์ ๋ฒํผ
$('#searchBtn').on('click', function () {
    let searchCondition = $('#searchCondition').val();
    let keyword = $('#keyword').val();

    //์์์ค ํธ์ถ
    ajaxCall(1, $('#perPage').val(), searchCondition, keyword)
})


//๐๊ณต์ง์ฌํญ ๋ฑ๋ก๐ 
//๐form submit ์ด๋ฒคํธ
$('#frm').on('submit', function (e) {
    e.preventDefault() //๊ธฐ๋ณธsubmit ์ด๋ฒคํธ ์ฐจ๋จ
    // let frm = $('#frm')
    let frm = document.getElementById('frm');
    let fData = new FormData(frm); //ํผ์ ๋ฐ์ดํฐ๋ฅผ ์ฝ๊ฒ ๊ฐ์ง๊ณ  ์ฌ์ ์์  -> ์ ์์ฒด๊ฐ ๋ฉํฐํํธ ์์ฒญ์
    for (let val of fData.entries()) {
        console.log(val)

    }
    // if(fData)  //๊ฐ์ด ์ ๋๋ก ๋์ด์ค๋์ง ํ์ธ
    //     return
    $.ajax({
        url: 'noticeInsertAjax.do', //์ฒ๋ฆฌํ๋ ์ปจํธ๋กค ์์ฑํด์ผํจ
        method: 'post',
        data: fData,
        dataType: 'json',

        processData: false, //๋ฉํฐํํธ๋ก ๋๊ธฐ๊ธฐ ์ํด์ ์จ์ค์ผํจ
        contentType: false, ///๋ฉํฐํํธ๋ก ๋๊ธฐ๊ธฐ ์ํด์ ์จ์ค์ผํจ
       
        success: function (result) {
            console.log(result)
            if (result.retCode == 'Success') { //ํ์ด์ง ๊ทธ๋ ค์ค๋ ํ์ด์ง ๊ฐ์ ์ ๋ณด๋, ํ์ฌ ํ์ด์ง ์ ๋ณด๋ง ๋๊ฒจ์ผํจ// ์์ฑ์ ์ ๋ณด๋ ๋๊ธฐ์ง์์๋ ๋จ

                //์์์ค ํธ์ถ  -> ์ฒ๋ฆฌ๊ฐ ๋์๋ค๋ ajax์ฝ๋ง ํ๋ฉด ๋จ
                ajaxCall(1, $('#perPage').val(), null, null)

            } else {
                alert('์ฒ๋ฆฌ์ค ์ค๋ฅ ๋ฐ์')
            }
        },
        error: function (error) {
            console.log(error)
        }
    })
})