/**
bookVue.js
 * 
 */
const memberAry = [];

const addComponent = {
    template: `
        <div id="addMember">
            <table class="table">
                <tr>
                <th>{{idLabel}}</th>
                <td><input type="text" v-model="mId"></td>
                
                </tr>
                <tr>
                <th>{{nameLabel}}</th>
                <td><input type="text" v-model="mName"></td>
                
                </tr>
                <tr>
                <th>{{ageLabel}}</th>
                <td><input type="text" v-model="mAge"></td>
                
                </tr>
                <tr>
                <th>{{telLabel}}</th>
                <td><input type="text" v-model="mTel"></td>
                
                </tr>
                <tr>
                <th>{{addrLabel}}</th>
                <td><input type="text" v-model="mAddr"></td>
                
                </tr>
                <tr>
                
                <td align="center" colspan="2">
                <br>
                    <button v-bind:style="{color:myColor}" class="btn btn-dark" v-on:click="addMember">회원등록</button>
                    <button class="btn btn-dark" v-on:click="selectedMemberDel">선택삭제</button>
                </td>
                
                </tr>
            </table>
        </div>
    
    `,
    data: function () {
        return {
            //라벨
            idLabel: '회원 아이디',
            nameLabel: '회원 이름',
            ageLabel: '회원 나이',
            telLabel: '회원 연락처',
            addrLabel: '회원 주소',
            //입력
            mId: 'User1',
            mName: '짱구',
            mAge: '5',
            mTel: '010-5555-5555',
            mAddr: '떡잎마을',

            members: memberAry, //여기 변수에 접근하여서 변경하기 위해서 적어줌
            myColor:'black'
        }
    },
    methods: {
        addMember: function () {
            let params = 'memberId=' + this.mId +
                '&memberName=' + this.mName +
                '&memberPassword=1234' +
                '&memberTel=' + this.mTel +
                '&memberAge=' + this.mAge +
                '&memberAddress=' + this.mAddr
            // console.log(params)
            fetch('../memberAddAjax.do', {
                    method: 'post',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: params
                })
                .then(result => result.json())
                .then(result => {
                    console.log(result)

                })
                .catch(err => console.log(err))
        },
        selectedMemberDel: function () {
            console.log(this)

        }
    }

}
const listComponent = {
    template: `
        <table class="table">
        <thead>
            <tr>
                <th>회원 아이디</th>
                <th>회원 이름</th>
                <th>나이</th>
                <th>연락처</th>
                <th>주소</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="member in members">
            <td>{{member.memberId}}</td>
            <td>{{member.memberName}}</td>
            <td>{{member.memberAge}}</td>
            <td>{{member.memberTel}}</td>
            <td>{{member.memberAddress}}</td>
            <td><button v-on:click="delMember(member.memberId)">삭제</button></td>
            </tr>
        </tbody>
    </table>
    
    `,
    data: function () {
        return {
            members: memberAry

        }
    },
    methods: { //💥
        delMember: function (id) {
            console.log(id)
            fetch('../memberDelAjax.do?id=' + id) //💥경로 주의💥
                .then(result => result.json())
                .then(result => {
                    console.log(result)
                    if (result.retCode == 'Success') {
                        this.members.forEach((member, idx) => {
                            if (member.memberId == id) { //삭제 아이디와 동일한 값을 배열에서 제거 
                                this.members.splice(idx, 1);
                            }
                        })
                    } else {
                        alert('오류발생')
                    }
                })
                .catch(err => {
                    console.log(err)
                })
        }
    }
}

new Vue({
    el: "#app",
    components: {
        'add-component': addComponent,
        'list-component': listComponent
    },
    data: {
        members: memberAry
    },
    methods: {

    },
    //Vue의 라이프사이클
    beforeCreate: function () {
        console.log('beforeCreate hook')
    },
    created: function () {
        console.log('created hook')
        fetch('../memberListAjax.do')
            .then(result => result.json())
            .then(result => {
                console.log(result)
                result.forEach(member => {
                    this.members.push(member);
                });

            })
            .catch(err => {
                console.log(err)
            })
    },
    beforeMount: function () {
        console.log('beforeMount hook')

    },
    mounted: function () {
        console.log('mounted hook')

    }
})