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
		
			$("div:contains('����������ȸ')").bind("click",function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../user/getUser?userId=${user.userId}");
			});
	
			$("div:contains('ȸ��������ȸ')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../user/listUser");
			});
			
			$("div:contains('�ǸŻ�ǰ���')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/addProduct");
			});

			$("div:contains('�ǸŻ�ǰ����')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/listProduct?menu=manage");
			});

			$("div:contains('�Ǹ��̷���ȸ')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../purchase/listSale?searchKeyword=saleList");
			});

			$("div:contains('�� ǰ �� ��')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../product/listProduct?menu=search");
			});

			$("div:contains('�����̷���ȸ')").bind("click", function(){
				$(window.parent.frames['rightFrame'].document.location).attr("href","../purchase/listPurchase?searchKeyword=purchaseList&searchCondition=${user.userId}");
			});

			$("div:contains('�ֱ� �� ��ǰ')").bind("mouseenter", function(){
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
	<li><div>ȸ������</div>
		<ul>
			<li><div>ȸ��������ȸ</div></li>
		</ul>
	</li>
	<li><div>��ǰ����</div>
		<ul>
			<li><div>�ǸŻ�ǰ���</div></li>
			<li><div>�ǸŻ�ǰ����</div></li>
		</ul>
	</li>
	<li><div>�ǸŰ���</div>
		<ul>
			<li><div>�Ǹ��̷���ȸ</div></li>
		</ul>
	</li>
	<li></li>
</c:if>
	<li ${!empty user ? "":"class='ui-state-disabled'"}><div>����������ȸ</div></li>
	<li ${!empty user ? "":"class='ui-state-disabled'"}><div>�����̷���ȸ</div></li>
	<li></li>
	<li><div>�� ǰ �� ��</div></li>
	<li><div>�ֱ� �� ��ǰ</div>
		<ul></ul>
	</li>
</ul>
</body>
</html>