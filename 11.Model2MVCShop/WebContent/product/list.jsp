<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

	<script type="text/javascript">
		var currentPage = 0;
		
		function fncNextList(){
			currentPage++;
			$.ajax({
				url : 'json/listProduct/'+$('input:hidden[name="menu"]').val(),
				method : 'post',
				async : false,
				dataType : 'json',
				data : JSON.stringify({
						currentPage : currentPage,
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSON){
					var i = JSON.resultPage.totalCount - (JSON.resultPage.currentPage-1)*JSON.resultPage.pageSize + 1;
					var list = '';
					for( x in JSON.list){
						i--;
						var product = JSON.list[x];
						list += '<div class="col-sm-6 col-md-4"><div class="thumbnail">';
						list += '<img src="../images/uploadFiles/'+(product.fileName!=null ? product.fileName : 'empty'+Math.floor(3*Math.random())+'.GIF')+'" data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">';
						list += '<div class="caption">';
						list += '<input type="hidden" name="prodNo" value="'+product.prodNo+'">';
						list += '<h3>'+product.prodName+'</h3>';
						list += '<p>'+product.prodDetail+'</p>';
						list += '<p>';
						list += '<a href="#" class="btn btn-primary" role="button">상세보기</a>';
						list += '<a href="#" class="btn btn-default" role="button">구매</a>';
						list += '</p></div></div></div>';
					}
					$('.bs-docs-section .row').html($('.bs-docs-section .row').html() + list);
					
					init();
				}
			});
		}
		
		function init(){
			$('a.btn-primary:contains("상세보기")').bind('click',function(){
				self.location.href='getProduct?menu=${param.menu}&prodNo='+$(this).parent().parent().find('input:hidden').val();
			});
		}
		
		$( function() {
			while($(document).height() == $(window).height() && 
					(currentPage < $('input:hidden[name="maxPage"]').val() || $('input:hidden[name="maxPage"]').val()==0)){
				fncNextList();
			}
			
		} );
		
		$(window).scroll(function(){
			if(currentPage < $('input:hidden[name="maxPage"]').val()){
				if(pageYOffset == $(document).height()-$(window).height()){
					$(window).scrollTop(pageYOffset - 1);
					fncNextList();
				}
			}
		});
	</script>

	
	<input type="hidden" name="menu" value="${param.menu}"/>
	<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
	
	<div class="container bs-docs-container">
		<div class="row">
			<div class="col-md-9" role="main">
				<div class="bs-docs-section">
					<div class="row">
					
					</div>
				</div>
			</div>
			<jsp:include page="../history.jsp"/>
		</div>
	</div>
	