<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->

 <div class="navbar-wrapper ">
      <div class="container">

        <nav class="navbar navbar-inverse navbar-static-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li><a href="#">����������ȸ</a></li>
                <c:if test = "${user.userId eq 'admin'}" >
                	<li><a href="#">ȸ��������ȸ</a></li>
                </c:if>
                <li><a href="#">�α׾ƿ�</a></li>
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">��     ǰ<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                  <c:if test = "${user.userId eq 'admin'}" >
	                    <li><a href="#">�ǸŻ�ǰ���</a></li>
	                    <li><a href="#">�ǸŻ�ǰ����</a></li>
	              </c:if>
	              <c:if test = "${user.role eq 'user'}" >
						<li><a href="#">�����̷���ȸ</a></li>
				  </c:if>	
	                <li role="separator" class="divider"></li>
                    <li><a href="#">����Ȩ</a></li>
                    <li><a href="#">�ֱ� �� ��ǰ</a></li>
                  </ul>
                </li>    
           </div>
           
            
          </div>
        </nav>

      </div>
    </div>

   	
   	<script type="text/javascript">
		
	   	function history(){
			popWin = window.open("/history.jsp",
														"popWin",
														"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
   	
	 	$(function() {
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
		 });
		
		 $(function() {
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				self.location = "/user/listUser"
			}); 
		 });
		
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
	 	
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
	 		$(self.location).attr("href","/product/addProductView.jsp;");
		});
	 	
		$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct?menu=manage");
		});
		
		$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/listPurchase");
		});
		
		$( "a:contains('����Ȩ')" ).on("click" , function() {
			$(self.location).attr("href","/index.jsp");
		});
		
		$( "a:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
			history();
		});
		
	</script>  