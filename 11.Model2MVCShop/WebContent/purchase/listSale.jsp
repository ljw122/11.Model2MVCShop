<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- root���� ���� --%>

<html>
<head>
	<title>�Ǹ� �����ȸ</title>
	
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		var currentPage = 1,
			searchKeyword = 'saleList';
		
		function init(){
			$('.ct_list_pop:nth-child(2n+2)').css('background-color','rgb(220, 245, 245)');

			$('.ct_list_pop span:nth-child(1)').css('width', '70px').css('display','inline-block')
				.bind('click',function(){
					self.location = 'getPurchase?tranNo='+$(this).find('input:hidden').val();
				});
			
			$('.ct_list_pop span:nth-child(2)').css('width', '180px').css('display','inline-block')
				.bind('click',function(){
					self.location = '../product/getProduct?prodNo='+$(this).find('input:hidden').val()+'&menu=manage';
				});
			
			$('.ct_list_pop span:nth-child(3)').css('width', '150px').css('display','inline-block')
				.bind('click',function(){
					self.location = '../user/getUser?userId='+$(this).text().trim();
				});
			$('.ct_list_pop span:nth-child(4)').css('width', '150px').css('display','inline-block')
			
			$('.ct_list_pop span:nth-child(6):contains("����ϱ�")').css('width', '70px').css('display','inline-block').css('float','right')
				.bind('click',function(){
					self.location = 'updateTranCode?tranNo='+$(this).find('input:hidden').val()+'&tranCode=2&menu=manage';
				});
		}
		
		function fncNextList(){
			currentPage++;
			$.ajax({
				url : 'json/listPurchase',
				method : 'post',
				async : false,
				dataType : 'json',
				data : JSON.stringify({
					currentPage : currentPage,
					searchKeyword : searchKeyword
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSON){
					var i = JSON.resultPage.totalCount - (JSON.resultPage.currentPage-1)*JSON.resultPage.pageSize + 1;
					for( x in JSON.list){
						i--;
						var sale = JSON.list[x];
						var list = '<div class="ct_list_pop">';
						list += '<span><input type="hidden" name="tranNo" value="'+sale.tranNo+'">'+i+'</span>';
						list += '<span><input type="hidden" name="prodNo" value="'+sale.purchaseProd.prodNo+'">'+sale.purchaseProd.prodName+' (���� : '+sale.purchaseCount+')</span>';
						list += '<span>'+sale.buyer.userId+'</span>';
						list += '<span>'+sale.dlvyDate+'</span>';
						list += '<span>';
						if(sale.tranCode == 1){
							list += '���ſϷ�';
						}else if(sale.tranCode == 2){
							list += '�����';
						}else{
							list += '��ۿϷ�';
						}
						list += '</span>';
						list += '<span>'+(sale.tranCode == 1 ? '<input type="hidden" name="tranNo" value="'+sale.tranNo+'">����ϱ�' : '')+'</span>';
						list += '</div>';
						
						$('div.sale_list').html($('div.sale_list').html() + list);
					}
					init();
				}
			});
		}
		
		$(function(){
			init();
			while($(document).height() == $(window).height() && currentPage < $('input:hidden[name="maxPage"]').val()){
				fncNextList();
			}
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

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">
<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="../images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">�Ǹ� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="../images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
			��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="70">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="180">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">������ ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��� �����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
</table>

<div class="sale_list">
	<c:set var="i" value="${resultPage.totalCount- (resultPage.currentPage-1)*resultPage.pageSize + 1}"/>
	<c:forEach var="purchase" items="${list}">	
		<c:set var="i" value="${i-1}"/>
		<div class="ct_list_pop">
			<span>
				<input type="hidden" name="tranNo" value="${purchase.tranNo}">
				${i}
			</span>
			<span>
				<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}">
				${purchase.purchaseProd.prodName} (���� : ${purchase.purchaseCount })
			</span>
			<span>${purchase.buyer.userId}</span>
			<span>${purchase.dlvyDate}</span>
			<span>
				<c:choose>
					<c:when test="${purchase.tranCode=='1' }">
						���ſϷ�
					</c:when>
					<c:when test="${purchase.tranCode=='2' }">
						�����
					</c:when>
					<c:when test="${purchase.tranCode=='3' }">
						��ۿϷ�
					</c:when>
				</c:choose>
			</span>
			<span>
				<c:if test="${purchase.tranCode=='1'}">
					<input type="hidden" name="tranNo" value="${purchase.tranNo}">
					����ϱ�
				</c:if>
			</span>
		</div>
	</c:forEach>
	
</div>


</form>

</div>

</body>
</html>