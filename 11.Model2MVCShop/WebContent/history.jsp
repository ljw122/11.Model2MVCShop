<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-3" role="complementary">
	<div class="panel panel-success">
		<div class="panel-heading">최근 본 상품</div>
		<div class="panel-body">
			<c:forTokens var="i" items="${cookie.history.value }" delims=",">
				<a href="${param.uri}product/getProduct?prodNo=${i}&menu=search">${i}</a><br/>
			</c:forTokens>
		</div>
	</div>
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