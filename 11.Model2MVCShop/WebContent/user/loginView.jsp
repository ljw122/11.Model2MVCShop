<%@ page contentType="text/html; charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- user���� ���� --%>
<html>
<head>
	<title>�α���</title>
	
	<link rel="stylesheet" href="../css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		function loginCheck(){
			var id=$('input:text').val();
			var pw=$('input:password').val();
			
			if(id == null || id.length < 1){
				alert('���̵� �Է����� �ʾҽ��ϴ�.');
				$('input:text').focus();
				return;
			}
			
			if(pw == null || pw.length < 1){
				alert('��й�ȣ�� �Է����� �ʾҽ��ϴ�.');
				$('input:password').focus();
				return;
			}
			
			$('form').attr('method','post').attr('action','login').attr('target','_parent').submit();
			
		}
	
		$(function(){
			$('input:text').focus();
			
			$('input').bind('keydown', function(event){
				if(event.which == '13'){
					loginCheck();
				}
			});
			
			$('img[src="../images/btn_login.gif"]').bind('click', function(){
				loginCheck();
			});
			
			$('input:password').bind('keydown', function(event){
				if(event.which == '9'){
					event.preventDefault();
					$('input:text').focus();
				}
			});
			
		});
		
		$(function(){
			$('img[src="../images/btn_add.gif"]').bind('click', function(){
				self.location = 'addUser';
			});
		});
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000" >

<form>

<div align="center">

<TABLE WIdTH="100%" HEIGHT="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">

<table width="650" height="390" border="5" cellpadding="0" cellspacing="0" bordercolor="#D6CDB7">
  <tr> 
    <td width="10" height="5" align="left" valign="top" bordercolor="#D6CDB7">
    	<table width="650" height="390" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="305">
            <img src="../images/logo-spring.png" width="305" height="390">
          </td>
          <td width="345" align="left" valign="top" background="../images/login02.gif">
          	<table width="100%" height="220" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="30" height="100">&nbsp;</td>
                <td width="100" height="100">&nbsp;</td>
                <td height="100">&nbsp;</td>
                <td width="20" height="100">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="50">&nbsp;</td>
                <td width="100" height="50">
                	<img src="../images/text_login.gif" width="91" height="32">
                </td>
                <td height="50">&nbsp;</td>
                <td width="20" height="50">&nbsp;</td>
              </tr>
              <tr> 
                <td width="200" height="50" colspan="4">
                </td>
              </tr>              
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="../images/text_id.gif" width="100" height="30">
                </td>
                <td height="30">
                  <input 	type="text" name="userId"  class="ct_input_g" 
                  				style="width:180px; height:19px"  maxLength='50'/>          
          		</td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="../images/text_pas.gif" width="100" height="30">
                </td>
                <td height="30">                    
                    <input 	type="password" name="password" class="ct_input_g" 
                    				style="width:180px; height:19px"  maxLength="50" >
                </td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="20">&nbsp;</td>
                <td width="100" height="20">&nbsp;</td>
                <td height="20" align="center">
      				<table width="136" height="20" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="56">
                           		<img src="../images/btn_login.gif" width="56" height="20" border="0">
	                        </td>
                            <td width="10">&nbsp;</td>
                            <td width="70">
                           		<img src="../images/btn_add.gif" width="70" height="20" border="0">
                            </td>
                          </tr>
                    </table>
                  </td>
                  <td width="20" height="20">&nbsp;</td>
                </tr>
            </table>
         </td>
       </tr>                            
      </table>
      </td>
  </tr>
</table>
</TD>
</TR>
</TABLE>
</div>

</form>

</body>
</html>

