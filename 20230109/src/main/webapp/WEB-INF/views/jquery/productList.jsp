<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

<link rel="stylesheet" type="text/css" href="css/slick-theme.css">

<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<style>
	@font-face {
		font-family: 'GangwonEdu_OTFBoldA';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}

	* {
		font-family: 'GangwonEdu_OTFBoldA';
	}
</style>
<!-- Header-->
<header class="bg-dark py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white">
			<div class="all-images">
				<!-- <div><img style="width: 350px; height: 350px;" src="images/과테말라 안티구아.jpg" item="CF001"></div> -->
				<!-- <div><img style="width: 350px; height: 350px;" src="images/니카라구아 더치핸드드립용 분쇄원두.jpg" item="CF002"></div>
				<div><img style="width: 350px; height: 350px;" src="images/브라질산토스.jpg" item="CF003"></div>
				<div><img style="width: 350px; height: 350px;" src="images/에티오피아 예가체프.jpg" item="CF004"></div>
				<div><img style="width: 350px; height: 350px;" src="images/케냐 오크라톡신.jpg" item="CF005"></div>
				<div><img style="width: 350px; height: 350px;" src="images/코스타리카 따라주.jpg" item="CF006"></div> -->
			</div>
		</div>
	</div>
</header>
<!-- Section-->
<!-- template -->
<section class="py-5">
	<div class="container px-4 px-lg-5 mt-5">
		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<div class="col mb-5">
				<div class="card h-100">
					<!-- Sale badge-->
					<div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale
					</div>
					<!-- Product image-->
					<a href="productInfo.do?item="><img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /></a>
					<!-- Product details-->
					<div class="card-body p-4">
						<div class="text-center">
							<!-- Product name-->
							<h5 class="fw-bolder">Special Item</h5>
							<!-- Product reviews-->
							<div class="d-flex justify-content-center small text-warning mb-2">
								<div class="bi-star-fill"></div>
								<div class="bi-star-fill"></div>
								<div class="bi-star-fill"></div>
								<div class="bi-star-half"></div>
								<div class="bi-star"></div>
							</div>
							<!-- Product price-->
							<span class="text-muted text-decoration-line-through">$20.00</span>
							<span>$18.00</span>
						</div>
					</div>
					<!-- Product actions-->
					<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
						<div class="text-center">
							<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
						</div>
					</div>
				</div>
			</div>
			<!-- template -->
		</div>
	</div>
</section>
<!-- <script src="js/jquery-3.6.3.min.js"></script> -->
<script>
	$.ajax({
		url: 'productList.do',
		dataType: 'json',
		success: function (result) {
			console.log(result)
			$(result).each(function (idx, item) {

				//🍓이미지 태그만들기 
				//.all-images 하위에 <div><img src="", item=""></div>
				// $('.all-images').append(
				// 	$('<div />').attr({
				// 		src:"images/"+ $(item.productImage),
				// 		item : $(item.productCode)
				// 	})
				// )

				$('.all-images').append(
					$('<div><img style="width:350px; height:350px;" src="images/'+item.productImage+'" item="'+item.productCode+'"></div>')
				)


				let template = $('div.col.mb-5:nth-child(1)').clone();

				//🍓상품 이름 등록 item.productName
				template.find('h5').text(item.productName) //하위요소를 찾아오기 find

				//🍓상품 이미지 등록 item.productImage
				template.find('img').attr('src', 'images/' + item
					.productImage) //💥 item.productImage 주의

				//🍓첫번째 span - productPrice, 두번째 span - salePrice
				template.find('div.text-center span:nth-of-type(1)').text('￦' + Number(item
						.productPrice)
					.toLocaleString()
				) //nth-of-type : 앞에 적힌 span만 카운트를 함 /nth-child : 해당하는 요소외에도 다른 요소들도 카운트를 해버림
				//template.find('div.text-center span:nth-child(3)').text('￦'+item.productPrice)  //💥nth-child : 해당하는 요소외에도 다른 요소들도 카운트를 해버림  첫번째 요소는 h5 두번째는 div class="d-flex justify-content-center small text-warning mb-2">
				template.find('div.text-center span:nth-of-type(2)').text('￦' + Number(item.salePrice)
					.toLocaleString())

				//🍓평점 ex)3.5 => 3(fill) .5(half) 남은자리 빈별() 
				template.find('div.d-flex div').remove() //먼저 하위요서 remove
				let target = template.find('div.d-flex') //parent요소 지정 
				for (let i = 0; i < 5; i++) {
					if (i < Math.floor(item.likeIt)) //floor 소수점 자리는 버리겠다
						target.append($('<div />').attr('class', 'bi-star-fill')) //3까지는 가득찬 별로 
					else if (i < item.likeIt)
						target.append($('<div />').addClass('bi-star-half')) //0.5 남아있으면 반틈짜리 별로 
					else
						target.append($('<div />').addClass('bi-star')) // 나머지는 빈별로
				}
				//🍓이미지에 상품 코드 넣기
				template.find('a').attr('href', 'productInfo.do?item=' + item.productCode)
			
				$('div.row').append(template) //row밑에 방금 가지고 온 template를 붙임 => 여섯번 반복 하면서 붙을 것
				
				
			})
			//display :none
			$('div.col.mb-5:nth-child(1)').css('display', 'none')
			//slick call -> 호출 순서 때문에 이곳에 있어야함!
				$('.all-images').slick({
					autoplaySpeed: 2000,
					centerMode: true,
					// centerPadding: '60px',
					slidesToScroll: 1,
					slidesToShow: 3,
					autoplay: true

				})
		},
		error: function (reject) {
			console.log(reject);
		}

	})

	

	//슬라이드의 사진을 클릭하면 상세페이지로 이동함 
	$('.all-images').on('click', function (event, slick, direction) {
		console.log(event.target.getAttribute('item'))
		let item = event.target.getAttribute('item');

		//이미지 아닌 곳을 클릭하면 이동 안하도록.
		if (item)  //item값을 가지고 와서 item값이 있으면 링크로 이동하고 아니면은 이벤트가 걸리지 않도록
			$(location).attr('href', 'productInfo.do?item=' + item)
		// location.href = 'productInfo.do?item=' + item;  // 페이지를 호출할때 item을 같이 넘겨줌
	})
</script>