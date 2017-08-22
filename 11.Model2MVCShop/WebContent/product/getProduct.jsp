<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- root에서 실행 --%>

<%
	int index = (int)(java.lang.Math.random()*3.0);
%>

<html>
<head>
	<title>상품 조회</title>
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript">
	
		function fncAddComment(){
			$('form[name="commentProduct"]').attr('method','post').attr('action','addProductComment').submit();
		}
		
		$(function(){

			$('td.ct_btn01:contains("확인")').bind('click',function(){
				self.location('listProduct?menu=manage');
			});
			
			$('td.ct_btn01:contains("구매")').bind('click',function(){
				self.location.href = '../purchase/addPurchase?prodNo=${product.prodNo}';
			});
			
			$('td.ct_btn01:contains("이전")').bind('click',function(){
				history.go(-1);
			});
			
			$('td.ct_btn01:contains("등록")').bind('click',function(){
				fncAddComment();
			});
			
			$('input:text[name="cmt"]').bind('keydown',function(event){
				if(event.keyCode == '13'){
					event.preventDefault();
					fncAddComment();
				}
			});
			
			$('div span:contains("답글달기")').bind('click',function(){
				var index = $(this).find('input:hidden[name="index"]').val();
				$($('input:hidden[name="replyNo"]')[0]).val($('input:hidden[name="'+index+'"]').val());
				$('input:text[name="cmt"]').val($('input:text[name="innerCmt'+index+'"]').val());
				fncAddComment();
			});
			
			$('div div input:text').bind('keydown',function(event){
				if(event.keyCode == '13'){
					event.preventDefault();
					var index = $(this).attr('name');
					index = index.substr(8);
					$($('input:hidden[name="replyNo"]')[0]).val($('input:hidden[name="'+index+'"]').val());
					$('input:text[name="cmt"]').val($('input:text[name="innerCmt'+index+'"]').val());
					fncAddComment();
				}
			});
			
			
		});
		$(function() {
			$("#accordion").accordion({
				collapsible : true,
				active : false,
				heightStyle : 'content'
			});
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="../images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="../images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품번호<img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo }</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명<img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">남은수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.stock }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품이미지<img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product.fileName }">
				<img src = "../images/uploadFiles/${product.fileName}" height="150"/>
			</c:if>
			<c:if test="${empty product.fileName }">
				<img src = "../images/uploadFiles/empty<%=index %>.GIF" height="150"/>
			</c:if>
			
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${!empty product.price ? product.price : ""}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		
		<table border="0" cellspacing="0" cellpadding="0">
		<c:choose>
			<c:when test="${param.menu=='manage'}">
			<tr>
				<td width="17" height="23">
					<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="../images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					확인
				</td>
				<td width="14" height="23">
					<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
			</c:when>
			<c:otherwise>
			<tr>
			<c:if test="${!empty user }">
				<td width="17" height="23">
					<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<c:if test="${product.stock != 0}">
						구매
					</c:if>
				</td>
				<td width="14" height="23">
					<img src="../images/ct_btnbg03.gif" width="14" height="23">
				</td>
				<td width="30"></td>
			</c:if>
				<td width="17" height="23">
					<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					이전
				</td>
				<td width="14" height="23">
					<img src="../images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
			</c:otherwise>
		</c:choose>
		</table>
		</td>
	</tr>
</table>
</form>


	
<form name="commentProduct">
<input type="hidden" name="prodNo" value="${product.prodNo}"/>
<input type="hidden" name="userId" value="${user.userId }"/>
<input type="hidden" name="replyNo" value="0"><hr/>
상품평 보기

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<th height="1" colspan="3" bgcolor="D6D6D6"></th>
	</tr>
	<c:if test="${!empty user }">
	<tr>
		<th width="104" class="ct_write">
			상품평 쓰기
		</th>
		<th bgcolor="D6D6D6" width="1"></th>
		<th class="ct_write01" align="left">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="90%">
						<input type="text" name="cmt" maxlength="100" width="*"/>
					</td>
					<td width="17" height="23">
						<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						등록
					</td>
					<td width="14" height="23">
						<img src="../images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</th>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	</c:if>
</table>
<div id="accordion">
	<c:if test="${replyList.size()>0 }">
	<c:set var="i" value="0"/>
		<c:forEach var="reply" items="${ replyList }">
			<c:set var="i" value="${i+1}"/>
 			<h3>${reply.userId}&nbsp;&nbsp;&nbsp;${reply.cmt}</h3>
			<div>
				<input type="hidden" name="${i}" value="${reply.replyNo}">
				<c:forEach var="innerReply" items="${reply.innerReply}">
					<p>${innerReply.userId}&nbsp;&nbsp;&nbsp;${innerReply.cmt}</p>
				</c:forEach>
				<c:if test="${!empty user }">
					<input type="text" name="innerCmt${i}">
					<span>
						<input type="hidden" name="index" value="${i}">답글달기
					</span>
				</c:if>
			</div>
 		</c:forEach>
	</c:if>
</div>
</form>


</body>
</html>