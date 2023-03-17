<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    <link rel="canonical" href="https://getbootstrap.com/docs/3.4/examples/carousel/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="./css/carousel.css" rel="stylesheet">

	<title>Model2 MVC Shop</title>

    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script type="text/javascript">
    
    //공백제거
		String.prototype.trim = function() {
		    return this.replace(/(^\s*)|(\s*$)/gi, "");
		}
	
		//무한스크롤
		var loading = false;
		var scrollPage = 1;
		var num = 1;
		var menu =  "${param.menu}";
		
		$(window).scroll(function() {
		   if ($(window).scrollTop() +5 >= $(document).height() - $(window).height() ) {
		   		if(!loading){
		   			scrollPage++;
		   			infinity();
		   		}
		   }
		});
		
		function infinity() {
			loading = true;
				$.ajax({
		            type     : 'POST',
		            url      : '/product/json/listProduct',
		            data     : JSON.stringify({
		            	page : scrollPage
		            }), // 다음 페이지 번호를 가지고 갑니다. 
		            dataType : 'json',
		            contentType: "application/json",
		            success : function(data) {
		            	var displayValue = "";
		            	data.forEach(function (el , index) {
		            				            		
		            		var code = "";
		            		if(el.tranCode != null){
		            			code = el.tranCode.trim();
		            		} 
		            		
		            		var id = "${sessionScope.user.userId}";
		            		var text = "";
		            		var button = "";
		            				            		
		            		if( id == 'admin') {
		            			if( code == '' ){
			             			text = "판매중";
			             			button = "<p><a class='btn btn-info' href='/product/getProduct?prodNo="+ el.prodNo + "' role='button'>상품확인 &raquo;</a></p>";
		            			} else if (  code ==  '1' && menu == 'manage' )  {
		            				text = "구매완료" + "<a href='/purchase/updateTranCodeByProd?prodNo=" + el.prodNo + "&tranCode=2'>" + "배송하기" + "</a>";
		            				button = "<p><a class='btn btn-danger' role='button'>품   절 &raquo;</a></p>";
		            			} else if ( code == '1' && menu != 'manage' ) {
		            				text = "구매완료";
		            				button = "<p><a class='btn btn-danger' role='button'>품   절 &raquo;</a></p>";
		            			} else if ( code == '2' ) {
		            				text = "배송중";
		            				button = "<p><a class='btn btn-danger' role='button'>품   절 &raquo;</a></p>";
		            			} else {
		            				text = "배송완료";
		            				button = "<p><a class='btn btn-danger' role='button'>품   절 &raquo;</a></p>";
		            			}
		            		}
		            			
		            		if( id != 'admin') {
		            			if( code == '' ){
		            				text = "판매중"
		            				button = "<p><a class='btn btn-info' href='/product/getProduct?prodNo="+ el.prodNo + "' role='button'>상품확인 &raquo;</a></p>";
		            			} else {
		            				text = "재고없음"
		            				button = "<p><a class='btn btn-danger' role='button'>품   절 &raquo;</a></p>";
		            			}
		            		} 
		            			        			
		        			var jbSplit = el.fileName.split('/');
		            		
		            		 displayValue += "<div class='col-lg-4'><br/><br/>"
			            		 + "<img class='img-circle' src='/images/uploadFiles/" + jbSplit[0] + "' alt='Generic placeholder image' width='130' height='130'>"
			            		 + "<h2>" + el.prodName + "</h2>"
			            		 + "<p>" + el.price + "원</p>"
			            		 + "<p>" + el.manuDate + "</p>"
			            		 + "<h6>" + text + "</h6>"
			            		 + button
			            		 + "</div>";
			            		 			            	
		            	})		
	            	
		            	$( "#addlist" ).append(displayValue);      	    	
		            	
		            	loading = false;
			   			
		            }
					
		        });
		}
	
 </script>
  </head>
<!-- NAVBAR
================================================== -->
  <body>
  
  	<jsp:include page="/layout/toolbar.jsp" /> 

    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img class="first-slide" src="/images/bitcamp.jpg" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
              <!-- <h1>BIT CAMP</h1> -->
              <br/><br/><br/><br/><br/>
              <p><a class="btn btn-lg btn-primary" href="https://www.bitcamp.co.kr/" role="button">이동하기</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="second-slide" src="/images/navercloud.jpg" alt="Second slide">
          <div class="container">
            <div class="carousel-caption">
              <!-- <h1>NAVER CLOUD PLATFORM</h1> -->
              <br/><br/><br/><br/><br/>
              <p><a class="btn btn-lg btn-primary" href="https://www.naver.com/" role="button">이동하기</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="third-slide" src="/images/web.jpg" alt="Third slide">
          <div class="container">
            <div class="carousel-caption">
              <!-- <h1>MAGIC ECOLE</h1> -->
              <br/><br/><br/><br/><br/>
              <!-- <p><a class="btn btn-lg btn-primary" href="#" role="button">이동하기</a></p> -->
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div><!-- /.carousel -->

	
	
    <div class="container marketing" id="addlist" >

      <!-- Three columns of text below the carousel -->
      <div class="row">
		<c:forEach var= "i" items="${list}">
		<c:set var="num" value="${ num+1 }" />
		
        <div class="col-lg-4">
        <br/><br/>
          <img class="img-circle" src="/images/uploadFiles/${i.fileName}" alt="Generic placeholder image" width="130" height="130">
          <h2>${i.prodName}</h2>
          <p>${i.price}원</p>
          <p>${i.regDate}</p>
          <h6>
          		<c:if test = "${ sessionScope.user.userId eq 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								판매중
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu == 'manage')}" >
								구매완료 <a href="/purchase/updateTranCodeByProd?prodNo=${i.prodNo}&tranCode=2">배송하기</a>
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu != 'manage')}" >
								구매완료
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '2' }" >
								배송중
							</c:when>
							<c:otherwise>
							 	배송완료
							 </c:otherwise>
						</c:choose>
					</c:if>
					

					<c:if test = "${sessionScope.user.userId ne 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								판매중
							</c:when>
							<c:otherwise>
							 	재고없음
							 </c:otherwise>
						</c:choose>
					</c:if>
          </h6>
          <c:choose>
	          <c:when test = "${ fn:trim(i.tranCode) eq '' }" >
	          	<p><a class="btn btn-info" href="/product/getProduct?prodNo=${i.prodNo}" role="button">상품확인 &raquo;</a></p>
	          </c:when>
         	 <c:otherwise>
				<p><a class="btn btn-danger btn" href="#" role="button">품&nbsp;절</a></p>
			</c:otherwise>
			</c:choose>
        </div><!-- /.col-lg-4 -->

        </c:forEach> 
      </div><!-- /.row -->
      

      <!-- START THE FEATURETTES -->

      <!-- <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It'll blow your mind.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7 col-md-push-5">
          <h2 class="featurette-heading">Oh yeah, it's that good. <span class="text-muted">See for yourself.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5 col-md-pull-7">
          <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">And lastly, this one. <span class="text-muted">Checkmate.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
        </div>
      </div> -->

      <!-- <hr class="featurette-divider">

      <footer>
        <p class="pull-right"><a href="#">맨 위로</a></p>
        <p>&copy; 2022 12 ~ 2023 06. &middot; <a href="#">So</a> &middot; <a href="#">Jaeyeon</a></p>
      </footer>  -->

    </div>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    <script src="../../assets/js/vendor/holder.min.js"></script>
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  	<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
  </body>
</html>
