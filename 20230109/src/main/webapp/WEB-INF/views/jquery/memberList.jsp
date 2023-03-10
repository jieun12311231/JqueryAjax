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
        <h1>πν μ κ° μπ</h1>
    </div>
    <div>
        <form id="frm" action="memberJoin.do" onsubmit="return formCheck()" method="post">
            <div>
                <table class="table" border="1">
                    <tr>
                        <th width="150">μμ΄λ</th>
                        <td width="300"><input type="text" id="memberId" name="memberId" required="required"
                                value="user1" title="μμ΄λλ₯Ό μλ ₯νμΈμ©.">&nbsp;
                            <button type="button" onclick="idChk()" id="btnId" value="No">μ€λ³΅μ²΄ν¬</button>
                        </td>
                    </tr>
                    <tr>
                        <th width="150">μ΄λ¦</th>
                        <td><input type="text" id="memberName" name="memberName" required="required" value="user1"title="μ΄λ¦μ μλ ₯νμΈμ©."></td>
                    </tr>
                    <tr>
                        <th width="150">ν¨μ€μλ</th>
                        <td><input type="password" id="memberPassword" name="memberPassword" required="required"
                                value="1234" title="λΉλ°λ²νΈλ₯Ό μλ ₯νμΈμ©."></td>
                    </tr>
                    <tr>
                        <th width="150">ν¨μ€μλνμΈ</th>
                        <td><input type="password" id="passwordChk" required="required" value="1234"></td>
                    </tr>
                    <tr>
                        <th width="150">λμ΄</th>
                        <td><input type="text" id="memberAge" name="memberAge" value="20" title="λμ΄λ₯Ό μλ ₯νμΈμ©."></td>
                    </tr>
                    <tr>
                        <th width="150">μ£Όμ</th>
                        <td><input type="text" id="memberAddress" name="memberAddress" value="λκ΅¬" title="μ£Όμλ₯Ό μλ ₯νμΈμ©."></td>
                    </tr>
                    <tr>
                        <th width="150">μ νλ²νΈ</th>
                        <td><input type="tel" id="memberTel" name="memberTel" value="010-1234-5678" title="μ νλ²νΈλ₯Ό μλ ₯νμΈμ©."></td>
                    </tr>
                </table>
            </div>
            <br> <input type="submit" value="νμκ°μ">&nbsp;&nbsp; <input type="reset" value="μ·¨μ">&nbsp;&nbsp; <input
                type="button" onclick="location.href='main.do'" value="νκ°κΈ°">
        </form>
    </div>
    <table class="table">
        <div align="center">
            <br>
            <h3>πνμ λͺ©λ‘π</h3>
        </div>
        <thead>
            <tr>
                <th>μμ΄λ</th>
                <th>μ΄λ¦</th>
                <th>λμ΄</th>
                <th>μ£Όμ</th>
                <th>μ°λ½μ²</th>
                <th>μ­μ </th>
                <th>μμ </th>
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
    //πdbμμ κ°μ κ°μ§κ³  μμ trμ λ§λ€μ΄μ λ¦¬μ€νΈ μΆλ ₯
    function makeRow(obj = {}) { //κ°μ²΄ κ°μ΄ λ€μ΄μ¨λ€λ κ²μ  μλ €μ£ΌκΈ° μν΄
        let tr = $('<tr />').append( //μμ λ§λ€λλ '<>'  μμ μ°Ύμμ¬λλ '' 
            $('<td />').text(obj.memberId),
            $('<td />').text(obj.memberName),
            $('<td />').text(obj.memberAge),
            $('<td />').text(obj.memberAddress),
            $('<td />').text(obj.memberTel),
            $('<td />').append($('<button />').text('μ­μ ').on('click', delMemberFnc)),
            $('<td />').append($('<button />').text('μμ ').on('click', modifyFormFnc))
        );
        tr.attr('id', obj.memberId) //trμ attributeμ idλ₯Ό λ§λ€μ΄μ£ΌκΈ°
        return tr;
    }
    //πμμ  λλ₯΄λ©΄ νλ©΄ μμ ν  μ μλλ‘  μλ‘μ΄ trλ§λ€κΈ° (replace)
    function modifyFormFnc(e) {
        console.log(e);
        let id = $(e.currentTarget).parent().parent().attr('id') //μ΄λ²€νΈκ° μΌμ΄λλ©΄ μΌμ΄λλ μ΄λ²€νΈμ currentTargetλ₯Ό μ½μ΄μ΄
        $.ajax({ //μλ²μ μλ λ°μ΄ν°λ₯Ό κ°μ§κ³  μ€κΈ° μν΄μ ajaxλ₯Ό μ¬μ©! => νΈνκ² λ°μ΄ν°λ₯Ό κ°μ§κ³  μ¬ μ μμ //ajaxμμ κ°μ²΄νμμ key:vakueννμ μ΅μμ λ£μ΄μ£Όλμ€ 
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
                    $('<td />').append($('<button />').text('μ­μ ').attr('disabled', 'disabled')),
                    $('<td />').append($('<button />').text('λ³κ²½').on('click', updateMemberAjax))

                );
                ntr.attr('id', result.memberId); //π₯idκ°μ΄ μμ΄μΌμ§ λμ²΄κ° κ°λ₯ν¨!!
                $('#' + id).replaceWith(ntr) //κΈ°μ‘΄μ idκ° μλ κ³³μ μλ‘ λ§λλ trκ³Ό κΈ°μ‘΄μ μλ trμ replace

            },
            error: function (reject) {
                console.log(reject);
            }
        })

    }
    //πλ³κ²½ λ²νΌ λλ₯΄λ©΄ μμ  λλλ‘
    function updateMemberAjax(e) {
        let tr = $(e.currentTarget).parent().parent() //λ²νΌ ->td ->tr
        console.log(tr)
        let id = tr.children().eq(0).text(); //trμ μμ μ€ μ²«λ²μ§Έ μμμ textκ°μ κ°μ§κ³  μ€κ² λ€.
        let address = tr.children().eq(3).children().eq(0).val();
        let phone = tr.children().eq(4).children().eq(0).val(); //trμ μμ μ€μμ 5λ²μ§Έμ μλ μμ(td)μ μ²«λ²μ§Έ μμ(input)μ text
        console.log(phone)

        $.ajax({
            url: 'updateMemberAjax.do',
            method: 'post',
            data: { //μλ²μμ νλΌλ―Έν°λ‘ λμ΄κ°λ κ°μ μ΄λ¦
                id: id,
                address: address,
                phone: phone
            },
            dataType: 'json',
            success: function (result) {
                console.log(result)
                $('#' + id).replaceWith(makeRow(result.data)) //μλ‘ dataλΌλ λ€μ΄μ¨ κ°μ²΄λ‘ λμ²΄ν¨ 
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //πνμ μ­μ μ²λ¦¬ 
    function delMemberFnc(e) { //μ΄λ²€νΈλ κΈ°λ³Έκ°μΌλ‘ μ΄λ²€νΈκ° λμ΄μ΄ 
        console.log(e);

        let id = $(e.currentTarget).parent().parent().children().eq(0).text(); //μ­μ  λ²νΌμ λΆλͺ¨μ λΆλͺ¨μΌ μμμ€μ μ²«λ²μ§Έμ text
        id = $(e.currentTarget).parent().parent().attr('id') //idλΌλ κ°μ μ½μ΄λλ¦¬κ² λ€
        console.log(id)
        $.ajax({
            url: 'memberDelAjax.do',
            method: 'post',
            dataType: 'json',
            data: {
                id: id //νλΌλ―Έν°κ°
            },
            success: function (result) {
                console.log(result)
                if (result.retCode == 'Success') { // //νλ©΄μμλ μ§μ°κΈ° μν¨
                    console.log('μ­μ μ')
                    $('#' + id).remove();
                } else {
                    alert('μ²λ¦¬μ€ μλ¬ λ°μ ')
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //πμλ²μμ λ°μ΄ν°λ₯Ό κ°μ§κ³  μμ κ° μΆλ ₯νκΈ°
    //νλ©΄μ΄ λ‘λ©λλ©΄ λͺ©λ‘ μΆλ ₯
    $.ajax({
        url: 'memberListAjax.do', //jso ν¬λ§·μΌλ‘ κ°μ§κ³  νμ λͺ©λ‘ κ°μ§κ³  μ€κΈ° 
        dataType: 'json',
        success: function (result) {
            console.log(result) //μλ°μ€ν¬λ¦½νΈμ λ°°μ΄κ°μ²΄  foreachλ₯Ό ν΅ν΄μ λ°°μ΄μ κΊΌλΌμμμ 
            $(result).each(function (idx, item) { //jqueryκ°μ²΄λ‘ λ³κ²½  (λ°°μ΄μ΄λ©΄ eachμ¬μ©νλ©΄λ¨)

                if (item.memberAge > 0) //λμ΄κ° 0μ΄λ©΄ μΆλ ₯ μλκ² 
                    $('#memberList').append(makeRow(item));

            })
        },
        error: function (reject) {
            console.log(reject)
        }
    })


    //πμμ΄λ μ€λ³΅μ²΄ν¬
    function idChk() {
        let searchId = $('#memberId').val() //inputνν¬ μ°Ύμμ€κΈ° . inutνκ·Έμ valueκ°
        $.ajax({
            url: `AjaxMemberIdCheck.do`,
            data: {
                id: searchId
            }, //`id=${searchId}`,  μλ²λ‘ λμ΄κ° νλΌλ―Έν° κ° μ€μ 
            method: 'post', //λμλ¬Έμ μκ΄μμ
            success: function (result) { //successλΌλ λ©μλ
                console.log(result)
                if (result == 0) {
                    //alert('μ΄λ―Έ μ‘΄μ¬νλ μμ΄λμλλ€.')
                    $('#dialog p').text('μ΄λ―Έ μ‘΄μ¬νλ μμ΄λ μλλ€ .')
                    $("#dialog").dialog();
                    $('#memberId').val("");
                } else {
                    //alert('μ¬μ© κ°λ₯ν μμ΄λμλλ€.')
                    $('#dialog p').text('μ¬μ© κ°λ₯ν μμ΄λ μλλ€.')
                    $("#dialog").dialog();
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
    }

    //πonsubmit => submitμ΄λΌκ³  κ°λ€κ³  λ³΄λ©΄λμ§λ§ trueμ΄λ©΄ formμ submitμ΄ μ§νλλλ‘ν¨ 
    function formCheck() {
        console.log('hhh')
        let password1 = $('#memberPassword').val()
        let password2 = $('#passwordChk').val()

        if (password1 != password2) {
            alert('λΉλ°λ²νΈκ° μΌμΉνμ§μμ΅λλ€.')
            return false; //returnκ°μ΄ falseκ° μλλ©΄ νμ΄μ§κ° λμ΄κ°κΈ° λλ¬Έμ νμ΄μ§λ₯Ό λμ΄κ°μ§ μκ²νκΈ°μν΄μ falseλ₯Ό λ£μ΄μ€μΌν¨.
        }

        let params = $('#frm').serialize(); //serialize : key:valueννλ‘ κ°μ μμμ λ΄μμ΄
        console.log(params)

        //λΉλ°λ²νΈκ° μΌμΉνλ©΄ μ§νλλ κ³΅κ° -> λ°λ‘ λ¦¬μ€νΈμ μμ±λ¨
        //ajaxνΈμΆ
        $.ajax({
            url: 'memberAddAjax.do', //μμ²­ νμ΄μ§
            method: 'post', //μμ²­ λ°©μ
            data: params, //μλ²μ μ μ‘ν  λ°μ΄ν° 
            dataType: 'json', //μλμΌλ‘ μ μ΄μ¨ νμμΌλ‘ λ°λμ€
            success: function (result) {
                console.log(result)
                if (result.retCode == 'Success') {
                    $('#memberList').append(makeRow(result.data)); //trμμ±ν΄μ tbodyμ λΆμ
                } else {
                    alert('μ²λ¦¬ μ€ μλ¬ λ°μ')
                }
            },
            error: function (reject) {
                console.log(reject)
            }
        })
        return false; //return false νλ©΄ μ΄ νμ΄μ§μ κ³μ λ¨Έλ¬Όλ¬ μμ  // return trueλ₯Ό νλ©΄ νμ΄μ§λ₯Ό μ΄λν΄λ²λ¦Ό
    }
</script>