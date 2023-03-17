<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>ȸ����������</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../javascript/calendar.js"></script>
<script type="text/javascript" >

function fncAddProduct(){
	//Form ��ȿ�� ����
 	var name=$("input[name='prodName']").val();
	var detail=$("input[name='prodDetail']").val();
	var manuDate=$("input[name='manuDate']").val();
	var price=$("input[name='price']").val();
	
	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
		
	$("form").attr("method", "POST").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
}

$(function() {
	
	$("#date").on("click", function(){
		show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
	});
	 
	$("#update").on("click", function(){
		fncAddProduct();
	});

	
	$("#back").on("click", function(){
		history.go(-1)
	});
	
});	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div class="container">
	
		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
		<form name="detailForm">
		<!-- form Start /////////////////////////////////////-->
		<input type="hidden" name="prodNo" value="${pro.prodNo}">


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
						<input 	type="text" name="prodName" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" value="${pro.prodName}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<br/>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="prodDetail" value="${pro.prodDetail}" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10"	minLength="6">
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
		
	<tr>
		<td width="104" class="ct_write">
			�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" readonly="readonly" name="manuDate" value="${pro.manuDate}"	
						class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6">&nbsp;
						<img 	src="../images/ct_icon_date.gif" id="date" width="15" height="15"  />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="price" value="${pro.price}"
						class="ct_input_g" style="width: 100px; height: 19px" maxLength="50"/>&nbsp;��
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<input type="hidden" name="fileName" value="${pro.fileName}">
		<td class="ct_write01"  >${pro.fileName}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<input multiple="multiple" type="file" name="file" class="ct_input_g" 
						required="required" style="width: 200px; height: 19px" maxLength="13" value="${pro.fileName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<br/><br/>
		  
		  <div class="form-group">
			  <div class="col-sm-offset-4  col-sm-4 text-center">
			    <button type="button" class="btn btn-primary" id="update" >�� &nbsp;��</button>
				<a class="btn btn-danger btn" id="back" role="button">�� &nbsp;��</a>
			 </div>
		</div>
		
		</form>
 </div>   	

</body>
</html>