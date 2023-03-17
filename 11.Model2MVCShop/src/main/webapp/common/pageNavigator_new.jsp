<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">
		 
		 <nav>
		  <!-- ũ������ :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== ���� nav -->
		  	<c:if test="${ resultPage.page <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.page > resultPage.pageUnit }">
				<li>
			</c:if>
		      <a href="javascript:fncGetProductList('${ resultPage.page-1}')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  �߾�  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.page == i }">
					<!--  ���� page ����ų��� : active -->
				    <li class="active">
				    	<a href="javascript:fncGetProductList('${ i }', '${param.menu}');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.page != i}">	
					<li>
						<a href="javascript:fncGetProductList('${ i }', '${param.menu}');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  ���� nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		    	<a href="javascript:fncGetProductList('${ resultPage.page+1}')" aria-label="Previous">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div>
 