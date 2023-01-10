<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 이 부분이 있어야지 별이 그려짐 -->
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<p>상품코드:<span>${productCode}</span></p>
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
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="row gx-4 gx-lg-5 align-items-center">
			<div class="col-md-6">
				<img class="card-img-top mb-5 mb-md-0" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"
					alt="..." />
			</div>
			<div class="col-md-6">
				<div class="small mb-1">${productCode}</div>
				<h1 class="display-5 fw-bolder">Shop item template</h1>
				<div class="fs-5 mb-5">
					<span class="text-decoration-line-through">$45.00</span> <span>$40.00</span>
				</div>
				<p class="lead"></p>
				<div class="d-flex">
					<input class="form-control text-center me-3" id="inputQuantity" type="num" value="1"
						style="max-width: 3rem" />
					<button class="btn btn-outline-dark flex-shrink-0" type="button">
						<i class="bi-cart-fill me-1"></i> Add to cart
					</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Related items section-->
<section class="py-5 bg-light">
	<div class="container px-4 px-lg-5 mt-5">
		<h2 class="fw-bolder mb-4">Related products</h2>
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
			
		
		</div>
	</div>
</section>
<script>

	//상품코드에 따라 상세 정보 가지고 오기 
	let template = $('section.py-5:nth-of-type(1)');
	let item = template.find('div.small.mb-1').text();
	console.log(item)
	let productCode = '${productCode }';
	$.ajax({
		url: 'productDetail.do?item='+item,
		dataType: 'json',
		method :'post',
		success: function (result) {
			console.log(result)
			template.find('h1').text(result.productName)
			template.find('div.fs-5 span:nth-of-type(1)').text('￦' + Number(result.productPrice).toLocaleString())
			template.find('div.fs-5 span:nth-of-type(2)').text('￦' + Number(result.salePrice).toLocaleString())
			template.find('p.lead').text(result.productDesc)
			template.find('img').attr('src','images/'+result.productImage)
		},
		error:function(reject){
			console.log(reject)
		}
	})

	$.ajax({
		url: 'relatedProducts.do',
		dataType: 'json',
		success: function (result) {
			console.log(result)
			$(result).each(function (idx, item) {
				let template = $('section.py-5.bg-light div.col.mb-5:nth-child(1)').clone();
				// $('div.row').append(template); //row밑에 방금 가지고 온 template를 붙임 => 여섯번 반복 하면서 붙을 것
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
				//이미지에 상품 코드 넣기
				template.find('a').attr('href', 'productInfo.do?item=' + item.productCode)
				$('section.py-5.bg-light div.row').append(template)


			})
			//display :none
			$('div.col.mb-5:nth-child(1)').css('display', 'none')
		},
		error: function (reject) {
			console.log(reject);
		}

	})
</script>