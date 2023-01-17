/**
app.js
 * 
 */
import router from './router/router.js'  //라우터
//router-view는 라우터 정보를 화면에 그려줌
const template =`
<div id="app">
	<router-view></router-view>
</div>
`
new Vue({
	el:'#app',
	template,		//template : template,
	router			//router :{router:router}  //라우터는 라우터를 불러온더
	
})