<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.dropdown:hover > .dropdown-menu{
		display : block;
	}
	
	.rightMenu{
		position:absolute;
		float:right;
		top:0;
		left:158px;
	}
</style>

<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="${param.uri}index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target">

			<ul class="nav navbar-nav">
				<c:if test="${sessionScope.user.role == 'admin'}">
					<li class="dropdown">
						<a	href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span>관리자 메뉴</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >회원관리</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">회원정보조회</a></li>
								</ul>
							</li>
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >상품관리</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">판매상품등록</a></li>
									<li><a href="#">판매상품관리</a></li>
								</ul>
							</li>
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >판매관리</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">판매이력조회</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</c:if>

				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >상품구매</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">상품검색</a></li>
						<c:if test="${!empty user}">
							<li><a href="#">구매이력조회</a></li>
						</c:if>
					</ul>
				</li>
			</ul>
			
			
			<c:if test="${empty user}">
				<form class="navbar-form navbar-right">
					<input type="text" class="form-control" name="userId" placeholder="ID" style="display:inline-block; width:120px;"/>
					<input type="password" class="form-control" name="password" placeholder="PASSWORD" style="display:inline-block; width:120px;"/>
					<button type="submit" class="btn btn-primary">Log in</button>
					<button type="button" class="btn btn-primary">Sign in</button>
				</form>
			</c:if>	
			<c:if test="${!empty user}">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" class="user-info">${sessionScope.user.userName}</a>
					<li><a href="#">로그아웃</a></li>
				</ul>
			</c:if>
		</div>
	    
	</div>
</div>

<script type="text/javascript">

	function loginCheck(){
		var id=$('input:text').val();
		var pw=$('input:password').val();
		
		if(id == null || id.length < 1){
			alert('아이디를 입력하지 않았습니다.');
			$('input:text').focus();
			return;
		}
		
		if(pw == null || pw.length < 1){
			alert('비밀번호를 입력하지 않았습니다.');
			$('input:password').focus();
			return;
		}
		
		$('.navbar-form').attr('method','post').attr('action','${param.uri}user/login').submit();
	}
	
	$(function(){
	
		$("a.user-info").bind("click",function(){
			self.location.href="${param.uri}user/getUser?userId=${sessionScope.user.userId}";
		});
	
		$("a:contains('회원정보조회')").bind("click", function(){
			self.location.href="${param.uri}user/listUser";
		});
		
		$("a:contains('판매상품등록')").bind("click", function(){
			self.location.href="${param.uri}product/addProduct";
		});
	
		$("a:contains('판매상품관리')").bind("click", function(){
			self.location.href="${param.uri}product/listProduct?menu=manage";
		});
	
		$("a:contains('판매이력조회')").bind("click", function(){
			self.location.href="${param.uri}purchase/listSale?searchKeyword=saleList";
		});
	
		$("a:contains('상품검색')").bind("click", function(){
			self.location.href="${param.uri}product/listProduct?menu=search";
		});
	
		$("a:contains('구매이력조회')").bind("click", function(){
			self.location.href="${param.uri}purchase/listPurchase?searchKeyword=purchaseList&searchCondition=${user.userId}";
		});
		
		$("button:contains('Log in')").bind("click",function(){
			loginCheck();
		});
		
		$(".navbar-form button:contains('Sign in')").bind("click",function(){
			self.location.href="${param.uri}user/addUser";
		});
		
		$("a:contains('로그아웃')").bind("click",function(){
			self.location.href="${param.uri}user/logout";
		});
	
	});

</script>

