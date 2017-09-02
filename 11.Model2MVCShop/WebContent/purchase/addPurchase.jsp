<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% int index = (int)(java.lang.Math.random()*3.0); %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			$('a.btn-success:contains("확인")').bind('click',function(){
				self.location.href='listPurchase?searchKeyword=purchaseList&searchCondition=${sessionScope.user.userId}';
			});
		});
	</script>
	
</head>

<body>

	<jsp:include page="../layout/menubar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

<div class="container">	
	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>주문이 완료되었습니다.</h1>
	</div>
	
	<dl class="dl-horizontal">
		<dt>상품명</dt>
		<dd>${purchase.purchaseProd.prodName}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>구매 수량</dt>
		<dd>${purchase.purchaseCount} 개</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>결제 방법</dt>
		<dd>${purchase.paymentOption=='1'? '현금구매':'신용구매'}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>받으실 분</dt>
		<dd>${purchase.receiverName}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>연락처</dt>
		<dd>${purchase.receiverPhone}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>배송지</dt>
		<dd>${purchase.dlvyAddr}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>구매 요청사항</dt>
		<dd>${purchase.dlvyRequest}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>배송 희망 일자</dt>
		<dd>${purchase.dlvyDate}</dd>
	</dl>
	<div class="btn-group" role="group">
		<a href="#" class="add btn btn-success" role="button">확인</a>
	</div>
	

</div>

</body>
</html>