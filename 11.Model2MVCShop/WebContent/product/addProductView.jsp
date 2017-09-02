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
	
		function fncAddProduct(){
			//Form 유효성 검증
			var name = $('input[name="prodName"]').val();
			var detail = $('input[name="prodDetail"]').val();
			var manuDate = $('input[name="manuDate"]').val();
			var price = $('input[name="price"]').val();
			var stock = $('input[name="stock"]').val();
			var formData = new FormData();
			formData.append('file',$('input[name="file"]')[0].files[0]);
			
			if(name == null || name.length<1){
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if(stock == null || stock.length<1){
				alert("최소 수량은 1개 입니다.")
				return;
			}
			if(!$.isNumeric(stock)){
				alert('수량은 숫자로 적어주세요.');
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length<1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
			if(!$.isNumeric(price)){
				alert('가격은 숫자로 적어주세요.');
				return;
			}
			
			$('#myModal').modal('show');
			if($('input[name="file"]')[0].files[0] != null){
				$.ajax({
					url : 'json/uploadFile',
					method : 'post',
					data : formData,
					contentType:false,
					processData:false,
					success : function(){
						window.setTimeout(modalOut,5000);
						window.setTimeout(sendForm,5000);
					},
					error : function(jqXHR, status, error){
						modalOut();
						alert('등록에 실패했습니다. 잠시 후 다시 시도해 주세요..');
					},
					statusCode : {
						404 : function(){
							alert('404맨');
						},
						405 : function(){
							alert('405맨');
						},
						400 : function(){
							alert('400맨');
						},
						415 : function(){
							alert('415맨');
						}
					}
	
				});
			}else{
				modalOut();
				sendForm();
			}
			
		}
	
	
		$(function(){
			$('button:contains("등록하기")').bind('click',function(){
				fncAddProduct();
			});
			
			$('#inputManuDate').datepicker({
				dateFormat : 'yymmdd'
			})
		})
		
		function modalOut(){
			$('#myModal').modal('hide');
		}
		
		function sendForm(){
			$('form.add-product').attr('method','post').attr('action','addProduct').attr('enctype','multipart/form-data').submit();
		}
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/menubar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>상품 등록</h1>
	</div>
	<form class="add-product form-horizontal">
		<div class="form-group">
			<div class="row">
				<label for="inputProdName" class="col-sm-3 control-label">상품명</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputProdName" name="prodName" placeholder="상품명">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputProdDetail" class="col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="inputProdDetail" name="prodDetail" placeholder="상세정보">
				</div>
			</div>
			<br/>
			<div class="row">
				<label for="inputStock" class="col-sm-3 control-label">상품수량</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputStock" name="stock" placeholder="최소 수량은 1개 입니다.">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputManuDate" class="col-sm-3 control-label">제조일자</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputManuDate" name="manuDate" readonly>
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputPrice" class="col-sm-3 control-label">가격</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputPrice" name="price" >
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputFile" class="col-sm-3 control-label">상품이미지</label>
				<div class="col-sm-6">
					<input type="file" class="form-control" id="inputFile" name="file" >
				</div>
				<span class="col-sm-3"></span>
			</div>
			<br/>
			<div class="row">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-success">
						등록하기
					</button>
					
					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-body">
									<!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
									<h4 class="modal-title" id="myModalLabel">상품 등록 중입니다..</h4>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</form>
</div>





</body>

</html>