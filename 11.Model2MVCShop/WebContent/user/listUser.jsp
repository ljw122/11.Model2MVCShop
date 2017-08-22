<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- root에서 실행 --%>


<html>
<head>
	<title>회원 목록조회</title>
	
	<link rel="stylesheet" href="../css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		var currentPage = 1,
			searchCondition,
			searchKeyword;
		
		function init(){
			$('div.ct_list_pop span:nth-child(1)').css('width', '100px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(2)').css('width', '150px')
													.css('display','inline-block')
													.css('color','red')
													.bind('click', function(){
														self.location = 'getUser?userId='+$(this).text().trim();
													});
			$('div.ct_list_pop span:nth-child(3)').css('width', '150px').css('display','inline-block');
			$('div.ct_list_pop span:nth-child(4)').css('display','inline-block');
			
			$('h7').css('color','red');
			
			$('.ct_list_pop:nth-child(2n+2)').css('background-color','rgb(220, 245, 245)');

		}
		
		function fncNextList(){
			currentPage++;
			searchCondition = $('select[name="searchCondition"]').val();
			searchKeyword = $('input:text[name="searchKeyword"]').val();
			
			$.ajax({
				url : 'json/listUser',
				method : 'post',
				async : false,
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				dataType : 'json',
				data : JSON.stringify({
					currentPage : currentPage,
					searchCondition : searchCondition,
					searchKeyword : searchKeyword
				}),
				success : function(JSON){
					var i = JSON.resultPage.totalCount - (JSON.resultPage.currentPage-1)*JSON.resultPage.pageSize + 1;
					for( x in JSON.list){
						i--;
						var user = JSON.list[x];
						var list = '<div class="ct_list_pop">';
						list += '<span>'+i+'</span>';
						list += '<span>'+user.userId+'</span>';
						list += '<span>'+user.userName+'</span>';
						list += '<span>'+user.email+'</span></div>';
						
						$('div.user_list').html($('div.user_list').html() + list);
					}
					init();
				}
			});
		}

		function fncGetList(){
			$('#currentPage').val(currentPage);
			$('form').attr('method','post').attr('action','listProduct').submit();
		}

		$(function(){
			$('td.ct_btn01:contains("검색")').bind('click',function(){
				currentPage = 1;
				fncGetList();
			});
		});

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

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >
<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="../images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="../images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : ""}>회원ID</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}>회원명</option>
			</select>
			<input 	type="text" name="searchKeyword"  value="${!empty search.searchKeyword ? search.searchKeyword : ''}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="../images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
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
		<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			회원ID <h7 >(id click:상세정보)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">이메일</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
</table>

<div class="user_list">
<c:set var="i" value="${resultPage.totalCount - (resultPage.currentPage-1)*resultPage.pageSize + 1}"/>
<c:forEach var="user" items="${list}">
	<c:set var="i" value="${i-1}"/>
	<div class="ct_list_pop">
		<span>${i}</span>
		<span>${user.userId}</span>
		<span>${user.userName}</span>
		<span>${user.email}</span>
	</div>
</c:forEach>
</div>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>