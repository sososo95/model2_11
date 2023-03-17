<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	
	//���ѽ�ũ��
	var loading = false;
	var scrollPage = 1;
	
	$(window).scroll(function() {
	   if ($(window).scrollTop() +5 >= $(document).height() - $(window).height()) {
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
                url      : '/user/json/listUser',
                data     : JSON.stringify({
                	page : scrollPage  
                }), // ���� ������ ��ȣ�� ������ ����� ������ ���ϴ�.
                dataType : 'json',
                contentType: "application/json",
                success : function(data) {
                	var displayValue = "";
                	data.forEach(function (el , index) {
                		displayValue += "<tr class='ct_list_pop'>"
                		+	"<td style='text-align: center; vertical-align: middle;' width='150' height='150'><img src='/images/pro.jpg' width='150' height='150'/></td>"
                		+  "<td style='text-align: center; vertical-align: middle;'  title='Click : ȸ������ Ȯ��'>" + el.userId + "</td>"
                		+  "<td style='text-align: center; vertical-align: middle;'>" + el.userName + "</td>"
                		+  "<td style='text-align: center; vertical-align: middle;'>" + el.email + "</td>"
                		+  "<td style='text-align: center; vertical-align: middle;'><i class='glyphicon glyphicon-ok' id='" + el.userId + "'></i><input type='hidden' value='" + el.userId + "'> " 
                		+  "</td></tr>";	
                	})	
                	
                	$( "#addlist" ).append(displayValue);

                	$(  "td:nth-child(5) > i" ).on("click" , function() {

    					var userId = $(this).next().val();
    				
    					$.ajax( 
    							{
    								url : "/user/json/getUser/"+userId ,
    								method : "GET" ,
    								dataType : "json" ,
    								headers : {
    									"Accept" : "application/json",
    									"Content-Type" : "application/json"
    								},
    								success : function(JSONData , status) {

    									var displayValue = "<h6>"
    																+"���̵� : "+JSONData.userId+"<br/>"
    																+"��  �� : "+JSONData.userName+"<br/>"
    																+"�̸��� : "+JSONData.email+"<br/>"
    																+"ROLE : "+JSONData.role+"<br/>"
    																+"����� : "+JSONData.regDateString+"<br/>"
    																+"</h6>";
    									$("h6").remove();
    									$( "#"+userId+"" ).html(displayValue);
    								}
    						});
    					
    			});
    			
                $( "td:nth-child(2)" ).on("click" , function() {
       				 self.location ="/user/getUser?userId="+$(this).text().trim();
       			});
       						
       			$( "td:nth-child(2)" ).css("color" , "red");
       			
       			
    			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
    			$("h7").css("color" , "red");
    			
    			$(".ct_list_pop:nth-child(4n+7)" ).css("background-color" , "whitesmoke");
                
      			loading = false;
                }
						
				
            });
	}
	

		function fncGetUserList(page) {
			$("#page").val(page)
			$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
		}
		
		//auto complete
		 $(function() {
			 $('#searchKeyword').autocomplete(
						{
							source : function(request, response) { //source: �Է½� ���� ���
								
								var con = $("#searchCondition").val();
							     $.ajax({
							           url : "/user/json/autocomplete"   
							         , type : "POST"
							         , dataType: "JSON"
							         , data : {value: request.term, con}	// �˻� Ű����
							         , success : function(data){ 	// ����
							             response(
							                 $.map(data.autoList, function(item) {
							                	 if(con == 0){
								                	 return {
								                    	     label : item.USER_ID  	// ��Ͽ� ǥ�õǴ� ��
								                           , value : item.USER_ID   		// ���� �� inputâ�� ǥ�õǴ� ��
								                     };
							                     } else if (con == 1){
								                    	 return {
								                    	     label : item.USER_NAME  	// ��Ͽ� ǥ�õǴ� ��
								                           , value : item.USER_NAME   		// ���� �� inputâ�� ǥ�õǴ� ��
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
						      
							 }
					});
		 })
		
		
		 $(function() {
		
			$( "td:nth-child(2)" ).on("click" , function() {
				 self.location ="/user/getUser?userId="+$(this).text().trim();
			});
						
			$( "td:nth-child(2)" ).css("color" , "red");
			
		});	
		
		
		 $(function() {
			 
			 $("#btn_search").on("click" , function() {
					fncGetUserList('${resultPage.page}');
				});
			 
			 
			$(  "td:nth-child(5) > i" ).on("click" , function() {

					var userId = $(this).next().val();
				
					$.ajax( 
							{
								url : "/user/json/getUser/"+userId ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									var displayValue = "<h6>"
																+"���̵� : "+JSONData.userId+"<br/>"
																+"��  �� : "+JSONData.userName+"<br/>"
																+"�̸��� : "+JSONData.email+"<br/>"
																+"ROLE : "+JSONData.role+"<br/>"
																+"����� : "+JSONData.regDateString+"<br/>"
																+"</h6>";
									$("h6").remove();
									$( "#"+userId+"" ).html(displayValue);
								}
						});
					
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});	
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>ȸ�������ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ȸ���� ${resultPage.totalCount }
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" id="searchCondition">
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ȸ��ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>ȸ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
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
            <th style="text-align: center; vertical-align: middle;">No</th>
            <th style="text-align: center; vertical-align: middle;">ȸ�� ID</th>
            <th style="text-align: center; vertical-align: middle;">ȸ����</th>
            <th style="text-align: center; vertical-align: middle;">�̸���</th>
            <th style="text-align: center; vertical-align: middle;">��������</th>
          </tr>
        </thead>
       
		<tbody id="addlist">
		
		  <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
			  <td style="text-align: center; vertical-align: middle;" width="150" height="150"><img src="/images/pro.jpg" width="150" height="150"/></td>
			  <td style="text-align: center; vertical-align: middle;"  title="Click : ȸ������ Ȯ��">${user.userId}</td>
			  <td style="text-align: center; vertical-align: middle;">${user.userName}</td>
			  <td style="text-align: center; vertical-align: middle;">${user.email}</td>
			  <td style="text-align: center; vertical-align: middle;">
			  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 		
 	
 	<!-- PageNavigation Start... -->
	<%-- <jsp:include page="../common/pageNavigator_new.jsp"/> --%>
	<!-- PageNavigation End... -->
	
</body>

</html>