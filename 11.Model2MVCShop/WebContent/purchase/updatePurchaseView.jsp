<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- root���� ���� --%>


<html>
<head>
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	
	<title>�������� ����</title>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('.ct_btn01:contains("����")').bind('click',function(){
				$('form').attr('method','post').attr('action','updatePurchase').submit();
			});
			$('.ct_btn01:contains("���")').bind('click',function(){
				history.go(-1);
			});
			
			$('.ct_write01 img').bind('click',function(){
				show_calendar('document.updatePurchase.dlvyDate', document.updatePurchase.dlvtDate.value);
			});
		});
	</script>
<script type="text/javascript" src="../javascript/calendar.js">
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<form name="updatePurchase">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="../images/ct_ttl_img01.gif"  width="15" height="37"/>
		</td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">������������</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="../images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<input type="hidden" name="buyer.userId" value="${purchase.buyer.userId}"/>
<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����ھ��̵�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.buyer.userId }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20">
				<option value="1" ${purchase.paymentOption=='1  '? "selected":""}>���ݱ���</option>
				<option value="2" ${purchase.paymentOption=='2  '? "selected":""}>�ſ뱸��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.receiverName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ż���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="purchaseCount" class="ct_input_g" style="width:50px"
						onChange="">
				<c:forEach var="i" begin="1" end="${purchase.purchaseProd.stock+purchase.purchaseCount>10? 10 : purchase.purchaseProd.stock+purchase.purchaseCount }">
					<option value="${i}" ${purchase.purchaseCount==i ? "selected":"" }>${i}</option>
				</c:forEach>
			</select> ��
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">������ ����ó</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.receiverPhone}" />
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="dlvyAddr" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.dlvyAddr}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ſ�û����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="dlvyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${purchase.dlvyRequest}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input type="text" readonly="readonly" name="dlvyDate" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${purchase.dlvyDate}"/>
				<img 	src="../images/ct_icon_date.gif" width="15" height="15"	/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="../images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					����
				</td>
				<td width="14" height="23">
					<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					���
				</td>
				<td width="14" height="23">
					<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>