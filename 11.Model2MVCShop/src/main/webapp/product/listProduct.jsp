<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%--
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.*" %>


<%
	String title = null;
	String type = null;
	String window = null;

	if(request.getParameter("menu") != null){
		if(request.getParameter("menu").equals("search")){
	title = "상품 목록조회";
	type = "search";
	window = "/getProduct.do";
	System.out.println("상품 목록 조회 우선 이상없이 실행되었습니다.");
		} else {
	title = "상품 관리";
	type = "manage";
	window = "/updateProductView.do";
	System.out.println("업데이트 뷰쪽으로 우선 이상없이 실행되었습니다.");
		}
	}
	
	
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	Search searchVO = (Search)request.getAttribute("search");
	
	String searchCondition = CommonUtil.null2str(searchVO.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(searchVO.getSearchKeyword());
%>
--%>
<!DOCTYPE html>
<html>
<head>
<title>상품 목록조회</title>

<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
	<script type="text/javascript">

	
		//auto complete
		$(function(){
			$('#searchKeyword').autocomplete(
			{
				source : function(request, response) { //source: 입력시 보일 목록
					
					var con = $("#searchCondition").val();
				     $.ajax({
				           url : "/product/json/autocomplete"   
				         , type : "POST"
				         , dataType: "JSON"
				         , data : {value: request.term, con}	// 검색 키워드
				         , success : function(data){ 	// 성공
				             response(
				                 $.map(data.autoList, function(item) {
				                	 if(con == 0){
					                	 return {
					                    	     label : item.PROD_NO  	// 목록에 표시되는 값
					                           , value : item.PROD_NO   		// 선택 시 input창에 표시되는 값
					                     };
				                     } else if (con == 1){
					                    	 return {
					                    	     label : item.PROD_NAME  	// 목록에 표시되는 값
					                           , value : item.PROD_NAME   		// 선택 시 input창에 표시되는 값
					                     }; 
				                     } else if (con == 2){
				                    	 return {
				                    	     label : item.PRICE  	// 목록에 표시되는 값
				                           , value : item.PRICE   		// 선택 시 input창에 표시되는 값
				                    	 };
				                     }
				                 })
				             );    //response
				         }
				         ,error : function(){ //실패
				             alert("오류가 발생했습니다.");
				         }
				     });
				}
				,focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
						return false;
				}
				,minLength: 1// 최소 글자수
				,autoFocus : true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
				,delay: 100	//autocomplete 딜레이 시간(ms)
				,select : function(evt, ui) { 
			      	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
						//console.log(ui.item.label);
						//console.log(ui.item.idx);
				 }
			});
		})	
		

	function fncGetProductList(page, type){
		$("#page").val(page);
		$("#type").val(type);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}

	
	$(function() {
		
		$("#btn_search").on("click" , function() {
			 fncGetProductList('${resultPage.page}','${param.menu}');
		});
		
		 	 
		$( ".ct_list_pop td:nth-child(2)" ).on("click" , function() {
			if($(this).find("input").val() != null){
				self.location = "/product/updateProduct?prodNo=" + $(this).find("input").val();
			} else if ($(this).find("input").val() == null){
				
			}
		});
		
				
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "blue");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	});	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
  

 <div class="container">
	
		<div class="page-header text-info">
	       <h3>상품 목록</h3>
	    </div>
	    
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체 상품 ${resultPage.totalCount } 개
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" id="searchCondition">
						<option value="0" ${param.searchCondition == '0' ? "selected" : ""} >상품번호</option>
						<option value="1" ${param.searchCondition == '1' ? "selected" : ""} >상품명</option>
						<option value="2" ${param.searchCondition == '2' ? "selected" : ""} >상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default" id="btn_search">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="page" name="page" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped">
      
        <thead>
          <tr>
            <th style="text-align: center; vertical-align: middle;">상품이미지</th>
            <th style="text-align: center; vertical-align: middle;">상품명</th>
            <th style="text-align: center; vertical-align: middle;">가 격</th>
            <th style="text-align: center; vertical-align: middle;">등록일</th>
            <th style="text-align: center; vertical-align: middle;">현재상태</th>
          </tr>
        </thead>
        

		  <c:forEach var="i" items="${list}">
			<c:set var="num" value="${ num+1 }" />
									
			<tr class="ct_list_pop">
			  <td style="text-align: center; vertical-align: middle;" width="150" height="150"><img src="/images/uploadFiles/${fn:split(i.fileName, '/')[0]}" width="150" height="150"/></td>
			  <c:choose>
				  <c:when test = "${ fn:trim(i.tranCode) eq '' }">
				 	 <td style="text-align: center; vertical-align: middle;" >${i.prodName} <input type="hidden" value="${i.prodNo}" id="prodNo"  /></td>
				 </c:when>
			 	 <c:otherwise>
				 	  <td style="text-align: center; vertical-align: middle;" >${i.prodName} (품절) </td>
				 </c:otherwise>
			 </c:choose>
			  <td style="text-align: center; vertical-align: middle;">${i.price}</td>
			  <td style="text-align: center; vertical-align: middle;">${i.regDate}</td>
			  <td style="text-align: center; vertical-align: middle;">		

					
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
								  
			  </td>
			</tr>
          </c:forEach>
        
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div> 



 <%-- <div style="width:98%; margin-left:10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
						${ param.menu == 'manage' ? "상품 관리" : "상품 목록조회" }
		
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" id="searchCondition" class="ct_input_g" style="width:80px">

				<option value="0" ${param.searchCondition == '0' ? "selected" : ""} >상품번호</option>
				<option value="1" ${param.searchCondition == '1' ? "selected" : ""} >상품명</option>
				<option value="2" ${param.searchCondition == '2' ? "selected" : ""} >상품가격</option>

			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!--  <a href="javascript:fncGetProductList('${resultPage.page}','${param.menu}');">검색</a>-->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" id="addlist" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.page} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>		
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var= "i" items="${list}">
		<c:set var="num" value="${ num+1 }" />
		<tr class="ct_list_pop">
			<td align="center"><img src="/images/uploadFiles/${i.fileName}" width="150" height="150" /></td>
			<td></td>
			<td align="center">
			
			<c:choose>
			 <% if(productvo.getProTranCode() == null || productvo.getProTranCode().trim().equals("0")){
				<c:when test = "${ fn:trim(i.tranCode) eq '' }" >
					<!-- <a href="${param.menu == 'manage'?"/product/updateProduct?":"/product/getProduct?"}&prodNo=${i.prodNo}">${i.prodName}</a> -->
						${i.prodName}  <input type="hidden" value="${i.prodNo}" id="prodNo"  />
				</c:when>
				 <c:otherwise>
				 	${i.prodName} <input type="hidden" value="${i.prodNo}" id="prodNo"  />
				 </c:otherwise>
			</c:choose>
				
						
			</td>
			<td></td>
			<td align="center">${i.price}</td>
			<td></td>
			<td align="center">${i.regDate}
			</td>
			<td></td>
			<td align="left">
		

					
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
					
		
			</td>			
		</tr>
		
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
		<input type="hidden" id="page" name="page" value=""/>
		<input type="hidden" id="type" name="type" value=""/>
		<jsp:include page="../common/pageNavigator.jsp"/>	
		
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->


</form>

</div> --%>

<input type="hidden" id="page" name="page" value=""/>
<input type="hidden" id="type" name="type" value=""/>

<jsp:include page="../common/pageNavigator_new.jsp"/>

</body>
</html>