<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-3" role="complementary">
	<nav class="bs-docs-sidebar">
		<ul class="nav bs-docs-sidenav">
			<li>�ֱ� �� ��ǰ</li>
			<li>�� ����</li>
			<li>����´�</li>
			<li>�ų���</li>
		</ul>
	</nav>
</div>


<script type="text/javascript">
	$(function(){
		if($(window).width()<987){
			$('div[role="complementary"]').hide();
		}
	});
	
	$(window).resize(function(){
		if($(window).width()<987){
			$('div[role="complementary"]').hide();
		}else{
			$('div[role="complementary"]').show();
		}
	});
	$(window).scroll(function(){
		$('div[role="complementary"]').stop();
		$('div[role="complementary"]').animate({top:$(window).scrollTop()+"px"},{queue: false, duration: 0});
	});
</script>