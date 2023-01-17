// router.js :url pattern == component 매핑
import Main from '../components/Main.js'; //컴포넌트를 임포트해서 사용
import Form from '../components/Form.js'; //컴포넌트를 임포트해서 사용
import Product from '../components/Product.js'; //컴포넌트를 임포트해서 사용
import EditProduct from '../components/EditProduct.js'; //컴포넌트를 임포트해서 사용


export default new VueRouter({
    // mode:'history',  //-> url의 #을 제거함
    routes: [{
            path: '/',
            name: 'main',  //링크 호출할때 사용
            component: Main
        },
        {
            path: '/',
            name: 'form',
            component: Form
        },
        {
            path: '/produt/:id',  //id를 파라미터로 넘김
            name: 'Id',
            component: Product,
            children:[
                {
                    path:'edit',
                    name:'edit',
                    component:EditProduct
                }
            ]
        },
        {// 위에 적힌 요청에 해당 되지않는 경우 메인으로 이동하도록
            path:'*',  
            redirect:'/',
        },

    ]
})