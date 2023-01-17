/**
 * EditProduct
 */
export default{
template:`
<div>
    <h1>상품 정보 수정</h1>
상품 가격: <input type="text" v-model="price">
상품 이름: <input type="text" v-model="title">
상품 설명: <textarea type="text" v-model="description"></textarea>
<button v-on:click="changeInfo">수정</button>
  </div>
`,
data(){
    return{
        price:'변경 상품가격',
        title:'변경 상품명',
        description:'변경 상품설명',
    }
},
methods:{
    changeInfo:function(){
        console.log(this)
        console.log(this.price)
        this.$parent.product.price = this.price
        this.$parent.product.title = this.title
        this.$parent.product.description = this.description


    }
},

//??????????? 수정 버튼 누르면 배열에 담길수있도록하기->메인에서도 새로 수정한 정보가 뜨도록
created:function(){
    axios.get('./static/products.json')
    .then((reponse)=>{
        console.log(this)
        reponse.data.products.price = this.$parent.product.price
        return
    })
}
}