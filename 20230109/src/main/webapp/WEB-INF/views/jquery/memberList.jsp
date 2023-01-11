<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/style.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>
    @font-face {
        font-family: 'GangwonEdu_OTFBoldA';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    *{
        font-family: 'GangwonEdu_OTFBoldA';
    }
    </style>
<div align="center">
    <div>
    <br>
        <h1>🍓회 원 가 입🍓</h1>
    </div>
    <div>
        <form id="frm" action="memberJoin.do" onsubmit="return formCheck()" method="post">
            <div>
                <table class="table" border="1">
                    <tr>
                        <th width="150">아이디</th>
                        <td width="300"><input type="text" id="memberId" name="memberId" required="required"
                                value="user1" title="아이디를 입력하세용.">&nbsp;
                            <button type="button" onclick="idChk()" id="btnId" value="No">중복체크</button>
                        </td>
                    </tr>
                    <tr>
                        <th width="150">이름</th>
                        <td><input type="text" id="memberName" name="memberName" required="required" value="user1"title="이름을 입력하세용."></td>
                    </tr>
                    <tr>
                        <th width="150">패스워드</th>
                        <td><input type="password" id="memberPassword" name="memberPassword" required="required"
                                value="1234" title="비밀번호를 입력하세용."></td>
                    </tr>
                    <tr>
                        <th width="150">패스워드확인</th>
                        <td><input type="password" id="passwordChk" required="required" value="1234"></td>
                    </tr>
                    <tr>
                        <th width="150">나이</th>
                        <td><input type="text" id="memberAge" name="memberAge" value="20" title="나이를 입력하세용."></td>
                    </tr>
                    <tr>
                        <th width="150">주소</th>
                        <td><input type="text" id="memberAddress" name="memberAddress" value="대구" title="주소를 입력하세용."></td>
                    </tr>
                    <tr>
                        <th width="150">전화번호</th>
                        <td><input type="tel" id="memberTel" name="memberTel" value="010-1234-5678" title="전화번호를 입력하세용."></td>
                    </tr>
                </table>
            </div>
            <br> <input type="submit" value="회원가입">&nbsp;&nbsp; <input type="reset" value="취소">&nbsp;&nbsp; <input
                type="button" onclick="location.href='main.do'" value="홈가기">
        </form>
    </div>
    <table class="table">
        <div align="center">
            <br>
            <h3>🍓회원 목록🍓</h3>
        </div>
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>나이</th>
                <th>주소</th>
                <th>연락처</th>
                <th>삭제</th>
                <th>수정</th>
            </tr>
        </thead>
        <tbody id="memberList"></tbody>
    </table>
</div>
<div id="dialog" title="Basic dialog">
    <p></p>
</div>
<script>
    $(function () {
        var tooltips = $("[title]").tooltip({
            position: {
                my: "left top",
                at: "right+5 top-5",
                collision: "none"
            }
        });
        
    });
    //🍓db에서 값을 가지고 와서 tr을 만들어서 리스트 출력
    function makeRow(obj = {}) { //객체 값이 들어온다는 것을  알려주기 위해
        let tr = $('<tr />').append( //요소 만들때는 '<>'  요소 찾아올때는 '' 
            $('<td />').text(obj.memberId),
            $('<td />').text(obj.memberName),
            $('<td />').text(obj.memberAge),
            $('<td />').text(obj.memberAddress),
            $('<td />').text(obj.memberTel),
            $('<td />').append($('<button />').text('삭제').on('click', delMemberFnc)),
            $('<td />').append($('<button />').text('수정').on('click', modifyFormFnc))
        );
        tr.attr('id', obj.memberId) //tr의 attribute에 id를 만들어주기
        return tr;
    }
    //🍓수정 누르면 화면 수정할 수 있도록  새로운 tr만들기 (replace)
    function modifyFormFnc(e) {
        console.log(e);
        let id = $(e.currentTarget).parent().parent().attr('id') //이벤트가 일어나면 일어나는 이벤트의 currentTarget를 읽어옴
        $.ajax({ //서버에 있는 데이터를 가지고 오기 위해서 ajax를 사용! => 편하게 데이터를 가지고 올 수 있음 //ajax안에 객체타입의 key:vakue형태의 옵션을 넣어주는중 
            url: 'memberGetAjax.do?id=' + id,
            // method: 'get',
            dataType: 'json',
            success: function (result) {
                console.log(result)
                let ntr = $('<tr />').append(
                    $('<td />').text(result.memberId),
                    $('<td />').text(result.memberName),
                    $('<td />').text(result.memberAge),
                    $('<td />').append($('<input />').attr('type', 'text').val(result.memberAddress)),
                    $('<td />').append($('<input />').attr('type', 'text').val(result.memberTel)),
                    $('<td />').append($('<button />').text('삭제').attr('disabled', 'disabled')),
                    $('<td />').append($('<button />').text('변경').on('click', updateMemberAjax))

                );
                ntr.attr('id', result.memberId); //💥id값이 있어야지 대체가 가능함!!
                $('#' + id).replaceWith(ntr) //기존의 id가 있는 곳에 새로 만드는 tr과 기존에 있던 tr을 replace

            },
            error: function (reject) {
                console.log(reject);
            }
        })

    }
    //🍓변경 버튼 누르면 수정 되도록
    function updateMemberAjax(e) {
        let tr = $(e.currentTarget).parent().parent() //버튼 ->td ->tr
        console.log(tr)
        let id = tr.children().eq(0).text(); //tr의 자식 중 첫번째 자식의 text값을 가지고 오겠다.
        let address = tr.children().eq(3).children().eq(0).val();
        let phone = tr.children().eq(4).children().eq(0).val(); //tr의 자식 중에서 5번째에 있는 자식(td)의 첫번째 자식(input)의 text
        console.log(phone)

        $.ajax({
            url: 'updateMemberAjax.do',
            method: 'post',
            data: { //서버에서 파라미터로 넘어가는 값의 이름
                id: id,
                address: address,
                phone: phone
            },
            dataType: 'json',
            success: function (result) {
                console.log(result)
                $('#' + id).replaceWith(makeRow(result.data)) //새로 data라는 들어온 객체로 대체함 
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //🍓회원 삭제처리 
    function delMemberFnc(e) { //이벤트는 기본값으로 이벤트가 넘어옴 
        console.log(e);

        let id = $(e.currentTarget).parent().parent().children().eq(0).text(); //삭제 버튼의 부모의 부모으 자식중에 첫번째의 text
        id = $(e.currentTarget).parent().parent().attr('id') //id라는 값을 읽어드리겠다
        console.log(id)
        $.ajax({
            url: 'memberDelAjax.do',
            method: 'post',
            dataType: 'json',
            data: {
                id: id //파라미터값
            },
            success: function (result) {
                console.log(result)
                if (result.retCode == 'Success') { // //화면에서도 지우기 위함
                    console.log('삭제완')
                    $('#' + id).remove();
                } else {
                    alert('처리중 에러 발생 ')
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //🍓서버에서 데이터를 가지고 와서 값 출력하기
    //화면이 로딩되면 목록 출력
    $.ajax({
        url: 'memberListAjax.do', //jso 포맷으로 가지고 회원 목록 가지고 오기 
        dataType: 'json',
        success: function (result) {
            console.log(result) //자바스크립트의 배열객체  foreach를 통해서 배열을 꺼낼수있음 
            $(result).each(function (idx, item) { //jquery객체로 변경  (배열이면 each사용하면됨)

                if (item.memberAge > 0) //나이가 0이면 출력 안되게 
                    $('#memberList').append(makeRow(item));

            })
        },
        error: function (reject) {
            console.log(reject)
        }
    })


    //🍓아이디 중복체크
    function idChk() {
        let searchId = $('#memberId').val() //input태크 찾아오기 . inut태그의 value값
        $.ajax({
            url: `AjaxMemberIdCheck.do`,
            data: {
                id: searchId
            }, //`id=${searchId}`,  서버로 넘어갈 파라미터 값 설정
            method: 'post', //대소문자 상관없음
            success: function (result) { //success라는 메소드
                console.log(result)
                if (result == 0) {
                    //alert('이미 존재하는 아이디입니다.')
                    $('#dialog p').text('이미 존재하는 아이디 입니다 .')
                    $("#dialog").dialog();
                    $('#memberId').val("");
                } else {
                    //alert('사용 가능한 아이디입니다.')
                    $('#dialog p').text('사용 가능한 아이디 입니다.')
                    $("#dialog").dialog();
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //🍓onsubmit => submit이라고 같다고 보면되지만 true이면 form의 submit이 진행되도록함 
    function formCheck() {
        console.log('hhh')
        let password1 = $('#memberPassword').val()
        let password2 = $('#passwordChk').val()

        if (password1 != password2) {
            alert('비밀번호가 일치하지않습니다.')
            return false; //return값이 false가 아니면 페이지가 넘어가기 때문에 페이지를 넘어가지 않게하기위해서 false를 넣어줘야함.
        }

        let params = $('#frm').serialize(); //serialize : key:value형태로 값을 알아서 담아옴
        console.log(params)

        //비밀번호가 일치하면 진행되는 공간 -> 바로 리스트에 생성됨
        //ajax호출
        $.ajax({
            url: 'memberAddAjax.do', //요청 페이지
            method: 'post', //요청 방식
            data: params, //서버에 전송할 데이터 
            dataType: 'json', //자동으로 제이슨 타입으로 바뀌줌
            success: function (result) {
                console.log(result)
                if (result.retCode == 'Success') {
                    $('#memberList').append(makeRow(result.data)); //tr생성해서 tbody에 붙임
                } else {
                    alert('처리 중 에러 발생')
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
        return false; //return false 하면 이 페이지에 계속 머물러 있음  // return true를 하면 페이지를 이동해버림
    }
</script>