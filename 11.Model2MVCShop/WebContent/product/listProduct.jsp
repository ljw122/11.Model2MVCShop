<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- root���� ���� --%>
<%-- ����ȭ�� / ������ȭ�� �ΰ��� �и� --%>

<c:set var="menu" value="${!empty param.menu ? param.menu : \"search\" }"/>

<html>
<head>
<!-- 	<title>��ǰ �����ȸ</title> -->	

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		var currentPage = 1,
			menu,
			searchCondition,
			searchKeyword,
			searchKeyword2,
			orderCondition,
			orderOption;

		function init(){

			$('div.ct_list_pop span:nth-child(1)').css('width', '70px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(2)').css('width', '150px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(3)').css('width', '100px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(4)').css('width', '100%-470px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(5)').css('width', '150px')
													.css('display','inline-block')
													.css('float','right');

			$('.ct_list_pop:nth-child(2n+1)').css('background-color','rgb(220, 245, 245)');

			$('h4').bind('click',function(){
				self.location = 'getProduct?menu=${menu}&prodNo='+$(this).find('input:hidden').val();
			});

			$(document).tooltip({
				items : '[data-img]',
				hide : {
					effect : 'explode',
					delay : 100
				},
				content : function(callback){
					$.ajax({
						url : 'json/getProduct/search/'+$(this).parent().find('input:hidden').val(),
						method : 'get',
						async : false,
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						},
						dataType : 'json',
						success : function(data){
							var src = '<img src="../images/uploadFiles/';
							if(data.product.fileName != null){
								src += data.product.fileName;
							}else{
								src += 'empty'+Math.floor(3*Math.random())+'.GIF';
							}
							src += '" height="125" width="125"/>';
							callback(src);
						}
					});
				}
			});
		}

		
		function fncNextList(){
			currentPage++;
			menu = $('input:hidden[name="menu"]').val();
			searchCondition = $('select[name="searchCondition"]').val();
			searchKeyword = $('input:text[name="searchKeyword"]').val();
			if(searchCondition == 2){
				searchKeyword2 = $('input:text[name="searchKeyword2"]').val();
			}else{
				searchKeyword2 = null;
			}
			orderCondition = $('input:hidden[name="orderCondition"]').val();
			orderOption = $('input:hidden[name="orderOption"]').val();
			stockView = $('input[name="stockView"]').attr('checked')? true : false;
			
			$.ajax({
				url : 'json/listProduct/'+menu,
				method : 'post',
				async : false,
				dataType : 'json',
				data : JSON.stringify({
						currentPage : currentPage,
						searchCondition : searchCondition,
						searchKeyword : searchKeyword,
						searchKeyword2 : searchKeyword2,
						orderCondition : orderCondition,
						orderOption : orderOption,
						stockView : stockView
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSON){
					var i = JSON.resultPage.totalCount - (JSON.resultPage.currentPage-1)*JSON.resultPage.pageSize + 1;
					for( x in JSON.list){
						i--;
						var product = JSON.list[x];
						var list = '<div class="ct_list_pop">'+'<span>'+i+'</span>'+'<span>';
						if(product.proTranCode == null || product.proTranCode == '' || menu == 'manage'){
							list += '<h4><input type="hidden" name="'+product.prodName+'" value="'+product.prodNo+'">';
							list += '<a href="#" data-img="">'+product.prodName+'</a></h4>';
						}else{
							list += product.prodName;
						}
						list += '</span><span>'+product.price+'</span><span>';
						list += menu=='manage'? product.regDate : product.prodDetail;
						list += '</span><span>';
						list += menu=='manage'? product.stock : (product.stock==0? '������' : '�Ǹ���');
						list += '</span></div>';

						$('div.product_list').html($('div.product_list').html() + list);
					}
					init();
				},
				statusCode : {
					404 : function(){
						alert('404��');
					},
					405 : function(){
						alert('405��');
					},
					400 : function(){
						alert('400��');
					},
					415 : function(){
						alert('415��');
					}
				}
			});
		}
		
		function callTag(){
			$.ajax({
				url : 'json/getProductNames/',
//				url : 'json/getProductNames/'+$('input:text[name="searchKeyword"]').val().trim(),
				method : 'post',
//				method : 'get',
				dataType : 'json',
				data : JSON.stringify({
					searchKeyword : $('input:text[name="searchKeyword"]').val().trim()
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSONData){
					$('input:text[name="searchKeyword"]').autocomplete({
						source : JSONData
					});
				},
				statusCode : {
					404 : function(){
						alert('404��');
					},
					405 : function(){
						alert('405��');
					},
					400 : function(){
						alert('400��');
					},
					415 : function(){
						alert('415��');
					}
				}
			});
		}

		function fncGetList(){
			$('#currentPage').val(currentPage);
			$('form').attr('method','post').attr('action','listProduct').submit();
		}

		function fncOrderList(orderCondition, orderOption){
			$('#orderCondition').val(orderCondition);
			$('#orderOption').val(orderOption);
			currentPage = 1;
			fncGetList();
		}
		
		$( function() {
			init();
			while($(document).height() == $(window).height() && currentPage < $('input:hidden[name="maxPage"]').val()){
				fncNextList();
			}
			
		} );

		$(function(){
			
			var orderOption = $('input:hidden[name="orderOption"]').val();
			var orderCondition = $('input:hidden[name="orderCondition"]').val();
			
			$('select[name="searchCondition"]').bind('change',function(){
				
				$('input:text').val('');

				if($(this).val()==2){

					$('span.search').replaceWith(
						'<span class="search">'
							+'<input type="text" name="searchKeyword" value="${search.searchKeyword}"'
								+'class="ct_input_g" style="width:65px; height:19px" />&nbsp;�̻� &nbsp;'
							+'<input type="text" name="searchKeyword2" value="${search.searchKeyword2}"'
								+'class="ct_input_g" style="width:65px; height:19px" />&nbsp;����'
						+'</span>'
					);
				}else{
					$('span.search').replaceWith(
						'<span class="search">'
							+'<input type="text" name="searchKeyword" value="${search.searchKeyword}"'
								+'class="ct_input_g" style="width:200px; height:19px" />'
						+'</span>'
					);

				}
					
			});
			
			$('.ct_list_b:contains("��ǰ��")').bind('click',function(){
				if(orderCondition == 1 && orderOption == 'ASC'){
					fncOrderList(1, 'DESC');
				}else{
					fncOrderList(1, 'ASC');
				}
			});
			
			$('.ct_list_b:contains("����")').bind('click',function(){
				if(orderCondition == 2 && orderOption == 'ASC'){
					fncOrderList(2, 'DESC');
				}else{
					fncOrderList(2, 'ASC');
				}
			});
			
			$('input:checkbox[name="stockView"]').bind('change',function(){
				currentPage = 1;
				fncGetList();
			});
		});
		
		$(function(){
			$('input:text').bind('keydown',function(event){
				if(event.keyCode == '13'){
					event.preventDefault();
					if($('select[name="searchCondition"]').val()==2){
						if( ($('input:text[name="searchKeyword"]') != null && $('input:text[name="searchKeyword"]').val() != '' && !$.isNumeric($('input:text[name="searchKeyword"]').val()) )
								|| ( $('input:text[name="searchKeyword2"]') != null && $('input:text[name="searchKeyword2"]').val() != '' && !$.isNumeric($('input:text[name="searchKeyword2"]').val()) ) ){
							alert('���� �˻��� ���ڷθ� �����մϴ�!');
							$('input:text').val('');
							return;
						}
					}
					currentPage = 1;
					fncGetList();
				}
			}).bind('keyup',function(event){
				if( $('select[name="searchCondition"]').val()==1 ){
					if($(this).val().trim() != ''){
						callTag();
					};
				};
			});
			
			$('.ct_btn01:contains("�˻�")').bind('click',function(){
				if($('select[name="searchCondition"]').val()==2){
					if( ($('input:text[name="searchKeyword"]') != null && $('input:text[name="searchKeyword"]').val() != '' && !$.isNumeric($('input:text[name="searchKeyword"]').val()) )
							|| ( $('input:text[name="searchKeyword2"]') != null && $('input:text[name="searchKeyword2"]').val() != '' && !$.isNumeric($('input:text[name="searchKeyword2"]').val()) ) ){
						alert('���� �˻��� ���ڷθ� �����մϴ�!');
						$('input:text').val('');
						return;
					}
				}
				currentPage = 1;
				fncGetList();
			});
		});
		

		$(window).scroll(function(event){
			if(currentPage < $('input:hidden[name="maxPage"]').val()){
				if(pageYOffset == ($(document).height()-$(window).height())){
					window.scrollTo(0,$(document).height()-$(window).height()-1);
					fncNextList();
				}
			}
		});
		
	</script>
	<style>
		label {
		  display: inline-block;
		  width: 5em;
		}
	</style>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">
<input type="hidden" name="menu" value="${menu}"/>
<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="../images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						��ǰ ${menu=='manage' ? "����" : "�����ȸ" }
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="../images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>		
		<td align="left">
			<c:if test="${menu=='search' }">
				<input type="checkbox" name="stockView" ${search.stockView ? "checked=\"checked\"" : "" }
						class="ct_input_g" height="19"/>���� ��ǰ ����
			</c:if>
		</td>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected" : ""} >��ǰ��</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected" : ""} >��ǰ����</option>
			</select>
			<span class="search">
				<c:if test="${search.searchCondition == '1'}">
					<input type="text" name="searchKeyword" value="${search.searchKeyword}"
						class="ct_input_g" style="width:200px; height:19px" />
				</c:if>
				<c:if test="${search.searchCondition == '2'}">
					<input type="text" name="searchKeyword" value="${search.searchKeyword}"
						class="ct_input_g" style="width:65px; height:19px" />&nbsp;�̻�&nbsp;
					<input type="text" name="searchKeyword2" value="${search.searchKeyword2}"
						class="ct_input_g" style="width:65px; height:19px" />&nbsp;����
				</c:if>					
			</span>
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="../images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="../images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="70">No</td>
		<td class="ct_line02">
			<input type="hidden" id="orderCondition" name="orderCondition" value="${!empty search.orderCondition? search.orderCondition : '' }"/>
			<input type="hidden" id="orderOption" name="orderOption" value="${!empty search.orderOption? search.orderOption : '' }"/>
		</td>
		<td class="ct_list_b" width="150">��ǰ��&nbsp;
			${!empty search.orderCondition && search.orderCondition=='1' ? (search.orderOption=='ASC'? "��":"��") : "-" }
 		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">����&nbsp;
			${!empty search.orderCondition && search.orderCondition=='2' ? (search.orderOption=='ASC'? "��":"��") : "-" }
 		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">${menu=='manage' ? "�����":"��ǰ �� ����"}</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">${menu=='manage' ? "��������":"�������"}</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
</table>

	<!-- ���⼭ for�� ���� pageSize ���� -->
<div class="product_list">
<c:set var="i" value="${resultPage.totalCount- (resultPage.currentPage-1)*resultPage.pageSize + 1 }"/>
<c:forEach var="product" items="${list}">
	<c:set var="i" value="${i-1}"/>
	<div class="ct_list_pop">
		<span>
			${i }
		</span>
		<span>
			<c:choose>
				<c:when test="${empty product.proTranCode || menu=='manage' }">
					<h4>
						<input type="hidden" name="${product.prodName}" value="${product.prodNo}">
						<a href='#' data-img=''>${product.prodName}</a>
					</h4>
				</c:when>
				<c:otherwise>
					${product.prodName }
				</c:otherwise>
			</c:choose>
			
		</span>
		
		<span>${product.price}</span>
		<span>${menu=='manage'? product.regDate : product.prodDetail }</span>
		<span>
		<c:choose>
			<c:when test="${menu=='manage' }">
				${product.stock }
			</c:when>
			<c:otherwise>
				${product.stock==0 ? "������" : "�Ǹ���" }
			</c:otherwise>
		</c:choose>
		</span>	
	</div>
</c:forEach>
</div>
<!-- ������ Navigator �� -->

</form>

</div>
</body>
</html>