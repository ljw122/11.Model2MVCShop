<!DOCTYPE html>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="../css/left.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
		
		$(function(){
			$( "#menu" ).menu();
		
			$("div:contains('개인정보조회')").bind("click",function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../user/getUser?userId=${user.userId}");
			});
	
			$("div:contains('회원정보조회')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../user/listUser");
			});
			
			$("div:contains('판매상품등록')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/addProduct");
			});

			$("div:contains('판매상품관리')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/listProduct?menu=manage");
			});

			$("div:contains('판매이력조회')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../purchase/listSale?searchKeyword=saleList");
			});

			$("div:contains('상 품 검 색')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/listProduct?menu=search");
			});

			$("div:contains('구매이력조회')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../purchase/listPurchase?searchKeyword=purchaseList&searchCondition=${user.userId}");
			});

			$("div:contains('최근 본 상품')").bind("mouseenter", function(){
				$(this).parent().find('ul').html('').append(history());
			});
		});
		
		function history(){
			var history = '';
			$.ajax({
				url : '../product/json/getHistory',
				async : false,
				method : 'get',
				data : null,
				dataType : 'json',
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSONData, status){
					for(i=0 ; i<JSONData.length ; i++){
						history += '<li><div><a href="../product/getProduct?prodNo='+JSONData[i]+'&menu=search" target="rightFrame">'+JSONData[i]+'</a></div></li>';
					}
				}
			});
			return $(history);
		};

	</script>
	<style>
		.ui-menu { width: 90px; }
	</style>
</head>

<body background="../images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<ul id="menu">
<c:if test="${user.role=='admin' }">
	<li><div>회원관리</div>
		<ul>
			<li><div>회원정보조회</div></li>
		</ul>
	</li>
	<li><div>상품관리</div>
		<ul>
			<li><div>판매상품등록</div></li>
			<li><div>판매상품관리</div></li>
		</ul>
	</li>
	<li><div>판매관리</div>
		<ul>
			<li><div>판매이력조회</div></li>
		</ul>
	</li>
	<li></li>
</c:if>
	<li ${!empty user ? "":"class='ui-state-disabled'"}><div>개인정보조회</div></li>
	<li ${!empty user ? "":"class='ui-state-disabled'"}><div>구매이력조회</div></li>
	<li></li>
	<li><div>상 품 검 색</div></li>
	<li><div>최근 본 상품</div>
		<ul></ul>
	</li>
</ul>
</body>
</html>