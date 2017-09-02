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
			
			$('.add-purchase .btn-success:contains("구매")').bind('click',function(){
				$('form').attr('method','post').attr('action','addPurchase').submit();
			});
			
			$('.add-purchase .btn-info:contains("취소")').bind('click',function(){
				history.go(-1);
			});
			
			$('#inputDlvyDate').datepicker({
				dateFormat : 'yymmdd'
			})

		});
		
	</script>
</head>

<body>

	<jsp:include page="../layout/menubar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	
<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>상품 구매</h1>
	</div>
	<form class="add-product form-horizontal">
		<input type="hidden" name="purchaseProd.prodNo" value="${product.prodNo }" />
		<input type="hidden" name="purchaseProd.prodName" value="${product.prodName }"/>
		<input type="hidden" name="buyer.userId" value="${user.userId }"/>
		<input type="hidden" name="tranCode" value="1"/>
		
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-xs-4">
						<c:if test="${!empty product.fileName}">
							<img src="../images/uploadFiles/${product.fileName}" class="img-responsive"/>
						</c:if>
						<c:if test="${empty product.fileName}">
							<img src="../images/uploadFiles/empty<%=index%>.GIF" class="img-responsive"/>
						</c:if>
					</div>
					<div class="col-xs-8">
						<dl class="dl-horizontal">
							<dt>상품명</dt>
							<dd>${product.prodName}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>남은수량</dt>
							<dd>${product.stock} 개</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>제조일자</dt>
							<dd>${product.manuDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>가격</dt>
							<dd>${product.price} 원</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>상세정보</dt>
							<dd>${product.prodDetail}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>등록일자</dt>
							<dd>${product.regDate}</dd>
						</dl>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="form-group">
					<div class="row">
						<label for="inputPaymentOption" class="col-sm-3 control-label">결제방법</label>
						<div class="col-sm-3">
							<select class="form-control" id="inputPaymentOption" name="paymentOption">
								<option value="1">현금결제</option>
								<option value="2">신용카드</option>
							</select>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputPurchaseCount" class="col-sm-3 control-label">구매수량</label>
						<div class="col-sm-3">
							<select class="form-control" id="inputPurchaseCount" name="purchaseCount">
								<c:forEach var="i" begin="1" end="${product.stock>10? 10 : product.stock}">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputReceiverName" class="col-sm-3 control-label">받는사람</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputReceiverName" name="receiverName" value="${user.userName}">
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputReceiverPhone" class="col-sm-3 control-label">연락처</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputReceiverPhone" name="receiverPhone" value="${user.phone}">
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputDlvyAddr" class="col-sm-3 control-label">배송지</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputDlvyAddr" name="dlvyAddr" value="${user.addr}" >
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputDlvyDate" class="col-sm-3 control-label">배송희망일</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputDlvyDate" name="dlvyDate" readonly>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputDlvyRequest" class="col-sm-3 control-label">요청사항</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="inputDlvyRequest" name="dlvyRequest">
						</div>
						<span class="col-sm-3"></span>
					</div>
					<br/>
					<div class="row">
						<div class="add-purchase col-sm-offset-3 col-sm-9">
							<button type="button" class="btn btn-success">
								구매
							</button>
							<button type="button" class="btn btn-info">
								취소
							</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
	</form>
	
</div>


</body>
</html>