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
	title = "��ǰ �����ȸ";
	type = "search";
	window = "/getProduct.do";
	System.out.println("��ǰ ��� ��ȸ �켱 �̻���� ����Ǿ����ϴ�.");
		} else {
	title = "��ǰ ����";
	type = "manage";
	window = "/updateProductView.do";
	System.out.println("������Ʈ �������� �켱 �̻���� ����Ǿ����ϴ�.");
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
<title>��ǰ �����ȸ</title>

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
				source : function(request, response) { //source: �Է½� ���� ���
					
					var con = $("#searchCondition").val();
				     $.ajax({
				           url : "/product/json/autocomplete"   
				         , type : "POST"
				         , dataType: "JSON"
				         , data : {value: request.term, con}	// �˻� Ű����
				         , success : function(data){ 	// ����
				             response(
				                 $.map(data.autoList, function(item) {
				                	 if(con == 0){
					                	 return {
					                    	     label : item.PROD_NO  	// ��Ͽ� ǥ�õǴ� ��
					                           , value : item.PROD_NO   		// ���� �� inputâ�� ǥ�õǴ� ��
					                     };
				                     } else if (con == 1){
					                    	 return {
					                    	     label : item.PROD_NAME  	// ��Ͽ� ǥ�õǴ� ��
					                           , value : item.PROD_NAME   		// ���� �� inputâ�� ǥ�õǴ� ��
					                     }; 
				                     } else if (con == 2){
				                    	 return {
				                    	     label : item.PRICE  	// ��Ͽ� ǥ�õǴ� ��
				                           , value : item.PRICE   		// ���� �� inputâ�� ǥ�õǴ� ��
				                    	 };
				                     }
				                 })
				             );    //response
				         }
				         ,error : function(){ //����
				             alert("������ �߻��߽��ϴ�.");
				         }
				     });
				}
				,focus : function(event, ui) { // ����Ű�� �ڵ��ϼ��ܾ� ���� �����ϰ� �������	
						return false;
				}
				,minLength: 1// �ּ� ���ڼ�
				,autoFocus : true // true == ù ��° �׸� �ڵ����� ������ ������
				,delay: 100	//autocomplete ������ �ð�(ms)
				,select : function(evt, ui) { 
			      	// ������ ���ý� ���� ui.item �� ���õ� �׸��� ��Ÿ���� ��ü, lavel/value/idx�� ����
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
	       <h3>��ǰ ���</h3>
	    </div>
	    
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü ��ǰ ${resultPage.totalCount } ��
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" id="searchCondition">
						<option value="0" ${param.searchCondition == '0' ? "selected" : ""} >��ǰ��ȣ</option>
						<option value="1" ${param.searchCondition == '1' ? "selected" : ""} >��ǰ��</option>
						<option value="2" ${param.searchCondition == '2' ? "selected" : ""} >��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻�</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword}" placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default" id="btn_search">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="page" name="page" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped">
      
        <thead>
          <tr>
            <th style="text-align: center; vertical-align: middle;">��ǰ�̹���</th>
            <th style="text-align: center; vertical-align: middle;">��ǰ��</th>
            <th style="text-align: center; vertical-align: middle;">�� ��</th>
            <th style="text-align: center; vertical-align: middle;">�����</th>
            <th style="text-align: center; vertical-align: middle;">�������</th>
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
				 	  <td style="text-align: center; vertical-align: middle;" >${i.prodName} (ǰ��) </td>
				 </c:otherwise>
			 </c:choose>
			  <td style="text-align: center; vertical-align: middle;">${i.price}</td>
			  <td style="text-align: center; vertical-align: middle;">${i.regDate}</td>
			  <td style="text-align: center; vertical-align: middle;">		

					
					<c:if test = "${ sessionScope.user.userId eq 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								�Ǹ���
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu == 'manage')}" >
								���ſϷ� <a href="/purchase/updateTranCodeByProd?prodNo=${i.prodNo}&tranCode=2">����ϱ�</a>
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu != 'manage')}" >
								���ſϷ�
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '2' }" >
								�����
							</c:when>
							<c:otherwise>
							 	��ۿϷ�
							 </c:otherwise>
						</c:choose>
					</c:if>
					

					<c:if test = "${sessionScope.user.userId ne 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								�Ǹ���
							</c:when>
							<c:otherwise>
							 	������
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
					
						${ param.menu == 'manage' ? "��ǰ ����" : "��ǰ �����ȸ" }
		
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

				<option value="0" ${param.searchCondition == '0' ? "selected" : ""} >��ǰ��ȣ</option>
				<option value="1" ${param.searchCondition == '1' ? "selected" : ""} >��ǰ��</option>
				<option value="2" ${param.searchCondition == '2' ? "selected" : ""} >��ǰ����</option>

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
						<!--  <a href="javascript:fncGetProductList('${resultPage.page}','${param.menu}');">�˻�</a>-->
						�˻�
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
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.page} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>		
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
								�Ǹ���
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu == 'manage')}" >
								���ſϷ� <a href="/purchase/updateTranCodeByProd?prodNo=${i.prodNo}&tranCode=2">����ϱ�</a>
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu != 'manage')}" >
								���ſϷ�
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '2' }" >
								�����
							</c:when>
							<c:otherwise>
							 	��ۿϷ�
							 </c:otherwise>
						</c:choose>
					</c:if>
					

					<c:if test = "${sessionScope.user.userId ne 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								�Ǹ���
							</c:when>
							<c:otherwise>
							 	������
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
<!--  ������ Navigator �� -->


</form>

</div> --%>

<input type="hidden" id="page" name="page" value=""/>
<input type="hidden" id="type" name="type" value=""/>

<jsp:include page="../common/pageNavigator_new.jsp"/>

</body>
</html>