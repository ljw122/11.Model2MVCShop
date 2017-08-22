<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- product���� ���� --%>
<html>
<head>
	<title>��ǰ���</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	
	<script type="text/javascript">
		function fncAddProduct(){
			//Form ��ȿ�� ����
			var name = $('input[name="prodName"]').val();
			var detail = $('input[name="prodDetail"]').val();
			var manuDate = $('input[name="manuDate"]').val();
			var price = $('input[name="price"]').val();
			var stock = $('input[name="stock"]').val();
			
			if(name == null || name.length<1){
				alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(price == null || price.length<1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(stock == null || stock.length<1){
				alert("�ּ� ������ 1�� �Դϴ�.")
				return;
			}
		
			$('form').attr('method','post').attr('action','addProduct').attr('enctype','multipart/form-data').submit();
			
		}
		
		$(function(){
		});

		
		
		$( function() {
			var progressTimer,
				progressbar = $( "#progressbar" ),
				progressLabel = $( ".progress-label" ),
				dialog = $( "#dialog" ).dialog({
						autoOpen: false,
						closeOnEscape: false,
						resizable: false,
						open: function() {
								progressTimer = setTimeout( progress, 2000 );
						}
				});
			
			progressbar.progressbar({
					value: false,
					change: function() {
							progressLabel.text( "Current Progress: " + progressbar.progressbar( "value" ) + "%" );
					},
					complete: function() {
							progressLabel.text( "Complete!" );
							dialog.dialog( "option", "buttons", [{
									text: "Close",
									click: closeUpload
							}]);
							$(".ui-dialog button").last().trigger( "focus" );
					}
			});
			
			function progress() {
				var val = progressbar.progressbar( "value" ) || 0;
				
				progressbar.progressbar( "value", val + Math.floor( Math.random() * 3 ) );
			
				if ( val <= 99 ) {
					progressTimer = setTimeout( progress, 50 );
				}
			}
			
			function closeUpload() {
				clearTimeout( progressTimer );
				dialog
					.dialog( "option", "buttons", dialogButtons )
					.dialog( "close" );
				progressbar.progressbar( "value", false );
				progressLabel.text( "Starting upload..." );
			}

			$('td.ct_btn01:contains("���")').bind('click',function(){
				fncAddProduct();
				dialog.dialog('open');
			});
			
			$('td.ct_btn01:contains("���")').bind('click',function(){
				$('form')[0].reset();	
			});
			
			$('td.ct_write01 img').bind('click',function(){
				show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
			});

		} );
		</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="../images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="../images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ���</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="../images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ��<img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
						<input type="text" name="prodName" class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="20">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="prodDetail" class="ct_input_g" 
						style="width: 200px; height: 19px" maxLength="13" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��ǰ����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="stock" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="6" value=""/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�������� <img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
				&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="../images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="price" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10">&nbsp;��</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��ǰ�̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="file" name="file" class="ct_input_g" 
							style="width: 200px; height: 19px" maxLength="13"/>
		</td>
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
				<tr>
					<td width="17" height="23">
						<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="../images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
						���
					</td>
					<td width="14" height="23">
						<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="../images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
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
<div id="dialog" title="File Upload">
  <div class="progress-label">Starting upload...</div>
  <div id="progressbar"></div>
</div>
</form>
</body>
</html>