<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@ page import="com.model2.mvc.service.domain.*" --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<%--

	Purchase pur = (Purchase) request.getAttribute("pur");
	
--%>

<html>
<head>
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=0");
		
	});
	
</script>

</head>

<body>

<form name="updatePurchase">

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		
		<td>${pur.purchaseProd.prodNo}</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${pur.buyer.userId}</td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		
			${pur.paymentOption eq '1' ? "���ݱ���" : "�ſ뱸��" }
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${pur.receiverName}</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${pur.receiverPhone}</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${pur.divyAddr}</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${pur.divyRequest}</td>
		<td></td> 
	</tr>
	<tr>
		<td>����������</td>
		<td>${pur.divyDate}</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>