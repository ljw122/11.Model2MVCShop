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
		var currentPage = 0;
		
		function fncNextList(){
			currentPage++;
			$.ajax({
				url : 'json/listProduct/'+$('input:hidden[name="menu"]').val(),
				method : 'post',
				async : false,
				dataType : 'json',
				data : JSON.stringify({
						currentPage : currentPage,
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSON){
					var list = '';
					for( x in JSON.list){
						var product = JSON.list[x];
						list += '<div class="col-sm-6 col-md-4"><div class="thumbnail alert alert-'+(product.stock==0? 'danger':'warning')+'">';
						list += '<img src="../images/uploadFiles/'+(product.fileName!=null ? product.fileName : 'empty'+Math.floor(3*Math.random())+'.GIF')+'" class="img-responsive" data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">';
						list += '<div class="caption">';
						list += '<input type="hidden" name="prodNo" value="'+product.prodNo+'">';
						list += '<h3>'+product.prodName+'</h3>';
						list += '<p>';
						list += '<div class="btn-group" role="group">';
						list += '<a href="#" class="btn btn-primary" role="button">';
						if($('input:hidden[name="menu"]').val()=='manage'){
							list += '정보수정';
						}else{
							list += '상세보기';
						}
						list += '</a>';
						if($('input:hidden[name="userId"]').val() != '' && $('input:hidden[name="menu"]').val()=='search'){
							list += '<a href="#" class="btn btn-default" role="button">구매</a>';
						}
						list += '</div>';
						list += '</p></div></div></div>';
					}
					$('.col-md-9 > .row').html($('.col-md-9 > .row').html() + list);
					
					init();
				}
			});
		}
		
		function init(){
			$('a.btn-primary:contains("상세보기"), a.btn-primary:contains("정보수정")').unbind('click').bind('click',function(){
				self.location.href='getProduct?menu=${param.menu}&prodNo='+$(this).parent().parent().find('input:hidden').val();
			});
			
			$('a.btn-default:contains("구매")').unbind('click').bind('click',function(){
				self.location.href='../purchase/addPurchase?prodNo='+$(this).parent().parent().find('input:hidden[name="prodNo"]').val();
			});
		};
		
		$( function() {
			while($(document).height() == $(window).height() && currentPage < $('input:hidden[name="maxPage"]').val()){
				fncNextList();
			}
			
		} );
		
		$(window).scroll(function(){
			if(currentPage < $('input:hidden[name="maxPage"]').val()){
				if(pageYOffset == $(document).height()-$(window).height()){
					$(window).scrollTop(pageYOffset - 1);
					fncNextList();
				}
			}
		});
		
	</script>
</head>

<body>

	<jsp:include page="../layout/menubar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	
	<input type="hidden" name="menu" value="${param.menu}"/>
	<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
	<input type="hidden" name="userId" value="${sessionScope.user.userId}"/>
	
	<div class="container">
		<div class="row">
			<div class="col-md-9" role="main">
				<div class="page-header col-sm-offset-2 col-sm-10">
					<c:if test="${param.menu=='manage'}">
						<h1>상품 관리</h1>
					</c:if>
					<c:if test="${param.menu=='search'}">
						<h1>상품 구매</h1>
					</c:if>
				</div>
				<div class="row">
				
				</div>
			</div>
			<jsp:include page="../history.jsp">
				<jsp:param name="uri" value="../"/>
			</jsp:include>
		</div>
	</div>
	
</body>

</html>