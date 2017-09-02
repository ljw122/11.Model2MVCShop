<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			
			$.ajax({
				url : 'product/json/getIndexProductList',
				method : 'get',
				dataType : 'json',
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(data){
					$($('div.carousel-inner > div')[0]).find('img').attr('src','images/uploadFiles/'+(data.NP.fileName!=null ? data.NP.fileName : 'empty'+Math.floor(3*Math.random())+'.GIF'));
					$($('div.carousel-inner > div')[0]).find('input').attr('value',data.NP.prodNo);
					$($('div.carousel-inner > div')[0]).find('div').find('p').text(data.NP.prodName);
					
					$($('div.carousel-inner > div')[1]).find('img').attr('src','images/uploadFiles/'+(data.HP[0].fileName!=null ? data.HP[0].fileName : 'empty'+Math.floor(3*Math.random())+'.GIF'));
					$($('div.carousel-inner > div')[1]).find('input').attr('value',data.HP[0].prodNo);
					$($('div.carousel-inner > div')[1]).find('div').find('p').text(data.HP[0].prodName);
					
					$($('div.carousel-inner > div')[2]).find('img').attr('src','images/uploadFiles/'+(data.RP.fileName!=null ? data.RP.fileName : 'empty'+Math.floor(3*Math.random())+'.GIF'));
					$($('div.carousel-inner > div')[2]).find('input').attr('value',data.RP.prodNo);
					$($('div.carousel-inner > div')[2]).find('div').find('p').text(data.RP.prodName);

					$('.carousel').carousel({
						interval: 1700
					});
					
					$('div.carousel-inner > div > img').bind('click',function(){
						self.location.href = 'product/getProduct?menu=search&prodNo='+$(this).parent().find('input:hidden').val();
					});
				}
			});
		});
	</script>
</head>

<body>

	<jsp:include page="layout/menubar.jsp"/>
	
	<div class="container">
		<div id="carousel-example-generic" class="carousel slide">
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="http://placehold.it/1140x500" style="width:1140px; height:500px;" alt="First slide">
					<input type="hidden" name="prodNo"/>
					<div class="carousel-caption">
						<h1>신상의 신상!</h1>
						<p>상품 준비 중 입니다.</p>
					</div>
				</div>
				<div class="item">
					<img src="http://placehold.it/1140x500/" style="width:1140px; height:500px;" alt="Second slide">
					<input type="hidden" name="prodNo"/>
					<div class="carousel-caption">
						<h1>가장 많이 팔린!</h1>
						<p>상품 준비 중 입니다.</p>
					</div>
				</div>
				<div class="item">
					<img src="http://placehold.it/1140x500/" style="width:1140px; height:500px;" alt="Third slide">
					<input type="hidden" name="prodNo"/>
					<div class="carousel-caption">
						<h1>상품평이 가장 많은!</h1>
						<p>상품 준비 중 입니다.</p>
					</div>
				</div>
			</div>
			<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
</body>

</html>