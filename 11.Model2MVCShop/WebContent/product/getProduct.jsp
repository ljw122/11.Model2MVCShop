<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% int index = (int)(java.lang.Math.random()*3.0); %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
		function fncAddComment(cmtForm){
			cmtForm.attr('method','post').attr('action','addProductComment').submit();
		}
		
		$( function() {
			$( "#tabs" ).tabs();
			
			$('.cmt > .form-group > div > button').bind('click',function(){
				fncAddComment($(this).parent().parent().parent());
			});
			
			$('input:text[name="cmt"]').bind('keydown',function(event){
				if(event.keyCode == '13'){
					event.preventDefault();
					fncAddComment($(this).parent().parent().parent());
				}
			});
			
			$('a.btn-default:contains("목록으로")').bind('click',function(){
				self.location.href = 'listProduct?menu=${param.menu}';
			});

			$('a.btn-success:contains("구매하러가기")').bind('click',function(){
				self.location.href = '../purchase/addPurchase?prodNo='+$('input:hidden[name="prodNo"]').val();
			});

		} );
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/menubar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	
	<div class="container">
		<div class="col-md-9" role="main">
			<div id="tabs">
				<ul>
					<li>
						<a href="#tabs-1">
							<c:if test="${param.menu=='search'}">
								상품상세정보
							</c:if>
							<c:if test="${param.menu=='manage'}">
								수정된 정보
							</c:if>
						</a>
					</li>
					<c:if test="${param.menu=='search'}"><li><a href="#tabs-2">상품평</a></li></c:if>
				</ul>
				
				<!-- tabs-1 -->
				<div class="row" id="tabs-1">
					<div class="col-xs-5">
						<c:if test="${!empty product.fileName}">
							<img src="../images/uploadFiles/${product.fileName}" class="img-responsive"/>
						</c:if>
						<c:if test="${empty product.fileName}">
							<img src="../images/uploadFiles/empty<%=index%>.GIF" class="img-responsive"/>
						</c:if>
					</div>
					<div class="col-xs-7">
						<dl class="dl-horizontal">
							<dt>상품명</dt>
							<dd>${product.prodName}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>남은수량</dt>
							<dd>${product.stock} 개</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>제조일자</dt>
							<dd>${product.manuDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>가격</dt>
							<dd>${product.price} 원</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>상세정보</dt>
							<dd>${product.prodDetail}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>등록일자</dt>
							<dd>${product.regDate}</dd>
						</dl>
						<div class="btn-group" role="group">
							<c:if test="${param.menu=='search' && !empty user}">
								<a href="#" class="btn btn-success" role="button">구매하러가기</a>
							</c:if>
							<a href="#" class="btn btn-default" role="button">목록으로</a>
						</div>
					</div>
				</div>
				
				<!-- tabs-2 -->
				<c:if test="${param.menu=='search'}">
					<div class="row" id="tabs-2">
						<form class="form-horizontal cmt">
							<input type="hidden" name="prodNo" value="${product.prodNo}">
							<input type="hidden" name="userId" value="${user.userId}">
							<div class="form-group">
								<label for="innerCmt${i}" class="col-xs-2 control-label">${user.userId}</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="cmt${i}" name="cmt" ${user==null ? 'placeholder="로그인 후 이용 가능합니다.." disabled':''}>
								</div>
								<div class="col-xs-2">
									<button type="button" class="btn btn-default" ${user==null ? 'disabled':''}>상품평달기</button>
								</div>
							</div>
						</form>
						<c:if test="${replyList.size()==0}">
							아직 등록된 상품평이 없습니다.
						</c:if>
						<c:if test="${replyList.size()>0}">
							<c:set var="i" value="0"/>
							<c:forEach var="reply" items="${replyList}">
								<c:set var="i" value="${i+1}"/>
								<ul class="list-group">
									<li class="list-group-item">
										<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
											<div class="panel panel-defalut">
												<div class="panel-heading" role="tab" id="heading${i}">
													<h4 class="panel-title">
														<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">
															${reply.userId}&nbsp;&nbsp;&nbsp;${reply.cmt}&nbsp;<span class="badge">${reply.innerReply.size()}</span>
														</a>
													</h4>
												</div>
												<div id="collapse${i}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${i}">
													<c:if test="${reply.innerReply.size()>0}">
															<c:forEach var="innerReply" items="${reply.innerReply}">
																<dl class="dl-horizontal">
																	<dt class="text-left">└ ${innerReply.userId}</dt>
																	<dd>${innerReply.cmt}</dd>
																</dl>
															</c:forEach>
													</c:if>
													<br/>
													<form class="form-horizontal cmt inner-cmt">
														<input type="hidden" name="prodNo" value="${product.prodNo}">
														<input type="hidden" name="userId" value="${user.userId}">
														<input type="hidden" name="replyNo" value="${reply.replyNo}">
														<div class="form-group">
															<label for="innerCmt${i}" class="col-xs-2">${user.userId}</label>
															<div class="col-xs-8">
																<input type="text" class="form-control" id="innerCmt${i}" name="cmt" ${user==null ? 'placeholder="로그인 후 이용 가능합니다.." disabled':''}>
															</div>
															<div class="col-xs-2">
																<button type="button" class="btn btn-default" ${user==null ? 'disabled':''}>답글달기</button>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</c:forEach>
						</c:if>
					</div>
				</c:if>
				<!-- tabs end -->
			</div>
		</div>
		<jsp:include page="../history.jsp">
			<jsp:param name="uri" value="../"/>
		</jsp:include>
	</div>
	
</body>
</html>